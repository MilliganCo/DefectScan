// lib/features/basket/data/basket_repository_impl.dart
import '../domain/basket_repository.dart';
import '../domain/basket_entity.dart';
import 'basket_local_ds.dart';
import 'basket_remote_ds.dart';

class BasketRepositoryImpl implements BasketRepository {
  BasketRepositoryImpl(
    this._local,
    this._remote,
  ) {
    // загружаем сохранённую корзину один раз
    _init = _local.load();
  }

  final BasketLocalDataSource _local;
  final BasketRemoteDataSource _remote;
  Future<BasketEntity?>? _init; // кеш будущего

  @override
  Future<List<BasketEntity>> getDrafts() => _local.getAll();

  @override
  Future<void> removeDraft(String productCode) => _local.delete(productCode);

  @override
  Future<void> saveDraft(BasketEntity? basket) {
    if (basket != null) {
      return _local.save(basket);
    }
    return Future.value();
  }

  Future<BasketEntity?> getCurrentBasket() async {
    return _init ??= _local.load();
  }

  @override
  Future<void> submitBasket(BasketEntity basket) async {
    await _remote.submit(basket);
    // await _local.clear(); // очищаем сохранённую корзину после отправки
    await _local.delete(basket.productCode);
  }
}
