// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_states.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getUserDataHash() => r'f646ecc9ae060f35b12ce8a2ad55e560fc46f734';

/// See also [getUserData].
@ProviderFor(getUserData)
final getUserDataProvider = AutoDisposeProvider<BaseInfo>.internal(
  getUserData,
  name: r'getUserDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getUserDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetUserDataRef = AutoDisposeProviderRef<BaseInfo>;
String _$getBaseInfoHash() => r'6fc3b0ff8a9133fa031d8396c040e345701c62f4';

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

/// See also [getBaseInfo].
@ProviderFor(getBaseInfo)
const getBaseInfoProvider = GetBaseInfoFamily();

/// See also [getBaseInfo].
class GetBaseInfoFamily extends Family<AsyncValue<void>> {
  /// See also [getBaseInfo].
  const GetBaseInfoFamily();

  /// See also [getBaseInfo].
  GetBaseInfoProvider call(
    String token,
  ) {
    return GetBaseInfoProvider(
      token,
    );
  }

  @override
  GetBaseInfoProvider getProviderOverride(
    covariant GetBaseInfoProvider provider,
  ) {
    return call(
      provider.token,
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
  String? get name => r'getBaseInfoProvider';
}

/// See also [getBaseInfo].
class GetBaseInfoProvider extends AutoDisposeFutureProvider<void> {
  /// See also [getBaseInfo].
  GetBaseInfoProvider(
    String token,
  ) : this._internal(
          (ref) => getBaseInfo(
            ref as GetBaseInfoRef,
            token,
          ),
          from: getBaseInfoProvider,
          name: r'getBaseInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBaseInfoHash,
          dependencies: GetBaseInfoFamily._dependencies,
          allTransitiveDependencies:
              GetBaseInfoFamily._allTransitiveDependencies,
          token: token,
        );

  GetBaseInfoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
  }) : super.internal();

  final String token;

  @override
  Override overrideWith(
    FutureOr<void> Function(GetBaseInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetBaseInfoProvider._internal(
        (ref) => create(ref as GetBaseInfoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _GetBaseInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBaseInfoProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetBaseInfoRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `token` of this provider.
  String get token;
}

class _GetBaseInfoProviderElement extends AutoDisposeFutureProviderElement<void>
    with GetBaseInfoRef {
  _GetBaseInfoProviderElement(super.provider);

  @override
  String get token => (origin as GetBaseInfoProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
