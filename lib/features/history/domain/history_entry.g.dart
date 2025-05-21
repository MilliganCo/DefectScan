// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryEntryImpl _$$HistoryEntryImplFromJson(Map<String, dynamic> json) =>
    _$HistoryEntryImpl(
      date: DateTime.parse(json['date'] as String),
      factory: (json['factory'] as num).toInt(),
      productName: json['productName'] as String,
      totalQty: (json['totalQty'] as num).toInt(),
      status: $enumDecode(_$HistoryStatusEnumMap, json['status']),
      fileUrl: json['fileUrl'] as String,
      rows:
          (json['rows'] as List<dynamic>)
              .map((e) => BasketRow.fromJson(e as Map<String, dynamic>))
              .toList(),
      productCode: json['productCode'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$HistoryEntryImplToJson(_$HistoryEntryImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'factory': instance.factory,
      'productName': instance.productName,
      'totalQty': instance.totalQty,
      'status': _$HistoryStatusEnumMap[instance.status]!,
      'fileUrl': instance.fileUrl,
      'rows': instance.rows,
      'productCode': instance.productCode,
      'id': instance.id,
    };

const _$HistoryStatusEnumMap = {
  HistoryStatus.sent: 'sent',
  HistoryStatus.removed: 'removed',
};
