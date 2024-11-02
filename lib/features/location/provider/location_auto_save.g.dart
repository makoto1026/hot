// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_auto_save.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationAutoSaveHash() => r'5b1c238b2ab73bf0c2a2a972d30f7ce3384ae84a';

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

abstract class _$LocationAutoSave
    extends BuildlessAutoDisposeAsyncNotifier<Location?> {
  late final String args;

  FutureOr<Location?> build(
    String args,
  );
}

/// See also [LocationAutoSave].
@ProviderFor(LocationAutoSave)
const locationAutoSaveProvider = LocationAutoSaveFamily();

/// See also [LocationAutoSave].
class LocationAutoSaveFamily extends Family<AsyncValue<Location?>> {
  /// See also [LocationAutoSave].
  const LocationAutoSaveFamily();

  /// See also [LocationAutoSave].
  LocationAutoSaveProvider call(
    String args,
  ) {
    return LocationAutoSaveProvider(
      args,
    );
  }

  @override
  LocationAutoSaveProvider getProviderOverride(
    covariant LocationAutoSaveProvider provider,
  ) {
    return call(
      provider.args,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'locationAutoSaveProvider';
}

/// See also [LocationAutoSave].
class LocationAutoSaveProvider
    extends AutoDisposeAsyncNotifierProviderImpl<LocationAutoSave, Location?> {
  /// See also [LocationAutoSave].
  LocationAutoSaveProvider(
    String args,
  ) : this._internal(
          () => LocationAutoSave()..args = args,
          from: locationAutoSaveProvider,
          name: r'locationAutoSaveProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$locationAutoSaveHash,
          dependencies: LocationAutoSaveFamily._dependencies,
          allTransitiveDependencies:
              LocationAutoSaveFamily._allTransitiveDependencies,
          args: args,
        );

  LocationAutoSaveProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.args,
  }) : super.internal();

  final String args;

  @override
  FutureOr<Location?> runNotifierBuild(
    covariant LocationAutoSave notifier,
  ) {
    return notifier.build(
      args,
    );
  }

  @override
  Override overrideWith(LocationAutoSave Function() create) {
    return ProviderOverride(
      origin: this,
      override: LocationAutoSaveProvider._internal(
        () => create()..args = args,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        args: args,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<LocationAutoSave, Location?>
      createElement() {
    return _LocationAutoSaveProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocationAutoSaveProvider && other.args == args;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, args.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LocationAutoSaveRef on AutoDisposeAsyncNotifierProviderRef<Location?> {
  /// The parameter `args` of this provider.
  String get args;
}

class _LocationAutoSaveProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LocationAutoSave, Location?>
    with LocationAutoSaveRef {
  _LocationAutoSaveProviderElement(super.provider);

  @override
  String get args => (origin as LocationAutoSaveProvider).args;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
