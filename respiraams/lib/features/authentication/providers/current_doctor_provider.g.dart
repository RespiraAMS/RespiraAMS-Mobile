// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_doctor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentDoctorHash() => r'692b9f45312a061d601ef9b2ee1e932e8d1dbfe4';

/// Profile of the signed-in doctor, resolved through the account-id bridge.
///
/// The JWT only carries the *account* id, while `GET /doctors/{id}` takes the
/// *profile* id, so the roster is walked once and kept alive for the session.
///
/// Copied from [currentDoctor].
@ProviderFor(currentDoctor)
final currentDoctorProvider = FutureProvider<DoctorProfileDto?>.internal(
  currentDoctor,
  name: r'currentDoctorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentDoctorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentDoctorRef = FutureProviderRef<DoctorProfileDto?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
