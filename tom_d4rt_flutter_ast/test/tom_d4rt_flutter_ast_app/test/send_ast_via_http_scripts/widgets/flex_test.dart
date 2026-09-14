// Deep visual demo: Flex - the MultiChildRenderObjectWidget that is the shared
// base of Row and Column. When `Axis` itself needs to be a parameter, Flex is
// the widget you reach for. Row is Flex(direction: Axis.horizontal); Column is
// Flex(direction: Axis.vertical).
//
// Manually authored. STATELESS ONLY. A handful of top-level ValueNotifiers and
// ValueListenableBuilders drive the live examples. No StatefulWidget anywhere
// in this file. No main(), no runApp(), no print().
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Top-level state (consumed by stateless widgets via ValueListenableBuilder).
// ═══════════════════════════════════════════════════════════════════════════

final ValueNotifier<Axis> _directionNotifier = ValueNotifier<Axis>(Axis.horizontal);
final ValueNotifier<MainAxisAlignment> _mainSpotlight =
    ValueNotifier<MainAxisAlignment>(MainAxisAlignment.spaceBetween);
final ValueNotifier<CrossAxisAlignment> _crossSpotlight =
    ValueNotifier<CrossAxisAlignment>(CrossAxisAlignment.center);
final ValueNotifier<MainAxisSize> _sizeSpotlight =
    ValueNotifier<MainAxisSize>(MainAxisSize.max);
final ValueNotifier<TextDirection> _textDirectionNotifier =
    ValueNotifier<TextDirection>(TextDirection.ltr);
final ValueNotifier<VerticalDirection> _verticalDirectionNotifier =
    ValueNotifier<VerticalDirection>(VerticalDirection.down);
final ValueNotifier<int> _responsiveBreakpoint = ValueNotifier<int>(768);

// ═══════════════════════════════════════════════════════════════════════════
// Palette (deliberately understated so the layout geometry pops).
// ═══════════════════════════════════════════════════════════════════════════

const Color _seed = Color(0xFF4F46E5);
const Color _ink = Color(0xFF111827);
const Color _paper = Color(0xFFF8FAFC);
const Color _frame = Color(0xFFE2E8F0);
const Color _muted = Color(0xFF64748B);
const Color _accentA = Color(0xFF4F46E5);
const Color _accentB = Color(0xFF0EA5E9);
const Color _accentC = Color(0xFFF59E0B);
const Color _accentD = Color(0xFFEF4444);
const Color _accentE = Color(0xFF10B981);
const Color _accentF = Color(0xFFEC4899);

// ═══════════════════════════════════════════════════════════════════════════
// Entry point.
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) => const _FlexDeepDemoApp();

class _FlexDeepDemoApp extends StatelessWidget {
  const _FlexDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: _seed);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: _paper,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontWeight: FontWeight.w800, color: _ink),
          titleLarge: TextStyle(fontWeight: FontWeight.w700, color: _ink),
          titleMedium: TextStyle(fontWeight: FontWeight.w600, color: _ink),
          bodyMedium: TextStyle(height: 1.38, color: _ink),
          labelLarge: TextStyle(fontWeight: FontWeight.w600),
        ),
        dividerColor: _frame,
      ),
      home: const _FlexDeepDemoHome(),
    );
  }
}

class _FlexDeepDemoHome extends StatelessWidget {
  const _FlexDeepDemoHome();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          title: const Text('Flex - Deep Visual Demo'),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: <Tab>[
              Tab(icon: Icon(Icons.auto_awesome_outlined), text: 'Hero'),
              Tab(icon: Icon(Icons.swap_horiz_outlined), text: 'Direction'),
              Tab(icon: Icon(Icons.align_horizontal_left_outlined), text: 'Main'),
              Tab(icon: Icon(Icons.align_vertical_center_outlined), text: 'Cross'),
              Tab(icon: Icon(Icons.unfold_less_outlined), text: 'Size'),
              Tab(icon: Icon(Icons.view_stream_outlined), text: 'Expanded'),
              Tab(icon: Icon(Icons.swap_vert_outlined), text: 'Direction Matrix'),
              Tab(icon: Icon(Icons.text_fields_outlined), text: 'Baseline'),
              Tab(icon: Icon(Icons.menu_book_outlined), text: 'More'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _DirectionTab(),
            _MainAxisAlignmentTab(),
            _CrossAxisAlignmentTab(),
            _MainAxisSizeTab(),
            _ExpandedFlexibleTab(),
            _DirectionMatrixTab(),
            _BaselineTab(),
            _MoreTab(),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared primitives.
// ═══════════════════════════════════════════════════════════════════════════

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: _muted),
          ),
          const SizedBox(height: 22),
          child,
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 10),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
    this.background = const Color(0xFFE0E7FF),
    this.foreground = const Color(0xFF312E81),
  });

  final IconData icon;
  final String title;
  final String body;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: foreground.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: foreground),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: foreground),
                ),
                const SizedBox(height: 4),
                Text(body, style: TextStyle(color: foreground, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color, this.dark = false});

  final String label;
  final Color color;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: dark ? 1 : 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: dark ? Colors.white : color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({
    required this.label,
    required this.color,
    this.width = 56,
    this.height = 56,
    this.fontSize = 14,
  });

  final String label;
  final Color color;
  final double width;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class _FrameCard extends StatelessWidget {
  const _FrameCard({required this.title, required this.note, required this.child});

  final String title;
  final String note;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _frame),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0F111827),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(note, style: const TextStyle(fontSize: 12, color: _muted, height: 1.35)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 1 — Hero banner.
// ═══════════════════════════════════════════════════════════════════════════

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Meet Flex',
      subtitle:
          'The MultiChildRenderObjectWidget that is the shared base of Row and Column. '
          'When the axis itself is a parameter, Flex is the widget you reach for.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[_accentA, _accentB],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.swap_horiz, color: Colors.white, size: 34),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Flex',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'class Flex extends MultiChildRenderObjectWidget',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'A single widget captures the essence of both Row and Column. Row is '
                  'Flex(direction: Axis.horizontal); Column is Flex(direction: Axis.vertical). '
                  'Everything else (main/cross alignment, main size, text direction, vertical '
                  'direction, text baseline, clip behavior) applies identically.',
                  style: TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const <Widget>[
                    _Chip(label: 'direction: Axis', color: Colors.white, dark: false),
                    _Chip(label: 'mainAxisAlignment', color: Colors.white, dark: false),
                    _Chip(label: 'crossAxisAlignment', color: Colors.white, dark: false),
                    _Chip(label: 'mainAxisSize', color: Colors.white, dark: false),
                    _Chip(label: 'textDirection', color: Colors.white, dark: false),
                    _Chip(label: 'verticalDirection', color: Colors.white, dark: false),
                    _Chip(label: 'textBaseline', color: Colors.white, dark: false),
                    _Chip(label: 'clipBehavior', color: Colors.white, dark: false),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _InfoCard(
            icon: Icons.lightbulb_outline,
            title: 'When to reach for Flex',
            body:
                'Use Flex directly when the axis needs to be parameterized at runtime - for '
                'example, a reusable card whose children arrange horizontally on wide screens '
                'and vertically on narrow ones. In every other case, prefer Row or Column '
                'for clearer intent.',
            background: scheme.secondaryContainer,
            foreground: scheme.onSecondaryContainer,
          ),
          const SizedBox(height: 14),
          _InfoCard(
            icon: Icons.account_tree_outlined,
            title: 'Render object',
            body:
                'Flex creates RenderFlex, which performs a two-pass layout: first laying out '
                'inflexible children with their own constraints, then distributing remaining '
                'main-axis space to Expanded / Flexible children according to their flex factor.',
            background: scheme.tertiaryContainer,
            foreground: scheme.onTertiaryContainer,
          ),
          const SizedBox(height: 14),
          _InfoCard(
            icon: Icons.layers_outlined,
            title: 'Ancestry',
            body:
                'Row extends Flex with direction fixed to Axis.horizontal. Column extends '
                'Flex with direction fixed to Axis.vertical. Both inherit every other Flex '
                'parameter unchanged.',
            background: const Color(0xFFFCE7F3),
            foreground: const Color(0xFF831843),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 2 — Direction toggle.
// ═══════════════════════════════════════════════════════════════════════════

class _DirectionTab extends StatelessWidget {
  const _DirectionTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Direction: Axis.horizontal vs Axis.vertical',
      subtitle:
          'A single Flex driven by a ValueNotifier<Axis>. The children never change - only '
          'direction does. Watch the same cards flip from a Row-like to Column-like layout.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder<Axis>(
            valueListenable: _directionNotifier,
            builder: (BuildContext context, Axis direction, Widget? child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SegmentedButton<Axis>(
                    segments: const <ButtonSegment<Axis>>[
                      ButtonSegment<Axis>(
                        value: Axis.horizontal,
                        label: Text('Axis.horizontal'),
                        icon: Icon(Icons.swap_horiz),
                      ),
                      ButtonSegment<Axis>(
                        value: Axis.vertical,
                        label: Text('Axis.vertical'),
                        icon: Icon(Icons.swap_vert),
                      ),
                    ],
                    selected: <Axis>{direction},
                    onSelectionChanged: (Set<Axis> values) {
                      _directionNotifier.value = values.first;
                    },
                  ),
                  const SizedBox(height: 20),
                  _FrameCard(
                    title: direction == Axis.horizontal ? 'Flex (horizontal)' : 'Flex (vertical)',
                    note: 'Same children. Only `direction:` changed.',
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _paper,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _frame),
                      ),
                      child: _PivotFlex(direction: direction),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _PivotExplainer(direction: direction),
                ],
              );
            },
          ),
          const _SectionHeading(text: 'The parameter that matters'),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Flex(\n'
              '  direction: Axis.horizontal,   // flip to Axis.vertical\n'
              '  mainAxisAlignment: MainAxisAlignment.spaceBetween,\n'
              '  crossAxisAlignment: CrossAxisAlignment.center,\n'
              '  children: <Widget>[A, B, C],\n'
              ')',
              style: TextStyle(
                color: Color(0xFFE2E8F0),
                fontFamily: 'monospace',
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const _InfoCard(
            icon: Icons.compare_arrows,
            title: 'Identical behavior to Row/Column',
            body:
                'Setting direction: Axis.horizontal is exactly equivalent to using a Row. '
                'Setting direction: Axis.vertical is exactly equivalent to using a Column. '
                'The advantage of Flex is that the axis is a runtime value.',
            background: Color(0xFFFEF3C7),
            foreground: Color(0xFF78350F),
          ),
        ],
      ),
    );
  }
}

class _PivotFlex extends StatelessWidget {
  const _PivotFlex({required this.direction});
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = <Widget>[
      const _Box(label: 'A', color: _accentA, width: 72, height: 60),
      const _Box(label: 'B', color: _accentB, width: 72, height: 60),
      const _Box(label: 'C', color: _accentC, width: 72, height: 60),
      const _Box(label: 'D', color: _accentE, width: 72, height: 60),
    ];
    return SizedBox(
      height: direction == Axis.horizontal ? 96 : 320,
      child: Flex(
        direction: direction,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items,
      ),
    );
  }
}

class _PivotExplainer extends StatelessWidget {
  const _PivotExplainer({required this.direction});
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final bool horizontal = direction == Axis.horizontal;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _frame),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            horizontal ? Icons.east : Icons.south,
            size: 32,
            color: _accentA,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  horizontal
                      ? 'Main axis flows left to right (east).'
                      : 'Main axis flows top to bottom (south).',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  horizontal
                      ? 'Cross axis runs vertically. Flex height is decided by children.'
                      : 'Cross axis runs horizontally. Flex width is decided by children.',
                  style: const TextStyle(color: _muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 3 — mainAxisAlignment gallery (six cards).
// ═══════════════════════════════════════════════════════════════════════════

class _MainAxisAlignmentTab extends StatelessWidget {
  const _MainAxisAlignmentTab();

  @override
  Widget build(BuildContext context) {
    const List<_MainSample> samples = <_MainSample>[
      _MainSample(
        value: MainAxisAlignment.start,
        title: 'MainAxisAlignment.start',
        note: 'Children clustered at the leading edge. Free space sits after them.',
      ),
      _MainSample(
        value: MainAxisAlignment.end,
        title: 'MainAxisAlignment.end',
        note: 'Children clustered at the trailing edge. Free space sits before them.',
      ),
      _MainSample(
        value: MainAxisAlignment.center,
        title: 'MainAxisAlignment.center',
        note: 'Children centered as a single group. Equal free space on each side.',
      ),
      _MainSample(
        value: MainAxisAlignment.spaceBetween,
        title: 'MainAxisAlignment.spaceBetween',
        note: 'First and last pinned to the edges. Equal gaps between interior items.',
      ),
      _MainSample(
        value: MainAxisAlignment.spaceAround,
        title: 'MainAxisAlignment.spaceAround',
        note: 'Equal gap around each child. Edge gaps are half of interior gaps.',
      ),
      _MainSample(
        value: MainAxisAlignment.spaceEvenly,
        title: 'MainAxisAlignment.spaceEvenly',
        note: 'All gaps - including the edges - are the same size.',
      ),
    ];

    return _Section(
      title: 'mainAxisAlignment gallery',
      subtitle:
          'How free space along the main axis is distributed. Each card uses Flex(direction: '
          'Axis.horizontal) with identical children, differing only in mainAxisAlignment.',
      child: Column(
        children: <Widget>[
          ValueListenableBuilder<MainAxisAlignment>(
            valueListenable: _mainSpotlight,
            builder: (BuildContext context, MainAxisAlignment spotlight, Widget? child) {
              return _FrameCard(
                title: 'Spotlight: ${spotlight.name}',
                note:
                    'Tap any card below to put it in the spotlight. The large preview uses '
                    'that value so differences in gap size are easy to see at scale.',
                child: Container(
                  height: 96,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: _paper,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _frame),
                  ),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: spotlight,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      _Box(label: '1', color: _accentA, width: 56, height: 56),
                      _Box(label: '2', color: _accentB, width: 56, height: 56),
                      _Box(label: '3', color: _accentC, width: 56, height: 56),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int columns = constraints.maxWidth > 720 ? 3 : (constraints.maxWidth > 440 ? 2 : 1);
              final double spacing = 14;
              final double width = (constraints.maxWidth - spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: <Widget>[
                  for (final _MainSample sample in samples)
                    SizedBox(
                      width: width,
                      child: _MainAxisCard(sample: sample),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          const _InfoCard(
            icon: Icons.straighten_outlined,
            title: 'Ruler overlay',
            body:
                'Each card shows a ruler beneath the Flex to make the gap distribution '
                'literally visible. The ticks are spaced in tens so you can compare sizes.',
            background: Color(0xFFDBEAFE),
            foreground: Color(0xFF1E3A8A),
          ),
        ],
      ),
    );
  }
}

class _MainSample {
  const _MainSample({required this.value, required this.title, required this.note});
  final MainAxisAlignment value;
  final String title;
  final String note;
}

class _MainAxisCard extends StatelessWidget {
  const _MainAxisCard({required this.sample});
  final _MainSample sample;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _mainSpotlight.value = sample.value,
      child: _FrameCard(
        title: sample.title,
        note: sample.note,
        child: Column(
          children: <Widget>[
            Container(
              height: 76,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: _paper,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _frame),
              ),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: sample.value,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  _Box(label: '1', color: _accentA, width: 40, height: 40, fontSize: 12),
                  _Box(label: '2', color: _accentB, width: 40, height: 40, fontSize: 12),
                  _Box(label: '3', color: _accentC, width: 40, height: 40, fontSize: 12),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const _Ruler(),
          ],
        ),
      ),
    );
  }
}

class _Ruler extends StatelessWidget {
  const _Ruler();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: CustomPaint(
        size: const Size(double.infinity, 16),
        painter: _RulerPainter(),
      ),
    );
  }
}

class _RulerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint axis = Paint()
      ..color = _muted
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), axis);
    const double step = 10;
    final int ticks = (size.width / step).floor();
    for (int i = 0; i <= ticks; i++) {
      final double x = i * step;
      final bool major = i % 5 == 0;
      canvas.drawLine(
        Offset(x, size.height / 2 - (major ? 5 : 3)),
        Offset(x, size.height / 2 + (major ? 5 : 3)),
        axis,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RulerPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 4 — crossAxisAlignment gallery (five cards).
// ═══════════════════════════════════════════════════════════════════════════

class _CrossAxisAlignmentTab extends StatelessWidget {
  const _CrossAxisAlignmentTab();

  @override
  Widget build(BuildContext context) {
    const List<_CrossSample> samples = <_CrossSample>[
      _CrossSample(
        value: CrossAxisAlignment.start,
        title: 'CrossAxisAlignment.start',
        note: 'Children hug the top of the cross axis (for Axis.horizontal).',
      ),
      _CrossSample(
        value: CrossAxisAlignment.end,
        title: 'CrossAxisAlignment.end',
        note: 'Children hug the bottom of the cross axis.',
      ),
      _CrossSample(
        value: CrossAxisAlignment.center,
        title: 'CrossAxisAlignment.center',
        note: 'Children centered along the cross axis. The default.',
      ),
      _CrossSample(
        value: CrossAxisAlignment.stretch,
        title: 'CrossAxisAlignment.stretch',
        note: 'Children forced to fill the cross axis completely.',
      ),
      _CrossSample(
        value: CrossAxisAlignment.baseline,
        title: 'CrossAxisAlignment.baseline',
        note: 'Text baselines aligned - requires a textBaseline.',
      ),
    ];

    return _Section(
      title: 'crossAxisAlignment gallery',
      subtitle:
          'How children line up perpendicular to the main axis. In a horizontal Flex, the '
          'cross axis is vertical; in a vertical Flex, the cross axis is horizontal.',
      child: Column(
        children: <Widget>[
          ValueListenableBuilder<CrossAxisAlignment>(
            valueListenable: _crossSpotlight,
            builder: (BuildContext context, CrossAxisAlignment spotlight, Widget? child) {
              final bool isBaseline = spotlight == CrossAxisAlignment.baseline;
              return _FrameCard(
                title: 'Spotlight: ${spotlight.name}',
                note:
                    'Boxes have deliberately mixed heights to make cross-axis positioning '
                    'visible. Baseline mode aligns the text, not the box.',
                child: Container(
                  height: 130,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _paper,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _frame),
                  ),
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: spotlight,
                    textBaseline: isBaseline ? TextBaseline.alphabetic : null,
                    children: <Widget>[
                      _VaryingBox(height: 48, label: 'small', color: _accentA),
                      const SizedBox(width: 14),
                      _VaryingBox(height: 78, label: 'medium', color: _accentB),
                      const SizedBox(width: 14),
                      _VaryingBox(height: 104, label: 'tall', color: _accentC),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int columns = constraints.maxWidth > 720 ? 3 : (constraints.maxWidth > 440 ? 2 : 1);
              final double spacing = 14;
              final double width = (constraints.maxWidth - spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: <Widget>[
                  for (final _CrossSample sample in samples)
                    SizedBox(
                      width: width,
                      child: _CrossAxisCard(sample: sample),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          const _InfoCard(
            icon: Icons.open_in_full,
            title: 'About CrossAxisAlignment.stretch',
            body:
                'Stretch gives each child unbounded cross-axis constraints equal to the Flex '
                'own cross-axis size. That forces fixed-cross-size widgets (Container with '
                'height or width) to coexist with the stretch by using BoxDecoration fill.',
            background: Color(0xFFDCFCE7),
            foreground: Color(0xFF14532D),
          ),
        ],
      ),
    );
  }
}

class _CrossSample {
  const _CrossSample({required this.value, required this.title, required this.note});
  final CrossAxisAlignment value;
  final String title;
  final String note;
}

class _CrossAxisCard extends StatelessWidget {
  const _CrossAxisCard({required this.sample});
  final _CrossSample sample;

  @override
  Widget build(BuildContext context) {
    final bool isBaseline = sample.value == CrossAxisAlignment.baseline;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _crossSpotlight.value = sample.value,
      child: _FrameCard(
        title: sample.title,
        note: sample.note,
        child: Container(
          height: 108,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _paper,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _frame),
          ),
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: sample.value,
            textBaseline: isBaseline ? TextBaseline.alphabetic : null,
            children: <Widget>[
              _VaryingBox(height: 40, label: 's', color: _accentA),
              const SizedBox(width: 8),
              _VaryingBox(height: 58, label: 'm', color: _accentB),
              const SizedBox(width: 8),
              _VaryingBox(height: 82, label: 'l', color: _accentC),
            ],
          ),
        ),
      ),
    );
  }
}

class _VaryingBox extends StatelessWidget {
  const _VaryingBox({required this.height, required this.label, required this.color});

  final double height;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 5 — mainAxisSize playground (max vs min).
// ═══════════════════════════════════════════════════════════════════════════

class _MainAxisSizeTab extends StatelessWidget {
  const _MainAxisSizeTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'mainAxisSize: max vs min',
      subtitle:
          'max makes the Flex expand to fill the main axis of its parent. min shrinks it to '
          'just enough room for the children. Same children - dramatically different footprints.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder<MainAxisSize>(
            valueListenable: _sizeSpotlight,
            builder: (BuildContext context, MainAxisSize spotlight, Widget? child) {
              return SegmentedButton<MainAxisSize>(
                segments: const <ButtonSegment<MainAxisSize>>[
                  ButtonSegment<MainAxisSize>(
                    value: MainAxisSize.max,
                    label: Text('MainAxisSize.max'),
                    icon: Icon(Icons.open_in_full),
                  ),
                  ButtonSegment<MainAxisSize>(
                    value: MainAxisSize.min,
                    label: Text('MainAxisSize.min'),
                    icon: Icon(Icons.close_fullscreen),
                  ),
                ],
                selected: <MainAxisSize>{spotlight},
                onSelectionChanged: (Set<MainAxisSize> values) {
                  _sizeSpotlight.value = values.first;
                },
              );
            },
          ),
          const SizedBox(height: 18),
          _FrameCard(
            title: 'Side-by-side comparison',
            note:
                'Both Flexes hold the same three boxes. The left Flex uses MainAxisSize.max '
                'so it consumes the column width. The right Flex uses MainAxisSize.min so it '
                'is exactly as wide as its content.',
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double halfWidth = (constraints.maxWidth - 14) / 2;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: halfWidth,
                      child: _SizeBox(
                        label: 'MainAxisSize.max',
                        sub: 'takes all main-axis space',
                        mainSize: MainAxisSize.max,
                        color: _accentA,
                      ),
                    ),
                    const SizedBox(width: 14),
                    SizedBox(
                      width: halfWidth,
                      child: _SizeBox(
                        label: 'MainAxisSize.min',
                        sub: 'hugs the children',
                        mainSize: MainAxisSize.min,
                        color: _accentE,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          ValueListenableBuilder<MainAxisSize>(
            valueListenable: _sizeSpotlight,
            builder: (BuildContext context, MainAxisSize spotlight, Widget? child) {
              return _FrameCard(
                title: 'Spotlight: ${spotlight.name}',
                note:
                    'The Flex container (outlined) is whatever size the mainAxisSize demands. '
                    'Observe how much space it leaves - or does not leave - around the children.',
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _paper,
                    border: Border.all(color: _frame),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: _accentA, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: spotlight,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          _Box(label: 'x', color: _accentA, width: 50, height: 44),
                          SizedBox(width: 10),
                          _Box(label: 'y', color: _accentB, width: 50, height: 44),
                          SizedBox(width: 10),
                          _Box(label: 'z', color: _accentC, width: 50, height: 44),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          const _InfoCard(
            icon: Icons.info_outline,
            title: 'Interaction with Expanded',
            body:
                'Expanded children only make sense when mainAxisSize is .max. Inside a .min '
                'Flex, Expanded still fills remaining space, but since there is no extra main-'
                'axis space to distribute, Expanded collapses to its minimum size.',
            background: Color(0xFFFFE4E6),
            foreground: Color(0xFF881337),
          ),
        ],
      ),
    );
  }
}

class _SizeBox extends StatelessWidget {
  const _SizeBox({
    required this.label,
    required this.sub,
    required this.mainSize,
    required this.color,
  });

  final String label;
  final String sub;
  final MainAxisSize mainSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _frame),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(label, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 4),
          Text(sub, style: const TextStyle(color: _muted, fontSize: 12)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: mainSize,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                _Box(label: 'a', color: _accentA, width: 40, height: 36, fontSize: 12),
                SizedBox(width: 8),
                _Box(label: 'b', color: _accentB, width: 40, height: 36, fontSize: 12),
                SizedBox(width: 8),
                _Box(label: 'c', color: _accentC, width: 40, height: 36, fontSize: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 6 — Expanded / Flexible showcase.
// ═══════════════════════════════════════════════════════════════════════════

class _ExpandedFlexibleTab extends StatelessWidget {
  const _ExpandedFlexibleTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Expanded and Flexible inside Flex',
      subtitle:
          'Flex performs layout in two passes: inflexible children first, then leftover space '
          'is distributed according to flex factors. Expanded forces fill; Flexible allows '
          'loose fit.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _FrameCard(
            title: 'Recipe: fixed + Expanded(2) + Expanded(1) + Flexible(loose)',
            note:
                'Each colored band below is one child. The width ratio of the two Expanded '
                'children is 2:1 after the fixed child takes its space. The Flexible child '
                'with FlexFit.loose occupies at most its preferred 80 logical pixels.',
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _paper,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _frame),
              ),
              child: SizedBox(
                height: 80,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    _ExpandedLegend(
                      color: _accentA,
                      title: 'fixed',
                      width: 80,
                      note: 'SizedBox(width: 80)',
                    ),
                    Expanded(
                      flex: 2,
                      child: _ExpandedLegend(
                        color: _accentB,
                        title: 'Expanded',
                        flex: 2,
                        note: 'flex: 2 - fills remaining',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: _ExpandedLegend(
                        color: _accentC,
                        title: 'Expanded',
                        flex: 1,
                        note: 'flex: 1 - half of the Expanded(2)',
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: _ExpandedLegend(
                        color: _accentF,
                        title: 'Flexible',
                        note: 'FlexFit.loose, max 80',
                        width: 80,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const _SectionHeading(text: 'Two flavors of flexibility'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: _FlexFitCard(
                  fit: FlexFit.tight,
                  title: 'Expanded (FlexFit.tight)',
                  description:
                      'Forces the child to fill the allotted space exactly. '
                      'Child must accept unbounded main-axis constraints.',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _FlexFitCard(
                  fit: FlexFit.loose,
                  title: 'Flexible (FlexFit.loose)',
                  description:
                      'Lets the child decide its own size up to the allotted space. '
                      'Unused space reverts to the parent Flex.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _FrameCard(
            title: 'Visual: changing the flex factor',
            note: 'Three flex factors side by side make the 1:2:3 proportion obvious.',
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _paper,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _frame),
              ),
              child: SizedBox(
                height: 60,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(flex: 1, child: _RatioBar(label: '1', color: _accentA)),
                    SizedBox(width: 6),
                    Expanded(flex: 2, child: _RatioBar(label: '2', color: _accentB)),
                    SizedBox(width: 6),
                    Expanded(flex: 3, child: _RatioBar(label: '3', color: _accentC)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const _InfoCard(
            icon: Icons.tune,
            title: 'The two-pass algorithm',
            body:
                'Pass 1: lay out all non-flex children with their own preferred sizes. '
                'Pass 2: subtract that from the Flex main-axis size to find free space. '
                'Free space is distributed among flex children proportional to their flex '
                'values. Expanded enforces tight fit on the resulting slot.',
            background: Color(0xFFFEF3C7),
            foreground: Color(0xFF78350F),
          ),
        ],
      ),
    );
  }
}

class _ExpandedLegend extends StatelessWidget {
  const _ExpandedLegend({
    required this.color,
    required this.title,
    required this.note,
    this.flex,
    this.width,
  });

  final Color color;
  final String title;
  final String note;
  final int? flex;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final Widget body = Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          if (flex != null)
            Text(
              'flex: $flex',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          Text(
            note,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
    if (width != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: SizedBox(width: width, child: body),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: body,
    );
  }
}

class _FlexFitCard extends StatelessWidget {
  const _FlexFitCard({
    required this.fit,
    required this.title,
    required this.description,
  });

  final FlexFit fit;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _FrameCard(
      title: title,
      note: description,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _paper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _frame),
        ),
        child: SizedBox(
          height: 70,
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Flexible(
                fit: fit,
                child: Container(
                  decoration: BoxDecoration(
                    color: fit == FlexFit.tight ? _accentB : _accentE,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    fit == FlexFit.tight ? 'fills the slot' : 'up to ~140',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 60,
                decoration: BoxDecoration(
                  color: _frame,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text('fixed', style: TextStyle(color: _ink)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RatioBar extends StatelessWidget {
  const _RatioBar({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 7 — textDirection + verticalDirection matrix (2x2).
// ═══════════════════════════════════════════════════════════════════════════

class _DirectionMatrixTab extends StatelessWidget {
  const _DirectionMatrixTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'textDirection and verticalDirection',
      subtitle:
          'These two parameters decide which end of the main axis is "first" when '
          'direction is horizontal or vertical. The 2x2 matrix below shows every '
          'combination with identical children.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder<TextDirection>(
            valueListenable: _textDirectionNotifier,
            builder: (BuildContext context, TextDirection td, Widget? child) {
              return ValueListenableBuilder<VerticalDirection>(
                valueListenable: _verticalDirectionNotifier,
                builder: (BuildContext context, VerticalDirection vd, Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: <Widget>[
                          ChoiceChip(
                            label: const Text('TextDirection.ltr'),
                            selected: td == TextDirection.ltr,
                            onSelected: (_) =>
                                _textDirectionNotifier.value = TextDirection.ltr,
                          ),
                          ChoiceChip(
                            label: const Text('TextDirection.rtl'),
                            selected: td == TextDirection.rtl,
                            onSelected: (_) =>
                                _textDirectionNotifier.value = TextDirection.rtl,
                          ),
                          const SizedBox(width: 10),
                          ChoiceChip(
                            label: const Text('VerticalDirection.down'),
                            selected: vd == VerticalDirection.down,
                            onSelected: (_) =>
                                _verticalDirectionNotifier.value = VerticalDirection.down,
                          ),
                          ChoiceChip(
                            label: const Text('VerticalDirection.up'),
                            selected: vd == VerticalDirection.up,
                            onSelected: (_) =>
                                _verticalDirectionNotifier.value = VerticalDirection.up,
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      _FrameCard(
                        title: 'Horizontal Flex - textDirection: ${td.name}',
                        note:
                            td == TextDirection.ltr
                                ? '1-2-3 in visual order, because LTR means child[0] is on the left.'
                                : '1-2-3 reversed, because RTL means child[0] is on the right.',
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _paper,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _frame),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            textDirection: td,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const <Widget>[
                              _Box(label: '1', color: _accentA, width: 48, height: 48),
                              SizedBox(width: 10),
                              _Box(label: '2', color: _accentB, width: 48, height: 48),
                              SizedBox(width: 10),
                              _Box(label: '3', color: _accentC, width: 48, height: 48),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      _FrameCard(
                        title: 'Vertical Flex - verticalDirection: ${vd.name}',
                        note: vd == VerticalDirection.down
                            ? 'child[0] at the top. Default behavior.'
                            : 'child[0] at the bottom. Useful for chat transcripts.',
                        child: SizedBox(
                          height: 220,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _paper,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: _frame),
                            ),
                            child: Flex(
                              direction: Axis.vertical,
                              verticalDirection: vd,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                _Box(label: '1', color: _accentA, width: 72, height: 44),
                                SizedBox(height: 8),
                                _Box(label: '2', color: _accentB, width: 72, height: 44),
                                SizedBox(height: 8),
                                _Box(label: '3', color: _accentC, width: 72, height: 44),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          const _SectionHeading(text: '2 x 2 matrix: all four combinations at once'),
          const _DirectionMatrix(),
          const SizedBox(height: 18),
          const _InfoCard(
            icon: Icons.translate_outlined,
            title: 'Why these parameters exist',
            body:
                'Flutter widgets are locale-aware. textDirection flips horizontal order for '
                'right-to-left scripts such as Arabic or Hebrew. verticalDirection flips top-'
                'to-bottom order - bottom-first columns are handy for chat feeds and terminal '
                'transcripts.',
            background: Color(0xFFE0F2FE),
            foreground: Color(0xFF0C4A6E),
          ),
        ],
      ),
    );
  }
}

class _DirectionMatrix extends StatelessWidget {
  const _DirectionMatrix();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double cellWidth = (constraints.maxWidth - 14) / 2;
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: cellWidth, child: const _MatrixCell(td: TextDirection.ltr, vd: VerticalDirection.down)),
                const SizedBox(width: 14),
                SizedBox(width: cellWidth, child: const _MatrixCell(td: TextDirection.rtl, vd: VerticalDirection.down)),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                SizedBox(width: cellWidth, child: const _MatrixCell(td: TextDirection.ltr, vd: VerticalDirection.up)),
                const SizedBox(width: 14),
                SizedBox(width: cellWidth, child: const _MatrixCell(td: TextDirection.rtl, vd: VerticalDirection.up)),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _MatrixCell extends StatelessWidget {
  const _MatrixCell({required this.td, required this.vd});
  final TextDirection td;
  final VerticalDirection vd;

  @override
  Widget build(BuildContext context) {
    return _FrameCard(
      title: '${td.name} / ${vd.name}',
      note: 'Horizontal Flex above, vertical Flex below. Both use the same three children.',
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _paper,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _frame),
            ),
            child: Flex(
              direction: Axis.horizontal,
              textDirection: td,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                _Box(label: '1', color: _accentA, width: 36, height: 36, fontSize: 12),
                SizedBox(width: 6),
                _Box(label: '2', color: _accentB, width: 36, height: 36, fontSize: 12),
                SizedBox(width: 6),
                _Box(label: '3', color: _accentC, width: 36, height: 36, fontSize: 12),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 140,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _paper,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _frame),
            ),
            child: Flex(
              direction: Axis.vertical,
              verticalDirection: vd,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                _Box(label: '1', color: _accentA, width: 50, height: 32, fontSize: 12),
                SizedBox(height: 6),
                _Box(label: '2', color: _accentB, width: 50, height: 32, fontSize: 12),
                SizedBox(height: 6),
                _Box(label: '3', color: _accentC, width: 50, height: 32, fontSize: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 8 — Baseline alignment.
// ═══════════════════════════════════════════════════════════════════════════

class _BaselineTab extends StatelessWidget {
  const _BaselineTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'textBaseline + CrossAxisAlignment.baseline',
      subtitle:
          'When cross-axis alignment is .baseline, Flex lines up the typographic baselines '
          'of its children instead of their bounding boxes. The difference is most obvious '
          'when child font sizes differ.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _FrameCard(
            title: 'Side-by-side: baseline vs bottom',
            note:
                'Left Flex uses CrossAxisAlignment.baseline with TextBaseline.alphabetic. '
                'Right Flex uses CrossAxisAlignment.end. Three words at 14, 28, and 42 pt.',
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double halfWidth = (constraints.maxWidth - 14) / 2;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: halfWidth, child: const _BaselineCard(alignment: CrossAxisAlignment.baseline, label: 'baseline')),
                    const SizedBox(width: 14),
                    SizedBox(width: halfWidth, child: const _BaselineCard(alignment: CrossAxisAlignment.end, label: 'end (bottom)')),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const _SectionHeading(text: 'Letter breakdown'),
          _FrameCard(
            title: 'Font-size ramp',
            note: 'The dotted line is the common alphabetic baseline.',
            child: Container(
              height: 120,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _paper,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _frame),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Positioned.fill(
                    child: CustomPaint(painter: _BaselineGuidePainter()),
                  ),
                  const Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Ag', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      Text('Ag', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                      Text('Ag', style: TextStyle(fontSize: 56, fontWeight: FontWeight.w700)),
                      Text('Ag', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const _InfoCard(
            icon: Icons.text_snippet_outlined,
            title: 'Two options',
            body:
                'TextBaseline.alphabetic is the default Latin baseline used in most fonts. '
                'TextBaseline.ideographic is appropriate for CJK scripts where characters sit '
                'on a lower line. The parameter is required when CrossAxisAlignment.baseline '
                'is used; asserts otherwise.',
            background: Color(0xFFFCE7F3),
            foreground: Color(0xFF9D174D),
          ),
          const SizedBox(height: 14),
          const _InfoCard(
            icon: Icons.warning_amber_outlined,
            title: 'Widgets without a baseline',
            body:
                'Baseline alignment only applies to widgets that expose a baseline (Text, '
                'RichText, and widgets that delegate). Placing a plain Container in a baseline '
                'Flex falls back to CrossAxisAlignment.start for that child.',
            background: Color(0xFFFEF9C3),
            foreground: Color(0xFF713F12),
          ),
        ],
      ),
    );
  }
}

class _BaselineCard extends StatelessWidget {
  const _BaselineCard({required this.alignment, required this.label});
  final CrossAxisAlignment alignment;
  final String label;

  @override
  Widget build(BuildContext context) {
    final bool isBaseline = alignment == CrossAxisAlignment.baseline;
    return _FrameCard(
      title: 'CrossAxisAlignment.$label',
      note: isBaseline
          ? 'textBaseline: TextBaseline.alphabetic required.'
          : 'Fallback alignment - children stick to the bottom edge.',
      child: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: _paper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _frame),
        ),
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: alignment,
          textBaseline: isBaseline ? TextBaseline.alphabetic : null,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text('Fly', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            Text('Run', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            Text('Jump', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _BaselineGuidePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double y = size.height - 24;
    final Paint paint = Paint()
      ..color = _accentD.withValues(alpha: 0.7)
      ..strokeWidth = 1;
    const double dash = 6;
    const double gap = 4;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, y), Offset(math.min(x + dash, size.width), y), paint);
      x += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _BaselineGuidePainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 9 — More: responsive, diagram, comparison, cheat sheet.
// ═══════════════════════════════════════════════════════════════════════════

class _MoreTab extends StatelessWidget {
  const _MoreTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Responsive Flex, diagram, comparison, API cheat sheet',
      subtitle: 'The payoff tab. Everything that demonstrates Flex in context.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _ResponsiveFlexSection(),
          SizedBox(height: 26),
          _DiagramSection(),
          SizedBox(height: 26),
          _ComparisonSection(),
          SizedBox(height: 26),
          _CheatSheetSection(),
        ],
      ),
    );
  }
}

// ── Responsive Flex ───────────────────────────────────────────────────────

class _ResponsiveFlexSection extends StatelessWidget {
  const _ResponsiveFlexSection();

  @override
  Widget build(BuildContext context) {
    return _FrameCard(
      title: 'Responsive Flex (breakpoint simulation)',
      note:
          'Tap a chip to simulate a viewport width. Below ~600 the Flex runs vertical (phone); '
          'at and above, it runs horizontal (tablet/desktop). Same children, reshaped by the '
          'container width via a ValueNotifier<Axis>.',
      child: ValueListenableBuilder<int>(
        valueListenable: _responsiveBreakpoint,
        builder: (BuildContext context, int width, Widget? child) {
          final Axis axis = width < 600 ? Axis.vertical : Axis.horizontal;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text('Viewport:', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: <Widget>[
                        for (final int w in <int>[320, 480, 600, 768, 1024, 1440])
                          ChoiceChip(
                            label: Text('${w}px'),
                            selected: w == width,
                            onSelected: (_) => _responsiveBreakpoint.value = w,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  _Chip(
                    label: 'Axis.${axis.name}',
                    color: axis == Axis.horizontal ? _accentB : _accentA,
                    dark: true,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'width ${width}px is ${axis == Axis.horizontal ? '>= 600 (horizontal)' : '< 600 (vertical)'}',
                    style: const TextStyle(color: _muted),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                constraints: BoxConstraints(maxWidth: width.toDouble()),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _paper,
                  border: Border.all(color: _frame),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  height: axis == Axis.horizontal ? 140 : 380,
                  child: Flex(
                    direction: axis,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      _ResponsiveCard(title: 'Profile', detail: 'Photo + bio', color: _accentA),
                      SizedBox(width: 10, height: 10),
                      _ResponsiveCard(title: 'Settings', detail: 'Preferences', color: _accentB),
                      SizedBox(width: 10, height: 10),
                      _ResponsiveCard(title: 'Logs', detail: 'Recent activity', color: _accentE),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ResponsiveCard extends StatelessWidget {
  const _ResponsiveCard({required this.title, required this.detail, required this.color});
  final String title;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          border: Border.all(color: color.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 36,
              height: 6,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
            ),
            const SizedBox(height: 10),
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 4),
            Text(detail, style: const TextStyle(color: _muted)),
          ],
        ),
      ),
    );
  }
}

// ── Diagram (CustomPainter) ───────────────────────────────────────────────

class _DiagramSection extends StatelessWidget {
  const _DiagramSection();

  @override
  Widget build(BuildContext context) {
    return _FrameCard(
      title: 'Main axis vs cross axis',
      note:
          'A schematic of how Flex interprets its two axes for each direction. The thick arrow '
          'is the main axis; the thin arrow is the cross axis.',
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _paper,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _frame),
        ),
        child: Row(
          children: const <Widget>[
            Expanded(child: _AxisDiagramLabel(direction: Axis.horizontal)),
            SizedBox(width: 14),
            Expanded(child: _AxisDiagramLabel(direction: Axis.vertical)),
          ],
        ),
      ),
    );
  }
}

class _AxisDiagramLabel extends StatelessWidget {
  const _AxisDiagramLabel({required this.direction});
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Axis.${direction.name}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: CustomPaint(
            size: const Size(double.infinity, 180),
            painter: _AxisDiagramPainter(direction: direction),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Thick = main, Thin = cross',
          style: TextStyle(color: _muted, fontSize: 12),
        ),
      ],
    );
  }
}

class _AxisDiagramPainter extends CustomPainter {
  _AxisDiagramPainter({required this.direction});
  final Axis direction;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint frameBg = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final Paint frameBorder = Paint()
      ..color = _frame
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final RRect outline = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 8, size.width - 16, size.height - 16),
      const Radius.circular(10),
    );
    canvas.drawRRect(outline, frameBg);
    canvas.drawRRect(outline, frameBorder);

    final Paint mainPaint = Paint()
      ..color = _accentA
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final Paint crossPaint = Paint()
      ..color = _accentF
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final double cx = size.width / 2;
    final double cy = size.height / 2;

    if (direction == Axis.horizontal) {
      final Offset start = Offset(24, cy);
      final Offset end = Offset(size.width - 24, cy);
      canvas.drawLine(start, end, mainPaint);
      _drawArrow(canvas, end, const Offset(1, 0), mainPaint);
      canvas.drawLine(Offset(cx, 24), Offset(cx, size.height - 24), crossPaint);
      _drawArrow(canvas, Offset(cx, size.height - 24), const Offset(0, 1), crossPaint);

      _drawLabel(canvas, 'main axis', Offset(cx, cy - 14), _accentA);
      _drawLabel(canvas, 'cross', Offset(cx + 34, cy + 20), _accentF);

      for (int i = 0; i < 3; i++) {
        final double bx = 40.0 + i * ((size.width - 80) / 2);
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTWH(bx - 16, cy - 20, 32, 40), const Radius.circular(6)),
          Paint()..color = <Color>[_accentA, _accentB, _accentC][i],
        );
      }
    } else {
      final Offset start = Offset(cx, 24);
      final Offset end = Offset(cx, size.height - 24);
      canvas.drawLine(start, end, mainPaint);
      _drawArrow(canvas, end, const Offset(0, 1), mainPaint);
      canvas.drawLine(Offset(24, cy), Offset(size.width - 24, cy), crossPaint);
      _drawArrow(canvas, Offset(size.width - 24, cy), const Offset(1, 0), crossPaint);

      _drawLabel(canvas, 'main', Offset(cx + 36, cy - 40), _accentA);
      _drawLabel(canvas, 'cross axis', Offset(cx, cy - 12), _accentF);

      for (int i = 0; i < 3; i++) {
        final double by = 40.0 + i * ((size.height - 80) / 2);
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTWH(cx - 22, by - 14, 44, 28), const Radius.circular(6)),
          Paint()..color = <Color>[_accentA, _accentB, _accentC][i],
        );
      }
    }
  }

  void _drawArrow(Canvas canvas, Offset tip, Offset direction, Paint paint) {
    const double size = 9;
    final Offset perp = Offset(-direction.dy, direction.dx) * size;
    final Offset back = direction * -size;
    final Path path = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(tip.dx + back.dx + perp.dx, tip.dy + back.dy + perp.dy)
      ..lineTo(tip.dx + back.dx - perp.dx, tip.dy + back.dy - perp.dy)
      ..close();
    canvas.drawPath(path, Paint()..color = paint.color);
  }

  void _drawLabel(Canvas canvas, String text, Offset origin, Color color) {
    final TextPainter painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, origin - Offset(painter.width / 2, painter.height / 2));
  }

  @override
  bool shouldRepaint(covariant _AxisDiagramPainter oldDelegate) => oldDelegate.direction != direction;
}

// ── Comparison table ──────────────────────────────────────────────────────

class _ComparisonSection extends StatelessWidget {
  const _ComparisonSection();

  @override
  Widget build(BuildContext context) {
    const List<_Row> rows = <_Row>[
      _Row(
        widget: 'Flex',
        axis: 'Parameter',
        linebreaks: 'Never',
        paints: 'No',
        note: 'Use when axis is a runtime value.',
      ),
      _Row(
        widget: 'Row',
        axis: 'Axis.horizontal',
        linebreaks: 'Never',
        paints: 'No',
        note: 'Direct Flex with horizontal direction.',
      ),
      _Row(
        widget: 'Column',
        axis: 'Axis.vertical',
        linebreaks: 'Never',
        paints: 'No',
        note: 'Direct Flex with vertical direction.',
      ),
      _Row(
        widget: 'Wrap',
        axis: 'Parameter',
        linebreaks: 'Yes',
        paints: 'No',
        note: 'Automatically wraps children to a new run.',
      ),
      _Row(
        widget: 'Stack',
        axis: 'None',
        linebreaks: 'N/A',
        paints: 'Yes (z-order)',
        note: 'Overlaps children; no linear axis.',
      ),
    ];

    return _FrameCard(
      title: 'Flex vs Row vs Column vs Wrap vs Stack',
      note: 'Each column summarizes a single dimension of behavior.',
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(flex: 2, child: Text('Widget', style: TextStyle(fontWeight: FontWeight.w800))),
                Expanded(flex: 2, child: Text('Axis', style: TextStyle(fontWeight: FontWeight.w800))),
                Expanded(flex: 2, child: Text('Line breaks', style: TextStyle(fontWeight: FontWeight.w800))),
                Expanded(flex: 2, child: Text('Paints', style: TextStyle(fontWeight: FontWeight.w800))),
                Expanded(flex: 5, child: Text('Note', style: TextStyle(fontWeight: FontWeight.w800))),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: i.isEven ? Colors.white : const Color(0xFFF8FAFC),
                border: const Border(top: BorderSide(color: _frame)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 2, child: Text(rows[i].widget, style: const TextStyle(fontWeight: FontWeight.w700))),
                  Expanded(flex: 2, child: Text(rows[i].axis)),
                  Expanded(flex: 2, child: Text(rows[i].linebreaks)),
                  Expanded(flex: 2, child: Text(rows[i].paints)),
                  Expanded(flex: 5, child: Text(rows[i].note, style: const TextStyle(height: 1.35))),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Row {
  const _Row({
    required this.widget,
    required this.axis,
    required this.linebreaks,
    required this.paints,
    required this.note,
  });
  final String widget;
  final String axis;
  final String linebreaks;
  final String paints;
  final String note;
}

// ── API cheat sheet ───────────────────────────────────────────────────────

class _CheatSheetSection extends StatelessWidget {
  const _CheatSheetSection();

  @override
  Widget build(BuildContext context) {
    const List<_ApiItem> items = <_ApiItem>[
      _ApiItem(
        name: 'direction',
        type: 'Axis',
        required: true,
        summary:
            'The axis along which children are laid out. Axis.horizontal for Row-like, '
            'Axis.vertical for Column-like.',
      ),
      _ApiItem(
        name: 'mainAxisAlignment',
        type: 'MainAxisAlignment',
        required: false,
        summary:
            'How children are positioned along the main axis when free space is available. '
            'Default: MainAxisAlignment.start.',
      ),
      _ApiItem(
        name: 'mainAxisSize',
        type: 'MainAxisSize',
        required: false,
        summary:
            'Whether the Flex consumes all available main-axis space (max, default) or only '
            'enough to wrap its children (min).',
      ),
      _ApiItem(
        name: 'crossAxisAlignment',
        type: 'CrossAxisAlignment',
        required: false,
        summary:
            'How children are aligned perpendicular to the main axis. Default: center. '
            'Options: start, end, center, stretch, baseline.',
      ),
      _ApiItem(
        name: 'textDirection',
        type: 'TextDirection?',
        required: false,
        summary:
            'For horizontal Flex, which horizontal direction counts as "leading". If null, '
            'uses the ambient Directionality.',
      ),
      _ApiItem(
        name: 'verticalDirection',
        type: 'VerticalDirection',
        required: false,
        summary:
            'For vertical Flex, which vertical direction counts as "leading". Default: '
            'VerticalDirection.down.',
      ),
      _ApiItem(
        name: 'textBaseline',
        type: 'TextBaseline?',
        required: false,
        summary:
            'Required when crossAxisAlignment is CrossAxisAlignment.baseline. Typically '
            'TextBaseline.alphabetic.',
      ),
      _ApiItem(
        name: 'clipBehavior',
        type: 'Clip',
        required: false,
        summary:
            'Whether content that overflows the Flex is clipped. Default: Clip.none. Use '
            'Clip.hardEdge for sharp clipping at the Flex bounds.',
      ),
      _ApiItem(
        name: 'children',
        type: 'List<Widget>',
        required: false,
        summary:
            'The children to lay out. Typically includes Expanded, Flexible, Spacer, or '
            'plain widgets.',
      ),
    ];

    return _FrameCard(
      title: 'API cheat sheet - every Flex parameter',
      note: 'Quick lookup for the full constructor signature.',
      child: Column(
        children: <Widget>[
          for (final _ApiItem item in items) _ApiRow(item: item),
        ],
      ),
    );
  }
}

class _ApiItem {
  const _ApiItem({
    required this.name,
    required this.type,
    required this.required,
    required this.summary,
  });
  final String name;
  final String type;
  final bool required;
  final String summary;
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({required this.item});
  final _ApiItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _frame),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                item.name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: _accentA,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _frame,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  item.type,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: _ink,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (item.required)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _accentD,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'required',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(item.summary, style: const TextStyle(height: 1.38, color: _ink)),
        ],
      ),
    );
  }
}
