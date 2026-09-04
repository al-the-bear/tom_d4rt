import 'package:tom_d4rt/d4rt.dart';

/// Declares the `dart:core` **exception** chain to the subtype registry.
///
/// The sibling of `ErrorHierarchyCore`, and it was missing entirely: the error
/// side has declared its edges since RC-7, the exception side had none. So
/// `FormatException('x') is Exception` answered `false`, and so did the same
/// question about every other bridged exception in the workspace.
///
/// Nothing noticed for a long time because the one place scripts ask it most —
/// `on Exception catch (e)` — did not go through the type test at all. It had
/// its own `case 'Exception': thrownValue is Exception` arm, which reads the
/// native object directly and is therefore right for a *native* operand while
/// saying nothing about the bridged one. SCC20 deleted that arm along with the
/// rest of the hand-written catch-clause switch, and the missing edges surfaced
/// immediately: `on Exception` stopped catching a thrown `FormatException`.
///
/// Registry edges are the whole fix — no `isAssignable` is added to the
/// `Exception` bridge. That distinction is load-bearing. `isAssignable` decides
/// which bridge *owns* a native object, so putting one on a root type makes the
/// root match every value in its hierarchy and steal member dispatch from its
/// own subtypes (the failure `ConvertHierarchyConvert` documents for
/// `ChunkedConversionSink`). The registry feeds `isSubtypeOf` only, so
/// `FormatException` keeps its `message` / `source` / `offset` getters and
/// merely gains a truthful answer about its supertype.
///
/// Each edge is declared ONCE, as the SDK declares it; the closure is computed
/// by the registry walk (SCC19).
class ExceptionHierarchyCore {
  static void register() {
    BridgedClass.registerSupertypes(const {
      'FormatException': ['Exception'],
      'TimeoutException': ['Exception'],
      'IsolateSpawnException': ['Exception'],

      // `abstract class IOException implements Exception` — not bridged itself,
      // so `on IOException` still cannot resolve a class. The hop is declared
      // anyway because it is what the SDK says, it is what makes the two
      // classes below reach `Exception` truthfully, and it means bridging
      // `IOException` later needs no edge changes.
      'IOException': ['Exception'],
      'FileSystemException': ['IOException'],
      'SocketException': ['IOException'],
      'PathAccessException': ['FileSystemException'],
      'PathExistsException': ['FileSystemException'],
      'PathNotFoundException': ['FileSystemException'],
    });
  }
}

class ExceptionCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Exception,
    name: 'Exception',
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final message = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String?
            : null;
        return Exception(message);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Exception).toString();
      },
    },
    getters: {
      'hashCode': (visitor, target) => (target as Exception).hashCode,
      'runtimeType': (visitor, target) => (target as Exception).runtimeType,
    },
  );
}

class FormatExceptionCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: FormatException,
    name: 'FormatException',
    isAssignable: (v) => v is FormatException,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final message = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String
            : '';
        final source = namedArgs['source'];
        final offset = namedArgs['offset'] as int?;
        return FormatException(message, source, offset);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as FormatException).toString();
      },
    },
    getters: {
      'message': (visitor, target) => (target as FormatException).message,
      'source': (visitor, target) => (target as FormatException).source,
      'offset': (visitor, target) => (target as FormatException).offset,
      'hashCode': (visitor, target) => (target as FormatException).hashCode,
      'runtimeType': (visitor, target) =>
          (target as FormatException).runtimeType,
    },
  );
}
