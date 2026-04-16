// D4rt deep visual demo — DraggableScrollableActuator.
//
// DraggableScrollableActuator is a marker in the widget tree whose descendant
// DraggableScrollableSheets can be programmatically reset to their
// initialChildSize via the static helper
// DraggableScrollableActuator.reset(BuildContext context). Internally the
// actuator exposes a ResetNotifier; each descendant sheet subscribes, and a
// reset call triggers a notification that makes every sheet run its own
// AnimationController back to the initial extent.
//
// Deeply visual tour: hero banner, live sheet, multi-sheet scenario, extent
// gauge, reset-animation diagram, notification flow diagram, use cases,
// snap-target visualization, pitfalls, API cheat sheet.
// Stateless; top-level ValueNotifiers power ValueListenableBuilders.
import 'package:flutter/material.dart';
// --- Top-level observables ---
final ValueNotifier<double> _sheetExtent = ValueNotifier<double>(0.5);
final ValueNotifier<double> _sheetExtentLeft = ValueNotifier<double>(0.5);
final ValueNotifier<double> _sheetExtentRight = ValueNotifier<double>(0.5);
final ValueNotifier<double> _snapSheetExtent = ValueNotifier<double>(0.5);
final ValueNotifier<int> _resetPulse = ValueNotifier<int>(0);
const double _kMinExtent = 0.25;
const double _kInitialExtent = 0.5;
const double _kMaxExtent = 0.9;
const List<double> _kSnapPoints = <double>[0.25, 0.5, 0.9];
// --- Entry point ---
dynamic build(BuildContext context) {
  final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF5C6BC0),
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
    ),
  );
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DraggableScrollableActuator Tour',
    theme: theme,
    home: DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('DraggableScrollableActuator'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Tab>[
              Tab(icon: Icon(Icons.waves_outlined), text: 'Hero'),
              Tab(icon: Icon(Icons.vertical_align_bottom), text: 'Live sheet'),
              Tab(icon: Icon(Icons.dynamic_feed), text: 'Multi-sheet'),
              Tab(icon: Icon(Icons.speed_outlined), text: 'Gauge'),
              Tab(icon: Icon(Icons.animation), text: 'Reset anim'),
              Tab(icon: Icon(Icons.account_tree_outlined), text: 'Flow'),
              Tab(icon: Icon(Icons.apps_outlined), text: 'Use cases'),
              Tab(icon: Icon(Icons.grid_view_outlined), text: 'Snap'),
              Tab(icon: Icon(Icons.report_gmailerrorred), text: 'Pitfalls'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _LiveSheetTab(),
            _MultiSheetTab(),
            _GaugeTab(),
            _AnimationDiagramTab(),
            _FlowDiagramTab(),
            _UseCasesTab(),
            _SnapTargetsTab(),
            _PitfallsTab(),
          ],
        ),
        bottomNavigationBar: const _ApiCheatSheet(),
      ),
    ),
  );
}

// --- Section 1 · Hero banner ---
class _HeroTab extends StatelessWidget {
  const _HeroTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeroBanner(scheme: s),
        const SizedBox(height: 20),
        _SectionCard(icon: Icons.info_outline, accent: s.primary,
          title: 'What it is',
          body: 'DraggableScrollableActuator is a tree-level marker holding '
            'a ResetNotifier. Descendant DraggableScrollableSheets subscribe '
            'to it; the actuator does no painting or layout itself.'),
        const SizedBox(height: 14),
        _SectionCard(icon: Icons.code_outlined, accent: s.secondary,
          title: 'Constructor',
          body: 'const DraggableScrollableActuator({\n'
            '  Key? key,\n  required Widget child,\n})\n\n'
            'Helper: static bool DraggableScrollableActuator.reset(\n'
            '  BuildContext context,\n)',
          mono: true),
        const SizedBox(height: 14),
        _SectionCard(icon: Icons.bolt_outlined, accent: s.tertiary,
          title: 'Role — the reset hook',
          body: 'Place one above any sheet whose position you want to '
            'restore. From anywhere below, a button, menu, or background tap '
            'can call reset(context) and every descendant sheet animates '
            'home.'),
        const SizedBox(height: 14),
        _SectionCard(icon: Icons.lightbulb_outline, accent: s.primary,
          title: 'When to reach for it',
          body: '• User taps background — collapse sheet.\n'
            '• Search pick — dismiss filter sheet.\n'
            '• Route changed — restore layout.\n'
            '• A "snap home" toggle button.'),
      ],
    );
  }
}
class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.scheme});
  final ColorScheme scheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: <Color>[scheme.primary, scheme.tertiary],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.28),
            blurRadius: 24, offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.vertical_align_bottom,
                    color: scheme.onPrimary, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('DraggableScrollableActuator',
                      style: TextStyle(
                        color: scheme.onPrimary, fontSize: 22,
                        fontWeight: FontWeight.w800, letterSpacing: 0.2)),
                    const SizedBox(height: 4),
                    Text('Programmatic reset for descendant draggable sheets',
                      style: TextStyle(
                        color: scheme.onPrimary.withValues(alpha: 0.85),
                        fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10, runSpacing: 10,
            children: const <Widget>[
              _HeroChip(label: 'InheritedWidget marker'),
              _HeroChip(label: 'Static reset(context)'),
              _HeroChip(label: 'Notification-based'),
              _HeroChip(label: 'Works with any sheet'),
            ],
          ),
        ],
      ),
    );
  }
}
class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: s.onPrimary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: s.onPrimary.withValues(alpha: 0.35))),
      child: Text(label, style: TextStyle(color: s.onPrimary,
          fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

// --- Section 2 · Live sheet demo ---
class _LiveSheetTab extends StatelessWidget {
  const _LiveSheetTab();
  @override
  Widget build(BuildContext context) =>
      DraggableScrollableActuator(child: _LiveSheetBody());
}
class _LiveSheetBody extends StatelessWidget {
  const _LiveSheetBody();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const _ColoredMapBackground(),
        Positioned(
          left: 16, right: 16, top: 16,
          child: _ResetToolbar(
            label: 'Tap to reset the sheet to '
                '${_kInitialExtent.toStringAsFixed(2)}',
            onReset: (BuildContext ctx) {
              DraggableScrollableActuator.reset(ctx);
              _resetPulse.value = _resetPulse.value + 1;
            },
          ),
        ),
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (DraggableScrollableNotification n) {
            _sheetExtent.value = n.extent;
            return false;
          },
          child: const DraggableScrollableSheet(
            initialChildSize: _kInitialExtent,
            minChildSize: _kMinExtent,
            maxChildSize: _kMaxExtent,
            builder: _buildSheetContent,
          ),
        ),
      ],
    );
  }
}
Widget _buildSheetContent(BuildContext context, ScrollController controller) {
  final ColorScheme s = Theme.of(context).colorScheme;
  return Container(
    decoration: BoxDecoration(
      color: s.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: s.shadow.withValues(alpha: 0.15),
          blurRadius: 18, offset: const Offset(0, -4),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        const SizedBox(height: 10),
        Container(
          width: 48, height: 4,
          decoration: BoxDecoration(color: s.outlineVariant, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Icon(Icons.list_alt, color: s.primary),
              const SizedBox(width: 10),
              Text('Nearby places',
                  style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              ValueListenableBuilder<double>(
                valueListenable: _sheetExtent,
                builder: (BuildContext ctx, double e, Widget? _) =>
                    _ExtentBadge(extent: e)),
            ],
          ),
        ),
        const Divider(height: 20),
        Expanded(
          child: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            itemCount: 24,
            itemBuilder: (BuildContext ctx, int i) => _PlaceTile(index: i),
          ),
        ),
      ],
    ),
  );
}
class _ColoredMapBackground extends StatelessWidget {
  const _ColoredMapBackground();
  @override
  Widget build(BuildContext context) => Positioned.fill(
    child: CustomPaint(
      painter: _MapPainter(scheme: Theme.of(context).colorScheme)));
}
class _MapPainter extends CustomPainter {
  const _MapPainter({required this.scheme});
  final ColorScheme scheme;
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: <Color>[
          scheme.primaryContainer.withValues(alpha: 0.6),
          scheme.tertiaryContainer.withValues(alpha: 0.6),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);
    final Paint lanes = Paint()..color = scheme.onPrimaryContainer.withValues(alpha: 0.15)..strokeWidth = 1.6;
    for (double y = 24; y < size.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), lanes);
    }
    for (double x = 24; x < size.width; x += 48) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), lanes);
    }
    final Paint river = Paint()..color = scheme.primary.withValues(alpha: 0.28)..strokeWidth = 12..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final Path r1 = Path()
      ..moveTo(-10, size.height * 0.25)
      ..cubicTo(size.width * 0.25, size.height * 0.1,
          size.width * 0.55, size.height * 0.4,
          size.width + 10, size.height * 0.3);
    canvas.drawPath(r1, river);
    final Paint dot = Paint()..color = scheme.secondary;
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.35), 6, dot);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.2), 6, dot);
    canvas.drawCircle(Offset(size.width * 0.72, size.height * 0.35), 6, dot);
  }
  @override
  bool shouldRepaint(covariant _MapPainter old) => old.scheme != scheme;
}
class _ResetToolbar extends StatelessWidget {
  const _ResetToolbar({required this.label, required this.onReset});
  final String label;
  final void Function(BuildContext) onReset;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Material(
      color: s.surface, elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
        child: Row(
          children: <Widget>[
            Icon(Icons.refresh, color: s.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(label,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w500)),
            ),
            Builder(
              builder: (BuildContext inner) => FilledButton.icon(
                onPressed: () => onReset(inner),
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset'))),
          ],
        ),
      ),
    );
  }
}
class _ExtentBadge extends StatelessWidget {
  const _ExtentBadge({required this.extent});
  final double extent;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: s.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(999)),
      child: Text('extent ${extent.toStringAsFixed(2)}',
        style: TextStyle(color: s.primary,
            fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }
}
class _PlaceTile extends StatelessWidget {
  const _PlaceTile({required this.index});
  final int index;
  static const List<String> _names = <String>[
    'Blue Lagoon Cafe', 'Harbor Bookshop', 'Orchid Bakery', 'Tidepool Diner',
    'Compass Coffee', 'Meridian Market', 'Driftwood Gallery', 'Kelp & Kindle',
    'Windward Noodle', 'Saltbox Bistro', 'Beacon Tea', 'Mariner Theater',
  ];
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    final String name = _names[index % _names.length];
    final double dist = 0.2 + (index % 9) * 0.17;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Material(
        color: s.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: s.primary.withValues(alpha: 0.14), shape: BoxShape.circle),
                child: Icon(Icons.place, color: s.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text('${dist.toStringAsFixed(1)} km · open now',
                      style: TextStyle(
                          fontSize: 12, color: s.onSurfaceVariant)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: s.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Section 3 · Multi-sheet ---
class _MultiSheetTab extends StatelessWidget {
  const _MultiSheetTab();
  @override
  Widget build(BuildContext context) =>
      DraggableScrollableActuator(child: _MultiSheetLayout());
}
class _MultiSheetLayout extends StatelessWidget {
  const _MultiSheetLayout();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Stack(
      children: <Widget>[
        Positioned.fill(child: ColoredBox(color: s.surfaceContainerLow)),
        const Positioned(left: 12, right: 12, top: 12, child: _MultiHeader()),
        Positioned(
          left: 0, right: 0, bottom: 0,
          child: SizedBox(
            height: 360,
            child: Row(
              children: <Widget>[
                Expanded(child: _MiniSheet(
                  tag: 'left', color: s.primary,
                  onExtent: (double e) => _sheetExtentLeft.value = e)),
                Expanded(child: _MiniSheet(
                  tag: 'right', color: s.tertiary,
                  onExtent: (double e) => _sheetExtentRight.value = e)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
class _MultiHeader extends StatelessWidget {
  const _MultiHeader();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Material(
      color: s.surface, elevation: 2,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.dynamic_feed, color: s.primary),
                const SizedBox(width: 10),
                const Text('Two sheets, one actuator',
                  style: TextStyle(fontWeight: FontWeight.w700)),
                const Spacer(),
                Builder(
                  builder: (BuildContext inner) => FilledButton.icon(
                    onPressed: () {
                      DraggableScrollableActuator.reset(inner);
                      _resetPulse.value = _resetPulse.value + 1;
                    },
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reset all'))),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(child: ValueListenableBuilder<double>(
                  valueListenable: _sheetExtentLeft,
                  builder: (BuildContext ctx, double e, Widget? _) =>
                      _ExtentRow(label: 'Left sheet', extent: e))),
                const SizedBox(width: 12),
                Expanded(child: ValueListenableBuilder<double>(
                  valueListenable: _sheetExtentRight,
                  builder: (BuildContext ctx, double e, Widget? _) =>
                      _ExtentRow(label: 'Right sheet', extent: e))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class _ExtentRow extends StatelessWidget {
  const _ExtentRow({required this.label, required this.extent});
  final String label;
  final double extent;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('$label · ${extent.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: extent.clamp(0.0, 1.0), minHeight: 6,
            backgroundColor: s.surfaceContainerHighest),
        ),
      ],
    );
  }
}
class _MiniSheet extends StatelessWidget {
  const _MiniSheet({required this.tag, required this.color, required this.onExtent, });
  final String tag;
  final Color color;
  final void Function(double) onExtent;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (DraggableScrollableNotification n) {
        onExtent(n.extent);
        return false;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.5, minChildSize: 0.2, maxChildSize: 1.0,
        builder: (BuildContext ctx, ScrollController controller) {
          return Container(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(top: BorderSide(color: color, width: 3)),
            ),
            child: ListView.builder(
              controller: controller,
              itemCount: 20,
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext ctx2, int i) => Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                child: Text('$tag · item #${i + 1}',
                  style: TextStyle(color: color, fontWeight: FontWeight.w600)),
              ),
            ),
          );
        },
      ),
    );
  }
}

// --- Section 4 · Size gauge ---
class _GaugeTab extends StatelessWidget {
  const _GaugeTab();
  @override
  Widget build(BuildContext context) =>
      DraggableScrollableActuator(child: _GaugeLayout());
}
class _GaugeLayout extends StatelessWidget {
  const _GaugeLayout();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Positioned.fill(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _GaugeCard()),
              SizedBox(height: 16),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _ResetPulseCard()),
              SizedBox(height: 12),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _ResetButtonCard()),
            ],
          ),
        ),
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (DraggableScrollableNotification n) {
            _sheetExtent.value = n.extent;
            return false;
          },
          child: const DraggableScrollableSheet(
            initialChildSize: _kInitialExtent,
            minChildSize: _kMinExtent,
            maxChildSize: _kMaxExtent,
            builder: _buildSheetContent,
          ),
        ),
      ],
    );
  }
}
class _GaugeCard extends StatelessWidget {
  const _GaugeCard();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Material(
      elevation: 3, color: s.surface,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 120, height: 120,
              child: ValueListenableBuilder<double>(
                valueListenable: _sheetExtent,
                builder: (BuildContext ctx, double e, Widget? _) => CustomPaint(
                  painter: _GaugePainter(
                    extent: e, minExtent: _kMinExtent,
                    maxExtent: _kMaxExtent, scheme: s)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Sheet extent',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  const Text(
                    'The gauge tracks notification.extent from the live '
                    'sheet. Reset forces the needle back to the initial '
                    'value.',
                    style: TextStyle(fontSize: 12, height: 1.4)),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<double>(
                    valueListenable: _sheetExtent,
                    builder: (BuildContext ctx, double e, Widget? _) => Wrap(
                      spacing: 6, runSpacing: 6,
                      children: <Widget>[
                        _Tag(label: 'min ${_kMinExtent.toStringAsFixed(2)}'),
                        _Tag(label:
                            'init ${_kInitialExtent.toStringAsFixed(2)}'),
                        _Tag(label: 'max ${_kMaxExtent.toStringAsFixed(2)}'),
                        _Tag(label: 'now ${e.toStringAsFixed(2)}',
                            highlight: true),
                      ],
                    )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _GaugePainter extends CustomPainter {
  const _GaugePainter({
    required this.extent, required this.minExtent,
    required this.maxExtent, required this.scheme,
  });
  final ColorScheme scheme;
  final double extent, minExtent, maxExtent;
  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = Offset(size.width / 2, size.height);
    final double r = size.width / 2 - 4;
    final Rect ar = Rect.fromCircle(center: c, radius: r);
    final Paint track = Paint()..color = scheme.surfaceContainerHighest..strokeWidth = 12..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawArc(ar, 3.14159, 3.14159, false, track);
    final double frac =
        ((extent - minExtent) / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final Paint active = Paint()
      ..shader = SweepGradient(
        startAngle: 3.14159, endAngle: 3.14159 * 2,
        colors: <Color>[scheme.primary, scheme.tertiary],
      ).createShader(ar)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(ar, 3.14159, 3.14159 * frac, false, active);
    final double angle = 3.14159 + 3.14159 * frac;
    final Offset end = Offset(
      c.dx + (r - 8) * _fastCos(angle),
      c.dy + (r - 8) * _fastSin(angle),
    );
    canvas.drawLine(c, end,
      Paint()..color = scheme.onSurface
        ..strokeWidth = 3 ..strokeCap = StrokeCap.round);
    canvas.drawCircle(c, 6, Paint()..color = scheme.primary);
  }
  @override
  bool shouldRepaint(covariant _GaugePainter old) =>
      old.extent != extent || old.scheme != scheme;
}
// Bhaskara-I cosine approximation; sin via phase shift. Avoids dart:math.
double _fastCos(double a) {
  double x = a;
  while (x > 3.14159) { x -= 6.28318; }
  while (x < -3.14159) { x += 6.28318; }
  final double xx = x * x;
  return (3.14159 * 3.14159 - 4 * xx) / (3.14159 * 3.14159 + xx);
}
double _fastSin(double a) => _fastCos(a - 1.5708);
class _Tag extends StatelessWidget {
  const _Tag({required this.label, this.highlight = false});
  final String label;
  final bool highlight;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    final Color bg = highlight
        ? s.primary : s.primary.withValues(alpha: 0.10);
    final Color fg = highlight ? s.onPrimary : s.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(label,
        style: TextStyle(
            color: fg, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }
}
class _ResetPulseCard extends StatelessWidget {
  const _ResetPulseCard();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Material(
      color: s.secondaryContainer,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            Icon(Icons.bolt, color: s.onSecondaryContainer),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Every reset() call bumps a pulse counter so you know the '
                'notification was dispatched.',
                style: TextStyle(
                    fontSize: 12, color: s.onSecondaryContainer)),
            ),
            ValueListenableBuilder<int>(
              valueListenable: _resetPulse,
              builder: (BuildContext ctx, int count, Widget? _) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: s.onSecondaryContainer, borderRadius: BorderRadius.circular(999)),
                child: Text('pulses $count',
                  style: TextStyle(
                    color: s.secondaryContainer,
                    fontWeight: FontWeight.w700, fontSize: 11)),
              )),
          ],
        ),
      ),
    );
  }
}
class _ResetButtonCard extends StatelessWidget {
  const _ResetButtonCard();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2, borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            const Expanded(
              child: Text('Drag the sheet up, then reset.',
                style: TextStyle(fontSize: 12))),
            Builder(
              builder: (BuildContext inner) => FilledButton.tonalIcon(
                onPressed: () {
                  DraggableScrollableActuator.reset(inner);
                  _resetPulse.value = _resetPulse.value + 1;
                },
                icon: const Icon(Icons.undo),
                label: const Text('Reset sheet'))),
          ],
        ),
      ),
    );
  }
}

// --- Section 5 · Reset animation diagram ---
class _AnimationDiagramTab extends StatelessWidget {
  const _AnimationDiagramTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionCard(
          icon: Icons.animation, accent: s.primary,
          title: 'Reset animation',
          body: 'Reset dispatches a _ResetNotification that each sheet\'s '
              'state catches. The sheet runs an AnimationController from '
              'the current extent to initialChildSize. The diagram below '
              'plots the expected extent curve starting at maxChildSize.'),
        const SizedBox(height: 16),
        Material(
          color: s.surface, elevation: 2,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              height: 320,
              child: CustomPaint(painter: _ResetAnimationPainter(scheme: s))),
          ),
        ),
        const SizedBox(height: 16),
        _PhaseTile(index: 1, label: 't = 0',
          text: 'Sheet is at maxChildSize (0.9). User scrolled it up.',
          scheme: s),
        _PhaseTile(index: 2, label: 't = tap',
          text: 'FilledButton invokes DraggableScrollableActuator.reset(ctx).',
          scheme: s),
        _PhaseTile(index: 3, label: 't = tap + 0 ms',
          text: '_ResetNotification fires; sheet starts its animation.',
          scheme: s),
        _PhaseTile(index: 4, label: 't = tap + ~200 ms',
          text: 'Sheet extent arrives at initialChildSize (0.5).',
          scheme: s),
      ],
    );
  }
}
class _ResetAnimationPainter extends CustomPainter {
  const _ResetAnimationPainter({required this.scheme});
  final ColorScheme scheme;
  @override
  void paint(Canvas canvas, Size size) {
    final Paint axis = Paint()..color = scheme.outlineVariant..strokeWidth = 1.2;
    const double left = 40;
    final double right = size.width - 20;
    const double top = 20;
    final double bottom = size.height - 30;
    canvas.drawLine(Offset(left, bottom), Offset(right, bottom), axis);
    canvas.drawLine(const Offset(left, top), Offset(left, bottom), axis);
    _drawGuide(canvas, left, right, bottom, top, 0.25, 'min', scheme);
    _drawGuide(canvas, left, right, bottom, top, 0.50, 'init', scheme);
    _drawGuide(canvas, left, right, bottom, top, 0.90, 'max', scheme);
    final Path curve = Path();
    final double yMax = top + (bottom - top) * (1 - 0.9);
    final double yInit = top + (bottom - top) * (1 - 0.5);
    curve.moveTo(left, yMax);
    curve.lineTo(left + (right - left) * 0.35, yMax);
    curve.cubicTo(
      left + (right - left) * 0.5, yMax,
      left + (right - left) * 0.6, yInit,
      left + (right - left) * 0.75, yInit);
    curve.lineTo(right, yInit);
    final Paint cp = Paint()..color = scheme.primary..strokeWidth = 3..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawPath(curve, cp);
    _event(canvas, Offset(left + (right - left) * 0.35, yMax),
        'reset pressed', scheme);
    _event(canvas, Offset(left + (right - left) * 0.75, yInit),
        'initialChildSize reached', scheme);
    _label(canvas, Offset(right - 40, bottom + 8), 'time', scheme);
    _label(canvas, const Offset(left - 30, top), 'extent', scheme);
  }
  void _drawGuide(Canvas canvas, double left, double right, double bottom,
      double top, double frac, String label, ColorScheme s) {
    final double y = top + (bottom - top) * (1 - frac);
    final Paint p = Paint()..color = s.outlineVariant.withValues(alpha: 0.7)..strokeWidth = 0.8;
    const double dash = 6;
    double x = left;
    while (x < right) {
      canvas.drawLine(Offset(x, y), Offset(x + dash, y), p);
      x += dash * 2;
    }
    _label(canvas, Offset(left - 34, y - 6), label, s);
  }
  void _event(Canvas canvas, Offset pos, String text, ColorScheme s) {
    canvas.drawCircle(pos, 5, Paint()..color = s.tertiary);
    _label(canvas, pos.translate(8, -16), text, s);
  }
  void _label(Canvas canvas, Offset pos, String text, ColorScheme s) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text,
        style: TextStyle(
            color: s.onSurface, fontSize: 10, fontWeight: FontWeight.w600)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos);
  }
  @override
  bool shouldRepaint(covariant _ResetAnimationPainter old) =>
      old.scheme != scheme;
}
class _PhaseTile extends StatelessWidget {
  const _PhaseTile({
    required this.index, required this.label,
    required this.text, required this.scheme,
  });
  final int index;
  final ColorScheme scheme;
  final String label, text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 28, height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.primary, shape: BoxShape.circle),
                child: Text('$index',
                  style: TextStyle(
                      color: scheme.onPrimary, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(label,
                      style: TextStyle(
                          color: scheme.primary,
                          fontWeight: FontWeight.w700, fontSize: 12)),
                    const SizedBox(height: 2),
                    Text(text, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Section 6 · Flow diagram ---
class _FlowDiagramTab extends StatelessWidget {
  const _FlowDiagramTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionCard(
          icon: Icons.account_tree_outlined, accent: s.primary,
          title: 'Notification flow',
          body: 'The actuator exposes a ResetNotifier (ChangeNotifier) '
              'through an InheritedNotifier. reset(context) notifies '
              'subscribers; every subscribed sheet state animates its '
              'scroll position.'),
        const SizedBox(height: 16),
        Material(
          color: s.surface, elevation: 2,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              height: 420,
              child: CustomPaint(painter: _FlowDiagramPainter(scheme: s))),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10, runSpacing: 10,
          children: <Widget>[
            _LegendChip(color: s.primary, label: 'Entry points'),
            _LegendChip(color: s.secondary, label: 'Framework glue'),
            _LegendChip(color: s.tertiary, label: 'State / result'),
          ],
        ),
      ],
    );
  }
}
class _FlowDiagramPainter extends CustomPainter {
  const _FlowDiagramPainter({required this.scheme});
  final ColorScheme scheme;
  @override
  void paint(Canvas canvas, Size size) {
    final List<_FlowNode> nodes = <_FlowNode>[
      _FlowNode(label: 'User event',
        subtitle: 'FilledButton tap / gesture', accent: scheme.primary),
      _FlowNode(label: 'Actuator.reset(ctx)',
        subtitle: 'static method', accent: scheme.secondary),
      _FlowNode(label: '_ResetNotifier',
        subtitle: 'ChangeNotifier', accent: scheme.tertiary),
      _FlowNode(label: '_SheetState.addListener',
        subtitle: 'listens in subtree', accent: scheme.primary),
      _FlowNode(label: 'AnimationController',
        subtitle: 'animates extent', accent: scheme.secondary),
      _FlowNode(label: 'initialChildSize',
        subtitle: 'target reached', accent: scheme.tertiary),
    ];
    const double marginX = 24;
    final double usable = size.width - marginX * 2;
    final double rowH = (size.height - 20) / nodes.length;
    final Paint arrow = Paint()..color = scheme.onSurface.withValues(alpha: 0.65)..strokeWidth = 1.8..style = PaintingStyle.stroke;
    for (int i = 0; i < nodes.length; i++) {
      final _FlowNode n = nodes[i];
      final Rect r = Rect.fromLTWH(
          marginX, 10 + i * rowH, usable, rowH - 18);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(14));
      canvas.drawRRect(rr,
          Paint()..color = n.accent.withValues(alpha: 0.12));
      canvas.drawRRect(rr,
          Paint()..color = n.accent
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5);
      _text(canvas, Offset(r.left + 16, r.top + 8), n.label, 13,
          FontWeight.w700, scheme.onSurface);
      _text(canvas, Offset(r.left + 16, r.top + 26), n.subtitle, 11,
          FontWeight.w500, scheme.onSurfaceVariant);
      if (i < nodes.length - 1) {
        final Offset a = Offset(r.left + usable / 2, r.bottom);
        final Offset b = Offset(r.left + usable / 2, r.bottom + 16);
        canvas.drawLine(a, b, arrow);
        canvas.drawPath(
          Path()
            ..moveTo(b.dx - 5, b.dy - 2)
            ..lineTo(b.dx + 5, b.dy - 2)
            ..lineTo(b.dx, b.dy + 5)
            ..close(),
          Paint()..color = arrow.color);
      }
    }
  }
  void _text(Canvas canvas, Offset pos, String text, double sz,
      FontWeight w, Color color) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text,
        style: TextStyle(color: color, fontSize: sz, fontWeight: w)),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 360);
    tp.paint(canvas, pos);
  }
  @override
  bool shouldRepaint(covariant _FlowDiagramPainter old) =>
      old.scheme != scheme;
}
class _FlowNode {
  const _FlowNode({required this.label, required this.subtitle, required this.accent, });
  final Color accent;
  final String label, subtitle;
}
class _LegendChip extends StatelessWidget {
  const _LegendChip({required this.color, required this.label});
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10, height: 10,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// --- Section 7 · Use cases ---
class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    final List<_UseCase> cases = <_UseCase>[
      _UseCase(icon: Icons.map_outlined, title: 'Map bottom sheet',
        scenario: 'User browses a place card up close, then backs out. The '
          'sheet returns to a mid extent for overview.',
        trigger: 'Back button tap', accent: s.primary),
      _UseCase(icon: Icons.filter_alt_outlined, title: 'Filter drawer',
        scenario: 'Filter sheet expanded for multi-select; applying filters '
          'should collapse it to the initial summary height.',
        trigger: 'Apply button', accent: s.secondary),
      _UseCase(icon: Icons.local_taxi_outlined, title: 'Ride-hailing sheet',
        scenario: 'Driver selected from the list; sheet glides to a compact '
          '"driver arriving" state.',
        trigger: 'Driver selected', accent: s.tertiary),
      _UseCase(icon: Icons.shopping_cart_outlined, title: 'Cart summary',
        scenario: 'User expanded the cart to read policies. After checkout, '
          'collapse it.',
        trigger: 'Checkout tapped', accent: s.primary),
      _UseCase(icon: Icons.play_circle_outline, title: 'Player controls',
        scenario: 'Expanded queue obscures the now-playing art; tap cover to '
          'reset the sheet.',
        trigger: 'Cover tap', accent: s.secondary),
      _UseCase(icon: Icons.search_outlined, title: 'Search results',
        scenario: 'After picking a result, the results sheet collapses so '
          'the selected page shows.',
        trigger: 'Result selected', accent: s.tertiary),
    ];
    return GridView.count(
      crossAxisCount: 2, childAspectRatio: 0.78,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 12, crossAxisSpacing: 12,
      children: cases.map((_UseCase c) => _UseCaseCard(data: c)).toList(),
    );
  }
}
class _UseCase {
  const _UseCase({
    required this.icon, required this.title, required this.scenario,
    required this.trigger, required this.accent,
  });
  final IconData icon;
  final Color accent;
  final String title, scenario, trigger;
}
class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({required this.data});
  final _UseCase data;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Material(
      elevation: 1, color: s.surface,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: data.accent.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(12)),
              child: Icon(data.icon, color: data.accent)),
            const SizedBox(height: 10),
            Text(data.title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: data.accent, fontSize: 15)),
            const SizedBox(height: 6),
            Expanded(
              child: Text(data.scenario, style: const TextStyle(fontSize: 12, height: 1.35))),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: data.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
              child: Text(data.trigger,
                style: TextStyle(
                    color: data.accent, fontSize: 11,
                    fontWeight: FontWeight.w700))),
          ],
        ),
      ),
    );
  }
}

// --- Section 8 · Snap targets ---
class _SnapTargetsTab extends StatelessWidget {
  const _SnapTargetsTab();
  @override
  Widget build(BuildContext context) =>
      DraggableScrollableActuator(child: _SnapLayout());
}
class _SnapLayout extends StatelessWidget {
  const _SnapLayout();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Stack(
      children: <Widget>[
        Positioned.fill(child: ColoredBox(color: s.surfaceContainer)),
        const Positioned(left: 12, right: 12, top: 12, child: _SnapHeader()),
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (DraggableScrollableNotification n) {
            _snapSheetExtent.value = n.extent;
            return false;
          },
          child: DraggableScrollableSheet(
            initialChildSize: _kInitialExtent,
            minChildSize: _kMinExtent,
            maxChildSize: _kMaxExtent,
            snap: true, snapSizes: _kSnapPoints,
            builder: (BuildContext ctx, ScrollController controller) =>
                _SnapSheetBody(controller: controller),
          ),
        ),
      ],
    );
  }
}
class _SnapHeader extends StatelessWidget {
  const _SnapHeader();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Material(
      color: s.surface, elevation: 2,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.grid_view_outlined, color: s.primary),
                const SizedBox(width: 10),
                const Text('Snap + reset interaction',
                  style: TextStyle(fontWeight: FontWeight.w700)),
                const Spacer(),
                Builder(
                  builder: (BuildContext inner) => FilledButton.icon(
                    onPressed: () =>
                        DraggableScrollableActuator.reset(inner),
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reset'))),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Snap anchors influence drag endings, not reset(). Reset '
              'always moves the sheet to initialChildSize regardless of the '
              'nearest snap.',
              style: TextStyle(fontSize: 12)),
            const SizedBox(height: 10),
            ValueListenableBuilder<double>(
              valueListenable: _snapSheetExtent,
              builder: (BuildContext ctx, double e, Widget? _) => SizedBox(
                height: 50,
                child: CustomPaint(
                  painter: _SnapPainter(
                      extent: e, snaps: _kSnapPoints, scheme: s))),
            ),
          ],
        ),
      ),
    );
  }
}
class _SnapPainter extends CustomPainter {
  const _SnapPainter({required this.extent, required this.snaps, required this.scheme, });
  final double extent;
  final List<double> snaps;
  final ColorScheme scheme;
  @override
  void paint(Canvas canvas, Size size) {
    final double y = size.height / 2;
    canvas.drawLine(Offset(6, y), Offset(size.width - 6, y),
      Paint()..color = scheme.outlineVariant
        ..strokeWidth = 3 ..strokeCap = StrokeCap.round);
    for (final double s in snaps) {
      final double x = 6 + (size.width - 12) * s;
      canvas.drawCircle(Offset(x, y), 6,
          Paint()..color = scheme.secondary);
      final TextPainter tp = TextPainter(
        text: TextSpan(text: s.toStringAsFixed(2),
          style: TextStyle(color: scheme.secondary,
              fontSize: 10, fontWeight: FontWeight.w700)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, y - 22));
    }
    final double curX = 6 + (size.width - 12) * extent.clamp(0.0, 1.0);
    canvas.drawCircle(Offset(curX, y), 9, Paint()..color = scheme.primary);
    canvas.drawCircle(Offset(curX, y), 14,
      Paint()..color = scheme.primary.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke ..strokeWidth = 3);
  }
  @override
  bool shouldRepaint(covariant _SnapPainter old) =>
      old.extent != extent || old.scheme != scheme;
}
class _SnapSheetBody extends StatelessWidget {
  const _SnapSheetBody({required this.controller});
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: s.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(top: BorderSide(color: s.primary, width: 4))),
      child: ListView.builder(
        controller: controller,
        padding: const EdgeInsets.all(14),
        itemCount: 24,
        itemBuilder: (BuildContext ctx, int i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: <Widget>[
              Container(
                width: 34, height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: s.primary.withValues(alpha: 0.14), shape: BoxShape.circle),
                child: Icon(Icons.label_outline, color: s.primary)),
              const SizedBox(width: 10),
              Expanded(child: Text('Snap-friendly row #${i + 1}')),
              Icon(Icons.chevron_right, color: s.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Section 9 · Pitfalls ---
class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _PitfallTile(number: 1, title: 'No actuator ancestor',
          description: 'Calling DraggableScrollableActuator.reset(context) '
            'without a DraggableScrollableActuator above the context '
            'triggers an assertion in debug mode. Wrap the scaffold body '
            'or subtree that contains your sheets.',
          fix: 'Wrap with DraggableScrollableActuator(child: ...)',
          accent: s.error),
        const SizedBox(height: 12),
        _PitfallTile(number: 2, title: 'Nested actuators',
          description: 'When two DraggableScrollableActuators are nested, '
            'the innermost one wins. Sheets outside the inner actuator do '
            'not receive the reset.',
          fix: 'Use a single actuator or split your subtrees.',
          accent: s.tertiary),
        const SizedBox(height: 12),
        _PitfallTile(number: 3, title: 'Reset during drag',
          description: 'If the user is actively dragging a sheet when you '
            'call reset, the drag gesture wins until the pointer is lifted. '
            'Disable the reset button while a drag is active to avoid '
            'surprises.',
          fix: 'Gate the button on notification.extent stability.',
          accent: s.primary),
      ],
    );
  }
}
class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.number, required this.title,
    required this.description, required this.fix, required this.accent,
  });
  final int number;
  final Color accent;
  final String title, description, fix;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Material(
      color: s.surface, elevation: 1,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40, height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: accent.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(12)),
              child: Text('#$number',
                style: TextStyle(
                    color: accent, fontWeight: FontWeight.w800))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700,
                        color: accent)),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(fontSize: 12, height: 1.4)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: s.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(999)),
                    child: Text('Fix · $fix',
                      style: TextStyle(
                          color: s.primary, fontSize: 11,
                          fontWeight: FontWeight.w700))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Section 10 · API cheat sheet (bottomNavigationBar) ---
class _ApiCheatSheet extends StatelessWidget {
  const _ApiCheatSheet();
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Material(
      color: s.surface, elevation: 8,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.menu_book_outlined,
                    color: s.primary, size: 18),
                const SizedBox(width: 6),
                Text('API cheat sheet',
                  style: TextStyle(
                      color: s.primary,
                      fontWeight: FontWeight.w800, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 96,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _CheatCard(title: 'DraggableScrollableActuator',
                    body: 'const ctor:\n'
                      '  DraggableScrollableActuator({\n'
                      '    Key? key,\n'
                      '    required Widget child,\n'
                      '  })',
                    accent: s.primary),
                  _CheatCard(title: 'static reset',
                    body: 'static bool reset(BuildContext context)\n'
                      'Returns false when no actuator is found.',
                    accent: s.secondary),
                  _CheatCard(title: 'DraggableScrollableNotification',
                    body: 'extent, minExtent, maxExtent,\n'
                      'context, shouldCloseOnMinExtent',
                    accent: s.tertiary),
                  _CheatCard(title: 'Companion types',
                    body: 'DraggableScrollableSheet,\n'
                      'DraggableScrollableController',
                    accent: s.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _CheatCard extends StatelessWidget {
  const _CheatCard({required this.title, required this.body, required this.accent, });
  final Color accent;
  final String title, body;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
            style: TextStyle(
                color: accent, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 4),
          Expanded(
            child: Text(body,
              style: const TextStyle(
                  fontFamily: 'monospace', fontSize: 11, height: 1.35)),
          ),
        ],
      ),
    );
  }
}
// --- Shared · Section card ---
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon, required this.accent,
    required this.title, required this.body, this.mono = false,
  });
  final IconData icon;
  final Color accent;
  final bool mono;
  final String title, body;
  @override
  Widget build(BuildContext context) {
    final ColorScheme s = Theme.of(context).colorScheme;
    return Material(
      color: s.surface, elevation: 2,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: accent.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: accent)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                    style: TextStyle(
                        color: accent, fontSize: 16,
                        fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(body,
                    style: TextStyle(
                        fontSize: 13, height: 1.45,
                        fontFamily: mono ? 'monospace' : null,
                        color: s.onSurface)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
