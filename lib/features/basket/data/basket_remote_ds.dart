// lib/features/basket/data/basket_remote_ds.dart
import '../../../core/network/api_client.dart';
import '../domain/basket_entity.dart';

class BasketRemoteDataSource {
  BasketRemoteDataSource(this._api);
  final ApiClient _api;

  Future<void> submit(BasketEntity basket) async {
    await _api.postJson('/upload', basket.rows.map((r) => r.toJson()).toList());
  }
}
