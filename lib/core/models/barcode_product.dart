// lib/core/models/barcode_product.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'barcode_product.freezed.dart';
part 'barcode_product.g.dart';

@freezed
class BarcodeProduct with _$BarcodeProduct {
  const factory BarcodeProduct({
    required String name,
    required String shortCode,
    required List<String> sizes,
  }) = _BarcodeProduct;

  factory BarcodeProduct.fromJson(Map<String, dynamic> json) =>
      _$BarcodeProductFromJson(json);
}
