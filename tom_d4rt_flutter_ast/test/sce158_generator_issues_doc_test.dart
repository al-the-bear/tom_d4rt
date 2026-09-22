// RUNNER BUCKET: guard — run_guard_tests.sh
//
/// SCE158 — `doc/generator_issues.md` carries a state per entry, and its header
/// register is DERIVED from those states.
///
/// ## What went wrong without this
///
/// The file held 36 entries, 35 of them ending in a written-out follow-up
/// recommendation — "in bridge generation, add explicit support for
/// `ReverseTween<T>` construction dispatch", and so on — and **zero** status
/// markers of any kind. Thirty-five analyses had been paid for and nothing
/// recorded whether any of them was ever applied. The expensive half was done;
/// the cheap half, knowing which were outstanding, was missing, and it got more
/// expensive to recover every month.
///
/// That is the same shape as the cluster log before `interpreter_issues.md`
/// grew a derived header, and this guard is the same answer. The difference is
/// the key: the cluster log is `###` sections whose bracket IS their state, so
/// ISSUES-1/2 can key on headings. This file is flat `batch:` / `issue-index:`
/// prose with no headings, so the state is an explicit `status:` line placed
/// directly under each `issue-index:`.
///
/// ## What is asserted
///
/// F-SCE158-1 — every entry has exactly one `status:` line, and it is one of the
/// four recognised states. An entry with none is the defect this file exists
/// for; an entry with two is a merge nobody finished reading.
///
/// F-SCE158-2 — the header register's counts are recomputed from those lines
/// and must match. A summary that can drift from its entries is worse than no
/// summary, because it is believed.
///
/// F-SCE158-3 — an `open` entry names the `scd…` / `sce…` / `scf…` / `GEN-…`
/// that owes the fix. Written-out work with no owner is how this file reached
/// 35 unowned recommendations in the first place. (Vacuous today at zero open
/// entries — which is why F-SCE158-5 proves the check can fail.)
///
/// F-SCE158-4 (control) — the file was read, has the magnitude expected of it,
/// and the parse found entries rather than passing over an empty set.
///
/// F-SCE158-5 (control) — the owner rule and the state vocabulary are exercised
/// against synthetic text, so neither is a claim that only holds while the
/// register happens to be empty.
///
/// This guard reads one file in its own package and needs no transport, so it
/// belongs in `run_guard_tests.sh` rather than in either corpus runner.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _doc = 'doc/generator_issues.md';

/// The states an entry may declare. Deliberately small: a vocabulary that grows
/// per entry stops being a register and becomes prose again.
const _states = <String>{'fixed', 'open', 'superseded', 'wont-fix'};

/// Ids that count as an owner for an `open` entry.
final _ownerPattern = RegExp(
  r'\b(scd|sce|scf)\d+|\bGEN-\d+',
  caseSensitive: false,
);

/// Entries below this count mean the parse, not the file, is the problem.
const _minEntries = 30;

/// One `issue-index:` entry, reduced to what this file asserts.
typedef _Entry = ({String index, List<String> statusLines});

List<_Entry> _parse(List<String> lines) {
  final entries = <({String index, List<String> statusLines})>[];
  String? index;
  var statuses = <String>[];
  void flush() {
    final current = index;
    if (current != null) {
      entries.add((index: current, statusLines: List.of(statuses)));
    }
  }

  for (final line in lines) {
    if (line.startsWith('issue-index: ')) {
      flush();
      index = line.substring('issue-index: '.length).trim();
      statuses = <String>[];
    } else if (line.startsWith('status: ') && index != null) {
      statuses.add(line.substring('status: '.length).trim());
    }
  }
  flush();
  return entries;
}

/// The first word of a status line — its state.
String _stateOf(String statusLine) => statusLine.split(RegExp(r'[\s—]')).first;

/// Reads a `| label | count |` row out of the header register.
int? _registerCount(List<String> lines, String label) {
  for (final line in lines) {
    if (!line.startsWith('| ')) continue;
    final cells = line.split('|').map((c) => c.trim()).toList();
    if (cells.length < 4) continue;
    if (cells[1] == label) return int.tryParse(cells[2]);
  }
  return null;
}

void main() {
  late List<String> lines;
  late List<_Entry> entries;

  setUpAll(() {
    final file = File(_doc);
    expect(
      file.existsSync(),
      isTrue,
      reason:
          '$_doc is this guard\'s entire subject. If it moved, move the guard '
          'with it rather than leaving one that passes over nothing',
    );
    lines = file.readAsLinesSync();
    entries = _parse(lines);
  });

  group('SCE158: the generator issues log is a register, not just prose', () {
    test('F-SCE158-1: every entry declares exactly one recognised state', () {
      final missing = <String>[];
      final duplicated = <String>[];
      final unrecognised = <String>[];
      for (final entry in entries) {
        if (entry.statusLines.isEmpty) {
          missing.add(entry.index);
          continue;
        }
        if (entry.statusLines.length > 1) duplicated.add(entry.index);
        for (final status in entry.statusLines) {
          final state = _stateOf(status);
          if (!_states.contains(state)) {
            unrecognised.add('${entry.index}: `$state`');
          }
        }
      }

      expect(
        missing,
        isEmpty,
        reason:
            'these entries end in a written-out recommendation and record '
            'nothing about whether it landed — which is the whole defect this '
            'file was added for. Add `status: <${_states.join('|')}> — '
            '<evidence>` directly under the `issue-index:` line: '
            '${missing.join(', ')}',
      );
      expect(
        duplicated,
        isEmpty,
        reason:
            'more than one `status:` line in one entry — a merge nobody '
            'finished reading: ${duplicated.join(', ')}',
      );
      expect(
        unrecognised,
        isEmpty,
        reason:
            'the state vocabulary is ${_states.join(' / ')} and is deliberately '
            'small; a vocabulary that grows per entry stops being a register: '
            '${unrecognised.join(', ')}',
      );
    });

    test('F-SCE158-2: the header register is derived from the entries', () {
      final counts = <String, int>{for (final state in _states) state: 0};
      for (final entry in entries) {
        for (final status in entry.statusLines) {
          final state = _stateOf(status);
          if (counts.containsKey(state)) counts[state] = counts[state]! + 1;
        }
      }

      final declaredTotal = _registerCount(lines, 'entries (`issue-index:`)');
      expect(
        declaredTotal,
        entries.length,
        reason:
            'the register says $declaredTotal entries and the file holds '
            '${entries.length}. These numbers are recomputed here precisely so '
            'nobody has to keep them in step by hand',
      );

      for (final state in _states) {
        expect(
          _registerCount(lines, state),
          counts[state],
          reason:
              'the register says ${_registerCount(lines, state)} `$state` '
              'entries; the `status:` lines say ${counts[state]}. Update the '
              'table from the entries, never the other way round',
        );
      }
    });

    test('F-SCE158-3: an open entry names who owes the fix', () {
      final unowned = <String>[
        for (final entry in entries)
          for (final status in entry.statusLines)
            if (_stateOf(status) == 'open' && !_ownerPattern.hasMatch(status))
              entry.index,
      ];
      expect(
        unowned,
        isEmpty,
        reason:
            'an open entry with a written-out fix and no owner is exactly how '
            'this file accumulated 35 unowned recommendations. Name the '
            'scd…/sce…/scf…/GEN-… that owes it: ${unowned.join(', ')}',
      );
    });

    test(
      'F-SCE158-4 (control): the file was read and the parse found entries',
      () {
        expect(
          entries.length,
          greaterThanOrEqualTo(_minEntries),
          reason:
              'only ${entries.length} entries were parsed out of $_doc. Every '
              'assertion above iterates this list, so a parse that finds nothing '
              'passes them all by iterating nothing',
        );
        expect(
          lines.length,
          greaterThan(500),
          reason: 'the file is far shorter than the log this guard is about',
        );
        expect(
          _registerCount(lines, 'entries (`issue-index:`)'),
          isNotNull,
          reason:
              'the header register row could not be read at all, so F-SCE158-2 '
              'would be comparing against null rather than against a claim',
        );
      },
    );

    test(
      'F-SCE158-5 (control): the owner rule and the vocabulary can fail',
      () {
        // F-SCE158-3 is vacuous while nothing is open, and F-SCE158-1's
        // vocabulary check is vacuous while every entry says `fixed`. Both are
        // exercised here so neither is a claim that holds only by luck.
        final synthetic = _parse([
          'issue-index: 9001',
          'status: open — nobody owes this',
          'issue-index: 9002',
          'status: open — owed by sce158',
          'issue-index: 9003',
          'status: maybe — not a state',
        ]);
        expect(synthetic, hasLength(3));

        expect(
          _ownerPattern.hasMatch(synthetic[0].statusLines.single),
          isFalse,
          reason: 'an open entry naming no id must read as unowned',
        );
        expect(
          _ownerPattern.hasMatch(synthetic[1].statusLines.single),
          isTrue,
          reason: 'and one naming an sce… id must read as owned',
        );
        expect(
          _states.contains(_stateOf(synthetic[2].statusLines.single)),
          isFalse,
          reason: 'a state outside the vocabulary must be rejected',
        );
        expect(
          _states.contains(_stateOf('fixed — corpus: something')),
          isTrue,
          reason:
              'and the real shape used throughout the file must be accepted',
        );
      },
    );
  });
}
