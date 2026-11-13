// ghissues21 — a bridged enum is one type: `is` accepts it, and an alias or a
// second registration of it is the same type.
//
// Measured 2026-11-10 in the Flutter AST twin (published tom_d4rt_ast 0.212.1
// and the 0.225.0 tree alike), with `MaterialState` an alias of the bridged
// enum `WidgetState`:
//
//   WidgetState.hovered is WidgetState        // threw: Type check failed:
//                                             //   Type 'WidgetState' not found
//                                             //   or is not a BridgedEnumValue.
//   WidgetState.hovered is MaterialState      // threw the same
//   String takes(MaterialState s) => s.name;
//   takes(WidgetState.hovered)                // type 'WidgetState' is not a
//                                             //   subtype of type 'WidgetState'
//
// Two defects. `is` had no branch for a bridged enum type, so any `x is E`
// with E a bridged enum threw. And the generator emits one
// `BridgedEnumDefinition` per bridge file that exports the enum (WidgetState
// is in three), each built its own `BridgedEnum`, and the alias bound
// whichever was registered first while later registrations replaced the
// name - two different objects named WidgetState, compared by identity. An
// enum alias now follows its target's current registration, two
// `BridgedEnum`s over one native enum are one type, and `is` decides a
// bridged enum type like a parameter check does. The same in tom_d4rt_ast
// (test/runtime/ghissues21_bridged_enum_type_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

enum Gh21State { hovered, focused, pressed }

const _entry = 'package:p/main.dart';

/// `Gh21State` defined twice, as two bridge files do, under the libraries
/// `package:w/widgets.dart` and `package:w/material.dart`, with the alias
/// `Gh21MaterialState` registered beside the second.
D4rt _interpreter() => D4rt()
  ..registerBridgedEnum(
    BridgedEnumDefinition<Gh21State>(
      name: 'Gh21State',
      values: Gh21State.values,
    ),
    'package:w/widgets.dart',
  )
  ..registerBridgedEnum(
    BridgedEnumDefinition<Gh21State>(
      name: 'Gh21State',
      values: Gh21State.values,
    ),
    'package:w/material.dart',
  )
  ..registerClassAlias(
    'Gh21MaterialState',
    'Gh21State',
    'package:w/material.dart',
  );

Object? _run(String body) => _interpreter().execute(
  library: _entry,
  sources: {
    _entry:
        "import 'package:w/material.dart';\n"
        "import 'package:w/widgets.dart';\n"
        'String takes(Gh21MaterialState s) => s.name;\n'
        'String takesState(Gh21State s) => s.name;\n'
        'main() => $body;\n',
  },
);

void main() {
  group('ghissues21: a bridged enum is one type', () {
    test('GHI21-1: `is` accepts a bridged enum type, its alias, and refuses '
        'another type [2026-11-10]', () {
      expect(
        _run(
          '[Gh21State.hovered is Gh21State, Gh21State.hovered is '
          'Gh21MaterialState, Gh21MaterialState.focused is Gh21State, '
          "'x' is Gh21State, 1 is Gh21MaterialState]",
        ),
        [true, true, true, false, false],
      );
    });

    test('GHI21-2: a parameter of the alias type takes a value of the enum, '
        'and the reverse [2026-11-10]', () {
      expect(
        _run(
          '[takes(Gh21State.hovered), takesState(Gh21MaterialState.pressed)]',
        ),
        ['hovered', 'pressed'],
      );
    });

    test('GHI21-3: the alias and the enum name the same values '
        '[2026-11-10]', () {
      expect(
        _run(
          '[Gh21MaterialState.hovered == Gh21State.hovered, '
          '<Gh21MaterialState>[Gh21State.pressed].length, '
          '(Gh21State.focused as Gh21MaterialState).name]',
        ),
        [true, 1, 'focused'],
      );
    });
  });
}
