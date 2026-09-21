@Timeout(Duration(minutes: 3))
library;

// The audit's WRITING side, which nothing tested until this file.
//
// `tool/stdlib_member_diff.dart` renders two checked-in Dart sources that the
// standing guards then read — `member_coverage_baseline.dart` and
// `hierarchy_baseline.dart`. Its measuring side is exercised on every suite
// run, because those baselines are produced by it. Its EMITTING side is not
// exercised at all by a baseline run, and it had already shipped a defect:
//
//     ${unfinished.map((n) => "  '\$n',").join('\n')}   // emits   '$n',
//     ${measured.map((n) => "  '$n',").join('\n')}     // emits   'Foo',
//
// Six lines apart in one string. The wrong one would have written Dart that
// does not compile — loudly, but only at the moment somebody was already
// dealing with a regression and regenerating. It was invisible because
// `unfinishedClasses` is pinned EMPTY on purpose, so that emitter had never
// run with data. It still has not, outside this file: as of 2026-09-21
// `unfinishedClasses` is empty by design and the hierarchy baseline's
// `confirmedEdges` and `unmeasurableEdges` are both empty too, so three of the
// emitters across the two renderers produce nothing on every real run.
//
// SO THE INPUT HERE IS SYNTHETIC, with every bucket populated. Building
// `ClassDiff` and `HierarchyGap` by hand is deliberate and is what makes this
// cheap — the alternative, arranging a real environment in which a class has
// no instance recipe, would take seconds and could not reach the buckets that
// are empty by policy at all.
//
// THE ASSERTION IS `dart analyze`, because the property that failed is
// "the output compiles". F-SCE86-5 is what makes that a measurement rather
// than a hope: it injects the historical defect into a rendered file at the
// same path and requires the analyzer to report it. An analyzer that silently
// skipped this directory would pass every other case in the file.
//
// ABLATED, both subjects, each fault put back and the file re-run:
//
//   | Injected fault                                   | Fires   |
//   | ------------------------------------------------ | ------- |
//   | the shipped over-escape, `'\$n'` for `'$n'`       | 1 and 3 |
//   | the `--only` + `--baseline` refusal deleted       | 6       |
//
// 1 and 3 catch the same fault two ways on purpose: analysis says the output
// does not compile, and the content assertion says which emitter produced it.
// A future defect that compiles and is still wrong — an emitter dropping its
// entries — is only visible to 3.

import 'dart:io';

import 'package:test/test.dart';

import '../../tool/stdlib_member_diff.dart';

/// Scratch directory for rendered sources.
///
/// Under `.dart_tool/`, which is gitignored: a generated file that lands in
/// the tree is the defect this corner of the repo keeps finding in other
/// shapes.
late final Directory _scratch;

/// Runs `dart analyze` on [file] and returns its stdout+stderr.
///
/// The VM running this test rather than whatever `dart` a PATH lookup finds:
/// this workspace runs Dart from the Flutter bundle, so a PATH lookup is a
/// different SDK on some fleet host.
({int exitCode, String output}) _analyze(File file) {
  final r = Process.runSync(Platform.resolvedExecutable, [
    'analyze',
    '--no-fatal-warnings',
    file.path,
  ], workingDirectory: Directory.current.path);
  return (exitCode: r.exitCode, output: '${r.stdout}\n${r.stderr}');
}

/// A diff with every bucket the member renderer emits populated.
List<ClassDiff> _syntheticDiffs() {
  final confirmed = ClassDiff('SceConfirmed', 'SceConfirmed')
    ..recipeUsable = true
    ..verified = true
    ..missingInstance.addAll(['aMember', 'bMember'])
    ..missingStatic.add('aStatic')
    ..missingOperators.add('+')
    ..missingUniversal.add('toString');

  // `declined` is split out of the measured gaps by `_isDeclined`, which reads
  // the interpreter's own `kUnbridgedMemberReasons` — so a synthetic class
  // cannot reach that bucket. This one uses a real declined pair, which also
  // means the case fails if that register is emptied without the renderer
  // being reconsidered.
  final declined = ClassDiff('ByteBuffer', 'ByteBuffer')
    ..recipeUsable = true
    ..verified = true
    ..missingInstance.add('asFloat32x4List');

  final unmeasurable = ClassDiff('SceUnmeasurable', 'SceUnmeasurable')
    ..verified = true
    ..notAuditableReason = 'synthetic: no instance can be made'
    ..unverifiedInstance.add('cMember')
    ..unverifiedStatic.add('cStatic');

  // No `notAuditableReason`, so this one lands in `unfinishedClasses` — the
  // bucket whose emitter carried the defect and which no real run populates.
  final unfinished = ClassDiff('SceUnfinished', 'SceUnfinished')
    ..verified = true
    ..unverifiedInstance.add('dMember');

  return [confirmed, declined, unmeasurable, unfinished];
}

/// Gaps with every bucket the hierarchy renderer emits populated.
List<HierarchyGap> _syntheticGaps() {
  final confirmed = HierarchyGap('SceEdgeConfirmed', 'SceEdgeConfirmed', true)
    ..recipeUsable = true
    ..verified = true
    ..missingEdges.addAll(['Iterable', 'Set']);

  final declined = HierarchyGap('SceEdgeDeclined', 'SceEdgeDeclined', false)
    ..recipeUsable = true
    ..verified = true
    ..declinedEdges.add('Enum');

  final unmeasurable = HierarchyGap('SceEdgeBlind', 'SceEdgeBlind', true)
    ..verified = true
    ..unverifiedEdges.add('Pattern');

  return [confirmed, declined, unmeasurable];
}

File _write(String name, String source) {
  final f = File('${_scratch.path}/$name')..writeAsStringSync(source);
  return f;
}

void main() {
  setUpAll(() {
    _scratch = Directory('.dart_tool/sce86_baseline_renderer')
      ..createSync(recursive: true);
  });

  tearDownAll(() {
    if (_scratch.existsSync()) _scratch.deleteSync(recursive: true);
  });

  group('SCE86: the baseline renderers emit Dart that compiles', () {
    test('F-SCE86-1: the member baseline analyzes clean with every bucket '
        'populated [2026-09-21] (PASS)', () {
      final source = renderBaselineSource(_syntheticDiffs(), {
        'SceConfirmed',
        'ByteBuffer',
        'SceUnmeasurable',
        'SceUnfinished',
        'SceRegisteredOnly',
      });
      final result = _analyze(_write('member_baseline.dart', source));
      expect(
        result.exitCode,
        0,
        reason:
            'The generated member baseline does not analyze:\n'
            '${result.output}',
      );
    });

    test('F-SCE86-2: the hierarchy baseline analyzes clean with every bucket '
        'populated [2026-09-21] (PASS)', () {
      final result = _analyze(
        _write(
          'hierarchy_baseline.dart',
          renderHierarchyBaselineSource(_syntheticGaps()),
        ),
      );
      expect(
        result.exitCode,
        0,
        reason:
            'The generated hierarchy baseline does not analyze:\n'
            '${result.output}',
      );
    });

    test('F-SCE86-3: every synthetic name reaches its bucket [2026-09-21] '
        '(PASS)', () {
      // Analyzing catches output that does not compile. It does NOT catch
      // output that compiles and says the wrong thing — an emitter dropping
      // its entries would produce an empty but perfectly valid map. The names
      // are checked against the buckets they belong in for that reason, and
      // this is also the case that fails in the exact shape of the shipped
      // defect: an interpolated `'$n'` is neither `'SceUnfinished'` nor
      // valid Dart.
      final source = renderBaselineSource(_syntheticDiffs(), {
        'SceConfirmed',
        'SceRegisteredOnly',
      });
      expect(source, contains("'SceConfirmed': ["));
      expect(source, contains("r'aMember',"));
      expect(source, contains("'ByteBuffer': ["));
      expect(source, contains("r'asFloat32x4List',"));
      expect(source, contains("'SceUnmeasurable': ["));
      expect(source, contains("  'SceUnfinished',"));
      expect(source, contains("  'SceConfirmed',"));
      expect(source, contains("  'SceRegisteredOnly',"));
      expect(
        source,
        isNot(contains(r"'$n',")),
        reason: 'the emitter interpolated its loop variable instead of a name',
      );

      final edges = renderHierarchyBaselineSource(_syntheticGaps());
      expect(edges, contains("'SceEdgeConfirmed': ["));
      expect(edges, contains("r'Iterable',"));
      expect(edges, contains("'SceEdgeDeclined': ["));
      expect(edges, contains("'SceEdgeBlind': ["));
      expect(edges, contains("  'SceEdgeConfirmed',"));
      expect(edges, isNot(contains(r"'$n',")));
    });

    test('F-SCE86-4: the declined split comes from the interpreter\'s own '
        'register [2026-09-21] (PASS)', () {
      // `_isDeclined` reads `kUnbridgedMemberReasons` from `lib/`, so a member
      // recorded there must NOT land in `confirmedGaps`. Getting this backwards
      // turns a decision into a reported defect in every regenerated baseline.
      final source = renderBaselineSource(_syntheticDiffs(), {'ByteBuffer'});
      final confirmedBlock = source.substring(
        source.indexOf('const confirmedGaps'),
        source.indexOf('const declinedMembers'),
      );
      expect(
        confirmedBlock,
        isNot(contains('asFloat32x4List')),
        reason: 'a declined member was rendered as a confirmed gap',
      );
      expect(
        source.substring(source.indexOf('const declinedMembers')),
        contains('asFloat32x4List'),
      );
    });

    test('F-SCE86-5 (control): the analyzer reports on files in this scratch '
        'directory [2026-09-21] (PASS)', () {
      // Anti-vacuity, and the case that makes the other two mean anything.
      // `.dart_tool/` is where generated scratch belongs, and it is also the
      // kind of directory an analyzer is entitled to skip; if it skipped this
      // one, F-SCE86-1 and -2 would pass over unanalyzed files for ever.
      //
      // The injected fault is the SHIPPED one: the emitter interpolating its
      // loop variable. `'$n'` inside a const set is an undefined name and not
      // a constant expression, so a working analyzer must report it.
      final broken = renderBaselineSource(_syntheticDiffs(), {
        'SceConfirmed',
      }).replaceAll("  'SceUnfinished',", r"  '$n',");
      final result = _analyze(_write('broken_baseline.dart', broken));
      expect(
        result.exitCode,
        isNot(0),
        reason:
            'The analyzer did not report a file that cannot compile, so it is '
            'not reading this directory and F-SCE86-1/-2 prove nothing. Move '
            'the scratch path somewhere it does read.\n${result.output}',
      );
      expect(
        result.output,
        contains("Undefined name 'n'"),
        reason:
            'The analyzer reported something, but not the injected fault — so '
            'it is not the fault being detected and the control is measuring '
            'something else.\n${result.output}',
      );
    });
  });

  group('SCE86: the CLI refuses to write a narrowed baseline', () {
    test('F-SCE86-6: --only with --baseline exits 2 and writes nothing '
        '[2026-09-21] (PASS)', () {
      // WHY THE REFUSAL EXISTS, so nobody removes it as over-caution: a
      // baseline written from `--only RegExp` records `measuredClasses` as one
      // name. `F-SCC13-2` computes `measuredClasses.difference(observed)`,
      // which is then empty and PASSES, and `F-SCC13-0`'s floors bound the
      // LIVE run, which is full-size, so they pass too. The narrowed baseline
      // disarms the guards without failing anything.
      //
      // Driven as a process because the refusal calls `exit()`, which cannot
      // be observed in-process. The narrowed run costs about five seconds.
      final out = File('${_scratch.path}/must_not_be_written.dart');
      expect(out.existsSync(), isFalse, reason: 'precondition');

      final r = Process.runSync(Platform.resolvedExecutable, [
        'run',
        'tool/stdlib_member_diff.dart',
        '--only',
        'RegExp',
        '--baseline',
        '--baseline-out',
        out.path,
      ], workingDirectory: Directory.current.path);

      expect(
        r.exitCode,
        2,
        reason:
            'A --only run must refuse to write a baseline.\n'
            '${r.stdout}\n${r.stderr}',
      );
      expect(
        out.existsSync(),
        isFalse,
        reason: 'the refusal wrote the file anyway',
      );
      expect('${r.stderr}', contains('Refusing to write a baseline'));
    });
  });
}
