// RUNNER BUCKET: guard — run_guard_tests.sh
//
// SCE210 — no FLUTTER bridge registration binds a class-shaped name to a value.
//
// THE DEFECT SHAPE is SCD175's (`tom_d4rt/test/scd175_class_shaped_binding_test.dart`):
// `define('Foo', ...)` binds a capitalised name to a value instead of
// registering a bridge with `defineBridge`. It constructs, prints and resolves
// like a working bridge and fails only on `is` — and widget code is where `is`
// checks are most common. SCD175 sweeps the eight stdlib registrars and only
// them, so a bridge PACKAGE doing the same was invisible to it. This is the
// same rule applied to what `FlutterD4rt` registers.
//
// WHY THE LIVE ENVIRONMENT AND NOT THE SOURCE: for the reason SCD175 gives —
// it tests what a script sees, so a binding made through a helper, a loop or a
// generated table is caught where a `define('<Uppercase>'` grep is not. The
// grep was run anyway before this file was written (2026-09-28) and is still
// zero across the repo, both twins included.
//
// EXTENSIONS ARE NOT CLASS-SHAPED BINDINGS, and the first run said so. It
// found exactly two capitalised values, `StringCharacters` and
// `HtmlElementViewImpl`, both `InterpretedExtension`s: the generated bridges
// register `extension StringCharacters on String` (package:characters) and
// Flutter's `extension HtmlElementViewImpl`. An extension's name is
// capitalised by convention, it is not a type, and `is` cannot name one — so
// the failure SCD175 guards against cannot happen through it, and the
// interpreter storing it as a value is correct. They are excluded BY KIND
// rather than by name, so a new generated extension needs no allowlist edit,
// and F-SCE210-1 asserts extensions are present so the exclusion is not
// quietly skipping an empty set.
//
// With that, the allowlist is EMPTY BY MEASUREMENT (2026-09-28): a finding
// here is the defect and needs no judgement to read.

import 'package:flutter_test/flutter_test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstBundler;
import 'package:tom_d4rt_ast/d4rt.dart';
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

const String _probeScript = '''
import 'package:flutter/material.dart';

int main() => 1;
''';

/// Capitalised value-bindings the registration may legitimately make. EMPTY,
/// measured so — see the header. An entry is a claim that a class-shaped name
/// genuinely is not a class, and needs a reason beside it.
const _allowedValueBindings = <String, String>{};

final RegExp _classShaped = RegExp(r'^[A-Z]');

/// Every value binding on [env]'s scope chain, innermost first wins.
Map<String, Object?> _valueBindings(Environment env) {
  final out = <String, Object?>{};
  for (Environment? frame = env; frame != null; frame = frame.enclosing) {
    for (final entry in frame.values.entries) {
      out.putIfAbsent(entry.key, () => entry.value);
    }
  }
  return out;
}

Future<Environment> _liveRegistry() async {
  final d4rt = FlutterD4rt();
  final bundle = await AstBundler(
    bridgedLibraries: d4rt.interpreter.bridgedLibraryUris,
  ).createFromSource(_probeScript);
  d4rt.execute<int>(bundle, name: 'main');
  return d4rt.interpreter.visitor!.globalEnvironment;
}

void main() {
  late Environment env;
  late Map<String, Object?> values;

  setUpAll(() async {
    env = await _liveRegistry();
    values = _valueBindings(env);
  });

  group('SCE210: no flutter bridge registration binds a class-shaped name '
      'to a value', () {
    test('F-SCE210-1 (control): the registry loaded and the sweep reads the '
        'value map [2026-09-28] (PASS)', () {
      // Anti-vacuity twice over. The assertion below is an EMPTINESS claim,
      // which an unloaded registry satisfies; and `define` and `defineBridge`
      // write different maps, which is exactly the confusion this sweep could
      // fall into. So: the bridges are there, lower-case values are there,
      // and a class-shaped `define` shows up in the map being swept.
      var bridged = 0;
      for (Environment? frame = env; frame != null; frame = frame.enclosing) {
        bridged += frame.bridgedClassNames.length;
      }
      expect(
        bridged,
        greaterThanOrEqualTo(1500),
        reason:
            'only $bridged bridged class names: the registry did not '
            'load, and every name would read as correctly shaped by absence',
      );
      expect(
        values.keys,
        contains('print'),
        reason: 'the stdlib value bindings are missing: wrong map or frame',
      );

      expect(
        values.values.whereType<InterpretedExtension>(),
        isNotEmpty,
        reason:
            'no extension values: the by-kind exclusion in F-SCE210-2 '
            'would be excluding nothing, and the registry is not the one '
            'measured on 2026-09-28',
      );

      final probe = Environment(enclosing: env)
        ..define('ZzClassShaped', () => 1);
      expect(
        _valueBindings(probe).keys.where(_classShaped.hasMatch),
        contains('ZzClassShaped'),
      );
    });

    test('F-SCE210-2: no capitalised name is bound to a value '
        '[2026-09-28] (PASS)', () {
      final offenders = [
        for (final entry in values.entries)
          if (_classShaped.hasMatch(entry.key) &&
              entry.value is! InterpretedExtension &&
              !_allowedValueBindings.containsKey(entry.key))
            '${entry.key} -> ${entry.value.runtimeType}',
      ]..sort();
      expect(
        offenders,
        isEmpty,
        reason:
            'These are bound with `define`, not registered with '
            '`defineBridge`. A class-shaped name bound to a value constructs '
            'and prints like a working bridge and fails only on `is`. Register '
            'the class as a bridge; if the name genuinely is not a class, add '
            'it to _allowedValueBindings with the reason.',
      );
    });

    test('F-SCE210-3: no allowlist entry outlives its cause '
        '[2026-09-28] (PASS)', () {
      final stale = [
        for (final name in _allowedValueBindings.keys)
          if (!values.containsKey(name)) name,
      ];
      expect(
        stale,
        isEmpty,
        reason: 'permitted names no registration binds any more',
      );
    });
  });
}
