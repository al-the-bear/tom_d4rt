// ignore_for_file: avoid_print
// D4rt deep demo: StretchMode — controls the visual effect applied to
// FlexibleSpaceBar content when the user overscrolls (zoom, blur, fade).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StretchMode deep demo executing');
  print('=' * 60);

  for (final v in StretchMode.values) {
    print('  ${v.name} (index ${v.index})');
  }
  print('Total values: ${StretchMode.values.length}');
  print('=' * 60);

  // ── colour palette ──────────────────────────────────────────
  const smPrimary = Color(0xFF1565C0);   // sapphire
  const smAccent = Color(0xFF42A5F5);    // azure
  final smLight = const Color(0xFFE3F2FD);  // pale azure
  const smDark = Color(0xFF0D47A1);      // deep sapphire
  const smSurface = Color(0xFFF5F9FF);
  const smOnSurface = Color(0xFF1A237E);
  const smMuted = Color(0xFF546E7A);

  // ── data ────────────────────────────────────────────────────
  final List<Map<String, dynamic>> smModeData = [
    {
      'value': StretchMode.zoomBackground,
      'name': 'zoomBackground',
      'title': 'Zoom Background',
      'desc': 'Scales the background image up as the user overscrolls '
          'downward. The further the overscroll, the larger the zoom. '
          'This is the default and most common stretch mode.',
      'effect': 'Scale transform on background',
      'visual': 'Image grows beyond its natural size',
      'icon': Icons.zoom_in,
    },
    {
      'value': StretchMode.blurBackground,
      'name': 'blurBackground',
      'title': 'Blur Background',
      'desc': 'Applies a progressive gaussian blur to the background '
          'as the user overscrolls. Creates an iOS-style frosted '
          'glass effect that intensifies with scroll distance.',
      'effect': 'ImageFilter.blur applied progressively',
      'visual': 'Background becomes increasingly blurred',
      'icon': Icons.blur_on,
    },
    {
      'value': StretchMode.fadeTitle,
      'name': 'fadeTitle',
      'title': 'Fade Title',
      'desc': 'Fades the title text to transparent as the user '
          'overscrolls. The title opacity decreases proportionally '
          'to the overscroll distance.',
      'effect': 'Opacity animation on title widget',
      'visual': 'Title gradually disappears',
      'icon': Icons.text_decrease,
    },
  ];

  // ── helpers ─────────────────────────────────────────────────
  Widget smSection(String title, {Widget? child, List<Widget>? children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: smAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: smPrimary.withValues(alpha: 0.07),
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
                colors: [smPrimary, smAccent],
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

  Widget smLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: smOnSurface)),
    );
  }

  Widget smBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: smMuted, height: 1.5)),
    );
  }

  Widget smChip(String label, {Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? smLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: smAccent.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget smDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: smAccent.withValues(alpha: 0.2), height: 1),
    );
  }

  // Mini SliverAppBar simulation (contained, not a real CustomScrollView)
  Widget smAppBarPreview({
    required String title,
    required List<StretchMode> modes,
    required Color headerColor,
    required String description,
    double height = 180,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: smAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Simulated expanded app bar
          Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [headerColor, Color.lerp(headerColor, Colors.black, 0.3)!],
              ),
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned.fill(
                  child: GridView.count(
                    crossAxisCount: 8,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      64,
                      (i) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.06),
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Title area
                Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          for (final m in modes) ...[
                            smChip(m.name,
                                bg: Colors.white.withValues(alpha: 0.2)),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                // Stretch indicator
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      modes.map((m) => m.name).join(' + '),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Description
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: smLight,
            child: Text(description,
                style: TextStyle(fontSize: 12, color: smMuted, height: 1.4)),
          ),
        ],
      ),
    );
  }

  // Overscroll amount visualizer
  Widget smStretchBar({
    required String label,
    required double fraction,
    required Color color,
    required String effectLabel,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: smLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: fraction.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(effectLabel,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
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
      color: smSurface,
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
                colors: [smDark, smPrimary, smAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('StretchMode',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  'Controls the visual effect applied to '
                  'FlexibleSpaceBar content during overscroll.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    smChip('enum', bg: Colors.white.withValues(alpha: 0.2)),
                    smChip('FlexibleSpaceBar',
                        bg: Colors.white.withValues(alpha: 0.2)),
                    smChip('SliverAppBar',
                        bg: Colors.white.withValues(alpha: 0.2)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 2. Enum Overview ─────────────────────────────────
          smSection('Enum Overview',
            children: [
              smBody(
                'StretchMode is an enum used in FlexibleSpaceBar.stretchModes '
                'to define what happens when the user overscrolls beyond '
                'the top of a scrollable area containing a SliverAppBar. '
                'Multiple modes can be combined in a list.'),
              smBody(
                'Stretch only activates when SliverAppBar.stretch is true '
                'and the scroll physics allow overscroll (like '
                'BouncingScrollPhysics on iOS).'),
              Wrap(
                children: [
                  for (final v in StretchMode.values)
                    smChip(v.name),
                ],
              ),
              const SizedBox(height: 8),
              smBody(
                'Default: [StretchMode.zoomBackground]'),
            ],
          ),

          // ── 3. Individual Mode Cards ─────────────────────────
          for (final m in smModeData)
            smSection('${m['name']}',
              children: [
                Row(
                  children: [
                    Icon(m['icon'] as IconData, color: smPrimary, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(m['title'] as String,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                smLabel('Description'),
                smBody(m['desc'] as String),
                smLabel('Visual Effect'),
                smBody(m['effect'] as String),
                smLabel('What You See'),
                smBody(m['visual'] as String),
                smLabel('Index'),
                smBody('${(m['value'] as StretchMode).index}'),
              ],
            ),

          // ── 4. Live Demo — zoomBackground ────────────────────
          smSection('Live Preview — zoomBackground',
            children: [
              smBody(
                'The background image scales up proportionally to the '
                'overscroll distance. Below is a simulated SliverAppBar '
                'with a gridded background so you can see the zoom:'),
              smAppBarPreview(
                title: 'Zoom Effect',
                modes: [StretchMode.zoomBackground],
                headerColor: smPrimary,
                description:
                    'When the user pulls down beyond the scroll extent, '
                    'the background image zooms in. The grid pattern '
                    'would enlarge, revealing less content at larger scale.',
                height: 200,
              ),
              smBody(
                'The zoom factor is proportional to overscroll pixels: '
                'at 0px overscroll the scale is 1.0, and it increases '
                'linearly. The image is clipped to its original bounds.'),
            ],
          ),

          // ── 5. Live Demo — blurBackground ────────────────────
          smSection('Live Preview — blurBackground',
            children: [
              smBody(
                'A gaussian blur intensifies with overscroll distance. '
                'The blur sigma increases from 0 to a maximum:'),
              smAppBarPreview(
                title: 'Blur Effect',
                modes: [StretchMode.blurBackground],
                headerColor: const Color(0xFF5C6BC0),
                description:
                    'On overscroll, the background becomes progressively '
                    'blurred with an ImageFilter.blur. At resting position '
                    'the image is sharp; pulling down frosts the glass.',
                height: 180,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: smLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    smLabel('Blur Sigma Progression'),
                    for (final step in [
                      {'scroll': '0px', 'sigma': '0.0', 'desc': 'Sharp'},
                      {'scroll': '20px', 'sigma': '2.0', 'desc': 'Slight blur'},
                      {'scroll': '50px', 'sigma': '5.0', 'desc': 'Moderate'},
                      {'scroll': '100px', 'sigma': '10.0', 'desc': 'Heavy frost'},
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(step['scroll']!,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'monospace',
                                      fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text('σ ${step['sigma']}',
                                  style: TextStyle(
                                      fontSize: 11, color: smPrimary)),
                            ),
                            Expanded(
                              child: Text(step['desc']!,
                                  style: TextStyle(
                                      fontSize: 11, color: smMuted)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 6. Live Demo — fadeTitle ──────────────────────────
          smSection('Live Preview — fadeTitle',
            children: [
              smBody(
                'The title fades out as the user overscrolls. The '
                'opacity decreases from 1.0 to 0.0:'),
              smAppBarPreview(
                title: 'Fade Title',
                modes: [StretchMode.fadeTitle],
                headerColor: const Color(0xFF00897B),
                description:
                    'The "Fade Title" text would gradually become '
                    'transparent as the user pulls down. At maximum '
                    'overscroll the title is invisible.',
                height: 160,
              ),
              // Opacity steps visualization
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: smLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    smLabel('Title Opacity During Overscroll'),
                    for (final op in [1.0, 0.8, 0.6, 0.4, 0.2, 0.0])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text('${(op * 100).toInt()}%',
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Expanded(
                              child: Opacity(
                                opacity: op,
                                child: Text('Sample Title Text',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: smDark)),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 7. Combined Modes Demo ───────────────────────────
          smSection('Combined Modes',
            children: [
              smBody(
                'stretchModes accepts a List<StretchMode>, so '
                'multiple effects run simultaneously. Common '
                'combinations:'),
              smAppBarPreview(
                title: 'Zoom + Fade',
                modes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                headerColor: const Color(0xFFAD1457),
                description:
                    'Background zooms while title fades. The zoom '
                    'draws attention to the image as the text retreats.',
                height: 160,
              ),
              smAppBarPreview(
                title: 'All Three',
                modes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                headerColor: const Color(0xFF6A1B9A),
                description:
                    'Zoom + blur + fade simultaneously. The background '
                    'grows and blurs while the title fades. A dramatic '
                    'cinematic effect.',
                height: 160,
              ),
              smAppBarPreview(
                title: 'Blur + Fade',
                modes: [
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                headerColor: const Color(0xFF00695C),
                description:
                    'Background blurs without zooming while title '
                    'fades. A subtle, elegant transition.',
                height: 150,
              ),
            ],
          ),

          // ── 8. Stretch Mechanics ─────────────────────────────
          smSection('Stretch Mechanics Visualisation',
            children: [
              smBody(
                'The stretch effect intensity is proportional to the '
                'overscroll pixels. Below shows relative intensity at '
                'different overscroll depths:'),
              smLabel('zoomBackground Intensity'),
              for (final px in [10, 30, 60, 100])
                smStretchBar(
                  label: '${px}px',
                  fraction: px / 100.0,
                  color: smPrimary,
                  effectLabel: 'scale ${(1.0 + px / 200.0).toStringAsFixed(2)}x',
                ),
              smDivider(),
              smLabel('blurBackground Intensity'),
              for (final px in [10, 30, 60, 100])
                smStretchBar(
                  label: '${px}px',
                  fraction: px / 100.0,
                  color: smAccent,
                  effectLabel: 'σ ${(px / 10.0).toStringAsFixed(1)}',
                ),
              smDivider(),
              smLabel('fadeTitle Intensity'),
              for (final px in [10, 30, 60, 100])
                smStretchBar(
                  label: '${px}px',
                  fraction: px / 100.0,
                  color: const Color(0xFF00897B),
                  effectLabel: 'opacity ${(1.0 - px / 100.0).toStringAsFixed(1)}',
                ),
            ],
          ),

          // ── 9. Comparison Table ──────────────────────────────
          smSection('Effect Comparison Table',
            child: Table(
              border: TableBorder.all(
                  color: smAccent.withValues(alpha: 0.3), width: 1),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(1.5),
                3: FlexColumnWidth(1.5),
              },
              children: [
                TableRow(
                  decoration:
                      BoxDecoration(color: smPrimary.withValues(alpha: 0.1)),
                  children: [
                    for (final h in [
                      'Property',
                      'zoomBg',
                      'blurBg',
                      'fadeTitle',
                    ])
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(h,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 10)),
                      ),
                  ],
                ),
                for (final row in [
                  ['Affects', 'Background', 'Background', 'Title'],
                  ['Transform', 'Scale', 'Filter', 'Opacity'],
                  ['Reversible', '✓', '✓', '✓'],
                  ['Composable', '✓', '✓', '✓'],
                  ['GPU cost', 'Low', 'Medium', 'Low'],
                  ['Default', '✓', '✗', '✗'],
                ])
                  TableRow(
                    children: [
                      for (int i = 0; i < 4; i++)
                        Padding(
                          padding: EdgeInsets.all(7),
                          child: Text(row[i],
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight:
                                      i == 0 ? FontWeight.w600 : FontWeight.w400,
                                  color: i == 0 ? smDark : smMuted)),
                        ),
                    ],
                  ),
              ],
            ),
          ),

          // ── 10. SliverAppBar Integration ─────────────────────
          smSection('SliverAppBar Integration',
            children: [
              smBody(
                'StretchMode is only meaningful when SliverAppBar.stretch '
                'is true. Here are the key properties that interact:'),
              for (final prop in [
                [
                  'stretch',
                  'Must be true to enable stretch effects',
                ],
                [
                  'stretchTriggerOffset',
                  'Pixels of overscroll needed to trigger onStretchTrigger',
                ],
                [
                  'onStretchTrigger',
                  'Callback when stretchTriggerOffset is reached',
                ],
                [
                  'expandedHeight',
                  'Height of the app bar when fully expanded',
                ],
                [
                  'flexibleSpace',
                  'Usually a FlexibleSpaceBar with stretchModes',
                ],
                [
                  'pinned / floating',
                  'Controls collapse behaviour during normal scroll',
                ],
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 5, right: 8),
                        decoration: BoxDecoration(
                          color: smPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: Text(prop[0],
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace')),
                      ),
                      Expanded(
                        child: Text(prop[1],
                            style: TextStyle(fontSize: 12, color: smMuted)),
                      ),
                    ],
                  ),
                ),
              smDivider(),
              smBody(
                'The FlexibleSpaceBar reads the parent SliverAppBar '
                'constraints. When scroll position goes negative '
                '(overscroll), it applies the configured stretch modes.'),
            ],
          ),

          // ── 11. Scroll Physics Context ───────────────────────
          smSection('Scroll Physics & Platform Context',
            children: [
              smBody(
                'Stretch effects depend on the scroll physics allowing '
                'overscroll. Platform defaults differ:'),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: smLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.phone_iphone, color: smDark, size: 28),
                          const SizedBox(height: 6),
                          const Text('iOS',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text('BouncingScrollPhysics',
                              style: TextStyle(fontSize: 10, color: smMuted)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('Stretch works natively',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.green.shade700)),
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
                        color: smLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.phone_android, color: smDark, size: 28),
                          const SizedBox(height: 6),
                          const Text('Android',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text('ClampingScrollPhysics',
                              style: TextStyle(fontSize: 10, color: smMuted)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('No overscroll by default',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.orange.shade800)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              smBody(
                'To enable stretch on Android, use '
                'BouncingScrollPhysics or '
                'AlwaysScrollableScrollPhysics with bouncing '
                'parent, for example in a CustomScrollView:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in [
                      'CustomScrollView(',
                      '  physics: BouncingScrollPhysics(',
                      '    parent: AlwaysScrollableScrollPhysics(),',
                      '  ),',
                      '  slivers: [',
                      '    SliverAppBar(',
                      '      stretch: true,',
                      '      flexibleSpace: FlexibleSpaceBar(',
                      '        stretchModes: [',
                      '          StretchMode.zoomBackground,',
                      '          StretchMode.fadeTitle,',
                      '        ],',
                      '      ),',
                      '    ),',
                      '  ],',
                      ')',
                    ])
                      Text(line,
                          style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              height: 1.5)),
                  ],
                ),
              ),
            ],
          ),

          // ── 12. Common Pitfalls ──────────────────────────────
          smSection('Common Pitfalls',
            children: [
              for (final pit in [
                {
                  'title': 'Forgetting stretch: true',
                  'detail':
                      'stretchModes has no effect unless SliverAppBar.stretch '
                      'is explicitly set to true. This is the most common '
                      'mistake.',
                },
                {
                  'title': 'Clamping physics on Android',
                  'detail':
                      'Android defaults to ClampingScrollPhysics which prevents '
                      'overscroll. Without bouncing physics, stretch modes '
                      'never activate.',
                },
                {
                  'title': 'blurBackground performance',
                  'detail':
                      'Gaussian blur is GPU-intensive. On low-end devices, '
                      'blurBackground may cause dropped frames during rapid '
                      'overscroll. Test on real hardware.',
                },
                {
                  'title': 'Empty stretchModes list',
                  'detail':
                      'Passing an empty list disables all stretch effects '
                      'even when stretch is true. The default is '
                      '[StretchMode.zoomBackground].',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: smPrimary.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: smDark, size: 16),
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
                          style: TextStyle(fontSize: 11, color: smMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 13. onStretchTrigger Demo ────────────────────────
          smSection('onStretchTrigger Callback',
            children: [
              smBody(
                'SliverAppBar.onStretchTrigger fires when the overscroll '
                'exceeds stretchTriggerOffset (default: 100.0). This '
                'callback is separate from StretchMode effects but '
                'commonly used together for pull-to-refresh patterns:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: smLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    smLabel('Pull-to-Refresh with Stretch'),
                    for (final step in [
                      '0px   → Normal state',
                      '50px  → Zoom begins, title fading',
                      '100px → onStretchTrigger fires!',
                      '      → Begin data refresh',
                      '      → Show loading indicator',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(step,
                            style: const TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              smBody(
                'The default stretchTriggerOffset of 100.0 can be '
                'customised. Set a smaller value for easier triggering '
                'or a larger one to require more deliberate overscroll.'),
            ],
          ),

          // ── 14. Performance Notes ────────────────────────────
          smSection('Performance Notes',
            children: [
              for (final note in [
                {
                  'mode': 'zoomBackground',
                  'cost': 'Low',
                  'detail': 'Simple transform matrix scale — handled '
                      'entirely by the compositor with no extra '
                      'rasterization.',
                },
                {
                  'mode': 'blurBackground',
                  'cost': 'Medium–High',
                  'detail': 'Uses BackdropFilter / ImageFilter.blur '
                      'which requires GPU shader passes. Can drop frames '
                      'on low-end devices.',
                },
                {
                  'mode': 'fadeTitle',
                  'cost': 'Very Low',
                  'detail': 'Opacity change via RenderOpacity — one '
                      'of the cheapest operations available.',
                },
              ])
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: smLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 110,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(note['mode']!,
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 2),
                            smChip(note['cost']!),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(note['detail']!,
                            style: TextStyle(fontSize: 11, color: smMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 15. Related APIs ─────────────────────────────────
          smSection('Related APIs',
            children: [
              for (final api in [
                {
                  'name': 'FlexibleSpaceBar',
                  'rel': 'Widget that uses stretchModes property',
                },
                {
                  'name': 'SliverAppBar',
                  'rel': 'Parent that provides stretch: true',
                },
                {
                  'name': 'CustomScrollView',
                  'rel': 'Container scroll view for slivers',
                },
                {
                  'name': 'BouncingScrollPhysics',
                  'rel': 'Required scroll physics for overscroll',
                },
                {
                  'name': 'BackdropFilter',
                  'rel': 'Underlying widget for blurBackground',
                },
                {
                  'name': 'CollapseMode',
                  'rel': 'Related enum for collapse behaviour',
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
                                color: smDark)),
                      ),
                      Expanded(
                        child: Text(api['rel']!,
                            style: TextStyle(fontSize: 12, color: smMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 16. Summary Dashboard ────────────────────────────
          smSection('Summary Dashboard',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: smPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                                '${StretchMode.values.length}',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: smDark)),
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
                          color: smAccent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('7',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: smDark)),
                            const Text('Combinations',
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
                          color: smLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('6',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: smDark)),
                            const Text('Previews',
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
                    color: smLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'StretchMode enables beautiful overscroll effects '
                    'for SliverAppBar. Combine modes for rich visual '
                    'feedback. Remember: stretch requires bouncing '
                    'scroll physics and stretch: true.',
                    style: TextStyle(
                        fontSize: 12, color: smMuted, height: 1.5),
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
            color: smDark,
            child: Column(
              children: [
                const Text('StretchMode Deep Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Sapphire/Azure theme  •  Batch 61  •  '
                  '${StretchMode.values.length} enum values  •  '
                  '6 live previews',
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
