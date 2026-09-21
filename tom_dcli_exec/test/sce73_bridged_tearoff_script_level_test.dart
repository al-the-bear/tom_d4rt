// SCE73: a bridged tear-off reaches a dcli bridged callback parameter.
//
// SCD35 widened every callback coercion in the interpreter twins' `stdlib`
// from `InterpretedFunction` to `Callable`, so a tear-off of a BRIDGED method
// — `seen.add`, where `seen` is a script-level `<String>[]` — is accepted
// wherever a function is expected. The generated bridges were a separate
// surface: a `.b.dart` that guards with `positionalArgs[0] is!
// InterpretedFunction` rejects the same tear-off, because it evaluates to a
// `BridgedMethodCallable` rather than an interpreted closure.
//
// The dcli bridges carried that shape and no longer do: every callback the
// generator emits now routes through `D4.callInterpreterCallback`, which
// dispatches on `Callable`. Nothing asserted it FROM A SCRIPT, which is the
// only place the question is real — the package's existing `forEach` coverage
// calls the dcli extension from native Dart and so never crosses the bridge.
//
// WHY THE BARE TEAR-OFF IS THE ASSERTION AND THE LAMBDA IS ONLY A CONTROL:
// `(l) => seen.add(l)` is an InterpretedFunction and passes even with the
// defect fully present. A suite written that way is green and blind, which is
// how this class of bug survived long enough to be found twice.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/tom_d4rt_exec.dart';
import 'package:tom_dcli_exec/dartscript.b.dart';

Object? _run(String body) {
  final d4rt = D4rt()
    ..grant(FilesystemPermission.any)
    ..grant(ProcessRunPermission.any);
  TomD4rtDcliBridge.register(d4rt);
  return d4rt.execute(source: body);
}

void main() {
  group('SCE73: a bridged tear-off is accepted by a dcli bridged callback', () {
    test('F-SCE73G-1: `forEach(seen.add)` — the bare tear-off [2026-09-21] '
        '(PASS)', () {
      expect(
        _run('''
import 'package:dcli/dcli.dart';
main() {
  var seen = <String>[];
  'echo hello'.forEach(seen.add);
  return seen.join(",");
}'''),
        'hello',
        reason:
            '`seen.add` is a tear-off of a BRIDGED method, so it evaluates to '
            'a BridgedMethodCallable. A bridge that narrows its callback '
            'parameter to InterpretedFunction rejects it with "type '
            "'BridgedMethodCallable' is not a subtype of type "
            '\'InterpretedFunction\'".',
      );
    });

    test('F-SCE73G-2 (control): the lambda-wrapped form passes too, and is '
        'why it cannot stand in for the case above [2026-09-21] (PASS)', () {
      // This one passed throughout the defect's whole lifetime. It is here to
      // record that it proves nothing on its own — not as extra coverage.
      expect(
        _run('''
import 'package:dcli/dcli.dart';
main() {
  var seen = <String>[];
  'echo hello'.forEach((l) => seen.add(l));
  return seen.join(",");
}'''),
        'hello',
      );
    });
  });
}
