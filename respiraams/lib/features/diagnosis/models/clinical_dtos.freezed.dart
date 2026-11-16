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
  List<ClinicalVariableDto> get clinicalVariables =>
      throw _privateConstructorUsedError;
  List<AntibioticFormDto> get antibiotics => throw _privateConstructorUsedError;
  List<NamedRefDto> get pathogens => throw _privateConstructorUsedError;

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
  $Res call({
    List<ClinicalVariableDto> clinicalVariables,
    List<AntibioticFormDto> antibiotics,
    List<NamedRefDto> pathogens,
  });
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
  $Res call({
    Object? clinicalVariables = null,
    Object? antibiotics = null,
    Object? pathogens = null,
  }) {
    return _then(
      _value.copyWith(
            clinicalVariables: null == clinicalVariables
                ? _value.clinicalVariables
                : clinicalVariables // ignore: cast_nullable_to_non_nullable
                      as List<ClinicalVariableDto>,
            antibiotics: null == antibiotics
                ? _value.antibiotics
                : antibiotics // ignore: cast_nullable_to_non_nullable
                      as List<AntibioticFormDto>,
            pathogens: null == pathogens
                ? _value.pathogens
                : pathogens // ignore: cast_nullable_to_non_nullable
                      as List<NamedRefDto>,
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
  $Res call({
    List<ClinicalVariableDto> clinicalVariables,
    List<AntibioticFormDto> antibiotics,
    List<NamedRefDto> pathogens,
  });
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
  $Res call({
    Object? clinicalVariables = null,
    Object? antibiotics = null,
    Object? pathogens = null,
  }) {
    return _then(
      _$DiagnosisFormDtoImpl(
        clinicalVariables: null == clinicalVariables
            ? _value._clinicalVariables
            : clinicalVariables // ignore: cast_nullable_to_non_nullable
                  as List<ClinicalVariableDto>,
        antibiotics: null == antibiotics
            ? _value._antibiotics
            : antibiotics // ignore: cast_nullable_to_non_nullable
                  as List<AntibioticFormDto>,
        pathogens: null == pathogens
            ? _value._pathogens
            : pathogens // ignore: cast_nullable_to_non_nullable
                  as List<NamedRefDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiagnosisFormDtoImpl extends _DiagnosisFormDto {
  const _$DiagnosisFormDtoImpl({
    final List<ClinicalVariableDto> clinicalVariables = const [],
    final List<AntibioticFormDto> antibiotics = const [],
    final List<NamedRefDto> pathogens = const [],
  }) : _clinicalVariables = clinicalVariables,
       _antibiotics = antibiotics,
       _pathogens = pathogens,
       super._();

  factory _$DiagnosisFormDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiagnosisFormDtoImplFromJson(json);

  final List<ClinicalVariableDto> _clinicalVariables;
  @override
  @JsonKey()
  List<ClinicalVariableDto> get clinicalVariables {
    if (_clinicalVariables is EqualUnmodifiableListView)
      return _clinicalVariables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clinicalVariables);
  }

  final List<AntibioticFormDto> _antibiotics;
  @override
  @JsonKey()
  List<AntibioticFormDto> get antibiotics {
    if (_antibiotics is EqualUnmodifiableListView) return _antibiotics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_antibiotics);
  }

  final List<NamedRefDto> _pathogens;
  @override
  @JsonKey()
  List<NamedRefDto> get pathogens {
    if (_pathogens is EqualUnmodifiableListView) return _pathogens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pathogens);
  }

  @override
  String toString() {
    return 'DiagnosisFormDto(clinicalVariables: $clinicalVariables, antibiotics: $antibiotics, pathogens: $pathogens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagnosisFormDtoImpl &&
            const DeepCollectionEquality().equals(
              other._clinicalVariables,
              _clinicalVariables,
            ) &&
            const DeepCollectionEquality().equals(
              other._antibiotics,
              _antibiotics,
            ) &&
            const DeepCollectionEquality().equals(
              other._pathogens,
              _pathogens,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_clinicalVariables),
    const DeepCollectionEquality().hash(_antibiotics),
    const DeepCollectionEquality().hash(_pathogens),
  );

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

abstract class _DiagnosisFormDto extends DiagnosisFormDto {
  const factory _DiagnosisFormDto({
    final List<ClinicalVariableDto> clinicalVariables,
    final List<AntibioticFormDto> antibiotics,
    final List<NamedRefDto> pathogens,
  }) = _$DiagnosisFormDtoImpl;
  const _DiagnosisFormDto._() : super._();

  factory _DiagnosisFormDto.fromJson(Map<String, dynamic> json) =
      _$DiagnosisFormDtoImpl.fromJson;

  @override
  List<ClinicalVariableDto> get clinicalVariables;
  @override
  List<AntibioticFormDto> get antibiotics;
  @override
  List<NamedRefDto> get pathogens;

  /// Create a copy of DiagnosisFormDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiagnosisFormDtoImplCopyWith<_$DiagnosisFormDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AntibioticFormDto _$AntibioticFormDtoFromJson(Map<String, dynamic> json) {
  return _AntibioticFormDto.fromJson(json);
}

/// @nodoc
mixin _$AntibioticFormDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get antibioticGroupId => throw _privateConstructorUsedError;
  String get antibioticGroupName => throw _privateConstructorUsedError;
  String get classification => throw _privateConstructorUsedError;

  /// Serializes this AntibioticFormDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AntibioticFormDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AntibioticFormDtoCopyWith<AntibioticFormDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AntibioticFormDtoCopyWith<$Res> {
  factory $AntibioticFormDtoCopyWith(
    AntibioticFormDto value,
    $Res Function(AntibioticFormDto) then,
  ) = _$AntibioticFormDtoCopyWithImpl<$Res, AntibioticFormDto>;
  @useResult
  $Res call({
    String id,
    String name,
    String antibioticGroupId,
    String antibioticGroupName,
    String classification,
  });
}

/// @nodoc
class _$AntibioticFormDtoCopyWithImpl<$Res, $Val extends AntibioticFormDto>
    implements $AntibioticFormDtoCopyWith<$Res> {
  _$AntibioticFormDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AntibioticFormDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? antibioticGroupId = null,
    Object? antibioticGroupName = null,
    Object? classification = null,
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
            antibioticGroupId: null == antibioticGroupId
                ? _value.antibioticGroupId
                : antibioticGroupId // ignore: cast_nullable_to_non_nullable
                      as String,
            antibioticGroupName: null == antibioticGroupName
                ? _value.antibioticGroupName
                : antibioticGroupName // ignore: cast_nullable_to_non_nullable
                      as String,
            classification: null == classification
                ? _value.classification
                : classification // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AntibioticFormDtoImplCopyWith<$Res>
    implements $AntibioticFormDtoCopyWith<$Res> {
  factory _$$AntibioticFormDtoImplCopyWith(
    _$AntibioticFormDtoImpl value,
    $Res Function(_$AntibioticFormDtoImpl) then,
  ) = __$$AntibioticFormDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String antibioticGroupId,
    String antibioticGroupName,
    String classification,
  });
}

/// @nodoc
class __$$AntibioticFormDtoImplCopyWithImpl<$Res>
    extends _$AntibioticFormDtoCopyWithImpl<$Res, _$AntibioticFormDtoImpl>
    implements _$$AntibioticFormDtoImplCopyWith<$Res> {
  __$$AntibioticFormDtoImplCopyWithImpl(
    _$AntibioticFormDtoImpl _value,
    $Res Function(_$AntibioticFormDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AntibioticFormDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? antibioticGroupId = null,
    Object? antibioticGroupName = null,
    Object? classification = null,
  }) {
    return _then(
      _$AntibioticFormDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        antibioticGroupId: null == antibioticGroupId
            ? _value.antibioticGroupId
            : antibioticGroupId // ignore: cast_nullable_to_non_nullable
                  as String,
        antibioticGroupName: null == antibioticGroupName
            ? _value.antibioticGroupName
            : antibioticGroupName // ignore: cast_nullable_to_non_nullable
                  as String,
        classification: null == classification
            ? _value.classification
            : classification // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AntibioticFormDtoImpl implements _AntibioticFormDto {
  const _$AntibioticFormDtoImpl({
    required this.id,
    required this.name,
    this.antibioticGroupId = '',
    this.antibioticGroupName = '',
    this.classification = '',
  });

  factory _$AntibioticFormDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AntibioticFormDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String antibioticGroupId;
  @override
  @JsonKey()
  final String antibioticGroupName;
  @override
  @JsonKey()
  final String classification;

  @override
  String toString() {
    return 'AntibioticFormDto(id: $id, name: $name, antibioticGroupId: $antibioticGroupId, antibioticGroupName: $antibioticGroupName, classification: $classification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AntibioticFormDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.antibioticGroupId, antibioticGroupId) ||
                other.antibioticGroupId == antibioticGroupId) &&
            (identical(other.antibioticGroupName, antibioticGroupName) ||
                other.antibioticGroupName == antibioticGroupName) &&
            (identical(other.classification, classification) ||
                other.classification == classification));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    antibioticGroupId,
    antibioticGroupName,
    classification,
  );

  /// Create a copy of AntibioticFormDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AntibioticFormDtoImplCopyWith<_$AntibioticFormDtoImpl> get copyWith =>
      __$$AntibioticFormDtoImplCopyWithImpl<_$AntibioticFormDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AntibioticFormDtoImplToJson(this);
  }
}

abstract class _AntibioticFormDto implements AntibioticFormDto {
  const factory _AntibioticFormDto({
    required final String id,
    required final String name,
    final String antibioticGroupId,
    final String antibioticGroupName,
    final String classification,
  }) = _$AntibioticFormDtoImpl;

  factory _AntibioticFormDto.fromJson(Map<String, dynamic> json) =
      _$AntibioticFormDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get antibioticGroupId;
  @override
  String get antibioticGroupName;
  @override
  String get classification;

  /// Create a copy of AntibioticFormDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AntibioticFormDtoImplCopyWith<_$AntibioticFormDtoImpl> get copyWith =>
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
class _$VariableRefDtoImpl extends _VariableRefDto {
  const _$VariableRefDtoImpl({required this.id, this.name = '', this.code = ''})
    : super._();

  factory _$VariableRefDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariableRefDtoImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
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

abstract class _VariableRefDto extends VariableRefDto {
  const factory _VariableRefDto({
    required final String id,
    final String name,
    final String code,
  }) = _$VariableRefDtoImpl;
  const _VariableRefDto._() : super._();

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

RelatedObservationDto _$RelatedObservationDtoFromJson(
  Map<String, dynamic> json,
) {
  return _RelatedObservationDto.fromJson(json);
}

/// @nodoc
mixin _$RelatedObservationDto {
  VariableRefDto? get variable => throw _privateConstructorUsedError;
  Object? get value => throw _privateConstructorUsedError;

  /// Serializes this RelatedObservationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RelatedObservationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RelatedObservationDtoCopyWith<RelatedObservationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelatedObservationDtoCopyWith<$Res> {
  factory $RelatedObservationDtoCopyWith(
    RelatedObservationDto value,
    $Res Function(RelatedObservationDto) then,
  ) = _$RelatedObservationDtoCopyWithImpl<$Res, RelatedObservationDto>;
  @useResult
  $Res call({VariableRefDto? variable, Object? value});

  $VariableRefDtoCopyWith<$Res>? get variable;
}

/// @nodoc
class _$RelatedObservationDtoCopyWithImpl<
  $Res,
  $Val extends RelatedObservationDto
>
    implements $RelatedObservationDtoCopyWith<$Res> {
  _$RelatedObservationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RelatedObservationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? variable = freezed, Object? value = freezed}) {
    return _then(
      _value.copyWith(
            variable: freezed == variable
                ? _value.variable
                : variable // ignore: cast_nullable_to_non_nullable
                      as VariableRefDto?,
            value: freezed == value ? _value.value : value,
          )
          as $Val,
    );
  }

  /// Create a copy of RelatedObservationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VariableRefDtoCopyWith<$Res>? get variable {
    if (_value.variable == null) {
      return null;
    }

    return $VariableRefDtoCopyWith<$Res>(_value.variable!, (value) {
      return _then(_value.copyWith(variable: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RelatedObservationDtoImplCopyWith<$Res>
    implements $RelatedObservationDtoCopyWith<$Res> {
  factory _$$RelatedObservationDtoImplCopyWith(
    _$RelatedObservationDtoImpl value,
    $Res Function(_$RelatedObservationDtoImpl) then,
  ) = __$$RelatedObservationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({VariableRefDto? variable, Object? value});

  @override
  $VariableRefDtoCopyWith<$Res>? get variable;
}

/// @nodoc
class __$$RelatedObservationDtoImplCopyWithImpl<$Res>
    extends
        _$RelatedObservationDtoCopyWithImpl<$Res, _$RelatedObservationDtoImpl>
    implements _$$RelatedObservationDtoImplCopyWith<$Res> {
  __$$RelatedObservationDtoImplCopyWithImpl(
    _$RelatedObservationDtoImpl _value,
    $Res Function(_$RelatedObservationDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RelatedObservationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? variable = freezed, Object? value = freezed}) {
    return _then(
      _$RelatedObservationDtoImpl(
        variable: freezed == variable
            ? _value.variable
            : variable // ignore: cast_nullable_to_non_nullable
                  as VariableRefDto?,
        value: freezed == value ? _value.value : value,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RelatedObservationDtoImpl implements _RelatedObservationDto {
  const _$RelatedObservationDtoImpl({this.variable, this.value});

  factory _$RelatedObservationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelatedObservationDtoImplFromJson(json);

  @override
  final VariableRefDto? variable;
  @override
  final Object? value;

  @override
  String toString() {
    return 'RelatedObservationDto(variable: $variable, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelatedObservationDtoImpl &&
            (identical(other.variable, variable) ||
                other.variable == variable) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    variable,
    const DeepCollectionEquality().hash(value),
  );

  /// Create a copy of RelatedObservationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RelatedObservationDtoImplCopyWith<_$RelatedObservationDtoImpl>
  get copyWith =>
      __$$RelatedObservationDtoImplCopyWithImpl<_$RelatedObservationDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RelatedObservationDtoImplToJson(this);
  }
}

abstract class _RelatedObservationDto implements RelatedObservationDto {
  const factory _RelatedObservationDto({
    final VariableRefDto? variable,
    final Object? value,
  }) = _$RelatedObservationDtoImpl;

  factory _RelatedObservationDto.fromJson(Map<String, dynamic> json) =
      _$RelatedObservationDtoImpl.fromJson;

  @override
  VariableRefDto? get variable;
  @override
  Object? get value;

  /// Create a copy of RelatedObservationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RelatedObservationDtoImplCopyWith<_$RelatedObservationDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

EvidenceDto _$EvidenceDtoFromJson(Map<String, dynamic> json) {
  return _EvidenceDto.fromJson(json);
}

/// @nodoc
mixin _$EvidenceDto {
  String get source => throw _privateConstructorUsedError;
  String get formula => throw _privateConstructorUsedError;
  List<RelatedObservationDto> get relatedObservations =>
      throw _privateConstructorUsedError;
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
    List<RelatedObservationDto> relatedObservations,
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
    Object? relatedObservations = null,
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
            relatedObservations: null == relatedObservations
                ? _value.relatedObservations
                : relatedObservations // ignore: cast_nullable_to_non_nullable
                      as List<RelatedObservationDto>,
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
    List<RelatedObservationDto> relatedObservations,
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
    Object? relatedObservations = null,
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
        relatedObservations: null == relatedObservations
            ? _value._relatedObservations
            : relatedObservations // ignore: cast_nullable_to_non_nullable
                  as List<RelatedObservationDto>,
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
    final List<RelatedObservationDto> relatedObservations = const [],
    this.evaluatedValue,
    this.score,
    this.isMajor,
    final List<VariableRefDto> missingVariables = const [],
  }) : _relatedObservations = relatedObservations,
       _missingVariables = missingVariables;

  factory _$EvidenceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EvidenceDtoImplFromJson(json);

  @override
  @JsonKey()
  final String source;
  @override
  @JsonKey()
  final String formula;
  final List<RelatedObservationDto> _relatedObservations;
  @override
  @JsonKey()
  List<RelatedObservationDto> get relatedObservations {
    if (_relatedObservations is EqualUnmodifiableListView)
      return _relatedObservations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedObservations);
  }

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
    return 'EvidenceDto(source: $source, formula: $formula, relatedObservations: $relatedObservations, evaluatedValue: $evaluatedValue, score: $score, isMajor: $isMajor, missingVariables: $missingVariables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EvidenceDtoImpl &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.formula, formula) || other.formula == formula) &&
            const DeepCollectionEquality().equals(
              other._relatedObservations,
              _relatedObservations,
            ) &&
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
    const DeepCollectionEquality().hash(_relatedObservations),
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
    final List<RelatedObservationDto> relatedObservations,
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
  List<RelatedObservationDto> get relatedObservations;
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

MetricsSeverityDto _$MetricsSeverityDtoFromJson(Map<String, dynamic> json) {
  return _MetricsSeverityDto.fromJson(json);
}

/// @nodoc
mixin _$MetricsSeverityDto {
  String get code => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  String get treatmentSite => throw _privateConstructorUsedError;
  List<EvidenceDto> get evidences => throw _privateConstructorUsedError;
  int? get score => throw _privateConstructorUsedError;
  int? get majorMatched => throw _privateConstructorUsedError;
  int? get minorMatched => throw _privateConstructorUsedError;

  /// Serializes this MetricsSeverityDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MetricsSeverityDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MetricsSeverityDtoCopyWith<MetricsSeverityDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetricsSeverityDtoCopyWith<$Res> {
  factory $MetricsSeverityDtoCopyWith(
    MetricsSeverityDto value,
    $Res Function(MetricsSeverityDto) then,
  ) = _$MetricsSeverityDtoCopyWithImpl<$Res, MetricsSeverityDto>;
  @useResult
  $Res call({
    String code,
    String severity,
    String treatmentSite,
    List<EvidenceDto> evidences,
    int? score,
    int? majorMatched,
    int? minorMatched,
  });
}

/// @nodoc
class _$MetricsSeverityDtoCopyWithImpl<$Res, $Val extends MetricsSeverityDto>
    implements $MetricsSeverityDtoCopyWith<$Res> {
  _$MetricsSeverityDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MetricsSeverityDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? severity = null,
    Object? treatmentSite = null,
    Object? evidences = null,
    Object? score = freezed,
    Object? majorMatched = freezed,
    Object? minorMatched = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as String,
            treatmentSite: null == treatmentSite
                ? _value.treatmentSite
                : treatmentSite // ignore: cast_nullable_to_non_nullable
                      as String,
            evidences: null == evidences
                ? _value.evidences
                : evidences // ignore: cast_nullable_to_non_nullable
                      as List<EvidenceDto>,
            score: freezed == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int?,
            majorMatched: freezed == majorMatched
                ? _value.majorMatched
                : majorMatched // ignore: cast_nullable_to_non_nullable
                      as int?,
            minorMatched: freezed == minorMatched
                ? _value.minorMatched
                : minorMatched // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MetricsSeverityDtoImplCopyWith<$Res>
    implements $MetricsSeverityDtoCopyWith<$Res> {
  factory _$$MetricsSeverityDtoImplCopyWith(
    _$MetricsSeverityDtoImpl value,
    $Res Function(_$MetricsSeverityDtoImpl) then,
  ) = __$$MetricsSeverityDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String severity,
    String treatmentSite,
    List<EvidenceDto> evidences,
    int? score,
    int? majorMatched,
    int? minorMatched,
  });
}

/// @nodoc
class __$$MetricsSeverityDtoImplCopyWithImpl<$Res>
    extends _$MetricsSeverityDtoCopyWithImpl<$Res, _$MetricsSeverityDtoImpl>
    implements _$$MetricsSeverityDtoImplCopyWith<$Res> {
  __$$MetricsSeverityDtoImplCopyWithImpl(
    _$MetricsSeverityDtoImpl _value,
    $Res Function(_$MetricsSeverityDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MetricsSeverityDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? severity = null,
    Object? treatmentSite = null,
    Object? evidences = null,
    Object? score = freezed,
    Object? majorMatched = freezed,
    Object? minorMatched = freezed,
  }) {
    return _then(
      _$MetricsSeverityDtoImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String,
        treatmentSite: null == treatmentSite
            ? _value.treatmentSite
            : treatmentSite // ignore: cast_nullable_to_non_nullable
                  as String,
        evidences: null == evidences
            ? _value._evidences
            : evidences // ignore: cast_nullable_to_non_nullable
                  as List<EvidenceDto>,
        score: freezed == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int?,
        majorMatched: freezed == majorMatched
            ? _value.majorMatched
            : majorMatched // ignore: cast_nullable_to_non_nullable
                  as int?,
        minorMatched: freezed == minorMatched
            ? _value.minorMatched
            : minorMatched // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MetricsSeverityDtoImpl implements _MetricsSeverityDto {
  const _$MetricsSeverityDtoImpl({
    this.code = '',
    this.severity = '',
    this.treatmentSite = '',
    final List<EvidenceDto> evidences = const [],
    this.score,
    this.majorMatched,
    this.minorMatched,
  }) : _evidences = evidences;

  factory _$MetricsSeverityDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetricsSeverityDtoImplFromJson(json);

  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final String severity;
  @override
  @JsonKey()
  final String treatmentSite;
  final List<EvidenceDto> _evidences;
  @override
  @JsonKey()
  List<EvidenceDto> get evidences {
    if (_evidences is EqualUnmodifiableListView) return _evidences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evidences);
  }

  @override
  final int? score;
  @override
  final int? majorMatched;
  @override
  final int? minorMatched;

  @override
  String toString() {
    return 'MetricsSeverityDto(code: $code, severity: $severity, treatmentSite: $treatmentSite, evidences: $evidences, score: $score, majorMatched: $majorMatched, minorMatched: $minorMatched)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetricsSeverityDtoImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.treatmentSite, treatmentSite) ||
                other.treatmentSite == treatmentSite) &&
            const DeepCollectionEquality().equals(
              other._evidences,
              _evidences,
            ) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.majorMatched, majorMatched) ||
                other.majorMatched == majorMatched) &&
            (identical(other.minorMatched, minorMatched) ||
                other.minorMatched == minorMatched));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    severity,
    treatmentSite,
    const DeepCollectionEquality().hash(_evidences),
    score,
    majorMatched,
    minorMatched,
  );

  /// Create a copy of MetricsSeverityDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetricsSeverityDtoImplCopyWith<_$MetricsSeverityDtoImpl> get copyWith =>
      __$$MetricsSeverityDtoImplCopyWithImpl<_$MetricsSeverityDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MetricsSeverityDtoImplToJson(this);
  }
}

abstract class _MetricsSeverityDto implements MetricsSeverityDto {
  const factory _MetricsSeverityDto({
    final String code,
    final String severity,
    final String treatmentSite,
    final List<EvidenceDto> evidences,
    final int? score,
    final int? majorMatched,
    final int? minorMatched,
  }) = _$MetricsSeverityDtoImpl;

  factory _MetricsSeverityDto.fromJson(Map<String, dynamic> json) =
      _$MetricsSeverityDtoImpl.fromJson;

  @override
  String get code;
  @override
  String get severity;
  @override
  String get treatmentSite;
  @override
  List<EvidenceDto> get evidences;
  @override
  int? get score;
  @override
  int? get majorMatched;
  @override
  int? get minorMatched;

  /// Create a copy of MetricsSeverityDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetricsSeverityDtoImplCopyWith<_$MetricsSeverityDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MicrobialTestResultDto _$MicrobialTestResultDtoFromJson(
  Map<String, dynamic> json,
) {
  return _MicrobialTestResultDto.fromJson(json);
}

/// @nodoc
mixin _$MicrobialTestResultDto {
  String get sampleType => throw _privateConstructorUsedError;
  String get category =>
      throw _privateConstructorUsedError; // Susceptible | Intermediate | Resistant
  NamedRefDto? get pathogen => throw _privateConstructorUsedError;
  List<AntibioticRefDto> get antibiotics => throw _privateConstructorUsedError;

  /// Serializes this MicrobialTestResultDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MicrobialTestResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MicrobialTestResultDtoCopyWith<MicrobialTestResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MicrobialTestResultDtoCopyWith<$Res> {
  factory $MicrobialTestResultDtoCopyWith(
    MicrobialTestResultDto value,
    $Res Function(MicrobialTestResultDto) then,
  ) = _$MicrobialTestResultDtoCopyWithImpl<$Res, MicrobialTestResultDto>;
  @useResult
  $Res call({
    String sampleType,
    String category,
    NamedRefDto? pathogen,
    List<AntibioticRefDto> antibiotics,
  });

  $NamedRefDtoCopyWith<$Res>? get pathogen;
}

/// @nodoc
class _$MicrobialTestResultDtoCopyWithImpl<
  $Res,
  $Val extends MicrobialTestResultDto
>
    implements $MicrobialTestResultDtoCopyWith<$Res> {
  _$MicrobialTestResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MicrobialTestResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sampleType = null,
    Object? category = null,
    Object? pathogen = freezed,
    Object? antibiotics = null,
  }) {
    return _then(
      _value.copyWith(
            sampleType: null == sampleType
                ? _value.sampleType
                : sampleType // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            pathogen: freezed == pathogen
                ? _value.pathogen
                : pathogen // ignore: cast_nullable_to_non_nullable
                      as NamedRefDto?,
            antibiotics: null == antibiotics
                ? _value.antibiotics
                : antibiotics // ignore: cast_nullable_to_non_nullable
                      as List<AntibioticRefDto>,
          )
          as $Val,
    );
  }

  /// Create a copy of MicrobialTestResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NamedRefDtoCopyWith<$Res>? get pathogen {
    if (_value.pathogen == null) {
      return null;
    }

    return $NamedRefDtoCopyWith<$Res>(_value.pathogen!, (value) {
      return _then(_value.copyWith(pathogen: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MicrobialTestResultDtoImplCopyWith<$Res>
    implements $MicrobialTestResultDtoCopyWith<$Res> {
  factory _$$MicrobialTestResultDtoImplCopyWith(
    _$MicrobialTestResultDtoImpl value,
    $Res Function(_$MicrobialTestResultDtoImpl) then,
  ) = __$$MicrobialTestResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String sampleType,
    String category,
    NamedRefDto? pathogen,
    List<AntibioticRefDto> antibiotics,
  });

  @override
  $NamedRefDtoCopyWith<$Res>? get pathogen;
}

/// @nodoc
class __$$MicrobialTestResultDtoImplCopyWithImpl<$Res>
    extends
        _$MicrobialTestResultDtoCopyWithImpl<$Res, _$MicrobialTestResultDtoImpl>
    implements _$$MicrobialTestResultDtoImplCopyWith<$Res> {
  __$$MicrobialTestResultDtoImplCopyWithImpl(
    _$MicrobialTestResultDtoImpl _value,
    $Res Function(_$MicrobialTestResultDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MicrobialTestResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sampleType = null,
    Object? category = null,
    Object? pathogen = freezed,
    Object? antibiotics = null,
  }) {
    return _then(
      _$MicrobialTestResultDtoImpl(
        sampleType: null == sampleType
            ? _value.sampleType
            : sampleType // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        pathogen: freezed == pathogen
            ? _value.pathogen
            : pathogen // ignore: cast_nullable_to_non_nullable
                  as NamedRefDto?,
        antibiotics: null == antibiotics
            ? _value._antibiotics
            : antibiotics // ignore: cast_nullable_to_non_nullable
                  as List<AntibioticRefDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MicrobialTestResultDtoImpl implements _MicrobialTestResultDto {
  const _$MicrobialTestResultDtoImpl({
    this.sampleType = '',
    this.category = '',
    this.pathogen,
    final List<AntibioticRefDto> antibiotics = const [],
  }) : _antibiotics = antibiotics;

  factory _$MicrobialTestResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MicrobialTestResultDtoImplFromJson(json);

  @override
  @JsonKey()
  final String sampleType;
  @override
  @JsonKey()
  final String category;
  // Susceptible | Intermediate | Resistant
  @override
  final NamedRefDto? pathogen;
  final List<AntibioticRefDto> _antibiotics;
  @override
  @JsonKey()
  List<AntibioticRefDto> get antibiotics {
    if (_antibiotics is EqualUnmodifiableListView) return _antibiotics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_antibiotics);
  }

  @override
  String toString() {
    return 'MicrobialTestResultDto(sampleType: $sampleType, category: $category, pathogen: $pathogen, antibiotics: $antibiotics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MicrobialTestResultDtoImpl &&
            (identical(other.sampleType, sampleType) ||
                other.sampleType == sampleType) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.pathogen, pathogen) ||
                other.pathogen == pathogen) &&
            const DeepCollectionEquality().equals(
              other._antibiotics,
              _antibiotics,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sampleType,
    category,
    pathogen,
    const DeepCollectionEquality().hash(_antibiotics),
  );

  /// Create a copy of MicrobialTestResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MicrobialTestResultDtoImplCopyWith<_$MicrobialTestResultDtoImpl>
  get copyWith =>
      __$$MicrobialTestResultDtoImplCopyWithImpl<_$MicrobialTestResultDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MicrobialTestResultDtoImplToJson(this);
  }
}

abstract class _MicrobialTestResultDto implements MicrobialTestResultDto {
  const factory _MicrobialTestResultDto({
    final String sampleType,
    final String category,
    final NamedRefDto? pathogen,
    final List<AntibioticRefDto> antibiotics,
  }) = _$MicrobialTestResultDtoImpl;

  factory _MicrobialTestResultDto.fromJson(Map<String, dynamic> json) =
      _$MicrobialTestResultDtoImpl.fromJson;

  @override
  String get sampleType;
  @override
  String get category; // Susceptible | Intermediate | Resistant
  @override
  NamedRefDto? get pathogen;
  @override
  List<AntibioticRefDto> get antibiotics;

  /// Create a copy of MicrobialTestResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MicrobialTestResultDtoImplCopyWith<_$MicrobialTestResultDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CriterionRefDto _$CriterionRefDtoFromJson(Map<String, dynamic> json) {
  return _CriterionRefDto.fromJson(json);
}

/// @nodoc
mixin _$CriterionRefDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get formula => throw _privateConstructorUsedError;

  /// Serializes this CriterionRefDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CriterionRefDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CriterionRefDtoCopyWith<CriterionRefDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CriterionRefDtoCopyWith<$Res> {
  factory $CriterionRefDtoCopyWith(
    CriterionRefDto value,
    $Res Function(CriterionRefDto) then,
  ) = _$CriterionRefDtoCopyWithImpl<$Res, CriterionRefDto>;
  @useResult
  $Res call({String id, String name, String formula});
}

/// @nodoc
class _$CriterionRefDtoCopyWithImpl<$Res, $Val extends CriterionRefDto>
    implements $CriterionRefDtoCopyWith<$Res> {
  _$CriterionRefDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CriterionRefDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? formula = null}) {
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
            formula: null == formula
                ? _value.formula
                : formula // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CriterionRefDtoImplCopyWith<$Res>
    implements $CriterionRefDtoCopyWith<$Res> {
  factory _$$CriterionRefDtoImplCopyWith(
    _$CriterionRefDtoImpl value,
    $Res Function(_$CriterionRefDtoImpl) then,
  ) = __$$CriterionRefDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String formula});
}

/// @nodoc
class __$$CriterionRefDtoImplCopyWithImpl<$Res>
    extends _$CriterionRefDtoCopyWithImpl<$Res, _$CriterionRefDtoImpl>
    implements _$$CriterionRefDtoImplCopyWith<$Res> {
  __$$CriterionRefDtoImplCopyWithImpl(
    _$CriterionRefDtoImpl _value,
    $Res Function(_$CriterionRefDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CriterionRefDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? formula = null}) {
    return _then(
      _$CriterionRefDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        formula: null == formula
            ? _value.formula
            : formula // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CriterionRefDtoImpl implements _CriterionRefDto {
  const _$CriterionRefDtoImpl({
    this.id = '',
    this.name = '',
    this.formula = '',
  });

  factory _$CriterionRefDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CriterionRefDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String formula;

  @override
  String toString() {
    return 'CriterionRefDto(id: $id, name: $name, formula: $formula)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CriterionRefDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.formula, formula) || other.formula == formula));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, formula);

  /// Create a copy of CriterionRefDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CriterionRefDtoImplCopyWith<_$CriterionRefDtoImpl> get copyWith =>
      __$$CriterionRefDtoImplCopyWithImpl<_$CriterionRefDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CriterionRefDtoImplToJson(this);
  }
}

abstract class _CriterionRefDto implements CriterionRefDto {
  const factory _CriterionRefDto({
    final String id,
    final String name,
    final String formula,
  }) = _$CriterionRefDtoImpl;

  factory _CriterionRefDto.fromJson(Map<String, dynamic> json) =
      _$CriterionRefDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get formula;

  /// Create a copy of CriterionRefDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CriterionRefDtoImplCopyWith<_$CriterionRefDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TreatmentProtocolDto _$TreatmentProtocolDtoFromJson(Map<String, dynamic> json) {
  return _TreatmentProtocolDto.fromJson(json);
}

/// @nodoc
mixin _$TreatmentProtocolDto {
  String get id => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  String get treatmentSite => throw _privateConstructorUsedError;
  List<List<AntibioticRefDto>> get medicines =>
      throw _privateConstructorUsedError;
  List<NamedRefDto> get pathogens => throw _privateConstructorUsedError;
  List<CriterionRefDto> get criteria => throw _privateConstructorUsedError;

  /// Serializes this TreatmentProtocolDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TreatmentProtocolDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TreatmentProtocolDtoCopyWith<TreatmentProtocolDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreatmentProtocolDtoCopyWith<$Res> {
  factory $TreatmentProtocolDtoCopyWith(
    TreatmentProtocolDto value,
    $Res Function(TreatmentProtocolDto) then,
  ) = _$TreatmentProtocolDtoCopyWithImpl<$Res, TreatmentProtocolDto>;
  @useResult
  $Res call({
    String id,
    String severity,
    String treatmentSite,
    List<List<AntibioticRefDto>> medicines,
    List<NamedRefDto> pathogens,
    List<CriterionRefDto> criteria,
  });
}

/// @nodoc
class _$TreatmentProtocolDtoCopyWithImpl<
  $Res,
  $Val extends TreatmentProtocolDto
>
    implements $TreatmentProtocolDtoCopyWith<$Res> {
  _$TreatmentProtocolDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TreatmentProtocolDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? severity = null,
    Object? treatmentSite = null,
    Object? medicines = null,
    Object? pathogens = null,
    Object? criteria = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as String,
            treatmentSite: null == treatmentSite
                ? _value.treatmentSite
                : treatmentSite // ignore: cast_nullable_to_non_nullable
                      as String,
            medicines: null == medicines
                ? _value.medicines
                : medicines // ignore: cast_nullable_to_non_nullable
                      as List<List<AntibioticRefDto>>,
            pathogens: null == pathogens
                ? _value.pathogens
                : pathogens // ignore: cast_nullable_to_non_nullable
                      as List<NamedRefDto>,
            criteria: null == criteria
                ? _value.criteria
                : criteria // ignore: cast_nullable_to_non_nullable
                      as List<CriterionRefDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TreatmentProtocolDtoImplCopyWith<$Res>
    implements $TreatmentProtocolDtoCopyWith<$Res> {
  factory _$$TreatmentProtocolDtoImplCopyWith(
    _$TreatmentProtocolDtoImpl value,
    $Res Function(_$TreatmentProtocolDtoImpl) then,
  ) = __$$TreatmentProtocolDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String severity,
    String treatmentSite,
    List<List<AntibioticRefDto>> medicines,
    List<NamedRefDto> pathogens,
    List<CriterionRefDto> criteria,
  });
}

/// @nodoc
class __$$TreatmentProtocolDtoImplCopyWithImpl<$Res>
    extends _$TreatmentProtocolDtoCopyWithImpl<$Res, _$TreatmentProtocolDtoImpl>
    implements _$$TreatmentProtocolDtoImplCopyWith<$Res> {
  __$$TreatmentProtocolDtoImplCopyWithImpl(
    _$TreatmentProtocolDtoImpl _value,
    $Res Function(_$TreatmentProtocolDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TreatmentProtocolDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? severity = null,
    Object? treatmentSite = null,
    Object? medicines = null,
    Object? pathogens = null,
    Object? criteria = null,
  }) {
    return _then(
      _$TreatmentProtocolDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String,
        treatmentSite: null == treatmentSite
            ? _value.treatmentSite
            : treatmentSite // ignore: cast_nullable_to_non_nullable
                  as String,
        medicines: null == medicines
            ? _value._medicines
            : medicines // ignore: cast_nullable_to_non_nullable
                  as List<List<AntibioticRefDto>>,
        pathogens: null == pathogens
            ? _value._pathogens
            : pathogens // ignore: cast_nullable_to_non_nullable
                  as List<NamedRefDto>,
        criteria: null == criteria
            ? _value._criteria
            : criteria // ignore: cast_nullable_to_non_nullable
                  as List<CriterionRefDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TreatmentProtocolDtoImpl implements _TreatmentProtocolDto {
  const _$TreatmentProtocolDtoImpl({
    this.id = '',
    this.severity = '',
    this.treatmentSite = '',
    final List<List<AntibioticRefDto>> medicines = const [],
    final List<NamedRefDto> pathogens = const [],
    final List<CriterionRefDto> criteria = const [],
  }) : _medicines = medicines,
       _pathogens = pathogens,
       _criteria = criteria;

  factory _$TreatmentProtocolDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreatmentProtocolDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String severity;
  @override
  @JsonKey()
  final String treatmentSite;
  final List<List<AntibioticRefDto>> _medicines;
  @override
  @JsonKey()
  List<List<AntibioticRefDto>> get medicines {
    if (_medicines is EqualUnmodifiableListView) return _medicines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medicines);
  }

  final List<NamedRefDto> _pathogens;
  @override
  @JsonKey()
  List<NamedRefDto> get pathogens {
    if (_pathogens is EqualUnmodifiableListView) return _pathogens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pathogens);
  }

  final List<CriterionRefDto> _criteria;
  @override
  @JsonKey()
  List<CriterionRefDto> get criteria {
    if (_criteria is EqualUnmodifiableListView) return _criteria;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_criteria);
  }

  @override
  String toString() {
    return 'TreatmentProtocolDto(id: $id, severity: $severity, treatmentSite: $treatmentSite, medicines: $medicines, pathogens: $pathogens, criteria: $criteria)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreatmentProtocolDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.treatmentSite, treatmentSite) ||
                other.treatmentSite == treatmentSite) &&
            const DeepCollectionEquality().equals(
              other._medicines,
              _medicines,
            ) &&
            const DeepCollectionEquality().equals(
              other._pathogens,
              _pathogens,
            ) &&
            const DeepCollectionEquality().equals(other._criteria, _criteria));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    severity,
    treatmentSite,
    const DeepCollectionEquality().hash(_medicines),
    const DeepCollectionEquality().hash(_pathogens),
    const DeepCollectionEquality().hash(_criteria),
  );

  /// Create a copy of TreatmentProtocolDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TreatmentProtocolDtoImplCopyWith<_$TreatmentProtocolDtoImpl>
  get copyWith =>
      __$$TreatmentProtocolDtoImplCopyWithImpl<_$TreatmentProtocolDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TreatmentProtocolDtoImplToJson(this);
  }
}

abstract class _TreatmentProtocolDto implements TreatmentProtocolDto {
  const factory _TreatmentProtocolDto({
    final String id,
    final String severity,
    final String treatmentSite,
    final List<List<AntibioticRefDto>> medicines,
    final List<NamedRefDto> pathogens,
    final List<CriterionRefDto> criteria,
  }) = _$TreatmentProtocolDtoImpl;

  factory _TreatmentProtocolDto.fromJson(Map<String, dynamic> json) =
      _$TreatmentProtocolDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get severity;
  @override
  String get treatmentSite;
  @override
  List<List<AntibioticRefDto>> get medicines;
  @override
  List<NamedRefDto> get pathogens;
  @override
  List<CriterionRefDto> get criteria;

  /// Create a copy of TreatmentProtocolDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TreatmentProtocolDtoImplCopyWith<_$TreatmentProtocolDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiagnoseResultDto _$DiagnoseResultDtoFromJson(Map<String, dynamic> json) {
  return _DiagnoseResultDto.fromJson(json);
}

/// @nodoc
mixin _$DiagnoseResultDto {
  String get diagnosisId => throw _privateConstructorUsedError;
  String get severity =>
      throw _privateConstructorUsedError; // Mild | Moderate | Severe
  String get treatmentSite =>
      throw _privateConstructorUsedError; // Outpatient | Inpatient | IntensiveCareUnit
  List<NamedRefDto> get worthSuspected => throw _privateConstructorUsedError;
  List<NamedRefDto> get heavySuspected => throw _privateConstructorUsedError;
  List<EvidenceDto> get evidences => throw _privateConstructorUsedError;
  List<VariableRefDto> get missingVariables =>
      throw _privateConstructorUsedError;
  bool get isPatientPregnantOrInLactationPhase =>
      throw _privateConstructorUsedError;
  double? get egfr => throw _privateConstructorUsedError;
  List<String> get otherInfections => throw _privateConstructorUsedError;
  AllergyResultDto? get allergy => throw _privateConstructorUsedError;
  List<MetricsSeverityDto> get metricsSeverityDiagnosis =>
      throw _privateConstructorUsedError;
  List<MicrobialTestResultDto> get microbialTestResults =>
      throw _privateConstructorUsedError;
  List<TreatmentProtocolDto> get protocols =>
      throw _privateConstructorUsedError;

  /// Raw `data` snapshot of the response, echoed back verbatim to
  /// `POST /diagnose/confirm-treatment` (the backend takes it as
  /// `JsonElement` and must not receive a re-serialized subset).
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? get rawJson => throw _privateConstructorUsedError;

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
    String diagnosisId,
    String severity,
    String treatmentSite,
    List<NamedRefDto> worthSuspected,
    List<NamedRefDto> heavySuspected,
    List<EvidenceDto> evidences,
    List<VariableRefDto> missingVariables,
    bool isPatientPregnantOrInLactationPhase,
    double? egfr,
    List<String> otherInfections,
    AllergyResultDto? allergy,
    List<MetricsSeverityDto> metricsSeverityDiagnosis,
    List<MicrobialTestResultDto> microbialTestResults,
    List<TreatmentProtocolDto> protocols,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Map<String, dynamic>? rawJson,
  });

  $AllergyResultDtoCopyWith<$Res>? get allergy;
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
    Object? diagnosisId = null,
    Object? severity = null,
    Object? treatmentSite = null,
    Object? worthSuspected = null,
    Object? heavySuspected = null,
    Object? evidences = null,
    Object? missingVariables = null,
    Object? isPatientPregnantOrInLactationPhase = null,
    Object? egfr = freezed,
    Object? otherInfections = null,
    Object? allergy = freezed,
    Object? metricsSeverityDiagnosis = null,
    Object? microbialTestResults = null,
    Object? protocols = null,
    Object? rawJson = freezed,
  }) {
    return _then(
      _value.copyWith(
            diagnosisId: null == diagnosisId
                ? _value.diagnosisId
                : diagnosisId // ignore: cast_nullable_to_non_nullable
                      as String,
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
            isPatientPregnantOrInLactationPhase:
                null == isPatientPregnantOrInLactationPhase
                ? _value.isPatientPregnantOrInLactationPhase
                : isPatientPregnantOrInLactationPhase // ignore: cast_nullable_to_non_nullable
                      as bool,
            egfr: freezed == egfr
                ? _value.egfr
                : egfr // ignore: cast_nullable_to_non_nullable
                      as double?,
            otherInfections: null == otherInfections
                ? _value.otherInfections
                : otherInfections // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            allergy: freezed == allergy
                ? _value.allergy
                : allergy // ignore: cast_nullable_to_non_nullable
                      as AllergyResultDto?,
            metricsSeverityDiagnosis: null == metricsSeverityDiagnosis
                ? _value.metricsSeverityDiagnosis
                : metricsSeverityDiagnosis // ignore: cast_nullable_to_non_nullable
                      as List<MetricsSeverityDto>,
            microbialTestResults: null == microbialTestResults
                ? _value.microbialTestResults
                : microbialTestResults // ignore: cast_nullable_to_non_nullable
                      as List<MicrobialTestResultDto>,
            protocols: null == protocols
                ? _value.protocols
                : protocols // ignore: cast_nullable_to_non_nullable
                      as List<TreatmentProtocolDto>,
            rawJson: freezed == rawJson
                ? _value.rawJson
                : rawJson // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }

  /// Create a copy of DiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AllergyResultDtoCopyWith<$Res>? get allergy {
    if (_value.allergy == null) {
      return null;
    }

    return $AllergyResultDtoCopyWith<$Res>(_value.allergy!, (value) {
      return _then(_value.copyWith(allergy: value) as $Val);
    });
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
    String diagnosisId,
    String severity,
    String treatmentSite,
    List<NamedRefDto> worthSuspected,
    List<NamedRefDto> heavySuspected,
    List<EvidenceDto> evidences,
    List<VariableRefDto> missingVariables,
    bool isPatientPregnantOrInLactationPhase,
    double? egfr,
    List<String> otherInfections,
    AllergyResultDto? allergy,
    List<MetricsSeverityDto> metricsSeverityDiagnosis,
    List<MicrobialTestResultDto> microbialTestResults,
    List<TreatmentProtocolDto> protocols,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Map<String, dynamic>? rawJson,
  });

  @override
  $AllergyResultDtoCopyWith<$Res>? get allergy;
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
    Object? diagnosisId = null,
    Object? severity = null,
    Object? treatmentSite = null,
    Object? worthSuspected = null,
    Object? heavySuspected = null,
    Object? evidences = null,
    Object? missingVariables = null,
    Object? isPatientPregnantOrInLactationPhase = null,
    Object? egfr = freezed,
    Object? otherInfections = null,
    Object? allergy = freezed,
    Object? metricsSeverityDiagnosis = null,
    Object? microbialTestResults = null,
    Object? protocols = null,
    Object? rawJson = freezed,
  }) {
    return _then(
      _$DiagnoseResultDtoImpl(
        diagnosisId: null == diagnosisId
            ? _value.diagnosisId
            : diagnosisId // ignore: cast_nullable_to_non_nullable
                  as String,
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
        isPatientPregnantOrInLactationPhase:
            null == isPatientPregnantOrInLactationPhase
            ? _value.isPatientPregnantOrInLactationPhase
            : isPatientPregnantOrInLactationPhase // ignore: cast_nullable_to_non_nullable
                  as bool,
        egfr: freezed == egfr
            ? _value.egfr
            : egfr // ignore: cast_nullable_to_non_nullable
                  as double?,
        otherInfections: null == otherInfections
            ? _value._otherInfections
            : otherInfections // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        allergy: freezed == allergy
            ? _value.allergy
            : allergy // ignore: cast_nullable_to_non_nullable
                  as AllergyResultDto?,
        metricsSeverityDiagnosis: null == metricsSeverityDiagnosis
            ? _value._metricsSeverityDiagnosis
            : metricsSeverityDiagnosis // ignore: cast_nullable_to_non_nullable
                  as List<MetricsSeverityDto>,
        microbialTestResults: null == microbialTestResults
            ? _value._microbialTestResults
            : microbialTestResults // ignore: cast_nullable_to_non_nullable
                  as List<MicrobialTestResultDto>,
        protocols: null == protocols
            ? _value._protocols
            : protocols // ignore: cast_nullable_to_non_nullable
                  as List<TreatmentProtocolDto>,
        rawJson: freezed == rawJson
            ? _value._rawJson
            : rawJson // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiagnoseResultDtoImpl implements _DiagnoseResultDto {
  const _$DiagnoseResultDtoImpl({
    this.diagnosisId = '',
    required this.severity,
    required this.treatmentSite,
    final List<NamedRefDto> worthSuspected = const [],
    final List<NamedRefDto> heavySuspected = const [],
    final List<EvidenceDto> evidences = const [],
    final List<VariableRefDto> missingVariables = const [],
    this.isPatientPregnantOrInLactationPhase = false,
    this.egfr,
    final List<String> otherInfections = const [],
    this.allergy,
    final List<MetricsSeverityDto> metricsSeverityDiagnosis = const [],
    final List<MicrobialTestResultDto> microbialTestResults = const [],
    final List<TreatmentProtocolDto> protocols = const [],
    @JsonKey(includeFromJson: false, includeToJson: false)
    final Map<String, dynamic>? rawJson,
  }) : _worthSuspected = worthSuspected,
       _heavySuspected = heavySuspected,
       _evidences = evidences,
       _missingVariables = missingVariables,
       _otherInfections = otherInfections,
       _metricsSeverityDiagnosis = metricsSeverityDiagnosis,
       _microbialTestResults = microbialTestResults,
       _protocols = protocols,
       _rawJson = rawJson;

  factory _$DiagnoseResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiagnoseResultDtoImplFromJson(json);

  @override
  @JsonKey()
  final String diagnosisId;
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

  @override
  @JsonKey()
  final bool isPatientPregnantOrInLactationPhase;
  @override
  final double? egfr;
  final List<String> _otherInfections;
  @override
  @JsonKey()
  List<String> get otherInfections {
    if (_otherInfections is EqualUnmodifiableListView) return _otherInfections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_otherInfections);
  }

  @override
  final AllergyResultDto? allergy;
  final List<MetricsSeverityDto> _metricsSeverityDiagnosis;
  @override
  @JsonKey()
  List<MetricsSeverityDto> get metricsSeverityDiagnosis {
    if (_metricsSeverityDiagnosis is EqualUnmodifiableListView)
      return _metricsSeverityDiagnosis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_metricsSeverityDiagnosis);
  }

  final List<MicrobialTestResultDto> _microbialTestResults;
  @override
  @JsonKey()
  List<MicrobialTestResultDto> get microbialTestResults {
    if (_microbialTestResults is EqualUnmodifiableListView)
      return _microbialTestResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_microbialTestResults);
  }

  final List<TreatmentProtocolDto> _protocols;
  @override
  @JsonKey()
  List<TreatmentProtocolDto> get protocols {
    if (_protocols is EqualUnmodifiableListView) return _protocols;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_protocols);
  }

  /// Raw `data` snapshot of the response, echoed back verbatim to
  /// `POST /diagnose/confirm-treatment` (the backend takes it as
  /// `JsonElement` and must not receive a re-serialized subset).
  final Map<String, dynamic>? _rawJson;

  /// Raw `data` snapshot of the response, echoed back verbatim to
  /// `POST /diagnose/confirm-treatment` (the backend takes it as
  /// `JsonElement` and must not receive a re-serialized subset).
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? get rawJson {
    final value = _rawJson;
    if (value == null) return null;
    if (_rawJson is EqualUnmodifiableMapView) return _rawJson;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'DiagnoseResultDto(diagnosisId: $diagnosisId, severity: $severity, treatmentSite: $treatmentSite, worthSuspected: $worthSuspected, heavySuspected: $heavySuspected, evidences: $evidences, missingVariables: $missingVariables, isPatientPregnantOrInLactationPhase: $isPatientPregnantOrInLactationPhase, egfr: $egfr, otherInfections: $otherInfections, allergy: $allergy, metricsSeverityDiagnosis: $metricsSeverityDiagnosis, microbialTestResults: $microbialTestResults, protocols: $protocols, rawJson: $rawJson)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagnoseResultDtoImpl &&
            (identical(other.diagnosisId, diagnosisId) ||
                other.diagnosisId == diagnosisId) &&
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
            (identical(
                  other.isPatientPregnantOrInLactationPhase,
                  isPatientPregnantOrInLactationPhase,
                ) ||
                other.isPatientPregnantOrInLactationPhase ==
                    isPatientPregnantOrInLactationPhase) &&
            (identical(other.egfr, egfr) || other.egfr == egfr) &&
            const DeepCollectionEquality().equals(
              other._otherInfections,
              _otherInfections,
            ) &&
            (identical(other.allergy, allergy) || other.allergy == allergy) &&
            const DeepCollectionEquality().equals(
              other._metricsSeverityDiagnosis,
              _metricsSeverityDiagnosis,
            ) &&
            const DeepCollectionEquality().equals(
              other._microbialTestResults,
              _microbialTestResults,
            ) &&
            const DeepCollectionEquality().equals(
              other._protocols,
              _protocols,
            ) &&
            const DeepCollectionEquality().equals(other._rawJson, _rawJson));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    diagnosisId,
    severity,
    treatmentSite,
    const DeepCollectionEquality().hash(_worthSuspected),
    const DeepCollectionEquality().hash(_heavySuspected),
    const DeepCollectionEquality().hash(_evidences),
    const DeepCollectionEquality().hash(_missingVariables),
    isPatientPregnantOrInLactationPhase,
    egfr,
    const DeepCollectionEquality().hash(_otherInfections),
    allergy,
    const DeepCollectionEquality().hash(_metricsSeverityDiagnosis),
    const DeepCollectionEquality().hash(_microbialTestResults),
    const DeepCollectionEquality().hash(_protocols),
    const DeepCollectionEquality().hash(_rawJson),
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
    final String diagnosisId,
    required final String severity,
    required final String treatmentSite,
    final List<NamedRefDto> worthSuspected,
    final List<NamedRefDto> heavySuspected,
    final List<EvidenceDto> evidences,
    final List<VariableRefDto> missingVariables,
    final bool isPatientPregnantOrInLactationPhase,
    final double? egfr,
    final List<String> otherInfections,
    final AllergyResultDto? allergy,
    final List<MetricsSeverityDto> metricsSeverityDiagnosis,
    final List<MicrobialTestResultDto> microbialTestResults,
    final List<TreatmentProtocolDto> protocols,
    @JsonKey(includeFromJson: false, includeToJson: false)
    final Map<String, dynamic>? rawJson,
  }) = _$DiagnoseResultDtoImpl;

  factory _DiagnoseResultDto.fromJson(Map<String, dynamic> json) =
      _$DiagnoseResultDtoImpl.fromJson;

  @override
  String get diagnosisId;
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
  bool get isPatientPregnantOrInLactationPhase;
  @override
  double? get egfr;
  @override
  List<String> get otherInfections;
  @override
  AllergyResultDto? get allergy;
  @override
  List<MetricsSeverityDto> get metricsSeverityDiagnosis;
  @override
  List<MicrobialTestResultDto> get microbialTestResults;
  @override
  List<TreatmentProtocolDto> get protocols;

  /// Raw `data` snapshot of the response, echoed back verbatim to
  /// `POST /diagnose/confirm-treatment` (the backend takes it as
  /// `JsonElement` and must not receive a re-serialized subset).
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? get rawJson;

  /// Create a copy of DiagnoseResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiagnoseResultDtoImplCopyWith<_$DiagnoseResultDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AntibioticRefDto _$AntibioticRefDtoFromJson(Map<String, dynamic> json) {
  return _AntibioticRefDto.fromJson(json);
}

/// @nodoc
mixin _$AntibioticRefDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get classification => throw _privateConstructorUsedError;

  /// Serializes this AntibioticRefDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AntibioticRefDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AntibioticRefDtoCopyWith<AntibioticRefDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AntibioticRefDtoCopyWith<$Res> {
  factory $AntibioticRefDtoCopyWith(
    AntibioticRefDto value,
    $Res Function(AntibioticRefDto) then,
  ) = _$AntibioticRefDtoCopyWithImpl<$Res, AntibioticRefDto>;
  @useResult
  $Res call({String id, String name, String classification});
}

/// @nodoc
class _$AntibioticRefDtoCopyWithImpl<$Res, $Val extends AntibioticRefDto>
    implements $AntibioticRefDtoCopyWith<$Res> {
  _$AntibioticRefDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AntibioticRefDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? classification = null,
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
            classification: null == classification
                ? _value.classification
                : classification // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AntibioticRefDtoImplCopyWith<$Res>
    implements $AntibioticRefDtoCopyWith<$Res> {
  factory _$$AntibioticRefDtoImplCopyWith(
    _$AntibioticRefDtoImpl value,
    $Res Function(_$AntibioticRefDtoImpl) then,
  ) = __$$AntibioticRefDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String classification});
}

/// @nodoc
class __$$AntibioticRefDtoImplCopyWithImpl<$Res>
    extends _$AntibioticRefDtoCopyWithImpl<$Res, _$AntibioticRefDtoImpl>
    implements _$$AntibioticRefDtoImplCopyWith<$Res> {
  __$$AntibioticRefDtoImplCopyWithImpl(
    _$AntibioticRefDtoImpl _value,
    $Res Function(_$AntibioticRefDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AntibioticRefDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? classification = null,
  }) {
    return _then(
      _$AntibioticRefDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        classification: null == classification
            ? _value.classification
            : classification // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AntibioticRefDtoImpl implements _AntibioticRefDto {
  const _$AntibioticRefDtoImpl({
    required this.id,
    required this.name,
    this.classification = '',
  });

  factory _$AntibioticRefDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AntibioticRefDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String classification;

  @override
  String toString() {
    return 'AntibioticRefDto(id: $id, name: $name, classification: $classification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AntibioticRefDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.classification, classification) ||
                other.classification == classification));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, classification);

  /// Create a copy of AntibioticRefDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AntibioticRefDtoImplCopyWith<_$AntibioticRefDtoImpl> get copyWith =>
      __$$AntibioticRefDtoImplCopyWithImpl<_$AntibioticRefDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AntibioticRefDtoImplToJson(this);
  }
}

abstract class _AntibioticRefDto implements AntibioticRefDto {
  const factory _AntibioticRefDto({
    required final String id,
    required final String name,
    final String classification,
  }) = _$AntibioticRefDtoImpl;

  factory _AntibioticRefDto.fromJson(Map<String, dynamic> json) =
      _$AntibioticRefDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get classification;

  /// Create a copy of AntibioticRefDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AntibioticRefDtoImplCopyWith<_$AntibioticRefDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AllergyResultDto _$AllergyResultDtoFromJson(Map<String, dynamic> json) {
  return _AllergyResultDto.fromJson(json);
}

/// @nodoc
mixin _$AllergyResultDto {
  String get type =>
      throw _privateConstructorUsedError; // Yes | No | NonRegisteredAntibiotic | Unknown
  List<AntibioticRefDto> get allergicAntibiotics =>
      throw _privateConstructorUsedError;
  String? get otherAllergy => throw _privateConstructorUsedError;

  /// Serializes this AllergyResultDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllergyResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllergyResultDtoCopyWith<AllergyResultDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllergyResultDtoCopyWith<$Res> {
  factory $AllergyResultDtoCopyWith(
    AllergyResultDto value,
    $Res Function(AllergyResultDto) then,
  ) = _$AllergyResultDtoCopyWithImpl<$Res, AllergyResultDto>;
  @useResult
  $Res call({
    String type,
    List<AntibioticRefDto> allergicAntibiotics,
    String? otherAllergy,
  });
}

/// @nodoc
class _$AllergyResultDtoCopyWithImpl<$Res, $Val extends AllergyResultDto>
    implements $AllergyResultDtoCopyWith<$Res> {
  _$AllergyResultDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllergyResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? allergicAntibiotics = null,
    Object? otherAllergy = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            allergicAntibiotics: null == allergicAntibiotics
                ? _value.allergicAntibiotics
                : allergicAntibiotics // ignore: cast_nullable_to_non_nullable
                      as List<AntibioticRefDto>,
            otherAllergy: freezed == otherAllergy
                ? _value.otherAllergy
                : otherAllergy // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AllergyResultDtoImplCopyWith<$Res>
    implements $AllergyResultDtoCopyWith<$Res> {
  factory _$$AllergyResultDtoImplCopyWith(
    _$AllergyResultDtoImpl value,
    $Res Function(_$AllergyResultDtoImpl) then,
  ) = __$$AllergyResultDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    List<AntibioticRefDto> allergicAntibiotics,
    String? otherAllergy,
  });
}

/// @nodoc
class __$$AllergyResultDtoImplCopyWithImpl<$Res>
    extends _$AllergyResultDtoCopyWithImpl<$Res, _$AllergyResultDtoImpl>
    implements _$$AllergyResultDtoImplCopyWith<$Res> {
  __$$AllergyResultDtoImplCopyWithImpl(
    _$AllergyResultDtoImpl _value,
    $Res Function(_$AllergyResultDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AllergyResultDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? allergicAntibiotics = null,
    Object? otherAllergy = freezed,
  }) {
    return _then(
      _$AllergyResultDtoImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        allergicAntibiotics: null == allergicAntibiotics
            ? _value._allergicAntibiotics
            : allergicAntibiotics // ignore: cast_nullable_to_non_nullable
                  as List<AntibioticRefDto>,
        otherAllergy: freezed == otherAllergy
            ? _value.otherAllergy
            : otherAllergy // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AllergyResultDtoImpl implements _AllergyResultDto {
  const _$AllergyResultDtoImpl({
    this.type = 'Unknown',
    final List<AntibioticRefDto> allergicAntibiotics = const [],
    this.otherAllergy,
  }) : _allergicAntibiotics = allergicAntibiotics;

  factory _$AllergyResultDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllergyResultDtoImplFromJson(json);

  @override
  @JsonKey()
  final String type;
  // Yes | No | NonRegisteredAntibiotic | Unknown
  final List<AntibioticRefDto> _allergicAntibiotics;
  // Yes | No | NonRegisteredAntibiotic | Unknown
  @override
  @JsonKey()
  List<AntibioticRefDto> get allergicAntibiotics {
    if (_allergicAntibiotics is EqualUnmodifiableListView)
      return _allergicAntibiotics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergicAntibiotics);
  }

  @override
  final String? otherAllergy;

  @override
  String toString() {
    return 'AllergyResultDto(type: $type, allergicAntibiotics: $allergicAntibiotics, otherAllergy: $otherAllergy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllergyResultDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._allergicAntibiotics,
              _allergicAntibiotics,
            ) &&
            (identical(other.otherAllergy, otherAllergy) ||
                other.otherAllergy == otherAllergy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    const DeepCollectionEquality().hash(_allergicAntibiotics),
    otherAllergy,
  );

  /// Create a copy of AllergyResultDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllergyResultDtoImplCopyWith<_$AllergyResultDtoImpl> get copyWith =>
      __$$AllergyResultDtoImplCopyWithImpl<_$AllergyResultDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AllergyResultDtoImplToJson(this);
  }
}

abstract class _AllergyResultDto implements AllergyResultDto {
  const factory _AllergyResultDto({
    final String type,
    final List<AntibioticRefDto> allergicAntibiotics,
    final String? otherAllergy,
  }) = _$AllergyResultDtoImpl;

  factory _AllergyResultDto.fromJson(Map<String, dynamic> json) =
      _$AllergyResultDtoImpl.fromJson;

  @override
  String get type; // Yes | No | NonRegisteredAntibiotic | Unknown
  @override
  List<AntibioticRefDto> get allergicAntibiotics;
  @override
  String? get otherAllergy;

  /// Create a copy of AllergyResultDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllergyResultDtoImplCopyWith<_$AllergyResultDtoImpl> get copyWith =>
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
  String get id => throw _privateConstructorUsedError;
  String get routeOfAdministration => throw _privateConstructorUsedError;
  String get dose => throw _privateConstructorUsedError;

  /// CrCl adjustment range; `null` means this is the standard dose.
  RangeDto? get crcl => throw _privateConstructorUsedError;

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
  $Res call({
    String id,
    String routeOfAdministration,
    String dose,
    RangeDto? crcl,
  });

  $RangeDtoCopyWith<$Res>? get crcl;
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
  $Res call({
    Object? id = null,
    Object? routeOfAdministration = null,
    Object? dose = null,
    Object? crcl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            routeOfAdministration: null == routeOfAdministration
                ? _value.routeOfAdministration
                : routeOfAdministration // ignore: cast_nullable_to_non_nullable
                      as String,
            dose: null == dose
                ? _value.dose
                : dose // ignore: cast_nullable_to_non_nullable
                      as String,
            crcl: freezed == crcl
                ? _value.crcl
                : crcl // ignore: cast_nullable_to_non_nullable
                      as RangeDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of DosageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RangeDtoCopyWith<$Res>? get crcl {
    if (_value.crcl == null) {
      return null;
    }

    return $RangeDtoCopyWith<$Res>(_value.crcl!, (value) {
      return _then(_value.copyWith(crcl: value) as $Val);
    });
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
  $Res call({
    String id,
    String routeOfAdministration,
    String dose,
    RangeDto? crcl,
  });

  @override
  $RangeDtoCopyWith<$Res>? get crcl;
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
  $Res call({
    Object? id = null,
    Object? routeOfAdministration = null,
    Object? dose = null,
    Object? crcl = freezed,
  }) {
    return _then(
      _$DosageDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        routeOfAdministration: null == routeOfAdministration
            ? _value.routeOfAdministration
            : routeOfAdministration // ignore: cast_nullable_to_non_nullable
                  as String,
        dose: null == dose
            ? _value.dose
            : dose // ignore: cast_nullable_to_non_nullable
                  as String,
        crcl: freezed == crcl
            ? _value.crcl
            : crcl // ignore: cast_nullable_to_non_nullable
                  as RangeDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DosageDtoImpl implements _DosageDto {
  const _$DosageDtoImpl({
    this.id = '',
    required this.routeOfAdministration,
    required this.dose,
    this.crcl,
  });

  factory _$DosageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DosageDtoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  final String routeOfAdministration;
  @override
  final String dose;

  /// CrCl adjustment range; `null` means this is the standard dose.
  @override
  final RangeDto? crcl;

  @override
  String toString() {
    return 'DosageDto(id: $id, routeOfAdministration: $routeOfAdministration, dose: $dose, crcl: $crcl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DosageDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.routeOfAdministration, routeOfAdministration) ||
                other.routeOfAdministration == routeOfAdministration) &&
            (identical(other.dose, dose) || other.dose == dose) &&
            (identical(other.crcl, crcl) || other.crcl == crcl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, routeOfAdministration, dose, crcl);

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
    final String id,
    required final String routeOfAdministration,
    required final String dose,
    final RangeDto? crcl,
  }) = _$DosageDtoImpl;

  factory _DosageDto.fromJson(Map<String, dynamic> json) =
      _$DosageDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get routeOfAdministration;
  @override
  String get dose;

  /// CrCl adjustment range; `null` means this is the standard dose.
  @override
  RangeDto? get crcl;

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
