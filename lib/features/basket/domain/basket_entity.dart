// lib/features/basket/domain/basket_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'basket_row.dart';



class BasketEntity {
  const BasketEntity({
    required this.productCode,
    required this.productName,
    required this.factory,
    required this.date,
    required this.rows, // ← обязательно!
  });

  final String productCode;
  final String productName;
  final int factory;
  final DateTime date;
  final List<BasketRow> rows; // ← обязательно!

  BasketEntity copyWith({
    String? productCode,
    String? productName,
    int? factory,
    DateTime? date,
    List<BasketRow>? rows,
  }) {
    return BasketEntity(
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      factory: factory ?? this.factory,
      date: date ?? this.date,
      rows: rows ?? this.rows,
    );
  }

  factory BasketEntity.fromJson(Map<String, dynamic> j) => BasketEntity(
    productCode : j['productCode'],
    productName : j['productName'],
    factory     : j['factory'],
    date        : DateTime.parse(j['date']),
    rows        : (j['rows'] as List)
                    .map((e) => BasketRow.fromJson(Map<String, dynamic>.from(e)))
                    .toList(),
  );

  Map<String, dynamic> toJson() => {
    'productCode': productCode,
    'productName': productName,
    'factory': factory,
    'date': date.toIso8601String(),
    'rows': rows.map((e) => e.toJson()).toList(),
  };
}
