import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// ScrollIncrementType — Line vs Page
// ---------------------------------------------------------------------------
// A deep visual demo of the Flutter `ScrollIncrementType` enum. The enum has
// two values — `line` and `page` — and is carried by a `ScrollIntent` so that
// a ScrollAction (or a custom `incrementCalculator`) knows how far to scroll.
//
// The typical bindings baked into Flutter's default shortcuts are:
//   * ArrowUp / ArrowDown  → ScrollIntent(type: line, direction: up/down)
//   * ArrowLeft / ArrowRight → ScrollIntent(type: line, direction: left/right)
//   * PageUp   / PageDown    → ScrollIntent(type: page, direction: up/down)
//
// The default increment is ~50 logical pixels for `line` and the viewport's
// main-axis dimension for `page`. Authors can override this by providing an
// `incrementCalculator` on their `Scrollable`.
//
// This demo walks through the behaviour with live scrollers, annotated
// overlays, and teaching tiles, so the consumer gets both the conceptual
// picture and a feel for the pixel deltas involved.

const Color kCobalt = Color(0xFF1B3A9B);
const Color kLemon = Color(0xFFF6E05E);
const Color kCream = Color(0xFFFEF8EC);
const Color kInk = Color(0xFF1A1A2E);
const Color kLineColor = Color(0xFF2A6DF4);
const Color kPageColor = Color(0xFFEA7A2C);
const Color kMuted = Color(0xFF5C5C70);

// ---------------------------------------------------------------------------
// Top-level build — this is the d4rt AST harness entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollIncrementType Catalog',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kCream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kCobalt,
        primary: kCobalt,
        secondary: kLemon,
        surface: kCream,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w800,
          fontSize: 26,
          letterSpacing: -0.3,
        ),
        titleMedium: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.45,
        ),
      ),
    ),
    home: const _ScrollIncrementTypeCatalog(),
  );
}

// ---------------------------------------------------------------------------
// Top-level catalog widget
// ---------------------------------------------------------------------------

class _ScrollIncrementTypeCatalog extends StatefulWidget {
  const _ScrollIncrementTypeCatalog();

  @override
  State<_ScrollIncrementTypeCatalog> createState() =>
      _ScrollIncrementTypeCatalogState();
}

class _ScrollIncrementTypeCatalogState
    extends State<_ScrollIncrementTypeCatalog> {
  // Shared state: last key pressed (for keycap highlight animation),
  // last line delta, last page delta.
  LogicalKeyboardKey? _lastKey;
  double _lastLineDelta = 0;
  double _lastPageDelta = 0;
  String _lastAction = 'idle';

  void _registerKey(LogicalKeyboardKey key, String label, double delta) {
    setState(() {
      _lastKey = key;
      _lastAction = label;
      if (label.contains('line')) {
        _lastLineDelta = delta;
      } else if (label.contains('page')) {
        _lastPageDelta = delta;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kCobalt,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'ScrollIncrementType — Line vs Page',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.2),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'enum · 2 values',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
        children: [
          const _HeroHeader(),
          const SizedBox(height: 28),
          _SideBySideScrollers(
            onLineJump: (d) => _registerKey(
              LogicalKeyboardKey.arrowDown,
              'line down',
              d,
            ),
            onPageJump: (d) => _registerKey(
              LogicalKeyboardKey.pageDown,
              'page down',
              d,
            ),
          ),
          const SizedBox(height: 28),
          _PixelDeltaOverlay(
            lineDelta: _lastLineDelta,
            pageDelta: _lastPageDelta,
          ),
          const SizedBox(height: 28),
          const _KeyToTypeMappingCard(),
          const SizedBox(height: 28),
          const _EnumValueCards(),
          const SizedBox(height: 28),
          _CustomIncrementCalculatorDemo(
            onLineJump: (d) => _registerKey(
              LogicalKeyboardKey.arrowDown,
              'custom line',
              d,
            ),
            onPageJump: (d) => _registerKey(
              LogicalKeyboardKey.pageDown,
              'custom page',
              d,
            ),
          ),
          const SizedBox(height: 28),
          const _TeachingPanel(),
          const SizedBox(height: 28),
          _KeycapDiagram(activeKey: _lastKey, lastAction: _lastAction),
          const SizedBox(height: 28),
          const _UseCasesStrip(),
          const SizedBox(height: 28),
          const _FooterSummary(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Hero header — title + decorative twin rulers (narrow vs wide ticks).
// ---------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kCobalt,
            kCobalt.withValues(alpha: 0.88),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: kCobalt.withValues(alpha: 0.25),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kLemon,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Flutter · widgets',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: kInk,
                    fontSize: 12,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
                child: const Text(
                  'enum ScrollIncrementType { line, page }',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'ScrollIncrementType — Line vs Page',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'The size-unit carried by ScrollIntent. Arrow keys request a '
            'line — roughly 50 logical pixels. PageUp / PageDown request a '
            'page — roughly one viewport. This catalog walks through both.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 28),
          _RulerPair(),
        ],
      ),
    );
  }
}

class _RulerPair extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _RulerLabel(color: kLineColor, label: 'line  ≈ 50 px'),
            const SizedBox(width: 16),
            _RulerLabel(color: kPageColor, label: 'page  ≈ viewport'),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 48,
          child: CustomPaint(
            size: const Size(double.infinity, 48),
            painter: _RulerPainter(
              colorLine: kLineColor,
              colorPage: kPageColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _RulerLabel extends StatelessWidget {
  const _RulerLabel({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _RulerPainter extends CustomPainter {
  _RulerPainter({required this.colorLine, required this.colorPage});

  final Color colorLine;
  final Color colorPage;

  @override
  void paint(Canvas canvas, Size size) {
    final baseLine = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..strokeWidth = 2;

    // Top ruler (line, narrow ticks)
    final topY = 10.0;
    canvas.drawLine(
      Offset(0, topY),
      Offset(size.width, topY),
      baseLine,
    );
    final linePaint = Paint()
      ..color = colorLine
      ..strokeWidth = 2;
    const lineTickGap = 14.0;
    for (double x = 0; x <= size.width; x += lineTickGap) {
      canvas.drawLine(Offset(x, topY - 6), Offset(x, topY + 6), linePaint);
    }

    // Bottom ruler (page, wide ticks)
    final botY = 38.0;
    canvas.drawLine(
      Offset(0, botY),
      Offset(size.width, botY),
      baseLine,
    );
    final pagePaint = Paint()
      ..color = colorPage
      ..strokeWidth = 3;
    final pageGap = size.width / 5.0;
    for (double x = 0; x <= size.width + 0.5; x += pageGap) {
      canvas.drawLine(Offset(x, botY - 10), Offset(x, botY + 10), pagePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RulerPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// 2. Side-by-side live scrollers — left = line, right = page.
// ---------------------------------------------------------------------------

class _SideBySideScrollers extends StatefulWidget {
  const _SideBySideScrollers({
    required this.onLineJump,
    required this.onPageJump,
  });

  final ValueChanged<double> onLineJump;
  final ValueChanged<double> onPageJump;

  @override
  State<_SideBySideScrollers> createState() => _SideBySideScrollersState();
}

class _SideBySideScrollersState extends State<_SideBySideScrollers> {
  final ScrollController _lineCtrl = ScrollController();
  final ScrollController _pageCtrl = ScrollController();
  double _lineFlash = 0;
  double _pageFlash = 0;
  bool _lineFlashOn = false;
  bool _pageFlashOn = false;

  static const double _lineIncrement = 50;

  void _jumpLine(double dir) {
    if (!_lineCtrl.hasClients) return;
    final current = _lineCtrl.offset;
    final max = _lineCtrl.position.maxScrollExtent;
    final target = (current + dir * _lineIncrement).clamp(0.0, max);
    final delta = (target - current).abs();
    _lineCtrl.animateTo(
      target,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
    );
    setState(() {
      _lineFlash = delta;
      _lineFlashOn = true;
    });
    widget.onLineJump(delta);
    Future<void>.delayed(const Duration(milliseconds: 550), () {
      if (!mounted) return;
      setState(() => _lineFlashOn = false);
    });
  }

  void _jumpPage(double dir) {
    if (!_pageCtrl.hasClients) return;
    final current = _pageCtrl.offset;
    final max = _pageCtrl.position.maxScrollExtent;
    final viewport = _pageCtrl.position.viewportDimension;
    final target = (current + dir * viewport).clamp(0.0, max);
    final delta = (target - current).abs();
    _pageCtrl.animateTo(
      target,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
    setState(() {
      _pageFlash = delta;
      _pageFlashOn = true;
    });
    widget.onPageJump(delta);
    Future<void>.delayed(const Duration(milliseconds: 650), () {
      if (!mounted) return;
      setState(() => _pageFlashOn = false);
    });
  }

  @override
  void dispose() {
    _lineCtrl.dispose();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '§2  Live scrollers — line vs page',
      subtitle:
          'Two list views of 40 tiles each. The left binds ArrowDown to a '
          'line-type ScrollIntent; the right binds PageDown to a page-type '
          'ScrollIntent. The coloured chip flashes the pixel delta each jump.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _ScrollerColumn(
              title: 'ArrowDown → line',
              accent: kLineColor,
              controller: _lineCtrl,
              flashValue: _lineFlash,
              flashOn: _lineFlashOn,
              onTriggerDown: () => _jumpLine(1),
              onTriggerUp: () => _jumpLine(-1),
              count: 40,
              typeLabel: 'ScrollIncrementType.line',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _ScrollerColumn(
              title: 'PageDown → page',
              accent: kPageColor,
              controller: _pageCtrl,
              flashValue: _pageFlash,
              flashOn: _pageFlashOn,
              onTriggerDown: () => _jumpPage(1),
              onTriggerUp: () => _jumpPage(-1),
              count: 40,
              typeLabel: 'ScrollIncrementType.page',
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollerColumn extends StatelessWidget {
  const _ScrollerColumn({
    required this.title,
    required this.accent,
    required this.controller,
    required this.flashValue,
    required this.flashOn,
    required this.onTriggerDown,
    required this.onTriggerUp,
    required this.count,
    required this.typeLabel,
  });

  final String title;
  final Color accent;
  final ScrollController controller;
  final double flashValue;
  final bool flashOn;
  final VoidCallback onTriggerDown;
  final VoidCallback onTriggerUp;
  final int count;
  final String typeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard, color: accent, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  typeLabel,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    fontSize: 10.5,
                    color: kMuted,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 260,
            child: Stack(
              children: [
                ListView.builder(
                  controller: controller,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  itemCount: count,
                  itemBuilder: (context, i) {
                    return Container(
                      height: 48,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: i.isEven
                            ? kCream
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.18),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            alignment: Alignment.center,
                            child: Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: accent,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Tile #${i + 1} — scrollable item',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kInk,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Icon(
                              Icons.drag_handle,
                              color: accent.withValues(alpha: 0.6),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: AnimatedOpacity(
                    opacity: flashOn ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: accent.withValues(alpha: 0.45),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '+${flashValue.toStringAsFixed(0)} px',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: _TriggerButton(
                    label: 'Scroll up',
                    icon: Icons.arrow_upward,
                    color: accent,
                    onTap: onTriggerUp,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _TriggerButton(
                    label: 'Scroll down',
                    icon: Icons.arrow_downward,
                    color: accent,
                    onTap: onTriggerDown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TriggerButton extends StatelessWidget {
  const _TriggerButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. Pixel-delta overlay — visualizes the last line/page increments.
// ---------------------------------------------------------------------------

class _PixelDeltaOverlay extends StatelessWidget {
  const _PixelDeltaOverlay({
    required this.lineDelta,
    required this.pageDelta,
  });

  final double lineDelta;
  final double pageDelta;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '§3  Pixel-delta overlay',
      subtitle:
          'The canvas renders a horizontal bar per jump. Line bars cap around '
          '50 logical pixels; page bars fill the viewport width.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DeltaBar(
            label: 'line',
            typeText: 'ScrollIncrementType.line',
            color: kLineColor,
            delta: lineDelta,
            maxDelta: 60,
          ),
          const SizedBox(height: 16),
          _DeltaBar(
            label: 'page',
            typeText: 'ScrollIncrementType.page',
            color: kPageColor,
            delta: pageDelta,
            maxDelta: 600,
          ),
        ],
      ),
    );
  }
}

class _DeltaBar extends StatelessWidget {
  const _DeltaBar({
    required this.label,
    required this.typeText,
    required this.color,
    required this.delta,
    required this.maxDelta,
  });

  final String label;
  final String typeText;
  final Color color;
  final double delta;
  final double maxDelta;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fraction = (delta / maxDelta).clamp(0.0, 1.0);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  typeText,
                  style: const TextStyle(
                    color: kMuted,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  '${delta.toStringAsFixed(1)} px',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                Container(
                  height: 22,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: color.withValues(alpha: 0.25),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  height: 22,
                  width: constraints.maxWidth * fraction,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withValues(alpha: 0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '0 px                                                              '
              '${maxDelta.toStringAsFixed(0)} px',
              style: TextStyle(
                color: kMuted.withValues(alpha: 0.8),
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ],
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// 4. Key-to-type mapping card.
// ---------------------------------------------------------------------------

class _KeyToTypeMappingCard extends StatelessWidget {
  const _KeyToTypeMappingCard();

  @override
  Widget build(BuildContext context) {
    final rows = <_MappingRow>[
      const _MappingRow(
        keys: 'ArrowUp / ArrowDown',
        type: 'line',
        direction: 'up / down',
        note: 'Default vertical line increment (~50 px).',
        color: kLineColor,
      ),
      const _MappingRow(
        keys: 'ArrowLeft / ArrowRight',
        type: 'line',
        direction: 'left / right',
        note: 'Horizontal line increment for horizontal scrollables.',
        color: kLineColor,
      ),
      const _MappingRow(
        keys: 'PageUp / PageDown',
        type: 'page',
        direction: 'up / down',
        note: 'Full viewport jump — fast vertical navigation.',
        color: kPageColor,
      ),
      const _MappingRow(
        keys: 'Space (outside text fields)',
        type: 'page',
        direction: 'down (shift = up)',
        note: 'Web-style page scroll when the focused widget ignores Space.',
        color: kPageColor,
      ),
      const _MappingRow(
        keys: 'Home / End',
        type: 'document boundary',
        direction: 'start / end',
        note: 'Not carried by ScrollIncrementType — jumps to extremes.',
        color: kMuted,
      ),
    ];

    return _SectionShell(
      title: '§4  Key → type mapping',
      subtitle:
          'The built-in Flutter shortcut map turns these key events into '
          'ScrollIntents carrying the appropriate ScrollIncrementType.',
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: kCobalt.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: const [
                SizedBox(
                  width: 200,
                  child: Text(
                    'Key(s)',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: kCobalt,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: kCobalt,
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    'Direction',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: kCobalt,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Note',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: kCobalt,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (final r in rows) r,
        ],
      ),
    );
  }
}

class _MappingRow extends StatelessWidget {
  const _MappingRow({
    required this.keys,
    required this.type,
    required this.direction,
    required this.note,
    required this.color,
  });

  final String keys;
  final String type;
  final String direction;
  final String note;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: kCobalt.withValues(alpha: 0.08)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              keys,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                color: kInk,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color.withValues(alpha: 0.4)),
              ),
              alignment: Alignment.center,
              child: Text(
                type,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: color,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 120,
            child: Text(
              direction,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: kInk,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                color: kMuted,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. Enum value cards — one per value.
// ---------------------------------------------------------------------------

class _EnumValueCards extends StatelessWidget {
  const _EnumValueCards();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '§5  Enum values',
      subtitle:
          'Each value carries a simple promise about the magnitude of the '
          'requested scroll. Flutter supplies defaults, but you can override.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _ValueCard(
              name: 'line',
              color: kLineColor,
              defaultPx: '≈ 50 logical px',
              binding: 'ArrowUp / ArrowDown',
              description:
                  'Precise, one-step nudges for reading list rows, grid '
                  'cells, form fields, or anywhere a user wants fine '
                  'control over position.',
              visual: _LineVisual(color: kLineColor),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _ValueCard(
              name: 'page',
              color: kPageColor,
              defaultPx: 'viewport dimension',
              binding: 'PageUp / PageDown',
              description:
                  'Broad leaps through long content — documents, logs, '
                  'timelines. Matches desktop-OS expectations of what '
                  '"page down" means.',
              visual: _PageVisual(color: kPageColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  const _ValueCard({
    required this.name,
    required this.color,
    required this.defaultPx,
    required this.binding,
    required this.description,
    required this.visual,
  });

  final String name;
  final Color color;
  final String defaultPx;
  final String binding;
  final String description;
  final Widget visual;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'ScrollIncrementType.$name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            name,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: -0.6,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'default · $defaultPx',
            style: const TextStyle(
              color: kMuted,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: kInk,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard, size: 14, color: color),
                const SizedBox(width: 6),
                Text(
                  binding,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          visual,
        ],
      ),
    );
  }
}

class _LineVisual extends StatelessWidget {
  const _LineVisual({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          for (int i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 14,
                    decoration: BoxDecoration(
                      color: i == 1
                          ? color
                          : color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 14,
                      decoration: BoxDecoration(
                        color: kInk.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_downward, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                '~50 px nudge',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageVisual extends StatelessWidget {
  const _PageVisual({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color.withValues(alpha: 0.4)),
              ),
              alignment: Alignment.center,
              child: Text(
                'viewport N',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(Icons.east, color: color, size: 22),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: const Text(
                'viewport N+1',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. Custom incrementCalculator demo.
// ---------------------------------------------------------------------------

class _CustomIncrementCalculatorDemo extends StatefulWidget {
  const _CustomIncrementCalculatorDemo({
    required this.onLineJump,
    required this.onPageJump,
  });

  final ValueChanged<double> onLineJump;
  final ValueChanged<double> onPageJump;

  @override
  State<_CustomIncrementCalculatorDemo> createState() =>
      _CustomIncrementCalculatorDemoState();
}

class _CustomIncrementCalculatorDemoState
    extends State<_CustomIncrementCalculatorDemo> {
  final ScrollController _ctrl = ScrollController();
  String _log = 'Last: -';

  // This function mirrors what a custom Scrollable.incrementCalculator would
  // return — different values per ScrollIncrementType. We keep it simple so
  // the demo is purely visual.
  double _customCalculator({
    required double viewport,
    required bool isPage,
  }) {
    if (isPage) return viewport;
    return 30; // smaller than the default 50 — very precise line nudges.
  }

  void _fire({required bool isPage, required double dir}) {
    if (!_ctrl.hasClients) return;
    final viewport = _ctrl.position.viewportDimension;
    final amount = _customCalculator(viewport: viewport, isPage: isPage);
    final target = (_ctrl.offset + dir * amount).clamp(
      0.0,
      _ctrl.position.maxScrollExtent,
    );
    final delta = (target - _ctrl.offset).abs();
    _ctrl.animateTo(
      target,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
    setState(() {
      _log = isPage
          ? 'page → viewport ${viewport.toStringAsFixed(0)} px '
                '(delta ${delta.toStringAsFixed(0)} px)'
          : 'line → 30 px (delta ${delta.toStringAsFixed(0)} px)';
    });
    debugPrint('[incrementCalculator] $_log');
    if (isPage) {
      widget.onPageJump(delta);
    } else {
      widget.onLineJump(delta);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '§6  Custom incrementCalculator',
      subtitle:
          'A Scrollable can expose an incrementCalculator callback. It '
          'receives a ScrollIncrementDetails whose .type is the enum value. '
          'Here, we return 30 px for line and viewport for page.',
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kInk,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.code, color: kLemon, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'double myCalc(ScrollIncrementDetails d) =>\n'
                    '    d.type == ScrollIncrementType.page\n'
                    '        ? d.metrics.viewportDimension\n'
                    '        : 30.0;',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kCobalt.withValues(alpha: 0.22)),
            ),
            child: ListView.builder(
              controller: _ctrl,
              padding: const EdgeInsets.all(8),
              itemCount: 50,
              itemBuilder: (context, i) {
                final isHighlight = i % 7 == 0;
                return Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isHighlight
                        ? kLemon.withValues(alpha: 0.5)
                        : kCream,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: kCobalt.withValues(alpha: 0.12),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Row #${i + 1}  ·  ${isHighlight ? "section header" : "content"}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kInk,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _TriggerButton(
                  label: 'line up (30)',
                  icon: Icons.keyboard_arrow_up,
                  color: kLineColor,
                  onTap: () => _fire(isPage: false, dir: -1),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TriggerButton(
                  label: 'line down (30)',
                  icon: Icons.keyboard_arrow_down,
                  color: kLineColor,
                  onTap: () => _fire(isPage: false, dir: 1),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TriggerButton(
                  label: 'page up',
                  icon: Icons.keyboard_double_arrow_up,
                  color: kPageColor,
                  onTap: () => _fire(isPage: true, dir: -1),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TriggerButton(
                  label: 'page down',
                  icon: Icons.keyboard_double_arrow_down,
                  color: kPageColor,
                  onTap: () => _fire(isPage: true, dir: 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kLemon.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kCobalt.withValues(alpha: 0.15)),
            ),
            child: Row(
              children: [
                const Icon(Icons.terminal, size: 16, color: kCobalt),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _log,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: kInk,
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
  }
}

// ---------------------------------------------------------------------------
// 7. Teaching panel — three prose tiles.
// ---------------------------------------------------------------------------

class _TeachingPanel extends StatelessWidget {
  const _TeachingPanel();

  @override
  Widget build(BuildContext context) {
    final tiles = <_TeachingTile>[
      const _TeachingTile(
        icon: Icons.settings_suggest,
        title: 'Defaults matter',
        body:
            'Flutter ships with 50 logical pixels for line and viewport '
            'dimension for page. Override only when you have a specific UX '
            'rationale — most users already have muscle memory for these.',
        color: kCobalt,
      ),
      const _TeachingTile(
        icon: Icons.accessibility_new,
        title: 'Respect assistive tech',
        body:
            'Screen readers and switch devices assume predictable line and '
            'page increments. Surprising deltas break predictability and '
            'hurt accessibility.',
        color: kLineColor,
      ),
      const _TeachingTile(
        icon: Icons.alt_route,
        title: 'Branch on the enum',
        body:
            'Inside a custom incrementCalculator, pattern-match '
            'details.type — return fine-grained values for line and coarse '
            'viewport-based jumps for page.',
        color: kPageColor,
      ),
    ];

    return _SectionShell(
      title: '§7  Teaching panel',
      subtitle:
          'Design considerations when customising scroll increment '
          'behaviour.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < tiles.length; i++) ...[
            Expanded(child: tiles[i]),
            if (i < tiles.length - 1) const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}

class _TeachingTile extends StatelessWidget {
  const _TeachingTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: kInk,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8. Keycap diagram — arrow cluster + PgUp/PgDn, highlight on recent key.
// ---------------------------------------------------------------------------

class _KeycapDiagram extends StatelessWidget {
  const _KeycapDiagram({required this.activeKey, required this.lastAction});

  final LogicalKeyboardKey? activeKey;
  final String lastAction;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '§8  Keycap diagram',
      subtitle:
          'Blue caps emit line intents; orange caps emit page intents. The '
          'last trigger glows briefly so you can trace what fired.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kInk,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Arrow cluster
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 48),
                        _Keycap(
                          label: '↑',
                          color: kLineColor,
                          active: activeKey == LogicalKeyboardKey.arrowUp,
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _Keycap(
                          label: '←',
                          color: kLineColor,
                          active: activeKey == LogicalKeyboardKey.arrowLeft,
                        ),
                        const SizedBox(width: 6),
                        _Keycap(
                          label: '↓',
                          color: kLineColor,
                          active: activeKey == LogicalKeyboardKey.arrowDown,
                        ),
                        const SizedBox(width: 6),
                        _Keycap(
                          label: '→',
                          color: kLineColor,
                          active:
                              activeKey == LogicalKeyboardKey.arrowRight,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                // Page cluster
                Column(
                  children: [
                    _Keycap(
                      label: 'PgUp',
                      color: kPageColor,
                      active: activeKey == LogicalKeyboardKey.pageUp,
                      wide: true,
                    ),
                    const SizedBox(height: 6),
                    _Keycap(
                      label: 'PgDn',
                      color: kPageColor,
                      active: activeKey == LogicalKeyboardKey.pageDown,
                      wide: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 14,
                color: kMuted.withValues(alpha: 0.9),
              ),
              const SizedBox(width: 6),
              Text(
                'Last action: $lastAction',
                style: const TextStyle(
                  color: kMuted,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Keycap extends StatelessWidget {
  const _Keycap({
    required this.label,
    required this.color,
    required this.active,
    this.wide = false,
  });

  final String label;
  final Color color;
  final bool active;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: wide ? 72 : 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: active
              ? [color, color.withValues(alpha: 0.55)]
              : [
                  Colors.white.withValues(alpha: 0.08),
                  Colors.white.withValues(alpha: 0.03),
                ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: active ? color : Colors.white.withValues(alpha: 0.25),
          width: active ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: active
                ? color.withValues(alpha: 0.65)
                : Colors.black.withValues(alpha: 0.5),
            blurRadius: active ? 18 : 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : Colors.white.withValues(alpha: 0.85),
          fontWeight: FontWeight.w800,
          fontSize: wide ? 14 : 18,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 9. Use cases strip — four tiles.
// ---------------------------------------------------------------------------

class _UseCasesStrip extends StatelessWidget {
  const _UseCasesStrip();

  @override
  Widget build(BuildContext context) {
    final tiles = <_UseCaseTile>[
      const _UseCaseTile(
        icon: Icons.chat_bubble_outline,
        title: 'Long chat logs',
        body: 'Arrow keys step one message at a time; PageDown jumps to the '
            'next unread batch.',
        color: kLineColor,
      ),
      const _UseCaseTile(
        icon: Icons.menu_book_outlined,
        title: 'Document readers',
        body: 'Line nudges align to text baselines; pages advance one screen '
            'for fast reading.',
        color: kPageColor,
      ),
      const _UseCaseTile(
        icon: Icons.grid_on_outlined,
        title: 'Data tables',
        body: 'Line scroll walks row-by-row; page jumps advance whole '
            'screens of data.',
        color: kCobalt,
      ),
      const _UseCaseTile(
        icon: Icons.view_carousel_outlined,
        title: 'Paged onboarding',
        body: 'Page increments align naturally with one-screen '
            'walkthrough cards.',
        color: kPageColor,
      ),
    ];

    return _SectionShell(
      title: '§9  Use cases',
      subtitle: 'Four common places where the line/page distinction matters.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < tiles.length; i++) ...[
            Expanded(child: tiles[i]),
            if (i < tiles.length - 1) const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _UseCaseTile extends StatelessWidget {
  const _UseCaseTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: const TextStyle(
              color: kInk,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 10. Footer summary.
// ---------------------------------------------------------------------------

class _FooterSummary extends StatelessWidget {
  const _FooterSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: kInk.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
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
                  color: kLemon,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.summarize_outlined,
                  color: kInk,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Summary — two values, one clean contract',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _FooterBullet(
            color: kLineColor,
            keyword: 'line',
            text:
                'Fine, predictable, ~50 px nudges. Bound to the arrow keys '
                'and to assistive-tech single-step commands.',
          ),
          const SizedBox(height: 8),
          const _FooterBullet(
            color: kPageColor,
            keyword: 'page',
            text:
                'Viewport-sized leaps. Bound to PageUp/PageDown and to the '
                'Space key in web-style reading contexts.',
          ),
          const SizedBox(height: 8),
          const _FooterBullet(
            color: kLemon,
            keyword: 'customize',
            text:
                'Override only through Scrollable.incrementCalculator — '
                'branch on ScrollIncrementDetails.type and keep the '
                'defaults as a baseline.',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.verified, color: kLemon, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'ScrollIncrementType is intentionally tiny — two values, '
                    'one job: carry the magnitude-semantics of a ScrollIntent '
                    'from key press to ScrollAction.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterBullet extends StatelessWidget {
  const _FooterBullet({
    required this.color,
    required this.keyword,
    required this.text,
  });

  final Color color;
  final String keyword;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 3),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          margin: const EdgeInsets.only(right: 8, top: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            keyword,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared section shell — title + subtitle + child content card.
// ---------------------------------------------------------------------------

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kCobalt.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: kCobalt.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kCobalt,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: kMuted,
              fontSize: 13,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}
