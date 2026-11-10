// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_flow_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$diagnosisFormHash() => r'690d07fcbf2815d76f584a3c31e4d0796861e8ad';

/// Dynamic form catalog from `GET /diagnose` (clinical variables,
/// antibiotics and pathogens).
///
/// Copied from [diagnosisForm].
@ProviderFor(diagnosisForm)
final diagnosisFormProvider = FutureProvider<DiagnosisFormDto>.internal(
  diagnosisForm,
  name: r'diagnosisFormProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$diagnosisFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DiagnosisFormRef = FutureProviderRef<DiagnosisFormDto>;
String _$diagnosisFlowControllerHash() =>
    r'233e5a6ec4a2493235e590867c965dd34a3345f8';

/// Orchestrates the API-backed empirical diagnosis flow.
///
/// Copied from [DiagnosisFlowController].
@ProviderFor(DiagnosisFlowController)
final diagnosisFlowControllerProvider =
    NotifierProvider<DiagnosisFlowController, DiagnosisFlowState>.internal(
      DiagnosisFlowController.new,
      name: r'diagnosisFlowControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$diagnosisFlowControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DiagnosisFlowController = Notifier<DiagnosisFlowState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
