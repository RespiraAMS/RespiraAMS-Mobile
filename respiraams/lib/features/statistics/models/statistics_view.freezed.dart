// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KpiStat _$KpiStatFromJson(Map<String, dynamic> json) {
  return _KpiStat.fromJson(json);
}

/// @nodoc
mixin _$KpiStat {
  KpiId get id => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;

  /// Serializes this KpiStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KpiStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KpiStatCopyWith<KpiStat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KpiStatCopyWith<$Res> {
  factory $KpiStatCopyWith(KpiStat value, $Res Function(KpiStat) then) =
      _$KpiStatCopyWithImpl<$Res, KpiStat>;
  @useResult
  $Res call({KpiId id, int value});
}

/// @nodoc
class _$KpiStatCopyWithImpl<$Res, $Val extends KpiStat>
    implements $KpiStatCopyWith<$Res> {
  _$KpiStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KpiStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? value = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as KpiId,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KpiStatImplCopyWith<$Res> implements $KpiStatCopyWith<$Res> {
  factory _$$KpiStatImplCopyWith(
    _$KpiStatImpl value,
    $Res Function(_$KpiStatImpl) then,
  ) = __$$KpiStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({KpiId id, int value});
}

/// @nodoc
class __$$KpiStatImplCopyWithImpl<$Res>
    extends _$KpiStatCopyWithImpl<$Res, _$KpiStatImpl>
    implements _$$KpiStatImplCopyWith<$Res> {
  __$$KpiStatImplCopyWithImpl(
    _$KpiStatImpl _value,
    $Res Function(_$KpiStatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KpiStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? value = null}) {
    return _then(
      _$KpiStatImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as KpiId,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KpiStatImpl implements _KpiStat {
  const _$KpiStatImpl({required this.id, required this.value});

  factory _$KpiStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$KpiStatImplFromJson(json);

  @override
  final KpiId id;
  @override
  final int value;

  @override
  String toString() {
    return 'KpiStat(id: $id, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KpiStatImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, value);

  /// Create a copy of KpiStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KpiStatImplCopyWith<_$KpiStatImpl> get copyWith =>
      __$$KpiStatImplCopyWithImpl<_$KpiStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KpiStatImplToJson(this);
  }
}

abstract class _KpiStat implements KpiStat {
  const factory _KpiStat({required final KpiId id, required final int value}) =
      _$KpiStatImpl;

  factory _KpiStat.fromJson(Map<String, dynamic> json) = _$KpiStatImpl.fromJson;

  @override
  KpiId get id;
  @override
  int get value;

  /// Create a copy of KpiStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KpiStatImplCopyWith<_$KpiStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DistributionBar _$DistributionBarFromJson(Map<String, dynamic> json) {
  return _DistributionBar.fromJson(json);
}

/// @nodoc
mixin _$DistributionBar {
  String get label => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;

  /// Serializes this DistributionBar to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DistributionBar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DistributionBarCopyWith<DistributionBar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistributionBarCopyWith<$Res> {
  factory $DistributionBarCopyWith(
    DistributionBar value,
    $Res Function(DistributionBar) then,
  ) = _$DistributionBarCopyWithImpl<$Res, DistributionBar>;
  @useResult
  $Res call({String label, int value});
}

/// @nodoc
class _$DistributionBarCopyWithImpl<$Res, $Val extends DistributionBar>
    implements $DistributionBarCopyWith<$Res> {
  _$DistributionBarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DistributionBar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? value = null}) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DistributionBarImplCopyWith<$Res>
    implements $DistributionBarCopyWith<$Res> {
  factory _$$DistributionBarImplCopyWith(
    _$DistributionBarImpl value,
    $Res Function(_$DistributionBarImpl) then,
  ) = __$$DistributionBarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, int value});
}

/// @nodoc
class __$$DistributionBarImplCopyWithImpl<$Res>
    extends _$DistributionBarCopyWithImpl<$Res, _$DistributionBarImpl>
    implements _$$DistributionBarImplCopyWith<$Res> {
  __$$DistributionBarImplCopyWithImpl(
    _$DistributionBarImpl _value,
    $Res Function(_$DistributionBarImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DistributionBar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? value = null}) {
    return _then(
      _$DistributionBarImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DistributionBarImpl implements _DistributionBar {
  const _$DistributionBarImpl({required this.label, required this.value});

  factory _$DistributionBarImpl.fromJson(Map<String, dynamic> json) =>
      _$$DistributionBarImplFromJson(json);

  @override
  final String label;
  @override
  final int value;

  @override
  String toString() {
    return 'DistributionBar(label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistributionBarImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  /// Create a copy of DistributionBar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DistributionBarImplCopyWith<_$DistributionBarImpl> get copyWith =>
      __$$DistributionBarImplCopyWithImpl<_$DistributionBarImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DistributionBarImplToJson(this);
  }
}

abstract class _DistributionBar implements DistributionBar {
  const factory _DistributionBar({
    required final String label,
    required final int value,
  }) = _$DistributionBarImpl;

  factory _DistributionBar.fromJson(Map<String, dynamic> json) =
      _$DistributionBarImpl.fromJson;

  @override
  String get label;
  @override
  int get value;

  /// Create a copy of DistributionBar
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DistributionBarImplCopyWith<_$DistributionBarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BreakdownStat _$BreakdownStatFromJson(Map<String, dynamic> json) {
  return _BreakdownStat.fromJson(json);
}

/// @nodoc
mixin _$BreakdownStat {
  String get key => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// 0 = most frequent; drives the bar color.
  int get rank => throw _privateConstructorUsedError;

  /// Serializes this BreakdownStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BreakdownStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BreakdownStatCopyWith<BreakdownStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BreakdownStatCopyWith<$Res> {
  factory $BreakdownStatCopyWith(
    BreakdownStat value,
    $Res Function(BreakdownStat) then,
  ) = _$BreakdownStatCopyWithImpl<$Res, BreakdownStat>;
  @useResult
  $Res call({String key, int count, int rank});
}

/// @nodoc
class _$BreakdownStatCopyWithImpl<$Res, $Val extends BreakdownStat>
    implements $BreakdownStatCopyWith<$Res> {
  _$BreakdownStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BreakdownStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? key = null, Object? count = null, Object? rank = null}) {
    return _then(
      _value.copyWith(
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BreakdownStatImplCopyWith<$Res>
    implements $BreakdownStatCopyWith<$Res> {
  factory _$$BreakdownStatImplCopyWith(
    _$BreakdownStatImpl value,
    $Res Function(_$BreakdownStatImpl) then,
  ) = __$$BreakdownStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, int count, int rank});
}

/// @nodoc
class __$$BreakdownStatImplCopyWithImpl<$Res>
    extends _$BreakdownStatCopyWithImpl<$Res, _$BreakdownStatImpl>
    implements _$$BreakdownStatImplCopyWith<$Res> {
  __$$BreakdownStatImplCopyWithImpl(
    _$BreakdownStatImpl _value,
    $Res Function(_$BreakdownStatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BreakdownStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? key = null, Object? count = null, Object? rank = null}) {
    return _then(
      _$BreakdownStatImpl(
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BreakdownStatImpl implements _BreakdownStat {
  const _$BreakdownStatImpl({
    required this.key,
    required this.count,
    required this.rank,
  });

  factory _$BreakdownStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$BreakdownStatImplFromJson(json);

  @override
  final String key;
  @override
  final int count;

  /// 0 = most frequent; drives the bar color.
  @override
  final int rank;

  @override
  String toString() {
    return 'BreakdownStat(key: $key, count: $count, rank: $rank)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BreakdownStatImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.rank, rank) || other.rank == rank));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key, count, rank);

  /// Create a copy of BreakdownStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BreakdownStatImplCopyWith<_$BreakdownStatImpl> get copyWith =>
      __$$BreakdownStatImplCopyWithImpl<_$BreakdownStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BreakdownStatImplToJson(this);
  }
}

abstract class _BreakdownStat implements BreakdownStat {
  const factory _BreakdownStat({
    required final String key,
    required final int count,
    required final int rank,
  }) = _$BreakdownStatImpl;

  factory _BreakdownStat.fromJson(Map<String, dynamic> json) =
      _$BreakdownStatImpl.fromJson;

  @override
  String get key;
  @override
  int get count;

  /// 0 = most frequent; drives the bar color.
  @override
  int get rank;

  /// Create a copy of BreakdownStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BreakdownStatImplCopyWith<_$BreakdownStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LatestReport _$LatestReportFromJson(Map<String, dynamic> json) {
  return _LatestReport.fromJson(json);
}

/// @nodoc
mixin _$LatestReport {
  String get analysisId => throw _privateConstructorUsedError;
  int get totalTreatmentPlans => throw _privateConstructorUsedError;
  int get totalPatients => throw _privateConstructorUsedError;
  int get totalAdherentPlans => throw _privateConstructorUsedError;
  int get totalNonAdherentPlans => throw _privateConstructorUsedError;
  int get totalPendingReviewPlans => throw _privateConstructorUsedError;

  /// Serializes this LatestReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LatestReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LatestReportCopyWith<LatestReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatestReportCopyWith<$Res> {
  factory $LatestReportCopyWith(
    LatestReport value,
    $Res Function(LatestReport) then,
  ) = _$LatestReportCopyWithImpl<$Res, LatestReport>;
  @useResult
  $Res call({
    String analysisId,
    int totalTreatmentPlans,
    int totalPatients,
    int totalAdherentPlans,
    int totalNonAdherentPlans,
    int totalPendingReviewPlans,
  });
}

/// @nodoc
class _$LatestReportCopyWithImpl<$Res, $Val extends LatestReport>
    implements $LatestReportCopyWith<$Res> {
  _$LatestReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LatestReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? analysisId = null,
    Object? totalTreatmentPlans = null,
    Object? totalPatients = null,
    Object? totalAdherentPlans = null,
    Object? totalNonAdherentPlans = null,
    Object? totalPendingReviewPlans = null,
  }) {
    return _then(
      _value.copyWith(
            analysisId: null == analysisId
                ? _value.analysisId
                : analysisId // ignore: cast_nullable_to_non_nullable
                      as String,
            totalTreatmentPlans: null == totalTreatmentPlans
                ? _value.totalTreatmentPlans
                : totalTreatmentPlans // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPatients: null == totalPatients
                ? _value.totalPatients
                : totalPatients // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAdherentPlans: null == totalAdherentPlans
                ? _value.totalAdherentPlans
                : totalAdherentPlans // ignore: cast_nullable_to_non_nullable
                      as int,
            totalNonAdherentPlans: null == totalNonAdherentPlans
                ? _value.totalNonAdherentPlans
                : totalNonAdherentPlans // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPendingReviewPlans: null == totalPendingReviewPlans
                ? _value.totalPendingReviewPlans
                : totalPendingReviewPlans // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LatestReportImplCopyWith<$Res>
    implements $LatestReportCopyWith<$Res> {
  factory _$$LatestReportImplCopyWith(
    _$LatestReportImpl value,
    $Res Function(_$LatestReportImpl) then,
  ) = __$$LatestReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String analysisId,
    int totalTreatmentPlans,
    int totalPatients,
    int totalAdherentPlans,
    int totalNonAdherentPlans,
    int totalPendingReviewPlans,
  });
}

/// @nodoc
class __$$LatestReportImplCopyWithImpl<$Res>
    extends _$LatestReportCopyWithImpl<$Res, _$LatestReportImpl>
    implements _$$LatestReportImplCopyWith<$Res> {
  __$$LatestReportImplCopyWithImpl(
    _$LatestReportImpl _value,
    $Res Function(_$LatestReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LatestReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? analysisId = null,
    Object? totalTreatmentPlans = null,
    Object? totalPatients = null,
    Object? totalAdherentPlans = null,
    Object? totalNonAdherentPlans = null,
    Object? totalPendingReviewPlans = null,
  }) {
    return _then(
      _$LatestReportImpl(
        analysisId: null == analysisId
            ? _value.analysisId
            : analysisId // ignore: cast_nullable_to_non_nullable
                  as String,
        totalTreatmentPlans: null == totalTreatmentPlans
            ? _value.totalTreatmentPlans
            : totalTreatmentPlans // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPatients: null == totalPatients
            ? _value.totalPatients
            : totalPatients // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAdherentPlans: null == totalAdherentPlans
            ? _value.totalAdherentPlans
            : totalAdherentPlans // ignore: cast_nullable_to_non_nullable
                  as int,
        totalNonAdherentPlans: null == totalNonAdherentPlans
            ? _value.totalNonAdherentPlans
            : totalNonAdherentPlans // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPendingReviewPlans: null == totalPendingReviewPlans
            ? _value.totalPendingReviewPlans
            : totalPendingReviewPlans // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LatestReportImpl extends _LatestReport {
  const _$LatestReportImpl({
    this.analysisId = '',
    this.totalTreatmentPlans = 0,
    this.totalPatients = 0,
    this.totalAdherentPlans = 0,
    this.totalNonAdherentPlans = 0,
    this.totalPendingReviewPlans = 0,
  }) : super._();

  factory _$LatestReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$LatestReportImplFromJson(json);

  @override
  @JsonKey()
  final String analysisId;
  @override
  @JsonKey()
  final int totalTreatmentPlans;
  @override
  @JsonKey()
  final int totalPatients;
  @override
  @JsonKey()
  final int totalAdherentPlans;
  @override
  @JsonKey()
  final int totalNonAdherentPlans;
  @override
  @JsonKey()
  final int totalPendingReviewPlans;

  @override
  String toString() {
    return 'LatestReport(analysisId: $analysisId, totalTreatmentPlans: $totalTreatmentPlans, totalPatients: $totalPatients, totalAdherentPlans: $totalAdherentPlans, totalNonAdherentPlans: $totalNonAdherentPlans, totalPendingReviewPlans: $totalPendingReviewPlans)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatestReportImpl &&
            (identical(other.analysisId, analysisId) ||
                other.analysisId == analysisId) &&
            (identical(other.totalTreatmentPlans, totalTreatmentPlans) ||
                other.totalTreatmentPlans == totalTreatmentPlans) &&
            (identical(other.totalPatients, totalPatients) ||
                other.totalPatients == totalPatients) &&
            (identical(other.totalAdherentPlans, totalAdherentPlans) ||
                other.totalAdherentPlans == totalAdherentPlans) &&
            (identical(other.totalNonAdherentPlans, totalNonAdherentPlans) ||
                other.totalNonAdherentPlans == totalNonAdherentPlans) &&
            (identical(
                  other.totalPendingReviewPlans,
                  totalPendingReviewPlans,
                ) ||
                other.totalPendingReviewPlans == totalPendingReviewPlans));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    analysisId,
    totalTreatmentPlans,
    totalPatients,
    totalAdherentPlans,
    totalNonAdherentPlans,
    totalPendingReviewPlans,
  );

  /// Create a copy of LatestReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LatestReportImplCopyWith<_$LatestReportImpl> get copyWith =>
      __$$LatestReportImplCopyWithImpl<_$LatestReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LatestReportImplToJson(this);
  }
}

abstract class _LatestReport extends LatestReport {
  const factory _LatestReport({
    final String analysisId,
    final int totalTreatmentPlans,
    final int totalPatients,
    final int totalAdherentPlans,
    final int totalNonAdherentPlans,
    final int totalPendingReviewPlans,
  }) = _$LatestReportImpl;
  const _LatestReport._() : super._();

  factory _LatestReport.fromJson(Map<String, dynamic> json) =
      _$LatestReportImpl.fromJson;

  @override
  String get analysisId;
  @override
  int get totalTreatmentPlans;
  @override
  int get totalPatients;
  @override
  int get totalAdherentPlans;
  @override
  int get totalNonAdherentPlans;
  @override
  int get totalPendingReviewPlans;

  /// Create a copy of LatestReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LatestReportImplCopyWith<_$LatestReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatisticsView _$StatisticsViewFromJson(Map<String, dynamic> json) {
  return _StatisticsView.fromJson(json);
}

/// @nodoc
mixin _$StatisticsView {
  List<KpiStat> get kpis => throw _privateConstructorUsedError;
  List<DistributionBar> get ageBars => throw _privateConstructorUsedError;
  List<BreakdownStat> get outcomes => throw _privateConstructorUsedError;
  LatestReport? get latestReport => throw _privateConstructorUsedError;

  /// Serializes this StatisticsView to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatisticsView
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatisticsViewCopyWith<StatisticsView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticsViewCopyWith<$Res> {
  factory $StatisticsViewCopyWith(
    StatisticsView value,
    $Res Function(StatisticsView) then,
  ) = _$StatisticsViewCopyWithImpl<$Res, StatisticsView>;
  @useResult
  $Res call({
    List<KpiStat> kpis,
    List<DistributionBar> ageBars,
    List<BreakdownStat> outcomes,
    LatestReport? latestReport,
  });

  $LatestReportCopyWith<$Res>? get latestReport;
}

/// @nodoc
class _$StatisticsViewCopyWithImpl<$Res, $Val extends StatisticsView>
    implements $StatisticsViewCopyWith<$Res> {
  _$StatisticsViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatisticsView
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kpis = null,
    Object? ageBars = null,
    Object? outcomes = null,
    Object? latestReport = freezed,
  }) {
    return _then(
      _value.copyWith(
            kpis: null == kpis
                ? _value.kpis
                : kpis // ignore: cast_nullable_to_non_nullable
                      as List<KpiStat>,
            ageBars: null == ageBars
                ? _value.ageBars
                : ageBars // ignore: cast_nullable_to_non_nullable
                      as List<DistributionBar>,
            outcomes: null == outcomes
                ? _value.outcomes
                : outcomes // ignore: cast_nullable_to_non_nullable
                      as List<BreakdownStat>,
            latestReport: freezed == latestReport
                ? _value.latestReport
                : latestReport // ignore: cast_nullable_to_non_nullable
                      as LatestReport?,
          )
          as $Val,
    );
  }

  /// Create a copy of StatisticsView
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatestReportCopyWith<$Res>? get latestReport {
    if (_value.latestReport == null) {
      return null;
    }

    return $LatestReportCopyWith<$Res>(_value.latestReport!, (value) {
      return _then(_value.copyWith(latestReport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StatisticsViewImplCopyWith<$Res>
    implements $StatisticsViewCopyWith<$Res> {
  factory _$$StatisticsViewImplCopyWith(
    _$StatisticsViewImpl value,
    $Res Function(_$StatisticsViewImpl) then,
  ) = __$$StatisticsViewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<KpiStat> kpis,
    List<DistributionBar> ageBars,
    List<BreakdownStat> outcomes,
    LatestReport? latestReport,
  });

  @override
  $LatestReportCopyWith<$Res>? get latestReport;
}

/// @nodoc
class __$$StatisticsViewImplCopyWithImpl<$Res>
    extends _$StatisticsViewCopyWithImpl<$Res, _$StatisticsViewImpl>
    implements _$$StatisticsViewImplCopyWith<$Res> {
  __$$StatisticsViewImplCopyWithImpl(
    _$StatisticsViewImpl _value,
    $Res Function(_$StatisticsViewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StatisticsView
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kpis = null,
    Object? ageBars = null,
    Object? outcomes = null,
    Object? latestReport = freezed,
  }) {
    return _then(
      _$StatisticsViewImpl(
        kpis: null == kpis
            ? _value._kpis
            : kpis // ignore: cast_nullable_to_non_nullable
                  as List<KpiStat>,
        ageBars: null == ageBars
            ? _value._ageBars
            : ageBars // ignore: cast_nullable_to_non_nullable
                  as List<DistributionBar>,
        outcomes: null == outcomes
            ? _value._outcomes
            : outcomes // ignore: cast_nullable_to_non_nullable
                  as List<BreakdownStat>,
        latestReport: freezed == latestReport
            ? _value.latestReport
            : latestReport // ignore: cast_nullable_to_non_nullable
                  as LatestReport?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StatisticsViewImpl implements _StatisticsView {
  const _$StatisticsViewImpl({
    final List<KpiStat> kpis = const [],
    final List<DistributionBar> ageBars = const [],
    final List<BreakdownStat> outcomes = const [],
    this.latestReport,
  }) : _kpis = kpis,
       _ageBars = ageBars,
       _outcomes = outcomes;

  factory _$StatisticsViewImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatisticsViewImplFromJson(json);

  final List<KpiStat> _kpis;
  @override
  @JsonKey()
  List<KpiStat> get kpis {
    if (_kpis is EqualUnmodifiableListView) return _kpis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kpis);
  }

  final List<DistributionBar> _ageBars;
  @override
  @JsonKey()
  List<DistributionBar> get ageBars {
    if (_ageBars is EqualUnmodifiableListView) return _ageBars;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ageBars);
  }

  final List<BreakdownStat> _outcomes;
  @override
  @JsonKey()
  List<BreakdownStat> get outcomes {
    if (_outcomes is EqualUnmodifiableListView) return _outcomes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outcomes);
  }

  @override
  final LatestReport? latestReport;

  @override
  String toString() {
    return 'StatisticsView(kpis: $kpis, ageBars: $ageBars, outcomes: $outcomes, latestReport: $latestReport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatisticsViewImpl &&
            const DeepCollectionEquality().equals(other._kpis, _kpis) &&
            const DeepCollectionEquality().equals(other._ageBars, _ageBars) &&
            const DeepCollectionEquality().equals(other._outcomes, _outcomes) &&
            (identical(other.latestReport, latestReport) ||
                other.latestReport == latestReport));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_kpis),
    const DeepCollectionEquality().hash(_ageBars),
    const DeepCollectionEquality().hash(_outcomes),
    latestReport,
  );

  /// Create a copy of StatisticsView
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatisticsViewImplCopyWith<_$StatisticsViewImpl> get copyWith =>
      __$$StatisticsViewImplCopyWithImpl<_$StatisticsViewImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StatisticsViewImplToJson(this);
  }
}

abstract class _StatisticsView implements StatisticsView {
  const factory _StatisticsView({
    final List<KpiStat> kpis,
    final List<DistributionBar> ageBars,
    final List<BreakdownStat> outcomes,
    final LatestReport? latestReport,
  }) = _$StatisticsViewImpl;

  factory _StatisticsView.fromJson(Map<String, dynamic> json) =
      _$StatisticsViewImpl.fromJson;

  @override
  List<KpiStat> get kpis;
  @override
  List<DistributionBar> get ageBars;
  @override
  List<BreakdownStat> get outcomes;
  @override
  LatestReport? get latestReport;

  /// Create a copy of StatisticsView
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatisticsViewImplCopyWith<_$StatisticsViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
