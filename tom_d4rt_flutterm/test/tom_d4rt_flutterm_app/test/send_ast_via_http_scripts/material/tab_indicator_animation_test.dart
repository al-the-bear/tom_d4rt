// ignore_for_file: avoid_print
// D4rt deep demo: TabIndicatorAnimation — controls how the selection
// indicator moves between tabs: linear (constant speed) or elastic
// (spring-like with asymmetric overshoot).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabIndicatorAnimation deep demo executing');
  print('=' * 60);

  for (final v in TabIndicatorAnimation.values) {
    print('  ${v.name} (index ${v.index})');
  }
  print('Total values: ${TabIndicatorAnimation.values.length}');
  print('=' * 60);

  // ── colour palette ──────────────────────────────────────────
  const tiPrimary = Color(0xFF7B2D6E);   // mulberry
  const tiAccent = Color(0xFFA05497);     // soft plum
  const tiLight = Color(0xFFF6EBF4);      // pale mulberry
  const tiDark = Color(0xFF4A1942);       // deep mulberry
  const tiSurface = Color(0xFFFDF8FC);
  const tiOnSurface = Color(0xFF301A2D);
  const tiMuted = Color(0xFF7B5E78);

  // ── data ────────────────────────────────────────────────────
  final List<Map<String, String>> tiAnimations = [
    {
      'value': 'linear',
      'title': 'Linear',
      'desc': 'The selection indicator moves at a constant speed '
          'from the current tab to the target tab. Both leading '
          'and trailing edges move at the same rate, producing a '
          'sliding rectangle motion.',
      'motion': 'Constant velocity, uniform timing',
      'curve': 'Effectively linear interpolation',
      'feel': 'Mechanical, predictable, direct',
      'default': 'Default in Material 2',
    },
    {
      'value': 'elastic',
      'title': 'Elastic',
      'desc': 'The indicator stretches and contracts as it moves. '
          'The leading edge begins first and accelerates, while '
          'the trailing edge follows with a spring-like deceleration. '
          'This creates a rubber-band effect.',
      'motion': 'Asymmetric spring: leading edge leads, trailing snaps',
      'curve': 'Custom spring physics per edge',
      'feel': 'Organic, playful, modern',
      'default': 'Default in Material 3',
    },
  ];

  // ── helpers ─────────────────────────────────────────────────
  Widget tiSection(String title, {Widget? child, List<Widget>? children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tiAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: tiPrimary.withValues(alpha: 0.07),
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
                colors: [tiPrimary, tiDark],
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
            child: child ??
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children ?? []),
          ),
        ],
      ),
    );
  }

  Widget tiLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: tiOnSurface)),
    );
  }

  Widget tiBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: tiMuted, height: 1.5)),
    );
  }

  Widget tiChip(String label, {Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? tiLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tiAccent.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget tiDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: tiAccent.withValues(alpha: 0.2), height: 1),
    );
  }

  // Live TabBar with given animation style
  Widget tiTabBarDemo({
    required TabIndicatorAnimation animation,
    required String label,
    List<String> tabs = const ['Home', 'Search', 'Profile', 'Settings'],
    String? note,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tiAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: tiLight,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: tiPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(label,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700)),
                ),
                tiChip(animation.name),
              ],
            ),
          ),
          DefaultTabController(
            length: tabs.length,
            child: TabBar(
              indicatorAnimation: animation,
              labelColor: tiDark,
              unselectedLabelColor: tiMuted,
              indicatorColor: tiPrimary,
              tabs: [for (final t in tabs) Tab(text: t)],
            ),
          ),
          if (note != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Text(note,
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: tiMuted)),
            ),
        ],
      ),
    );
  }

  // Curve visualiser — draws a simple bar chart
  Widget tiCurveBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Container(
              height: 18,
              decoration: BoxDecoration(
                color: tiLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                widthFactor: fraction.clamp(0.0, 1.0),
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 45,
            child: Text('${(fraction * 100).toInt()}%',
                style: TextStyle(fontSize: 11, color: tiMuted)),
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
      color: tiSurface,
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
                colors: [tiDark, tiPrimary, tiAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TabIndicatorAnimation',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  'Determines the motion style of the tab selection '
                  'indicator as it transitions between tabs.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    tiChip('enum', bg: Colors.white.withValues(alpha: 0.2)),
                    tiChip('TabBar',
                        bg: Colors.white.withValues(alpha: 0.2)),
                    tiChip('animation',
                        bg: Colors.white.withValues(alpha: 0.2)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 2. Enum Overview ─────────────────────────────────
          tiSection('Enum Overview',
            children: [
              tiBody(
                'TabIndicatorAnimation was introduced in Flutter 3.22 '
                'to give developers control over the indicator motion '
                'style. Material 3 defaults to elastic, while Material 2 '
                'used a simpler linear slide.'),
              tiBody(
                'The enum affects ONLY how the indicator rectangle '
                'transitions between positions — it does not change the '
                'indicator shape, colour, or thickness.'),
              Wrap(
                children: [
                  for (final v in TabIndicatorAnimation.values)
                    tiChip(v.name),
                ],
              ),
            ],
          ),

          // ── 3. Individual Value Cards ────────────────────────
          for (final a in tiAnimations)
            tiSection(a['title']!,
              children: [
                tiLabel('Value'),
                tiChip('TabIndicatorAnimation.${a['value']}'),
                const SizedBox(height: 8),
                tiLabel('Description'),
                tiBody(a['desc']!),
                tiLabel('Motion Characteristics'),
                tiBody(a['motion']!),
                tiLabel('Animation Curve'),
                tiBody(a['curve']!),
                tiLabel('Perceived Feel'),
                tiBody(a['feel']!),
                tiLabel('Default Context'),
                tiBody(a['default']!),
              ],
            ),

          // ── 4. Live TabBar Demos — Individual ────────────────
          tiSection('Live TabBars — Each Animation',
            children: [
              tiBody(
                'Tap between tabs to observe the indicator motion. '
                'Linear slides uniformly; elastic stretches and snaps.'),
              tiTabBarDemo(
                animation: TabIndicatorAnimation.linear,
                label: 'Linear Animation',
                note: 'Indicator slides at constant velocity from tab to tab.',
              ),
              tiTabBarDemo(
                animation: TabIndicatorAnimation.elastic,
                label: 'Elastic Animation',
                note: 'Indicator stretches, then the trailing edge snaps into place.',
              ),
            ],
          ),

          // ── 5. Side-by-Side Comparison ───────────────────────
          tiSection('Side-by-Side: Linear vs Elastic',
            children: [
              tiBody(
                'Both TabBars have the same tabs. Tap tabs in each '
                'to compare the motion directly:'),
              for (final anim in [
                TabIndicatorAnimation.linear,
                TabIndicatorAnimation.elastic,
              ])
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: anim == TabIndicatorAnimation.linear
                                  ? tiAccent
                                  : tiPrimary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(anim.name,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      DefaultTabController(
                        length: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: tiLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TabBar(
                            indicatorAnimation: anim,
                            labelColor: tiDark,
                            unselectedLabelColor: tiMuted,
                            indicatorColor: tiPrimary,
                            tabs: const [
                              Tab(text: 'One'),
                              Tab(text: 'Two'),
                              Tab(text: 'Three'),
                              Tab(text: 'Four'),
                              Tab(text: 'Five'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 6. Motion Phase Diagram ──────────────────────────
          tiSection('Motion Phase Breakdown',
            children: [
              tiBody(
                'How each animation mode behaves across the transition:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tiLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Linear',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    for (final phase in [
                      'Start → 25%:  L●────────R  (both edges move equally)',
                      '25%  → 50%:  ─L●───────R  (uniform translation)',
                      '50%  → 75%:  ──L●──────R  (constant speed continues)',
                      '75%  → End:  ───L●─────R  (arrives simultaneously)',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(phase,
                            style: const TextStyle(
                                fontSize: 11, fontFamily: 'monospace')),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tiLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Elastic',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    for (final phase in [
                      'Start → 25%:  L●────R     (leading accelerates)',
                      '25%  → 50%:  ──L●──────R  (indicator stretches)',
                      '50%  → 75%:  ────L●────R  (trailing catches up)',
                      '75%  → End:  ──────L●──R  (trailing snaps, slight overshoot)',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(phase,
                            style: const TextStyle(
                                fontSize: 11, fontFamily: 'monospace')),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 7. Animation Timing Analysis ─────────────────────
          tiSection('Animation Timing Analysis',
            children: [
              tiBody(
                'Animation characteristics at different transition '
                'distances (number of tabs between source and target):'),
              SizedBox(
                width: double.infinity,
                child: Table(
                  border: TableBorder.all(
                      color: tiAccent.withValues(alpha: 0.3), width: 1),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1.5),
                    2: FlexColumnWidth(1.7),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                          color: tiPrimary.withValues(alpha: 0.1)),
                      children: [
                        for (final h in [
                          'Distance',
                          'Linear',
                          'Elastic',
                        ])
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(h,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11)),
                          ),
                      ],
                    ),
                    for (final row in [
                      [
                        'Adjacent (1 tab)',
                        'Smooth slide',
                        'Subtle stretch',
                      ],
                      [
                        'Short (2 tabs)',
                        'Steady glide',
                        'Noticeable stretch',
                      ],
                      [
                        'Medium (3 tabs)',
                        'Even motion',
                        'Pronounced rubber-band',
                      ],
                      [
                        'Long (4+ tabs)',
                        'Long steady slide',
                        'Dramatic stretch & snap',
                      ],
                    ])
                      TableRow(
                        children: [
                          for (final cell in row)
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(cell,
                                  style: TextStyle(
                                      fontSize: 11, color: tiMuted)),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 8. Spring Physics Explanation ─────────────────────
          tiSection('Elastic Spring Physics',
            children: [
              tiBody(
                'The elastic animation uses separate spring simulations '
                'for the leading and trailing edges of the indicator:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tiLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in [
                      'Leading edge: Fast start, arrives early',
                      'Trailing edge: Delayed start, arrives with spring overshoot',
                      'Peak stretch: ~30-40% through the animation',
                      'Overshoot: Trailing edge briefly passes target, then settles',
                      'Total duration: Same as linear (~300ms default)',
                    ]) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('→ ',
                              style: TextStyle(
                                  color: tiPrimary,
                                  fontWeight: FontWeight.w700)),
                          Expanded(
                            child: Text(item,
                                style: TextStyle(
                                    fontSize: 12, color: tiMuted)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 10),
              tiBody(
                'This asymmetry between edges is what creates the '
                'characteristic "stretching" look. The indicator '
                'temporarily becomes wider than its resting width.'),
            ],
          ),

          // ── 9. Energy Visualiser ─────────────────────────────
          tiSection('Motion Energy Visualiser',
            children: [
              tiBody(
                'Relative "motion energy" across the animation timeline '
                '(higher = more movement at that point):'),
              const Text('Linear',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              tiCurveBar('0-25%', 0.50, tiAccent),
              tiCurveBar('25-50%', 0.50, tiAccent),
              tiCurveBar('50-75%', 0.50, tiAccent),
              tiCurveBar('75-100%', 0.50, tiAccent),
              tiDivider(),
              const Text('Elastic',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              tiCurveBar('0-25%', 0.80, tiPrimary),
              tiCurveBar('25-50%', 0.95, tiPrimary),
              tiCurveBar('50-75%', 0.55, tiPrimary),
              tiCurveBar('75-100%', 0.30, tiPrimary),
              const SizedBox(height: 6),
              tiBody(
                'Linear has uniform energy. Elastic front-loads energy '
                '(fast start) and tapers off (trailing snaps to rest).'),
            ],
          ),

          // ── 10. Material 2 vs 3 Defaults ────────────────────
          tiSection('Material 2 vs Material 3 Defaults',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: tiLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Material 2',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          for (final fact in [
                            'No indicatorAnimation property',
                            'Implicit linear motion',
                            'Simple slide transition',
                            'No stretch effect',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text('• $fact',
                                  style: TextStyle(
                                      fontSize: 11, color: tiMuted)),
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
                        color: tiLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Material 3',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          for (final fact in [
                            'indicatorAnimation added',
                            'Default: elastic',
                            'Rubber-band stretch & snap',
                            'Matches M3 motion spec',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text('• $fact',
                                  style: TextStyle(
                                      fontSize: 11, color: tiMuted)),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── 11. Many Tabs Demo ───────────────────────────────
          tiSection('Long-Distance Transitions',
            children: [
              tiBody(
                'With many tabs, elastic stretch becomes very '
                'pronounced. Tap the first and last tab to see a '
                'full-width stretch:'),
              tiTabBarDemo(
                animation: TabIndicatorAnimation.elastic,
                label: '7 tabs — elastic animation',
                tabs: [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                  'Sun',
                ],
                note: 'Tap Mon then Sun: the indicator stretches across the '
                    'entire bar before snapping to the target.',
              ),
              tiTabBarDemo(
                animation: TabIndicatorAnimation.linear,
                label: '7 tabs — linear animation',
                tabs: [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                  'Sun',
                ],
                note: 'Same tabs with linear: steady glide, no stretching.',
              ),
            ],
          ),

          // ── 12. Indicator Size Interaction ───────────────────
          tiSection('Interaction with indicatorSize',
            children: [
              tiBody(
                'TabBarIndicatorSize (.tab vs .label) changes the '
                'indicator width — the animation still applies:'),
              for (final combo in [
                {
                  'label': 'elastic + indicatorSize: tab',
                  'desc': 'Full-width indicator stretches across entire tab width.',
                },
                {
                  'label': 'elastic + indicatorSize: label',
                  'desc': 'Narrow indicator stretches between label widths.',
                },
                {
                  'label': 'linear + indicatorSize: tab',
                  'desc': 'Full-width indicator slides uniformly.',
                },
                {
                  'label': 'linear + indicatorSize: label',
                  'desc': 'Narrow indicator slides uniformly between labels.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tiLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(combo['label']!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(combo['desc']!,
                          style: TextStyle(fontSize: 11, color: tiMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 13. UX Recommendations ───────────────────────────
          tiSection('UX Recommendations',
            children: [
              for (final rec in [
                {
                  'scenario': 'Productivity / Data-heavy apps',
                  'recommendation': 'linear',
                  'reason': 'Less visual distraction; focus stays on content.',
                },
                {
                  'scenario': 'Consumer / Social apps',
                  'recommendation': 'elastic',
                  'reason': 'Playful motion matches casual user expectations.',
                },
                {
                  'scenario': 'Accessibility-focused apps',
                  'recommendation': 'linear',
                  'reason': 'Simpler motion is easier to follow for users '
                      'with vestibular sensitivities.',
                },
                {
                  'scenario': 'Material 3 compliance',
                  'recommendation': 'elastic',
                  'reason': 'Matches Material 3 motion specification.',
                },
                {
                  'scenario': 'Custom branded motion',
                  'recommendation': 'Either — override with custom indicator',
                  'reason': 'For unique branding, create a custom '
                      'Decoration instead.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tiLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rec['scenario']!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      tiChip(rec['recommendation']!),
                      const SizedBox(height: 4),
                      Text(rec['reason']!,
                          style: TextStyle(fontSize: 11, color: tiMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 14. Common Pitfalls ──────────────────────────────
          tiSection('Common Pitfalls',
            children: [
              for (final pit in [
                {
                  'title': 'Expecting elastic on Material 2',
                  'detail':
                      'If ThemeData.useMaterial3 is false (Material 2), '
                      'the default is linear. You must explicitly set '
                      'indicatorAnimation: TabIndicatorAnimation.elastic.',
                },
                {
                  'title': 'Custom indicator overrides animation',
                  'detail':
                      'If you provide a custom indicator Decoration, '
                      'the built-in animation is bypassed. You must '
                      'handle animation yourself in the decoration.',
                },
                {
                  'title': 'Confusing with TabBarIndicatorSize',
                  'detail':
                      'indicatorAnimation controls MOTION style. '
                      'indicatorSize controls WIDTH. They are '
                      'independent properties.',
                },
                {
                  'title': 'Reduced motion preference',
                  'detail':
                      'Users who enable "reduce motion" in OS settings '
                      'may find elastic too dynamic. Consider listening '
                      'to MediaQuery.disableAnimations.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: tiPrimary.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: tiDark, size: 16),
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
                          style: TextStyle(fontSize: 11, color: tiMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 15. Related APIs ─────────────────────────────────
          tiSection('Related APIs',
            children: [
              for (final api in [
                {
                  'name': 'TabBar.indicatorAnimation',
                  'rel': 'The property that accepts this enum',
                },
                {
                  'name': 'TabBar',
                  'rel': 'Primary widget using indicator animation',
                },
                {
                  'name': 'TabBar.secondary',
                  'rel': 'Secondary tab bar (same animation applies)',
                },
                {
                  'name': 'TabBarIndicatorSize',
                  'rel': 'Controls indicator width (.tab vs .label)',
                },
                {
                  'name': 'TabAlignment',
                  'rel': 'Controls tab horizontal positioning',
                },
                {
                  'name': 'AnimationController',
                  'rel': 'Underlying animation driving the indicator',
                },
                {
                  'name': 'TabBarTheme',
                  'rel': 'Theme-level tab styling including animation',
                },
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 210,
                        child: Text(api['name']!,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: tiDark)),
                      ),
                      Expanded(
                        child: Text(api['rel']!,
                            style: TextStyle(fontSize: 12, color: tiMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 16. Summary Dashboard ────────────────────────────
          tiSection('Summary Dashboard',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: tiPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                                '${TabIndicatorAnimation.values.length}',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: tiDark)),
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
                          color: tiAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('6',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: tiDark)),
                            const Text('Live TabBars',
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
                          color: tiLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('16',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: tiDark)),
                            const Text('Sections',
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
                    color: tiLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'TabIndicatorAnimation lets you choose between a '
                    'simple linear slide and an organic elastic stretch '
                    'for the tab selection indicator. Match the style '
                    'to your app personality and user needs.',
                    style: TextStyle(
                        fontSize: 12, color: tiMuted, height: 1.5),
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
            color: tiDark,
            child: Column(
              children: [
                const Text('TabIndicatorAnimation Deep Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Mulberry/Plum theme  •  Batch 61  •  '
                  '${TabIndicatorAnimation.values.length} enum values  •  '
                  '6 live TabBars',
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
