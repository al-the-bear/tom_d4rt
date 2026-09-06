import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

/// SCC78 mirror coverage for `tom_d4rt_ast` — a bridged instance reports its
/// own type, not the wrapper's.
///
/// **This tree was already correct, and that is the finding.** SCC78 was filed
/// against `tom_d4rt`, where `visitPropertyAccess` returned `target.runtimeType`
/// for a bridged instance — and `target` is the WRAPPER when the value arrives
/// already wrapped, so every bridged value reported `BridgedInstance<Object>`.
/// This tree has used `bridgedInstance.nativeObject.runtimeType` since GEN-075.
///
/// So the two `interpreter_visitor.dart` files disagreed on one line for as
/// long as both existed, and nothing noticed. The mirror rule says an
/// interpreter fix must land in both trees; it has no counterpart saying the
/// two must AGREE, and a divergence that arrives as a fix landing in only one
/// tree looks exactly like this one did.
///
/// The assertions are registration-level: this package has no parser, and
/// `tom_d4rt_exec` — the only runner that could execute a script against it —
/// resolves it from pub.dev. `BridgedInstance` is constructed directly instead,
/// which is what the interpreter does one step before the property read.
void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    Stdlib(env).register();
    IoStdlib.register(env);
  });

  /// What the interpreter wraps a native value in before reading a property.
  BridgedInstance wrap(Object native) {
    final instance = env.toBridgedInstance(native);
    expect(instance, isNotNull, reason: 'no bridge claims $native');
    return instance!;
  }

  group('SCC78: the wrapper does not answer for the value', () {
    test('F-SCC78-AST-1: the wrapper and its native disagree about '
        'runtimeType [2026-09-06]', () {
      // The defect in one line: reading `runtimeType` off the wrapper gives the
      // wrapper's type. Anything that answers from `target` rather than from
      // `nativeObject` returns THIS, for every bridged value in the language.
      final wrapped = wrap(StringBuffer());
      expect(wrapped.runtimeType.toString(), contains('BridgedInstance'));
      expect(
        wrapped.nativeObject.runtimeType.toString(),
        equals('StringBuffer'),
      );
    });

    test('F-SCC78-AST-2: two unrelated bridged types have different native '
        'runtimeTypes [2026-09-06]', () {
      // The discriminator the script-level twin uses, and the reason it needs
      // no type name: while the wrapper answered, these were equal.
      final a = wrap(StringBuffer());
      final b = wrap(const Duration(seconds: 1));
      expect(
        a.nativeObject.runtimeType,
        isNot(equals(b.nativeObject.runtimeType)),
      );
      // And the wrappers really are indistinguishable, which is what made the
      // defect invisible rather than merely wrong.
      expect(a.runtimeType, equals(b.runtimeType));
    });

    test('F-SCC78-AST-3: two instances of one type agree [2026-09-06]', () {
      expect(
        wrap(StringBuffer()).nativeObject.runtimeType,
        equals(wrap(StringBuffer()).nativeObject.runtimeType),
      );
    });

    test('F-SCC78-AST-4: a dart:io value reports a real type [2026-09-06]', () {
      // `File('x').runtimeType` is `_File` in the SDK. The private name is
      // deliberately not pinned — SCC24 established that naming an SDK-private
      // type trades this bug for a version-fragility bug — so what is asserted
      // is that it is not the wrapper and that two io types disagree.
      final file = wrap(File('x')).nativeObject.runtimeType.toString();
      final dir = wrap(Directory('x')).nativeObject.runtimeType.toString();
      expect(file, isNot(contains('BridgedInstance')));
      expect(dir, isNot(contains('BridgedInstance')));
      expect(file, isNot(equals(dir)));
    });

    test('F-SCC78-AST-5: hashCode has the same shape [2026-09-06]', () {
      // The sibling case in the same switch. `BridgedInstance` overrides
      // `hashCode` to delegate to the native (SCC32), so this one happens to
      // agree — which is worth pinning, because it is the reason the `hashCode`
      // half of the defect never showed and could be "fixed" back the wrong way
      // without anything failing.
      final buffer = StringBuffer();
      final wrapped = wrap(buffer);
      expect(wrapped.nativeObject.hashCode, equals(buffer.hashCode));
      expect(wrapped.hashCode, equals(buffer.hashCode));
    });
  });
}
