// RUNNER BUCKET: guard — run_guard_tests.sh
/// SCE177 — a private SDK type still reaches its STDLIB bridge when the Flutter
/// bridges are in scope.
///
/// Most stdlib `nativeNames` entries were pruned because the structural pass
/// reaches the same bridge by name: `_CompactIterator` ends with `Iterator`.
/// But that pass is a SUFFIX match walked nearest frame first (SCF26), and in
/// this package the ~2000 Flutter bridges sit in the frame nearer than the
/// stdlib. A Flutter bridge whose name is also a suffix of an SDK type wins
/// there, silently. Measured when the prune was made: exactly two such
/// collisions, both on `BytesBuilder` — `_BytesBuilder` and
/// `_CopyingBytesBuilder` end with `Builder`, which is a Flutter widget. Those
/// two kept their precise entries; this guard is why that is known rather
/// than hoped.
///
/// It resolves REAL SDK objects in the frame a script runs in, so it measures
/// the scope layout rather than a model of it. It runs against the interpreter
/// this package resolves (DGUC6), which is the one a Flutter app ships.
library;

import 'dart:collection';
import 'dart:typed_data' show BytesBuilder;

import 'package:flutter_test/flutter_test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstBundler;
import 'package:tom_d4rt_ast/d4rt.dart';
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

const String _probeScript = '''
import 'package:flutter/material.dart';

int main() => 1;
''';

Object? _caught(void Function() raise) {
  try {
    raise();
  } catch (e) {
    return e;
  }
  return null;
}

void main() {
  late Environment env;

  setUpAll(() async {
    final d4rt = FlutterD4rt();
    final bundle = await AstBundler(
      bridgedLibraries: d4rt.interpreter.bridgedLibraryUris,
    ).createFromSource(_probeScript);
    d4rt.execute<int>(bundle, name: 'main');
    env = d4rt.interpreter.visitor!.globalEnvironment;
  });

  /// Real SDK objects, each with the stdlib bridge it must reach.
  final probes = <String, (Object? Function(), String)>{
    'BytesBuilder(copy: true)': (() => BytesBuilder(), 'BytesBuilder'),
    'BytesBuilder(copy: false)': (
      () => BytesBuilder(copy: false),
      'BytesBuilder',
    ),
    'List.iterator': (() => <int>[1].iterator, 'Iterator'),
    'set literal iterator': (() => <int>{1}.iterator, 'Iterator'),
    'HashSet iterator': (() => (HashSet<int>()..add(1)).iterator, 'Iterator'),
    'SplayTreeSet iterator': (
      () => (SplayTreeSet<int>()..add(1)).iterator,
      'Iterator',
    ),
    'ListQueue iterator': (
      () => (ListQueue<int>()..add(1)).iterator,
      'Iterator',
    ),
    'HashMap.keys': (
      () => (HashMap<String, int>()..['a'] = 1).keys,
      'Iterable',
    ),
    'SplayTreeMap.entries': (
      () => (SplayTreeMap<String, int>()..['a'] = 1).entries,
      'Iterable',
    ),
    'List.map': (() => <int>[1].map((e) => e), 'Iterable'),
    'failing cast': (
      () => _caught(() => (1 as dynamic) as String),
      'TypeError',
    ),
    'const map': (() => const <String, int>{}, 'Map'),
  };

  group('SCE177: stdlib types route to the stdlib under Flutter scope', () {
    test('SCE177-1: the probe environment is the Flutter one '
        '[2026-09-25] (PASS)', () {
      // Anti-vacuity: in a bare environment no Flutter bridge could hijack
      // anything, and every case below would pass for the wrong reason.
      expect(env.findBridgedClassByName('Builder'), isNotNull);
    });

    for (final entry in probes.entries) {
      test('SCE177-2 ${entry.key} routes to ${entry.value.$2} '
          '[2026-09-25] (PASS)', () {
        final value = entry.value.$1();
        expect(
          env.toBridgedClass(value.runtimeType).name,
          entry.value.$2,
          reason:
              '${value.runtimeType} must reach the stdlib `${entry.value.$2}` '
              'bridge. If it reaches a Flutter bridge instead, a Flutter name '
              'is a nearer suffix match (SCF26): give the stdlib bridge a '
              'precise `nativeNames` entry for it.',
        );
      });
    }
  });
}
