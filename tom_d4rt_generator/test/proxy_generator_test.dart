/// Golden lock-in for the A2 abstract-interface forwarding-proxy template
/// (`generateProxies`, `proxy_generator.dart`).
///
/// Quest d4rt (OPEN C.1): the generator already
/// emits the forwarding-proxy template into `flutter_proxies.b.dart` on both
/// flutter twins (15 live proxies). Before this file there was **no** generator
/// unit test exercising proxy generation at all — the first sub-step of the
/// backlog ("golden the emitted proxy for a fixture abstract class with
/// abstract methods of varied return types") was unpinned.
///
/// This test goldens the template against `dart:core`'s `Comparable<T>` — a
/// minimal abstract class with one abstract method (`int compareTo(T other)`)
/// and a generic type parameter, covering the native-return + generic-param
/// shapes. It pins the two halves of the template:
///   1. the proxy class itself (`class D4rtComparable<T> extends Comparable<T>`
///      with an `onCompareTo` callback that overrides `compareTo`), and
///   2. the `registerProxyFactories()` adapter that registers the proxy as an
///      interface proxy and forwards an `InterpretedInstance.compareTo` back
///      through `findInstanceMethod/bind/call` + `D4.extractBridgedArg<int>`.
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  group('A2 forwarding-proxy template (generateProxies)', () {
    late String generatedCode;
    late ProxyGenerationResult result;

    setUpAll(() async {
      // Use the generator package root as the project path so the analyzer
      // resolves `dart:core` via the SDK + package config. The output goes to
      // a temp file (absolute path → wins the p.join in proxy_generator).
      final projectRoot = Directory.current.path;
      final tempDir =
          Directory.systemTemp.createTempSync('proxy_generator_test_');
      final outputFile = p.join(tempDir.path, 'comparable_proxy.b.dart');

      final config = BridgeConfig(
        name: 'proxy_template_test',
        d4rtImport: 'package:tom_d4rt/d4rt.dart',
        generateProxies: true,
        proxiesOutputPath: outputFile,
        proxyClasses: const [ProxyClassConfig(className: 'Comparable')],
        modules: const [
          ModuleConfig(
            name: 'dart_core',
            barrelFiles: ['dart:core'],
            outputPath: 'unused_bridges.b.dart',
            barrelImport: 'dart:core',
          ),
        ],
      );

      result = await generateProxies(
        config: config,
        projectPath: projectRoot,
      );

      expect(result.errors, isEmpty,
          reason: 'Proxy generation should succeed for dart:core Comparable');
      expect(result.outputFile, isNotNull);
      generatedCode = await File(result.outputFile!).readAsString();
    });

    test('PROXY-A2-01: emits a proxy class extending the abstract base. '
        '[2026-06-07] (PASS)', () {
      // The generic type parameter from `Comparable<T>` is carried through.
      expect(generatedCode, contains('class D4rtComparable<T> extends Comparable<T>'));
    });

    test('PROXY-A2-02: abstract method becomes a required callback field. '
        '[2026-06-07] (PASS)', () {
      // `int compareTo(T other)` → `final int Function(T) onCompareTo;`
      expect(generatedCode, contains('int Function(T) onCompareTo'));
    });

    test('PROXY-A2-03: the override forwards to the callback. '
        '[2026-06-07] (PASS)', () {
      expect(generatedCode, contains('int compareTo(T other)'));
      expect(generatedCode, contains('onCompareTo(other)'));
    });

    test('PROXY-A2-04: registerProxyFactories registers an interface proxy. '
        '[2026-06-07] (PASS)', () {
      expect(generatedCode, contains('void registerProxyFactories()'));
      expect(generatedCode,
          contains("D4.registerInterfaceProxy('Comparable'"));
    });

    test('PROXY-A2-05: the factory adapts InterpretedInstance via '
        'findInstanceMethod/bind/call + extractBridgedArg. [2026-06-07] (PASS)',
        () {
      // The factory body is the InterpretedInstance→native bridge: it looks
      // up the script method, binds+calls it, and coerces the typed return.
      expect(generatedCode, contains("findInstanceMethod('compareTo')"));
      expect(generatedCode, contains('.bind(instance).call(visitor,'));
      expect(generatedCode,
          contains("D4.extractBridgedArg<int>(result, 'compareTo', visitor)"));
    });
  });

  /// Quest d4rt (OPEN C.1 c/d): per-target
  /// interface-proxy coverage expansion. Four of the five C.1 activation
  /// targets — `RouteAware` (didPush/didPop/…), `HitTestTarget` (handleEvent),
  /// `NotchedShape`/`FloatingActionButtonLocation` (single-method) — forward
  /// **void** members. The `PROXY-A2-01..05` golden only exercises the non-void
  /// `int compareTo` path, so the void-forwarding path those targets rely on
  /// was unpinned. This group goldens it against `dart:core`'s `Sink<T>`
  /// (`void add(T data)` + `void close()`): a void method with an argument and
  /// a void method with none, plus the generic type parameter — the exact
  /// shapes `HitTestTarget.handleEvent` and `RouteAware.didPush` introduce.
  group('A2 void-return forwarding (Sink<T>)', () {
    late String generatedCode;
    late ProxyGenerationResult result;

    setUpAll(() async {
      final projectRoot = Directory.current.path;
      final tempDir =
          Directory.systemTemp.createTempSync('proxy_void_test_');
      final outputFile = p.join(tempDir.path, 'sink_proxy.b.dart');

      final config = BridgeConfig(
        name: 'proxy_void_template_test',
        d4rtImport: 'package:tom_d4rt/d4rt.dart',
        generateProxies: true,
        proxiesOutputPath: outputFile,
        proxyClasses: const [ProxyClassConfig(className: 'Sink')],
        modules: const [
          ModuleConfig(
            name: 'dart_core',
            barrelFiles: ['dart:core'],
            outputPath: 'unused_bridges.b.dart',
            barrelImport: 'dart:core',
          ),
        ],
      );

      result = await generateProxies(
        config: config,
        projectPath: projectRoot,
      );

      expect(result.errors, isEmpty,
          reason: 'Proxy generation should succeed for dart:core Sink');
      expect(result.outputFile, isNotNull);
      generatedCode = await File(result.outputFile!).readAsString();
    });

    test('PROXY-A2-06: emits a proxy class extending the abstract base, '
        'carrying the generic param. [2026-06-07] (PASS)', () {
      expect(generatedCode, contains('class D4rtSink<T> extends Sink<T>'));
    });

    test('PROXY-A2-07: void abstract methods become required void callbacks '
        '(with and without arguments). [2026-06-07] (PASS)', () {
      // `void add(T data)` → `final void Function(T) onAdd;`
      expect(generatedCode, contains('void Function(T) onAdd'));
      // `void close()` → `final void Function() onClose;`
      expect(generatedCode, contains('void Function() onClose'));
    });

    test('PROXY-A2-08: the void overrides forward to their callbacks. '
        '[2026-06-07] (PASS)', () {
      expect(generatedCode, contains('void add(T data)'));
      expect(generatedCode, contains('onAdd(data)'));
      expect(generatedCode, contains('void close()'));
      expect(generatedCode, contains('onClose()'));
    });

    test('PROXY-A2-09: the void factory delegation calls the script method but '
        'emits no return coercion (the void path). [2026-06-07] (PASS)', () {
      expect(generatedCode, contains("findInstanceMethod('add')"));
      expect(generatedCode, contains('.bind(instance).call(visitor,'));
      // The defining property of the void path: a void return must NOT be
      // run through `D4.extractBridgedArg` — the delegation calls and returns.
      expect(generatedCode, isNot(contains('extractBridgedArg<void>')));
      expect(generatedCode, contains("D4.registerInterfaceProxy('Sink'"));
    });
  });
}
