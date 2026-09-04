import 'package:test/test.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`,
// so they are reached directly — as in the other AST-side stdlib tests. They
// re-export `Environment`, which is all this file needs besides them.
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

/// SCB26 mirror coverage for `tom_d4rt_ast` — `StringSink` must be owned by
/// exactly one registrar.
///
/// The AST tree carried the same duplicate: `StringSinkIo` from the io
/// registrar shadowing `StringSinkCore` on last-wins, with the io copy a strict
/// subset (no `toString`, no `hashCode`, no getters at all). Registration-level
/// here as in the source tree, since `StringSink` has no script-reachable
/// instance — and additionally because `tom_d4rt_exec` resolves
/// `tom_d4rt_ast` from pub.dev rather than by path (DGUC6), so no script-level
/// runner can see unpublished local edits to this tree at all.
void main() {
  const coreMethods = <String>{
    'hashCode',
    'toString',
    'write',
    'writeAll',
    'writeCharCode',
    'writeln',
  };
  const coreGetters = <String>{'hashCode', 'runtimeType'};

  Environment coreOnly() {
    final env = Environment();
    CoreStdlib.register(env);
    return env;
  }

  group('SCB26: StringSink has a single owning registrar', () {
    test(
      'F-SCB26-AST-1: dart:core declares the full member set [2026-09-03]',
      () {
        final sink = coreOnly().findBridgedClassByName('StringSink');
        expect(sink, isNotNull);
        expect(sink!.methods.keys, unorderedEquals(coreMethods));
        expect(sink.getters.keys, unorderedEquals(coreGetters));
      },
    );

    test('F-SCB26-AST-2: registering the io stdlib after core does not narrow '
        'StringSink [2026-09-03]', () {
      final env = coreOnly();
      IoStdlib.register(env);
      final sink = env.findBridgedClassByName('StringSink');
      expect(sink, isNotNull);
      expect(sink!.methods.keys, unorderedEquals(coreMethods));
      expect(sink.getters.keys, unorderedEquals(coreGetters));
    });

    test('F-SCB26-AST-3: exactly one StringSink definition is registered '
        '[2026-09-03]', () {
      final env = coreOnly();
      IoStdlib.register(env);
      expect(env.findAllBridgedClassesByName('StringSink'), hasLength(1));
    });

    test('F-SCB26-AST-4: the io registrar does not own StringSink at all '
        '[2026-09-03]', () {
      final ioOnly = Environment();
      IoStdlib.register(ioOnly);
      expect(ioOnly.findBridgedClassByName('StringSink'), isNull);
    });
  });
}
