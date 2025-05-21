// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barcode_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BarcodeProduct _$BarcodeProductFromJson(Map<String, dynamic> json) {
  return _BarcodeProduct.fromJson(json);
}

/// @nodoc
mixin _$BarcodeProduct {
  String get name => throw _privateConstructorUsedError;
  String get shortCode => throw _privateConstructorUsedError;
  List<String> get sizes => throw _privateConstructorUsedError;

  /// Serializes this BarcodeProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BarcodeProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BarcodeProductCopyWith<BarcodeProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarcodeProductCopyWith<$Res> {
  factory $BarcodeProductCopyWith(
    BarcodeProduct value,
    $Res Function(BarcodeProduct) then,
  ) = _$BarcodeProductCopyWithImpl<$Res, BarcodeProduct>;
  @useResult
  $Res call({String name, String shortCode, List<String> sizes});
}

/// @nodoc
class _$BarcodeProductCopyWithImpl<$Res, $Val extends BarcodeProduct>
    implements $BarcodeProductCopyWith<$Res> {
  _$BarcodeProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BarcodeProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? shortCode = null,
    Object? sizes = null,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            shortCode:
                null == shortCode
                    ? _value.shortCode
                    : shortCode // ignore: cast_nullable_to_non_nullable
                        as String,
            sizes:
                null == sizes
                    ? _value.sizes
                    : sizes // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BarcodeProductImplCopyWith<$Res>
    implements $BarcodeProductCopyWith<$Res> {
  factory _$$BarcodeProductImplCopyWith(
    _$BarcodeProductImpl value,
    $Res Function(_$BarcodeProductImpl) then,
  ) = __$$BarcodeProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String shortCode, List<String> sizes});
}

/// @nodoc
class __$$BarcodeProductImplCopyWithImpl<$Res>
    extends _$BarcodeProductCopyWithImpl<$Res, _$BarcodeProductImpl>
    implements _$$BarcodeProductImplCopyWith<$Res> {
  __$$BarcodeProductImplCopyWithImpl(
    _$BarcodeProductImpl _value,
    $Res Function(_$BarcodeProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BarcodeProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? shortCode = null,
    Object? sizes = null,
  }) {
    return _then(
      _$BarcodeProductImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        shortCode:
            null == shortCode
                ? _value.shortCode
                : shortCode // ignore: cast_nullable_to_non_nullable
                    as String,
        sizes:
            null == sizes
                ? _value._sizes
                : sizes // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BarcodeProductImpl implements _BarcodeProduct {
  const _$BarcodeProductImpl({
    required this.name,
    required this.shortCode,
    required final List<String> sizes,
  }) : _sizes = sizes;

  factory _$BarcodeProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$BarcodeProductImplFromJson(json);

  @override
  final String name;
  @override
  final String shortCode;
  final List<String> _sizes;
  @override
  List<String> get sizes {
    if (_sizes is EqualUnmodifiableListView) return _sizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sizes);
  }

  @override
  String toString() {
    return 'BarcodeProduct(name: $name, shortCode: $shortCode, sizes: $sizes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarcodeProductImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shortCode, shortCode) ||
                other.shortCode == shortCode) &&
            const DeepCollectionEquality().equals(other._sizes, _sizes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    shortCode,
    const DeepCollectionEquality().hash(_sizes),
  );

  /// Create a copy of BarcodeProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BarcodeProductImplCopyWith<_$BarcodeProductImpl> get copyWith =>
      __$$BarcodeProductImplCopyWithImpl<_$BarcodeProductImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BarcodeProductImplToJson(this);
  }
}

abstract class _BarcodeProduct implements BarcodeProduct {
  const factory _BarcodeProduct({
    required final String name,
    required final String shortCode,
    required final List<String> sizes,
  }) = _$BarcodeProductImpl;

  factory _BarcodeProduct.fromJson(Map<String, dynamic> json) =
      _$BarcodeProductImpl.fromJson;

  @override
  String get name;
  @override
  String get shortCode;
  @override
  List<String> get sizes;

  /// Create a copy of BarcodeProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BarcodeProductImplCopyWith<_$BarcodeProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
