// SC1 / SC10: the Stopwatch and UriData core bridges must exist in the
// analyzer-free tree too, not just in tom_d4rt.
//
// The workspace rule is that every stdlib bridge lands in BOTH interpreter
// trees; a bridge that only exists in `tom_d4rt` is a silent capability
// difference that scripts hit at runtime. These tests pin the mirror at the
// registration level: the class is reachable by name from a freshly
// registered `CoreStdlib`, it carries the members the tom_d4rt side declares,
// and its instance getters produce the right values off a real native object.
//
// Why registration-level and not script-level: driving a script needs a
// parsed AST, and the analyzer-based front end lives in `tom_d4rt_exec`,
// which consumes `tom_d4rt_ast` from pub.dev rather than by path — so it
// cannot see these changes until the package is published. Instance getters
// take a nullable `InterpreterVisitor`, so they *can* be invoked directly
// here; constructors and methods require a live visitor and are covered by
// the script-level suite in `tom_d4rt` (and, after publishing, in
// `tom_d4rt_exec`).

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    // Go through the public `Stdlib` façade rather than `CoreStdlib` directly
    // — that is the path the runner uses, so it also pins that the new
    // bridges are reachable from a stock environment.
    Stdlib(env).register();
  });

  group('SC1: Stopwatch core bridge', () {
    test('F-SC1-AST-1: is registered under the name Stopwatch [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('Stopwatch');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, Stopwatch);
      expect(bridge.isAssignable?.call(Stopwatch()), isTrue);
    });

    test('F-SC1-AST-2: declares the default constructor and the state-machine '
        'methods [2026-07-27]', () {
      final bridge = env.findBridgedClassByName('Stopwatch')!;
      expect(bridge.constructors.keys, contains(''));
      expect(bridge.methods.keys,
          containsAll(<String>['start', 'stop', 'reset', 'toString']));
    });

    test('F-SC1-AST-3: exposes every elapsed* / frequency / isRunning getter '
        '[2026-07-27]', () {
      final bridge = env.findBridgedClassByName('Stopwatch')!;
      expect(
          bridge.getters.keys,
          containsAll(<String>[
            'elapsed',
            'elapsedTicks',
            'elapsedMilliseconds',
            'elapsedMicroseconds',
            'frequency',
            'isRunning',
          ]));
    });

    test('F-SC1-AST-4: the getters read through to the native Stopwatch '
        '[2026-07-27]', () {
      // Getters accept a null visitor, so they can be driven directly. Assert
      // only the deterministic values — elapsed time is not reproducible.
      final bridge = env.findBridgedClassByName('Stopwatch')!;
      final sw = Stopwatch();
      expect(bridge.getters['isRunning']!(null, sw), isFalse);
      expect(bridge.getters['elapsedTicks']!(null, sw), 0);
      sw.start();
      expect(bridge.getters['isRunning']!(null, sw), isTrue);
      sw.stop();
      expect(bridge.getters['isRunning']!(null, sw), isFalse);
      expect(bridge.getters['elapsed']!(null, sw), isA<Duration>());
      expect(bridge.getters['frequency']!(null, sw), greaterThan(0));
    });
  });

  group('SC10: UriData core bridge', () {
    test('F-SC10-AST-1: is registered under the name UriData [2026-07-27]', () {
      final bridge = env.findBridgedClassByName('UriData');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, UriData);
      expect(bridge.isAssignable?.call(UriData.parse('data:,x')), isTrue);
    });

    test('F-SC10-AST-2: declares the three named constructors and the static '
        'parse [2026-07-27]', () {
      final bridge = env.findBridgedClassByName('UriData')!;
      expect(bridge.constructors.keys,
          containsAll(<String>['fromString', 'fromBytes', 'fromUri']));
      expect(bridge.staticMethods.keys, contains('parse'));
    });

    test('F-SC10-AST-3: declares the content accessors [2026-07-27]', () {
      final bridge = env.findBridgedClassByName('UriData')!;
      expect(bridge.methods.keys,
          containsAll(<String>['contentAsBytes', 'contentAsString']));
      expect(
          bridge.getters.keys,
          containsAll(<String>[
            'uri',
            'mimeType',
            'charset',
            'isBase64',
            'parameters',
            'contentText',
          ]));
    });

    test('F-SC10-AST-4: the getters read through to the native UriData '
        '[2026-07-27]', () {
      final bridge = env.findBridgedClassByName('UriData')!;
      final data = UriData.parse('data:text/plain;charset=utf-8,Hello');
      expect(bridge.getters['mimeType']!(null, data), 'text/plain');
      expect(bridge.getters['charset']!(null, data), 'utf-8');
      expect(bridge.getters['isBase64']!(null, data), isFalse);
      expect(bridge.getters['uri']!(null, data), isA<Uri>());
    });
  });

  group('SC10: the Uri.data accessor that makes UriData reachable', () {
    test('F-SC10-AST-5: the Uri bridge exposes the data getter [2026-07-27]',
        () {
      // Without this, a parsed `data:` URI has no route to its UriData —
      // the interpreter could build one and never read it back.
      final bridge = env.findBridgedClassByName('Uri')!;
      expect(bridge.getters.keys, contains('data'));
      final value = bridge.getters['data']!(null, Uri.parse('data:,round'));
      expect(value, isA<UriData>());
      expect((value as UriData).contentAsString(), 'round');
    });
  });
}
