// Fa5 canary — deliberately throws inside a child widget's build() to
// verify the SendTestRunner harness records FE>0 when child builds fail.
// This calibrates the Fa5 success signal: if the canary records FE>=1,
// then the inherited_widget/model passes can be trusted.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class _Boom extends StatelessWidget {
  const _Boom();
  @override
  Widget build(BuildContext context) {
    throw StateError('fa5-canary: deliberate throw to verify harness signal');
  }
}

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: Center(child: _Boom())),
  );
}
