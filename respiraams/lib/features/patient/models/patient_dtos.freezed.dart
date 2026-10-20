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

TreatmentItemDto _$TreatmentItemDtoFromJson(Map<String, dynamic> json) {
  return _TreatmentItemDto.fromJson(json);
}

/// @nodoc
mixin _$TreatmentItemDto {
  String get id => throw _privateConstructorUsedError;

  /// Serializes this TreatmentItemDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TreatmentItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TreatmentItemDtoCopyWith<TreatmentItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreatmentItemDtoCopyWith<$Res> {
  factory $TreatmentItemDtoCopyWith(
    TreatmentItemDto value,
    $Res Function(TreatmentItemDto) then,
  ) = _$TreatmentItemDtoCopyWithImpl<$Res, TreatmentItemDto>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$TreatmentItemDtoCopyWithImpl<$Res, $Val extends TreatmentItemDto>
    implements $TreatmentItemDtoCopyWith<$Res> {
  _$TreatmentItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TreatmentItemDto
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
abstract class _$$TreatmentItemDtoImplCopyWith<$Res>
    implements $TreatmentItemDtoCopyWith<$Res> {
  factory _$$TreatmentItemDtoImplCopyWith(
    _$TreatmentItemDtoImpl value,
    $Res Function(_$TreatmentItemDtoImpl) then,
  ) = __$$TreatmentItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$TreatmentItemDtoImplCopyWithImpl<$Res>
    extends _$TreatmentItemDtoCopyWithImpl<$Res, _$TreatmentItemDtoImpl>
    implements _$$TreatmentItemDtoImplCopyWith<$Res> {
  __$$TreatmentItemDtoImplCopyWithImpl(
    _$TreatmentItemDtoImpl _value,
    $Res Function(_$TreatmentItemDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TreatmentItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$TreatmentItemDtoImpl(
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
class _$TreatmentItemDtoImpl implements _TreatmentItemDto {
  const _$TreatmentItemDtoImpl({required this.id});

  factory _$TreatmentItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreatmentItemDtoImplFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'TreatmentItemDto(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreatmentItemDtoImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of TreatmentItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TreatmentItemDtoImplCopyWith<_$TreatmentItemDtoImpl> get copyWith =>
      __$$TreatmentItemDtoImplCopyWithImpl<_$TreatmentItemDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TreatmentItemDtoImplToJson(this);
  }
}

abstract class _TreatmentItemDto implements TreatmentItemDto {
  const factory _TreatmentItemDto({required final String id}) =
      _$TreatmentItemDtoImpl;

  factory _TreatmentItemDto.fromJson(Map<String, dynamic> json) =
      _$TreatmentItemDtoImpl.fromJson;

  @override
  String get id;

  /// Create a copy of TreatmentItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TreatmentItemDtoImplCopyWith<_$TreatmentItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
  List<TreatmentItemDto> get treatments => throw _privateConstructorUsedError;

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
    List<TreatmentItemDto> treatments,
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
    Object? treatments = null,
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
            treatments: null == treatments
                ? _value.treatments
                : treatments // ignore: cast_nullable_to_non_nullable
                      as List<TreatmentItemDto>,
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
    List<TreatmentItemDto> treatments,
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
    Object? treatments = null,
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
        treatments: null == treatments
            ? _value._treatments
            : treatments // ignore: cast_nullable_to_non_nullable
                  as List<TreatmentItemDto>,
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
    final List<TreatmentItemDto> treatments = const [],
  }) : _nextOfKins = nextOfKins,
       _treatments = treatments;

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

  final List<TreatmentItemDto> _treatments;
  @override
  @JsonKey()
  List<TreatmentItemDto> get treatments {
    if (_treatments is EqualUnmodifiableListView) return _treatments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_treatments);
  }

  @override
  String toString() {
    return 'PatientDetailDto(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, gender: $gender, height: $height, weight: $weight, medicalRecordCode: $medicalRecordCode, healthInsuranceCard: $healthInsuranceCard, address: $address, city: $city, admission: $admission, discharge: $discharge, treatmentOutcome: $treatmentOutcome, nextOfKins: $nextOfKins, treatments: $treatments)';
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
              other._treatments,
              _treatments,
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
    const DeepCollectionEquality().hash(_treatments),
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
    final List<TreatmentItemDto> treatments,
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
  List<TreatmentItemDto> get treatments;

  /// Create a copy of PatientDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientDetailDtoImplCopyWith<_$PatientDetailDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
