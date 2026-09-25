/// SCE178 — the two private SDK types the Stream bridge used to claim resolve
/// to the bridge they actually belong to, in the LIVE registry.
///
/// Measured with the SDK: `_StreamIterator` is what `StreamIterator(...)`
/// returns and `_HandlerEventSink` implements `EventSink`; neither is a Stream.
/// Both were on the Stream bridge's `nativeNames`. The first was inert, because
/// its name reaches `StreamIterator` first. The second was ALSO on EventSink's
/// list, and registration order made the Stream entry win, so the live
/// registry answered `Stream` for a type that is not one.
///
/// `_HandlerEventSink` never reaches script code (the SDK builds it inside
/// `StreamTransformer.fromHandlers` and consumes it itself), so the classes
/// below borrow the private names: resolution goes by the runtime type's NAME,
/// which is exactly what these reproduce. The same technique as SCF26's test.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

// ignore: unused_element
class _HandlerEventSink<S, T> {}

// ignore: unused_element
class _StreamIterator<T> {}

void main() {
  late Environment env;

  setUpAll(() {
    final runner = D4rtRunner()..warmup();
    final bundle = AstBundle(
      entryPointUri: 'package:t/main.dart',
      modules: {
        'package:t/main.dart': SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            SFunctionDeclaration(
              offset: 1,
              length: 4,
              name: SSimpleIdentifier(offset: 2, length: 4, name: 'main'),
              functionExpression: SFunctionExpression(
                offset: 3,
                length: 1,
                parameters: SFormalParameterList(offset: 4, length: 1),
                body: SExpressionFunctionBody(
                  offset: 5,
                  length: 1,
                  expression: SIntegerLiteral(offset: 6, length: 1, value: 1),
                ),
              ),
            ),
          ],
        ),
      },
    );
    runner.executeBundleAs<Object?>(bundle, name: 'main');
    env = runner.visitor!.globalEnvironment;
  });

  group('SCE178: the Stream bridge claims no non-Stream', () {
    test('F-SCE178-AST-1: _HandlerEventSink resolves to EventSink '
        '[2026-09-25]', () {
      expect(
        env.toBridgedClass(_HandlerEventSink<int, int>().runtimeType).name,
        'EventSink',
      );
    });

    test('F-SCE178-AST-2 (control): _StreamIterator resolves to StreamIterator '
        '[2026-09-25]', () {
      expect(
        env.toBridgedClass(_StreamIterator<int>().runtimeType).name,
        'StreamIterator',
      );
    });
  });
}
