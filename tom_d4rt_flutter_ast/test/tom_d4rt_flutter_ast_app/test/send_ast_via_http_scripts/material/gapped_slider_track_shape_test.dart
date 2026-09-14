// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== GappedSliderTrackShape Deep Demo ===');
  print('Material 3 SliderTrackShape that paints a gap around the thumb.');
  print('All sections drive real Slider widgets via SliderTheme wrappers.');

  // ===========================================================================
  // SECTION 1 - HERO CARD
  // ---------------------------------------------------------------------------
  // The hero introduces the GappedSliderTrackShape API.  GappedSliderTrackShape
  // is the Material 3 default SliderTrackShape: instead of running a single
  // continuous capsule under the thumb, the active and inactive segments stop
  // short of the thumb so the user gets a clear visual gap that separates the
  // travelled portion from the remainder.  The gap width is governed by the
  // SliderThemeData.trackGap field (M3 default ~6 logical pixels).  This card
  // explains the motivation, then renders one live Slider that uses the
  // shape directly so the gap is observable above the explanation copy.
  // ===========================================================================
  double heroValue = 0.42;

  // ===========================================================================
  // SECTION 2 - SIDE BY SIDE COMPARISON
  // ---------------------------------------------------------------------------
  // Two sliders share the same value/min/max and same SliderTheme except for
  // the trackShape: the legacy RoundedRectSliderTrackShape() versus the M3
  // GappedSliderTrackShape().  A StatefulBuilder keeps both sliders synced so
  // the user can drag either knob and visually compare the gap behaviour.
  // ===========================================================================
  double comparisonValue = 0.55;

  // ===========================================================================
  // SECTION 3 - TRACK HEIGHT SWEEP
  // ---------------------------------------------------------------------------
  // Three rows, all using GappedSliderTrackShape() but with trackHeight 4, 8,
  // and 16 logical pixels.  Demonstrates how the gap scales relative to the
  // track height; the gap stays visually proportional because Flutter computes
  // it from SliderThemeData.trackGap.
  // ===========================================================================
  double sweepValueA = 0.30;
  double sweepValueB = 0.50;
  double sweepValueC = 0.70;

  // ===========================================================================
  // SECTION 4 - COLOUR PALETTE SWEEP
  // ---------------------------------------------------------------------------
  // Three rows demonstrating distinct palettes for the active/inactive track:
  // ocean (cyan/teal), sunset (orange/amber), forest (green/lime).  Each row
  // uses GappedSliderTrackShape(); the gap is rendered in the surrounding
  // background colour so the contrast pops differently per palette.
  // ===========================================================================
  double oceanValue = 0.45;
  double sunsetValue = 0.65;
  double forestValue = 0.25;

  // ===========================================================================
  // SECTION 5 - DISCRETE DIVISIONS
  // ---------------------------------------------------------------------------
  // Three sliders configured with divisions 4, 10, 20 respectively.  The
  // GappedSliderTrackShape() interacts with the divisions tickmarks because
  // tickmarks are painted on the track regions surrounding the gap.  Labels
  // are activated to show the running value above the thumb.
  // ===========================================================================
  double divisionsA = 0.5; // 4 divisions
  double divisionsB = 0.4; // 10 divisions
  double divisionsC = 0.7; // 20 divisions

  // ===========================================================================
  // SECTION 6 - DISABLED STATE
  // ---------------------------------------------------------------------------
  // A Slider with onChanged: null demonstrating how the gap renders in the
  // disabled state.  The disabled active/inactive colours are intentionally
  // muted so the gap remains visible against a low-contrast track.
  // ===========================================================================
  const double disabledValue = 0.4;

  // ===========================================================================
  // SECTION 7 - CUSTOM THUMB SHAPE INTEGRATION
  // ---------------------------------------------------------------------------
  // GappedSliderTrackShape() paired with two distinct thumb shapes:
  // RoundSliderThumbShape(enabledThumbRadius: 12) and HandleThumbShape(),
  // M3's pill thumb.  The gap is anchored to the thumb's centre, so it
  // follows the thumb regardless of which shape is in use.
  // ===========================================================================
  double thumbRoundValue = 0.55;
  double thumbHandleValue = 0.55;

  // ===========================================================================
  // SECTION 8 - RECIPE: BRIGHTNESS CARD
  // ---------------------------------------------------------------------------
  // A practical mini-card demonstrating the gapped track being used as a
  // brightness control: a sun icon flanks a Slider whose track shows a gap
  // that visually separates "current brightness" from "remaining headroom".
  // Active colour blends amber so the slider reads as warm sunlight.
  // ===========================================================================
  double brightnessValue = 0.65;

  // ===========================================================================
  // SECTION 9 - RECIPE: MEDIA PROGRESS
  // ---------------------------------------------------------------------------
  // Two sliders styled as a media-progress scrubber: small variant (4px track)
  // and large variant (10px track).  Both use GappedSliderTrackShape() with a
  // discrete time-display readout on either side, mimicking the layout of a
  // typical media-player progress bar.
  // ===========================================================================
  double mediaSmall = 75.0; // seconds within a 240s track
  double mediaLarge = 132.0; // seconds within a 240s track

  // ===========================================================================
  // SECTION 10 - RECIPE: PRIORITY LEVELS
  // ---------------------------------------------------------------------------
  // A discrete slider with 5 categorical priority levels.  Each tick has a
  // text label rendered underneath, and the gapped track makes it obvious
  // which category is currently selected because the gap aligns with the
  // currently selected category's thumb position.
  // ===========================================================================
  double priorityValue = 2.0;
  const priorityLabels = <String>['Lowest', 'Low', 'Medium', 'High', 'Critical'];

  // ===========================================================================
  // SECTION 11 - REFERENCE CARD
  // ---------------------------------------------------------------------------
  // A static reference card that summarises:
  //   - GappedSliderTrackShape extends SliderTrackShape (the abstract base
  //     responsible for painting the slider track)
  //   - paint() signature: paint(context, offset, parentBox, sliderTheme,
  //     animation, thumbCenter, ...)
  //   - SliderThemeData wiring fields used by the shape: trackHeight,
  //     trackGap, activeTrackColor, inactiveTrackColor.
  // No live slider here; pure documentation surface.
  // ===========================================================================

  print('Live sliders: hero, comparison(2), sweep(3), palette(3), divisions(3),');
  print('              disabled(1), thumbs(2), brightness, media(2), priority');
  print('Total live Slider widgets in demo: 19 (plus 1 disabled).');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF3B5BDB)),
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================================
              // SECTION 1 - HERO CARD
              // =====================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B5BDB), Color(0xFF6C5CE7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.tune, color: Colors.white, size: 28),
                        SizedBox(width: 10),
                        Text(
                          'GappedSliderTrackShape',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'A Material 3 SliderTrackShape that draws a small gap '
                      'between the active and inactive track segments around '
                      'the slider thumb.  The gap visually separates the '
                      'travelled portion from the remainder of the range.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Why a gap? In M3 the slider thumb is treated as a '
                      'distinct interactive element, not a node embedded in '
                      'the track. The gap gives the thumb breathing room and '
                      'reinforces the affordance that the thumb is draggable.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 16),
                    StatefulBuilder(
                      builder: (BuildContext _, StateSetter setHero) {
                        return SliderTheme(
                          data: SliderThemeData(
                            trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                            trackHeight: 8,
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Colors.white24,
                            thumbColor: Colors.white,
                            overlayColor: Colors.white24,
                          ),
                          child: Slider(
                            value: heroValue,
                            min: 0,
                            max: 1,
                            onChanged: (double v) {
                              setHero(() {
                                heroValue = v;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('0.00',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              )),
                          Text('1.00',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // =====================================================================
              // SECTION 2 - SIDE BY SIDE COMPARISON
              // =====================================================================
              const Text(
                'Section 2 - Legacy vs M3 track shape',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Same value, two track shapes.  Drag either to see the gap.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (BuildContext _, StateSetter setCmp) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE0E3EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.history, size: 18, color: Colors.black54),
                                const SizedBox(width: 6),
                                const Text(
                                  'Legacy: RoundedRectSliderTrackShape()',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                Text(
                                  comparisonValue.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            SliderTheme(
                              data: SliderThemeData(
                                trackShape: const RoundedRectSliderTrackShape(),
                                trackHeight: 8,
                                activeTrackColor: const Color(0xFF3B5BDB),
                                inactiveTrackColor: const Color(0xFFC4CCE6),
                              ),
                              child: Slider(
                                value: comparisonValue,
                                min: 0,
                                max: 1,
                                onChanged: (double v) {
                                  setCmp(() {
                                    comparisonValue = v;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF3B5BDB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.new_releases, size: 18, color: Color(0xFF3B5BDB)),
                                const SizedBox(width: 6),
                                const Text(
                                  'M3: GappedSliderTrackShape()',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                Text(
                                  comparisonValue.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            SliderTheme(
                              data: SliderThemeData(
                                trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                                trackHeight: 8,
                                activeTrackColor: const Color(0xFF3B5BDB),
                                inactiveTrackColor: const Color(0xFFC4CCE6),
                              ),
                              child: Slider(
                                value: comparisonValue,
                                min: 0,
                                max: 1,
                                onChanged: (double v) {
                                  setCmp(() {
                                    comparisonValue = v;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),

              // =====================================================================
              // SECTION 3 - TRACK HEIGHT SWEEP
              // =====================================================================
              const Text(
                'Section 3 - Track height sweep (4 / 8 / 16)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'GappedSliderTrackShape() at three trackHeight settings.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (BuildContext _, StateSetter setSweep) {
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E3EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 90,
                              child: Text('trackHeight: 4',
                                  style: TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                                  trackHeight: 4,
                                  activeTrackColor: const Color(0xFF1F8E5A),
                                  inactiveTrackColor: const Color(0xFFB7E4C7),
                                  thumbColor: const Color(0xFF1F8E5A),
                                ),
                                child: Slider(
                                  value: sweepValueA,
                                  onChanged: (double v) {
                                    setSweep(() {
                                      sweepValueA = v;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(sweepValueA.toStringAsFixed(2),
                                  style: const TextStyle(fontFamily: 'monospace')),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const SizedBox(
                              width: 90,
                              child: Text('trackHeight: 8',
                                  style: TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                                  trackHeight: 8,
                                  activeTrackColor: const Color(0xFFB37FEB),
                                  inactiveTrackColor: const Color(0xFFE2D2F5),
                                  thumbColor: const Color(0xFF7C3AED),
                                ),
                                child: Slider(
                                  value: sweepValueB,
                                  onChanged: (double v) {
                                    setSweep(() {
                                      sweepValueB = v;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(sweepValueB.toStringAsFixed(2),
                                  style: const TextStyle(fontFamily: 'monospace')),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const SizedBox(
                              width: 90,
                              child: Text('trackHeight: 16',
                                  style: TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                                  trackHeight: 16,
                                  activeTrackColor: const Color(0xFFD9480F),
                                  inactiveTrackColor: const Color(0xFFFFD8A8),
                                  thumbColor: const Color(0xFFE8590C),
                                ),
                                child: Slider(
                                  value: sweepValueC,
                                  onChanged: (double v) {
                                    setSweep(() {
                                      sweepValueC = v;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(sweepValueC.toStringAsFixed(2),
                                  style: const TextStyle(fontFamily: 'monospace')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // =====================================================================
              // SECTION 4 - COLOUR PALETTE SWEEP
              // =====================================================================
              const Text(
                'Section 4 - Colour palette sweep',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Three palettes share GappedSliderTrackShape() with distinct '
                'active/inactive track colours.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (BuildContext _, StateSetter setPalette) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3FAFC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.water_drop, color: Color(0xFF0B7285)),
                            const SizedBox(width: 8),
                            const SizedBox(
                              width: 70,
                              child: Text('Ocean',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0B7285))),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                                  trackHeight: 8,
                                  activeTrackColor: const Color(0xFF0B7285),
                                  inactiveTrackColor: const Color(0xFF99E9F2),
                                  thumbColor: const Color(0xFF0B7285),
                                  overlayColor: const Color(0x550B7285),
                                ),
                                child: Slider(
                                  value: oceanValue,
                                  onChanged: (double v) {
                                    setPalette(() {
                                      oceanValue = v;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 56,
                              child: Text(
                                '${(oceanValue * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  color: Color(0xFF0B7285),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4E6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.wb_sunny, color: Color(0xFFD9480F)),
                            const SizedBox(width: 8),
                            const SizedBox(
                              width: 70,
                              child: Text('Sunset',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFD9480F))),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                                  trackHeight: 8,
                                  activeTrackColor: const Color(0xFFE8590C),
                                  inactiveTrackColor: const Color(0xFFFFD8A8),
                                  thumbColor: const Color(0xFFD9480F),
                                  overlayColor: const Color(0x55E8590C),
                                ),
                                child: Slider(
                                  value: sunsetValue,
                                  onChanged: (double v) {
                                    setPalette(() {
                                      sunsetValue = v;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 56,
                              child: Text(
                                '${(sunsetValue * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  color: Color(0xFFD9480F),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBFBEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.eco, color: Color(0xFF2B8A3E)),
                            const SizedBox(width: 8),
                            const SizedBox(
                              width: 70,
                              child: Text('Forest',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2B8A3E))),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                                  trackHeight: 8,
                                  activeTrackColor: const Color(0xFF2B8A3E),
                                  inactiveTrackColor: const Color(0xFFB2F2BB),
                                  thumbColor: const Color(0xFF2B8A3E),
                                  overlayColor: const Color(0x552B8A3E),
                                ),
                                child: Slider(
                                  value: forestValue,
                                  onChanged: (double v) {
                                    setPalette(() {
                                      forestValue = v;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 56,
                              child: Text(
                                '${(forestValue * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  color: Color(0xFF2B8A3E),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),

              // =====================================================================
              // SECTION 5 - DISCRETE DIVISIONS
              // =====================================================================
              const Text(
                'Section 5 - Discrete divisions (4 / 10 / 20)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Gap interacts with division tickmarks and value labels.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (BuildContext _, StateSetter setDiv) {
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E3EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'divisions: 4',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                            trackHeight: 8,
                            activeTrackColor: const Color(0xFFE03131),
                            inactiveTrackColor: const Color(0xFFFFC9C9),
                            thumbColor: const Color(0xFFC92A2A),
                            valueIndicatorColor: const Color(0xFFC92A2A),
                            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
                            activeTickMarkColor: Colors.white,
                            inactiveTickMarkColor: const Color(0xFFE03131),
                          ),
                          child: Slider(
                            value: divisionsA,
                            min: 0,
                            max: 1,
                            divisions: 4,
                            label: divisionsA.toStringAsFixed(2),
                            onChanged: (double v) {
                              setDiv(() {
                                divisionsA = v;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'divisions: 10',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                            trackHeight: 8,
                            activeTrackColor: const Color(0xFF1864AB),
                            inactiveTrackColor: const Color(0xFFA5D8FF),
                            thumbColor: const Color(0xFF1864AB),
                            valueIndicatorColor: const Color(0xFF1864AB),
                            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
                            activeTickMarkColor: Colors.white,
                            inactiveTickMarkColor: const Color(0xFF1864AB),
                          ),
                          child: Slider(
                            value: divisionsB,
                            min: 0,
                            max: 1,
                            divisions: 10,
                            label: divisionsB.toStringAsFixed(2),
                            onChanged: (double v) {
                              setDiv(() {
                                divisionsB = v;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'divisions: 20',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                            trackHeight: 8,
                            activeTrackColor: const Color(0xFF6741D9),
                            inactiveTrackColor: const Color(0xFFD0BFFF),
                            thumbColor: const Color(0xFF6741D9),
                            valueIndicatorColor: const Color(0xFF6741D9),
                            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
                            activeTickMarkColor: Colors.white,
                            inactiveTickMarkColor: const Color(0xFF6741D9),
                          ),
                          child: Slider(
                            value: divisionsC,
                            min: 0,
                            max: 1,
                            divisions: 20,
                            label: divisionsC.toStringAsFixed(2),
                            onChanged: (double v) {
                              setDiv(() {
                                divisionsC = v;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // =====================================================================
              // SECTION 6 - DISABLED STATE
              // =====================================================================
              const Text(
                'Section 6 - Disabled state',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Gap remains visible against the muted disabled track.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFDEE2E6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.block, color: Color(0xFF868E96), size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Slider(onChanged: null)',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF495057),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SliderTheme(
                      data: SliderThemeData(
                        trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                        trackHeight: 8,
                        disabledActiveTrackColor: const Color(0xFFADB5BD),
                        disabledInactiveTrackColor: const Color(0xFFDEE2E6),
                        disabledThumbColor: const Color(0xFF868E96),
                      ),
                      child: const Slider(
                        value: disabledValue,
                        min: 0,
                        max: 1,
                        onChanged: null,
                      ),
                    ),
                    const Text(
                      'Disabled sliders use disabledActive/Inactive track colours, '
                      'and the gap is rendered the same way as the enabled state.',
                      style: TextStyle(color: Color(0xFF495057), fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // =====================================================================
              // SECTION 7 - CUSTOM THUMB SHAPE INTEGRATION
              // =====================================================================
              const Text(
                'Section 7 - Custom thumb shape integration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Gap follows the thumb regardless of thumb shape.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (BuildContext _, StateSetter setThumb) {
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E3EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'RoundSliderThumbShape(enabledThumbRadius: 12)',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        SliderTheme(
                          data: SliderThemeData(
                            trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 12,
                            ),
                            trackHeight: 8,
                            activeTrackColor: const Color(0xFF0CA678),
                            inactiveTrackColor: const Color(0xFF96F2D7),
                            thumbColor: const Color(0xFF099268),
                            overlayColor: const Color(0x550CA678),
                          ),
                          child: Slider(
                            value: thumbRoundValue,
                            onChanged: (double v) {
                              setThumb(() {
                                thumbRoundValue = v;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 4),
                          child: Text(
                            'value=${thumbRoundValue.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Color(0xFF099268),
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'HandleThumbShape() (M3 pill thumb)',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        SliderTheme(
                          data: SliderThemeData(
                            trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                            thumbShape: const HandleThumbShape(),
                            trackHeight: 16,
                            activeTrackColor: const Color(0xFFAE3EC9),
                            inactiveTrackColor: const Color(0xFFE599F7),
                            thumbColor: const Color(0xFFAE3EC9),
                            overlayColor: const Color(0x55AE3EC9),
                          ),
                          child: Slider(
                            value: thumbHandleValue,
                            onChanged: (double v) {
                              setThumb(() {
                                thumbHandleValue = v;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 4),
                          child: Text(
                            'value=${thumbHandleValue.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Color(0xFFAE3EC9),
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // =====================================================================
              // SECTION 8 - RECIPE: BRIGHTNESS
              // =====================================================================
              const Text(
                'Section 8 - Recipe: brightness control',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Practical mini card combining icon row + gradient track.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (BuildContext _, StateSetter setBright) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF212529), Color(0xFFFFC078)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.brightness_low, color: Colors.white70, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Brightness',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.brightness_high, color: Colors.white, size: 22),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SliderTheme(
                          data: SliderThemeData(
                            trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                            trackHeight: 10,
                            activeTrackColor: const Color(0xFFFFE8CC),
                            inactiveTrackColor: const Color(0x55FFFFFF),
                            thumbColor: Colors.white,
                            overlayColor: const Color(0x33FFFFFF),
                          ),
                          child: Slider(
                            value: brightnessValue,
                            onChanged: (double v) {
                              setBright(() {
                                brightnessValue = v;
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('0%',
                                style: TextStyle(color: Colors.white70, fontSize: 12)),
                            Text(
                              '${(brightnessValue * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text('100%',
                                style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // =====================================================================
              // SECTION 9 - RECIPE: MEDIA PROGRESS
              // =====================================================================
              const Text(
                'Section 9 - Recipe: media progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Small (4px) and large (10px) variants of a media-progress bar.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (BuildContext _, StateSetter setMedia) {
                  String fmt(double sec) {
                    final int s = sec.round();
                    final int m = s ~/ 60;
                    final int r = s % 60;
                    return '${m.toString().padLeft(1, '0')}:${r.toString().padLeft(2, '0')}';
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1B1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Small variant',
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SliderTheme(
                              data: SliderThemeData(
                                trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                                trackHeight: 4,
                                activeTrackColor: const Color(0xFF40C057),
                                inactiveTrackColor: const Color(0xFF495057),
                                thumbColor: const Color(0xFF40C057),
                                overlayColor: const Color(0x5540C057),
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                              ),
                              child: Slider(
                                value: mediaSmall,
                                min: 0,
                                max: 240,
                                onChanged: (double v) {
                                  setMedia(() {
                                    mediaSmall = v;
                                  });
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(fmt(mediaSmall),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'monospace',
                                    )),
                                Text(fmt(240),
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontFamily: 'monospace',
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1B1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Large variant',
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SliderTheme(
                              data: SliderThemeData(
                                trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                                trackHeight: 10,
                                activeTrackColor: const Color(0xFFFD7E14),
                                inactiveTrackColor: const Color(0xFF495057),
                                thumbColor: const Color(0xFFFD7E14),
                                overlayColor: const Color(0x55FD7E14),
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 11,
                                ),
                              ),
                              child: Slider(
                                value: mediaLarge,
                                min: 0,
                                max: 240,
                                onChanged: (double v) {
                                  setMedia(() {
                                    mediaLarge = v;
                                  });
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(fmt(mediaLarge),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'monospace',
                                    )),
                                Text(fmt(240),
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontFamily: 'monospace',
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),

              // =====================================================================
              // SECTION 10 - RECIPE: PRIORITY LEVEL
              // =====================================================================
              const Text(
                'Section 10 - Recipe: priority levels',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Categorical labels under each tick mark.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (BuildContext _, StateSetter setPrio) {
                  final int idx = priorityValue.round().clamp(0, priorityLabels.length - 1);
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E3EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.flag, color: Color(0xFFD6336C)),
                            const SizedBox(width: 8),
                            const Text(
                              'Priority',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFD6336C),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              priorityLabels[idx],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFD6336C),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        SliderTheme(
                          data: SliderThemeData(
                            trackShape: const GappedSliderTrackShape(), trackGap: 6.0, thumbSize: const WidgetStatePropertyAll<Size?>(Size(4.0, 44.0)),
                            trackHeight: 8,
                            activeTrackColor: const Color(0xFFD6336C),
                            inactiveTrackColor: const Color(0xFFFFDEEB),
                            thumbColor: const Color(0xFFD6336C),
                            overlayColor: const Color(0x55D6336C),
                            valueIndicatorColor: const Color(0xFFD6336C),
                            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
                            activeTickMarkColor: Colors.white,
                            inactiveTickMarkColor: const Color(0xFFD6336C),
                          ),
                          child: Slider(
                            value: priorityValue,
                            min: 0,
                            max: (priorityLabels.length - 1).toDouble(),
                            divisions: priorityLabels.length - 1,
                            label: priorityLabels[idx],
                            onChanged: (double v) {
                              setPrio(() {
                                priorityValue = v;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: priorityLabels
                                .map(
                                  (String label) => Text(
                                    label,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF495057),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // =====================================================================
              // SECTION 11 - REFERENCE CARD
              // =====================================================================
              const Text(
                'Section 11 - Reference card',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Static documentation surface for the GappedSliderTrackShape API.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF212529),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Class: GappedSliderTrackShape',
                      style: TextStyle(
                        color: Color(0xFFFFD43B),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'extends SliderTrackShape with BaseSliderTrackShape',
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'paint() signature',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'void paint(\n'
                      '  PaintingContext context,\n'
                      '  Offset offset,\n'
                      '  {required RenderBox parentBox,\n'
                      '   required SliderThemeData sliderTheme,\n'
                      '   required Animation<double> enableAnimation,\n'
                      '   required TextDirection textDirection,\n'
                      '   required Offset thumbCenter,\n'
                      '   Offset? secondaryOffset,\n'
                      '   bool isEnabled = false,\n'
                      '   bool isDiscrete = false}\n'
                      ')',
                      style: TextStyle(
                        color: Color(0xFF8CE99A),
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'SliderThemeData wiring',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '- trackShape: const GappedSliderTrackShape()\n'
                      '- trackHeight: 4 / 8 / 16\n'
                      '- activeTrackColor / inactiveTrackColor\n'
                      '- disabledActiveTrackColor / disabledInactiveTrackColor\n'
                      '- thumbColor / thumbShape\n'
                      '- valueIndicatorColor / valueIndicatorTextStyle',
                      style: TextStyle(
                        color: Color(0xFFA5D8FF),
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Notes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '* GappedSliderTrackShape is the M3 default; legacy '
                      'apps may still use RoundedRectSliderTrackShape.\n'
                      '* The gap centres on thumbCenter and is symmetric on '
                      'both active and inactive sides.\n'
                      '* The shape co-operates with both RoundSliderThumbShape '
                      'and HandleThumbShape.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Center(
                child: Text(
                  'End of GappedSliderTrackShape Deep Demo',
                  style: TextStyle(
                    color: Colors.black45,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
