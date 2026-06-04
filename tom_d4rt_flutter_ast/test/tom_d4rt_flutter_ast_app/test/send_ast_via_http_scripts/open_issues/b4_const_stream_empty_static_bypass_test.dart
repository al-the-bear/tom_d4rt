// Reproduces B.4 — const-shaped constructor bypasses static-method registration.
//
// `const Stream<int>.empty()` routes only through `findConstructorAdapter` and
// never consults `staticMethods`, so the factory-as-static registration is
// missed and construction fails.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const Stream<int> source = Stream<int>.empty();
  return StreamBuilder<int>(
    stream: source,
    builder: (BuildContext c, AsyncSnapshot<int> snap) =>
        const SizedBox.shrink(),
  );
}
