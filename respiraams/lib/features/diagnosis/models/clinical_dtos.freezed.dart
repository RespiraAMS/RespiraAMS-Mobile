// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinical_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RangeDto _$RangeDtoFromJson(Map<String, dynamic> json) {
  return _RangeDto.fromJson(json);
}

/// @nodoc
mixin _$RangeDto {
  num get min => throw _privateConstructorUsedError;
  bool get isMinExclusive => throw _privateConstructorUsedError;
  num get max => throw _privateConstructorUsedError;
  bool get isMaxExclusive => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;

  /// Serializes this RangeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RangeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RangeDtoCopyWith<RangeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RangeDtoCopyWith<$Res> {
  factory $RangeDtoCopyWith(RangeDto value, $Res Function(RangeDto) then) =
      _$RangeDtoCopyWithImpl<$Res, RangeDto>;
  @useResult
  $Res call({
    num min,
    bool isMinExclusive,
    num max,
    bool isMaxExclusive,
    String? unit,
  });
}

/// @nodoc
class _$RangeDtoCopyWithImpl<$Res, $Val extends RangeDto>
    implements $RangeDtoCopyWith<$Res> {
  _$RangeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RangeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? isMinExclusive = null,
    Object? max = null,
    Object? isMaxExclusive = null,
    Object? unit = freezed,
  }) {
    return _then(
      _value.copyWith(
            min: null == min
                ? _value.min
                : min // ignore: cast_nullable_to_non_nullable
                      as num,
            isMinExclusive: null == isMinExclusive
                ? _value.isMinExclusive
                : isMinExclusive // ignore: cast_nullable_to_non_nullable
                      as bool,
            max: null == max
                ? _value.max
                : max // ignore: cast_nullable_to_non_nullable
                      as num,
            isMaxExclusive: null == isMaxExclusive
                ? _value.isMaxExclusive
                : isMaxExclusive // ignore: cast_nullable_to_non_nullable
                      as bool,
            unit: freezed == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RangeDtoImplCopyWith<$Res>
    implements $RangeDtoCopyWith<$Res> {
  factory _$$RangeDtoImplCopyWith(
    _$RangeDtoImpl value,
    $Res Function(_$RangeDtoImpl) then,
  ) = __$$RangeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    num min,
    bool isMinExclusive,
    num max,
    bool isMaxExclusive,
    String? unit,
  });
}

/// @nodoc
class __$$RangeDtoImplCopyWithImpl<$Res>
    extends _$RangeDtoCopyWithImpl<$Res, _$RangeDtoImpl>
    implements _$$RangeDtoImplCopyWith<$Res> {
  __$$RangeDtoImplCopyWithImpl(
    _$RangeDtoImpl _value,
    $Res Function(_$RangeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RangeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? isMinExclusive = null,
    Object? max = null,
    Object? isMaxExclusive = null,
    Object? unit = freezed,
  }) {
    return _then(
      _$RangeDtoImpl(
        min: null == min
            ? _value.min
            : min // ignore: cast_nullable_to_non_nullable
                  as num,
        isMinExclusive: null == isMinExclusive
            ? _value.isMinExclusive
            : isMinExclusive // ignore: cast_nullable_to_non_nullable
                  as bool,
        max: null == max
            ? _value.max
            : max // ignore: cast_nullable_to_non_nullable
                  as num,
        isMaxExclusive: null == isMaxExclusive
            ? _value.isMaxExclusive
            : isMaxExclusive // ignore: cast_nullable_to_non_nullable
                  as bool,
        unit: freezed == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RangeDtoImpl implements _RangeDto {
  const _$RangeDtoImpl({
    required this.min,
    this.isMinExclusive = false,
    required this.max,
    this.isMaxExclusive = false,
    this.unit,
  });

  factory _$RangeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RangeDtoImplFromJson(json);

  @override
  final num min;
  @override
  @JsonKey()
  final bool isMinExclusive;
  @override
  final num max;
  @override
  @JsonKey()
  final bool isMaxExclusive;
  @override
  final String? unit;

  @override
  String toString() {
    return 'RangeDto(min: $min, isMinExclusive: $isMinExclusive, max: $max, isMaxExclusive: $isMaxExclusive, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RangeDtoImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.isMinExclusive, isMinExclusive) ||
                other.isMinExclusive == isMinExclusive) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.isMaxExclusive, isMaxExclusive) ||
                other.isMaxExclusive == isMaxExclusive) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, min, isMinExclusive, max, isMaxExclusive, unit);

  /// Create a copy of RangeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RangeDtoImplCopyWith<_$RangeDtoImpl> get copyWith =>
      __$$RangeDtoImplCopyWithImpl<_$RangeDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RangeDtoImplToJson(this);
  }
}

abstract class _RangeDto implements RangeDto {
  const factory _RangeDto({
    required final num min,
    final bool isMinExclusive,
    required final num max,
    final bool isMaxExclusive,
    final String? unit,
  }) = _$RangeDtoImpl;

  factory _RangeDto.fromJson(Map<String, dynamic> json) =
      _$RangeDtoImpl.fromJson;

  @override
  num get min;
  @override
  bool get isMinExclusive;
  @override
  num get max;
  @override
  bool get isMaxExclusive;
  @override
  String? get unit;

  /// Create a copy of RangeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RangeDtoImplCopyWith<_$RangeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClinicalVariableDto _$ClinicalVariableDtoFromJson(Map<String, dynamic> json) {
  return _ClinicalVariableDto.fromJson(json);
}

/// @nodoc
mixin _$ClinicalVariableDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get valueType => throw _privateConstructorUsedError;
  String? get canonicalUnit => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  List<String> get acceptedValues => throw _privateConstructorUsedError;
  RangeDto? get normalRange => throw _privateConstructorUsedError;
  RangeDto? get acceptedRange => throw _privateConstructorUsedError;

  /// Serializes this ClinicalVariableDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClinicalVariableDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicalVariableDtoCopyWith<ClinicalVariableDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicalVariableDtoCopyWith<$Res> {
  factory $ClinicalVariableDtoCopyWith(
    ClinicalVariableDto value,
    $Res Function(ClinicalVariableDto) then,
  ) = _$ClinicalVariableDtoCopyWithImpl<$Res, ClinicalVariableDto>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String code,
    String valueType,
    String? canonicalUnit,
    bool isRequired,
    String category,
    List<String> acceptedValues,
    RangeDto? normalRange,
    RangeDto? acceptedRange,
  });

  $RangeDtoCopyWith<$Res>? get normalRange;
  $RangeDtoCopyWith<$Res>? get acceptedRange;
}

/// @nodoc
class _$ClinicalVariableDtoCopyWithImpl<$Res, $Val extends ClinicalVariableDto>
    implements $ClinicalVariableDtoCopyWith<$Res> {
  _$ClinicalVariableDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicalVariableDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? code = null,
    Object? valueType = null,
    Object? canonicalUnit = freezed,
    Object? isRequired = null,
    Object? category = null,
    Object? acceptedValues = null,
    Object? normalRange = freezed,
    Object? acceptedRange = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            valueType: null == valueType
                ? _value.valueType
                : valueType // ignore: cast_nullable_to_non_nullable
                      as String,
            canonicalUnit: freezed == canonicalUnit
                ? _value.canonicalUnit
                : canonicalUnit // ignore: cast_nullable_to_non_nullable
                      as String?,
            isRequired: null == isRequired
                ? _value.isRequired
                : isRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            acceptedValues: null == acceptedValues
                ? _value.acceptedValues
                : acceptedValues // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            normalRange: freezed == normalRange
                ? _value.normalRange
                : normalRange // ignore: cast_nullable_to_non_nullable
                      as RangeDto?,
            acceptedRange: freezed == acceptedRange
                ? _value.acceptedRange
                : acceptedRange // ignore: cast_nullable_to_non_nullable
                      as RangeDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of ClinicalVariableDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RangeDtoCopyWith<$Res>? get normalRange {
    if (_value.normalRange == null) {
      return null;
    }

    return $RangeDtoCopyWith<$Res>(_value.normalRange!, (value) {
      return _then(_value.copyWith(normalRange: value) as $Val);
    });
  }

  /// Create a copy of ClinicalVariableDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RangeDtoCopyWith<$Res>? get acceptedRange {
    if (_value.acceptedRange == null) {
      return null;
    }

    return $RangeDtoCopyWith<$Res>(_value.acceptedRange!, (value) {
      return _then(_value.copyWith(acceptedRange: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClinicalVariableDtoImplCopyWith<$Res>
    implements $ClinicalVariableDtoCopyWith<$Res> {
  factory _$$ClinicalVariableDtoImplCopyWith(
    _$ClinicalVariableDtoImpl value,
    $Res Function(_$ClinicalVariableDtoImpl) then,
  ) = __$$ClinicalVariableDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String code,
    String valueType,
    String? canonicalUnit,
    bool isRequired,
    String category,
    List<String> acceptedValues,
    RangeDto? normalRange,
    RangeDto? acceptedRange,
  });

  @override
  $RangeDtoCopyWith<$Res>? get normalRange;
  @override
  $RangeDtoCopyWith<$Res>? get acceptedRange;
}

/// @nodoc
class __$$ClinicalVariableDtoImplCopyWithImpl<$Res>
    extends _$ClinicalVariableDtoCopyWithImpl<$Res, _$ClinicalVariableDtoImpl>
    implements _$$ClinicalVariableDtoImplCopyWith<$Res> {
  __$$ClinicalVariableDtoImplCopyWithImpl(
    _$ClinicalVariableDtoImpl _value,
    $Res Function(_$ClinicalVariableDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClinicalVariableDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? code = null,
    Object? valueType = null,
    Object? canonicalUnit = freezed,
    Object? isRequired = null,
    Object? category = null,
    Object? acceptedValues = null,
    Object? normalRange = freezed,
    Object? acceptedRange = freezed,
  }) {
    return _then(
      _$ClinicalVariableDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        valueType: null == valueType
            ? _value.valueType
            : valueType // ignore: cast_nullable_to_non_nullable
                  as String,
        canonicalUnit: freezed == canonicalUnit
            ? _value.canonicalUnit
            : canonicalUnit // ignore: cast_nullable_to_non_nullable
                  as String?,
        isRequired: null == isRequired
            ? _value.isRequired
            : isRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        acceptedValues: null == acceptedValues
            ? _value._acceptedValues
            : acceptedValues // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        normalRange: freezed == normalRange
            ? _value.normalRange
            : normalRange // ignore: cast_nullable_to_non_nullable
                  as RangeDto?,
        acceptedRange: freezed == acceptedRange
            ? _value.acceptedRange
            : acceptedRange // ignore: cast_nullable_to_non_nullable
                  as RangeDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClinicalVariableDtoImpl implements _ClinicalVariableDto {
  const _$ClinicalVariableDtoImpl({
    required this.id,
    required this.name,
    this.description = '',
    required this.code,
    required this.valueType,
    this.canonicalUnit,
    this.isRequired = false,
    required this.category,
    final List<String> acceptedValues = const [],
    this.normalRange,
    this.acceptedRange,
  }) : _acceptedValues = acceptedValues;

  factory _$ClinicalVariableDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClinicalVariableDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  final String code;
  @override
  final String valueType;
  @override
  final String? canonicalUnit;
  @override
  @JsonKey()
  final bool isRequired;
  @override
  final String category;
  final List<String> _acceptedValues;
  @override
  @JsonKey()
  List<String> get acceptedValues {
    if (_acceptedValues is EqualUnmodifiableListView) return _acceptedValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_acceptedValues);
  }

  @override
  final RangeDto? normalRange;
  @override
  final RangeDto? acceptedRange;

  @override
  String toString() {
    return 'ClinicalVariableDto(id: $id, name: $name, description: $description, code: $code, valueType: $valueType, canonicalUnit: $canonicalUnit, isRequired: $isRequired, category: $category, acceptedValues: $acceptedValues, normalRange: $normalRange, acceptedRange: $acceptedRange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicalVariableDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.valueType, valueType) ||
                other.valueType == valueType) &&
            (identical(other.canonicalUnit, canonicalUnit) ||
                other.canonicalUnit == canonicalUnit) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(
              other._acceptedValues,
              _acceptedValues,
            ) &&
            (identical(other.normalRange, normalRange) ||
                other.normalRange == normalRange) &&
            (identical(other.acceptedRange, acceptedRange) ||
                other.acceptedRange == acceptedRange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    code,
    valueType,
    canonicalUnit,
    isRequired,
    category,
    const DeepCollectionEquality().hash(_acceptedValues),
    normalRange,
    acceptedRange,
  );

  /// Create a copy of ClinicalVariableDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicalVariableDtoImplCopyWith<_$ClinicalVariableDtoImpl> get copyWith =>
      __$$ClinicalVariableDtoImplCopyWithImpl<_$ClinicalVariableDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClinicalVariableDtoImplToJson(this);
  }
}

abstract class _ClinicalVariableDto implements ClinicalVariableDto {
  const factory _ClinicalVariableDto({
    required final String id,
    required final String name,
    final String description,
    required final String code,
    required final String valueType,
    final String? canonicalUnit,
    final bool isRequired,
    required final String category,
    final List<String> acceptedValues,
    final RangeDto? normalRange,
    final RangeDto? acceptedRange,
  }) = _$ClinicalVariableDtoImpl;

  factory _ClinicalVariableDto.fromJson(Map<String, dynamic> json) =
      _$ClinicalVariableDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get code;
  @override
  String get valueType;
  @override
  String? get canonicalUnit;
  @override
  bool get isRequired;
  @override
  String get category;
  @override
  List<String> get acceptedValues;
  @override
  RangeDto? get normalRange;
  @override
  RangeDto? get acceptedRange;

  /// Create a copy of ClinicalVariableDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicalVariableDtoImplCopyWith<_$ClinicalVariableDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiagnosisFormDto _$DiagnosisFormDtoFromJson(Map<String, dynamic> json) {
  return _DiagnosisFormDto.fromJson(json);
}

/// @nodoc
mixin _$DiagnosisFormDto {
  List<ClinicalVariableDto> get variables => throw _privateConstructorUsedError;

  /// Serializes this DiagnosisFormDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiagnosisFormDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiagnosisFormDtoCopyWith<DiagnosisFormDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiagnosisFormDtoCopyWith<$Res> {
  factory $DiagnosisFormDtoCopyWith(
    DiagnosisFormDto value,
    $Res Function(DiagnosisFormDto) then,
  ) = _$DiagnosisFormDtoCopyWithImpl<$Res, DiagnosisFormDto>;
  @useResult
  $Res call({List<ClinicalVariableDto> variables});
}

/// @nodoc
class _$DiagnosisFormDtoCopyWithImpl<$Res, $Val extends DiagnosisFormDto>
    implements $DiagnosisFormDtoCopyWith<$Res> {
  _$DiagnosisFormDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiagnosisFormDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? variables = null}) {
    return _then(
      _value.copyWith(
            variables: null == variables
                ? _value.variables
                : variables // ignore: cast_nullable_to_non_nullable
                      as List<ClinicalVariableDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiagnosisFormDtoImplCopyWith<$Res>
    implements $DiagnosisFormDtoCopyWith<$Res> {
  factory _$$DiagnosisFormDtoImplCopyWith(
    _$DiagnosisFormDtoImpl value,
    $Res Function(_$DiagnosisFormDtoImpl) then,
  ) = __$$DiagnosisFormDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ClinicalVariableDto> variables});
}

/// @nodoc
class __$$DiagnosisFormDtoImplCopyWithImpl<$Res>
    extends _$DiagnosisFormDtoCopyWithImpl<$Res, _$DiagnosisFormDtoImpl>
    implements _$$DiagnosisFormDtoImplCopyWith<$Res> {
  __$$DiagnosisFormDtoImplCopyWithImpl(
    _$DiagnosisFormDtoImpl _value,
    $Res Function(_$DiagnosisFormDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiagnosisFormDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? variables = null}) {
    return _then(
      _$DiagnosisFormDtoImpl(
        variables: null == variables
            ? _value._variables
            : variables // ignore: cast_nullable_to_non_nullable
                  as List<ClinicalVariableDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiagnosisFormDtoImpl implements _DiagnosisFormDto {
  const _$DiagnosisFormDtoImpl({
    final List<ClinicalVariableDto> variables = const [],
  }) : _variables = variables;

  factory _$DiagnosisFormDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiagnosisFormDtoImplFromJson(json);

  final List<ClinicalVariableDto> _variables;
  @override
  @JsonKey()
  List<ClinicalVariableDto> get variables {
    if (_variables is EqualUnmodifiableListView) return _variables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variables);
  }

  @override
  String toString() {
    return 'DiagnosisFormDto(variables: $variables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagnosisFormDtoImpl &&
            const DeepCollectionEquality().equals(
              other._variables,
              _variables,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_variables));

  /// Create a copy of DiagnosisFormDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiagnosisFormDtoImplCopyWith<_$DiagnosisFormDtoImpl> get copyWith =>
      __$$DiagnosisFormDtoImplCopyWithImpl<_$DiagnosisFormDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiagnosisFormDtoImplToJson(this);
  }
}

abstract class _DiagnosisFormDto implements DiagnosisFormDto {
  const factory _DiagnosisFormDto({final List<ClinicalVariableDto> variables}) =
      _$DiagnosisFormDtoImpl;

  factory _DiagnosisFormDto.fromJson(Map<String, dynamic> json) =
      _$DiagnosisFormDtoImpl.fromJson;

  @override
  List<ClinicalVariableDto> get variables;

  /// Create a copy of DiagnosisFormDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiagnosisFormDtoImplCopyWith<_$DiagnosisFormDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NamedRefDto _$NamedRefDtoFromJson(Map<String, dynamic> json) {
  return _NamedRefDto.fromJson(json);
}

/// @nodoc
mixin _$NamedRefDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this NamedRefDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NamedRefDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NamedRefDtoCopyWith<NamedRefDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NamedRefDtoCopyWith<$Res> {
  factory $NamedRefDtoCopyWith(
    NamedRefDto value,
    $Res Function(NamedRefDto) then,
  ) = _$NamedRefDtoCopyWithImpl<$Res, NamedRefDto>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$NamedRefDtoCopyWithImpl<$Res, $Val extends NamedRefDto>
    implements $NamedRefDtoCopyWith<$Res> {
  _$NamedRefDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NamedRefDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NamedRefDtoImplCopyWith<$Res>
    implements $NamedRefDtoCopyWith<$Res> {
  factory _$$NamedRefDtoImplCopyWith(
    _$NamedRefDtoImpl value,
    $Res Function(_$NamedRefDtoImpl) then,
  ) = __$$NamedRefDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$NamedRefDtoImplCopyWithImpl<$Res>
    extends _$NamedRefDtoCopyWithImpl<$Res, _$NamedRefDtoImpl>
    implements _$$NamedRefDtoImplCopyWith<$Res> {
  __$$NamedRefDtoImplCopyWithImpl(
    _$NamedRefDtoImpl _value,
    $Res Function(_$NamedRefDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NamedRefDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$NamedRefDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NamedRefDtoImpl implements _NamedRefDto {
  const _$NamedRefDtoImpl({required this.id, required this.name});

  factory _$NamedRefDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NamedRefDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'NamedRefDto(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamedRefDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of NamedRefDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NamedRefDtoImplCopyWith<_$NamedRefDtoImpl> get copyWith =>
      __$$NamedRefDtoImplCopyWithImpl<_$NamedRefDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NamedRefDtoImplToJson(this);
  }
}

abstract class _NamedRefDto implements NamedRefDto {
  const factory _NamedRefDto({
    required final String id,
    required final String name,
  }) = _$NamedRefDtoImpl;

  factory _NamedRefDto.fromJson(Map<String, dynamic> json) =
      _$NamedRefDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of NamedRefDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NamedRefDtoImplCopyWith<_$NamedRefDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VariableRefDto _$VariableRefDtoFromJson(Map<String, dynamic> json) {
  return _VariableRefDto.fromJson(json);
}

/// @nodoc
mixin _$VariableRefDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  /// Serializes this VariableRefDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VariableRefDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VariableRefDtoCopyWith<VariableRefDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariableRefDtoCopyWith<$Res> {
  factory $VariableRefDtoCopyWith(
    VariableRefDto value,
    $Res Function(VariableRefDto) then,
  ) = _$VariableRefDtoCopyWithImpl<$Res, VariableRefDto>;
  @useResult
  $Res call({String id, String name, String code});
}

/// @nodoc
class _$VariableRefDtoCopyWithImpl<$Res, $Val extends VariableRefDto>
    implements $VariableRefDtoCopyWith<$Res> {
  _$VariableRefDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VariableRefDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? code = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VariableRefDtoImplCopyWith<$Res>
    implements $VariableRefDtoCopyWith<$Res> {
  factory _$$VariableRefDtoImplCopyWith(
    _$VariableRefDtoImpl value,
    $Res Function(_$VariableRefDtoImpl) then,
  ) = __$$VariableRefDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String code});
}

/// @nodoc
class __$$VariableRefDtoImplCopyWithImpl<$Res>
    extends _$VariableRefDtoCopyWithImpl<$Res, _$VariableRefDtoImpl>
    implements _$$VariableRefDtoImplCopyWith<$Res> {
  __$$VariableRefDtoImplCopyWithImpl(
    _$VariableRefDtoImpl _value,
    $Res Function(_$VariableRefDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VariableRefDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? code = null}) {
    return _then(
      _$VariableRefDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VariableRefDtoImpl implements _VariableRefDto {
  const _$VariableRefDtoImpl({
    required this.id,
    required this.name,
    this.code = '',
  });

  factory _$VariableRefDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariableRefDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String code;

  @override
  String toString() {
    return 'VariableRefDto(id: $id, name: $name, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariableRefDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, code);

  /// Create a copy of VariableRefDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VariableRefDtoImplCopyWith<_$VariableRefDtoImpl> get copyWith =>
      __$$VariableRefDtoImplCopyWithImpl<_$VariableRefDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VariableRefDtoImplToJson(this);
  }
}

abstract class _VariableRefDto implements VariableRefDto {
  const factory _VariableRefDto({
    required final String id,
    required final String name,
    final String code,
  }) = _$VariableRefDtoImpl;

  factory _VariableRefDto.fromJson(Map<String, dynamic> json) =
      _$VariableRefDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get code;

  /// Create a copy of VariableRefDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VariableRefDtoImplCopyWith<_$VariableRefDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EvidenceDto _$EvidenceDtoFromJson(Map<String, dynamic> json) {
  return _EvidenceDto.fromJson(json);
}

/// @nodoc
mixin _$EvidenceDto {
  String get source => throw _privateConstructorUsedError;
  String get formula => throw _privateConstructorUsedError;
  Object? get evaluatedValue => throw _privateConstructorUsedError;
  num? get score => throw _privateConstructorUsedError;
  bool? get isMajor => throw _privateConstructorUsedError;
  List<VariableRefDto> get missingVariables =>
      throw _privateConstructorUsedError;

  /// Serializes this EvidenceDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EvidenceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EvidenceDtoCopyWith<EvidenceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EvidenceDtoCopyWith<$Res> {
  factory $EvidenceDtoCopyWith(
    EvidenceDto value,
    $Res Function(EvidenceDto) then,
  ) = _$EvidenceDtoCopyWithImpl<$Res, EvidenceDto>;
  @useResult
  $Res call({
    String source,
    String formula,
    Object? evaluatedValue,
    num? score,
    bool? isMajor,
    List<VariableRefDto> missingVariables,
  });
}

/// @nodoc
class _$EvidenceDtoCopyWithImpl<$Res, $Val extends EvidenceDto>
    implements $EvidenceDtoCopyWith<$Res> {
  _$EvidenceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EvidenceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? formula = null,
    Object? evaluatedValue = freezed,
    Object? score = freezed,
    Object? isMajor = freezed,
    Object? missingVariables = null,
  }) {
    return _then(
      _value.copyWith(
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            formula: null == formula
                ? _value.formula
                : formula // ignore: cast_nullable_to_non_nullable
                      as String,
            evaluatedValue: freezed == evaluatedValue
                ? _value.evaluatedValue
                : evaluatedValue,
            score: freezed == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as num?,
            isMajor: freezed == isMajor
                ? _value.isMajor
                : isMajor // ignore: cast_nullable_to_non_nullable
                      as bool?,
            missingVariables: null == missingVariables
                ? _value.missingVariables
                : missingVariables // ignore: cast_nullable_to_non_nullable
                      as List<VariableRefDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EvidenceDtoImplCopyWith<$Res>
    implements $EvidenceDtoCopyWith<$Res> {
  factory _$$EvidenceDtoImplCopyWith(
    _$EvidenceDtoImpl value,
    $Res Function(_$EvidenceDtoImpl) then,
  ) = __$$EvidenceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String source,
    String formula,
    Object? evaluatedValue,
    num? score,
    bool? isMajor,
    List<VariableRefDto> missingVariables,
  });
}

/// @nodoc
class __$$EvidenceDtoImplCopyWithImpl<$Res>
    extends _$EvidenceDtoCopyWithImpl<$Res, _$EvidenceDtoImpl>
    implements _$$EvidenceDtoImplCopyWith<$Res> {
  __$$EvidenceDtoImplCopyWithImpl(
    _$EvidenceDtoImpl _value,
    $Res Function(_$EvidenceDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EvidenceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? formula = null,
    Object? evaluatedValue = freezed,
    Object? score = freezed,
    Object? isMajor = freezed,
    Object? missingVariables = null,
  }) {
    return _then(
      _$EvidenceDtoImpl(
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        formula: null == formula
            ? _value.formula
            : formula // ignore: cast_nullable_to_non_nullable
                  as String,
        evaluatedValue: freezed == evaluatedValue
            ? _value.evaluatedValue
            : evaluatedValue,
        score: freezed == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as num?,
        isMajor: freezed == isMajor
            ? _value.isMajor
            : isMajor // ignore: cast_nullable_to_non_nullable
                  as bool?,
        missingVariables: null == missingVariables
            ? _value._missingVariables
            : missingVariables // ignore: cast_nullable_to_non_nullable
                  as List<VariableRefDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EvidenceDtoImpl implements _EvidenceDto {
  const _$EvidenceDtoImpl({
    this.source = '',
    this.formula = '',
    this.evaluatedValue,
    this.score,
    this.isMajor,
    final List<VariableRefDto> missingVariables = const [],
  }) : _missingVariables = missingVariables;

  factory _$EvidenceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EvidenceDtoImplFromJson(json);

  @override
  @JsonKey()
  final String source;
  @override
  @JsonKey()
  final String formula;
  @override
  final Object? evaluatedValue;
  @override
  final num? score;
  @override
  final bool? isMajor;
  final List<VariableRefDto> _missingVariables;
  @override
  @JsonKey()
  List<VariableRefDto> get missingVariables {
    if (_missingVariables is EqualUnmodifiableListView)
      return _missingVariables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missingVariables);
  }

  @override
  String toString() {
    return 'EvidenceDto(source: $source, formula: $formula, evaluatedValue: $evaluatedValue, score: $score, isMajor: $isMajor, missingVariables: $missingVariables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EvidenceDtoImpl &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.formula, formula) || other.formula == formula) &&
            const DeepCollectionEquality().equals(
              other.evaluatedValue,
              evaluatedValue,
            ) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.isMajor, isMajor) || other.isMajor == isMajor) &&
            const DeepCollectionEquality().equals(
              other._missingVariables,
              _missingVariables,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    source,
    formula,
    const DeepCollectionEquality().hash(evaluatedValue),
    score,
    isMajor,
    const DeepCollectionEquality().hash(_missingVariables),
  );

  /// Create a copy of EvidenceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EvidenceDtoImplCopyWith<_$EvidenceDtoImpl> get copyWith =>
      __$$EvidenceDtoImplCopyWithImpl<_$EvidenceDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EvidenceDtoImplToJson(this);
  }
}

abstract class _EvidenceDto implements EvidenceDto {
  const factory _EvidenceDto({
    final String source,
    final String formula,
    final Object? evaluatedValue,
    final num? score,
    final bool? isMajor,
    final List<VariableRefDto> missingVariables,
  }) = _$EvidenceDtoImpl;

  factory _EvidenceDto.fromJson(Map<String, dynamic> json) =
      _$EvidenceDtoImpl.fromJson;

  @override
  String get source;
  @override
  String get formula;
  @override
  Object? get evaluatedValue;
  @override
  num? get score;
  @override
  bool? get isMajor;
  @override
  List<VariableRefDto> get missingVariables;

  /// Create a copy of EvidenceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EvidenceDtoImplCopyWith<_$EvidenceDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiagnoseResultDto _$DiagnoseResultDtoFromJson(Map<String, dynamic> json) {
  return _DiagnoseResultDto.fromJson(json);
}

/// @nodoc
mixin _$DiagnoseResultDto {
  String get severity =>
      throw _privateConstructorUsedError; // Mild | Moderate | Severe
  String get treatmentSite =>
      throw _privateConstructorUsedError; // Outpatient | Inpatient | IntensiveCareUnit
  List<NamedRefDto> get worthSuspected => throw _privateConstructorUsedError;
  List<NamedRefDto> get heavySuspected => throw _privateConstructorUsedError;
  List<EvidenceDto> get evidences => throw _privateConstructorUsedError;
  List<VariableRefDto> get missingVariables =>
      throw _privateConstructorUsedError;
  List<NamedRefDto> get allergies => throw _privateConstructorUsedError;
  bool get isPatientPregnantOrInLactationPhase =>
      throw _privateConstructorUsedError;

  /// Serializes this DiagnoseResultDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiagnoseResultDtoCopyWith<DiagnoseResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiagnoseResultDtoCopyWith<$Res> {
  factory $DiagnoseResultDtoCopyWith(
    DiagnoseResultDto value,
    $Res Function(DiagnoseResultDto) then,
  ) = _$DiagnoseResultDtoCopyWithImpl<$Res, DiagnoseResultDto>;
  @useResult
  $Res call({
    String severity,
    String treatmentSite,
    List<NamedRefDto> worthSuspected,
    List<NamedRefDto> heavySuspected,
    List<EvidenceDto> evidences,
    List<VariableRefDto> missingVariables,
    List<NamedRefDto> allergies,
    bool isPatientPregnantOrInLactationPhase,
  });
}

/// @nodoc
class _$DiagnoseResultDtoCopyWithImpl<$Res, $Val extends DiagnoseResultDto>
    implements $DiagnoseResultDtoCopyWith<$Res> {
  _$DiagnoseResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = null,
    Object? treatmentSite = null,
    Object? worthSuspected = null,
    Object? heavySuspected = null,
    Object? evidences = null,
    Object? missingVariables = null,
    Object? allergies = null,
    Object? isPatientPregnantOrInLactationPhase = null,
  }) {
    return _then(
      _value.copyWith(
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as String,
            treatmentSite: null == treatmentSite
                ? _value.treatmentSite
                : treatmentSite // ignore: cast_nullable_to_non_nullable
                      as String,
            worthSuspected: null == worthSuspected
                ? _value.worthSuspected
                : worthSuspected // ignore: cast_nullable_to_non_nullable
                      as List<NamedRefDto>,
            heavySuspected: null == heavySuspected
                ? _value.heavySuspected
                : heavySuspected // ignore: cast_nullable_to_non_nullable
                      as List<NamedRefDto>,
            evidences: null == evidences
                ? _value.evidences
                : evidences // ignore: cast_nullable_to_non_nullable
                      as List<EvidenceDto>,
            missingVariables: null == missingVariables
                ? _value.missingVariables
                : missingVariables // ignore: cast_nullable_to_non_nullable
                      as List<VariableRefDto>,
            allergies: null == allergies
                ? _value.allergies
                : allergies // ignore: cast_nullable_to_non_nullable
                      as List<NamedRefDto>,
            isPatientPregnantOrInLactationPhase:
                null == isPatientPregnantOrInLactationPhase
                ? _value.isPatientPregnantOrInLactationPhase
                : isPatientPregnantOrInLactationPhase // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiagnoseResultDtoImplCopyWith<$Res>
    implements $DiagnoseResultDtoCopyWith<$Res> {
  factory _$$DiagnoseResultDtoImplCopyWith(
    _$DiagnoseResultDtoImpl value,
    $Res Function(_$DiagnoseResultDtoImpl) then,
  ) = __$$DiagnoseResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String severity,
    String treatmentSite,
    List<NamedRefDto> worthSuspected,
    List<NamedRefDto> heavySuspected,
    List<EvidenceDto> evidences,
    List<VariableRefDto> missingVariables,
    List<NamedRefDto> allergies,
    bool isPatientPregnantOrInLactationPhase,
  });
}

/// @nodoc
class __$$DiagnoseResultDtoImplCopyWithImpl<$Res>
    extends _$DiagnoseResultDtoCopyWithImpl<$Res, _$DiagnoseResultDtoImpl>
    implements _$$DiagnoseResultDtoImplCopyWith<$Res> {
  __$$DiagnoseResultDtoImplCopyWithImpl(
    _$DiagnoseResultDtoImpl _value,
    $Res Function(_$DiagnoseResultDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = null,
    Object? treatmentSite = null,
    Object? worthSuspected = null,
    Object? heavySuspected = null,
    Object? evidences = null,
    Object? missingVariables = null,
    Object? allergies = null,
    Object? isPatientPregnantOrInLactationPhase = null,
  }) {
    return _then(
      _$DiagnoseResultDtoImpl(
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String,
        treatmentSite: null == treatmentSite
            ? _value.treatmentSite
            : treatmentSite // ignore: cast_nullable_to_non_nullable
                  as String,
        worthSuspected: null == worthSuspected
            ? _value._worthSuspected
            : worthSuspected // ignore: cast_nullable_to_non_nullable
                  as List<NamedRefDto>,
        heavySuspected: null == heavySuspected
            ? _value._heavySuspected
            : heavySuspected // ignore: cast_nullable_to_non_nullable
                  as List<NamedRefDto>,
        evidences: null == evidences
            ? _value._evidences
            : evidences // ignore: cast_nullable_to_non_nullable
                  as List<EvidenceDto>,
        missingVariables: null == missingVariables
            ? _value._missingVariables
            : missingVariables // ignore: cast_nullable_to_non_nullable
                  as List<VariableRefDto>,
        allergies: null == allergies
            ? _value._allergies
            : allergies // ignore: cast_nullable_to_non_nullable
                  as List<NamedRefDto>,
        isPatientPregnantOrInLactationPhase:
            null == isPatientPregnantOrInLactationPhase
            ? _value.isPatientPregnantOrInLactationPhase
            : isPatientPregnantOrInLactationPhase // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiagnoseResultDtoImpl implements _DiagnoseResultDto {
  const _$DiagnoseResultDtoImpl({
    required this.severity,
    required this.treatmentSite,
    final List<NamedRefDto> worthSuspected = const [],
    final List<NamedRefDto> heavySuspected = const [],
    final List<EvidenceDto> evidences = const [],
    final List<VariableRefDto> missingVariables = const [],
    final List<NamedRefDto> allergies = const [],
    this.isPatientPregnantOrInLactationPhase = false,
  }) : _worthSuspected = worthSuspected,
       _heavySuspected = heavySuspected,
       _evidences = evidences,
       _missingVariables = missingVariables,
       _allergies = allergies;

  factory _$DiagnoseResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiagnoseResultDtoImplFromJson(json);

  @override
  final String severity;
  // Mild | Moderate | Severe
  @override
  final String treatmentSite;
  // Outpatient | Inpatient | IntensiveCareUnit
  final List<NamedRefDto> _worthSuspected;
  // Outpatient | Inpatient | IntensiveCareUnit
  @override
  @JsonKey()
  List<NamedRefDto> get worthSuspected {
    if (_worthSuspected is EqualUnmodifiableListView) return _worthSuspected;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_worthSuspected);
  }

  final List<NamedRefDto> _heavySuspected;
  @override
  @JsonKey()
  List<NamedRefDto> get heavySuspected {
    if (_heavySuspected is EqualUnmodifiableListView) return _heavySuspected;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_heavySuspected);
  }

  final List<EvidenceDto> _evidences;
  @override
  @JsonKey()
  List<EvidenceDto> get evidences {
    if (_evidences is EqualUnmodifiableListView) return _evidences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evidences);
  }

  final List<VariableRefDto> _missingVariables;
  @override
  @JsonKey()
  List<VariableRefDto> get missingVariables {
    if (_missingVariables is EqualUnmodifiableListView)
      return _missingVariables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missingVariables);
  }

  final List<NamedRefDto> _allergies;
  @override
  @JsonKey()
  List<NamedRefDto> get allergies {
    if (_allergies is EqualUnmodifiableListView) return _allergies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergies);
  }

  @override
  @JsonKey()
  final bool isPatientPregnantOrInLactationPhase;

  @override
  String toString() {
    return 'DiagnoseResultDto(severity: $severity, treatmentSite: $treatmentSite, worthSuspected: $worthSuspected, heavySuspected: $heavySuspected, evidences: $evidences, missingVariables: $missingVariables, allergies: $allergies, isPatientPregnantOrInLactationPhase: $isPatientPregnantOrInLactationPhase)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagnoseResultDtoImpl &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.treatmentSite, treatmentSite) ||
                other.treatmentSite == treatmentSite) &&
            const DeepCollectionEquality().equals(
              other._worthSuspected,
              _worthSuspected,
            ) &&
            const DeepCollectionEquality().equals(
              other._heavySuspected,
              _heavySuspected,
            ) &&
            const DeepCollectionEquality().equals(
              other._evidences,
              _evidences,
            ) &&
            const DeepCollectionEquality().equals(
              other._missingVariables,
              _missingVariables,
            ) &&
            const DeepCollectionEquality().equals(
              other._allergies,
              _allergies,
            ) &&
            (identical(
                  other.isPatientPregnantOrInLactationPhase,
                  isPatientPregnantOrInLactationPhase,
                ) ||
                other.isPatientPregnantOrInLactationPhase ==
                    isPatientPregnantOrInLactationPhase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    severity,
    treatmentSite,
    const DeepCollectionEquality().hash(_worthSuspected),
    const DeepCollectionEquality().hash(_heavySuspected),
    const DeepCollectionEquality().hash(_evidences),
    const DeepCollectionEquality().hash(_missingVariables),
    const DeepCollectionEquality().hash(_allergies),
    isPatientPregnantOrInLactationPhase,
  );

  /// Create a copy of DiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiagnoseResultDtoImplCopyWith<_$DiagnoseResultDtoImpl> get copyWith =>
      __$$DiagnoseResultDtoImplCopyWithImpl<_$DiagnoseResultDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiagnoseResultDtoImplToJson(this);
  }
}

abstract class _DiagnoseResultDto implements DiagnoseResultDto {
  const factory _DiagnoseResultDto({
    required final String severity,
    required final String treatmentSite,
    final List<NamedRefDto> worthSuspected,
    final List<NamedRefDto> heavySuspected,
    final List<EvidenceDto> evidences,
    final List<VariableRefDto> missingVariables,
    final List<NamedRefDto> allergies,
    final bool isPatientPregnantOrInLactationPhase,
  }) = _$DiagnoseResultDtoImpl;

  factory _DiagnoseResultDto.fromJson(Map<String, dynamic> json) =
      _$DiagnoseResultDtoImpl.fromJson;

  @override
  String get severity; // Mild | Moderate | Severe
  @override
  String get treatmentSite; // Outpatient | Inpatient | IntensiveCareUnit
  @override
  List<NamedRefDto> get worthSuspected;
  @override
  List<NamedRefDto> get heavySuspected;
  @override
  List<EvidenceDto> get evidences;
  @override
  List<VariableRefDto> get missingVariables;
  @override
  List<NamedRefDto> get allergies;
  @override
  bool get isPatientPregnantOrInLactationPhase;

  /// Create a copy of DiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiagnoseResultDtoImplCopyWith<_$DiagnoseResultDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PathogenItemDto _$PathogenItemDtoFromJson(Map<String, dynamic> json) {
  return _PathogenItemDto.fromJson(json);
}

/// @nodoc
mixin _$PathogenItemDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this PathogenItemDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PathogenItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PathogenItemDtoCopyWith<PathogenItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PathogenItemDtoCopyWith<$Res> {
  factory $PathogenItemDtoCopyWith(
    PathogenItemDto value,
    $Res Function(PathogenItemDto) then,
  ) = _$PathogenItemDtoCopyWithImpl<$Res, PathogenItemDto>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$PathogenItemDtoCopyWithImpl<$Res, $Val extends PathogenItemDto>
    implements $PathogenItemDtoCopyWith<$Res> {
  _$PathogenItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PathogenItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PathogenItemDtoImplCopyWith<$Res>
    implements $PathogenItemDtoCopyWith<$Res> {
  factory _$$PathogenItemDtoImplCopyWith(
    _$PathogenItemDtoImpl value,
    $Res Function(_$PathogenItemDtoImpl) then,
  ) = __$$PathogenItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$PathogenItemDtoImplCopyWithImpl<$Res>
    extends _$PathogenItemDtoCopyWithImpl<$Res, _$PathogenItemDtoImpl>
    implements _$$PathogenItemDtoImplCopyWith<$Res> {
  __$$PathogenItemDtoImplCopyWithImpl(
    _$PathogenItemDtoImpl _value,
    $Res Function(_$PathogenItemDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PathogenItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$PathogenItemDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PathogenItemDtoImpl implements _PathogenItemDto {
  const _$PathogenItemDtoImpl({required this.id, required this.name});

  factory _$PathogenItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PathogenItemDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'PathogenItemDto(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PathogenItemDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of PathogenItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PathogenItemDtoImplCopyWith<_$PathogenItemDtoImpl> get copyWith =>
      __$$PathogenItemDtoImplCopyWithImpl<_$PathogenItemDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PathogenItemDtoImplToJson(this);
  }
}

abstract class _PathogenItemDto implements PathogenItemDto {
  const factory _PathogenItemDto({
    required final String id,
    required final String name,
  }) = _$PathogenItemDtoImpl;

  factory _PathogenItemDto.fromJson(Map<String, dynamic> json) =
      _$PathogenItemDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of PathogenItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PathogenItemDtoImplCopyWith<_$PathogenItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AntibioticResultDto _$AntibioticResultDtoFromJson(Map<String, dynamic> json) {
  return _AntibioticResultDto.fromJson(json);
}

/// @nodoc
mixin _$AntibioticResultDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get antibioticGroupName => throw _privateConstructorUsedError;
  String get classification => throw _privateConstructorUsedError;
  List<DosageDto> get dosages => throw _privateConstructorUsedError;

  /// Serializes this AntibioticResultDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AntibioticResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AntibioticResultDtoCopyWith<AntibioticResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AntibioticResultDtoCopyWith<$Res> {
  factory $AntibioticResultDtoCopyWith(
    AntibioticResultDto value,
    $Res Function(AntibioticResultDto) then,
  ) = _$AntibioticResultDtoCopyWithImpl<$Res, AntibioticResultDto>;
  @useResult
  $Res call({
    String id,
    String name,
    String antibioticGroupName,
    String classification,
    List<DosageDto> dosages,
  });
}

/// @nodoc
class _$AntibioticResultDtoCopyWithImpl<$Res, $Val extends AntibioticResultDto>
    implements $AntibioticResultDtoCopyWith<$Res> {
  _$AntibioticResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AntibioticResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? antibioticGroupName = null,
    Object? classification = null,
    Object? dosages = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            antibioticGroupName: null == antibioticGroupName
                ? _value.antibioticGroupName
                : antibioticGroupName // ignore: cast_nullable_to_non_nullable
                      as String,
            classification: null == classification
                ? _value.classification
                : classification // ignore: cast_nullable_to_non_nullable
                      as String,
            dosages: null == dosages
                ? _value.dosages
                : dosages // ignore: cast_nullable_to_non_nullable
                      as List<DosageDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AntibioticResultDtoImplCopyWith<$Res>
    implements $AntibioticResultDtoCopyWith<$Res> {
  factory _$$AntibioticResultDtoImplCopyWith(
    _$AntibioticResultDtoImpl value,
    $Res Function(_$AntibioticResultDtoImpl) then,
  ) = __$$AntibioticResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String antibioticGroupName,
    String classification,
    List<DosageDto> dosages,
  });
}

/// @nodoc
class __$$AntibioticResultDtoImplCopyWithImpl<$Res>
    extends _$AntibioticResultDtoCopyWithImpl<$Res, _$AntibioticResultDtoImpl>
    implements _$$AntibioticResultDtoImplCopyWith<$Res> {
  __$$AntibioticResultDtoImplCopyWithImpl(
    _$AntibioticResultDtoImpl _value,
    $Res Function(_$AntibioticResultDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AntibioticResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? antibioticGroupName = null,
    Object? classification = null,
    Object? dosages = null,
  }) {
    return _then(
      _$AntibioticResultDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        antibioticGroupName: null == antibioticGroupName
            ? _value.antibioticGroupName
            : antibioticGroupName // ignore: cast_nullable_to_non_nullable
                  as String,
        classification: null == classification
            ? _value.classification
            : classification // ignore: cast_nullable_to_non_nullable
                  as String,
        dosages: null == dosages
            ? _value._dosages
            : dosages // ignore: cast_nullable_to_non_nullable
                  as List<DosageDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AntibioticResultDtoImpl implements _AntibioticResultDto {
  const _$AntibioticResultDtoImpl({
    required this.id,
    required this.name,
    this.antibioticGroupName = '',
    this.classification = '',
    final List<DosageDto> dosages = const [],
  }) : _dosages = dosages;

  factory _$AntibioticResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AntibioticResultDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String antibioticGroupName;
  @override
  @JsonKey()
  final String classification;
  final List<DosageDto> _dosages;
  @override
  @JsonKey()
  List<DosageDto> get dosages {
    if (_dosages is EqualUnmodifiableListView) return _dosages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dosages);
  }

  @override
  String toString() {
    return 'AntibioticResultDto(id: $id, name: $name, antibioticGroupName: $antibioticGroupName, classification: $classification, dosages: $dosages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AntibioticResultDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.antibioticGroupName, antibioticGroupName) ||
                other.antibioticGroupName == antibioticGroupName) &&
            (identical(other.classification, classification) ||
                other.classification == classification) &&
            const DeepCollectionEquality().equals(other._dosages, _dosages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    antibioticGroupName,
    classification,
    const DeepCollectionEquality().hash(_dosages),
  );

  /// Create a copy of AntibioticResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AntibioticResultDtoImplCopyWith<_$AntibioticResultDtoImpl> get copyWith =>
      __$$AntibioticResultDtoImplCopyWithImpl<_$AntibioticResultDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AntibioticResultDtoImplToJson(this);
  }
}

abstract class _AntibioticResultDto implements AntibioticResultDto {
  const factory _AntibioticResultDto({
    required final String id,
    required final String name,
    final String antibioticGroupName,
    final String classification,
    final List<DosageDto> dosages,
  }) = _$AntibioticResultDtoImpl;

  factory _AntibioticResultDto.fromJson(Map<String, dynamic> json) =
      _$AntibioticResultDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get antibioticGroupName;
  @override
  String get classification;
  @override
  List<DosageDto> get dosages;

  /// Create a copy of AntibioticResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AntibioticResultDtoImplCopyWith<_$AntibioticResultDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DosageDto _$DosageDtoFromJson(Map<String, dynamic> json) {
  return _DosageDto.fromJson(json);
}

/// @nodoc
mixin _$DosageDto {
  String get routeOfAdministration => throw _privateConstructorUsedError;
  String get dose => throw _privateConstructorUsedError;

  /// Serializes this DosageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DosageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DosageDtoCopyWith<DosageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DosageDtoCopyWith<$Res> {
  factory $DosageDtoCopyWith(DosageDto value, $Res Function(DosageDto) then) =
      _$DosageDtoCopyWithImpl<$Res, DosageDto>;
  @useResult
  $Res call({String routeOfAdministration, String dose});
}

/// @nodoc
class _$DosageDtoCopyWithImpl<$Res, $Val extends DosageDto>
    implements $DosageDtoCopyWith<$Res> {
  _$DosageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DosageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? routeOfAdministration = null, Object? dose = null}) {
    return _then(
      _value.copyWith(
            routeOfAdministration: null == routeOfAdministration
                ? _value.routeOfAdministration
                : routeOfAdministration // ignore: cast_nullable_to_non_nullable
                      as String,
            dose: null == dose
                ? _value.dose
                : dose // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DosageDtoImplCopyWith<$Res>
    implements $DosageDtoCopyWith<$Res> {
  factory _$$DosageDtoImplCopyWith(
    _$DosageDtoImpl value,
    $Res Function(_$DosageDtoImpl) then,
  ) = __$$DosageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String routeOfAdministration, String dose});
}

/// @nodoc
class __$$DosageDtoImplCopyWithImpl<$Res>
    extends _$DosageDtoCopyWithImpl<$Res, _$DosageDtoImpl>
    implements _$$DosageDtoImplCopyWith<$Res> {
  __$$DosageDtoImplCopyWithImpl(
    _$DosageDtoImpl _value,
    $Res Function(_$DosageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DosageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? routeOfAdministration = null, Object? dose = null}) {
    return _then(
      _$DosageDtoImpl(
        routeOfAdministration: null == routeOfAdministration
            ? _value.routeOfAdministration
            : routeOfAdministration // ignore: cast_nullable_to_non_nullable
                  as String,
        dose: null == dose
            ? _value.dose
            : dose // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DosageDtoImpl implements _DosageDto {
  const _$DosageDtoImpl({
    required this.routeOfAdministration,
    required this.dose,
  });

  factory _$DosageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DosageDtoImplFromJson(json);

  @override
  final String routeOfAdministration;
  @override
  final String dose;

  @override
  String toString() {
    return 'DosageDto(routeOfAdministration: $routeOfAdministration, dose: $dose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DosageDtoImpl &&
            (identical(other.routeOfAdministration, routeOfAdministration) ||
                other.routeOfAdministration == routeOfAdministration) &&
            (identical(other.dose, dose) || other.dose == dose));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, routeOfAdministration, dose);

  /// Create a copy of DosageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DosageDtoImplCopyWith<_$DosageDtoImpl> get copyWith =>
      __$$DosageDtoImplCopyWithImpl<_$DosageDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DosageDtoImplToJson(this);
  }
}

abstract class _DosageDto implements DosageDto {
  const factory _DosageDto({
    required final String routeOfAdministration,
    required final String dose,
  }) = _$DosageDtoImpl;

  factory _DosageDto.fromJson(Map<String, dynamic> json) =
      _$DosageDtoImpl.fromJson;

  @override
  String get routeOfAdministration;
  @override
  String get dose;

  /// Create a copy of DosageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DosageDtoImplCopyWith<_$DosageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TargetedDiagnoseResultDto _$TargetedDiagnoseResultDtoFromJson(
  Map<String, dynamic> json,
) {
  return _TargetedDiagnoseResultDto.fromJson(json);
}

/// @nodoc
mixin _$TargetedDiagnoseResultDto {
  double get crcl => throw _privateConstructorUsedError;
  List<AntibioticResultDto> get recommendations =>
      throw _privateConstructorUsedError;

  /// Serializes this TargetedDiagnoseResultDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TargetedDiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TargetedDiagnoseResultDtoCopyWith<TargetedDiagnoseResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetedDiagnoseResultDtoCopyWith<$Res> {
  factory $TargetedDiagnoseResultDtoCopyWith(
    TargetedDiagnoseResultDto value,
    $Res Function(TargetedDiagnoseResultDto) then,
  ) = _$TargetedDiagnoseResultDtoCopyWithImpl<$Res, TargetedDiagnoseResultDto>;
  @useResult
  $Res call({double crcl, List<AntibioticResultDto> recommendations});
}

/// @nodoc
class _$TargetedDiagnoseResultDtoCopyWithImpl<
  $Res,
  $Val extends TargetedDiagnoseResultDto
>
    implements $TargetedDiagnoseResultDtoCopyWith<$Res> {
  _$TargetedDiagnoseResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TargetedDiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? crcl = null, Object? recommendations = null}) {
    return _then(
      _value.copyWith(
            crcl: null == crcl
                ? _value.crcl
                : crcl // ignore: cast_nullable_to_non_nullable
                      as double,
            recommendations: null == recommendations
                ? _value.recommendations
                : recommendations // ignore: cast_nullable_to_non_nullable
                      as List<AntibioticResultDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TargetedDiagnoseResultDtoImplCopyWith<$Res>
    implements $TargetedDiagnoseResultDtoCopyWith<$Res> {
  factory _$$TargetedDiagnoseResultDtoImplCopyWith(
    _$TargetedDiagnoseResultDtoImpl value,
    $Res Function(_$TargetedDiagnoseResultDtoImpl) then,
  ) = __$$TargetedDiagnoseResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double crcl, List<AntibioticResultDto> recommendations});
}

/// @nodoc
class __$$TargetedDiagnoseResultDtoImplCopyWithImpl<$Res>
    extends
        _$TargetedDiagnoseResultDtoCopyWithImpl<
          $Res,
          _$TargetedDiagnoseResultDtoImpl
        >
    implements _$$TargetedDiagnoseResultDtoImplCopyWith<$Res> {
  __$$TargetedDiagnoseResultDtoImplCopyWithImpl(
    _$TargetedDiagnoseResultDtoImpl _value,
    $Res Function(_$TargetedDiagnoseResultDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TargetedDiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? crcl = null, Object? recommendations = null}) {
    return _then(
      _$TargetedDiagnoseResultDtoImpl(
        crcl: null == crcl
            ? _value.crcl
            : crcl // ignore: cast_nullable_to_non_nullable
                  as double,
        recommendations: null == recommendations
            ? _value._recommendations
            : recommendations // ignore: cast_nullable_to_non_nullable
                  as List<AntibioticResultDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TargetedDiagnoseResultDtoImpl implements _TargetedDiagnoseResultDto {
  const _$TargetedDiagnoseResultDtoImpl({
    this.crcl = 0,
    final List<AntibioticResultDto> recommendations = const [],
  }) : _recommendations = recommendations;

  factory _$TargetedDiagnoseResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TargetedDiagnoseResultDtoImplFromJson(json);

  @override
  @JsonKey()
  final double crcl;
  final List<AntibioticResultDto> _recommendations;
  @override
  @JsonKey()
  List<AntibioticResultDto> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  String toString() {
    return 'TargetedDiagnoseResultDto(crcl: $crcl, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TargetedDiagnoseResultDtoImpl &&
            (identical(other.crcl, crcl) || other.crcl == crcl) &&
            const DeepCollectionEquality().equals(
              other._recommendations,
              _recommendations,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    crcl,
    const DeepCollectionEquality().hash(_recommendations),
  );

  /// Create a copy of TargetedDiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TargetedDiagnoseResultDtoImplCopyWith<_$TargetedDiagnoseResultDtoImpl>
  get copyWith =>
      __$$TargetedDiagnoseResultDtoImplCopyWithImpl<
        _$TargetedDiagnoseResultDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TargetedDiagnoseResultDtoImplToJson(this);
  }
}

abstract class _TargetedDiagnoseResultDto implements TargetedDiagnoseResultDto {
  const factory _TargetedDiagnoseResultDto({
    final double crcl,
    final List<AntibioticResultDto> recommendations,
  }) = _$TargetedDiagnoseResultDtoImpl;

  factory _TargetedDiagnoseResultDto.fromJson(Map<String, dynamic> json) =
      _$TargetedDiagnoseResultDtoImpl.fromJson;

  @override
  double get crcl;
  @override
  List<AntibioticResultDto> get recommendations;

  /// Create a copy of TargetedDiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TargetedDiagnoseResultDtoImplCopyWith<_$TargetedDiagnoseResultDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
