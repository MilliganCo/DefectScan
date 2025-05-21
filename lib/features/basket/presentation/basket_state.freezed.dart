// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basket_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BasketState _$BasketStateFromJson(Map<String, dynamic> json) {
  return _BasketState.fromJson(json);
}

/// @nodoc
mixin _$BasketState {
  BasketEntity? get basket => throw _privateConstructorUsedError;
  bool get submitting => throw _privateConstructorUsedError;
  bool get readOnly => throw _privateConstructorUsedError;
  HistoryStatus? get status => throw _privateConstructorUsedError; // Новое поле
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this BasketState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BasketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BasketStateCopyWith<BasketState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasketStateCopyWith<$Res> {
  factory $BasketStateCopyWith(
    BasketState value,
    $Res Function(BasketState) then,
  ) = _$BasketStateCopyWithImpl<$Res, BasketState>;
  @useResult
  $Res call({
    BasketEntity? basket,
    bool submitting,
    bool readOnly,
    HistoryStatus? status,
    String? error,
  });
}

/// @nodoc
class _$BasketStateCopyWithImpl<$Res, $Val extends BasketState>
    implements $BasketStateCopyWith<$Res> {
  _$BasketStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BasketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basket = freezed,
    Object? submitting = null,
    Object? readOnly = null,
    Object? status = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            basket:
                freezed == basket
                    ? _value.basket
                    : basket // ignore: cast_nullable_to_non_nullable
                        as BasketEntity?,
            submitting:
                null == submitting
                    ? _value.submitting
                    : submitting // ignore: cast_nullable_to_non_nullable
                        as bool,
            readOnly:
                null == readOnly
                    ? _value.readOnly
                    : readOnly // ignore: cast_nullable_to_non_nullable
                        as bool,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as HistoryStatus?,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BasketStateImplCopyWith<$Res>
    implements $BasketStateCopyWith<$Res> {
  factory _$$BasketStateImplCopyWith(
    _$BasketStateImpl value,
    $Res Function(_$BasketStateImpl) then,
  ) = __$$BasketStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    BasketEntity? basket,
    bool submitting,
    bool readOnly,
    HistoryStatus? status,
    String? error,
  });
}

/// @nodoc
class __$$BasketStateImplCopyWithImpl<$Res>
    extends _$BasketStateCopyWithImpl<$Res, _$BasketStateImpl>
    implements _$$BasketStateImplCopyWith<$Res> {
  __$$BasketStateImplCopyWithImpl(
    _$BasketStateImpl _value,
    $Res Function(_$BasketStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BasketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basket = freezed,
    Object? submitting = null,
    Object? readOnly = null,
    Object? status = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$BasketStateImpl(
        basket:
            freezed == basket
                ? _value.basket
                : basket // ignore: cast_nullable_to_non_nullable
                    as BasketEntity?,
        submitting:
            null == submitting
                ? _value.submitting
                : submitting // ignore: cast_nullable_to_non_nullable
                    as bool,
        readOnly:
            null == readOnly
                ? _value.readOnly
                : readOnly // ignore: cast_nullable_to_non_nullable
                    as bool,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as HistoryStatus?,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BasketStateImpl extends _BasketState {
  const _$BasketStateImpl({
    this.basket,
    this.submitting = false,
    this.readOnly = false,
    this.status,
    this.error,
  }) : super._();

  factory _$BasketStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BasketStateImplFromJson(json);

  @override
  final BasketEntity? basket;
  @override
  @JsonKey()
  final bool submitting;
  @override
  @JsonKey()
  final bool readOnly;
  @override
  final HistoryStatus? status;
  // Новое поле
  @override
  final String? error;

  @override
  String toString() {
    return 'BasketState(basket: $basket, submitting: $submitting, readOnly: $readOnly, status: $status, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BasketStateImpl &&
            (identical(other.basket, basket) || other.basket == basket) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.readOnly, readOnly) ||
                other.readOnly == readOnly) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, basket, submitting, readOnly, status, error);

  /// Create a copy of BasketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BasketStateImplCopyWith<_$BasketStateImpl> get copyWith =>
      __$$BasketStateImplCopyWithImpl<_$BasketStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BasketStateImplToJson(this);
  }
}

abstract class _BasketState extends BasketState {
  const factory _BasketState({
    final BasketEntity? basket,
    final bool submitting,
    final bool readOnly,
    final HistoryStatus? status,
    final String? error,
  }) = _$BasketStateImpl;
  const _BasketState._() : super._();

  factory _BasketState.fromJson(Map<String, dynamic> json) =
      _$BasketStateImpl.fromJson;

  @override
  BasketEntity? get basket;
  @override
  bool get submitting;
  @override
  bool get readOnly;
  @override
  HistoryStatus? get status; // Новое поле
  @override
  String? get error;

  /// Create a copy of BasketState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BasketStateImplCopyWith<_$BasketStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
