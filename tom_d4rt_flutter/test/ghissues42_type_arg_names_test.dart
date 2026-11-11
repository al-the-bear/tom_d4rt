// RUNNER BUCKET: guard — run_guard_tests.sh
// ghissues42 — the hand-written name-keyed dispatch reads a type argument's
// name with its `?` and its own type arguments.
//
// Since tom_d4rt 1.257.0 (tom_d4rt_ast 0.237.0) a script's type argument
// reaches a generic constructor or interceptor as `String?` or `_Scope<int>`,
// where it used to read `String` / `_Scope`. The registrations in
// `d4rt_runtime_registrations.dart` switched on the plain name, so
// `ValueNotifier<String?>('a')` took the bridge constructor's inferred
// `ValueNotifier<String>` (and refused a later `value = null`), and
// `dependOnInheritedWidgetOfExactType<_Scope<int>>()` and
// `theme.extension<_Brand<int>>()` found nothing. They now dispatch on the name
// without its type arguments and keep the `?` (`_typeArgSelector`), and the
// class lookups compare the class (`_typeArgClassName`).
//
// The interpreter this package resolves from pub.dev reads the plain names
// until ghissues999 publishes 1.257.0, so the tests skip themselves below it;
// `tool/prepublish_overrides.dart --set` runs them against the tree.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

const _script = r'''
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _Scope<T> extends InheritedWidget {
  const _Scope({required this.value, required super.child});
  final T value;
  @override
  bool updateShouldNotify(_Scope<T> oldWidget) => value != oldWidget.value;
}

class _Brand<T> extends ThemeExtension<_Brand<T>> {
  const _Brand(this.value);
  final T value;
  @override
  _Brand<T> copyWith() => this;
  @override
  _Brand<T> lerp(_Brand<T>? other, double t) => this;
}

List<Object?> notifiers() {
  final empty = ValueNotifier<String?>(null);
  final cleared = ValueNotifier<String?>('a');
  cleared.value = null;
  return <Object?>[
    empty,
    cleared,
    ValueNotifier<double?>(1),
    ValueKey<int?>(3),
  ];
}

Widget scope() => _Scope<int>(
  value: 7,
  child: Builder(
    builder: (context) {
      final found = context.dependOnInheritedWidgetOfExactType<_Scope<int>>();
      return Text('found ${found?.value}', textDirection: TextDirection.ltr);
    },
  ),
);

Object? themeExtension() {
  final theme = ThemeData(extensions: <ThemeExtension<dynamic>>[_Brand<int>(5)]);
  return theme.extension<_Brand<int>>()?.value;
}
''';

Future<T> _run<T>(String entry) async =>
    SourceFlutterD4rt().execute<T>('$_script\nObject? main() => $entry();\n');

/// The version of [package] this package resolves, read from its pubspec.
List<int> _resolvedVersion(String package) {
  final config =
      jsonDecode(File('.dart_tool/package_config.json').readAsStringSync())
          as Map<String, Object?>;
  final entry = (config['packages']! as List)
      .cast<Map<String, Object?>>()
      .firstWhere((p) => p['name'] == package);
  final rootUri = entry['rootUri']! as String;
  final root = Uri.directory(
    '${Directory.current.path}/.dart_tool/',
  ).resolve(rootUri.endsWith('/') ? rootUri : '$rootUri/');
  final pubspec = File.fromUri(root.resolve('pubspec.yaml')).readAsStringSync();
  final version = RegExp(
    r'^version:\s*(\d+)\.(\d+)\.(\d+)',
    multiLine: true,
  ).firstMatch(pubspec)!;
  return [for (var i = 1; i <= 3; i++) int.parse(version[i]!)];
}

/// Why the tests skip, or false once the interpreter names `T?` and `T<U>`.
Object get _skip {
  final v = _resolvedVersion('tom_d4rt');
  final keepsNames = v[0] > 1 || v[1] >= 257;
  return keepsNames
      ? false
      : 'ghissues999: tom_d4rt ${v.join('.')} reads type arguments without '
            'their `?` and type arguments; 1.257.0 (unpublished) keeps them. '
            'tool/prepublish_overrides.dart --set runs these tests.';
}

void main() {
  group('ghissues42: name-keyed dispatch of T? and T<U> type arguments', () {
    test('GHI42-1: a nullable type argument builds the nullable notifier and '
        'key [2026-11-11]', () async {
      final result = await _run<List<Object?>>('notifiers');
      expect(result[0], isA<ValueNotifier<String?>>());
      expect((result[0]! as ValueNotifier<String?>).value, isNull);
      expect(result[1], isA<ValueNotifier<String?>>());
      expect((result[1]! as ValueNotifier<String?>).value, isNull);
      expect(result[2], isA<ValueNotifier<double?>>());
      expect((result[2]! as ValueNotifier<double?>).value, 1.0);
      expect(result[3], isA<ValueKey<int?>>());
    }, skip: _skip);

    testWidgets(
      'GHI42-2: dependOnInheritedWidgetOfExactType<_Scope<int>>() finds the '
      'script scope [2026-11-11]',
      (tester) async {
        final widget = await tester.runAsync(() => _run<Widget>('scope'));
        await tester.pumpWidget(widget!);
        expect(find.text('found 7'), findsOneWidget);
      },
      skip: _skip != false,
    );

    test('GHI42-3: theme.extension<_Brand<int>>() finds the script extension '
        '[2026-11-11]', () async {
      expect(await _run<Object?>('themeExtension'), 5);
    }, skip: _skip);
  });
}
