// No stdlib registrar binds a CLASS-SHAPED name to a value.
//
// THE DEFECT SHAPE. `environment.define('HttpClientBasicCredentials', ...)`
// binds a capitalised name to a callable instead of registering a bridge with
// `defineBridge`. The result constructs correctly, analyzes clean, and passes
// any registration test that probes with `.toString()` or `env.get(name) !=
// null` — so it looks exactly like a working bridge. SCC64 removed the last
// four (the credentials family), found by an audit that probed with `is`; the
// symptom, a type test executing a constructor, read as a bridge bug rather
// than a registration one.
//
// AND THE LOUD SYMPTOM IS GONE. SCC64 also made a callable on the right of
// `is` DIAGNOSE rather than misbehave, which is the right fix and which also
// removes the noise a regression would otherwise make. That is the argument
// for a guard rather than for relying on someone noticing again.
//
// WHY THE ENVIRONMENT AND NOT THE SOURCE. SCD175 offered two mechanisms: a
// source sweep for the `define('<Uppercase>'` pattern, or a sweep of what the
// environment actually holds after registration. This is the second, because
// it tests what a SCRIPT sees rather than how the registrar was spelled — a
// name bound through a helper, a loop or a constant would slip past a text
// match and is caught here.
//
// TWIN of `tom_d4rt/test/scd175_class_shaped_binding_test.dart`. It is a real
// copy rather than one guard reading both trees, because each tree's
// registrars can only be imported from inside it — `tom_d4rt` cannot import
// `tom_d4rt_ast`, and the twin must stay dependency-free. The two differ only
// in those import paths.
//
// THE ALLOWLIST IS EMPTY, AND THAT WAS MEASURED BEFORE THE GUARD WAS WRITTEN,
// which is the condition SCD175 set: an allowlist that starts out wrong makes
// the guard worse than nothing. Every registrar contributes only lower-case
// names to the value environment — `print`, `identical`, `identityHashCode`,
// `stdout`, `stderr`, `stdin`, `stdioType`, `dynamic` — while classes and
// enums go to the separate bridge registry `defineBridge` writes. So a
// capitalised name appearing here is, today, the defect and nothing else, and
// the guard needs no judgement calls to read.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/isolate.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/typed_data.dart';

/// Every stdlib registrar, by the library it stands for.
const _registrars = <String, void Function(Environment)>{
  'dart:core': CoreStdlib.register,
  'dart:async': AsyncStdlib.register,
  'dart:collection': CollectionStdlib.register,
  'dart:convert': ConvertStdlib.register,
  'dart:io': IoStdlib.register,
  'dart:math': MathStdlib.register,
  'dart:typed_data': TypedDataStdlib.register,
  'dart:isolate': IsolateStdlib.register,
};

/// Capitalised value-bindings a registrar may legitimately make.
///
/// EMPTY, and measured so rather than assumed — see the header. An entry here
/// is a claim that a class-shaped name genuinely is not a class; it needs a
/// reason beside it, and F-SCD175-4 fails when the claim stops being true.
const _allowedValueBindings = <String, String>{};

final RegExp _classShaped = RegExp(r'^[A-Z]');

/// The capitalised names [register] leaves in the VALUE environment.
Map<String, Object?> _classShapedValues(void Function(Environment) register) {
  final env = Environment();
  register(env);
  return {
    for (final entry in env.values.entries)
      if (_classShaped.hasMatch(entry.key)) entry.key: entry.value,
  };
}

void main() {
  group('SCD175: no registrar binds a class-shaped name to a value', () {
    test('F-SCD175-1: every registrar ran and populated the value environment '
        '[2026-09-15] (PASS)', () {
      // Anti-vacuity, and it is the whole risk of this shape of guard: the
      // assertion below is that a set is EMPTY, which an environment nobody
      // populated satisfies perfectly. The floor is on the LOWER-case names,
      // because those are what a registrar legitimately contributes here.
      var total = 0;
      for (final entry in _registrars.entries) {
        final env = Environment();
        entry.value(env);
        total += env.values.length;
      }
      expect(
        total,
        greaterThanOrEqualTo(8),
        reason:
            'only $total value bindings across all ${_registrars.length} '
            'registrars — they did not run, and every name would then read as '
            'correctly shaped by absence',
      );
    });

    test('F-SCD175-2: no registrar leaves a capitalised name in the value '
        'environment [2026-09-15] (PASS)', () {
      final offenders = <String>[];
      for (final entry in _registrars.entries) {
        _classShapedValues(entry.value).forEach((name, value) {
          if (_allowedValueBindings.containsKey(name)) return;
          offenders.add('${entry.key}: $name -> ${value.runtimeType}');
        });
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'These are bound with `define`, not registered with '
            '`defineBridge`. A class-shaped name bound to a value constructs '
            'and prints like a working bridge and fails only on `is` — which '
            'is how the last four survived until SCC64 audited for it. '
            'Register the class as a bridge; if the name genuinely is not a '
            'class, add it to _allowedValueBindings with the reason.',
      );
    });

    test('F-SCD175-3: the sweep sees a class-shaped binding when there is one '
        '[2026-09-15] (PASS)', () {
      // The control. F-SCD175-2 asserts an ABSENCE, so on its own it cannot
      // distinguish "nothing is wrong" from "the sweep is looking in the wrong
      // map" — and `defineBridge` really does write to a different one, which
      // is exactly the confusion this guard could fall into.
      final env = Environment();
      CoreStdlib.register(env);
      expect(
        env.values.keys.where(_classShaped.hasMatch),
        isEmpty,
        reason: 'precondition: dart:core is clean',
      );
      env.define('ZzClassShaped', () => 1);
      expect(
        env.values.keys.where(_classShaped.hasMatch),
        contains('ZzClassShaped'),
        reason:
            'the sweep must read the map `define` writes to, or F-SCD175-2 is '
            'permanently and meaninglessly green',
      );
    });

    test('F-SCD175-4: no allowlist entry outlives its cause '
        '[2026-09-15] (PASS)', () {
      final stale = <String>[];
      for (final name in _allowedValueBindings.keys) {
        final bound = _registrars.values.any(
          (register) => _classShapedValues(register).containsKey(name),
        );
        if (!bound) stale.add(name);
      }
      expect(
        stale,
        isEmpty,
        reason:
            'These names are permitted and no registrar binds them any more. A '
            'permission left behind reads as a known exception and hides the '
            'next real one.\n${stale.join('\n')}',
      );
    });
  });
}
