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
/// The visible damage was in the declared-parameter type check
/// (`callable.dart` `_checkArgumentType`), which reported
/// `type 'Text' is not a subtype of type 'TextDirection' of 'dir'` for a
/// perfectly correct call — eight scripts of `flutter_base_01` alone.
///
/// Twin of `tom_d4rt/test/scc46_native_enum_runtime_type_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// Stands in for Flutter's `TextDirection`. The name matters: the bug is a
/// prefix collision, so the enum's native type name must begin with the
/// bridged class's registered name.
enum TextDirection { ltr, rtl }

/// Stands in for Flutter's `Text` widget — the shorter name that PASS B's
/// prefix fallback wrongly claimed.
class Text {
  const Text(this.data);
  final String data;
}

/// A native enum with NO name collision, to prove the fix is not merely
/// "return the enum when a class also matched".
enum Alignment { start, end }

Environment _envWithCollidingBridges() {
  final env = Environment();
  env.defineBridge(BridgedClass(nativeType: Text, name: 'Text'));
  env.defineBridgedEnum(
    BridgedEnumDefinition<TextDirection>(
      name: 'TextDirection',
      values: TextDirection.values,
    ).buildBridgedEnum(),
  );
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
  });
}
