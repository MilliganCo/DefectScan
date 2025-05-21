// lib/features/basket/domain/usecases/basket_usecases.dart
import '../basket_entity.dart';
import '../basket_row.dart';
import '../basket_repository.dart';

class AddRow {
  AddRow(this._repo);
  final BasketRepository _repo;

  Future<BasketEntity> call(BasketEntity basket, BasketRow row) async {
    final updated = basket.copyWith(rows: [...basket.rows, row]);
    await _repo.saveDraft(updated);
    return updated;
  }
}

class RemoveRow {
  RemoveRow(this._repo);
  final BasketRepository _repo;

  Future<BasketEntity> call(BasketEntity basket, int index) async {
    final updated = basket.copyWith(
      rows: [...basket.rows]..removeAt(index),
    );
    await _repo.saveDraft(updated);
    return updated;
  }
}

class UpdateQty {
  UpdateQty(this._repo);
  final BasketRepository _repo;

  Future<BasketEntity> call(
      BasketEntity basket, int index, int newQty) async {
    final rows = [...basket.rows];
    rows[index] = rows[index].copyWith(qty: newQty);
    final updated = basket.copyWith(rows: rows);
    await _repo.saveDraft(updated);
    return updated;
  }
}

class SubmitBasket {
  SubmitBasket(this._repo);
  final BasketRepository _repo;

  Future<void> call(BasketEntity basket) => _repo.submitBasket(basket);
}
