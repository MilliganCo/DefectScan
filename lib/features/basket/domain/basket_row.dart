// lib/features/basket/domain/basket_row.dart
import 'package:freezed_annotation/freezed_annotation.dart';


class BasketRow {
  const BasketRow({
    required this.productCode,
    required this.productName,
    required this.factory,
    required this.date,
    required this.defect,
    required this.size,
    required this.qty,
    required this.comment,
  });

  final String productCode;
  final String productName;
  final int factory;
  final DateTime date;
  final String defect;
  final String size;
  final int qty;
  final String comment;

  BasketRow copyWith({
    String? productCode,
    String? productName,
    int? factory,
    DateTime? date,
    String? defect,
    String? size,
    int? qty,
    String? comment,
  }) {
    return BasketRow(
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      factory: factory ?? this.factory,
      date: date ?? this.date,
      defect: defect ?? this.defect,
      size: size ?? this.size,
      qty: qty ?? this.qty,
      comment: comment ?? this.comment,
    );
  }

  factory BasketRow.fromJson(Map<String, dynamic> j) => BasketRow(
    productCode : j['productCode'],
    productName : j['productName'],
    factory     : j['factory'],
    date        : DateTime.parse(j['date']),
    defect      : j['defect'],
    size        : j['size'],
    qty         : j['qty'],
    comment     : j['comment'],
  );

  Map<String, dynamic> toJson() => {
    'productCode': productCode,
    'productName': productName,
    'factory': factory,
    'date': date.toIso8601String(),
    'defect': defect,
    'size': size,
    'qty': qty,
    'comment': comment,
  };
}
