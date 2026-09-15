/// SCD145 — a native object no bridge claims must SAY SO, not report a missing
/// member.
///
/// THE SYMPTOM, recorded verbatim in F-SCC49-1's reason string because it was
/// actively misleading while debugging:
///
///     Undefined property or method 'moveNext' on _TallyIterator
///
/// The real cause is thrown at the end of `Environment.toBridgedClass` —
/// `Cannot bridge native object: No registered bridged class found for native
/// type …` — and then absorbed. `InterpreterVisitorExtension.toBridgedInstance`
/// catches everything, `revoke()`s it and returns `(null, false)`, which is a
/// CONTROL-FLOW signal its callers need: an internal interpreter value
/// (`BridgedEnum`, `BridgedClass`, an `InterpretedInstance`) legitimately has no
/// bridge, and those callers must fall through to other registries. So the catch
/// is right and the message is lost.
///
/// The member error is then raised at the end of the fallthrough chain, and it
/// points the reader at the member: they go looking for a missing method on a
/// bridge, when the bridge does not exist at all.
///
/// WHY THIS MATTERS MORE AFTER SCC49, NOT LESS. SCC49 made implementation types
/// named after their interface resolve structurally, so the population reaching
/// this path shrank to the hard residue — types the SDK abbreviates
/// (`_StreamSinkWrapper`, `_ControllerSubscription`) and types with no naming
/// relationship to any bridge at all. Those are exactly the cases where the
/// reader most needs the diagnostic to name the cause, and they are now the only
/// ones that produce it.
///
/// WHAT THIS CHANGES, AND WHAT IT DELIBERATELY DOES NOT. Only the MESSAGE, at
/// the two sites that raise the member error for a non-bridged receiver. Not the
/// exception type, not `memberName`, not `receiver`, and not the control flow —
/// `environment.dart`'s own note records why widening resolution instead broke
/// 43 enum-dispatch tests, because callers use the throw as a signal. A message
/// change on a path that is already failing cannot regress a passing one, which
/// is the same safety argument SCC49 made for its structural pass.
///
/// F-SCD145-4 and -5 are the controls: an internal interpreter value and a
/// genuinely-bridged object must not acquire the new wording.
///
/// Twin of `tom_d4rt_ast/test/runtime/scd145_unbridged_native_diagnostic_test.dart`.
@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const String _libUri = 'package:scd145/fixtures.dart';

/// Static holder for the fixture factories. Never instantiated.
class FixtureFactory {}

/// The native type behind the one registered bridge.
class NativeGadget {}

/// A native type NO bridge can reach, by any pass.
///
/// The name is load-bearing and deliberately meaningless. `toBridgedClass` has
/// three ways to claim a type by name — PASS A's suffix rule, PASS B's >=3-char
/// prefix fallback, and SCC49's structural end-with pass — plus `nativeNames`
/// and `isAssignable`. `Zqwx` shares no prefix and no suffix with `Gadget`, is in
/// no allowlist, and implements nothing, so every pass misses it. A fixture that
/// accidentally resolved would make this whole file pass while proving nothing,
/// which is the trap SCC49's own header warns about.
class Zqwx {
  int get tally => 5;
}

D4rt _interpreter() {
  final interpreter = D4rt();
  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: NativeGadget,
      name: 'Gadget',
      getters: {'bridgeName': (visitor, target) => 'Gadget'},
    ),
    _libUri,
    sourceUri: _libUri,
  );
  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: FixtureFactory,
      name: 'Fixtures',
      staticMethods: {
        'unclaimed': (visitor, positional, named, typeArgs) => Zqwx(),
        'gadget': (visitor, positional, named, typeArgs) => NativeGadget(),
      },
    ),
    _libUri,
    sourceUri: _libUri,
  );
  return interpreter;
}

Future<Object?> _run(String body) async => _interpreter().execute(
  source:
      '''
import '$_libUri';

dynamic main() {
$body
}
''',
);

/// The message of whatever [body] throws.
Future<String> _failureOf(String body) async {
  try {
    await _run(body);
  } catch (e) {
    return e.toString();
  }
  return '<did not throw>';
}

void main() {
  group('SCD145: an unbridged native object names its own cause', () {
    test('F-SCD145-1: the fixture really is unresolvable — every naming pass '
        'misses it [2026-09-15]', () async {
      // Anti-vacuity, and the failure this file is most exposed to. If `Zqwx`
      // resolved to `Gadget` by some pass, the calls below would succeed or
      // fail for an unrelated reason and every assertion would be vacuous.
      final failure = await _failureOf('return Fixtures.unclaimed().tally;');
      expect(
        failure,
        contains('Zqwx'),
        reason:
            'the fixture must reach the failing path at all. If this names '
            'Gadget instead, a naming pass claimed it and the fixture needs '
            'renaming — see the class doc.',
      );
    });

    test('F-SCD145-2: a member call on an unbridged native names the missing '
        'BRIDGE, not just the missing member [2026-09-15]', () async {
      final failure = await _failureOf('return Fixtures.unclaimed().tally;');
      expect(
        failure,
        contains('no bridged class is registered'),
        reason:
            'Pre-SCD145 this read "Undefined property or method \'tally\' on '
            'Zqwx", which sends the reader looking for a missing method on a '
            'bridge that does not exist. The member is undefined as a '
            'CONSEQUENCE. Measured message: $failure',
      );
    });

    test('F-SCD145-3: the member name is still reported, because it is still '
        'useful context [2026-09-15]', () async {
      // Augment, do not replace: the member says what the script tried, and
      // `memberName` on the exception is part of the contract other code
      // reads.
      final failure = await _failureOf('return Fixtures.unclaimed().tally;');
      expect(failure, contains('tally'));
    });

    test('F-SCD145-4 (control): a genuinely bridged object is unaffected '
        '[2026-09-15]', () async {
      // A working call must stay working, and a FAILING call on a bridged
      // object must keep the member wording — the new text would be a lie
      // there, since the bridge exists.
      expect(
        await _run('return Fixtures.gadget().bridgeName;'),
        equals('Gadget'),
      );
      final failure = await _failureOf(
        'return Fixtures.gadget().noSuchMember;',
      );
      expect(
        failure,
        isNot(contains('no bridged class is registered')),
        reason:
            '`Gadget` IS registered; the member really is the problem. '
            'Measured: $failure',
      );
    });

    test(
      'F-SCD145-5 (control): an interpreted object is unaffected [2026-09-15]',
      () async {
        // The case the absorbing catch exists for. A script-declared class has
        // no bridge and is not supposed to have one, so the new wording must
        // not appear.
        final failure = await _failureOf('''
  var o = Mine();
  return o.absent;
''').then((s) => s);
        expect(
          failure,
          isNot(contains('no bridged class is registered')),
          reason:
              'an interpreted instance legitimately has no bridge — saying so '
              'would be noise on every script typo. Measured: $failure',
        );
      },
    );
  });
}
