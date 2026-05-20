// Minimal counter — exists as a diagnostic for the multi-file sample
// pipeline. The increment shows that `StatefulBuilder.setState` (the
// only setState path that currently schedules a Flutter rebuild in
// tom_d4rt) works across files.
//
// NOTE on the d4rt limitation: a user-defined `StatefulWidget` +
// `State<...>` subclass written in script source can mutate its
// own fields, but its `setState` does NOT trigger a Flutter rebuild
// in the analyzer-based interpreter today. See
// `tom_d4rt_flutter_ast/doc/interpreter_issues.md` (entry on
// "user-defined State.setState is a no-op for Flutter rebuild").
// Until that lands a real fix, samples use `StatefulBuilder` for
// any interactivity.
import 'package:flutter/material.dart';

import 'counter.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Counter',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: CounterHome(),
  );
}
