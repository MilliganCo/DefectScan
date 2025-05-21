// lib/features/basket/domain/basket_repository.dart
import 'basket_entity.dart';

abstract class BasketRepository {
  Future<void> saveDraft(BasketEntity? basket);
  Future<void> removeDraft(String productCode);
  Future<List<BasketEntity>> getDrafts();

  Future<void> submitBasket(BasketEntity basket);
  Future<BasketEntity?> getCurrentBasket();
}
