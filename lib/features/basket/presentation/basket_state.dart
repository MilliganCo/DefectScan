// lib/features/basket/presentation/basket_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/basket_entity.dart';
import '../../history/domain/history_status.dart'; // Добавляем импорт HistoryStatus

part 'basket_state.freezed.dart';
part 'basket_state.g.dart';         // ← если используете json_serializable

@freezed
class BasketState with _$BasketState {
  // Конструктор для кастомных геттеров
  const BasketState._();

  const factory BasketState({
    BasketEntity? basket,
    @Default(false) bool submitting,
    @Default(false) bool readOnly,
    HistoryStatus? status,     // Новое поле
    String? error,
  }) = _BasketState;

  // Пустая когда *нет ни одной* строки-дефекта
  bool get isEmpty => basket?.rows.isEmpty ?? true;

  factory BasketState.fromJson(Map<String, dynamic> json) =>
      _$BasketStateFromJson(json);
}
