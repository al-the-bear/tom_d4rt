// Minimal counter — exists as a diagnostic for the multi-file sample
// pipeline. If the counter increments when the FAB is tapped, setState
// on a user-defined StatefulWidget spanning two files works end-to-end.
import 'package:flutter/material.dart';

import 'counter.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Counter',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: const CounterHome(),
  );
}
