// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_patient_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activePatientControllerHash() =>
    r'f5551dce30605279380a9733d140c5ec0ba3da94';

/// The patient currently being worked on across clinical screens
/// (detail · progress · diagnosis wizard · result).
///
/// Empty until a patient is selected from the roster (`GET /patients/{id}`)
/// or freshly created; `AddPatientController.save()` swaps it for the newly
/// created patient so the whole flow reflects real data.
///
/// Copied from [ActivePatientController].
@ProviderFor(ActivePatientController)
final activePatientControllerProvider =
    NotifierProvider<ActivePatientController, Patient?>.internal(
      ActivePatientController.new,
      name: r'activePatientControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activePatientControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActivePatientController = Notifier<Patient?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
