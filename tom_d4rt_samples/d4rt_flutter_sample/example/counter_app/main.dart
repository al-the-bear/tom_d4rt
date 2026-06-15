// Minimal counter — verifies the multi-file sample pipeline + the
// script-side `State.setState` rebuild path end-to-end. The increment
// proves GEN-112 (RC-9 fallback routes through `nativeStateProxy`)
// and GEN-110 (MethodInvocation Function-arg dispatch + Callable
// wrapping) are both wired correctly.
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
