// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HistoryEntry _$HistoryEntryFromJson(Map<String, dynamic> json) {
  return _HistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$HistoryEntry {
  DateTime get date => throw _privateConstructorUsedError;
  int get factory => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  int get totalQty => throw _privateConstructorUsedError;
  HistoryStatus get status => throw _privateConstructorUsedError;
  String get fileUrl => throw _privateConstructorUsedError;
  List<BasketRow> get rows =>
      throw _privateConstructorUsedError; // ← обязательно!
  String? get productCode =>
      throw _privateConstructorUsedError; // ← опционально
  String? get id => throw _privateConstructorUsedError;

  /// Serializes this HistoryEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryEntryCopyWith<HistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryEntryCopyWith<$Res> {
  factory $HistoryEntryCopyWith(
    HistoryEntry value,
    $Res Function(HistoryEntry) then,
  ) = _$HistoryEntryCopyWithImpl<$Res, HistoryEntry>;
  @useResult
  $Res call({
    DateTime date,
    int factory,
    String productName,
    int totalQty,
    HistoryStatus status,
    String fileUrl,
    List<BasketRow> rows,
    String? productCode,
    String? id,
  });
}

/// @nodoc
class _$HistoryEntryCopyWithImpl<$Res, $Val extends HistoryEntry>
    implements $HistoryEntryCopyWith<$Res> {
  _$HistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? factory = null,
    Object? productName = null,
    Object? totalQty = null,
    Object? status = null,
    Object? fileUrl = null,
    Object? rows = null,
    Object? productCode = freezed,
    Object? id = freezed,
  }) {
    return _then(
      _value.copyWith(
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            factory:
                null == factory
                    ? _value.factory
                    : factory // ignore: cast_nullable_to_non_nullable
                        as int,
            productName:
                null == productName
                    ? _value.productName
                    : productName // ignore: cast_nullable_to_non_nullable
                        as String,
            totalQty:
                null == totalQty
                    ? _value.totalQty
                    : totalQty // ignore: cast_nullable_to_non_nullable
                        as int,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as HistoryStatus,
            fileUrl:
                null == fileUrl
                    ? _value.fileUrl
                    : fileUrl // ignore: cast_nullable_to_non_nullable
                        as String,
            rows:
                null == rows
                    ? _value.rows
                    : rows // ignore: cast_nullable_to_non_nullable
                        as List<BasketRow>,
            productCode:
                freezed == productCode
                    ? _value.productCode
                    : productCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HistoryEntryImplCopyWith<$Res>
    implements $HistoryEntryCopyWith<$Res> {
  factory _$$HistoryEntryImplCopyWith(
    _$HistoryEntryImpl value,
    $Res Function(_$HistoryEntryImpl) then,
  ) = __$$HistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime date,
    int factory,
    String productName,
    int totalQty,
    HistoryStatus status,
    String fileUrl,
    List<BasketRow> rows,
    String? productCode,
    String? id,
  });
}

/// @nodoc
class __$$HistoryEntryImplCopyWithImpl<$Res>
    extends _$HistoryEntryCopyWithImpl<$Res, _$HistoryEntryImpl>
    implements _$$HistoryEntryImplCopyWith<$Res> {
  __$$HistoryEntryImplCopyWithImpl(
    _$HistoryEntryImpl _value,
    $Res Function(_$HistoryEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? factory = null,
    Object? productName = null,
    Object? totalQty = null,
    Object? status = null,
    Object? fileUrl = null,
    Object? rows = null,
    Object? productCode = freezed,
    Object? id = freezed,
  }) {
    return _then(
      _$HistoryEntryImpl(
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        factory:
            null == factory
                ? _value.factory
                : factory // ignore: cast_nullable_to_non_nullable
                    as int,
        productName:
            null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                    as String,
        totalQty:
            null == totalQty
                ? _value.totalQty
                : totalQty // ignore: cast_nullable_to_non_nullable
                    as int,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as HistoryStatus,
        fileUrl:
            null == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        rows:
            null == rows
                ? _value._rows
                : rows // ignore: cast_nullable_to_non_nullable
                    as List<BasketRow>,
        productCode:
            freezed == productCode
                ? _value.productCode
                : productCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryEntryImpl implements _HistoryEntry {
  const _$HistoryEntryImpl({
    required this.date,
    required this.factory,
    required this.productName,
    required this.totalQty,
    required this.status,
    required this.fileUrl,
    required final List<BasketRow> rows,
    this.productCode,
    this.id,
  }) : _rows = rows;

  factory _$HistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryEntryImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int factory;
  @override
  final String productName;
  @override
  final int totalQty;
  @override
  final HistoryStatus status;
  @override
  final String fileUrl;
  final List<BasketRow> _rows;
  @override
  List<BasketRow> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  // ← обязательно!
  @override
  final String? productCode;
  // ← опционально
  @override
  final String? id;

  @override
  String toString() {
    return 'HistoryEntry(date: $date, factory: $factory, productName: $productName, totalQty: $totalQty, status: $status, fileUrl: $fileUrl, rows: $rows, productCode: $productCode, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryEntryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.factory, factory) || other.factory == factory) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.totalQty, totalQty) ||
                other.totalQty == totalQty) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            (identical(other.productCode, productCode) ||
                other.productCode == productCode) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    factory,
    productName,
    totalQty,
    status,
    fileUrl,
    const DeepCollectionEquality().hash(_rows),
    productCode,
    id,
  );

  /// Create a copy of HistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryEntryImplCopyWith<_$HistoryEntryImpl> get copyWith =>
      __$$HistoryEntryImplCopyWithImpl<_$HistoryEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryEntryImplToJson(this);
  }
}

abstract class _HistoryEntry implements HistoryEntry {
  const factory _HistoryEntry({
    required final DateTime date,
    required final int factory,
    required final String productName,
    required final int totalQty,
    required final HistoryStatus status,
    required final String fileUrl,
    required final List<BasketRow> rows,
    final String? productCode,
    final String? id,
  }) = _$HistoryEntryImpl;

  factory _HistoryEntry.fromJson(Map<String, dynamic> json) =
      _$HistoryEntryImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get factory;
  @override
  String get productName;
  @override
  int get totalQty;
  @override
  HistoryStatus get status;
  @override
  String get fileUrl;
  @override
  List<BasketRow> get rows; // ← обязательно!
  @override
  String? get productCode; // ← опционально
  @override
  String? get id;

  /// Create a copy of HistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryEntryImplCopyWith<_$HistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
