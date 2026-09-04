/// Tests for the thunk-capable bridge registry (import-optimization plan
/// step #3). A bridged class registered via [Environment.defineBridgeLazy] is
/// stored as a deferred `() => BridgedClass` thunk and built — then memoized —
/// only when the name (or native type) is first resolved.
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A trivial native type used as a bridge target.
class _Widget {
  final String label;
  _Widget(this.label);
}

/// A second native type for the same-name collision case.
class _OtherWidget {
  const _OtherWidget();
}

void main() {
  group('IMP-OPT-3: thunk-capable bridge registry', () {
    test(
      'IMP-OPT-3a: defineBridgeLazy defers construction until first lookup',
      () {
        final env = Environment();
        var builds = 0;
        env.defineBridgeLazy('Widget', _Widget, () {
          builds++;
          return BridgedClass(nativeType: _Widget, name: 'Widget');
        });

        // Registration alone must not build the class.
        expect(builds, 0, reason: 'thunk must not run at registration time');

        final resolved = env.findBridgedClassByName('Widget');
        expect(resolved, isNotNull);
        expect(resolved!.name, 'Widget');
        expect(builds, 1, reason: 'first lookup builds the class exactly once');
      },
    );

    test('IMP-OPT-3b: lookup memoizes — the thunk runs at most once', () {
      final env = Environment();
      var builds = 0;
      env.defineBridgeLazy('Widget', _Widget, () {
        builds++;
        return BridgedClass(nativeType: _Widget, name: 'Widget');
      });

      final first = env.findBridgedClassByName('Widget');
      final second = env.findBridgedClassByName('Widget');
      final third = env.findBridgedClassByName('Widget');

      expect(builds, 1, reason: 'subsequent lookups serve the memoized class');
      expect(identical(first, second), isTrue);
      expect(identical(second, third), isTrue);
    });

    test('IMP-OPT-3c: thunk resolves across the enclosing scope chain', () {
      final parent = Environment();
      final child = Environment(enclosing: parent);
      var builds = 0;
      parent.defineBridgeLazy('Widget', _Widget, () {
        builds++;
        return BridgedClass(nativeType: _Widget, name: 'Widget');
      });

      expect(builds, 0);
      final resolved = child.findBridgedClassByName('Widget');
      expect(resolved, isNotNull);
      expect(builds, 1, reason: 'child lookup walks up and builds once');
    });

    test(
      'IMP-OPT-3d: defineBridge (eager API) routes through the thunk + memo',
      () {
        final env = Environment();
        final built = BridgedClass(nativeType: _Widget, name: 'Widget');
        env.defineBridge(built);

        final first = env.findBridgedClassByName('Widget');
        final second = env.findBridgedClassByName('Widget');
        expect(
          identical(first, built),
          isTrue,
          reason: 'eager registration serves the same instance',
        );
        expect(identical(first, second), isTrue);
      },
    );

    test('IMP-OPT-3e: same-name collision preserves the displaced bridge', () {
      final env = Environment();
      final first = BridgedClass(nativeType: _Widget, name: 'Widget');
      final second = BridgedClass(nativeType: _OtherWidget, name: 'Widget');
      env.defineBridge(first);
      env.defineBridge(second);

      // Last registration wins as the primary.
      expect(identical(env.findBridgedClassByName('Widget'), second), isTrue);
      // The displaced bridge is still reachable for static/constructor fallback.
      final all = env.findAllBridgedClassesByName('Widget');
      expect(all, containsAll(<BridgedClass>[first, second]));
    });
  });

  group('AMBIG: same simple name declared by two libraries', () {
    // The bridge corpus imports every package barrel unprefixed, so two
    // packages that each declare a `MarkdownParser` put one name on two
    // classes. Dart's answer is to reject the bare name and demand a prefix;
    // these tests pin that answer down for the bridge registry.
    const scannerUri = 'package:tom_doc_scanner/src/markdown_parser.dart';
    const latexUri = 'package:tom_md2latex/src/markdown_parser.dart';

    Environment envWithBothParsers() {
      final env = Environment();
      env.defineBridge(
        BridgedClass(nativeType: _Widget, name: 'MarkdownParser'),
        sourceUri: scannerUri,
      );
      env.defineBridge(
        BridgedClass(nativeType: _OtherWidget, name: 'MarkdownParser'),
        sourceUri: latexUri,
      );
      return env;
    }

    test(
      'AMBIG-1: both classes stay reachable, each under its package name',
      () {
        final env = envWithBothParsers();

        final scanner = env.get('tom_doc_scanner.MarkdownParser');
        final latex = env.get('tom_md2latex.MarkdownParser');

        expect(scanner, isA<BridgedClass>());
        expect(latex, isA<BridgedClass>());
        expect((scanner as BridgedClass).nativeType, _Widget);
        expect((latex as BridgedClass).nativeType, _OtherWidget);
      },
    );

    test('AMBIG-2: the bare name is an error, not an arbitrary pick', () {
      final env = envWithBothParsers();

      expect(
        () => env.get('MarkdownParser'),
        throwsA(
          isA<AmbiguousBridgedNameException>().having(
            (e) => e.candidatesByQualifier.keys,
            'qualifiers',
            containsAll(<String>['tom_doc_scanner', 'tom_md2latex']),
          ),
        ),
      );
    });

    test('AMBIG-3: the error names both candidates and how to qualify', () {
      final env = envWithBothParsers();

      expect(
        () => env.get('MarkdownParser'),
        throwsA(
          isA<AmbiguousBridgedNameException>()
              .having((e) => e.message, 'message', contains(scannerUri))
              .having((e) => e.message, 'message', contains(latexUri))
              .having(
                (e) => e.message,
                'message',
                contains('tom_md2latex.MarkdownParser'),
              ),
        ),
      );
    });

    test('AMBIG-4: the same class re-registered via a second barrel is not '
        'ambiguous', () {
      // A re-export delivers one class twice. Same nativeType ⇒ one class ⇒
      // the bare name still designates exactly what the author expects.
      final env = Environment();
      env.defineBridge(
        BridgedClass(nativeType: _Widget, name: 'Widget'),
        sourceUri: 'package:tom_basics/src/widget.dart',
      );
      env.defineBridge(
        BridgedClass(nativeType: _Widget, name: 'Widget'),
        sourceUri: 'package:tom_basics/src/widget.dart',
      );

      expect(env.get('Widget'), isA<BridgedClass>());
    });

    test('AMBIG-5: a collision that cannot be qualified keeps last-wins', () {
      // No source URIs ⇒ no qualifier ⇒ no remedy. Rejecting the name here
      // would strand the script, so the legacy behaviour stands.
      final env = Environment();
      final first = BridgedClass(nativeType: _Widget, name: 'Widget');
      final second = BridgedClass(nativeType: _OtherWidget, name: 'Widget');
      env.defineBridge(first);
      env.defineBridge(second);

      expect(identical(env.get('Widget'), second), isTrue);
    });

    test('AMBIG-6: ambiguity survives an import into another environment', () {
      final target = Environment()..importEnvironment(envWithBothParsers());

      expect(
        () => target.get('MarkdownParser'),
        throwsA(isA<AmbiguousBridgedNameException>()),
      );
      expect(target.get('tom_doc_scanner.MarkdownParser'), isA<BridgedClass>());
    });
  });

  group('AMBIG-PLATFORM: a dart: declaration loses to a package: one', () {
    // Dart's platform-library precedence: when one library is a platform
    // (`dart:*`) library and the other is not, the non-platform declaration
    // shadows it silently — the bare name is NOT ambiguous. `dart:ui.TextStyle`
    // and `package:flutter/src/painting/text_style.dart`'s `TextStyle` are two
    // different classes, yet this is legal Dart and means painting's:
    //
    //   import 'dart:ui';
    //   import 'package:flutter/widgets.dart';
    //   const TextStyle(fontSize: 24.0).copyWith(fontSize: 2.0);
    //
    // `copyWith` exists only on painting's TextStyle, and `dart analyze`
    // accepts the snippet while calling the `dart:ui` import *unnecessary*.
    // Treating the pair as ambiguous rejects every Flutter script that names a
    // type dart:ui also declares.
    const uiUri = 'dart:ui';
    const paintingUri = 'package:flutter/src/painting/text_style.dart';

    test('AMBIG-P1: the package declaration wins when it registers second', () {
      final env = Environment();
      final ui = BridgedClass(nativeType: _Widget, name: 'TextStyle');
      final painting = BridgedClass(
        nativeType: _OtherWidget,
        name: 'TextStyle',
      );
      env.defineBridge(ui, sourceUri: uiUri);
      env.defineBridge(painting, sourceUri: paintingUri);

      expect(
        identical(env.get('TextStyle'), painting),
        isTrue,
        reason: 'the non-platform declaration holds the bare name',
      );
    });

    test('AMBIG-P2: the package declaration wins when it registers FIRST', () {
      // Registration order is an accident of how the bridge modules are
      // enumerated, so precedence must not depend on it.
      final env = Environment();
      final painting = BridgedClass(
        nativeType: _OtherWidget,
        name: 'TextStyle',
      );
      final ui = BridgedClass(nativeType: _Widget, name: 'TextStyle');
      env.defineBridge(painting, sourceUri: paintingUri);
      env.defineBridge(ui, sourceUri: uiUri);

      expect(
        identical(env.get('TextStyle'), painting),
        isTrue,
        reason: 'a later dart: registration must not steal the bare name',
      );
    });

    test('AMBIG-P3: the shadowed dart: class stays reachable by qualifier', () {
      // Nothing is lost by preferring the package declaration — the platform
      // one is still addressable, exactly as `ui.TextStyle` addresses it in
      // real Dart.
      final env = Environment();
      final ui = BridgedClass(nativeType: _Widget, name: 'TextStyle');
      final painting = BridgedClass(
        nativeType: _OtherWidget,
        name: 'TextStyle',
      );
      env.defineBridge(ui, sourceUri: uiUri);
      env.defineBridge(painting, sourceUri: paintingUri);

      final qualified = env.get('ui.TextStyle');
      expect(qualified, isA<BridgedClass>());
      expect((qualified as BridgedClass).nativeType, _Widget);
    });

    test('AMBIG-P4: two dart: libraries remain ambiguous with each other', () {
      // The rule is platform-vs-non-platform. Two platform libraries are peers,
      // so the bare name has no winner and must still be rejected.
      final env = Environment();
      env.defineBridge(
        BridgedClass(nativeType: _Widget, name: 'Codec'),
        sourceUri: 'dart:convert',
      );
      env.defineBridge(
        BridgedClass(nativeType: _OtherWidget, name: 'Codec'),
        sourceUri: 'dart:ui',
      );

      expect(
        () => env.get('Codec'),
        throwsA(isA<AmbiguousBridgedNameException>()),
      );
    });

    test('AMBIG-P5: platform precedence survives an import', () {
      final source = Environment();
      final ui = BridgedClass(nativeType: _Widget, name: 'TextStyle');
      final painting = BridgedClass(
        nativeType: _OtherWidget,
        name: 'TextStyle',
      );
      source.defineBridge(ui, sourceUri: uiUri);
      source.defineBridge(painting, sourceUri: paintingUri);

      final target = Environment()..importEnvironment(source);

      expect(identical(target.get('TextStyle'), painting), isTrue);
    });
  });

  group('IMP-OPT-17: N-of-M lazy materialization (build counter)', () {
    test('IMP-OPT-17a: resolving N of M registered thunks builds exactly N', () {
      // Models the generator's lazy emission: M classes registered as deferred
      // factory thunks, each incrementing a shared build counter when built.
      const total = 2064; // mirrors the flutter-material corpus size
      const used = 7;
      final env = Environment();
      var builds = 0;
      for (var i = 0; i < total; i++) {
        final name = 'Cls$i';
        env.defineBridgeLazy(name, Object, () {
          builds++;
          return BridgedClass(nativeType: Object, name: name);
        });
      }

      // Registration of all M classes must not build a single one.
      expect(builds, 0, reason: 'registering thunks must not build classes');

      // A "script" resolves only `used` of them, by name.
      for (var i = 0; i < used; i++) {
        final resolved = env.findBridgedClassByName('Cls$i');
        expect(resolved, isNotNull);
      }

      expect(
        builds,
        used,
        reason: 'only the resolved classes are materialized (≈N of M)',
      );
    });
  });
}
