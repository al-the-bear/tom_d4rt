// Reproduces A.7 — bridged text layout feeds NaN into Offset/Rect construction.
//
// Two distinct sub-symptoms, both non-fatal but recorded as FE > 0:
//
//   U16 — `Text('')`: a zero-glyph paragraph built through the bridge produces
//   "Offset argument contained a NaN value" (dart:ui/painting.dart). Under an
//   `IntrinsicHeight` it surfaces instead as "BoxConstraints forces an infinite
//   height". Native (non-interpreted) Flutter lays out `Text('')` cleanly — see
//   the control test `tom_d4rt_flutter/test/a7_empty_text_nan_control_test.dart`
//   — so the NaN is a genuine bridged-paragraph-path defect.
//
//   U19 — a per-character `TextSpan` stream of non-Latin glyphs (e.g. each
//   character of 'こんにちは' as its own child span) NaNs a `Rect` construction
//   (dart:ui/painting.dart, `_rectIsValid`) only through the bridge. It requires
//   BOTH per-character `TextSpan` fragmentation AND non-Latin glyphs. A
//   `Text`-level override cannot reach this `RichText`/`TextSpan` tree, so U19
//   is the harder half of A.7 (needs `TextSpan`/`RichText` normalization).
//
// The candidate `@D4rtUserBridge('package:flutter/src/widgets/text.dart','Text')`
// override addresses U16 (empty `data` → zero-width space) once the bridges are
// regenerated; U19 remains open.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // U19 — fragment a non-Latin string into one TextSpan per character.
  const String greeting = 'こんにちは';
  final List<TextSpan> perCharSpans = <TextSpan>[
    for (int i = 0; i < greeting.length; i++)
      TextSpan(text: greeting[i]),
  ];

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // U16 — empty Text triggers the zero-glyph-paragraph NaN.
        const Text(''),
        // U19 — per-character non-Latin TextSpan tree triggers the Rect NaN.
        Text.rich(
          TextSpan(children: perCharSpans),
          textDirection: TextDirection.ltr,
        ),
      ],
    ),
  );
}
