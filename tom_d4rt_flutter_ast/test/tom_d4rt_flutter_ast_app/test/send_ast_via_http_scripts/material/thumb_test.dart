// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// Slider Thumb Family — Deep Demo
// -----------------------------------------------------------------------------
// This script is a hand-authored, comprehensive walkthrough of the Material
// slider thumb family.  It demonstrates the abstract `SliderComponentShape`
// contract, the concrete shipped subclasses (`RoundSliderThumbShape`,
// `RoundRangeSliderThumbShape`), the Material 3 `HandleThumbShape`, the
// `Thumb` enum used to disambiguate the two handles of a `RangeSlider`, and
// the supporting cast of track/tick/overlay/value-indicator shapes that the
// thumb interacts with at paint time.
//
// The harness contract requires:
//   * the first non-comment line is the analyzer ignore directive,
//   * imports stay restricted to `package:flutter/material.dart`,
//   * a single top-level `dynamic build(BuildContext context)` that returns a
//     `MaterialApp` whose body is a `Scaffold` → `SafeArea` →
//     `SingleChildScrollView` → `Column` of section cards,
//   * no `main()`, no `runApp()`, no `testWidgets()`,
//   * each interactive section runs inside a `StatefulBuilder` so that the
//     section's local state stays inside the section.
//
// Each section paints a card-style container with a distinct palette so that
// scrolling the harness produces an obvious vertical rhythm.  Educational
// prose explains *when* to reach for each shape, and the file ends with a
// reference card that summarises the painting pipeline.
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Distinct section palettes.  We use a small constant table per section so the
// colour choices do not drift mid-section and so reviewers can see at a glance
// which colours belong to which scenario.
// -----------------------------------------------------------------------------
const Color _heroBg = Color(0xFFEDE7F6);
const Color _heroAccent = Color(0xFF4527A0);
const Color _heroInk = Color(0xFF1A0E4D);

const Color _defaultBg = Color(0xFFE3F2FD);
const Color _defaultAccent = Color(0xFF1565C0);
const Color _defaultInk = Color(0xFF0D2E58);

const Color _roundBg = Color(0xFFE8F5E9);
const Color _roundAccent = Color(0xFF2E7D32);
const Color _roundInk = Color(0xFF1B3D1F);

const Color _disabledBg = Color(0xFFFAFAFA);
const Color _disabledEnabled = Color(0xFF455A64);
const Color _disabledMuted = Color(0xFFB0BEC5);
const Color _disabledInk = Color(0xFF263238);

const Color _rangeBg = Color(0xFFFFF3E0);
const Color _rangeAccent = Color(0xFFE65100);
const Color _rangeInk = Color(0xFF6A2C00);

const Color _customBg = Color(0xFFFCE4EC);
const Color _customAccent = Color(0xFFAD1457);
const Color _customInk = Color(0xFF560027);

const Color _indicatorBg = Color(0xFFE0F7FA);
const Color _indicatorAccent = Color(0xFF00838F);
const Color _indicatorInk = Color(0xFF003844);

const Color _trackBg = Color(0xFFEDE7F6);
const Color _trackRoundedAccent = Color(0xFF512DA8);
const Color _trackRectAccent = Color(0xFF311B92);
const Color _trackInk = Color(0xFF1A0E4D);

const Color _ticksBg = Color(0xFFFFF8E1);
const Color _ticksAccent = Color(0xFFF57F17);
const Color _ticksInk = Color(0xFF5C3A00);

const Color _overlayBg = Color(0xFFE8EAF6);
const Color _overlayAccent = Color(0xFF283593);
const Color _overlayInk = Color(0xFF101542);

const Color _palettePink = Color(0xFFD81B60);
const Color _paletteTeal = Color(0xFF00796B);
const Color _palettePurple = Color(0xFF6A1B9A);
const Color _paletteBg = Color(0xFFF3E5F5);
const Color _paletteInk = Color(0xFF4A148C);

const Color _collisionBg = Color(0xFFFFEBEE);
const Color _collisionAccent = Color(0xFFC62828);
const Color _collisionInk = Color(0xFF6A0F12);

const Color _decisionBg = Color(0xFFF1F8E9);
const Color _decisionAccent = Color(0xFF33691E);
const Color _decisionInk = Color(0xFF1B3300);

const Color _refBg = Color(0xFFECEFF1);
const Color _refInk = Color(0xFF263238);

// -----------------------------------------------------------------------------
// Custom SliderComponentShape — a diamond-shaped thumb.
//
// `SliderComponentShape` is the abstract base class used by `Slider` and
// `RangeSlider` for every painted "spot": the thumb itself, the tick marks,
// the overlay (the soft halo behind the thumb), and the value indicator.
// Subclasses must implement two methods:
//
//   1. `Size getPreferredSize(bool isEnabled, bool isDiscrete)` — returns the
//      bounding box that Flutter reserves for the shape during layout.  Both
//      flags should influence the size if the shape wishes to grow when the
//      slider is enabled or shrink when it is discrete (i.e. a divisions slider
//      where the user may snap to integer steps).
//   2. `void paint(...)` — the actual painter, with a generous parameter list
//      that exposes the canvas, the centre, the animations, and any value
//      strings.
//
// We define one diamond thumb here; it scales between 6 and 12 logical pixels
// based on enabled state and is filled with the colour returned by
// `sliderTheme.thumbColor`, falling back to `colorScheme.primary`.
// -----------------------------------------------------------------------------
class _DiamondThumbShape extends SliderComponentShape {
  const _DiamondThumbShape({
    this.enabledRadius = 12.0,
    this.disabledRadius = 8.0,
  });

  final double enabledRadius;
  final double disabledRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    final double r = isEnabled ? enabledRadius : disabledRadius;
    return Size.fromRadius(r);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final Color fill = colorTween.evaluate(enableAnimation) ?? Colors.blueGrey;

    final double radius = enabledRadius * enableAnimation.value +
        disabledRadius * (1.0 - enableAnimation.value);

    final Path diamond = Path()
      ..moveTo(center.dx, center.dy - radius)
      ..lineTo(center.dx + radius, center.dy)
      ..lineTo(center.dx, center.dy + radius)
      ..lineTo(center.dx - radius, center.dy)
      ..close();

    final Paint shadow = Paint()
      ..color = Colors.black.withOpacity(0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawPath(diamond.shift(const Offset(0, 1.5)), shadow);

    final Paint paintFill = Paint()
      ..color = fill
      ..style = PaintingStyle.fill;
    canvas.drawPath(diamond, paintFill);

    final Paint stroke = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(diamond, stroke);
  }
}

// -----------------------------------------------------------------------------
// Custom SliderComponentShape — a square thumb with a coloured chevron.
//
// This second custom shape exists so that we have two distinct demonstrations
// of `SliderComponentShape` subclassing in the file, and so that the reader
// can compare a "rounded primitive" approach (the diamond above) against a
// "blocky" approach (the square with chevron).
// -----------------------------------------------------------------------------
class _SquareChevronThumbShape extends SliderComponentShape {
  const _SquareChevronThumbShape({this.side = 18.0});

  final double side;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.square(isEnabled ? side : side - 4);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final double t = enableAnimation.value;
    final double currentSide = side - (1.0 - t) * 4.0;
    final double s = currentSide * 0.5;

    final Rect square = Rect.fromCenter(
      center: center,
      width: s * 2,
      height: s * 2,
    );

    final Color fill = sliderTheme.thumbColor ?? Colors.deepPurple;

    final Paint shadow = Paint()
      ..color = Colors.black.withOpacity(0.20)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawRRect(
      RRect.fromRectAndRadius(square.shift(const Offset(0, 2)), const Radius.circular(3)),
      shadow,
    );

    final Paint paintFill = Paint()
      ..color = fill
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(square, const Radius.circular(3)),
      paintFill,
    );

    // Chevron mark to communicate "draggable".
    final Paint chevron = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    final double cx = center.dx;
    final double cy = center.dy;
    canvas.drawLine(Offset(cx - 3, cy - 3), Offset(cx, cy), chevron);
    canvas.drawLine(Offset(cx, cy), Offset(cx - 3, cy + 3), chevron);
    canvas.drawLine(Offset(cx + 3, cy - 3), Offset(cx, cy), chevron);
    canvas.drawLine(Offset(cx, cy), Offset(cx + 3, cy + 3), chevron);
  }
}

// -----------------------------------------------------------------------------
// Helper widgets used by every section.  Centralising them keeps the section
// code focused on the specific thumb-shape configuration under test.
// -----------------------------------------------------------------------------
Widget _sectionHeader(
  String number,
  String title,
  Color bg,
  Color ink,
) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 24, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: ink, width: 4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: ink,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bodyText(String text, {Color color = Colors.black87}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(color: color, fontSize: 13, height: 1.45),
    ),
  );
}

Widget _readout(String label, double v, Color ink) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ink.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Text(
            '$label ',
            style: TextStyle(
              color: ink,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            'value = ${v.toStringAsFixed(2)}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ],
      ),
    ),
  );
}

Widget _rangeReadout(String label, RangeValues v, Color ink) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ink.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Text(
            '$label  ',
            style: TextStyle(
              color: ink,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            'start=${v.start.toStringAsFixed(2)}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          const SizedBox(width: 12),
          Text(
            'end=${v.end.toStringAsFixed(2)}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          const Spacer(),
          Text(
            '|Δ|=${(v.end - v.start).abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: ink,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// build — entry point invoked by the harness.
// =============================================================================
dynamic build(BuildContext context) {
  print('=== Slider Thumb Family Deep Demo ===');
  print('Thirteen sections demonstrating SliderComponentShape, '
      'RoundSliderThumbShape, RoundRangeSliderThumbShape, '
      'HandleThumbShape, the Thumb enum, and supporting shapes.');

  // ===========================================================================
  // SECTION 1 — HERO CARD
  // ---------------------------------------------------------------------------
  // The hero introduces the slider thumb concept end-to-end.  A `Slider` is
  // composed of a *track*, a *thumb*, optional *tick marks*, an *overlay*, and
  // an optional *value indicator*; the thumb is the user's grip, the visible
  // representation of the current value.  Material defines several shipped
  // thumb shapes; in M2 the default is `RoundSliderThumbShape`, in M3 it is
  // `HandleThumbShape` (a vertical capsule), and a `RangeSlider` uses
  // `RoundRangeSliderThumbShape` for both endpoints.  All of those are
  // subclasses of the abstract `SliderComponentShape`.
  // ===========================================================================
  final heroSection = Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _heroBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _heroAccent.withOpacity(0.4)),
      boxShadow: [
        BoxShadow(
          color: _heroAccent.withOpacity(0.12),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _heroAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.tune,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Slider thumb family',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: _heroInk,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'A slider thumb is the draggable knob that represents the current '
          'value.  Flutter\'s Material library exposes the abstract '
          '`SliderComponentShape` and ships concrete subclasses for the '
          'common cases: `RoundSliderThumbShape` for the M2 circle thumb, '
          '`RoundRangeSliderThumbShape` for the two endpoints of a '
          'RangeSlider, and the M3 `HandleThumbShape` capsule.',
          style: TextStyle(color: _heroInk, fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 12),
        const Text(
          'A `RangeSlider` uses a `Thumb` enum (with values `start` and '
          '`end`) so that range thumb shapes can paint themselves '
          'differently for the leading and trailing handle.  This deep demo '
          'walks through all of those concepts with live, draggable widgets.',
          style: TextStyle(color: _heroInk, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 16),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.45;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 12,
                          pressedElevation: 8,
                        ),
                        activeTrackColor: _heroAccent,
                        inactiveTrackColor: _heroAccent.withOpacity(0.25),
                        thumbColor: _heroAccent,
                        overlayColor: _heroAccent.withOpacity(0.18),
                        trackHeight: 6,
                      ),
                      child: Slider(
                        value: v,
                        min: 0,
                        max: 1,
                        onChanged: (double nv) {
                          setLocal(() => v = nv);
                        },
                      ),
                    ),
                    _readout('HERO', v, _heroInk),
                  ],
                );
              },
            );
          },
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2 — DEFAULT THEME (Material 3 thumb)
  // ---------------------------------------------------------------------------
  // When you embed a plain `Slider` inside a `MaterialApp` whose theme has
  // `useMaterial3: true`, Flutter automatically selects the M3
  // `HandleThumbShape` — a tall, narrow vertical capsule.  We do not hard-wire
  // it here because not every Flutter version exposes the symbol; instead we
  // *omit* `thumbShape` so that the framework picks the default.  The
  // surrounding card colours track the M3 palette so the visual is recognisable
  // even on platforms where the symbol is internally named differently.
  // ===========================================================================
  final defaultSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _defaultBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Default M3 thumb (HandleThumbShape, framework selected)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _defaultAccent,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'No thumbShape override — the framework picks the platform default. '
          'On Material 3 this is HandleThumbShape, a vertical capsule '
          '(~4 px wide × ~44 px tall) that creates a distinct gripping motif '
          'for selection sliders.',
          style: TextStyle(color: _defaultInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.30;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Slider(
                      value: v,
                      min: 0,
                      max: 1,
                      onChanged: (double nv) {
                        setLocal(() => v = nv);
                      },
                    ),
                    _readout('M3', v, _defaultInk),
                  ],
                );
              },
            );
          },
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3 — RoundSliderThumbShape with explicit radii / elevation
  // ---------------------------------------------------------------------------
  // RoundSliderThumbShape is the Material 2 default, a filled circle.  Its
  // constructor accepts:
  //   * `enabledThumbRadius`  — radius when the slider is enabled,
  //   * `disabledThumbRadius` — optional radius when disabled (default: 4),
  //   * `elevation`           — drop-shadow size for the resting state,
  //   * `pressedElevation`    — drop-shadow size while the user presses the
  //     thumb.  Flutter animates between the two.
  // We expose three distinct configurations side-by-side: a tiny thumb
  // suitable for dense lists, a medium "default" thumb, and a chunky thumb
  // for finger-first interaction.
  // ===========================================================================
  final roundSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _roundBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RoundSliderThumbShape — explicit radii and elevation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _roundAccent,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Three sliders share min/max but use distinct '
          'RoundSliderThumbShape configurations.  The radius drives the '
          'visual weight; the pressedElevation governs how dramatically the '
          'shadow lifts when the user presses the thumb.',
          style: TextStyle(color: _roundInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double a = 0.20;
            double b = 0.50;
            double c = 0.80;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'tiny — radius 6, elevation 1, pressed 4',
                        style: TextStyle(fontSize: 12, color: _roundInk),
                      ),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                          elevation: 1,
                          pressedElevation: 4,
                        ),
                        activeTrackColor: _roundAccent,
                        inactiveTrackColor: _roundAccent.withOpacity(0.25),
                        thumbColor: _roundAccent,
                        overlayColor: _roundAccent.withOpacity(0.15),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: a,
                        onChanged: (double v) => setLocal(() => a = v),
                      ),
                    ),
                    _readout('TINY', a, _roundInk),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'medium — radius 10, elevation 2, pressed 6',
                        style: TextStyle(fontSize: 12, color: _roundInk),
                      ),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10,
                          elevation: 2,
                          pressedElevation: 6,
                        ),
                        activeTrackColor: _roundAccent,
                        inactiveTrackColor: _roundAccent.withOpacity(0.25),
                        thumbColor: _roundAccent,
                        overlayColor: _roundAccent.withOpacity(0.18),
                        trackHeight: 6,
                      ),
                      child: Slider(
                        value: b,
                        onChanged: (double v) => setLocal(() => b = v),
                      ),
                    ),
                    _readout('MED', b, _roundInk),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'chunky — radius 14, elevation 4, pressed 10',
                        style: TextStyle(fontSize: 12, color: _roundInk),
                      ),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 14,
                          elevation: 4,
                          pressedElevation: 10,
                        ),
                        activeTrackColor: _roundAccent,
                        inactiveTrackColor: _roundAccent.withOpacity(0.25),
                        thumbColor: _roundAccent,
                        overlayColor: _roundAccent.withOpacity(0.20),
                        trackHeight: 8,
                      ),
                      child: Slider(
                        value: c,
                        onChanged: (double v) => setLocal(() => c = v),
                      ),
                    ),
                    _readout('CHUNK', c, _roundInk),
                  ],
                );
              },
            );
          },
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 4 — Disabled vs enabled rendering
  // ---------------------------------------------------------------------------
  // Both `RoundSliderThumbShape` and `RoundRangeSliderThumbShape` honour the
  // `disabledThumbRadius` parameter and the `disabledThumbColor` from
  // `SliderThemeData`.  We render two sliders with identical configuration but
  // one has `onChanged: null`, which puts it in disabled state.  Notice how the
  // thumb shrinks and the track loses saturation.
  // ===========================================================================
  final disabledSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _disabledBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _disabledMuted),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Disabled vs enabled — same shape, different state',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _disabledInk,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Identical SliderTheme; the only difference is whether onChanged '
          'is non-null.  When disabled, RoundSliderThumbShape uses '
          'disabledThumbRadius (smaller) and the disabledThumbColor.',
          style: TextStyle(color: _disabledInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'enabled',
            style: TextStyle(fontSize: 12, color: _disabledInk),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.55;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 12,
                      disabledThumbRadius: 6,
                    ),
                    activeTrackColor: _disabledEnabled,
                    inactiveTrackColor: _disabledEnabled.withOpacity(0.3),
                    thumbColor: _disabledEnabled,
                    disabledThumbColor: _disabledMuted,
                    disabledActiveTrackColor: _disabledMuted,
                    disabledInactiveTrackColor: _disabledMuted.withOpacity(0.5),
                    overlayColor: _disabledEnabled.withOpacity(0.15),
                    trackHeight: 6,
                  ),
                  child: Slider(
                    value: v,
                    onChanged: (double nv) => setLocal(() => v = nv),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'disabled (onChanged: null)',
            style: TextStyle(fontSize: 12, color: _disabledInk),
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 12,
              disabledThumbRadius: 6,
            ),
            activeTrackColor: _disabledEnabled,
            inactiveTrackColor: _disabledEnabled.withOpacity(0.3),
            thumbColor: _disabledEnabled,
            disabledThumbColor: _disabledMuted,
            disabledActiveTrackColor: _disabledMuted,
            disabledInactiveTrackColor: _disabledMuted.withOpacity(0.5),
            overlayColor: _disabledEnabled.withOpacity(0.15),
            trackHeight: 6,
          ),
          child: const Slider(
            value: 0.55,
            onChanged: null,
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 5 — RangeSlider with RoundRangeSliderThumbShape
  // ---------------------------------------------------------------------------
  // `RoundRangeSliderThumbShape` is the M2 range thumb shape.  It paints a
  // filled circle for *each* endpoint, but its `paint` method receives a
  // `Thumb` enum value (`Thumb.start` or `Thumb.end`) so a custom subclass
  // could distinguish the two — for example to add an arrow on the right
  // endpoint pointing right.  The shipped class paints both identically.
  // The `Thumb` enum is the bridge between RangeSlider's two-handle world
  // and the single-handle SliderComponentShape.paint signature.
  // ===========================================================================
  final rangeSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _rangeBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RangeSlider — RoundRangeSliderThumbShape and the Thumb enum',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _rangeAccent,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A RangeSlider draws two thumbs with a connecting active region. '
          'The shape\'s paint() receives a Thumb.start / Thumb.end argument '
          'so subclasses can paint each endpoint differently. The shipped '
          'RoundRangeSliderThumbShape paints both the same.',
          style: TextStyle(color: _rangeInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            RangeValues r = const RangeValues(0.25, 0.75);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        rangeThumbShape: const RoundRangeSliderThumbShape(
                          enabledThumbRadius: 12,
                          disabledThumbRadius: 6,
                          elevation: 2,
                          pressedElevation: 6,
                        ),
                        activeTrackColor: _rangeAccent,
                        inactiveTrackColor: _rangeAccent.withOpacity(0.25),
                        thumbColor: _rangeAccent,
                        overlayColor: _rangeAccent.withOpacity(0.18),
                        trackHeight: 6,
                      ),
                      child: RangeSlider(
                        values: r,
                        min: 0,
                        max: 1,
                        onChanged: (RangeValues v) {
                          setLocal(() => r = v);
                        },
                      ),
                    ),
                    _rangeReadout('RANGE', r, _rangeInk),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Note: Thumb.start always represents the leading edge regardless '
            'of TextDirection — the framework mirrors the visual rendering '
            'for RTL but keeps the enum semantics stable.',
            style: TextStyle(
              fontSize: 12,
              color: _rangeInk,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 6 — Custom SliderComponentShape (diamond)
  // ---------------------------------------------------------------------------
  // `_DiamondThumbShape` is defined at file scope above.  We install it via
  // `SliderThemeData.thumbShape`.  This is the canonical extension point: any
  // subclass of `SliderComponentShape` can be used for the thumb so long as
  // it implements `getPreferredSize` and `paint`.  The diamond is sized based
  // on `enableAnimation.value` so that the thumb shrinks smoothly when the
  // slider becomes disabled.
  // ===========================================================================
  final customDiamondSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _customBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Custom SliderComponentShape — _DiamondThumbShape',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _customAccent,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A subclass of SliderComponentShape that paints a filled diamond. '
          'It implements getPreferredSize (returning a square bounding box) '
          'and paint (drawing four straight segments via Path).  Install it '
          'with SliderThemeData.thumbShape.',
          style: TextStyle(color: _customInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.40;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const _DiamondThumbShape(
                          enabledRadius: 14,
                          disabledRadius: 8,
                        ),
                        activeTrackColor: _customAccent,
                        inactiveTrackColor: _customAccent.withOpacity(0.25),
                        thumbColor: _customAccent,
                        disabledThumbColor: _customAccent.withOpacity(0.4),
                        overlayColor: _customAccent.withOpacity(0.18),
                        trackHeight: 6,
                      ),
                      child: Slider(
                        value: v,
                        onChanged: (double nv) => setLocal(() => v = nv),
                      ),
                    ),
                    _readout('DIAMOND', v, _customInk),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(height: 8),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.65;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const _SquareChevronThumbShape(side: 18),
                        activeTrackColor: _customAccent,
                        inactiveTrackColor: _customAccent.withOpacity(0.25),
                        thumbColor: _customAccent,
                        overlayColor: _customAccent.withOpacity(0.18),
                        trackHeight: 6,
                      ),
                      child: Slider(
                        value: v,
                        onChanged: (double nv) => setLocal(() => v = nv),
                      ),
                    ),
                    _readout('SQUARE', v, _customInk),
                  ],
                );
              },
            );
          },
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 — Value indicators: rectangular vs paddle
  // ---------------------------------------------------------------------------
  // The thumb is paired at paint time with a value indicator that pops above
  // it when the user is dragging a discrete slider (`divisions != null`) or
  // when `showValueIndicator` is set to `always`.  Two shipped indicator shapes
  // exist: `RectangularSliderValueIndicatorShape` (a flat speech bubble) and
  // `PaddleSliderValueIndicatorShape` (a teardrop that pulls toward the thumb).
  // ===========================================================================
  final indicatorSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _indicatorBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Value indicators — rectangular vs paddle',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _indicatorAccent,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'The thumb cooperates with the value indicator: while the user '
          'drags, the indicator floats above the thumb showing the formatted '
          'value.  Install the shape via SliderThemeData.valueIndicatorShape '
          'and the always-on visibility via showValueIndicator.',
          style: TextStyle(color: _indicatorInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'RectangularSliderValueIndicatorShape',
            style: TextStyle(fontSize: 12, color: _indicatorInk),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.4;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                    valueIndicatorShape:
                        const RectangularSliderValueIndicatorShape(),
                    showValueIndicator: ShowValueIndicator.always,
                    activeTrackColor: _indicatorAccent,
                    inactiveTrackColor: _indicatorAccent.withOpacity(0.25),
                    thumbColor: _indicatorAccent,
                    overlayColor: _indicatorAccent.withOpacity(0.18),
                    valueIndicatorColor: _indicatorAccent,
                    valueIndicatorTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    trackHeight: 6,
                  ),
                  child: Slider(
                    value: v,
                    divisions: 10,
                    label: (v * 100).toStringAsFixed(0),
                    onChanged: (double nv) => setLocal(() => v = nv),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'PaddleSliderValueIndicatorShape',
            style: TextStyle(fontSize: 12, color: _indicatorInk),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.7;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                    valueIndicatorShape:
                        const PaddleSliderValueIndicatorShape(),
                    showValueIndicator: ShowValueIndicator.always,
                    activeTrackColor: _indicatorAccent,
                    inactiveTrackColor: _indicatorAccent.withOpacity(0.25),
                    thumbColor: _indicatorAccent,
                    overlayColor: _indicatorAccent.withOpacity(0.18),
                    valueIndicatorColor: _indicatorAccent,
                    valueIndicatorTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    trackHeight: 6,
                  ),
                  child: Slider(
                    value: v,
                    divisions: 20,
                    label: (v * 100).toStringAsFixed(0),
                    onChanged: (double nv) => setLocal(() => v = nv),
                  ),
                );
              },
            );
          },
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 — Track shape combos
  // ---------------------------------------------------------------------------
  // The thumb does not paint the track itself; the track is rendered by a
  // separate `SliderTrackShape`.  Two shipped track shapes exist for the
  // single-value Slider:
  //   * `RoundedRectSliderTrackShape` — capsule, matches M2 default,
  //   * `RectangularSliderTrackShape` — sharp corners, the original M1 look.
  // We pair each track with the same `RoundSliderThumbShape` so the thumb is
  // constant and the track variation is the visible difference.
  // ===========================================================================
  final trackSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _trackBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Track shape combos — RoundedRect vs Rectangular',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _trackInk,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Same thumb (RoundSliderThumbShape, radius 10), different track '
          'shape.  RoundedRectSliderTrackShape is the capsule the user expects '
          'today; RectangularSliderTrackShape gives a more technical, '
          'instrument-panel look.',
          style: TextStyle(color: _trackInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'RoundedRectSliderTrackShape',
            style: TextStyle(fontSize: 12, color: _trackInk),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.5;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                    trackShape: const RoundedRectSliderTrackShape(),
                    activeTrackColor: _trackRoundedAccent,
                    inactiveTrackColor:
                        _trackRoundedAccent.withOpacity(0.25),
                    thumbColor: _trackRoundedAccent,
                    overlayColor: _trackRoundedAccent.withOpacity(0.18),
                    trackHeight: 8,
                  ),
                  child: Slider(
                    value: v,
                    onChanged: (double nv) => setLocal(() => v = nv),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'RectangularSliderTrackShape',
            style: TextStyle(fontSize: 12, color: _trackInk),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.5;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                    trackShape: const RectangularSliderTrackShape(),
                    activeTrackColor: _trackRectAccent,
                    inactiveTrackColor: _trackRectAccent.withOpacity(0.25),
                    thumbColor: _trackRectAccent,
                    overlayColor: _trackRectAccent.withOpacity(0.18),
                    trackHeight: 8,
                  ),
                  child: Slider(
                    value: v,
                    onChanged: (double nv) => setLocal(() => v = nv),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Pairing notes: a chunky thumb + a thin Rectangular track works '
            'well for industrial panels; a tiny thumb + a thick RoundedRect '
            'track works well for compact list rows.',
            style: TextStyle(
              fontSize: 12,
              color: _trackInk,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 9 — Tick marks with discrete divisions
  // ---------------------------------------------------------------------------
  // When `divisions` is set, the slider shows tick marks along the track.
  // The shipped `RoundSliderTickMarkShape` paints small circles (active vs
  // inactive depending on whether the tick is to the left or right of the
  // thumb).  The tick mark colour is selected from
  // `SliderThemeData.activeTickMarkColor` / `inactiveTickMarkColor`.
  // ===========================================================================
  final tickSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _ticksBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tick marks — RoundSliderTickMarkShape with discrete divisions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _ticksAccent,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Setting divisions activates tick marks.  Each tick is painted by '
          'a SliderTickMarkShape; RoundSliderTickMarkShape is the shipped '
          'circular default.  Active ticks (to the left of the thumb) use '
          'activeTickMarkColor; inactive ticks use inactiveTickMarkColor.',
          style: TextStyle(color: _ticksInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.5;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                    tickMarkShape: const RoundSliderTickMarkShape(
                      tickMarkRadius: 3,
                    ),
                    activeTrackColor: _ticksAccent,
                    inactiveTrackColor: _ticksAccent.withOpacity(0.25),
                    thumbColor: _ticksAccent,
                    overlayColor: _ticksAccent.withOpacity(0.18),
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: _ticksInk.withOpacity(0.6),
                    trackHeight: 6,
                  ),
                  child: Slider(
                    value: v,
                    divisions: 10,
                    onChanged: (double nv) => setLocal(() => v = nv),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 8),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.3;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                    tickMarkShape: const RoundSliderTickMarkShape(
                      tickMarkRadius: 5,
                    ),
                    activeTrackColor: _ticksAccent,
                    inactiveTrackColor: _ticksAccent.withOpacity(0.25),
                    thumbColor: _ticksAccent,
                    overlayColor: _ticksAccent.withOpacity(0.18),
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: _ticksInk.withOpacity(0.4),
                    trackHeight: 8,
                  ),
                  child: Slider(
                    value: v,
                    divisions: 5,
                    onChanged: (double nv) => setLocal(() => v = nv),
                  ),
                );
              },
            );
          },
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 10 — Overlay shape with custom radius
  // ---------------------------------------------------------------------------
  // The overlay is the soft halo painted behind the thumb when the user
  // hovers, focuses, or presses it.  `RoundSliderOverlayShape` lets you tune
  // the halo radius via its `overlayRadius` parameter.  The colour comes from
  // `SliderThemeData.overlayColor`.
  // ===========================================================================
  final overlaySection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _overlayBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overlay halo — RoundSliderOverlayShape with tunable radius',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _overlayAccent,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'The overlay is a soft halo behind the thumb shown during hover, '
          'focus, or press.  RoundSliderOverlayShape exposes overlayRadius; '
          'a larger radius makes the halo more pronounced and is useful '
          'for accessibility-sensitive UIs.',
          style: TextStyle(color: _overlayInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'overlayRadius = 24 (default-ish)',
            style: TextStyle(fontSize: 12, color: _overlayInk),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.5;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 24),
                    activeTrackColor: _overlayAccent,
                    inactiveTrackColor: _overlayAccent.withOpacity(0.25),
                    thumbColor: _overlayAccent,
                    overlayColor: _overlayAccent.withOpacity(0.20),
                    trackHeight: 6,
                  ),
                  child: Slider(
                    value: v,
                    onChanged: (double nv) => setLocal(() => v = nv),
                  ),
                );
              },
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'overlayRadius = 36 (chunky halo)',
            style: TextStyle(fontSize: 12, color: _overlayInk),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double v = 0.5;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return SliderTheme(
                  data: SliderThemeData(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 36),
                    activeTrackColor: _overlayAccent,
                    inactiveTrackColor: _overlayAccent.withOpacity(0.25),
                    thumbColor: _overlayAccent,
                    overlayColor: _overlayAccent.withOpacity(0.25),
                    trackHeight: 6,
                  ),
                  child: Slider(
                    value: v,
                    onChanged: (double nv) => setLocal(() => v = nv),
                  ),
                );
              },
            );
          },
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 — Colour theming via SliderThemeData
  // ---------------------------------------------------------------------------
  // The thumb and its supporting shapes resolve their colours from the
  // ambient SliderThemeData.  The most common knobs are:
  //   * thumbColor
  //   * activeTrackColor
  //   * inactiveTrackColor
  //   * overlayColor
  //   * disabledThumbColor / disabledActiveTrackColor / disabledInactiveTrackColor
  // We render three palette-distinct sliders to show how the same shape
  // (RoundSliderThumbShape) reads totally differently under different colours.
  // ===========================================================================
  final paletteSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _paletteBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Colour theming — same shape, three palettes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _paletteInk,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Three sliders with identical RoundSliderThumbShape (radius 11) and '
          'identical track height; only the colour palette changes.  This '
          'isolates the thumb shape from its colour identity so you can '
          'reason about each axis independently.',
          style: TextStyle(color: _paletteInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double a = 0.4;
            double b = 0.6;
            double c = 0.8;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 11,
                        ),
                        activeTrackColor: _palettePink,
                        inactiveTrackColor: _palettePink.withOpacity(0.25),
                        thumbColor: _palettePink,
                        overlayColor: _palettePink.withOpacity(0.20),
                        trackHeight: 6,
                      ),
                      child: Slider(
                        value: a,
                        onChanged: (double v) => setLocal(() => a = v),
                      ),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 11,
                        ),
                        activeTrackColor: _paletteTeal,
                        inactiveTrackColor: _paletteTeal.withOpacity(0.25),
                        thumbColor: _paletteTeal,
                        overlayColor: _paletteTeal.withOpacity(0.20),
                        trackHeight: 6,
                      ),
                      child: Slider(
                        value: b,
                        onChanged: (double v) => setLocal(() => b = v),
                      ),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 11,
                        ),
                        activeTrackColor: _palettePurple,
                        inactiveTrackColor: _palettePurple.withOpacity(0.25),
                        thumbColor: _palettePurple,
                        overlayColor: _palettePurple.withOpacity(0.20),
                        trackHeight: 6,
                      ),
                      child: Slider(
                        value: c,
                        onChanged: (double v) => setLocal(() => c = v),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 12 — Range thumb collision behaviour
  // ---------------------------------------------------------------------------
  // RangeSlider enforces ordering: the start value can never exceed the end
  // value.  When the user drags one thumb past the other, the framework
  // *clamps* it so the two thumbs sit on top of each other, producing a
  // visible collision moment that can be styled by tweaking the overlay and
  // thumb colours.  We render two starting positions: one with a wide range,
  // one with a near-collision (start = 0.49, end = 0.50) so the reader can
  // try the collision interactively.
  // ===========================================================================
  final collisionSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _collisionBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Range thumb collision — drag start past end',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _collisionAccent,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'RangeSlider enforces start ≤ end.  Drag the start thumb toward '
          'the end thumb: the framework clamps the start so the two thumbs '
          'sit at the same logical position.  This is the moment when '
          'making your custom range thumb shape look slightly different per '
          'Thumb (Thumb.start vs Thumb.end) pays off.',
          style: TextStyle(color: _collisionInk, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Wide range — easy to drag without collision',
            style: TextStyle(fontSize: 12, color: _collisionInk),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            RangeValues r = const RangeValues(0.10, 0.90);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        rangeThumbShape: const RoundRangeSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                        activeTrackColor: _collisionAccent,
                        inactiveTrackColor:
                            _collisionAccent.withOpacity(0.25),
                        thumbColor: _collisionAccent,
                        overlayColor: _collisionAccent.withOpacity(0.18),
                        trackHeight: 6,
                      ),
                      child: RangeSlider(
                        values: r,
                        onChanged: (RangeValues v) =>
                            setLocal(() => r = v),
                      ),
                    ),
                    _rangeReadout('WIDE', r, _collisionInk),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Near-collision — start = 0.49, end = 0.50',
            style: TextStyle(fontSize: 12, color: _collisionInk),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            RangeValues r = const RangeValues(0.49, 0.50);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        rangeThumbShape: const RoundRangeSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                        activeTrackColor: _collisionAccent,
                        inactiveTrackColor:
                            _collisionAccent.withOpacity(0.25),
                        thumbColor: _collisionAccent,
                        overlayColor: _collisionAccent.withOpacity(0.18),
                        trackHeight: 6,
                      ),
                      child: RangeSlider(
                        values: r,
                        onChanged: (RangeValues v) =>
                            setLocal(() => r = v),
                      ),
                    ),
                    _rangeReadout('TIGHT', r, _collisionInk),
                  ],
                );
              },
            );
          },
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 13 — When to customise the thumb (decision card)
  // ---------------------------------------------------------------------------
  // A short decision card with three concrete UX scenarios where a custom
  // thumb shape is justified, plus three scenarios where it is not.  This
  // helps engineers decide whether to invest the time to subclass
  // SliderComponentShape vs simply tuning RoundSliderThumbShape's parameters.
  // ===========================================================================
  final decisionSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _decisionBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'When to customise the thumb',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _decisionAccent,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'DO subclass SliderComponentShape when:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _decisionInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        _bodyText(
          '• Domain visual: a thumb that mimics a physical instrument (audio '
          'mixer fader, photographer\'s exposure dial, lock-and-tumbler).',
          color: _decisionInk,
        ),
        _bodyText(
          '• Multi-state painting: the thumb must paint differently '
          'depending on a value derived state (e.g. show a warning glyph '
          'when the value crosses a threshold).',
          color: _decisionInk,
        ),
        _bodyText(
          '• Asymmetric range thumbs: the start and end thumbs need to '
          'differ visually (use the Thumb enum from RoundRangeSliderThumbShape '
          'subclass paint() to branch).',
          color: _decisionInk,
        ),
        const SizedBox(height: 12),
        const Text(
          'DO NOT subclass when:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _decisionInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        _bodyText(
          '• You only need a different size or colour — tune '
          'RoundSliderThumbShape parameters or SliderThemeData fields.',
          color: _decisionInk,
        ),
        _bodyText(
          '• You only need a different elevation — use the elevation / '
          'pressedElevation parameters.',
          color: _decisionInk,
        ),
        _bodyText(
          '• You want to switch between rounded and rectangular looks — set '
          'trackShape and stick with RoundSliderThumbShape.',
          color: _decisionInk,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 14 — Reference card (painting pipeline)
  // ---------------------------------------------------------------------------
  // The closing reference card summarises the painting pipeline so the reader
  // can correlate the section names with concrete framework calls.  This is
  // intentionally text-heavy; no widgets here.
  // ===========================================================================
  final refSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _refBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Painting pipeline reference',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _refInk,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        _bodyText(
          '1. Layout: Slider asks SliderComponentShape.getPreferredSize for '
          'the thumb, overlay, tick mark, and value indicator shapes; this '
          'establishes the per-component bounds.',
          color: _refInk,
        ),
        _bodyText(
          '2. Track paint: SliderTrackShape.paint runs first, painting the '
          'inactive and active segments using the SliderThemeData track '
          'colours.',
          color: _refInk,
        ),
        _bodyText(
          '3. Tick paint (discrete only): SliderTickMarkShape.paint runs for '
          'each division.',
          color: _refInk,
        ),
        _bodyText(
          '4. Overlay paint: SliderComponentShape.paint runs for the overlay '
          'shape if the slider is hovered/focused/pressed.',
          color: _refInk,
        ),
        _bodyText(
          '5. Thumb paint: SliderComponentShape.paint runs for the thumb. '
          'For RangeSlider, this is RangeSliderThumbShape.paint, which '
          'receives a Thumb enum to identify start vs end.',
          color: _refInk,
        ),
        _bodyText(
          '6. Value indicator paint: when active, '
          'SliderComponentShape.paint runs for the value indicator above '
          'the thumb.',
          color: _refInk,
        ),
        const SizedBox(height: 8),
        const Text(
          'Thumb enum:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _refInk,
            fontSize: 13,
          ),
        ),
        _bodyText(
          'Thumb.start — leading thumb of a RangeSlider (logical, not '
          'visual; respects TextDirection for hit-testing).',
          color: _refInk,
        ),
        _bodyText(
          'Thumb.end — trailing thumb of a RangeSlider.',
          color: _refInk,
        ),
        const SizedBox(height: 8),
        const Text(
          'M2 vs M3 thumb defaults:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _refInk,
            fontSize: 13,
          ),
        ),
        _bodyText(
          'M2: RoundSliderThumbShape (filled circle, radius 10).  Pairs with '
          'RoundedRectSliderTrackShape and RoundSliderOverlayShape.',
          color: _refInk,
        ),
        _bodyText(
          'M3: HandleThumbShape (vertical capsule, ~4 × 44).  Pairs with '
          'GappedSliderTrackShape and a slimmer overlay.',
          color: _refInk,
        ),
        const SizedBox(height: 8),
        const Text(
          'Files in this demo subtree:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _refInk,
            fontSize: 13,
          ),
        ),
        _bodyText(
          'thumb_test.dart                          (this file)',
          color: _refInk,
        ),
        _bodyText(
          'round_slider_thumb_shape_test.dart       (single-thumb deep dive)',
          color: _refInk,
        ),
        _bodyText(
          'round_range_slider_thumb_shape_test.dart (range-thumb deep dive)',
          color: _refInk,
        ),
        _bodyText(
          'handle_thumb_shape_test.dart             (M3 thumb deep dive)',
          color: _refInk,
        ),
        _bodyText(
          'slider_component_shape_test.dart         (abstract base deep dive)',
          color: _refInk,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Top-level assembly.
  // ---------------------------------------------------------------------------
  return MaterialApp(
    title: 'Slider Thumb Family Deep Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: _heroAccent),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: _heroAccent,
        foregroundColor: Colors.white,
        title: const Text('Slider Thumb Family — Deep Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _sectionHeader('1', 'Hero — overview', _heroBg, _heroInk),
              heroSection,
              _sectionHeader(
                '2',
                'Default M3 thumb (HandleThumbShape)',
                _defaultBg,
                _defaultInk,
              ),
              defaultSection,
              _sectionHeader(
                '3',
                'RoundSliderThumbShape configurations',
                _roundBg,
                _roundInk,
              ),
              roundSection,
              _sectionHeader(
                '4',
                'Disabled vs enabled rendering',
                _disabledBg,
                _disabledInk,
              ),
              disabledSection,
              _sectionHeader(
                '5',
                'RangeSlider with RoundRangeSliderThumbShape',
                _rangeBg,
                _rangeInk,
              ),
              rangeSection,
              _sectionHeader(
                '6',
                'Custom SliderComponentShape (_DiamondThumbShape)',
                _customBg,
                _customInk,
              ),
              customDiamondSection,
              _sectionHeader(
                '7',
                'Value indicators (rectangular, paddle)',
                _indicatorBg,
                _indicatorInk,
              ),
              indicatorSection,
              _sectionHeader(
                '8',
                'Track shape combos (RoundedRect vs Rectangular)',
                _trackBg,
                _trackInk,
              ),
              trackSection,
              _sectionHeader(
                '9',
                'Tick marks (discrete divisions)',
                _ticksBg,
                _ticksInk,
              ),
              tickSection,
              _sectionHeader(
                '10',
                'Overlay halo (RoundSliderOverlayShape)',
                _overlayBg,
                _overlayInk,
              ),
              overlaySection,
              _sectionHeader(
                '11',
                'Colour theming via SliderThemeData',
                _paletteBg,
                _paletteInk,
              ),
              paletteSection,
              _sectionHeader(
                '12',
                'Range thumb collision behaviour',
                _collisionBg,
                _collisionInk,
              ),
              collisionSection,
              _sectionHeader(
                '13',
                'When to customise the thumb (decision)',
                _decisionBg,
                _decisionInk,
              ),
              decisionSection,
              _sectionHeader(
                '14',
                'Painting pipeline reference',
                _refBg,
                _refInk,
              ),
              refSection,
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}
