import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';
// The leaf exceptions are bridged by the library that owns them — `IoStdlib`,
// `AsyncStdlib` (`TimeoutException`), `IsolateStdlib` (`IsolateSpawnException`)
// — but their EDGES are all declared in core, because that is where the
// `Exception` root they hang from lives. Registering all four is what a script
// importing those libraries gets.
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/isolate.dart';

/// SCC20 mirror coverage for `tom_d4rt_ast` — the dart:core exception edges.
///
/// The script-level twin lives in `tom_d4rt/test/scc20_catch_clause_type_test.dart`
/// (F-SCC20-22..25), which can run `on Exception catch (e)` against a thrown
/// `FormatException` because that tree has a parser. This one is
/// registration-level for the reason SCB23's mirror gives: `tom_d4rt_ast` has no
/// analyzer, `tom_d4rt_exec` resolves it from pub.dev rather than by path, so no
/// runner in this repository can execute a script against *this* working tree.
///
/// Registration level is also the honest level here. The edges are entries in
/// `BridgedClass`'s static registry and `isSubtypeOf` reads them directly, so
/// asserting on the registry measures exactly what `ExceptionHierarchyCore`
/// changed. What it cannot measure — that the catch clause consults the type
/// test at all — is the same code in both trees after SCC20's fold, and the
/// script-level twin pins it.
///
/// NOTE ON THE STATIC REGISTRY: `registerSupertypes` writes to a process-wide
/// map with no reset hook. Registration is idempotent and additive, so these
/// tests are order-independent; a negative assertion is only safe when no
/// registrar anywhere declares the edge, which is why the one below picks
/// `Exception`-vs-`Error` — two roots that nothing joins.
void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    IoStdlib.register(env);
    AsyncStdlib.register(env);
    IsolateStdlib.register(env);
  });

  BridgedClass bridge(String name) {
    final b = env.findBridgedClassByName(name);
    expect(b, isNotNull, reason: '$name must be a registered bridge');
    return b!;
  }

  /// What a script's `x is Supertype` — and, since SCC20, its `on Supertype`
  /// — ultimately asks.
  bool isSub(String sub, String superName) =>
      bridge(sub).isSubtypeOf(bridge(superName));

  group('SCC20: the bridged exceptions reach Exception', () {
    for (final name in const <String>[
      'FormatException',
      'TimeoutException',
      'IsolateSpawnException',
    ]) {
      test('F-SCC20-AST-1-$name: $name is an Exception [2026-09-04]', () {
        expect(isSub(name, 'Exception'), isTrue);
      });
    }
  });

  group('SCC20: the IO exceptions reach Exception through IOException', () {
    for (final name in const <String>[
      'FileSystemException',
      'SocketException',
      'PathAccessException',
      'PathExistsException',
      'PathNotFoundException',
    ]) {
      test('F-SCC20-AST-2-$name: $name is an Exception [2026-09-04]', () {
        // Two or three declared hops away — `PathNotFoundException ->
        // FileSystemException -> IOException -> Exception` — over edges each
        // declared once. This is the SCC19 walk doing the closure; a flattened
        // edge list would pass here and hide whether the walk works.
        expect(isSub(name, 'Exception'), isTrue);
      });
    }

    test(
      'F-SCC20-AST-3: the intermediate hops are the SDK ones [2026-09-04]',
      () {
        expect(
          BridgedClass.transitiveSupertypeNames('PathNotFoundException'),
          containsAll(<String>[
            'FileSystemException',
            'IOException',
            'Exception',
          ]),
        );
        // `IOException` is declared but not bridged — the edge exists so that the
        // classes below it reach `Exception` truthfully and so that bridging it
        // later needs no edge changes.
        expect(env.findBridgedClassByName('IOException'), isNull);
      },
    );
  });

  group('SCC20: the two roots stay disjoint', () {
    test('F-SCC20-AST-4: an Exception is not an Error [2026-09-04]', () {
      // The negative half. A blanket "throwable-shaped reaches everything" edge
      // set would satisfy every positive above and break here — and `on Error`
      // would start swallowing exceptions.
      expect(isSub('FormatException', 'Error'), isFalse);
      expect(isSub('StateError', 'Exception'), isFalse);
    });
  });

  group('SCC20: the edges do not disturb bridge selection', () {
    test('F-SCC20-AST-5: FormatException keeps its own members [2026-09-04]', () {
      // Why this is registry edges and NOT an `isAssignable` on `Exception`:
      // `isAssignable` decides which bridge OWNS a native object, so one on a
      // root makes the root match every value in its hierarchy and steal member
      // dispatch from its subtypes. The registry feeds `isSubtypeOf` only.
      expect(
        bridge('FormatException').getters.keys,
        containsAll(<String>['message', 'source', 'offset']),
      );
      expect(bridge('Exception').getters.keys, isNot(contains('message')));
    });
  });
}
