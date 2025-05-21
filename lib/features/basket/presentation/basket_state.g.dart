// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BasketStateImpl _$$BasketStateImplFromJson(Map<String, dynamic> json) =>
    _$BasketStateImpl(
      basket:
          json['basket'] == null
              ? null
              : BasketEntity.fromJson(json['basket'] as Map<String, dynamic>),
      submitting: json['submitting'] as bool? ?? false,
      readOnly: json['readOnly'] as bool? ?? false,
      status: $enumDecodeNullable(_$HistoryStatusEnumMap, json['status']),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$BasketStateImplToJson(_$BasketStateImpl instance) =>
    <String, dynamic>{
      'basket': instance.basket,
      'submitting': instance.submitting,
      'readOnly': instance.readOnly,
      'status': _$HistoryStatusEnumMap[instance.status],
      'error': instance.error,
    };

const _$HistoryStatusEnumMap = {
  HistoryStatus.sent: 'sent',
  HistoryStatus.removed: 'removed',
};
