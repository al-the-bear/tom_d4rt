// SC11: the "Intentionally-Unbridged SDK Classes" section of
// doc/d4rt_limitations.md makes a claim about the code — that these names are
// absent on purpose. Prose cannot hold that claim: the moment someone bridges
// one of them the doc starts lying, and a limitations doc that lies is worse
// than no limitations doc.
//
// So the section is pinned here. Each case asserts the name is unresolvable
// AND that the failure is the message the doc tells readers to search for.
//
// IF ONE OF THESE FAILS you have probably just bridged the class — which is
// allowed, and for the "deferred pending a concrete consumer" group it is the
// expected end state. The fix is not to loosen the test: move the row out of
// the doc's table and delete the case here, in the same change.
//
// SCB29 added the SIMD group and, with it, the rule that makes this file
// complete rather than merely correct: every unbridged SDK name the gap audit
// records must carry a disposition — a tracked todo, or a row in the
// limitations table with a case here. The SIMD block had neither, which is
// why it went nine names unmissed. See the audit's "Disposition" rule in
// doc/stdlib_sdk_gap_audit.md § Recommended next actions.

// SCB30 made the message carry the decision rather than only the absence:
// `Undefined variable: Zone` now continues with `(not bridged: …; see
// doc/d4rt_limitations.md)`. The prefix is deliberately unchanged — it is what
// the cases below match on and what the doc tells readers to grep — so the
// suffix is purely additive and no existing case needed editing. It is pinned
// in its own group at the bottom.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/src/unbridged_reasons.dart';

import '../interpreter_test.dart';

void main() {
  /// Asserts that [expression] fails because [reported] is not defined.
  ///
  /// [reported] is the identifier the interpreter names — which is not always
  /// the class. A script reaches `Zone` by writing `runZoned`, and the
  /// `dart:io` compression codecs by writing the `gzip` / `zlib` globals, so
  /// those are the names a reader actually greps for.
  void expectUnbridged(String expression, String reported, {String? imports}) {
    final source =
        '''
      ${imports ?? ''}
      main() {
        return $expression;
      }
    ''';
    expect(
      () => execute(source),
      throwsRuntimeError(contains('Undefined variable: $reported')),
    );
  }

  group('SC11: cannot be honoured meaningfully', () {
    test(
      'F-SC11-1: Zone is unreachable, including via runZoned [2026-07-27]',
      () {
        // Three names, one decision: scripts almost never write `Zone` directly,
        // so the doc has to be findable from the runZoned* spellings too.
        expectUnbridged(
          'Zone.current',
          'Zone',
          imports: "import 'dart:async';",
        );
        expectUnbridged(
          'runZoned(() => 1)',
          'runZoned',
          imports: "import 'dart:async';",
        );
        expectUnbridged(
          'runZonedGuarded(() => 1, (e, s) {})',
          'runZonedGuarded',
          imports: "import 'dart:async';",
        );
        // Anchor: without this the three above would also pass if `dart:async`
        // were simply unreachable, and the claim would be vacuous.
        const anchor = '''
      import 'dart:async';
      main() => Completer<int>().isCompleted;
      ''';
        expect(execute(anchor), isFalse);
      },
    );

    test('F-SC11-2: the identity/GC trio is unreachable [2026-07-27]', () {
      // Expando, WeakReference and Finalizer all depend on native object
      // identity or GC timing, neither of which survives the bridge boundary.
      expectUnbridged('Expando()', 'Expando');
      expectUnbridged('WeakReference(Object())', 'WeakReference');
      expectUnbridged('Finalizer((v) {})', 'Finalizer');
    });

    test('F-SCC74-3: the file-descriptor-passing trio is unreachable '
        '[2026-09-06]', () {
      // Refused for the same reason as `HttpOverrides` rather than for a
      // technical one: a `ResourceHandle` is a raw OS file descriptor, and a
      // script holding one has a working handle to a file or socket that no
      // permission check ever saw named. The two `RawSocket` members that would
      // produce them are pinned separately by F-SCC74-1, as missing members on
      // a class that IS bridged.
      const io = "import 'dart:io';";
      expectUnbridged('SocketMessage([], [])', 'SocketMessage', imports: io);
      expectUnbridged(
        'SocketControlMessage.fromHandles([])',
        'SocketControlMessage',
        imports: io,
      );
      expectUnbridged(
        'ResourceHandle.fromFile(File("x"))',
        'ResourceHandle',
        imports: io,
      );
    });

    test('F-SC11-7: HttpOverrides is unreachable under every spelling '
        '[2026-09-06]', () {
      // The odd one out in this group: nothing about `HttpOverrides` resists
      // bridging technically — it is refused because the capability it grants
      // *is* the sandbox escape. `global` swaps the HttpClient implementation
      // process-wide and outlives the script that set it.
      const io = "import 'dart:io';";
      expectUnbridged('HttpOverrides.current', 'HttpOverrides', imports: io);
      expectUnbridged(
        'HttpOverrides.runZoned(() => 1)',
        'HttpOverrides',
        imports: io,
      );
      // The anchor that keeps the row honest: HTTP itself is bridged, so this
      // is a refusal of one hook and not of the library it lives in. Without
      // it the case above would also pass if `dart:io`'s HTTP surface were
      // simply missing, which is the opposite of what the doc claims.
      const anchor = '''
      import 'dart:io';
      main() => HttpClient().userAgent == null;
      ''';
      expect(execute(anchor), isFalse);
    });
  });

  group('SCC65: not a class, so there is nothing to bridge', () {
    test('F-SCC65-22: BadCertificateCallback is unreachable as a name '
        '[2026-09-06]', () {
      expectUnbridged(
        'BadCertificateCallback',
        'BadCertificateCallback',
        imports: "import 'dart:io';",
      );
    });

    test('F-SCC65-23: everything a script does with the alias works without it '
        '[2026-09-06]', () {
      // This is the case that makes the doc row honest rather than merely
      // true. The row's justification is not "we could not build it" — it is
      // "the name buys a script nothing", and that claim is only worth
      // anything if the two things a script would use the alias FOR both work
      // while the name is undefined.
      //
      // First: the setter takes a plain function value, with no reference to
      // the alias anywhere. The SDK declares it with the inline function type
      // too, so this matches the platform rather than working around it.
      const assignment = '''
      import 'dart:io';
      main() {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => false;
        return 'assigned';
      }
      ''';
      expect(execute(assignment), equals('assigned'));

      // Second: the alias is usable as an annotation while undefined, because
      // the interpreter does not resolve type annotations at all. A script
      // pasted from SDK documentation therefore runs unchanged — which is the
      // only way a reader would meet the name in practice.
      const annotated = '''
      import 'dart:io';
      bool check(X509Certificate c, String h, int p) => false;
      main() {
        BadCertificateCallback cb = check;
        return cb('cert', 'host', 443);
      }
      ''';
      expect(execute(annotated), isFalse);
    });
  });

  group('SC11: deferred pending a concrete consumer', () {
    test('F-SC11-3: the dart:io entries are unreachable [2026-07-27]', () {
      // `Link` is the last of them. `WebSocket` and the four names around it
      // were asserted here until they were bridged; the assertion went with
      // them, because this file pins the *doc's* deferred table and a name that
      // has been built is no longer in it. That is the mechanism working —
      // F-SCB30-3 derives the expected key set from the table, so removing the
      // row without removing this case would have failed rather than gone
      // quiet.
      expectUnbridged("Link('x')", 'Link', imports: "import 'dart:io';");
    });

    test('F-SC11-4: the compression codecs are unreachable under every '
        'spelling [2026-07-27]', () {
      // The globals matter more than the class names here — `gzip.encode(...)`
      // is what a script writes, and it is the message that sends a reader to
      // the doc. Unrelated to the gzip AstBundle uses internally, which is
      // below the bridge boundary and gives scripts nothing.
      expectUnbridged(
        'gzip.encode([1, 2, 3])',
        'gzip',
        imports: "import 'dart:io';",
      );
      expectUnbridged(
        'zlib.encode([1, 2, 3])',
        'zlib',
        imports: "import 'dart:io';",
      );
      expectUnbridged('GZipCodec()', 'GZipCodec', imports: "import 'dart:io';");
      expectUnbridged('ZLibCodec()', 'ZLibCodec', imports: "import 'dart:io';");
      expectUnbridged(
        'ZLibEncoder()',
        'ZLibEncoder',
        imports: "import 'dart:io';",
      );
      expectUnbridged(
        'ZLibDecoder()',
        'ZLibDecoder',
        imports: "import 'dart:io';",
      );
    });

    test('F-SC11-5: MutableRectangle is unreachable but Rectangle covers the '
        'common case [2026-07-27]', () {
      // The second half is the doc's stated justification for deferring the
      // mutable variant, so it has to hold for the row to stay honest.
      expectUnbridged(
        'MutableRectangle(0, 0, 1, 1)',
        'MutableRectangle',
        imports: "import 'dart:math';",
      );
      const source = '''
      import 'dart:math';
      main() {
        final r = Rectangle(0, 0, 4, 3);
        return [r.width, r.height, r.right, r.bottom];
      }
      ''';
      expect(execute(source), equals([4, 3, 4, 3]));
    });
  });

  group('SCB29: the SIMD block', () {
    // SCB29 found this block unbridged, untracked and undocumented — the
    // "neither" state the reconciliation exists to remove. It is nine names,
    // not the three the gap audit's ByteBuffer row implied: the scalars, the
    // three lists built from them, and the three views that return those.
    test('F-SCB29-1: the three SIMD scalars are unreachable [2026-09-03]', () {
      const td = "import 'dart:typed_data';";
      expectUnbridged('Float32x4(1, 2, 3, 4)', 'Float32x4', imports: td);
      expectUnbridged('Int32x4(1, 2, 3, 4)', 'Int32x4', imports: td);
      expectUnbridged('Float64x2(1, 2)', 'Float64x2', imports: td);
    });

    test('F-SCB29-2: the three SIMD lists are unreachable too — the audit '
        'named only the scalars [2026-09-03]', () {
      // These are the reason the count is nine rather than six: they are
      // typed-data views like the eleven that ARE bridged, so their absence
      // reads as an oversight in that set rather than as this decision.
      const td = "import 'dart:typed_data';";
      expectUnbridged('Float32x4List(2)', 'Float32x4List', imports: td);
      expectUnbridged('Int32x4List(2)', 'Int32x4List', imports: td);
      expectUnbridged('Float64x2List(2)', 'Float64x2List', imports: td);
    });

    test('F-SCB29-3: the three ByteBuffer SIMD views fail with a DIFFERENT '
        'message than the classes [2026-09-03]', () {
      // `ByteBuffer` is bridged, so these are missing *members*, not missing
      // names: they raise an SDK-shaped `NoSuchMethodError` rather than the
      // `RuntimeD4rtException` every other case here expects. The doc has to
      // send readers to the right string, so the distinction is pinned.
      for (final view in const [
        'asFloat32x4List',
        'asInt32x4List',
        'asFloat64x2List',
      ]) {
        expect(
          () => execute(
            "import 'dart:typed_data';\n"
            'main() => Uint8List(64).buffer.$view();',
          ),
          throwsA(
            isA<NoSuchMethodError>().having(
              (e) => e.toString(),
              'toString',
              contains("has no instance method named '$view'"),
            ),
          ),
          reason: 'ByteBuffer.$view should report a missing member',
        );
      }
    });

    test('F-SCC74-1: the RawSocket message pair fails as missing MEMBERS, so '
        'the sandbox decision holds [2026-09-06]', () async {
      // Same shape as F-SCB29-3 and for the same reason: `RawSocket` is
      // bridged, so `readMessage` / `sendMessage` are missing members rather
      // than missing names and never reach a variable lookup.
      //
      // This pair is the one REFUSED row in the limitations table. Every other
      // entry is deferred pending a consumer; these two would let a script
      // receive a `ResourceHandle` — a raw file descriptor — for a file or
      // socket the permission system never granted, and no permission check
      // can see it happen. If this test fails because someone bridged them,
      // the fix is NOT to delete the case: it is to decide, deliberately, that
      // the sandbox boundary moved.
      for (final member in const ['readMessage', 'sendMessage']) {
        await expectLater(
          () async {
            final source =
                "import 'dart:io';\n"
                'main() async {\n'
                "  final server = await RawServerSocket.bind('127.0.0.1', 0);\n"
                "  final socket = await RawSocket.connect('127.0.0.1', "
                'server.port);\n'
                // NOT `try { return ... } finally`: in an async function a
                // throwing return expression inside a try with a non-empty
                // finally and no catch loses the error and yields the finally
                // block's value instead. The audit tool hit this and documents
                // it as scd40; the shape below throws correctly.
                '  dynamic probed;\n'
                '  try {\n'
                '    probed = socket.$member();\n'
                '  } finally {\n'
                '    socket.close();\n'
                '    await server.close();\n'
                '  }\n'
                '  return probed;\n'
                '}\n';
            await executeAsync(source);
          }(),
          throwsA(
            isA<Object>().having(
              (e) => e.toString(),
              'toString',
              contains("named '$member'"),
            ),
          ),
          reason: 'RawSocket.$member should report a missing member',
        );
      }
    });

    test('F-SCB29-4: the eleven non-SIMD typed lists still work, so the block '
        'above is a decision and not a dead library [2026-09-03]', () {
      // Without this anchor every claim above would also hold if
      // `dart:typed_data` were simply unreachable.
      const source = '''
      import 'dart:typed_data';
      main() {
        final f = Float32List(2);
        f[0] = 1.5;
        return [f.length, f[0], Uint8List(64).buffer.asUint8List().length];
      }
      ''';
      expect(execute(source), equals([2, 1.5, 64]));
    });
  });

  group('SCB30: the message carries the decision', () {
    // The point of the change: `Zone` and `Zoen` used to be indistinguishable.
    // These cases pin the difference, and — more importantly — pin the map's
    // key set against the doc, because a map that drifts from the doc is the
    // same rot in Dart syntax.

    test('F-SCB30-1: an unbridged name reports the reason, a typo does not '
        '[2026-09-03]', () {
      // The contrast IS the feature. Asserting only the first half would pass
      // just as well if every undefined name grew a suffix, which would make
      // the suffix meaningless.
      expect(
        () => execute("import 'dart:async';\nmain() => Zone.current;"),
        throwsRuntimeError(
          allOf(
            contains('Undefined variable: Zone'),
            contains('not bridged:'),
            contains('doc/d4rt_limitations.md'),
          ),
        ),
      );
      expect(
        () => execute("import 'dart:async';\nmain() => Zoen.current;"),
        throwsRuntimeError(
          allOf(
            contains('Undefined variable: Zoen'),
            isNot(contains('not bridged:')),
          ),
        ),
      );
    });

    test('F-SCB30-2: the prefix is unchanged, so the existing matchers and the '
        'doc\'s grep advice still hold [2026-09-03]', () {
      // Every case above this group matches with `contains('Undefined
      // variable: <name>')`, and interpreter_visitor's extension resolution
      // inspects the same substring. The reason must be a suffix and nothing
      // else — no reordering, no reworded prefix.
      for (final name in kUnbridgedReasons.keys) {
        expect(
          undefinedVariableMessage(name),
          startsWith('Undefined variable: $name ('),
          reason: '$name must keep the bare prefix followed by the reason',
        );
      }
      expect(
        undefinedVariableMessage('Zoen'),
        equals('Undefined variable: Zoen'),
      );
    });

    test('F-SCB30-3: the map keys are exactly the doc\'s "Reported as" '
        'identifiers [2026-09-03]', () {
      // This is the case that stops the map rotting. SC11 moved the claim out
      // of prose and into a test; SCB30 adds a second copy of the same list in
      // lib/, so the list needs pinning to its source rather than restating.
      // Derived from the doc, not hard-coded — a hard-coded expectation here
      // would be a third copy and would rot alongside the other two.
      final documented = _reportedAsIdentifiers()
        // These four are in the doc's "Reported as" column because a reader may
        // arrive from `Bridged class 'ByteBuffer' has no instance method named
        // 'asFloat32x4List'` — a missing *member* on a class that IS bridged
        // (F-SCB29-3). That message never passes through a variable lookup, so
        // the map structurally cannot serve it, and `ByteBuffer` itself must
        // stay out of the map because it is registered. SCC91 tracks giving the
        // member path its own reason.
        //
        // `RawSocket` and its two message members are the same shape, added by
        // SCC74: the class is bridged and only the pair is out, so they arrive
        // as `has no instance method named 'readMessage'` and never reach a
        // variable lookup either.
        ..removeAll(const {
          'ByteBuffer',
          'asFloat32x4List',
          'asInt32x4List',
          'asFloat64x2List',
          'RawSocket',
          'readMessage',
          'sendMessage',
        });

      expect(
        documented,
        isNotEmpty,
        reason:
            'the doc parse found no identifiers — the table format '
            'changed and this test is no longer reading what it thinks',
      );
      expect(
        kUnbridgedReasons.keys.toSet(),
        equals(documented),
        reason:
            'kUnbridgedReasons and the limitations doc disagree: add the '
            'name to both, or to neither',
      );
    });

    test('F-SCB30-4: every reason is a single lower-case clause, so the '
        'assembled message reads as one sentence [2026-09-03]', () {
      for (final entry in kUnbridgedReasons.entries) {
        expect(entry.value, isNotEmpty, reason: entry.key);
        expect(
          entry.value.endsWith('.'),
          isFalse,
          reason:
              '${entry.key}: the reason is spliced before "; see …", so '
              'a trailing period reads as a broken sentence',
        );
        expect(entry.value.contains('\n'), isFalse, reason: entry.key);
      }
    });

    test('F-SCB30-5: the worked example in the doc is the message the code '
        'actually produces [2026-09-03]', () {
      // The doc quotes a full assembled message as its illustration. An
      // illustration that has drifted from the code is worse than none, and
      // this one is quoted in a wrapped code block where a reader would never
      // notice. Compared with whitespace collapsed, since the wrap points are
      // presentation and not content.
      String flat(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();
      expect(
        flat(File('doc/d4rt_limitations.md').readAsStringSync()),
        contains(flat(undefinedVariableMessage('Zone'))),
        reason:
            'the doc\'s example message no longer matches '
            'undefinedVariableMessage(\'Zone\')',
      );
    });
  });

  group('SC11: the section is reachable from the message', () {
    test('F-SC11-6: dart:io itself still works, so the absences above are '
        'per-class and not a dead library [2026-07-27]', () {
      // Without this the group above would also pass if `dart:io` were simply
      // unreachable, which would make every claim in the doc vacuous.
      const source = '''
      import 'dart:io';
      main() => File('x').path;
      ''';
      expect(execute(source), equals('x'));
    });
  });
}

/// Every backtick-quoted identifier in the "Reported as" column of the tables
/// under `## Intentionally-Unbridged SDK Classes`.
///
/// Reading the doc rather than restating it is the whole point: F-SCB30-3 needs
/// the doc's list as a *source*, and a hard-coded copy here would be a third
/// place to forget. The parse is deliberately narrow — cell index 1 of pipe
/// tables inside that one section — so a format change fails loudly on the
/// `isNotEmpty` guard instead of silently matching nothing.
Set<String> _reportedAsIdentifiers() {
  final doc = File('doc/d4rt_limitations.md').readAsLinesSync();
  final start = doc.indexWhere(
    (l) => l.startsWith('## Intentionally-Unbridged'),
  );
  if (start < 0) {
    throw StateError(
      'doc/d4rt_limitations.md has no '
      '"## Intentionally-Unbridged" section — the pin cannot read its source',
    );
  }
  var end = doc.indexWhere((l) => l.startsWith('## '), start + 1);
  if (end < 0) end = doc.length;

  final identifier = RegExp(r'`([A-Za-z_][A-Za-z0-9_]*)`');
  final found = <String>{};
  for (final line in doc.getRange(start, end)) {
    if (!line.startsWith('|') || !line.endsWith('|')) continue;
    final cells = line.split('|');
    // split on a fully-delimited row yields a leading and trailing empty
    // string, so the "Reported as" column (second) lands at index 2.
    if (cells.length < 4) continue;
    for (final m in identifier.allMatches(cells[2])) {
      found.add(m.group(1)!);
    }
  }
  return found;
}
