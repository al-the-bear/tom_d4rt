// ignore_for_file: avoid_print
// D4rt deep demo: SliderInteraction — controls the gesture model for
// Slider (tapAndSlide, tapOnly, slideOnly, slideThumb).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliderInteraction deep demo executing');
  print('=' * 60);

  for (final v in SliderInteraction.values) {
    print('  ${v.name} (index ${v.index})');
  }
  print('Total values: ${SliderInteraction.values.length}');
  print('=' * 60);

  // ── colour palette ──────────────────────────────────────────
  const siPrimary = Color(0xFF7CB342);   // pistachio green
  const siAccent = Color(0xFFC0D860);    // lime
  const siLight = Color(0xFFF1F8E9);     // pale lime
  const siDark = Color(0xFF33691E);      // deep green
  const siSurface = Color(0xFFFAFDF5);
  const siOnSurface = Color(0xFF263238);
  const siMuted = Color(0xFF607D8B);

  // ── data ────────────────────────────────────────────────────
  final List<Map<String, String>> siModes = [
    {
      'value': 'tapAndSlide',
      'title': 'Tap & Slide',
      'desc': 'User can tap anywhere on the track to jump to that '
          'value, then slide to refine. This is the default and most '
          'permissive interaction mode.',
      'tap': 'Yes — jump to position',
      'slide': 'Yes — from anywhere',
      'thumb': 'Not required',
      'ux': 'General purpose, web forms',
      'icon': '⤢',
    },
    {
      'value': 'tapOnly',
      'title': 'Tap Only',
      'desc': 'User can only tap to set a value. Dragging/sliding '
          'has no effect. Best for discrete step selection where '
          'precision is unnecessary.',
      'tap': 'Yes — snap to position',
      'slide': 'No',
      'thumb': 'Not required',
      'ux': 'Rating, step selectors',
      'icon': '⊙',
    },
    {
      'value': 'slideOnly',
      'title': 'Slide Only',
      'desc': 'User can only slide to adjust the value. Tapping the '
          'track does nothing. Prevents accidental value jumps.',
      'tap': 'No',
      'slide': 'Yes — from anywhere on track',
      'thumb': 'Not required',
      'ux': 'Audio/video scrubbing',
      'icon': '⟷',
    },
    {
      'value': 'slideThumb',
      'title': 'Slide Thumb',
      'desc': 'The most restrictive mode: the user must start the '
          'gesture on the thumb itself, then drag. No tapping, no '
          'track-area sliding.',
      'tap': 'No',
      'slide': 'Only from thumb',
      'thumb': 'Required — must start on thumb',
      'ux': 'Precision knobs, sensitive controls',
      'icon': '◉',
    },
  ];

  // ── helpers ─────────────────────────────────────────────────
  Widget siSection(String title, {Widget? child, List<Widget>? children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: siAccent.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: siPrimary.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [siPrimary, siDark],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child:
                child ?? Column(crossAxisAlignment: CrossAxisAlignment.start, children: children ?? []),
          ),
        ],
      ),
    );
  }

  Widget siLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: siOnSurface)),
    );
  }

  Widget siBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: siMuted, height: 1.5)),
    );
  }

  Widget siChip(String label, {Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? siLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: siAccent.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget siDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: siAccent.withValues(alpha: 0.2), height: 1),
    );
  }

  // Live slider per mode
  Widget siSliderCard({
    required String label,
    required SliderInteraction mode,
    required double value,
    int? divisions,
    String? note,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: siLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: siAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: siPrimary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderThemeData(
              allowedInteraction: mode,
              activeTrackColor: siPrimary,
              inactiveTrackColor: siAccent.withValues(alpha: 0.3),
              thumbColor: siDark,
              overlayColor: siPrimary.withValues(alpha: 0.15),
              valueIndicatorColor: siDark,
              valueIndicatorTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              showValueIndicator: ShowValueIndicator.onDrag,
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 100,
              divisions: divisions,
              label: value.toStringAsFixed(0),
              onChanged: (_) {},
            ),
          ),
          if (note != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(note,
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: siMuted)),
            ),
        ],
      ),
    );
  }

  // Interaction zone visualizer
  Widget siZoneDiagram({
    required String mode,
    required bool trackTap,
    required bool trackSlide,
    required bool thumbSlide,
  }) {
    final Color tapColor =
        trackTap ? siPrimary.withValues(alpha: 0.25) : Colors.red.withValues(alpha: 0.08);
    final Color slideColor =
        trackSlide ? siPrimary.withValues(alpha: 0.35) : Colors.red.withValues(alpha: 0.08);
    final Color thumbColor =
        thumbSlide ? siDark : siMuted.withValues(alpha: 0.4);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: siAccent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(mode,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          // Track diagram
          Stack(
            children: [
              // Full track background
              Container(
                height: 36,
                decoration: BoxDecoration(
                  color: tapColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Text(
                  trackTap ? 'TAP ZONE' : 'NO TAP',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: trackTap ? siDark : Colors.red.shade300,
                  ),
                ),
              ),
              // Slide overlay on track
              Positioned(
                left: 0,
                right: 60,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: slideColor,
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(4)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    trackSlide ? 'SLIDE ZONE' : '',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: siDark,
                    ),
                  ),
                ),
              ),
              // Thumb
              Positioned(
                right: 50,
                top: 4,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: thumbColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    thumbSlide ? '◉' : '○',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (trackTap)
                siChip('Tap ✓', bg: siPrimary.withValues(alpha: 0.15)),
              if (!trackTap)
                siChip('Tap ✗', bg: Colors.red.withValues(alpha: 0.1)),
              if (trackSlide)
                siChip('Slide ✓', bg: siPrimary.withValues(alpha: 0.15)),
              if (!trackSlide)
                siChip('Slide ✗', bg: Colors.red.withValues(alpha: 0.1)),
              siChip(
                thumbSlide ? 'Thumb ✓' : 'Thumb ✗',
                bg: thumbSlide
                    ? siPrimary.withValues(alpha: 0.15)
                    : Colors.red.withValues(alpha: 0.1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // BUILD
  // ══════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    child: Container(
      color: siSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Title Banner ──────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 42, 24, 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [siDark, siPrimary],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('SliderInteraction',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  'Defines which gestures the Slider responds to: '
                  'tapping, sliding, or only dragging the thumb.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    siChip('enum', bg: Colors.white.withValues(alpha: 0.2)),
                    siChip('SliderThemeData',
                        bg: Colors.white.withValues(alpha: 0.2)),
                    siChip('Gestures',
                        bg: Colors.white.withValues(alpha: 0.2)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 2. Enum Overview ─────────────────────────────────
          siSection('Enum Overview',
            children: [
              siBody(
                'SliderInteraction is an enum that restricts which '
                'touch/pointer gestures the Slider widget accepts. '
                'It is set through '
                'SliderThemeData.allowedInteraction and applies to '
                'both Slider and RangeSlider.'),
              siBody(
                'The four modes form a spectrum from most permissive '
                '(tapAndSlide) to most restrictive (slideThumb).'),
              Wrap(
                children: [
                  for (final v in SliderInteraction.values)
                    siChip(v.name),
                ],
              ),
            ],
          ),

          // ── 3. Individual Mode Cards ─────────────────────────
          for (final m in siModes)
            siSection('${m['icon']}  ${m['title']}',
              children: [
                siLabel('Mode'),
                siChip(m['value']!),
                const SizedBox(height: 8),
                siLabel('Description'),
                siBody(m['desc']!),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          siLabel('Tap'),
                          siBody(m['tap']!),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          siLabel('Slide'),
                          siBody(m['slide']!),
                        ],
                      ),
                    ),
                  ],
                ),
                siLabel('Thumb Required'),
                siBody(m['thumb']!),
                siLabel('Best For'),
                siBody(m['ux']!),
              ],
            ),

          // ── 4. Live Slider Demos ─────────────────────────────
          siSection('Live Slider Demos — Continuous',
            children: [
              siBody(
                'Each slider uses a different SliderInteraction mode. '
                'Try interacting to feel the difference:'),
              siSliderCard(
                label: 'tapAndSlide — default, most permissive',
                mode: SliderInteraction.tapAndSlide,
                value: 40,
                note: 'Tap the track or slide from anywhere.',
              ),
              siSliderCard(
                label: 'tapOnly — tap to set, no slide',
                mode: SliderInteraction.tapOnly,
                value: 60,
                note: 'Tapping jumps to position. Drag has no effect.',
              ),
              siSliderCard(
                label: 'slideOnly — slide to adjust, no tap jump',
                mode: SliderInteraction.slideOnly,
                value: 30,
                note: 'Must slide to change. Tapping the track ignored.',
              ),
              siSliderCard(
                label: 'slideThumb — must grab the thumb',
                mode: SliderInteraction.slideThumb,
                value: 75,
                note: 'Must start the gesture exactly on the thumb circle.',
              ),
            ],
          ),

          // ── 5. Live Slider Demos — Discrete ──────────────────
          siSection('Live Slider Demos — Discrete (5 steps)',
            children: [
              siBody(
                'Same modes on a discrete slider with 5 divisions. '
                'tapOnly is particularly natural here — each tap '
                'snaps to the nearest step:'),
              siSliderCard(
                label: 'tapAndSlide — 5 divisions',
                mode: SliderInteraction.tapAndSlide,
                value: 40,
                divisions: 5,
              ),
              siSliderCard(
                label: 'tapOnly — 5 divisions',
                mode: SliderInteraction.tapOnly,
                value: 60,
                divisions: 5,
                note: 'Tap to snap. Ideal for star-rating UIs.',
              ),
              siSliderCard(
                label: 'slideOnly — 5 divisions',
                mode: SliderInteraction.slideOnly,
                value: 20,
                divisions: 5,
              ),
              siSliderCard(
                label: 'slideThumb — 5 divisions',
                mode: SliderInteraction.slideThumb,
                value: 80,
                divisions: 5,
              ),
            ],
          ),

          // ── 6. Interaction Zone Diagrams ─────────────────────
          siSection('Interaction Zone Visualiser',
            children: [
              siBody(
                'Each diagram shows the track and thumb with '
                'colour-coded zones indicating which areas respond '
                'to gestures. Green = active, red = inactive.'),
              siZoneDiagram(
                mode: 'tapAndSlide',
                trackTap: true,
                trackSlide: true,
                thumbSlide: true,
              ),
              siZoneDiagram(
                mode: 'tapOnly',
                trackTap: true,
                trackSlide: false,
                thumbSlide: false,
              ),
              siZoneDiagram(
                mode: 'slideOnly',
                trackTap: false,
                trackSlide: true,
                thumbSlide: true,
              ),
              siZoneDiagram(
                mode: 'slideThumb',
                trackTap: false,
                trackSlide: false,
                thumbSlide: true,
              ),
            ],
          ),

          // ── 7. Gesture Comparison Table ──────────────────────
          siSection('Gesture Comparison Table',
            child: Table(
              border: TableBorder.all(
                  color: siAccent.withValues(alpha: 0.3), width: 1),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration:
                      BoxDecoration(color: siPrimary.withValues(alpha: 0.12)),
                  children: [
                    for (final h in ['Mode', 'Track Tap', 'Track Slide', 'Thumb Drag'])
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(h,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 11)),
                      ),
                  ],
                ),
                for (final row in [
                  ['tapAndSlide', '✓', '✓', '✓'],
                  ['tapOnly', '✓', '✗', '✗'],
                  ['slideOnly', '✗', '✓', '✓'],
                  ['slideThumb', '✗', '✗', '✓'],
                ])
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(row[0],
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: siDark)),
                      ),
                      for (int i = 1; i < 4; i++)
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(row[i],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: row[i] == '✓'
                                      ? Colors.green.shade700
                                      : Colors.red.shade600)),
                        ),
                    ],
                  ),
              ],
            ),
          ),

          // ── 8. UX Scenarios ──────────────────────────────────
          siSection('UX Scenarios',
            children: [
              for (final scenario in [
                {
                  'title': 'Media Player Scrubber',
                  'mode': 'slideOnly',
                  'why': 'Prevents accidental jumps when the user '
                      'taps near the progress bar. Only deliberate '
                      'sliding moves the playhead.',
                  'icon': Icons.play_circle_outline,
                },
                {
                  'title': 'Star Rating Selector',
                  'mode': 'tapOnly',
                  'why': 'Users tap to select 1–5 stars. Sliding is '
                      'unnatural for ratings — tap-to-snap is the '
                      'expected behaviour.',
                  'icon': Icons.star_outline,
                },
                {
                  'title': 'Colour Mixer Knob',
                  'mode': 'slideThumb',
                  'why': 'A sensitive colour-mixing knob that should '
                      'only move when the user grabs it deliberately. '
                      'Prevents accidental resets.',
                  'icon': Icons.palette_outlined,
                },
                {
                  'title': 'Form Range Input',
                  'mode': 'tapAndSlide',
                  'why': 'General-purpose range input in a form. '
                      'Maximum flexibility — user can tap to jump '
                      'or slide to refine.',
                  'icon': Icons.tune,
                },
              ]) ...[
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: siLight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: siAccent.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(scenario['icon'] as IconData,
                          color: siDark, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scenario['title'] as String,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 2),
                            siChip('${scenario['mode']}'),
                            const SizedBox(height: 6),
                            Text(scenario['why'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: siMuted,
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          // ── 9. SliderThemeData Integration ───────────────────
          siSection('SliderThemeData Integration',
            children: [
              siBody(
                'SliderInteraction is set via the allowedInteraction '
                'property of SliderThemeData. It complements other '
                'theme properties:'),
              for (final prop in [
                ['allowedInteraction', 'Which gestures the slider accepts'],
                ['showValueIndicator', 'When to show the value bubble'],
                ['trackHeight', 'Height of the slider track'],
                ['thumbShape', 'Shape/size of the draggable thumb'],
                ['overlayShape', 'Feedback overlay around the thumb'],
                ['tickMarkShape', 'Shape of discrete tick marks'],
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 5, right: 8),
                        decoration: BoxDecoration(
                          color: siPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: Text(prop[0],
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace')),
                      ),
                      Expanded(
                        child: Text(prop[1],
                            style: TextStyle(fontSize: 12, color: siMuted)),
                      ),
                    ],
                  ),
                ),
              siDivider(),
              siBody(
                'Tip: Combine slideThumb with a larger thumbShape for '
                'easier grab targets. The default 10dp radius can be '
                'hard to target on small screens.'),
            ],
          ),

          // ── 10. Accessibility Impact ─────────────────────────
          siSection('Accessibility Impact',
            children: [
              siBody(
                'SliderInteraction primarily affects pointer/touch '
                'gestures. It does NOT affect keyboard or screen-reader '
                'interaction:'),
              for (final item in [
                'Arrow keys always work regardless of interaction mode.',
                'TalkBack/VoiceOver users adjust via actions, not gestures.',
                'slideThumb may confuse users who tap the track expecting '
                    'a response — provide visual cues.',
                'tapOnly disables drag, but keyboard arrows still '
                    'increment/decrement in steps.',
                'Always test with assistive technology after restricting '
                    'interactions.',
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('→ ',
                          style: TextStyle(
                              color: siPrimary,
                              fontWeight: FontWeight.w700)),
                      Expanded(
                        child: Text(item,
                            style: TextStyle(fontSize: 12, color: siMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 11. Touch Target Analysis ────────────────────────
          siSection('Touch Target Size Analysis',
            children: [
              siBody(
                'The effective touch target for slideThumb depends on '
                'the thumb radius. Visualisation of target areas at '
                'different sizes:'),
              for (final size in [
                {'radius': 10.0, 'label': 'Default (10dp)', 'grade': 'Small'},
                {'radius': 16.0, 'label': 'Medium (16dp)', 'grade': 'OK'},
                {'radius': 22.0, 'label': 'Large (22dp)', 'grade': 'Recommended'},
              ])
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: siLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: (size['radius'] as double) * 2,
                        height: (size['radius'] as double) * 2,
                        decoration: BoxDecoration(
                          color: siPrimary,
                          shape: BoxShape.circle,
                          border: Border.all(color: siDark, width: 2),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(size['label'] as String,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            Text(
                              'Grade: ${size['grade']}  •  '
                              'Diameter: ${((size['radius'] as double) * 2).toStringAsFixed(0)}dp',
                              style: TextStyle(
                                  fontSize: 11, color: siMuted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              siBody(
                'For slideThumb, Material guidelines recommend at '
                'least 48dp touch target. The overlay extends the '
                'effective area beyond the visible thumb.'),
            ],
          ),

          // ── 12. Common Pitfalls ──────────────────────────────
          siSection('Common Pitfalls',
            children: [
              for (final pit in [
                {
                  'title': 'slideThumb with tiny thumb',
                  'detail':
                      'Using slideThumb with default thumb size makes '
                      'the slider nearly unusable on mobile. Increase '
                      'thumb radius to at least 16dp.',
                },
                {
                  'title': 'tapOnly on continuous sliders',
                  'detail':
                      'tapOnly on a continuous slider gives poor '
                      'precision because there are no snap points. '
                      'Prefer tapOnly with divisions.',
                },
                {
                  'title': 'Mixing modes in a form',
                  'detail':
                      'Having different interaction modes for similar-'
                      'looking sliders in the same form confuses users. '
                      'Be consistent.',
                },
                {
                  'title': 'No visual hint for restricted modes',
                  'detail':
                      'Users cannot tell by looking whether a slider '
                      'supports tapping. Add helper text or tooltips '
                      'for non-default modes.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: siPrimary.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: siDark, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(pit['title']!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(pit['detail']!,
                          style: TextStyle(fontSize: 11, color: siMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 13. Decision Guide ───────────────────────────────
          siSection('Decision Guide',
            children: [
              siBody(
                'Use this flow to pick the right mode:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: siLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final step in [
                      '1. Is accidental track-tap OK?',
                      '   YES → Does user need to slide too?',
                      '         YES → tapAndSlide (default)',
                      '         NO  → tapOnly',
                      '   NO  → Should sliding work from the track?',
                      '         YES → slideOnly',
                      '         NO  → slideThumb',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(step,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 14. Mobile vs Desktop ────────────────────────────
          siSection('Mobile vs Desktop Considerations',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: siLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phone_android,
                                  color: siDark, size: 18),
                              const SizedBox(width: 6),
                              const Text('Mobile',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          for (final tip in [
                            'Finger imprecision makes slideThumb hard',
                            'tapAndSlide works best as default',
                            'Larger thumbs improve slideThumb usability',
                            'tapOnly good for discrete 3-5 step choices',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text('• $tip',
                                  style: TextStyle(
                                      fontSize: 11, color: siMuted)),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: siLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.desktop_windows_outlined,
                                  color: siDark, size: 18),
                              const SizedBox(width: 6),
                              const Text('Desktop',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          for (final tip in [
                            'Mouse precision makes slideThumb viable',
                            'slideOnly common for audio/video timelines',
                            'Hover states visible before clicking',
                            'Keyboard arrows work in all modes',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text('• $tip',
                                  style: TextStyle(
                                      fontSize: 11, color: siMuted)),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── 15. Related APIs ─────────────────────────────────
          siSection('Related APIs',
            children: [
              for (final api in [
                {
                  'name': 'SliderThemeData',
                  'rel': 'Provides allowedInteraction property',
                },
                {
                  'name': 'Slider',
                  'rel': 'Primary widget using this interaction model',
                },
                {
                  'name': 'RangeSlider',
                  'rel': 'Also respects allowedInteraction',
                },
                {
                  'name': 'ShowValueIndicator',
                  'rel': 'Indicator visibility, complementary setting',
                },
                {
                  'name': 'GestureDetector',
                  'rel': 'Lower-level gesture handling that Slider uses',
                },
                {
                  'name': 'SliderComponentShape',
                  'rel': 'Affects touch target size for slideThumb',
                },
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190,
                        child: Text(api['name']!,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: siDark)),
                      ),
                      Expanded(
                        child: Text(api['rel']!,
                            style: TextStyle(fontSize: 12, color: siMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 16. Summary Dashboard ────────────────────────────
          siSection('Summary Dashboard',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: siPrimary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                                '${SliderInteraction.values.length}',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: siDark)),
                            const Text('Enum Values',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: siAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('8',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: siDark)),
                            const Text('Live Sliders',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: siLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('4',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: siDark)),
                            const Text('Zone Diagrams',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: siLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'SliderInteraction gives precise control over '
                    'how users operate Slider widgets. Choose the '
                    'right mode to match your UX expectations and '
                    'prevent accidental input.',
                    style: TextStyle(
                        fontSize: 12, color: siMuted, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Footer ───────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: siDark,
            child: Column(
              children: [
                const Text('SliderInteraction Deep Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Pistachio/Lime theme  •  Batch 61  •  '
                  '${SliderInteraction.values.length} enum values  •  '
                  '8 live sliders',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
