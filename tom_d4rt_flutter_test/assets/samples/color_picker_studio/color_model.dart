// Pure-Dart colour conversion + recents-list model for the
// color_picker_studio sample (example #11).
//
// Everything here is plain Dart — no `dart:ui`, no Flutter imports —
// so the math is testable inside the d4rt interpreter without
// depending on bridge coverage of `HSVColor` (which is incomplete in
// `tom_d4rt_flutter_ast` today).
//
// Conversions are the textbook RGB <-> HSV transforms:
//   * RGB channels are integers in [0, 255].
//   * Hue is a double in [0, 360).
//   * Saturation/value are doubles in [0, 100] (percent).
//
// Hex parsing accepts "#RRGGBB" / "RRGGBB" (case-insensitive) and
// rejects anything else; clamping happens before parsing so callers
// always get a well-formed channel triple back.
import 'package:flutter/material.dart';

// -- Constants --------------------------------------------------

/// Initial colour shown on first build. Picked to land on round HSV
/// values (h=216, s≈66.7, v=100) so test assertions don't have to
/// dance around floating-point noise.
const Color kInitialColor = Color(0xFF5599FF);

/// Maximum number of swatches kept in the "recents" strip.
const int kRecentsMax = 8;

/// Seeded palette shown on first build so the strip is never empty.
/// The list is deliberately curated to a spread of hues so a hover/
/// tap test can target a specific swatch index reliably.
const List<Color> kDefaultPalette = <Color>[
  Color(0xFFE53935), // red
  Color(0xFFFB8C00), // orange
  Color(0xFFFDD835), // yellow
  Color(0xFF43A047), // green
  Color(0xFF00ACC1), // cyan
  Color(0xFF1E88E5), // blue
  Color(0xFF8E24AA), // purple
  Color(0xFF6D4C41), // brown
];

// -- Conversions ------------------------------------------------

/// Convert an integer RGB triple in [0, 255] to HSV.
///
/// Returns `<double>[hue (0..360), saturation%, value%]`. Hue is 0
/// for fully achromatic colours (max == min) so the picker doesn't
/// jump when sliding `S` or `V` to zero.
List<double> rgbToHsv(int r, int g, int b) {
  final rd = r / 255.0;
  final gd = g / 255.0;
  final bd = b / 255.0;
  final maxC = rd > gd ? (rd > bd ? rd : bd) : (gd > bd ? gd : bd);
  final minC = rd < gd ? (rd < bd ? rd : bd) : (gd < bd ? gd : bd);
  final delta = maxC - minC;
  double h;
  if (delta == 0.0) {
    h = 0.0;
  } else if (maxC == rd) {
    h = 60.0 * (((gd - bd) / delta) % 6.0);
  } else if (maxC == gd) {
    h = 60.0 * (((bd - rd) / delta) + 2.0);
  } else {
    h = 60.0 * (((rd - gd) / delta) + 4.0);
  }
  if (h < 0.0) h += 360.0;
  final s = maxC == 0.0 ? 0.0 : (delta / maxC) * 100.0;
  final v = maxC * 100.0;
  return <double>[h, s, v];
}

/// Convert an HSV triple back to integer RGB in [0, 255].
///
/// `h` is in [0, 360), `s` and `v` are percentages in [0, 100].
/// Inputs are clamped so callers can pass slider values directly
/// without pre-validating.
List<int> hsvToRgb(double h, double s, double v) {
  final hh = h % 360.0;
  final ss = (s.clamp(0.0, 100.0)) / 100.0;
  final vv = (v.clamp(0.0, 100.0)) / 100.0;
  final c = vv * ss;
  final hPrime = hh / 60.0;
  final x = c * (1.0 - ((hPrime % 2.0) - 1.0).abs());
  double r1 = 0.0, g1 = 0.0, b1 = 0.0;
  if (hPrime < 1.0) {
    r1 = c;
    g1 = x;
  } else if (hPrime < 2.0) {
    r1 = x;
    g1 = c;
  } else if (hPrime < 3.0) {
    g1 = c;
    b1 = x;
  } else if (hPrime < 4.0) {
    g1 = x;
    b1 = c;
  } else if (hPrime < 5.0) {
    r1 = x;
    b1 = c;
  } else {
    r1 = c;
    b1 = x;
  }
  final m = vv - c;
  return <int>[
    ((r1 + m) * 255.0).round().clamp(0, 255),
    ((g1 + m) * 255.0).round().clamp(0, 255),
    ((b1 + m) * 255.0).round().clamp(0, 255),
  ];
}

// -- Hex helpers -------------------------------------------------

/// Format a `Color` as a canonical "#RRGGBB" hex string (uppercase).
String colorToHex(Color color) {
  final r = (color.red & 0xFF).toRadixString(16).padLeft(2, '0');
  final g = (color.green & 0xFF).toRadixString(16).padLeft(2, '0');
  final b = (color.blue & 0xFF).toRadixString(16).padLeft(2, '0');
  return '#${r.toUpperCase()}${g.toUpperCase()}${b.toUpperCase()}';
}

/// Parse "#RRGGBB" / "RRGGBB" into a `Color`. Returns `null` when the
/// input is not a 6-digit hex string. Caller is responsible for
/// showing a user-visible error; the picker simply ignores invalid
/// submissions.
Color? hexToColor(String input) {
  var s = input.trim();
  if (s.startsWith('#')) s = s.substring(1);
  if (s.length != 6) return null;
  final hex = s.toUpperCase();
  for (var i = 0; i < hex.length; i++) {
    final c = hex.codeUnitAt(i);
    final isDigit = c >= 0x30 && c <= 0x39;
    final isHex = c >= 0x41 && c <= 0x46;
    if (!isDigit && !isHex) return null;
  }
  final value = int.parse(hex, radix: 16);
  return Color(0xFF000000 | value);
}

// -- Recents list ------------------------------------------------

/// Push `next` onto a recents list, deduplicating and capping at
/// `kRecentsMax`. The most recent colour is always at index 0; if
/// `next` was already in the list it is moved to the front rather
/// than duplicated.
List<Color> recentsAdd(List<Color> current, Color next) {
  final out = <Color>[next];
  for (final c in current) {
    if (c.value == next.value) continue;
    out.add(c);
    if (out.length >= kRecentsMax) break;
  }
  return out;
}
