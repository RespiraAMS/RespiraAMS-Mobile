// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_flow_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$diagnosisFormHash() => r'761f7b10af623e8815e7fb48d1ac6c72a996b9c2';

/// Dynamic form catalog from `GET /diagnose/empirical`.
///
/// Copied from [diagnosisForm].
@ProviderFor(diagnosisForm)
final diagnosisFormProvider =
    FutureProvider<List<ClinicalVariableDto>>.internal(
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
typedef DiagnosisFormRef = FutureProviderRef<List<ClinicalVariableDto>>;
String _$diagnosisFlowControllerHash() =>
    r'3b41c2c2272f9f6b00e782bfb228bf6da66572bf';

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
