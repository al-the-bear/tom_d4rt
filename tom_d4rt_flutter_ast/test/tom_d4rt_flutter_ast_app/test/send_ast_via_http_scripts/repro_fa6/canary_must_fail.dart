// Fa6 canary — deliberately throws inside a child widget's build() to
// verify the SendTestRunner harness records FE>0 when child builds fail.
// Calibration mirror of fa5 canary; see the `20260428-1333`
// issue-analysis sweep (Fa6).
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class _Boom extends StatelessWidget {
  const _Boom();
  @override
  Widget build(BuildContext context) {
    throw StateError('fa6-canary: deliberate throw to verify harness signal');
  }
}

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: Center(child: _Boom())),
  );
}
