// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// GappedRangeSliderTrackShape — Deep Demo
// -----------------------------------------------------------------------------
// This file exercises Flutter's Material 3 `GappedRangeSliderTrackShape` using
// real, interactive `RangeSlider` widgets wired through `SliderTheme`. The
// gapped track shape draws a small visual gap on either side of each thumb,
// separating the active and inactive portions of the track. Material 3
// activates the shape by default; we install it explicitly through
// `SliderThemeData.rangeTrackShape` and then drive a sequence of self-contained
// scenarios from the same harness `build` function.
//
// The harness contract requires:
//   * a single top-level `dynamic build(BuildContext context)`,
//   * a `MaterialApp` → `Scaffold` → `SafeArea` → `SingleChildScrollView`
//     → `Column` skeleton,
//   * `StatefulBuilder` per live `RangeSlider` so each demo can mutate its own
//     `RangeValues` without leaking state,
//   * at least 800 lines of source.
//
// Each section is delimited by a banner comment to help reviewers navigate.
// =============================================================================
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Section palettes — each major demo has its own colour family so the eye can
// quickly distinguish one scenario from the next when scrolling vertically.
// -----------------------------------------------------------------------------
const Color _heroBg = Color(0xFFF3F0FF);
const Color _heroAccent = Color(0xFF5E35B1);
const Color _heroInk = Color(0xFF1A1338);

const Color _compareBg = Color(0xFFE8F5E9);
const Color _compareLegacy = Color(0xFF66BB6A);
const Color _compareGapped = Color(0xFF1B5E20);

const Color _heightBg = Color(0xFFFFF3E0);
const Color _heightActive = Color(0xFFEF6C00);
const Color _heightInactive = Color(0xFFFFCC80);

const Color _paletteBg = Color(0xFFE0F7FA);
const Color _paletteRowAink = Color(0xFF00838F);
const Color _paletteRowBink = Color(0xFFAD1457);
const Color _paletteRowCink = Color(0xFF4527A0);

const Color _divisionBg = Color(0xFFFFF8E1);
const Color _divisionInk = Color(0xFFF57F17);

const Color _disabledBg = Color(0xFFECEFF1);
const Color _disabledInk = Color(0xFF455A64);

const Color _priceBg = Color(0xFFF1F8E9);
const Color _priceInk = Color(0xFF2E7D32);

const Color _tempBg = Color(0xFFFFEBEE);
const Color _tempInk = Color(0xFFB71C1C);
const Color _tempCool = Color(0xFF1976D2);

const Color _soundBg = Color(0xFFE8EAF6);
const Color _soundInk = Color(0xFF1A237E);

const Color _refBg = Color(0xFFFAFAFA);
const Color _refInk = Color(0xFF212121);

// -----------------------------------------------------------------------------
// Helper widgets used across multiple sections.
// -----------------------------------------------------------------------------
Widget _sectionHeader(String number, String title, Color background, Color ink) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 24, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: background,
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
    child: Text(text, style: TextStyle(color: color, fontSize: 13, height: 1.4)),
  );
}

Widget _readout(String label, RangeValues values, Color ink) {
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
            style: TextStyle(color: ink, fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text(
            'start = ${values.start.toStringAsFixed(2)}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          const SizedBox(width: 12),
          Text(
            'end = ${values.end.toStringAsFixed(2)}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          const Spacer(),
          Text(
            '|Δ| = ${(values.end - values.start).abs().toStringAsFixed(2)}',
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

dynamic build(BuildContext context) {
  print('=== GappedRangeSliderTrackShape Deep Demo ===');
  print('Building 10 sections of live RangeSlider scenarios.');

  // ===========================================================================
  // SECTION 1 — HERO CARD
  // ---------------------------------------------------------------------------
  // The hero card explains what `GappedRangeSliderTrackShape` is, what the gap
  // around each thumb means, and when Material 3 enables it. We render a live
  // demo `RangeSlider` underneath the prose so the reader can see the gap in
  // action while reading the explanation.
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
                Icons.linear_scale,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'GappedRangeSliderTrackShape',
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
          'A Material 3 RangeSliderTrackShape that paints a small visual gap '
          'between the active and inactive parts of the track around each '
          'thumb. The gap helps reinforce the thumb\'s position and matches '
          'the M3 spec for selection sliders.',
          style: TextStyle(color: _heroInk, fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 12),
        const Text(
          'Material 3 enables GappedRangeSliderTrackShape automatically when '
          '`useMaterial3: true` is on the ThemeData and no rangeTrackShape is '
          'set. You can still install it explicitly via SliderThemeData.',
          style: TextStyle(color: _heroInk, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 16),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            RangeValues values = const RangeValues(0.2, 0.7);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        rangeTrackShape: const GappedRangeSliderTrackShape(), trackGap: 6.0,
                        activeTrackColor: _heroAccent,
                        inactiveTrackColor: _heroAccent.withOpacity(0.25),
                        thumbColor: _heroAccent,
                        overlayColor: _heroAccent.withOpacity(0.15),
                        trackHeight: 6,
                      ),
                      child: RangeSlider(
                        values: values,
                        min: 0,
                        max: 1,
                        onChanged: (RangeValues v) {
                          setLocal(() => values = v);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Live demo — drag either thumb to see the gap follow it.',
                        style: TextStyle(
                          color: _heroInk.withOpacity(0.7),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
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
  // SECTION 2 — SIDE-BY-SIDE COMPARISON
  // ---------------------------------------------------------------------------
  // Render the same `RangeSlider` twice; once with the legacy
  // `RoundedRectRangeSliderTrackShape` and once with the new
  // `GappedRangeSliderTrackShape`. A numeric readout below each makes the
  // current `RangeValues` explicit, so the gap is obviously a *render-only*
  // change rather than a numeric one.
  // ===========================================================================
  final compareSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _compareBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Legacy RoundedRectRangeSliderTrackShape',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _compareLegacy,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            RangeValues values = const RangeValues(0.3, 0.8);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
                        activeTrackColor: _compareLegacy,
                        inactiveTrackColor: _compareLegacy.withOpacity(0.25),
                        thumbColor: _compareLegacy,
                        overlayColor: _compareLegacy.withOpacity(0.2),
                        trackHeight: 6,
                      ),
                      child: RangeSlider(
                        values: values,
                        min: 0,
                        max: 1,
                        onChanged: (RangeValues v) {
                          setLocal(() => values = v);
                        },
                      ),
                    ),
                    _readout('LEGACY', values, _compareLegacy),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),
        const Text(
          'New GappedRangeSliderTrackShape',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _compareGapped,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            RangeValues values = const RangeValues(0.3, 0.8);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        rangeTrackShape: const GappedRangeSliderTrackShape(), trackGap: 6.0,
                        activeTrackColor: _compareGapped,
                        inactiveTrackColor: _compareGapped.withOpacity(0.25),
                        thumbColor: _compareGapped,
                        overlayColor: _compareGapped.withOpacity(0.2),
                        trackHeight: 6,
                      ),
                      child: RangeSlider(
                        values: values,
                        min: 0,
                        max: 1,
                        onChanged: (RangeValues v) {
                          setLocal(() => values = v);
                        },
                      ),
                    ),
                    _readout('GAPPED', values, _compareGapped),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Move thumbs in either slider to confirm the values are identical '
            'while the visuals differ around the thumb.',
            style: TextStyle(
              color: _compareGapped.withOpacity(0.8),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3 — TRACK-HEIGHT SWEEP
  // ---------------------------------------------------------------------------
  // Three rows, all using `GappedRangeSliderTrackShape()`. The only varying
  // dimension is `trackHeight`: 4, 8, then 16 logical pixels. The gap scales
  // with the track height, so the contrast between rows highlights how M3
  // tunes the gap to the available track size.
  // ===========================================================================
  Widget heightRow(double height, String label) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        RangeValues values = const RangeValues(0.25, 0.75);
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setLocal) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _heightActive,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      rangeTrackShape: const GappedRangeSliderTrackShape(), trackGap: 6.0,
                      activeTrackColor: _heightActive,
                      inactiveTrackColor: _heightInactive,
                      thumbColor: _heightActive,
                      overlayColor: _heightActive.withOpacity(0.18),
                      trackHeight: height,
                    ),
                    child: RangeSlider(
                      values: values,
                      min: 0,
                      max: 1,
                      onChanged: (RangeValues v) {
                        setLocal(() => values = v);
                      },
                    ),
                  ),
                  _readout('h=$label', values, _heightActive),
                ],
              ),
            );
          },
        );
      },
    );
  }

  final heightSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _heightBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Track-height sweep',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _heightActive,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'The gap scales with trackHeight. Compare the apparent gap size '
            'across the three rows.',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
        heightRow(4, '4 px'),
        heightRow(8, '8 px'),
        heightRow(16, '16 px'),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 4 — ACTIVE vs INACTIVE COLOUR PALETTE SWEEP
  // ---------------------------------------------------------------------------
  // Three rows with distinct `activeTrackColor` / `inactiveTrackColor`
  // combinations to demonstrate that the gap remains visible against the
  // surrounding track regardless of the colour palette.
  // ===========================================================================
  Widget paletteRow(
    String label,
    Color active,
    Color inactive,
    Color ink,
  ) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        RangeValues values = const RangeValues(0.2, 0.85);
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setLocal) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: active,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: inactive,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ink,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      rangeTrackShape: const GappedRangeSliderTrackShape(), trackGap: 6.0,
                      activeTrackColor: active,
                      inactiveTrackColor: inactive,
                      thumbColor: active,
                      overlayColor: active.withOpacity(0.2),
                      trackHeight: 8,
                    ),
                    child: RangeSlider(
                      values: values,
                      min: 0,
                      max: 1,
                      onChanged: (RangeValues v) {
                        setLocal(() => values = v);
                      },
                    ),
                  ),
                  _readout(label, values, ink),
                ],
              ),
            );
          },
        );
      },
    );
  }

  final paletteSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _paletteBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Active vs inactive palette sweep',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _paletteRowAink,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'The gap is rendered as a clear band, so it works against any '
            'combination of active and inactive colours.',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
        paletteRow('Teal/Cyan', const Color(0xFF00838F),
            const Color(0xFFB2EBF2), _paletteRowAink),
        paletteRow('Pink/Rose', const Color(0xFFAD1457),
            const Color(0xFFF8BBD0), _paletteRowBink),
        paletteRow('Indigo/Lilac', const Color(0xFF4527A0),
            const Color(0xFFD1C4E9), _paletteRowCink),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 5 — DISCRETE DIVISIONS
  // ---------------------------------------------------------------------------
  // Three rows show how the gap interacts with tick marks at coarser and
  // finer division counts: 4, 10, and 20 divisions. The thumb snaps to a
  // tick, but the gap remains exactly around the thumb regardless of where
  // the closest tick lies.
  // ===========================================================================
  Widget divisionRow(int divisions) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        RangeValues values = const RangeValues(0.2, 0.7);
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setLocal) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'divisions: $divisions',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _divisionInk,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      rangeTrackShape: const GappedRangeSliderTrackShape(), trackGap: 6.0,
                      activeTrackColor: _divisionInk,
                      inactiveTrackColor: _divisionInk.withOpacity(0.2),
                      thumbColor: _divisionInk,
                      overlayColor: _divisionInk.withOpacity(0.2),
                      activeTickMarkColor: Colors.white,
                      inactiveTickMarkColor: _divisionInk.withOpacity(0.6),
                      trackHeight: 8,
                      showValueIndicator: ShowValueIndicator.always,
                      valueIndicatorColor: _divisionInk,
                    ),
                    child: RangeSlider(
                      values: values,
                      min: 0,
                      max: 1,
                      divisions: divisions,
                      labels: RangeLabels(
                        values.start.toStringAsFixed(2),
                        values.end.toStringAsFixed(2),
                      ),
                      onChanged: (RangeValues v) {
                        setLocal(() => values = v);
                      },
                    ),
                  ),
                  _readout('div=$divisions', values, _divisionInk),
                ],
              ),
            );
          },
        );
      },
    );
  }

  final divisionSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _divisionBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Discrete divisions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _divisionInk,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'The gap stays anchored to the thumb position even when the '
            'thumb snaps to discrete ticks.',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
        divisionRow(4),
        divisionRow(10),
        divisionRow(20),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 6 — DISABLED STATE
  // ---------------------------------------------------------------------------
  // A `RangeSlider` with `onChanged: null` shows the disabled-track styling.
  // The gap still appears around each thumb but the colours are dimmed.
  // ===========================================================================
  final disabledSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _disabledBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Disabled state',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _disabledInk,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'When onChanged is null, the slider is disabled. The gapped track '
            'shape paints both the active and inactive segments with their '
            'disabled colours and keeps the gap in place.',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            rangeTrackShape: const GappedRangeSliderTrackShape(), trackGap: 6.0,
            activeTrackColor: _disabledInk,
            inactiveTrackColor: _disabledInk.withOpacity(0.25),
            disabledActiveTrackColor: _disabledInk.withOpacity(0.4),
            disabledInactiveTrackColor: _disabledInk.withOpacity(0.15),
            thumbColor: _disabledInk,
            disabledThumbColor: _disabledInk.withOpacity(0.4),
            overlayColor: _disabledInk.withOpacity(0.1),
            trackHeight: 8,
          ),
          child: RangeSlider(
            values: const RangeValues(0.3, 0.7),
            min: 0,
            max: 1,
            onChanged: null,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Disabled — values are fixed at start=0.30 and end=0.70.',
            style: TextStyle(
              color: _disabledInk.withOpacity(0.8),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 — RECIPE: PRICE-RANGE FILTER
  // ---------------------------------------------------------------------------
  // A realistic e-commerce price-range filter with currency labels and a
  // helper card showing the chosen min and max prices in dollars.
  // ===========================================================================
  final priceSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _priceBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recipe: price-range filter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _priceInk,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'A storefront-style price filter using GappedRangeSliderTrackShape '
            'and currency labels above the thumbs.',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            RangeValues prices = const RangeValues(20, 180);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                String currency(double v) {
                  return '\$${v.toStringAsFixed(0)}';
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _priceInk,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'min ${currency(prices.start)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _priceInk,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'max ${currency(prices.end)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          rangeTrackShape: const GappedRangeSliderTrackShape(), trackGap: 6.0,
                          activeTrackColor: _priceInk,
                          inactiveTrackColor: _priceInk.withOpacity(0.2),
                          thumbColor: _priceInk,
                          overlayColor: _priceInk.withOpacity(0.18),
                          showValueIndicator: ShowValueIndicator.always,
                          valueIndicatorColor: _priceInk,
                          trackHeight: 8,
                        ),
                        child: RangeSlider(
                          values: prices,
                          min: 0,
                          max: 500,
                          divisions: 50,
                          labels: RangeLabels(
                            currency(prices.start),
                            currency(prices.end),
                          ),
                          onChanged: (RangeValues v) {
                            setLocal(() => prices = v);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _priceInk.withOpacity(0.4)),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                color: _priceInk,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Showing items priced between '
                                  '${currency(prices.start)} and '
                                  '${currency(prices.end)}.',
                                  style: const TextStyle(
                                    color: _priceInk,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
  // SECTION 8 — RECIPE: TEMPERATURE-RANGE SCHEDULER
  // ---------------------------------------------------------------------------
  // A thermostat-style temperature range scheduler. The track active colour is
  // a hot-orange tone while the inactive is a cooler blue, evoking a hot/cold
  // dial. Degree labels live above each thumb and a summary card describes
  // the heating/cooling setpoints.
  // ===========================================================================
  final tempSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _tempBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recipe: temperature-range scheduler',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _tempInk,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'A thermostat-style range with degree labels and a colour-blended '
            'track. The gap reinforces where the cool and warm setpoints sit.',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            RangeValues temp = const RangeValues(18, 24);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                String degrees(double v) {
                  return '${v.toStringAsFixed(0)}°C';
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.ac_unit, color: _tempCool, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            degrees(temp.start),
                            style: const TextStyle(
                              color: _tempCool,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            degrees(temp.end),
                            style: const TextStyle(
                              color: _tempInk,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.local_fire_department,
                            color: _tempInk,
                            size: 18,
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          rangeTrackShape: const GappedRangeSliderTrackShape(), trackGap: 6.0,
                          activeTrackColor: _tempInk,
                          inactiveTrackColor: _tempCool.withOpacity(0.4),
                          thumbColor: _tempInk,
                          overlayColor: _tempInk.withOpacity(0.18),
                          trackHeight: 10,
                          showValueIndicator: ShowValueIndicator.always,
                          valueIndicatorColor: _tempInk,
                        ),
                        child: RangeSlider(
                          values: temp,
                          min: 10,
                          max: 32,
                          divisions: 22,
                          labels: RangeLabels(
                            degrees(temp.start),
                            degrees(temp.end),
                          ),
                          onChanged: (RangeValues v) {
                            setLocal(() => temp = v);
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _tempInk.withOpacity(0.4)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.thermostat,
                                  color: _tempInk,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Comfort range ${degrees(temp.start)} – '
                                  '${degrees(temp.end)}',
                                  style: const TextStyle(
                                    color: _tempInk,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Below ${degrees(temp.start)} the heater turns on. '
                              'Above ${degrees(temp.end)} cooling kicks in.',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
  // SECTION 9 — RECIPE: SOUND-LEVEL DUAL-THUMB METER
  // ---------------------------------------------------------------------------
  // A studio-style dual-thumb meter with custom thumb shapes (using
  // RoundSliderThumbShape with an enlarged radius). The track shape stays
  // `GappedRangeSliderTrackShape` so the gap appears next to each beefy thumb.
  // ===========================================================================
  final soundSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _soundBg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recipe: sound-level dual-thumb meter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _soundInk,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'A studio-style sound-level meter using GappedRangeSliderTrackShape '
            'plus enlarged custom thumbs.',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            RangeValues db = const RangeValues(-30, -6);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setLocal) {
                String level(double v) {
                  return '${v.toStringAsFixed(0)} dB';
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.graphic_eq,
                            color: _soundInk,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Floor ${level(db.start)}',
                            style: const TextStyle(
                              color: _soundInk,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Ceiling ${level(db.end)}',
                            style: const TextStyle(
                              color: _soundInk,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          rangeTrackShape: const GappedRangeSliderTrackShape(), trackGap: 6.0,
                          activeTrackColor: _soundInk,
                          inactiveTrackColor: _soundInk.withOpacity(0.2),
                          thumbColor: _soundInk,
                          overlayColor: _soundInk.withOpacity(0.18),
                          rangeThumbShape: const RoundRangeSliderThumbShape(
                            enabledThumbRadius: 12,
                            elevation: 2,
                          ),
                          trackHeight: 10,
                          showValueIndicator: ShowValueIndicator.always,
                          valueIndicatorColor: _soundInk,
                        ),
                        child: RangeSlider(
                          values: db,
                          min: -60,
                          max: 0,
                          divisions: 60,
                          labels: RangeLabels(level(db.start), level(db.end)),
                          onChanged: (RangeValues v) {
                            setLocal(() => db = v);
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _soundInk.withOpacity(0.4)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.equalizer,
                              color: _soundInk,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Mix is gated to the band '
                                '${level(db.start)} … ${level(db.end)}.',
                                style: const TextStyle(
                                  color: _soundInk,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
  // SECTION 10 — REFERENCE CARD
  // ---------------------------------------------------------------------------
  // A reference card listing the `GappedRangeSliderTrackShape` superclass,
  // its main methods, and how it integrates with `SliderTheme`.
  // ===========================================================================
  Widget refRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: _refInk,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: _refInk,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  final referenceSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _refBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _refInk.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Reference card',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _refInk,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'GappedRangeSliderTrackShape integration points used by SliderTheme.',
          style: TextStyle(color: Colors.black87, fontSize: 12),
        ),
        const SizedBox(height: 12),
        refRow('class', 'GappedRangeSliderTrackShape'),
        refRow('extends', 'RangeSliderTrackShape'),
        refRow('mixes in', 'BaseRangeSliderTrackShape'),
        refRow('paint(...)', 'Canvas, Offset, {required RenderBox parentBox, ...}'),
        refRow('getPreferredRect',
            'Returns the rect along which the track is drawn'),
        refRow('Slot in theme', 'SliderThemeData.rangeTrackShape'),
        refRow('M3 default', 'Auto-installed when useMaterial3: true'),
        refRow('Companion thumb', 'HandleRangeSliderThumbShape (M3 default)'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _refInk.withOpacity(0.2)),
          ),
          child: const Text(
            'Snippet:\n\n'
            'SliderTheme(\n'
            '  data: SliderThemeData(\n'
            '    rangeTrackShape: const GappedRangeSliderTrackShape(), trackGap: 6.0,\n'
            '    activeTrackColor: ...,\n'
            '    inactiveTrackColor: ...,\n'
            '    trackHeight: 8,\n'
            '  ),\n'
            '  child: RangeSlider(...),\n'
            ');\n',
            style: TextStyle(
              color: _refInk,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // ROOT WIDGET TREE
  // ---------------------------------------------------------------------------
  // Compose all ten sections into a single `Column` inside a scrollable.
  // ===========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _heroAccent),
    ),
    home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('GappedRangeSliderTrackShape Demo'),
        backgroundColor: _heroAccent,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _sectionHeader('1', 'Hero card', _heroBg, _heroAccent),
              _bodyText(
                'Introduction to GappedRangeSliderTrackShape: what the gap '
                'represents, when M3 enables it, and a live preview slider.',
              ),
              heroSection,
              _sectionHeader('2', 'Side-by-side comparison', _compareBg,
                  _compareGapped),
              _bodyText(
                'Two RangeSliders rendered with identical numeric values; only '
                'the rangeTrackShape differs.',
              ),
              compareSection,
              _sectionHeader('3', 'Track-height sweep', _heightBg, _heightActive),
              _bodyText(
                'Three rows with trackHeight set to 4, 8, and 16 logical '
                'pixels. The gap scales with the track height.',
              ),
              heightSection,
              _sectionHeader('4', 'Active vs inactive palette sweep', _paletteBg,
                  _paletteRowAink),
              _bodyText(
                'Three palette combinations to confirm the gap is visible '
                'against any active/inactive colour pair.',
              ),
              paletteSection,
              _sectionHeader('5', 'Discrete divisions', _divisionBg,
                  _divisionInk),
              _bodyText(
                'Three rows with divisions=4, 10, and 20 to show how the gap '
                'interacts with tick marks.',
              ),
              divisionSection,
              _sectionHeader('6', 'Disabled state', _disabledBg, _disabledInk),
              _bodyText(
                'A RangeSlider with onChanged: null demonstrates the disabled '
                'paint path.',
              ),
              disabledSection,
              _sectionHeader('7', 'Recipe: price-range filter', _priceBg,
                  _priceInk),
              _bodyText(
                'A storefront-style price filter with currency labels.',
              ),
              priceSection,
              _sectionHeader('8', 'Recipe: temperature-range scheduler', _tempBg,
                  _tempInk),
              _bodyText(
                'A thermostat-style scheduler with degree labels and a '
                'colour-blended track.',
              ),
              tempSection,
              _sectionHeader('9', 'Recipe: sound-level dual-thumb meter',
                  _soundBg, _soundInk),
              _bodyText(
                'A studio-style sound-level meter with custom thumb shapes.',
              ),
              soundSection,
              _sectionHeader('10', 'Reference card', _refBg, _refInk),
              _bodyText(
                'Quick reference of GappedRangeSliderTrackShape: superclass, '
                'methods, and SliderTheme integration.',
              ),
              referenceSection,
              const SizedBox(height: 32),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    '— end of GappedRangeSliderTrackShape demo —',
                    style: TextStyle(
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}
