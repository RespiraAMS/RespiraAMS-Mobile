// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$languageControllerHash() =>
    r'2dc24861faced18fefb13753df91c685ffa6abaf';

/// App-wide locale, persisted under `settings.language`.
///
/// Defaults to Vietnamese (the app's source language and backend content
/// language) so existing behaviour and tests stay unchanged until the user
/// picks English in the settings sheet.
///
/// Copied from [LanguageController].
@ProviderFor(LanguageController)
final languageControllerProvider =
    NotifierProvider<LanguageController, AppLanguage>.internal(
      LanguageController.new,
      name: r'languageControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$languageControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LanguageController = Notifier<AppLanguage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
