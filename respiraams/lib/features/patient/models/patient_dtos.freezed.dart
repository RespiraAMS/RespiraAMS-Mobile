// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PatientListItemDto _$PatientListItemDtoFromJson(Map<String, dynamic> json) {
  return _PatientListItemDto.fromJson(json);
}

/// @nodoc
mixin _$PatientListItemDto {
  String get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get dateOfBirth => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;

  /// `Male` | `Female`.
  String get gender => throw _privateConstructorUsedError;
  String get medicalRecordCode => throw _privateConstructorUsedError;
  PatientStatusDto get treatmentOutcome => throw _privateConstructorUsedError;

  /// Serializes this PatientListItemDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatientListItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientListItemDtoCopyWith<PatientListItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientListItemDtoCopyWith<$Res> {
  factory $PatientListItemDtoCopyWith(
    PatientListItemDto value,
    $Res Function(PatientListItemDto) then,
  ) = _$PatientListItemDtoCopyWithImpl<$Res, PatientListItemDto>;
  @useResult
  $Res call({
    String id,
    String fullName,
    String dateOfBirth,
    int age,
    String gender,
    String medicalRecordCode,
    PatientStatusDto treatmentOutcome,
  });
}

/// @nodoc
class _$PatientListItemDtoCopyWithImpl<$Res, $Val extends PatientListItemDto>
    implements $PatientListItemDtoCopyWith<$Res> {
  _$PatientListItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientListItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? dateOfBirth = null,
    Object? age = null,
    Object? gender = null,
    Object? medicalRecordCode = null,
    Object? treatmentOutcome = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            dateOfBirth: null == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as String,
            age: null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            medicalRecordCode: null == medicalRecordCode
                ? _value.medicalRecordCode
                : medicalRecordCode // ignore: cast_nullable_to_non_nullable
                      as String,
            treatmentOutcome: null == treatmentOutcome
                ? _value.treatmentOutcome
                : treatmentOutcome // ignore: cast_nullable_to_non_nullable
                      as PatientStatusDto,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PatientListItemDtoImplCopyWith<$Res>
    implements $PatientListItemDtoCopyWith<$Res> {
  factory _$$PatientListItemDtoImplCopyWith(
    _$PatientListItemDtoImpl value,
    $Res Function(_$PatientListItemDtoImpl) then,
  ) = __$$PatientListItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fullName,
    String dateOfBirth,
    int age,
    String gender,
    String medicalRecordCode,
    PatientStatusDto treatmentOutcome,
  });
}

/// @nodoc
class __$$PatientListItemDtoImplCopyWithImpl<$Res>
    extends _$PatientListItemDtoCopyWithImpl<$Res, _$PatientListItemDtoImpl>
    implements _$$PatientListItemDtoImplCopyWith<$Res> {
  __$$PatientListItemDtoImplCopyWithImpl(
    _$PatientListItemDtoImpl _value,
    $Res Function(_$PatientListItemDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientListItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? dateOfBirth = null,
    Object? age = null,
    Object? gender = null,
    Object? medicalRecordCode = null,
    Object? treatmentOutcome = null,
  }) {
    return _then(
      _$PatientListItemDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        dateOfBirth: null == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as String,
        age: null == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        medicalRecordCode: null == medicalRecordCode
            ? _value.medicalRecordCode
            : medicalRecordCode // ignore: cast_nullable_to_non_nullable
                  as String,
        treatmentOutcome: null == treatmentOutcome
            ? _value.treatmentOutcome
            : treatmentOutcome // ignore: cast_nullable_to_non_nullable
                  as PatientStatusDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientListItemDtoImpl implements _PatientListItemDto {
  const _$PatientListItemDtoImpl({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.age,
    required this.gender,
    required this.medicalRecordCode,
    required this.treatmentOutcome,
  });

  factory _$PatientListItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientListItemDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String fullName;
  @override
  final String dateOfBirth;
  @override
  final int age;

  /// `Male` | `Female`.
  @override
  final String gender;
  @override
  final String medicalRecordCode;
  @override
  final PatientStatusDto treatmentOutcome;

  @override
  String toString() {
    return 'PatientListItemDto(id: $id, fullName: $fullName, dateOfBirth: $dateOfBirth, age: $age, gender: $gender, medicalRecordCode: $medicalRecordCode, treatmentOutcome: $treatmentOutcome)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientListItemDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.medicalRecordCode, medicalRecordCode) ||
                other.medicalRecordCode == medicalRecordCode) &&
            (identical(other.treatmentOutcome, treatmentOutcome) ||
                other.treatmentOutcome == treatmentOutcome));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    dateOfBirth,
    age,
    gender,
    medicalRecordCode,
    treatmentOutcome,
  );

  /// Create a copy of PatientListItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientListItemDtoImplCopyWith<_$PatientListItemDtoImpl> get copyWith =>
      __$$PatientListItemDtoImplCopyWithImpl<_$PatientListItemDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientListItemDtoImplToJson(this);
  }
}

abstract class _PatientListItemDto implements PatientListItemDto {
  const factory _PatientListItemDto({
    required final String id,
    required final String fullName,
    required final String dateOfBirth,
    required final int age,
    required final String gender,
    required final String medicalRecordCode,
    required final PatientStatusDto treatmentOutcome,
  }) = _$PatientListItemDtoImpl;

  factory _PatientListItemDto.fromJson(Map<String, dynamic> json) =
      _$PatientListItemDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get fullName;
  @override
  String get dateOfBirth;
  @override
  int get age;

  /// `Male` | `Female`.
  @override
  String get gender;
  @override
  String get medicalRecordCode;
  @override
  PatientStatusDto get treatmentOutcome;

  /// Create a copy of PatientListItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientListItemDtoImplCopyWith<_$PatientListItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatedPatientDto _$CreatedPatientDtoFromJson(Map<String, dynamic> json) {
  return _CreatedPatientDto.fromJson(json);
}

/// @nodoc
mixin _$CreatedPatientDto {
  String get id => throw _privateConstructorUsedError;

  /// Serializes this CreatedPatientDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatedPatientDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatedPatientDtoCopyWith<CreatedPatientDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatedPatientDtoCopyWith<$Res> {
  factory $CreatedPatientDtoCopyWith(
    CreatedPatientDto value,
    $Res Function(CreatedPatientDto) then,
  ) = _$CreatedPatientDtoCopyWithImpl<$Res, CreatedPatientDto>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$CreatedPatientDtoCopyWithImpl<$Res, $Val extends CreatedPatientDto>
    implements $CreatedPatientDtoCopyWith<$Res> {
  _$CreatedPatientDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatedPatientDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreatedPatientDtoImplCopyWith<$Res>
    implements $CreatedPatientDtoCopyWith<$Res> {
  factory _$$CreatedPatientDtoImplCopyWith(
    _$CreatedPatientDtoImpl value,
    $Res Function(_$CreatedPatientDtoImpl) then,
  ) = __$$CreatedPatientDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$CreatedPatientDtoImplCopyWithImpl<$Res>
    extends _$CreatedPatientDtoCopyWithImpl<$Res, _$CreatedPatientDtoImpl>
    implements _$$CreatedPatientDtoImplCopyWith<$Res> {
  __$$CreatedPatientDtoImplCopyWithImpl(
    _$CreatedPatientDtoImpl _value,
    $Res Function(_$CreatedPatientDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreatedPatientDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$CreatedPatientDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatedPatientDtoImpl implements _CreatedPatientDto {
  const _$CreatedPatientDtoImpl({required this.id});

  factory _$CreatedPatientDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatedPatientDtoImplFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'CreatedPatientDto(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatedPatientDtoImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of CreatedPatientDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatedPatientDtoImplCopyWith<_$CreatedPatientDtoImpl> get copyWith =>
      __$$CreatedPatientDtoImplCopyWithImpl<_$CreatedPatientDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatedPatientDtoImplToJson(this);
  }
}

abstract class _CreatedPatientDto implements CreatedPatientDto {
  const factory _CreatedPatientDto({required final String id}) =
      _$CreatedPatientDtoImpl;

  factory _CreatedPatientDto.fromJson(Map<String, dynamic> json) =
      _$CreatedPatientDtoImpl.fromJson;

  @override
  String get id;

  /// Create a copy of CreatedPatientDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatedPatientDtoImplCopyWith<_$CreatedPatientDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NextOfKinItemDto _$NextOfKinItemDtoFromJson(Map<String, dynamic> json) {
  return _NextOfKinItemDto.fromJson(json);
}

/// @nodoc
mixin _$NextOfKinItemDto {
  String get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get relationship => throw _privateConstructorUsedError;

  /// Serializes this NextOfKinItemDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NextOfKinItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NextOfKinItemDtoCopyWith<NextOfKinItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NextOfKinItemDtoCopyWith<$Res> {
  factory $NextOfKinItemDtoCopyWith(
    NextOfKinItemDto value,
    $Res Function(NextOfKinItemDto) then,
  ) = _$NextOfKinItemDtoCopyWithImpl<$Res, NextOfKinItemDto>;
  @useResult
  $Res call({
    String id,
    String fullName,
    String phoneNumber,
    String relationship,
  });
}

/// @nodoc
class _$NextOfKinItemDtoCopyWithImpl<$Res, $Val extends NextOfKinItemDto>
    implements $NextOfKinItemDtoCopyWith<$Res> {
  _$NextOfKinItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NextOfKinItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? relationship = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            relationship: null == relationship
                ? _value.relationship
                : relationship // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NextOfKinItemDtoImplCopyWith<$Res>
    implements $NextOfKinItemDtoCopyWith<$Res> {
  factory _$$NextOfKinItemDtoImplCopyWith(
    _$NextOfKinItemDtoImpl value,
    $Res Function(_$NextOfKinItemDtoImpl) then,
  ) = __$$NextOfKinItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fullName,
    String phoneNumber,
    String relationship,
  });
}

/// @nodoc
class __$$NextOfKinItemDtoImplCopyWithImpl<$Res>
    extends _$NextOfKinItemDtoCopyWithImpl<$Res, _$NextOfKinItemDtoImpl>
    implements _$$NextOfKinItemDtoImplCopyWith<$Res> {
  __$$NextOfKinItemDtoImplCopyWithImpl(
    _$NextOfKinItemDtoImpl _value,
    $Res Function(_$NextOfKinItemDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NextOfKinItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? relationship = null,
  }) {
    return _then(
      _$NextOfKinItemDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        relationship: null == relationship
            ? _value.relationship
            : relationship // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NextOfKinItemDtoImpl implements _NextOfKinItemDto {
  const _$NextOfKinItemDtoImpl({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.relationship,
  });

  factory _$NextOfKinItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NextOfKinItemDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String fullName;
  @override
  final String phoneNumber;
  @override
  final String relationship;

  @override
  String toString() {
    return 'NextOfKinItemDto(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, relationship: $relationship)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NextOfKinItemDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, fullName, phoneNumber, relationship);

  /// Create a copy of NextOfKinItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NextOfKinItemDtoImplCopyWith<_$NextOfKinItemDtoImpl> get copyWith =>
      __$$NextOfKinItemDtoImplCopyWithImpl<_$NextOfKinItemDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NextOfKinItemDtoImplToJson(this);
  }
}

abstract class _NextOfKinItemDto implements NextOfKinItemDto {
  const factory _NextOfKinItemDto({
    required final String id,
    required final String fullName,
    required final String phoneNumber,
    required final String relationship,
  }) = _$NextOfKinItemDtoImpl;

  factory _NextOfKinItemDto.fromJson(Map<String, dynamic> json) =
      _$NextOfKinItemDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get fullName;
  @override
  String get phoneNumber;
  @override
  String get relationship;

  /// Create a copy of NextOfKinItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NextOfKinItemDtoImplCopyWith<_$NextOfKinItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TreatmentPlanItemDto _$TreatmentPlanItemDtoFromJson(Map<String, dynamic> json) {
  return _TreatmentPlanItemDto.fromJson(json);
}

/// @nodoc
mixin _$TreatmentPlanItemDto {
  String get id => throw _privateConstructorUsedError;

  /// `Adhere` | `NotAdhere` | `NotAdhereValid` | `NotAdhereInvalid`.
  String get adherenceState => throw _privateConstructorUsedError;

  /// `TreatmentPlanStatus` has no string enum converter on the backend,
  /// so it arrives as a number: `0` = InProgress, `1` = Closed.
  @JsonKey(fromJson: _treatmentPlanStatusFromJson)
  int get treatmentPlanStatus => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TreatmentPlanItemDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TreatmentPlanItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TreatmentPlanItemDtoCopyWith<TreatmentPlanItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreatmentPlanItemDtoCopyWith<$Res> {
  factory $TreatmentPlanItemDtoCopyWith(
    TreatmentPlanItemDto value,
    $Res Function(TreatmentPlanItemDto) then,
  ) = _$TreatmentPlanItemDtoCopyWithImpl<$Res, TreatmentPlanItemDto>;
  @useResult
  $Res call({
    String id,
    String adherenceState,
    @JsonKey(fromJson: _treatmentPlanStatusFromJson) int treatmentPlanStatus,
    String updatedAt,
  });
}

/// @nodoc
class _$TreatmentPlanItemDtoCopyWithImpl<
  $Res,
  $Val extends TreatmentPlanItemDto
>
    implements $TreatmentPlanItemDtoCopyWith<$Res> {
  _$TreatmentPlanItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TreatmentPlanItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? adherenceState = null,
    Object? treatmentPlanStatus = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            adherenceState: null == adherenceState
                ? _value.adherenceState
                : adherenceState // ignore: cast_nullable_to_non_nullable
                      as String,
            treatmentPlanStatus: null == treatmentPlanStatus
                ? _value.treatmentPlanStatus
                : treatmentPlanStatus // ignore: cast_nullable_to_non_nullable
                      as int,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TreatmentPlanItemDtoImplCopyWith<$Res>
    implements $TreatmentPlanItemDtoCopyWith<$Res> {
  factory _$$TreatmentPlanItemDtoImplCopyWith(
    _$TreatmentPlanItemDtoImpl value,
    $Res Function(_$TreatmentPlanItemDtoImpl) then,
  ) = __$$TreatmentPlanItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String adherenceState,
    @JsonKey(fromJson: _treatmentPlanStatusFromJson) int treatmentPlanStatus,
    String updatedAt,
  });
}

/// @nodoc
class __$$TreatmentPlanItemDtoImplCopyWithImpl<$Res>
    extends _$TreatmentPlanItemDtoCopyWithImpl<$Res, _$TreatmentPlanItemDtoImpl>
    implements _$$TreatmentPlanItemDtoImplCopyWith<$Res> {
  __$$TreatmentPlanItemDtoImplCopyWithImpl(
    _$TreatmentPlanItemDtoImpl _value,
    $Res Function(_$TreatmentPlanItemDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TreatmentPlanItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? adherenceState = null,
    Object? treatmentPlanStatus = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$TreatmentPlanItemDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        adherenceState: null == adherenceState
            ? _value.adherenceState
            : adherenceState // ignore: cast_nullable_to_non_nullable
                  as String,
        treatmentPlanStatus: null == treatmentPlanStatus
            ? _value.treatmentPlanStatus
            : treatmentPlanStatus // ignore: cast_nullable_to_non_nullable
                  as int,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TreatmentPlanItemDtoImpl implements _TreatmentPlanItemDto {
  const _$TreatmentPlanItemDtoImpl({
    required this.id,
    this.adherenceState = 'Adhere',
    @JsonKey(fromJson: _treatmentPlanStatusFromJson)
    this.treatmentPlanStatus = 0,
    this.updatedAt = '',
  });

  factory _$TreatmentPlanItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreatmentPlanItemDtoImplFromJson(json);

  @override
  final String id;

  /// `Adhere` | `NotAdhere` | `NotAdhereValid` | `NotAdhereInvalid`.
  @override
  @JsonKey()
  final String adherenceState;

  /// `TreatmentPlanStatus` has no string enum converter on the backend,
  /// so it arrives as a number: `0` = InProgress, `1` = Closed.
  @override
  @JsonKey(fromJson: _treatmentPlanStatusFromJson)
  final int treatmentPlanStatus;
  @override
  @JsonKey()
  final String updatedAt;

  @override
  String toString() {
    return 'TreatmentPlanItemDto(id: $id, adherenceState: $adherenceState, treatmentPlanStatus: $treatmentPlanStatus, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreatmentPlanItemDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.adherenceState, adherenceState) ||
                other.adherenceState == adherenceState) &&
            (identical(other.treatmentPlanStatus, treatmentPlanStatus) ||
                other.treatmentPlanStatus == treatmentPlanStatus) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    adherenceState,
    treatmentPlanStatus,
    updatedAt,
  );

  /// Create a copy of TreatmentPlanItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TreatmentPlanItemDtoImplCopyWith<_$TreatmentPlanItemDtoImpl>
  get copyWith =>
      __$$TreatmentPlanItemDtoImplCopyWithImpl<_$TreatmentPlanItemDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TreatmentPlanItemDtoImplToJson(this);
  }
}

abstract class _TreatmentPlanItemDto implements TreatmentPlanItemDto {
  const factory _TreatmentPlanItemDto({
    required final String id,
    final String adherenceState,
    @JsonKey(fromJson: _treatmentPlanStatusFromJson)
    final int treatmentPlanStatus,
    final String updatedAt,
  }) = _$TreatmentPlanItemDtoImpl;

  factory _TreatmentPlanItemDto.fromJson(Map<String, dynamic> json) =
      _$TreatmentPlanItemDtoImpl.fromJson;

  @override
  String get id;

  /// `Adhere` | `NotAdhere` | `NotAdhereValid` | `NotAdhereInvalid`.
  @override
  String get adherenceState;

  /// `TreatmentPlanStatus` has no string enum converter on the backend,
  /// so it arrives as a number: `0` = InProgress, `1` = Closed.
  @override
  @JsonKey(fromJson: _treatmentPlanStatusFromJson)
  int get treatmentPlanStatus;
  @override
  String get updatedAt;

  /// Create a copy of TreatmentPlanItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TreatmentPlanItemDtoImplCopyWith<_$TreatmentPlanItemDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PatientDetailDto _$PatientDetailDtoFromJson(Map<String, dynamic> json) {
  return _PatientDetailDto.fromJson(json);
}

/// @nodoc
mixin _$PatientDetailDto {
  String get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get dateOfBirth => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError; // Male | Female
  double get height => throw _privateConstructorUsedError; // cm
  double get weight => throw _privateConstructorUsedError; // kg
  String get medicalRecordCode => throw _privateConstructorUsedError;
  String get healthInsuranceCard => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get admission => throw _privateConstructorUsedError;
  String? get discharge => throw _privateConstructorUsedError;
  PatientStatusDto get treatmentOutcome => throw _privateConstructorUsedError;
  List<NextOfKinItemDto> get nextOfKins => throw _privateConstructorUsedError;
  List<TreatmentPlanItemDto> get treatmentPlans =>
      throw _privateConstructorUsedError;

  /// Serializes this PatientDetailDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatientDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientDetailDtoCopyWith<PatientDetailDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientDetailDtoCopyWith<$Res> {
  factory $PatientDetailDtoCopyWith(
    PatientDetailDto value,
    $Res Function(PatientDetailDto) then,
  ) = _$PatientDetailDtoCopyWithImpl<$Res, PatientDetailDto>;
  @useResult
  $Res call({
    String id,
    String fullName,
    String phoneNumber,
    String dateOfBirth,
    String gender,
    double height,
    double weight,
    String medicalRecordCode,
    String healthInsuranceCard,
    String address,
    String city,
    String admission,
    String? discharge,
    PatientStatusDto treatmentOutcome,
    List<NextOfKinItemDto> nextOfKins,
    List<TreatmentPlanItemDto> treatmentPlans,
  });
}

/// @nodoc
class _$PatientDetailDtoCopyWithImpl<$Res, $Val extends PatientDetailDto>
    implements $PatientDetailDtoCopyWith<$Res> {
  _$PatientDetailDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? dateOfBirth = null,
    Object? gender = null,
    Object? height = null,
    Object? weight = null,
    Object? medicalRecordCode = null,
    Object? healthInsuranceCard = null,
    Object? address = null,
    Object? city = null,
    Object? admission = null,
    Object? discharge = freezed,
    Object? treatmentOutcome = null,
    Object? nextOfKins = null,
    Object? treatmentPlans = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            dateOfBirth: null == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as String,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as double,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double,
            medicalRecordCode: null == medicalRecordCode
                ? _value.medicalRecordCode
                : medicalRecordCode // ignore: cast_nullable_to_non_nullable
                      as String,
            healthInsuranceCard: null == healthInsuranceCard
                ? _value.healthInsuranceCard
                : healthInsuranceCard // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            admission: null == admission
                ? _value.admission
                : admission // ignore: cast_nullable_to_non_nullable
                      as String,
            discharge: freezed == discharge
                ? _value.discharge
                : discharge // ignore: cast_nullable_to_non_nullable
                      as String?,
            treatmentOutcome: null == treatmentOutcome
                ? _value.treatmentOutcome
                : treatmentOutcome // ignore: cast_nullable_to_non_nullable
                      as PatientStatusDto,
            nextOfKins: null == nextOfKins
                ? _value.nextOfKins
                : nextOfKins // ignore: cast_nullable_to_non_nullable
                      as List<NextOfKinItemDto>,
            treatmentPlans: null == treatmentPlans
                ? _value.treatmentPlans
                : treatmentPlans // ignore: cast_nullable_to_non_nullable
                      as List<TreatmentPlanItemDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PatientDetailDtoImplCopyWith<$Res>
    implements $PatientDetailDtoCopyWith<$Res> {
  factory _$$PatientDetailDtoImplCopyWith(
    _$PatientDetailDtoImpl value,
    $Res Function(_$PatientDetailDtoImpl) then,
  ) = __$$PatientDetailDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fullName,
    String phoneNumber,
    String dateOfBirth,
    String gender,
    double height,
    double weight,
    String medicalRecordCode,
    String healthInsuranceCard,
    String address,
    String city,
    String admission,
    String? discharge,
    PatientStatusDto treatmentOutcome,
    List<NextOfKinItemDto> nextOfKins,
    List<TreatmentPlanItemDto> treatmentPlans,
  });
}

/// @nodoc
class __$$PatientDetailDtoImplCopyWithImpl<$Res>
    extends _$PatientDetailDtoCopyWithImpl<$Res, _$PatientDetailDtoImpl>
    implements _$$PatientDetailDtoImplCopyWith<$Res> {
  __$$PatientDetailDtoImplCopyWithImpl(
    _$PatientDetailDtoImpl _value,
    $Res Function(_$PatientDetailDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? dateOfBirth = null,
    Object? gender = null,
    Object? height = null,
    Object? weight = null,
    Object? medicalRecordCode = null,
    Object? healthInsuranceCard = null,
    Object? address = null,
    Object? city = null,
    Object? admission = null,
    Object? discharge = freezed,
    Object? treatmentOutcome = null,
    Object? nextOfKins = null,
    Object? treatmentPlans = null,
  }) {
    return _then(
      _$PatientDetailDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        dateOfBirth: null == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as String,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as double,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        medicalRecordCode: null == medicalRecordCode
            ? _value.medicalRecordCode
            : medicalRecordCode // ignore: cast_nullable_to_non_nullable
                  as String,
        healthInsuranceCard: null == healthInsuranceCard
            ? _value.healthInsuranceCard
            : healthInsuranceCard // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        admission: null == admission
            ? _value.admission
            : admission // ignore: cast_nullable_to_non_nullable
                  as String,
        discharge: freezed == discharge
            ? _value.discharge
            : discharge // ignore: cast_nullable_to_non_nullable
                  as String?,
        treatmentOutcome: null == treatmentOutcome
            ? _value.treatmentOutcome
            : treatmentOutcome // ignore: cast_nullable_to_non_nullable
                  as PatientStatusDto,
        nextOfKins: null == nextOfKins
            ? _value._nextOfKins
            : nextOfKins // ignore: cast_nullable_to_non_nullable
                  as List<NextOfKinItemDto>,
        treatmentPlans: null == treatmentPlans
            ? _value._treatmentPlans
            : treatmentPlans // ignore: cast_nullable_to_non_nullable
                  as List<TreatmentPlanItemDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientDetailDtoImpl implements _PatientDetailDto {
  const _$PatientDetailDtoImpl({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.height,
    required this.weight,
    required this.medicalRecordCode,
    required this.healthInsuranceCard,
    required this.address,
    required this.city,
    required this.admission,
    this.discharge,
    required this.treatmentOutcome,
    final List<NextOfKinItemDto> nextOfKins = const [],
    final List<TreatmentPlanItemDto> treatmentPlans = const [],
  }) : _nextOfKins = nextOfKins,
       _treatmentPlans = treatmentPlans;

  factory _$PatientDetailDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientDetailDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String fullName;
  @override
  final String phoneNumber;
  @override
  final String dateOfBirth;
  @override
  final String gender;
  // Male | Female
  @override
  final double height;
  // cm
  @override
  final double weight;
  // kg
  @override
  final String medicalRecordCode;
  @override
  final String healthInsuranceCard;
  @override
  final String address;
  @override
  final String city;
  @override
  final String admission;
  @override
  final String? discharge;
  @override
  final PatientStatusDto treatmentOutcome;
  final List<NextOfKinItemDto> _nextOfKins;
  @override
  @JsonKey()
  List<NextOfKinItemDto> get nextOfKins {
    if (_nextOfKins is EqualUnmodifiableListView) return _nextOfKins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nextOfKins);
  }

  final List<TreatmentPlanItemDto> _treatmentPlans;
  @override
  @JsonKey()
  List<TreatmentPlanItemDto> get treatmentPlans {
    if (_treatmentPlans is EqualUnmodifiableListView) return _treatmentPlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_treatmentPlans);
  }

  @override
  String toString() {
    return 'PatientDetailDto(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, gender: $gender, height: $height, weight: $weight, medicalRecordCode: $medicalRecordCode, healthInsuranceCard: $healthInsuranceCard, address: $address, city: $city, admission: $admission, discharge: $discharge, treatmentOutcome: $treatmentOutcome, nextOfKins: $nextOfKins, treatmentPlans: $treatmentPlans)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientDetailDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.medicalRecordCode, medicalRecordCode) ||
                other.medicalRecordCode == medicalRecordCode) &&
            (identical(other.healthInsuranceCard, healthInsuranceCard) ||
                other.healthInsuranceCard == healthInsuranceCard) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.admission, admission) ||
                other.admission == admission) &&
            (identical(other.discharge, discharge) ||
                other.discharge == discharge) &&
            (identical(other.treatmentOutcome, treatmentOutcome) ||
                other.treatmentOutcome == treatmentOutcome) &&
            const DeepCollectionEquality().equals(
              other._nextOfKins,
              _nextOfKins,
            ) &&
            const DeepCollectionEquality().equals(
              other._treatmentPlans,
              _treatmentPlans,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    phoneNumber,
    dateOfBirth,
    gender,
    height,
    weight,
    medicalRecordCode,
    healthInsuranceCard,
    address,
    city,
    admission,
    discharge,
    treatmentOutcome,
    const DeepCollectionEquality().hash(_nextOfKins),
    const DeepCollectionEquality().hash(_treatmentPlans),
  );

  /// Create a copy of PatientDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientDetailDtoImplCopyWith<_$PatientDetailDtoImpl> get copyWith =>
      __$$PatientDetailDtoImplCopyWithImpl<_$PatientDetailDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientDetailDtoImplToJson(this);
  }
}

abstract class _PatientDetailDto implements PatientDetailDto {
  const factory _PatientDetailDto({
    required final String id,
    required final String fullName,
    required final String phoneNumber,
    required final String dateOfBirth,
    required final String gender,
    required final double height,
    required final double weight,
    required final String medicalRecordCode,
    required final String healthInsuranceCard,
    required final String address,
    required final String city,
    required final String admission,
    final String? discharge,
    required final PatientStatusDto treatmentOutcome,
    final List<NextOfKinItemDto> nextOfKins,
    final List<TreatmentPlanItemDto> treatmentPlans,
  }) = _$PatientDetailDtoImpl;

  factory _PatientDetailDto.fromJson(Map<String, dynamic> json) =
      _$PatientDetailDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get fullName;
  @override
  String get phoneNumber;
  @override
  String get dateOfBirth;
  @override
  String get gender; // Male | Female
  @override
  double get height; // cm
  @override
  double get weight; // kg
  @override
  String get medicalRecordCode;
  @override
  String get healthInsuranceCard;
  @override
  String get address;
  @override
  String get city;
  @override
  String get admission;
  @override
  String? get discharge;
  @override
  PatientStatusDto get treatmentOutcome;
  @override
  List<NextOfKinItemDto> get nextOfKins;
  @override
  List<TreatmentPlanItemDto> get treatmentPlans;

  /// Create a copy of PatientDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientDetailDtoImplCopyWith<_$PatientDetailDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TreatmentPlanPatientDto _$TreatmentPlanPatientDtoFromJson(
  Map<String, dynamic> json,
) {
  return _TreatmentPlanPatientDto.fromJson(json);
}

/// @nodoc
mixin _$TreatmentPlanPatientDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this TreatmentPlanPatientDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TreatmentPlanPatientDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TreatmentPlanPatientDtoCopyWith<TreatmentPlanPatientDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreatmentPlanPatientDtoCopyWith<$Res> {
  factory $TreatmentPlanPatientDtoCopyWith(
    TreatmentPlanPatientDto value,
    $Res Function(TreatmentPlanPatientDto) then,
  ) = _$TreatmentPlanPatientDtoCopyWithImpl<$Res, TreatmentPlanPatientDto>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$TreatmentPlanPatientDtoCopyWithImpl<
  $Res,
  $Val extends TreatmentPlanPatientDto
>
    implements $TreatmentPlanPatientDtoCopyWith<$Res> {
  _$TreatmentPlanPatientDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TreatmentPlanPatientDto
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
abstract class _$$TreatmentPlanPatientDtoImplCopyWith<$Res>
    implements $TreatmentPlanPatientDtoCopyWith<$Res> {
  factory _$$TreatmentPlanPatientDtoImplCopyWith(
    _$TreatmentPlanPatientDtoImpl value,
    $Res Function(_$TreatmentPlanPatientDtoImpl) then,
  ) = __$$TreatmentPlanPatientDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$TreatmentPlanPatientDtoImplCopyWithImpl<$Res>
    extends
        _$TreatmentPlanPatientDtoCopyWithImpl<
          $Res,
          _$TreatmentPlanPatientDtoImpl
        >
    implements _$$TreatmentPlanPatientDtoImplCopyWith<$Res> {
  __$$TreatmentPlanPatientDtoImplCopyWithImpl(
    _$TreatmentPlanPatientDtoImpl _value,
    $Res Function(_$TreatmentPlanPatientDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TreatmentPlanPatientDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$TreatmentPlanPatientDtoImpl(
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
class _$TreatmentPlanPatientDtoImpl implements _TreatmentPlanPatientDto {
  const _$TreatmentPlanPatientDtoImpl({required this.id, required this.name});

  factory _$TreatmentPlanPatientDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreatmentPlanPatientDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'TreatmentPlanPatientDto(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreatmentPlanPatientDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of TreatmentPlanPatientDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TreatmentPlanPatientDtoImplCopyWith<_$TreatmentPlanPatientDtoImpl>
  get copyWith =>
      __$$TreatmentPlanPatientDtoImplCopyWithImpl<
        _$TreatmentPlanPatientDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TreatmentPlanPatientDtoImplToJson(this);
  }
}

abstract class _TreatmentPlanPatientDto implements TreatmentPlanPatientDto {
  const factory _TreatmentPlanPatientDto({
    required final String id,
    required final String name,
  }) = _$TreatmentPlanPatientDtoImpl;

  factory _TreatmentPlanPatientDto.fromJson(Map<String, dynamic> json) =
      _$TreatmentPlanPatientDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of TreatmentPlanPatientDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TreatmentPlanPatientDtoImplCopyWith<_$TreatmentPlanPatientDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TreatmentMedicineDto _$TreatmentMedicineDtoFromJson(Map<String, dynamic> json) {
  return _TreatmentMedicineDto.fromJson(json);
}

/// @nodoc
mixin _$TreatmentMedicineDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get classification => throw _privateConstructorUsedError;

  /// Serializes this TreatmentMedicineDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TreatmentMedicineDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TreatmentMedicineDtoCopyWith<TreatmentMedicineDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreatmentMedicineDtoCopyWith<$Res> {
  factory $TreatmentMedicineDtoCopyWith(
    TreatmentMedicineDto value,
    $Res Function(TreatmentMedicineDto) then,
  ) = _$TreatmentMedicineDtoCopyWithImpl<$Res, TreatmentMedicineDto>;
  @useResult
  $Res call({String id, String name, String classification});
}

/// @nodoc
class _$TreatmentMedicineDtoCopyWithImpl<
  $Res,
  $Val extends TreatmentMedicineDto
>
    implements $TreatmentMedicineDtoCopyWith<$Res> {
  _$TreatmentMedicineDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TreatmentMedicineDto
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
abstract class _$$TreatmentMedicineDtoImplCopyWith<$Res>
    implements $TreatmentMedicineDtoCopyWith<$Res> {
  factory _$$TreatmentMedicineDtoImplCopyWith(
    _$TreatmentMedicineDtoImpl value,
    $Res Function(_$TreatmentMedicineDtoImpl) then,
  ) = __$$TreatmentMedicineDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String classification});
}

/// @nodoc
class __$$TreatmentMedicineDtoImplCopyWithImpl<$Res>
    extends _$TreatmentMedicineDtoCopyWithImpl<$Res, _$TreatmentMedicineDtoImpl>
    implements _$$TreatmentMedicineDtoImplCopyWith<$Res> {
  __$$TreatmentMedicineDtoImplCopyWithImpl(
    _$TreatmentMedicineDtoImpl _value,
    $Res Function(_$TreatmentMedicineDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TreatmentMedicineDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? classification = null,
  }) {
    return _then(
      _$TreatmentMedicineDtoImpl(
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
class _$TreatmentMedicineDtoImpl implements _TreatmentMedicineDto {
  const _$TreatmentMedicineDtoImpl({
    required this.id,
    required this.name,
    this.classification = '',
  });

  factory _$TreatmentMedicineDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreatmentMedicineDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String classification;

  @override
  String toString() {
    return 'TreatmentMedicineDto(id: $id, name: $name, classification: $classification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreatmentMedicineDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.classification, classification) ||
                other.classification == classification));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, classification);

  /// Create a copy of TreatmentMedicineDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TreatmentMedicineDtoImplCopyWith<_$TreatmentMedicineDtoImpl>
  get copyWith =>
      __$$TreatmentMedicineDtoImplCopyWithImpl<_$TreatmentMedicineDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TreatmentMedicineDtoImplToJson(this);
  }
}

abstract class _TreatmentMedicineDto implements TreatmentMedicineDto {
  const factory _TreatmentMedicineDto({
    required final String id,
    required final String name,
    final String classification,
  }) = _$TreatmentMedicineDtoImpl;

  factory _TreatmentMedicineDto.fromJson(Map<String, dynamic> json) =
      _$TreatmentMedicineDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get classification;

  /// Create a copy of TreatmentMedicineDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TreatmentMedicineDtoImplCopyWith<_$TreatmentMedicineDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TreatmentPlanDetailDto _$TreatmentPlanDetailDtoFromJson(
  Map<String, dynamic> json,
) {
  return _TreatmentPlanDetailDto.fromJson(json);
}

/// @nodoc
mixin _$TreatmentPlanDetailDto {
  String get id => throw _privateConstructorUsedError;
  TreatmentPlanPatientDto get patient => throw _privateConstructorUsedError;
  String get doctorId => throw _privateConstructorUsedError;
  String get diagnosis => throw _privateConstructorUsedError;
  List<TreatmentMedicineDto> get medicines =>
      throw _privateConstructorUsedError;
  String? get reasonForMedicineChoice => throw _privateConstructorUsedError;

  /// `Adhere` | `NotAdhere` | `NotAdhereValid` | `NotAdhereInvalid`.
  String get adherenceState => throw _privateConstructorUsedError;

  /// `TreatmentPlanStatus` is numeric on the wire (`0` = InProgress,
  /// `1` = Closed).
  @JsonKey(fromJson: _treatmentPlanStatusFromJson)
  int get status => throw _privateConstructorUsedError;
  String? get closeReason => throw _privateConstructorUsedError;

  /// Serializes this TreatmentPlanDetailDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TreatmentPlanDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TreatmentPlanDetailDtoCopyWith<TreatmentPlanDetailDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreatmentPlanDetailDtoCopyWith<$Res> {
  factory $TreatmentPlanDetailDtoCopyWith(
    TreatmentPlanDetailDto value,
    $Res Function(TreatmentPlanDetailDto) then,
  ) = _$TreatmentPlanDetailDtoCopyWithImpl<$Res, TreatmentPlanDetailDto>;
  @useResult
  $Res call({
    String id,
    TreatmentPlanPatientDto patient,
    String doctorId,
    String diagnosis,
    List<TreatmentMedicineDto> medicines,
    String? reasonForMedicineChoice,
    String adherenceState,
    @JsonKey(fromJson: _treatmentPlanStatusFromJson) int status,
    String? closeReason,
  });

  $TreatmentPlanPatientDtoCopyWith<$Res> get patient;
}

/// @nodoc
class _$TreatmentPlanDetailDtoCopyWithImpl<
  $Res,
  $Val extends TreatmentPlanDetailDto
>
    implements $TreatmentPlanDetailDtoCopyWith<$Res> {
  _$TreatmentPlanDetailDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TreatmentPlanDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patient = null,
    Object? doctorId = null,
    Object? diagnosis = null,
    Object? medicines = null,
    Object? reasonForMedicineChoice = freezed,
    Object? adherenceState = null,
    Object? status = null,
    Object? closeReason = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            patient: null == patient
                ? _value.patient
                : patient // ignore: cast_nullable_to_non_nullable
                      as TreatmentPlanPatientDto,
            doctorId: null == doctorId
                ? _value.doctorId
                : doctorId // ignore: cast_nullable_to_non_nullable
                      as String,
            diagnosis: null == diagnosis
                ? _value.diagnosis
                : diagnosis // ignore: cast_nullable_to_non_nullable
                      as String,
            medicines: null == medicines
                ? _value.medicines
                : medicines // ignore: cast_nullable_to_non_nullable
                      as List<TreatmentMedicineDto>,
            reasonForMedicineChoice: freezed == reasonForMedicineChoice
                ? _value.reasonForMedicineChoice
                : reasonForMedicineChoice // ignore: cast_nullable_to_non_nullable
                      as String?,
            adherenceState: null == adherenceState
                ? _value.adherenceState
                : adherenceState // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            closeReason: freezed == closeReason
                ? _value.closeReason
                : closeReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of TreatmentPlanDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TreatmentPlanPatientDtoCopyWith<$Res> get patient {
    return $TreatmentPlanPatientDtoCopyWith<$Res>(_value.patient, (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TreatmentPlanDetailDtoImplCopyWith<$Res>
    implements $TreatmentPlanDetailDtoCopyWith<$Res> {
  factory _$$TreatmentPlanDetailDtoImplCopyWith(
    _$TreatmentPlanDetailDtoImpl value,
    $Res Function(_$TreatmentPlanDetailDtoImpl) then,
  ) = __$$TreatmentPlanDetailDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    TreatmentPlanPatientDto patient,
    String doctorId,
    String diagnosis,
    List<TreatmentMedicineDto> medicines,
    String? reasonForMedicineChoice,
    String adherenceState,
    @JsonKey(fromJson: _treatmentPlanStatusFromJson) int status,
    String? closeReason,
  });

  @override
  $TreatmentPlanPatientDtoCopyWith<$Res> get patient;
}

/// @nodoc
class __$$TreatmentPlanDetailDtoImplCopyWithImpl<$Res>
    extends
        _$TreatmentPlanDetailDtoCopyWithImpl<$Res, _$TreatmentPlanDetailDtoImpl>
    implements _$$TreatmentPlanDetailDtoImplCopyWith<$Res> {
  __$$TreatmentPlanDetailDtoImplCopyWithImpl(
    _$TreatmentPlanDetailDtoImpl _value,
    $Res Function(_$TreatmentPlanDetailDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TreatmentPlanDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patient = null,
    Object? doctorId = null,
    Object? diagnosis = null,
    Object? medicines = null,
    Object? reasonForMedicineChoice = freezed,
    Object? adherenceState = null,
    Object? status = null,
    Object? closeReason = freezed,
  }) {
    return _then(
      _$TreatmentPlanDetailDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        patient: null == patient
            ? _value.patient
            : patient // ignore: cast_nullable_to_non_nullable
                  as TreatmentPlanPatientDto,
        doctorId: null == doctorId
            ? _value.doctorId
            : doctorId // ignore: cast_nullable_to_non_nullable
                  as String,
        diagnosis: null == diagnosis
            ? _value.diagnosis
            : diagnosis // ignore: cast_nullable_to_non_nullable
                  as String,
        medicines: null == medicines
            ? _value._medicines
            : medicines // ignore: cast_nullable_to_non_nullable
                  as List<TreatmentMedicineDto>,
        reasonForMedicineChoice: freezed == reasonForMedicineChoice
            ? _value.reasonForMedicineChoice
            : reasonForMedicineChoice // ignore: cast_nullable_to_non_nullable
                  as String?,
        adherenceState: null == adherenceState
            ? _value.adherenceState
            : adherenceState // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        closeReason: freezed == closeReason
            ? _value.closeReason
            : closeReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TreatmentPlanDetailDtoImpl implements _TreatmentPlanDetailDto {
  const _$TreatmentPlanDetailDtoImpl({
    required this.id,
    required this.patient,
    this.doctorId = '',
    this.diagnosis = '',
    final List<TreatmentMedicineDto> medicines = const [],
    this.reasonForMedicineChoice,
    this.adherenceState = 'Adhere',
    @JsonKey(fromJson: _treatmentPlanStatusFromJson) this.status = 0,
    this.closeReason,
  }) : _medicines = medicines;

  factory _$TreatmentPlanDetailDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreatmentPlanDetailDtoImplFromJson(json);

  @override
  final String id;
  @override
  final TreatmentPlanPatientDto patient;
  @override
  @JsonKey()
  final String doctorId;
  @override
  @JsonKey()
  final String diagnosis;
  final List<TreatmentMedicineDto> _medicines;
  @override
  @JsonKey()
  List<TreatmentMedicineDto> get medicines {
    if (_medicines is EqualUnmodifiableListView) return _medicines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medicines);
  }

  @override
  final String? reasonForMedicineChoice;

  /// `Adhere` | `NotAdhere` | `NotAdhereValid` | `NotAdhereInvalid`.
  @override
  @JsonKey()
  final String adherenceState;

  /// `TreatmentPlanStatus` is numeric on the wire (`0` = InProgress,
  /// `1` = Closed).
  @override
  @JsonKey(fromJson: _treatmentPlanStatusFromJson)
  final int status;
  @override
  final String? closeReason;

  @override
  String toString() {
    return 'TreatmentPlanDetailDto(id: $id, patient: $patient, doctorId: $doctorId, diagnosis: $diagnosis, medicines: $medicines, reasonForMedicineChoice: $reasonForMedicineChoice, adherenceState: $adherenceState, status: $status, closeReason: $closeReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreatmentPlanDetailDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patient, patient) || other.patient == patient) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.diagnosis, diagnosis) ||
                other.diagnosis == diagnosis) &&
            const DeepCollectionEquality().equals(
              other._medicines,
              _medicines,
            ) &&
            (identical(
                  other.reasonForMedicineChoice,
                  reasonForMedicineChoice,
                ) ||
                other.reasonForMedicineChoice == reasonForMedicineChoice) &&
            (identical(other.adherenceState, adherenceState) ||
                other.adherenceState == adherenceState) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.closeReason, closeReason) ||
                other.closeReason == closeReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    patient,
    doctorId,
    diagnosis,
    const DeepCollectionEquality().hash(_medicines),
    reasonForMedicineChoice,
    adherenceState,
    status,
    closeReason,
  );

  /// Create a copy of TreatmentPlanDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TreatmentPlanDetailDtoImplCopyWith<_$TreatmentPlanDetailDtoImpl>
  get copyWith =>
      __$$TreatmentPlanDetailDtoImplCopyWithImpl<_$TreatmentPlanDetailDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TreatmentPlanDetailDtoImplToJson(this);
  }
}

abstract class _TreatmentPlanDetailDto implements TreatmentPlanDetailDto {
  const factory _TreatmentPlanDetailDto({
    required final String id,
    required final TreatmentPlanPatientDto patient,
    final String doctorId,
    final String diagnosis,
    final List<TreatmentMedicineDto> medicines,
    final String? reasonForMedicineChoice,
    final String adherenceState,
    @JsonKey(fromJson: _treatmentPlanStatusFromJson) final int status,
    final String? closeReason,
  }) = _$TreatmentPlanDetailDtoImpl;

  factory _TreatmentPlanDetailDto.fromJson(Map<String, dynamic> json) =
      _$TreatmentPlanDetailDtoImpl.fromJson;

  @override
  String get id;
  @override
  TreatmentPlanPatientDto get patient;
  @override
  String get doctorId;
  @override
  String get diagnosis;
  @override
  List<TreatmentMedicineDto> get medicines;
  @override
  String? get reasonForMedicineChoice;

  /// `Adhere` | `NotAdhere` | `NotAdhereValid` | `NotAdhereInvalid`.
  @override
  String get adherenceState;

  /// `TreatmentPlanStatus` is numeric on the wire (`0` = InProgress,
  /// `1` = Closed).
  @override
  @JsonKey(fromJson: _treatmentPlanStatusFromJson)
  int get status;
  @override
  String? get closeReason;

  /// Create a copy of TreatmentPlanDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TreatmentPlanDetailDtoImplCopyWith<_$TreatmentPlanDetailDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
