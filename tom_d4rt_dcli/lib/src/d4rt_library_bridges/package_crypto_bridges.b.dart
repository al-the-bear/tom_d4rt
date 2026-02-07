// D4rt Bridge - Generated file, do not edit
// Sources: 7 files
// Generated: 2026-02-07T09:29:49.834457

// ignore_for_file: unused_import, deprecated_member_use

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart' as $pkg;

/// Bridge class for package_crypto module.
class PackageCryptoBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createDigestBridge(),
      _createHashBridge(),
      _createHmacBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Digest': 'package:crypto/src/digest.dart',
      'Hash': 'package:crypto/src/hash.dart',
      'Hmac': 'package:crypto/src/hmac.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
    };
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes with source URIs for deduplication
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }

    // Register global variables
    registerGlobalVariables(interpreter, importPath);
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('md5', $pkg.md5, importPath, sourceUri: 'package:crypto/src/md5.dart');
    } catch (e) {
      errors.add('Failed to register variable "md5": $e');
    }
    try {
      interpreter.registerGlobalVariable('sha1', $pkg.sha1, importPath, sourceUri: 'package:crypto/src/sha1.dart');
    } catch (e) {
      errors.add('Failed to register variable "sha1": $e');
    }
    try {
      interpreter.registerGlobalVariable('sha256', $pkg.sha256, importPath, sourceUri: 'package:crypto/src/sha256.dart');
    } catch (e) {
      errors.add('Failed to register variable "sha256": $e');
    }
    try {
      interpreter.registerGlobalVariable('sha224', $pkg.sha224, importPath, sourceUri: 'package:crypto/src/sha256.dart');
    } catch (e) {
      errors.add('Failed to register variable "sha224": $e');
    }
    try {
      interpreter.registerGlobalVariable('sha384', $pkg.sha384, importPath, sourceUri: 'package:crypto/src/sha512.dart');
    } catch (e) {
      errors.add('Failed to register variable "sha384": $e');
    }
    try {
      interpreter.registerGlobalVariable('sha512', $pkg.sha512, importPath, sourceUri: 'package:crypto/src/sha512.dart');
    } catch (e) {
      errors.add('Failed to register variable "sha512": $e');
    }
    try {
      interpreter.registerGlobalVariable('sha512224', $pkg.sha512224, importPath, sourceUri: 'package:crypto/src/sha512.dart');
    } catch (e) {
      errors.add('Failed to register variable "sha512224": $e');
    }
    try {
      interpreter.registerGlobalVariable('sha512256', $pkg.sha512256, importPath, sourceUri: 'package:crypto/src/sha512.dart');
    } catch (e) {
      errors.add('Failed to register variable "sha512256": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (package_crypto):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {};
  }

  /// Returns a map of global function names to their canonical source URIs.
  static Map<String, String> globalFunctionSourceUris() {
    return {};
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {};
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:crypto/src/digest.dart',
      'package:crypto/src/hash.dart',
      'package:crypto/src/hmac.dart',
      'package:crypto/src/md5.dart',
      'package:crypto/src/sha1.dart',
      'package:crypto/src/sha256.dart',
      'package:crypto/src/sha512.dart',
    ];
  }

}

// =============================================================================
// Digest Bridge
// =============================================================================

BridgedClass _createDigestBridge() {
  return BridgedClass(
    nativeType: $pkg.Digest,
    name: 'Digest',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Digest');
        if (positional.isEmpty) {
          throw ArgumentError('Digest: Missing required argument "bytes" at position 0');
        }
        final bytes = D4.coerceList<int>(positional[0], 'bytes');
        return $pkg.Digest(bytes);
      },
    },
    getters: {
      'bytes': (visitor, target) => D4.validateTarget<$pkg.Digest>(target, 'Digest').bytes,
      'hashCode': (visitor, target) => D4.validateTarget<$pkg.Digest>(target, 'Digest').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Digest>(target, 'Digest');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Digest>(target, 'Digest');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'Digest(List<int> bytes)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'bytes': 'List<int> get bytes',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// Hash Bridge
// =============================================================================

BridgedClass _createHashBridge() {
  return BridgedClass(
    nativeType: $pkg.Hash,
    name: 'Hash',
    constructors: {
    },
    getters: {
      'blockSize': (visitor, target) => D4.validateTarget<$pkg.Hash>(target, 'Hash').blockSize,
    },
    methods: {
      'convert': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Hash>(target, 'Hash');
        D4.requireMinArgs(positional, 1, 'convert');
        if (positional.isEmpty) {
          throw ArgumentError('convert: Missing required argument "input" at position 0');
        }
        final input = D4.coerceList<int>(positional[0], 'input');
        return t.convert(input);
      },
      'startChunkedConversion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Hash>(target, 'Hash');
        D4.requireMinArgs(positional, 1, 'startChunkedConversion');
        final sink = D4.getRequiredArg<Sink<$pkg.Digest>>(positional, 0, 'sink', 'startChunkedConversion');
        return t.startChunkedConversion(sink);
      },
      'fuse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Hash>(target, 'Hash');
        D4.requireMinArgs(positional, 1, 'fuse');
        final other = D4.getRequiredArg<Converter<$pkg.Digest, dynamic>>(positional, 0, 'other', 'fuse');
        return t.fuse(other);
      },
      'bind': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Hash>(target, 'Hash');
        D4.requireMinArgs(positional, 1, 'bind');
        final stream = D4.getRequiredArg<Stream<List<int>>>(positional, 0, 'stream', 'bind');
        return t.bind(stream);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Hash>(target, 'Hash');
        return t.cast();
      },
    },
    methodSignatures: {
      'convert': 'Digest convert(List<int> input)',
      'startChunkedConversion': 'ByteConversionSink startChunkedConversion(Sink<Digest> sink)',
      'fuse': 'Converter<List<int>, dynamic> fuse(Converter<Digest, dynamic> other)',
      'bind': 'Stream<Digest> bind(Stream<List<int>> stream)',
      'cast': 'Converter<dynamic, dynamic> cast()',
    },
    getterSignatures: {
      'blockSize': 'int get blockSize',
    },
  );
}

// =============================================================================
// Hmac Bridge
// =============================================================================

BridgedClass _createHmacBridge() {
  return BridgedClass(
    nativeType: $pkg.Hmac,
    name: 'Hmac',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Hmac');
        final hash = D4.getRequiredArg<$pkg.Hash>(positional, 0, 'hash', 'Hmac');
        if (positional.length <= 1) {
          throw ArgumentError('Hmac: Missing required argument "key" at position 1');
        }
        final key = D4.coerceList<int>(positional[1], 'key');
        return $pkg.Hmac(hash, key);
      },
    },
    methods: {
      'convert': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Hmac>(target, 'Hmac');
        D4.requireMinArgs(positional, 1, 'convert');
        if (positional.isEmpty) {
          throw ArgumentError('convert: Missing required argument "input" at position 0');
        }
        final input = D4.coerceList<int>(positional[0], 'input');
        return t.convert(input);
      },
      'startChunkedConversion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Hmac>(target, 'Hmac');
        D4.requireMinArgs(positional, 1, 'startChunkedConversion');
        final sink = D4.getRequiredArg<Sink<$pkg.Digest>>(positional, 0, 'sink', 'startChunkedConversion');
        return t.startChunkedConversion(sink);
      },
      'fuse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Hmac>(target, 'Hmac');
        D4.requireMinArgs(positional, 1, 'fuse');
        final other = D4.getRequiredArg<Converter<$pkg.Digest, dynamic>>(positional, 0, 'other', 'fuse');
        return t.fuse(other);
      },
      'bind': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Hmac>(target, 'Hmac');
        D4.requireMinArgs(positional, 1, 'bind');
        final stream = D4.getRequiredArg<Stream<List<int>>>(positional, 0, 'stream', 'bind');
        return t.bind(stream);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Hmac>(target, 'Hmac');
        return t.cast();
      },
    },
    constructorSignatures: {
      '': 'Hmac(Hash hash, List<int> key)',
    },
    methodSignatures: {
      'convert': 'Digest convert(List<int> input)',
      'startChunkedConversion': 'ByteConversionSink startChunkedConversion(Sink<Digest> sink)',
      'fuse': 'Converter<List<int>, dynamic> fuse(Converter<Digest, dynamic> other)',
      'bind': 'Stream<Digest> bind(Stream<List<int>> stream)',
      'cast': 'Converter<dynamic, dynamic> cast()',
    },
  );
}

