// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_doctor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentDoctorHash() => r'7105f9753ab42e74acdd0465702ed7e3f2eea32f';

/// Profile of the signed-in doctor (`GET /doctors/me`), kept alive for the
/// session.
///
/// The JWT only carries the *account* id; the backend maps it to the doctor
/// profile, so no roster lookup is needed.
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
