// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'targeted_treatment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pathogenListHash() => r'b6236e93192bba8e6464ff02d236be2ee9d8c19e';

/// Demo pathogen list. The backend does not expose a targeted-therapy
/// contract yet, so the app keeps this flow on local demo data.
///
/// Copied from [pathogenList].
@ProviderFor(pathogenList)
final pathogenListProvider = FutureProvider<List<PathogenItemDto>>.internal(
  pathogenList,
  name: r'pathogenListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pathogenListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PathogenListRef = FutureProviderRef<List<PathogenItemDto>>;
String _$targetedDiagnoseResultHash() =>
    r'4924919baf2ec2c125396956cad664bc43ec7a98';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Demo targeted diagnosis for the given pathogen.
///
/// Copied from [targetedDiagnoseResult].
@ProviderFor(targetedDiagnoseResult)
const targetedDiagnoseResultProvider = TargetedDiagnoseResultFamily();

/// Demo targeted diagnosis for the given pathogen.
///
/// Copied from [targetedDiagnoseResult].
class TargetedDiagnoseResultFamily
    extends Family<AsyncValue<TargetedDiagnoseResultDto>> {
  /// Demo targeted diagnosis for the given pathogen.
  ///
  /// Copied from [targetedDiagnoseResult].
  const TargetedDiagnoseResultFamily();

  /// Demo targeted diagnosis for the given pathogen.
  ///
  /// Copied from [targetedDiagnoseResult].
  TargetedDiagnoseResultProvider call(String pathogenId) {
    return TargetedDiagnoseResultProvider(pathogenId);
  }

  @override
  TargetedDiagnoseResultProvider getProviderOverride(
    covariant TargetedDiagnoseResultProvider provider,
  ) {
    return call(provider.pathogenId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'targetedDiagnoseResultProvider';
}

/// Demo targeted diagnosis for the given pathogen.
///
/// Copied from [targetedDiagnoseResult].
class TargetedDiagnoseResultProvider
    extends FutureProvider<TargetedDiagnoseResultDto> {
  /// Demo targeted diagnosis for the given pathogen.
  ///
  /// Copied from [targetedDiagnoseResult].
  TargetedDiagnoseResultProvider(String pathogenId)
    : this._internal(
        (ref) => targetedDiagnoseResult(
          ref as TargetedDiagnoseResultRef,
          pathogenId,
        ),
        from: targetedDiagnoseResultProvider,
        name: r'targetedDiagnoseResultProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$targetedDiagnoseResultHash,
        dependencies: TargetedDiagnoseResultFamily._dependencies,
        allTransitiveDependencies:
            TargetedDiagnoseResultFamily._allTransitiveDependencies,
        pathogenId: pathogenId,
      );

  TargetedDiagnoseResultProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pathogenId,
  }) : super.internal();

  final String pathogenId;

  @override
  Override overrideWith(
    FutureOr<TargetedDiagnoseResultDto> Function(
      TargetedDiagnoseResultRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TargetedDiagnoseResultProvider._internal(
        (ref) => create(ref as TargetedDiagnoseResultRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pathogenId: pathogenId,
      ),
    );
  }

  @override
  FutureProviderElement<TargetedDiagnoseResultDto> createElement() {
    return _TargetedDiagnoseResultProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TargetedDiagnoseResultProvider &&
        other.pathogenId == pathogenId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pathogenId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TargetedDiagnoseResultRef
    on FutureProviderRef<TargetedDiagnoseResultDto> {
  /// The parameter `pathogenId` of this provider.
  String get pathogenId;
}

class _TargetedDiagnoseResultProviderElement
    extends FutureProviderElement<TargetedDiagnoseResultDto>
    with TargetedDiagnoseResultRef {
  _TargetedDiagnoseResultProviderElement(super.provider);

  @override
  String get pathogenId =>
      (origin as TargetedDiagnoseResultProvider).pathogenId;
}

String _$targetedSelectionControllerHash() =>
    r'2d0ec3e27f530399b3f658fa006d4e8bba549ce3';

/// Selected antibiotic IDs of the targeted-treatment screen.
///
/// Copied from [TargetedSelectionController].
@ProviderFor(TargetedSelectionController)
final targetedSelectionControllerProvider =
    AutoDisposeNotifierProvider<
      TargetedSelectionController,
      Set<String>
    >.internal(
      TargetedSelectionController.new,
      name: r'targetedSelectionControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$targetedSelectionControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TargetedSelectionController = AutoDisposeNotifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
