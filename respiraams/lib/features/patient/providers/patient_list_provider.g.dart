// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$visiblePatientsHash() => r'8cc5a7e2a4f35c6b14d001d6315e7e70a9f01305';

/// Applies the triage chips + priority sort over the loaded roster.
///
/// Copied from [visiblePatients].
@ProviderFor(visiblePatients)
final visiblePatientsProvider =
    AutoDisposeProvider<List<PatientSummary>>.internal(
      visiblePatients,
      name: r'visiblePatientsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$visiblePatientsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VisiblePatientsRef = AutoDisposeProviderRef<List<PatientSummary>>;
String _$patientListControllerHash() =>
    r'3efb63bbbc54312306036479e2cedb04ef51d921';

/// See also [PatientListController].
@ProviderFor(PatientListController)
final patientListControllerProvider =
    NotifierProvider<PatientListController, PatientListState>.internal(
      PatientListController.new,
      name: r'patientListControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$patientListControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PatientListController = Notifier<PatientListState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
