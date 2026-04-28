// Fa5 reproducer — script-defined InheritedWidget subclass + child that
// calls dependOnInheritedWidgetOfExactType<MyScope>(context).
//
// Hypothesis (Fa5 cluster doc): all interpreted InheritedWidget subclasses
// collapse to the same native runtimeType (`_InterpretedInheritedWidget`),
// so Flutter's _inheritedElements map (keyed by widget.runtimeType) cannot
// disambiguate.
//
// Expected behaviour after the existing interceptors landed:
// `dependOnInheritedWidgetOfExactType<MyScope>` must return the
// InterpretedInstance whose klass.name matches "MyScope" via
// `_findInheritedElementForType` + `_unwrapInheritedWidget`.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class MyScope extends InheritedWidget {
  final int value;
  final String label;

  const MyScope({
    super.key,
    required this.value,
    required this.label,
    required super.child,
  });

  static MyScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyScope>();
  }

  @override
  bool updateShouldNotify(MyScope oldWidget) =>
      value != oldWidget.value || label != oldWidget.label;
}

class _Reader extends StatelessWidget {
  const _Reader();

  @override
  Widget build(BuildContext context) {
    final scope = MyScope.of(context);
    print('[fa5-iw] reader scope=${scope == null ? 'NULL' : 'ok'}');
    if (scope == null) {
      // Surface the runtimeType-collapse failure as a framework error so
      // the harness records FE>0 instead of silently rendering placeholder
      // text.
      throw StateError(
        'fa5-iw: dependOnInheritedWidgetOfExactType<MyScope> returned null '
        '— interpreted InheritedWidget runtimeType collapse',
      );
    }
    final v = scope.value;
    final l = scope.label;
    if (v != 42 || l != 'fa5-test') {
      throw StateError(
        'fa5-iw: read wrong values — expected (42, "fa5-test"), '
        'got ($v, "$l")',
      );
    }
    return Text('value=$v label="$l"');
  }
}

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Scaffold(
      body: MyScope(
        value: 42,
        label: 'fa5-test',
        child: Center(child: _Reader()),
      ),
    ),
  );
}
