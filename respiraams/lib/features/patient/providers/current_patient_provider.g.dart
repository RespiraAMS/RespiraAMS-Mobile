// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_patient_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentPatientHash() => r'686a7aae83324694f69db8b32fd3cdaa973999ef';

/// The patient shown on detail/progress/wizard screens — mirrors the
/// [activePatientControllerProvider] so a freshly created or selected
/// patient flows through the whole diagnosis journey.
///
/// `null` until a patient is selected or created.
///
/// Copied from [currentPatient].
@ProviderFor(currentPatient)
final currentPatientProvider = AutoDisposeProvider<Patient?>.internal(
  currentPatient,
  name: r'currentPatientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentPatientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentPatientRef = AutoDisposeProviderRef<Patient?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
