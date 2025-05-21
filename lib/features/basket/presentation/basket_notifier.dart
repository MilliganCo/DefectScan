import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/basket_repository.dart';
import '../domain/basket_entity.dart';
import '../domain/basket_row.dart';
import '../domain/usecases/basket_usecases.dart';
import 'basket_state.dart';

import '../../history/domain/history_repository.dart';
import '../../history/domain/history_entry.dart';
import '../../history/domain/history_status.dart';
import '../../basket/data/basket_session_ds.dart';

class BasketNotifier extends StateNotifier<BasketState> {
  BasketNotifier(
    this._repo,
    this._historyRepo,
    this._session,
  ) : super(const BasketState()) {
    _add    = AddRow(_repo);
    _remove = RemoveRow(_repo);
    _update = UpdateQty(_repo);
    _submit = SubmitBasket(_repo);

    // ← авто-restore
    _repo.getCurrentBasket().then((b) {
      if (b != null) state = state.copyWith(basket: b);
    });
  }

  // ───────── deps
  final BasketRepository  _repo;
  final HistoryRepository _historyRepo;
  final BasketSessionStorage _session;

  late final AddRow       _add;
  late final RemoveRow    _remove;
  late final UpdateQty    _update;
  late final SubmitBasket _submit;

  BasketEntity? _activeSnapshot; // рабочая корзина до просмотра истории

  // ───────── getters
  bool get hasBasket => state.basket != null;
  bool get isEmpty   => state.basket == null; // ← добавьте этот helper
  bool get readOnly  => state.readOnly;

  // выход из режима просмотра истории
  void setReadOnly(bool flag) =>
      state = state.copyWith(readOnly: flag);

  // Выход из режима «просмотр истории»
  void exitReadOnly() {
    if (!state.readOnly) return;
    state = state.copyWith(
      basket   : _activeSnapshot,
      readOnly : false,
      status   : null,
    );
    _activeSnapshot = null;
  }

  // ───────── init / update
  void initBasket(
    BasketEntity basket, {
    bool readOnly = false,
    HistoryStatus? status,     // Добавляем параметр status
  }) {
    if (readOnly && !state.readOnly) {
      _activeSnapshot = state.basket; // сохраняем рабочую корзину
    }
    if (!readOnly) _activeSnapshot = null; // возвращаемся к работе

    state = state.copyWith(
      basket  : basket,
      readOnly: readOnly,
      status  : status,
    );

    if (!readOnly) {
      _session.save(basket);
      _repo.saveDraft(basket);
    }
  }

  void updateBasket(BasketEntity basket) {
    state = state.copyWith(basket: basket);
    if (!readOnly) {
      _session.save(basket);
      _repo.saveDraft(basket);
    }
  }

  // ───────── clear
  Future<void> clearBasket() async {
    if (state.basket != null) {
      await _historyRepo.addEntry(
        _toHistory(state.basket!, HistoryStatus.removed),
      );
    }
    state = const BasketState();
    await _session.clear();
    await _repo.saveDraft(null);
  }

  // ───────── row-level
  Future<void> addRow(BasketRow row) async {
    if (readOnly || state.basket == null) return;
    final updated = await _add(state.basket!, row);
    state = state.copyWith(basket: updated);
    await _session.save(updated);
    await _repo.saveDraft(updated);
  }

  Future<void> removeRow(int idx) async {
    if (readOnly || state.basket == null) return;
    final updated = await _remove(state.basket!, idx);
    state = state.copyWith(basket: updated);
    _session.save(updated);
    await _repo.saveDraft(updated);
  }

  Future<void> updateQty(int idx, int qty) async {
    if (readOnly || state.basket == null) return;
    final updated = await _update(state.basket!, idx, qty);
    state = state.copyWith(basket: updated);
    _session.save(updated);
    await _repo.saveDraft(updated);
  }

  // ───────── submit
  Future<void> submit() async {
    if (readOnly || state.basket == null) return;
    state = state.copyWith(submitting: true, error: null);
    try {
      await _submit(state.basket!);
      await _historyRepo.addEntry(
        _toHistory(state.basket!, HistoryStatus.sent),
      );
      state = const BasketState();
      await _session.clear();
      await _repo.saveDraft(null);
    } catch (e) {
      state = state.copyWith(error: e.toString(), submitting: false);
    }
  }

  // ───────── helpers
  Future<void> _restoreSession() async {
    final saved = await _session.load();
    if (saved != null) {
      state = state.copyWith(basket: saved);
    }
  }

  HistoryEntry _toHistory(BasketEntity b, HistoryStatus st) => HistoryEntry(
        id          : DateTime.now().microsecondsSinceEpoch.toString(),
        date        : b.date,
        factory     : b.factory,
        productCode : b.productCode,
        productName : b.productName,
        totalQty    : b.rows.fold(0,(s,e)=>s+e.qty),
        status      : st,
        rows        : b.rows, // сохраняем строки
        fileUrl     : st==HistoryStatus.sent
                        ? 'https://example.com/tmp/${b.productCode}.xlsx'
                        : '',
      );
}
