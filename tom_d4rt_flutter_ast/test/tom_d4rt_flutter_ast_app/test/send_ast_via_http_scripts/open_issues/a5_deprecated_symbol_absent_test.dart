// Reproduces A.5 — @Deprecated SDK symbols are absent from the bridge surface.
//
// `ButtonBar` is `@Deprecated` in current Flutter. The generator runs with
// `generateDeprecatedElements = false`, so every @Deprecated element is skipped
// and the symbol is undefined in scripts.
//
// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return ButtonBar(
    children: <Widget>[
      TextButton(onPressed: () {}, child: const Text('OK')),
    ],
  );
}
