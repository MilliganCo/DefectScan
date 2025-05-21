// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BarcodeProductImpl _$$BarcodeProductImplFromJson(Map<String, dynamic> json) =>
    _$BarcodeProductImpl(
      name: json['name'] as String,
      shortCode: json['shortCode'] as String,
      sizes: (json['sizes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$BarcodeProductImplToJson(
  _$BarcodeProductImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'shortCode': instance.shortCode,
  'sizes': instance.sizes,
};
