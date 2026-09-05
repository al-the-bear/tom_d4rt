/// SCC46: a NATIVE enum value must resolve to its bridged enum, never to a
/// bridged class whose name happens to be a prefix of the enum's.
///
/// `Environment.getRuntimeType` handles `BridgedEnumValue` (the wrapped form)
/// but had no branch for a raw native `Enum` arriving from a bridge return or
/// an argument. Such a value fell through to `toBridgedClass`, whose PASS B
/// fuzzy fallback matches any bridge name that is a >=3-char prefix of the
/// native type name. Flutter's registry is full of such pairs:
///
/// | native enum          | bridged class it was captured by |
/// | -------------------- | -------------------------------- |
/// | `TextDirection`      | `Text`                           |
/// | `ThemeMode`          | `Theme`                          |
/// | `BorderStyle`        | `Border`                         |
/// | `CupertinoButtonSize`| `CupertinoButton`                |
///
/// The visible damage was in the declared-parameter type check, which reported
/// `type 'Text' is not a subtype of type 'TextDirection' of 'dir'` for a
/// perfectly correct call — eight scripts of `flutter_base_01` alone.
///
/// Twin of `tom_d4rt_ast/test/scc46_native_enum_runtime_type_test.dart`, plus
/// the end-to-end script check this line can run and the AST line cannot.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
// `BridgedEnum` is not re-exported from `d4rt.dart` on this line, although the
// AST twin's `runtime.dart` does export it. Imported directly rather than
// widening the public surface as a side effect of a test.
import 'package:tom_d4rt/src/bridge/bridged_enum.dart';

/// Stands in for Flutter's `TextDirection`. The name matters: the bug is a
/// prefix collision, so the enum's native type name must begin with the
/// bridged class's registered name.
enum TextDirection { ltr, rtl }

/// Stands in for Flutter's `Text` widget — the shorter name that PASS B's
/// prefix fallback wrongly claimed.
class Text {
  const Text(this.data, {this.direction = TextDirection.ltr});
  final String data;
  final TextDirection direction;
}

/// A native enum with NO name collision, to prove the fix is not merely
/// "return the enum when a class also matched".
enum Alignment { start, end }

BridgedEnumDefinition<TextDirection> _textDirectionDefinition() =>
    BridgedEnumDefinition<TextDirection>(
      name: 'TextDirection',
      values: TextDirection.values,
    );

Environment _envWithCollidingBridges() {
  final env = Environment();
  env.defineBridge(BridgedClass(nativeType: Text, name: 'Text'));
  env.defineBridgedEnum(_textDirectionDefinition().buildBridgedEnum());
  env.defineBridgedEnum(
    BridgedEnumDefinition<Alignment>(
      name: 'Alignment',
      values: Alignment.values,
    ).buildBridgedEnum(),
  );
  return env;
}

void main() {
  group('SCC46: native enum runtime type', () {
    test(
      'F-SCC46-1: a native enum value resolves to its bridged enum, not to a '
      'bridged class whose name is a prefix of it',
      () {
        final env = _envWithCollidingBridges();

        final type = env.getRuntimeType(TextDirection.ltr);

        expect(
          type,
          isNotNull,
          reason: 'a registered enum value must have a runtime type',
        );
        expect(
          type!.name,
          'TextDirection',
          reason:
              'PASS B prefix matching resolved this to the Text bridge, which '
              'made every declared `TextDirection` parameter reject a correct '
              'argument',
        );
        expect(type, isA<BridgedEnum>());
      },
    );

    test('F-SCC46-2: an uncontested native enum value still resolves', () {
      final env = _envWithCollidingBridges();

      final type = env.getRuntimeType(Alignment.end);

      expect(type, isNotNull);
      expect(type!.name, 'Alignment');
      expect(type, isA<BridgedEnum>());
    });

    test('F-SCC46-3: the bridged class itself is unaffected — a Text instance '
        'still resolves to Text', () {
      final env = _envWithCollidingBridges();

      final type = env.getRuntimeType(const Text('hello'));

      expect(type, isNotNull);
      expect(type!.name, 'Text');
      expect(type, isA<BridgedClass>());
    });

    test(
      'F-SCC46-4: a script-level enum literal satisfies a declared parameter '
      'of that enum type when a prefix-colliding class is also bridged',
      () {
        final d4rt = D4rt();
        d4rt.registerBridgedClass(
          BridgedClass(nativeType: Text, name: 'Text'),
          'package:fixture/fixture.dart',
        );
        d4rt.registerBridgedEnum(
          _textDirectionDefinition(),
          'package:fixture/fixture.dart',
        );

        final result = d4rt.execute(
          source: '''
            import 'package:fixture/fixture.dart';

            String describe(TextDirection dir) => 'got \${dir.name}';

            main() {
              return describe(TextDirection.ltr);
            }
          ''',
        );

        expect(result, 'got ltr');
      },
    );
  });
}
