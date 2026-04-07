// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: ScrollbarPainter — the CustomPainter that Scrollbar uses to
// render its track and thumb. This demo explores every configurable
// property and shows how ScrollbarPainter connects to ScrollMetrics.
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'ScrollbarPainter Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: Colors.brown,
      brightness: Brightness.light,
      useMaterial3: true,
    ),
    home: const _ScrollbarPainterHome(),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Home scaffold
// ═════════════════════════════════════════════════════════════════════
class _ScrollbarPainterHome extends StatefulWidget {
  const _ScrollbarPainterHome();

  @override
  State<_ScrollbarPainterHome> createState() => _ScrollbarPainterHomeState();
}

class _ScrollbarPainterHomeState extends State<_ScrollbarPainterHome>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  static const _tabs = <String>[
    'Concept',
    'Anatomy',
    'Live Painter',
    'Thickness & Radius',
    'Colors & Opacity',
    'Orientation',
    'Scrollbar Widget',
    'Summary',
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScrollbarPainter'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        bottom: TabBar(
          controller: _tabCtrl,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _ConceptSection(),
          _AnatomySection(),
          _LivePainterSection(),
          _ThicknessRadiusSection(),
          _ColorsOpacitySection(),
          _OrientationSection(),
          _ScrollbarWidgetSection(),
          _SummarySection(),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 1 — Concept
// ═════════════════════════════════════════════════════════════════════
class _ConceptSection extends StatelessWidget {
  const _ConceptSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'What is ScrollbarPainter?',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 12),
        _buildSBPBullet(
          cs,
          Icons.brush,
          'CustomPainter for Scrollbars',
          'ScrollbarPainter is a CustomPainter that draws a scrollbar '
              'track and thumb. It is used internally by the Scrollbar, '
              'CupertinoScrollbar, and RawScrollbar widgets.',
        ),
        _buildSBPBullet(
          cs,
          Icons.straighten,
          'Driven by ScrollMetrics',
          'The painter reads ScrollMetrics (pixels, minScrollExtent, '
              'maxScrollExtent, viewportDimension) to calculate the '
              'thumb position and size. Call update() with new metrics '
              'whenever the scroll position changes.',
        ),
        _buildSBPBullet(
          cs,
          Icons.palette,
          'Fully Customizable',
          'You can configure: color, trackColor, trackBorderColor, '
              'thickness, radius, crossAxisMargin, mainAxisMargin, '
              'minLength, minOverscrollLength, padding, and more.',
        ),
        _buildSBPBullet(
          cs,
          Icons.visibility,
          'Fade Animation',
          'ScrollbarPainter supports an opacity Animation<double> for '
              'fading the scrollbar in and out. The Scrollbar widget '
              'drives this animation automatically on scroll/idle.',
        ),
        const Divider(height: 32),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.tertiaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.tertiaryContainer),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Direct vs Widget Usage',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.tertiary,
                ),
              ),
              const SizedBox(height: 6),
              _buildUsageLine(
                cs,
                'ScrollbarPainter',
                'Low-level: use when building a completely custom scrollbar. '
                    'You must manage metrics updates and hit testing yourself.',
              ),
              const SizedBox(height: 6),
              _buildUsageLine(
                cs,
                'Scrollbar / RawScrollbar',
                'High-level: wraps your scrollable widget and handles '
                    'everything — metrics, fade animation, drag interaction.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildUsageLine(ColorScheme cs, String title, String desc) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: cs.secondaryContainer,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: cs.onSecondaryContainer,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          desc,
          style: TextStyle(
            fontSize: 12,
            color: cs.onSurface.withOpacity(0.7),
          ),
        ),
      ),
    ],
  );
}

// ═════════════════════════════════════════════════════════════════════
// Section 2 — Anatomy (scrollbar parts)
// ═════════════════════════════════════════════════════════════════════
class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Scrollbar Anatomy',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 16),
        // Visual anatomy
        Container(
          height: 320,
          decoration: BoxDecoration(
            color: cs.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            children: [
              // Main content area
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Scrollable Content\nArea',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: cs.onSurface.withOpacity(0.4),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              // Scrollbar anatomy
              Container(
                width: 100,
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    // Track top
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        alignment: Alignment.center,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'TRACK',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.grey.shade500,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Thumb
                    Container(
                      width: 30,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.brown.shade400,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'THUMB',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.brown.shade50,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    // Track bottom
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(15),
                          ),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Annotations
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _annotationLabel(cs, '← crossAxisMargin'),
                    const SizedBox(height: 12),
                    _annotationLabel(cs, '← thickness'),
                    const SizedBox(height: 12),
                    _annotationLabel(cs, '← radius'),
                    const SizedBox(height: 12),
                    _annotationLabel(cs, '← minLength'),
                    const SizedBox(height: 12),
                    _annotationLabel(cs, '← mainAxisMargin'),
                    const SizedBox(height: 12),
                    _annotationLabel(cs, '← padding'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Property Reference',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildAnatomyProp(cs, 'thickness', 'Width of the scrollbar thumb'),
        _buildAnatomyProp(cs, 'radius', 'Corner rounding of the thumb'),
        _buildAnatomyProp(
            cs, 'crossAxisMargin', 'Space between thumb and edge'),
        _buildAnatomyProp(
            cs, 'mainAxisMargin', 'Space at top/bottom of track'),
        _buildAnatomyProp(cs, 'minLength', 'Minimum thumb length (default 18)'),
        _buildAnatomyProp(
            cs, 'minOverscrollLength', 'Min length during overscroll'),
        _buildAnatomyProp(cs, 'padding', 'EdgeInsets around the entire track'),
      ],
    );
  }
}

Widget _annotationLabel(ColorScheme cs, String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'monospace',
      fontSize: 10,
      color: cs.primary,
    ),
  );
}

Widget _buildAnatomyProp(ColorScheme cs, String prop, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            prop,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: cs.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Section 3 — Live Painter (scrollbar responds to actual scrolling)
// ═════════════════════════════════════════════════════════════════════
class _LivePainterSection extends StatefulWidget {
  const _LivePainterSection();

  @override
  State<_LivePainterSection> createState() => _LivePainterSectionState();
}

class _LivePainterSectionState extends State<_LivePainterSection> {
  final ScrollController _scrollCtrl = ScrollController();
  double _thumbPos = 0;
  int _itemCount = 50;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_updateThumb);
  }

  void _updateThumb() {
    if (_scrollCtrl.hasClients) {
      final pos = _scrollCtrl.position;
      if (pos.maxScrollExtent > 0) {
        setState(() {
          _thumbPos = pos.pixels / pos.maxScrollExtent;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Live Scrollbar Visualization',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Scroll the list to see the custom scrollbar indicator move. '
            'The thumb position tracks the scroll progress.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Custom scrollbar visualization
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 28,
            decoration: BoxDecoration(
              color: cs.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: LayoutBuilder(
              builder: (_, constraints) {
                final thumbWidth = 40.0;
                final maxSlide = constraints.maxWidth - thumbWidth - 4;
                final offset = (_thumbPos * maxSlide).clamp(0.0, maxSlide);
                return Stack(
                  children: [
                    Positioned(
                      left: offset + 2,
                      top: 2,
                      child: Container(
                        width: thumbWidth,
                        height: 24,
                        decoration: BoxDecoration(
                          color: cs.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${(_thumbPos * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: cs.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Item count control
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Items: $_itemCount',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: cs.primary,
                ),
              ),
              const SizedBox(width: 8),
              ActionChip(
                label: const Text('+10', style: TextStyle(fontSize: 11)),
                onPressed: () => setState(() => _itemCount += 10),
                side: BorderSide.none,
                backgroundColor: cs.secondaryContainer,
              ),
              const SizedBox(width: 4),
              ActionChip(
                label: const Text('-10', style: TextStyle(fontSize: 11)),
                onPressed: () {
                  if (_itemCount > 10) {
                    setState(() => _itemCount -= 10);
                  }
                },
                side: BorderSide.none,
                backgroundColor: cs.secondaryContainer,
              ),
              const Spacer(),
              Text(
                'More items = smaller thumb',
                style: TextStyle(
                  fontSize: 11,
                  color: cs.onSurface.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: cs.outlineVariant),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Scrollbar(
                  controller: _scrollCtrl,
                  thumbVisibility: true,
                  thickness: 10,
                  radius: const Radius.circular(5),
                  child: ListView.builder(
                    controller: _scrollCtrl,
                    padding: const EdgeInsets.all(8),
                    itemCount: _itemCount,
                    itemBuilder: (_, i) {
                      final hue = (i * 7.2) % 360;
                      return Container(
                        height: 48,
                        margin: const EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                          color:
                              HSLColor.fromAHSL(1, hue, 0.45, 0.88).toColor(),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          'Item $i',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:
                                HSLColor.fromAHSL(1, hue, 0.6, 0.3).toColor(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 4 — Thickness & Radius
// ═════════════════════════════════════════════════════════════════════
class _ThicknessRadiusSection extends StatefulWidget {
  const _ThicknessRadiusSection();

  @override
  State<_ThicknessRadiusSection> createState() =>
      _ThicknessRadiusSectionState();
}

class _ThicknessRadiusSectionState extends State<_ThicknessRadiusSection> {
  double _thickness = 8;
  double _radius = 4;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Thickness & Radius',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Adjust the scrollbar thickness and corner radius.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Thickness slider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                width: 90,
                child: Text(
                  'Thickness:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
              ),
              Expanded(
                child: Slider(
                  value: _thickness,
                  min: 2,
                  max: 30,
                  divisions: 28,
                  label: '${_thickness.toStringAsFixed(0)}px',
                  onChanged: (v) => setState(() => _thickness = v),
                ),
              ),
              SizedBox(
                width: 45,
                child: Text(
                  '${_thickness.toStringAsFixed(0)}px',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: cs.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Radius slider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                width: 90,
                child: Text(
                  'Radius:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
              ),
              Expanded(
                child: Slider(
                  value: _radius,
                  min: 0,
                  max: 15,
                  divisions: 15,
                  label: '${_radius.toStringAsFixed(0)}px',
                  onChanged: (v) => setState(() => _radius = v),
                ),
              ),
              SizedBox(
                width: 45,
                child: Text(
                  '${_radius.toStringAsFixed(0)}px',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: cs.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        // Side-by-side comparison
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Custom settings
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Custom',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: cs.onPrimaryContainer,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: cs.primary.withOpacity(0.2)),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                            child: ScrollbarTheme(
                              data: ScrollbarThemeData(
                                thickness: WidgetStatePropertyAll(_thickness),
                                radius: Radius.circular(_radius),
                                thumbVisibility:
                                    const WidgetStatePropertyAll(true),
                              ),
                              child: Scrollbar(
                                child: ListView.builder(
                                  itemCount: 40,
                                  itemBuilder: (_, i) => _buildThumbItem(cs, i),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Default
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: cs.tertiaryContainer,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Default (8px / 4px)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: cs.onTertiaryContainer,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: cs.tertiary.withOpacity(0.2)),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                            child: ScrollbarTheme(
                              data: const ScrollbarThemeData(
                                thumbVisibility:
                                    WidgetStatePropertyAll(true),
                              ),
                              child: Scrollbar(
                                child: ListView.builder(
                                  itemCount: 40,
                                  itemBuilder: (_, i) => _buildThumbItem(cs, i),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildThumbItem(ColorScheme cs, int i) {
    final hue = (i * 9.0) % 360;
    return Container(
      height: 40,
      margin: const EdgeInsets.fromLTRB(4, 2, 12, 2),
      decoration: BoxDecoration(
        color: HSLColor.fromAHSL(1, hue, 0.4, 0.9).toColor(),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        'Row $i',
        style: TextStyle(
          fontSize: 12,
          color: HSLColor.fromAHSL(1, hue, 0.5, 0.35).toColor(),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 5 — Colors & Opacity
// ═════════════════════════════════════════════════════════════════════
class _ColorsOpacitySection extends StatefulWidget {
  const _ColorsOpacitySection();

  @override
  State<_ColorsOpacitySection> createState() => _ColorsOpacitySectionState();
}

class _ColorsOpacitySectionState extends State<_ColorsOpacitySection> {
  int _selectedColor = 0;
  bool _showTrack = true;

  static const _colorPresets = <String, Color>{
    'Brown': Colors.brown,
    'Blue': Colors.blue,
    'Red': Colors.red,
    'Green': Colors.green,
    'Purple': Colors.purple,
    'Orange': Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final entries = _colorPresets.entries.toList();
    final selectedColor = entries[_selectedColor].value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Colors & Track Visibility',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Choose a thumb color and toggle track visibility.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Color chips
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              for (int i = 0; i < entries.length; i++)
                ChoiceChip(
                  label: Text(entries[i].key),
                  selected: _selectedColor == i,
                  onSelected: (_) => setState(() => _selectedColor = i),
                  avatar: CircleAvatar(
                    backgroundColor: entries[i].value,
                    radius: 10,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FilterChip(
            label: const Text('Show Track'),
            selected: _showTrack,
            onSelected: (v) => setState(() => _showTrack = v),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: cs.outlineVariant),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ScrollbarTheme(
                  data: ScrollbarThemeData(
                    thumbColor: WidgetStatePropertyAll(selectedColor),
                    trackColor: _showTrack
                        ? WidgetStatePropertyAll(
                            selectedColor.withOpacity(0.1))
                        : const WidgetStatePropertyAll(Colors.transparent),
                    trackBorderColor: _showTrack
                        ? WidgetStatePropertyAll(
                            selectedColor.withOpacity(0.2))
                        : const WidgetStatePropertyAll(Colors.transparent),
                    trackVisibility:
                        WidgetStatePropertyAll(_showTrack),
                    thumbVisibility: const WidgetStatePropertyAll(true),
                    thickness: const WidgetStatePropertyAll(12.0),
                    radius: const Radius.circular(6),
                  ),
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (_, i) {
                        return Container(
                          height: 48,
                          margin: const EdgeInsets.fromLTRB(6, 2, 18, 2),
                          decoration: BoxDecoration(
                            color: selectedColor.withOpacity(
                              0.05 + (i % 5) * 0.04,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            'Item $i',
                            style: TextStyle(
                              fontSize: 13,
                              color: selectedColor.withOpacity(0.7),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 6 — Orientation (vertical vs horizontal)
// ═════════════════════════════════════════════════════════════════════
class _OrientationSection extends StatelessWidget {
  const _OrientationSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Vertical vs Horizontal Scrollbars',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 8),
        Text(
          'ScrollbarPainter supports both orientations. The thumb '
          'direction matches the scroll axis automatically.',
          style: TextStyle(
            fontSize: 13,
            color: cs.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 16),
        // Vertical
        Text(
          'Vertical Scrollbar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: cs.tertiary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 160,
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ScrollbarTheme(
              data: const ScrollbarThemeData(
                thumbVisibility: WidgetStatePropertyAll(true),
                thickness: WidgetStatePropertyAll(8.0),
              ),
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (_, i) => Container(
                    height: 36,
                    margin: const EdgeInsets.fromLTRB(6, 2, 14, 2),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Vertical item $i',
                      style:
                          TextStyle(fontSize: 12, color: Colors.indigo.shade600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Horizontal
        Text(
          'Horizontal Scrollbar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: cs.tertiary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ScrollbarTheme(
              data: const ScrollbarThemeData(
                thumbVisibility: WidgetStatePropertyAll(true),
                thickness: WidgetStatePropertyAll(8.0),
              ),
              child: Scrollbar(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: (_, i) {
                    final hue = (i * 12.0) % 360;
                    return Container(
                      width: 90,
                      margin: const EdgeInsets.fromLTRB(3, 6, 3, 14),
                      decoration: BoxDecoration(
                        color:
                            HSLColor.fromAHSL(1, hue, 0.5, 0.85).toColor(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'H-$i',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              HSLColor.fromAHSL(1, hue, 0.6, 0.3).toColor(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: cs.primary, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'ScrollbarPainter determines orientation from the '
                  'ScrollMetrics.axisDirection. When scrollDirection is '
                  'Axis.horizontal, the thumb appears at the bottom. '
                  'When vertical, it appears on the right (or left for RTL).',
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 7 — Scrollbar Widget (high-level usage)
// ═════════════════════════════════════════════════════════════════════
class _ScrollbarWidgetSection extends StatelessWidget {
  const _ScrollbarWidgetSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Scrollbar Widget Variants',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 8),
        Text(
          'The Scrollbar widget uses ScrollbarPainter internally. '
          'Here are the different scrollbar widgets available:',
          style: TextStyle(
            fontSize: 13,
            color: cs.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 16),
        _buildScrollbarVariant(
          cs,
          'Scrollbar',
          'Material Design scrollbar. Adapts to the current theme. '
              'Shows on scroll, fades after inactivity. On desktop, '
              'can be dragged interactively.',
          Icons.linear_scale,
          Colors.blue,
        ),
        _buildScrollbarVariant(
          cs,
          'CupertinoScrollbar',
          'iOS-style scrollbar with thin, rounded thumb. Fades '
              'automatically. Appears slimmer and more subtle than '
              'the Material variant.',
          Icons.phone_iphone,
          Colors.grey,
        ),
        _buildScrollbarVariant(
          cs,
          'RawScrollbar',
          'Base scrollbar widget without platform-specific styling. '
              'Use this for complete control over appearance. Configure '
              'every property that ScrollbarPainter exposes.',
          Icons.settings,
          Colors.purple,
        ),
        const Divider(height: 28),
        Text(
          'Scrollbar Properties',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildSBPropRow(cs, 'thumbVisibility', 'Always show thumb (bool?)'),
        _buildSBPropRow(cs, 'trackVisibility', 'Always show track (bool?)'),
        _buildSBPropRow(cs, 'thickness', 'Scrollbar thickness (double?)'),
        _buildSBPropRow(cs, 'radius', 'Thumb corner radius (Radius?)'),
        _buildSBPropRow(cs, 'interactive', 'Accept drag gestures (bool?)'),
        _buildSBPropRow(cs, 'controller', 'Link to a ScrollController'),
        _buildSBPropRow(
            cs, 'scrollbarOrientation', 'Override orientation (left/right/top/bottom)'),
        _buildSBPropRow(
            cs, 'notificationPredicate', 'Filter which notifications to track'),
        const SizedBox(height: 16),
        // ScrollbarTheme
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.secondaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ScrollbarTheme',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.onSecondaryContainer,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Use ScrollbarThemeData in your ThemeData to globally '
                'configure scrollbar appearance across all Scrollbar '
                'widgets in the app. Properties include thumbColor, '
                'trackColor, trackBorderColor, thickness, radius, '
                'crossAxisMargin, mainAxisMargin, and more.',
                style: TextStyle(
                  fontSize: 12,
                  color: cs.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildScrollbarVariant(
  ColorScheme cs,
  String title,
  String description,
  IconData icon,
  Color accent,
) {
  return Card(
    margin: const EdgeInsets.only(bottom: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSBPropRow(ColorScheme cs, String prop, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            prop,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: cs.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Section 8 — Summary
// ═════════════════════════════════════════════════════════════════════
class _SummarySection extends StatelessWidget {
  const _SummarySection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'ScrollbarPainter Summary',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 16),
        _buildSBPBullet(
          cs,
          Icons.brush,
          'CustomPainter Foundation',
          'ScrollbarPainter is a CustomPainter that draws the scrollbar '
              'track and thumb based on ScrollMetrics provided via update().',
        ),
        _buildSBPBullet(
          cs,
          Icons.tune,
          'Fully Configurable',
          'thickness, radius, color, trackColor, crossAxisMargin, '
              'mainAxisMargin, minLength, padding — every visual aspect '
              'is tunable.',
        ),
        _buildSBPBullet(
          cs,
          Icons.swap_vert,
          'Orientation Auto-Detection',
          'The painter determines horizontal/vertical orientation from '
              'ScrollMetrics.axisDirection automatically.',
        ),
        _buildSBPBullet(
          cs,
          Icons.animation,
          'Fade Animation',
          'Supports an Animation<double> for opacity. The Scrollbar '
              'widget drives this fade-in/fade-out automatically.',
        ),
        _buildSBPBullet(
          cs,
          Icons.linear_scale,
          'Scrollbar Widget',
          'For most use cases, use the Scrollbar widget (Material), '
              'CupertinoScrollbar (iOS), or RawScrollbar (custom). '
              'They manage ScrollbarPainter internally.',
        ),
        _buildSBPBullet(
          cs,
          Icons.palette,
          'Theme Integration',
          'Use ScrollbarThemeData in ThemeData to globally configure '
              'all scrollbar appearances. Supports WidgetStateProperty '
              'for interactive states (hover, drag).',
        ),
        const Divider(height: 32),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cs.primaryContainer.withOpacity(0.5),
                cs.tertiaryContainer.withOpacity(0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 32, color: cs.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ScrollbarPainter is the engine behind every scrollbar '
                  'in Flutter. While you rarely interact with it directly, '
                  'understanding its properties lets you theme and customize '
                  'scrollbars precisely — from subtle thin indicators to '
                  'thick interactive tracks with custom colors.',
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Shared helpers (prefixed _buildSBP to avoid collisions)
// ─────────────────────────────────────────────────────────────────────
Widget _buildSBPBullet(
  ColorScheme cs,
  IconData icon,
  String title,
  String body,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: cs.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                body,
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
