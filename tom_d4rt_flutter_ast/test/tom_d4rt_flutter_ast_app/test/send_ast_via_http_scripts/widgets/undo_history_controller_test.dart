// D4rt test script: Deep Demo — UndoHistoryController
// Visual exploration of Flutter's UndoHistoryController, the
// ValueNotifier<UndoHistoryValue> that exposes imperative undo/redo over
// EditableText history, surfaces canUndo/canRedo via its value, and fires
// onUndo / onRedo ChangeNotifiers when the controller is driven.
//
// Styled as a brass + sepia + deep teak "time machine" workshop. No
// main() / runApp(); d4rt harness calls the top-level build() returning a
// MaterialApp. Lots of commentary, several synchronized scenarios, a
// hand-painted history ribbon, and a non-interactive autopilot panel.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// Palette — brass, sepia, deep teak
// ============================================================================

class _UhCtlPalette {
  const _UhCtlPalette();

  // Core woods and metals.
  static const Color teak = Color(0xFF3A2618);
  static const Color teakLight = Color(0xFF5A3A22);
  static const Color teakShadow = Color(0xFF1F1309);
  static const Color sepia = Color(0xFFE8D4A2);
  static const Color sepiaLight = Color(0xFFF4E6C4);
  static const Color sepiaDeep = Color(0xFFB89866);
  static const Color brass = Color(0xFFC89F3C);
  static const Color brassBright = Color(0xFFE7C56A);
  static const Color brassDark = Color(0xFF8A6E22);
  static const Color patina = Color(0xFF5B8A7B);
  static const Color patinaDeep = Color(0xFF2F5A4A);
  static const Color ink = Color(0xFF1B1308);
  static const Color paper = Color(0xFFF7EFD9);
  static const Color paperAged = Color(0xFFE0CE9E);
  static const Color rustRed = Color(0xFFA04A2A);
  static const Color emberOrange = Color(0xFFD67A2E);
  static const Color leafGreen = Color(0xFF5D7A34);
  static const Color skyBlue = Color(0xFF4A6A8C);
  static const Color plum = Color(0xFF6E3A5A);

  static LinearGradient teakGrain() {
    return const LinearGradient(
      colors: <Color>[teak, teakShadow, teak, teakLight, teak],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: <double>[0.0, 0.25, 0.55, 0.8, 1.0],
    );
  }

  static LinearGradient brassStripe() {
    return const LinearGradient(
      colors: <Color>[brassDark, brass, brassBright, brass, brassDark],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: <double>[0.0, 0.3, 0.5, 0.7, 1.0],
    );
  }

  static LinearGradient paperGradient() {
    return const LinearGradient(
      colors: <Color>[paper, sepiaLight, paperAged],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

// ============================================================================
// Hand-painted masthead with a gear motif
// ============================================================================

class _UhCtlGearMotifPainter extends CustomPainter {
  _UhCtlGearMotifPainter({required this.seed});

  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = _UhCtlPalette.teakGrain().createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    // Grain lines.
    final Paint grain = Paint()
      ..color = _UhCtlPalette.teakShadow.withValues(alpha: 0.35)
      ..strokeWidth = 0.6;
    final math.Random rng = math.Random(seed);
    for (int i = 0; i < 48; i++) {
      final double y = rng.nextDouble() * size.height;
      final double x1 = rng.nextDouble() * size.width * 0.3;
      final double x2 = size.width - rng.nextDouble() * size.width * 0.3;
      canvas.drawLine(Offset(x1, y), Offset(x2, y + rng.nextDouble() * 2 - 1), grain);
    }

    // Three brass gears of varying sizes.
    final List<_UhCtlGearSpec> gears = <_UhCtlGearSpec>[
      _UhCtlGearSpec(
        center: Offset(size.width * 0.18, size.height * 0.55),
        radius: size.height * 0.32,
        teeth: 16,
        rotation: 0.05,
      ),
      _UhCtlGearSpec(
        center: Offset(size.width * 0.48, size.height * 0.38),
        radius: size.height * 0.22,
        teeth: 12,
        rotation: 0.35,
      ),
      _UhCtlGearSpec(
        center: Offset(size.width * 0.78, size.height * 0.62),
        radius: size.height * 0.26,
        teeth: 14,
        rotation: 0.62,
      ),
    ];

    for (final _UhCtlGearSpec g in gears) {
      _drawGear(canvas, g);
    }

    // Ornamental hairline border.
    final Paint border = Paint()
      ..color = _UhCtlPalette.brass.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final Rect borderRect = Rect.fromLTWH(4, 4, size.width - 8, size.height - 8);
    canvas.drawRRect(RRect.fromRectAndRadius(borderRect, const Radius.circular(10)), border);
  }

  void _drawGear(Canvas canvas, _UhCtlGearSpec spec) {
    final Path gearPath = Path();
    final int n = spec.teeth;
    final double inner = spec.radius * 0.82;
    final double outer = spec.radius;
    for (int i = 0; i < n * 2; i++) {
      final double angle = (i / (n * 2)) * math.pi * 2 + spec.rotation;
      final double r = i.isEven ? outer : inner;
      final Offset p = spec.center + Offset(math.cos(angle) * r, math.sin(angle) * r);
      if (i == 0) {
        gearPath.moveTo(p.dx, p.dy);
      } else {
        gearPath.lineTo(p.dx, p.dy);
      }
    }
    gearPath.close();

    final Paint body = Paint()
      ..shader = _UhCtlPalette.brassStripe().createShader(
        Rect.fromCircle(center: spec.center, radius: outer),
      );
    canvas.drawPath(gearPath, body);

    final Paint rim = Paint()
      ..color = _UhCtlPalette.brassDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    canvas.drawPath(gearPath, rim);

    final Paint hub = Paint()..color = _UhCtlPalette.teakShadow;
    canvas.drawCircle(spec.center, spec.radius * 0.32, hub);
    final Paint hubRing = Paint()
      ..color = _UhCtlPalette.brassBright
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawCircle(spec.center, spec.radius * 0.32, hubRing);

    // Spokes.
    final Paint spoke = Paint()
      ..color = _UhCtlPalette.brassDark
      ..strokeWidth = 2.0;
    for (int s = 0; s < 4; s++) {
      final double a = spec.rotation + (s / 4) * math.pi * 2;
      final Offset from = spec.center + Offset(math.cos(a) * spec.radius * 0.34, math.sin(a) * spec.radius * 0.34);
      final Offset to = spec.center + Offset(math.cos(a) * spec.radius * 0.78, math.sin(a) * spec.radius * 0.78);
      canvas.drawLine(from, to, spoke);
    }

    // Center screw.
    canvas.drawCircle(spec.center, spec.radius * 0.08, Paint()..color = _UhCtlPalette.brassBright);
    canvas.drawCircle(spec.center, spec.radius * 0.08, rim);
  }

  @override
  bool shouldRepaint(covariant _UhCtlGearMotifPainter oldDelegate) => oldDelegate.seed != seed;
}

class _UhCtlGearSpec {
  _UhCtlGearSpec({
    required this.center,
    required this.radius,
    required this.teeth,
    required this.rotation,
  });
  final Offset center;
  final double radius;
  final int teeth;
  final double rotation;
}

// ============================================================================
// Masthead header
// ============================================================================

class _UhCtlMasthead extends StatelessWidget {
  const _UhCtlMasthead();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomPaint(
            painter: _UhCtlGearMotifPainter(seed: 7),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 22, 26, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _UhCtlPalette.brass.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: _UhCtlPalette.brassDark, width: 1),
                      ),
                      child: const Text(
                        'TIME MACHINE · WORKSHOP',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                          color: _UhCtlPalette.teakShadow,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _UhCtlPalette.patinaDeep,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'ValueNotifier<UndoHistoryValue>',
                        style: TextStyle(
                          fontSize: 10,
                          color: _UhCtlPalette.sepiaLight,
                          fontFamily: 'monospace',
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'UndoHistoryController',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: _UhCtlPalette.sepiaLight,
                    letterSpacing: 0.6,
                    fontFamily: 'serif',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Imperative time-travel across EditableText history, '
                  'observed like any other ValueNotifier.',
                  style: TextStyle(
                    fontSize: 14,
                    color: _UhCtlPalette.sepiaLight.withValues(alpha: 0.82),
                    fontFamily: 'serif',
                    fontStyle: FontStyle.italic,
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

// ============================================================================
// Section header strip
// ============================================================================

class _UhCtlSectionHeader extends StatelessWidget {
  const _UhCtlSectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final int index;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 22, 16, 6),
      padding: const EdgeInsets.fromLTRB(14, 12, 18, 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_UhCtlPalette.teak, _UhCtlPalette.teakLight],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _UhCtlPalette.brassDark, width: 1),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: _UhCtlPalette.brassStripe(),
              shape: BoxShape.circle,
              border: Border.all(color: _UhCtlPalette.brassDark, width: 1.5),
            ),
            child: Center(
              child: Text(
                index.toString().padLeft(2, '0'),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _UhCtlPalette.teakShadow,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _UhCtlPalette.sepiaLight,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'serif',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _UhCtlPalette.sepia.withValues(alpha: 0.85),
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'serif',
                  ),
                ),
              ],
            ),
          ),
          Icon(icon, color: _UhCtlPalette.brassBright, size: 28),
        ],
      ),
    );
  }
}

// ============================================================================
// Preamble card
// ============================================================================

class _UhCtlPreambleEntry {
  const _UhCtlPreambleEntry({
    required this.title,
    required this.body,
    required this.icon,
    required this.accent,
  });
  final String title;
  final String body;
  final IconData icon;
  final Color accent;
}

const List<_UhCtlPreambleEntry> _uhCtlPreamble = <_UhCtlPreambleEntry>[
  _UhCtlPreambleEntry(
    icon: Icons.history,
    accent: _UhCtlPalette.brass,
    title: 'What is UndoHistoryController?',
    body: 'UndoHistoryController extends ValueNotifier<UndoHistoryValue>. '
        'It sits next to an EditableText / TextField and exposes the '
        'current undo stack summary (canUndo, canRedo) as its value. '
        'Calling undo() or redo() on the controller asks the underlying '
        'UndoHistory widget to jump back or forward through its saved '
        'states — without the user ever pressing Ctrl+Z.',
  ),
  _UhCtlPreambleEntry(
    icon: Icons.layers,
    accent: _UhCtlPalette.patina,
    title: 'Where does it fit?',
    body: 'Inside every EditableText there is an UndoHistory<TextEditingValue> '
        'that quietly records the text field\'s state at each meaningful '
        'change. UndoHistoryController is the remote control for that '
        'invisible recorder. TextField exposes an `undoController` '
        'parameter that forwards straight into EditableText, which '
        'forwards into UndoHistory, which drives the controller.',
  ),
  _UhCtlPreambleEntry(
    icon: Icons.notifications_active,
    accent: _UhCtlPalette.emberOrange,
    title: 'Observing state',
    body: 'Because the controller IS a ValueNotifier, you can wrap it in '
        'ValueListenableBuilder<UndoHistoryValue> to rebuild buttons and '
        'badges whenever the stack changes. The controller additionally '
        'exposes onUndo and onRedo (ChangeNotifier) which fire when '
        'undo() / redo() are actually invoked — handy for telemetry and '
        'sound effects, but for UI state you\'ll usually use the value.',
  ),
  _UhCtlPreambleEntry(
    icon: Icons.keyboard_command_key,
    accent: _UhCtlPalette.skyBlue,
    title: 'Keyboard integration',
    body: 'UndoHistory wires itself into DefaultTextEditingShortcuts so that '
        'Ctrl+Z / Cmd+Z / Ctrl+Shift+Z / Cmd+Shift+Z work out of the box. '
        'Your custom buttons and the keyboard shortcuts both walk through '
        'the same underlying stack, and both update the controller\'s '
        'value — so any observer stays in sync regardless of who kicked '
        'off the change.',
  ),
  _UhCtlPreambleEntry(
    icon: Icons.auto_fix_high,
    accent: _UhCtlPalette.leafGreen,
    title: 'Disposal etiquette',
    body: 'An UndoHistoryController holds two inner ChangeNotifiers (onUndo, '
        'onRedo). Calling dispose() on the controller cleans them up as '
        'well. Treat it like a TextEditingController: one controller per '
        'State, created in initState, released in dispose. Sharing a '
        'single controller across many fields is legal but rarely what '
        'you want — the last-bound field wins.',
  ),
];

class _UhCtlPreambleCard extends StatelessWidget {
  const _UhCtlPreambleCard({required this.entry, required this.index});

  final _UhCtlPreambleEntry entry;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: _UhCtlPalette.paperGradient(),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: entry.accent.withValues(alpha: 0.65), width: 1.6),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _UhCtlPalette.teakShadow.withValues(alpha: 0.18),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: entry.accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: entry.accent.withValues(alpha: 0.5)),
              ),
              child: Icon(entry.icon, color: entry.accent, size: 30),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: entry.accent,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          '§${(index + 1).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: _UhCtlPalette.paper,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.title,
                          style: const TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: _UhCtlPalette.ink,
                            fontFamily: 'serif',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    entry.body,
                    style: const TextStyle(
                      fontSize: 13.5,
                      height: 1.45,
                      color: _UhCtlPalette.teakShadow,
                      fontFamily: 'serif',
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
}

// ============================================================================
// Animated gauge badge for canUndo / canRedo
// ============================================================================

class _UhCtlCapabilityBadge extends StatelessWidget {
  const _UhCtlCapabilityBadge({
    required this.label,
    required this.enabled,
    required this.icon,
    required this.activeColor,
  });

  final String label;
  final bool enabled;
  final IconData icon;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final Color bg = enabled ? activeColor : _UhCtlPalette.teakLight;
    final Color fg = enabled ? _UhCtlPalette.teakShadow : _UhCtlPalette.sepia.withValues(alpha: 0.5);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg.withValues(alpha: enabled ? 0.92 : 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: enabled ? _UhCtlPalette.brassDark : _UhCtlPalette.teakShadow,
          width: 1.2,
        ),
        boxShadow: enabled
            ? <BoxShadow>[
                BoxShadow(
                  color: activeColor.withValues(alpha: 0.55),
                  blurRadius: 8,
                  spreadRadius: 0.5,
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: fg),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: fg,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 6),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: enabled ? _UhCtlPalette.leafGreen : _UhCtlPalette.rustRed.withValues(alpha: 0.7),
              border: Border.all(color: _UhCtlPalette.teakShadow, width: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Toolbar button (brass)
// ============================================================================

class _UhCtlToolbarButton extends StatelessWidget {
  const _UhCtlToolbarButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.enabled,
    this.tint,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final Color accent = tint ?? _UhCtlPalette.brass;
    return Opacity(
      opacity: enabled ? 1.0 : 0.45,
      child: Container(
        decoration: BoxDecoration(
          gradient: enabled
              ? _UhCtlPalette.brassStripe()
              : LinearGradient(
                  colors: <Color>[
                    _UhCtlPalette.teakLight.withValues(alpha: 0.6),
                    _UhCtlPalette.teak.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _UhCtlPalette.brassDark, width: 1.2),
          boxShadow: enabled
              ? <BoxShadow>[
                  BoxShadow(
                    color: accent.withValues(alpha: 0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 1.5),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(icon, size: 18, color: _UhCtlPalette.teakShadow),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: _UhCtlPalette.teakShadow,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// History sample (for the ribbon painter)
// ============================================================================

class _UhCtlHistorySample {
  const _UhCtlHistorySample({
    required this.tick,
    required this.canUndo,
    required this.canRedo,
    required this.textLength,
    required this.event,
  });
  final int tick;
  final bool canUndo;
  final bool canRedo;
  final int textLength;
  final String event;
}

// ============================================================================
// History ribbon painter
// ============================================================================

class _UhCtlHistoryRibbonPainter extends CustomPainter {
  _UhCtlHistoryRibbonPainter({
    required this.samples,
    required this.pulse,
  });

  final List<_UhCtlHistorySample> samples;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    // Background.
    final Paint bg = Paint()
      ..shader = _UhCtlPalette.paperGradient().createShader(Offset.zero & size);
    final RRect rr = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8));
    canvas.drawRRect(rr, bg);

    // Faint grid.
    final Paint grid = Paint()
      ..color = _UhCtlPalette.sepiaDeep.withValues(alpha: 0.25)
      ..strokeWidth = 0.6;
    for (int g = 0; g <= 10; g++) {
      final double y = (g / 10) * size.height;
      canvas.drawLine(Offset(12, y), Offset(size.width - 12, y), grid);
    }
    for (int g = 0; g <= 12; g++) {
      final double x = 12 + (g / 12) * (size.width - 24);
      canvas.drawLine(Offset(x, 8), Offset(x, size.height - 8), grid);
    }

    if (samples.isEmpty) {
      final TextPainter tp = TextPainter(
        text: const TextSpan(
          text: 'No samples yet — edit the field to record history',
          style: TextStyle(
            fontSize: 12,
            color: _UhCtlPalette.teakShadow,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout(minWidth: 0, maxWidth: size.width);
      tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));
      return;
    }

    final int maxLen = samples.map((_UhCtlHistorySample s) => s.textLength).fold<int>(1, math.max);
    final double dx = (size.width - 24) / math.max(1, samples.length - 1);

    final Path line = Path();
    for (int i = 0; i < samples.length; i++) {
      final _UhCtlHistorySample s = samples[i];
      final double x = 12 + i * dx;
      final double t = s.textLength / maxLen;
      final double y = size.height - 12 - t * (size.height - 24);
      if (i == 0) {
        line.moveTo(x, y);
      } else {
        line.lineTo(x, y);
      }
    }
    final Paint linePaint = Paint()
      ..color = _UhCtlPalette.rustRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(line, linePaint);

    for (int i = 0; i < samples.length; i++) {
      final _UhCtlHistorySample s = samples[i];
      final double x = 12 + i * dx;
      final double t = s.textLength / maxLen;
      final double y = size.height - 12 - t * (size.height - 24);
      final Color tone = s.canUndo
          ? (s.canRedo ? _UhCtlPalette.plum : _UhCtlPalette.leafGreen)
          : _UhCtlPalette.sepiaDeep;
      canvas.drawCircle(Offset(x, y), 3.5, Paint()..color = tone);
      canvas.drawCircle(
        Offset(x, y),
        3.5,
        Paint()
          ..color = _UhCtlPalette.teakShadow
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8,
      );

      if (i == samples.length - 1) {
        final double radius = 6 + 4 * pulse;
        canvas.drawCircle(
          Offset(x, y),
          radius,
          Paint()
            ..color = tone.withValues(alpha: 0.35 * (1 - pulse))
            ..style = PaintingStyle.fill,
        );
      }
    }

    // Legend.
    const TextStyle legendStyle = TextStyle(
      fontSize: 10,
      color: _UhCtlPalette.teakShadow,
      fontFamily: 'monospace',
      fontWeight: FontWeight.w700,
    );
    final TextPainter legend = TextPainter(
      text: const TextSpan(text: 'length over time', style: legendStyle),
      textDirection: TextDirection.ltr,
    );
    legend.layout();
    legend.paint(canvas, const Offset(14, 6));
  }

  @override
  bool shouldRepaint(covariant _UhCtlHistoryRibbonPainter oldDelegate) =>
      oldDelegate.samples != samples || oldDelegate.pulse != pulse;
}

// ============================================================================
// Primary Time Machine panel (scenario 2)
// ============================================================================

class _UhCtlTimeMachinePanel extends StatefulWidget {
  const _UhCtlTimeMachinePanel();

  @override
  State<_UhCtlTimeMachinePanel> createState() => _UhCtlTimeMachinePanelState();
}

class _UhCtlTimeMachinePanelState extends State<_UhCtlTimeMachinePanel>
    with SingleTickerProviderStateMixin {
  final TextEditingController _text = TextEditingController(
    text: 'Type here, then press Undo to step back through history.',
  );
  final UndoHistoryController _undo = UndoHistoryController();
  final FocusNode _focus = FocusNode();

  final List<_UhCtlHistorySample> _samples = <_UhCtlHistorySample>[];
  int _undoInvocations = 0;
  int _redoInvocations = 0;
  int _tickCounter = 0;
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
    _undo.addListener(_recordSample);
    _undo.onUndo.addListener(_onUndoInvoked);
    _undo.onRedo.addListener(_onRedoInvoked);
    _text.addListener(_recordSample);
    WidgetsBinding.instance.addPostFrameCallback((_) => _recordSample());
  }

  void _onUndoInvoked() {
    setState(() {
      _undoInvocations += 1;
    });
    debugPrint('UndoHistoryController.onUndo fired (#$_undoInvocations)');
  }

  void _onRedoInvoked() {
    setState(() {
      _redoInvocations += 1;
    });
    debugPrint('UndoHistoryController.onRedo fired (#$_redoInvocations)');
  }

  void _recordSample() {
    _tickCounter += 1;
    final _UhCtlHistorySample sample = _UhCtlHistorySample(
      tick: _tickCounter,
      canUndo: _undo.value.canUndo,
      canRedo: _undo.value.canRedo,
      textLength: _text.text.length,
      event: 'observe',
    );
    setState(() {
      _samples.add(sample);
      if (_samples.length > 40) {
        _samples.removeAt(0);
      }
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    _undo.removeListener(_recordSample);
    _undo.onUndo.removeListener(_onUndoInvoked);
    _undo.onRedo.removeListener(_onRedoInvoked);
    _text.removeListener(_recordSample);
    _undo.dispose();
    _text.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: _UhCtlPalette.paperGradient(),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _UhCtlPalette.brassDark, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _UhCtlPalette.teakShadow.withValues(alpha: 0.22),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.panorama_horizontal, color: _UhCtlPalette.rustRed, size: 22),
              const SizedBox(width: 8),
              const Text(
                'Primary Time Machine',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _UhCtlPalette.teakShadow,
                  fontFamily: 'serif',
                ),
              ),
              const Spacer(),
              ValueListenableBuilder<UndoHistoryValue>(
                valueListenable: _undo,
                builder: (BuildContext context, UndoHistoryValue v, Widget? _) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _UhCtlCapabilityBadge(
                        label: 'CAN UNDO',
                        enabled: v.canUndo,
                        icon: Icons.undo,
                        activeColor: _UhCtlPalette.brassBright,
                      ),
                      const SizedBox(width: 8),
                      _UhCtlCapabilityBadge(
                        label: 'CAN REDO',
                        enabled: v.canRedo,
                        icon: Icons.redo,
                        activeColor: _UhCtlPalette.patina,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: _UhCtlPalette.paper,
              border: Border.all(color: _UhCtlPalette.brassDark, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              controller: _text,
              undoController: _undo,
              focusNode: _focus,
              maxLines: 4,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: _UhCtlPalette.ink,
                height: 1.45,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
                hintText: 'A monospaced window onto the undo stack…',
                hintStyle: TextStyle(
                  fontFamily: 'monospace',
                  color: _UhCtlPalette.sepiaDeep,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ValueListenableBuilder<UndoHistoryValue>(
                valueListenable: _undo,
                builder: (BuildContext context, UndoHistoryValue v, Widget? _) {
                  return _UhCtlToolbarButton(
                    icon: Icons.undo,
                    label: 'UNDO',
                    enabled: v.canUndo,
                    tint: _UhCtlPalette.brassBright,
                    onPressed: () {
                      _undo.undo();
                    },
                  );
                },
              ),
              ValueListenableBuilder<UndoHistoryValue>(
                valueListenable: _undo,
                builder: (BuildContext context, UndoHistoryValue v, Widget? _) {
                  return _UhCtlToolbarButton(
                    icon: Icons.redo,
                    label: 'REDO',
                    enabled: v.canRedo,
                    tint: _UhCtlPalette.patina,
                    onPressed: () {
                      _undo.redo();
                    },
                  );
                },
              ),
              _UhCtlToolbarButton(
                icon: Icons.clear_all,
                label: 'CLEAR',
                enabled: true,
                tint: _UhCtlPalette.rustRed,
                onPressed: () {
                  _text.clear();
                },
              ),
              _UhCtlToolbarButton(
                icon: Icons.keyboard_return,
                label: 'SEED',
                enabled: true,
                tint: _UhCtlPalette.skyBlue,
                onPressed: () {
                  _text.text = 'Seeded: ${DateTime.now().toIso8601String()}';
                },
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              _UhCtlCounterChip(
                label: 'onUndo',
                value: _undoInvocations,
                color: _UhCtlPalette.brassBright,
              ),
              const SizedBox(width: 8),
              _UhCtlCounterChip(
                label: 'onRedo',
                value: _redoInvocations,
                color: _UhCtlPalette.patina,
              ),
              const SizedBox(width: 8),
              _UhCtlCounterChip(
                label: 'samples',
                value: _samples.length,
                color: _UhCtlPalette.rustRed,
              ),
              const Spacer(),
              _UhCtlFocusIndicator(focus: _focus),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 110,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (BuildContext context, Widget? _) {
                return CustomPaint(
                  painter: _UhCtlHistoryRibbonPainter(
                    samples: List<_UhCtlHistorySample>.unmodifiable(_samples),
                    pulse: _pulse.value,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Small counter chip
// ============================================================================

class _UhCtlCounterChip extends StatelessWidget {
  const _UhCtlCounterChip({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: _UhCtlPalette.teakShadow,
              fontFamily: 'monospace',
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: _UhCtlPalette.teakShadow,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: _UhCtlPalette.brassBright,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Twin-fields scenario (scenario 3)
// ============================================================================

class _UhCtlTwinFieldsPanel extends StatefulWidget {
  const _UhCtlTwinFieldsPanel();

  @override
  State<_UhCtlTwinFieldsPanel> createState() => _UhCtlTwinFieldsPanelState();
}

class _UhCtlTwinFieldsPanelState extends State<_UhCtlTwinFieldsPanel> {
  // Left side: two fields sharing ONE controller (last-bound wins).
  final UndoHistoryController _sharedCtl = UndoHistoryController();
  final TextEditingController _leftA = TextEditingController(text: 'Left-A shares the controller');
  final TextEditingController _leftB = TextEditingController(text: 'Left-B also binds it');

  // Right side: each field owns its own controller.
  final UndoHistoryController _rightCtlA = UndoHistoryController();
  final UndoHistoryController _rightCtlB = UndoHistoryController();
  final TextEditingController _rightA = TextEditingController(text: 'Right-A has its own stack');
  final TextEditingController _rightB = TextEditingController(text: 'Right-B has its own stack too');

  @override
  void dispose() {
    _sharedCtl.dispose();
    _rightCtlA.dispose();
    _rightCtlB.dispose();
    _leftA.dispose();
    _leftB.dispose();
    _rightA.dispose();
    _rightB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _UhCtlPalette.paper.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _UhCtlPalette.brassDark, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.compare_arrows, color: _UhCtlPalette.plum, size: 22),
              SizedBox(width: 8),
              Text(
                'Shared vs Per-Field Scoping',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _UhCtlPalette.teakShadow,
                  fontFamily: 'serif',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'A single UndoHistoryController tracks whichever EditableText most '
            'recently took it on. Two fields sharing one controller will '
            'fight for ownership — only the last-bound field actually '
            'drives the stack. Usually you want one controller per field.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: _UhCtlPalette.teakShadow,
              fontFamily: 'serif',
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool narrow = constraints.maxWidth < 620;
              final Widget left = _buildSharedColumn();
              final Widget right = _buildSplitColumn();
              if (narrow) {
                return Column(
                  children: <Widget>[
                    left,
                    const SizedBox(height: 12),
                    right,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: left),
                  const SizedBox(width: 16),
                  Expanded(child: right),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSharedColumn() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _UhCtlPalette.sepiaLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _UhCtlPalette.rustRed.withValues(alpha: 0.55), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _UhCtlScenarioHeading(
            title: 'ONE controller, two fields',
            subtitle: 'expected: the second field wins',
            color: _UhCtlPalette.rustRed,
          ),
          const SizedBox(height: 10),
          _UhCtlMiniField(
            label: 'Left-A',
            controller: _leftA,
            undo: _sharedCtl,
          ),
          const SizedBox(height: 8),
          _UhCtlMiniField(
            label: 'Left-B',
            controller: _leftB,
            undo: _sharedCtl,
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<UndoHistoryValue>(
            valueListenable: _sharedCtl,
            builder: (BuildContext context, UndoHistoryValue v, Widget? _) {
              return _UhCtlSharedStatusRow(value: v);
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: ValueListenableBuilder<UndoHistoryValue>(
                  valueListenable: _sharedCtl,
                  builder: (BuildContext context, UndoHistoryValue v, Widget? _) {
                    return _UhCtlToolbarButton(
                      icon: Icons.undo,
                      label: 'UNDO (shared)',
                      enabled: v.canUndo,
                      tint: _UhCtlPalette.rustRed,
                      onPressed: _sharedCtl.undo,
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ValueListenableBuilder<UndoHistoryValue>(
                  valueListenable: _sharedCtl,
                  builder: (BuildContext context, UndoHistoryValue v, Widget? _) {
                    return _UhCtlToolbarButton(
                      icon: Icons.redo,
                      label: 'REDO (shared)',
                      enabled: v.canRedo,
                      tint: _UhCtlPalette.plum,
                      onPressed: _sharedCtl.redo,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSplitColumn() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _UhCtlPalette.sepiaLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _UhCtlPalette.patinaDeep.withValues(alpha: 0.65), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _UhCtlScenarioHeading(
            title: 'TWO controllers, two fields',
            subtitle: 'expected: independent time lines',
            color: _UhCtlPalette.patinaDeep,
          ),
          const SizedBox(height: 10),
          _UhCtlMiniField(
            label: 'Right-A',
            controller: _rightA,
            undo: _rightCtlA,
          ),
          ValueListenableBuilder<UndoHistoryValue>(
            valueListenable: _rightCtlA,
            builder: (BuildContext context, UndoHistoryValue v, Widget? _) {
              return _UhCtlInlineToolbar(
                controller: _rightCtlA,
                canUndo: v.canUndo,
                canRedo: v.canRedo,
                accent: _UhCtlPalette.patina,
              );
            },
          ),
          const SizedBox(height: 10),
          _UhCtlMiniField(
            label: 'Right-B',
            controller: _rightB,
            undo: _rightCtlB,
          ),
          ValueListenableBuilder<UndoHistoryValue>(
            valueListenable: _rightCtlB,
            builder: (BuildContext context, UndoHistoryValue v, Widget? _) {
              return _UhCtlInlineToolbar(
                controller: _rightCtlB,
                canUndo: v.canUndo,
                canRedo: v.canRedo,
                accent: _UhCtlPalette.skyBlue,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _UhCtlMiniField extends StatelessWidget {
  const _UhCtlMiniField({
    required this.label,
    required this.controller,
    required this.undo,
  });
  final String label;
  final TextEditingController controller;
  final UndoHistoryController undo;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 64,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.9,
                color: _UhCtlPalette.teakShadow,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _UhCtlPalette.paper,
              border: Border.all(color: _UhCtlPalette.brassDark, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: controller,
              undoController: undo,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: _UhCtlPalette.ink,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UhCtlScenarioHeading extends StatelessWidget {
  const _UhCtlScenarioHeading({
    required this.title,
    required this.subtitle,
    required this.color,
  });
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: _UhCtlPalette.teakShadow,
                  fontFamily: 'serif',
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: color.withValues(alpha: 0.95),
                  fontFamily: 'serif',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UhCtlSharedStatusRow extends StatelessWidget {
  const _UhCtlSharedStatusRow({required this.value});
  final UndoHistoryValue value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _UhCtlCapabilityBadge(
          label: 'CAN UNDO',
          enabled: value.canUndo,
          icon: Icons.undo,
          activeColor: _UhCtlPalette.brassBright,
        ),
        const SizedBox(width: 8),
        _UhCtlCapabilityBadge(
          label: 'CAN REDO',
          enabled: value.canRedo,
          icon: Icons.redo,
          activeColor: _UhCtlPalette.patina,
        ),
      ],
    );
  }
}

class _UhCtlInlineToolbar extends StatelessWidget {
  const _UhCtlInlineToolbar({
    required this.controller,
    required this.canUndo,
    required this.canRedo,
    required this.accent,
  });
  final UndoHistoryController controller;
  final bool canUndo;
  final bool canRedo;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 64),
      child: Row(
        children: <Widget>[
          _UhCtlIconPill(
            icon: Icons.undo,
            label: 'undo',
            enabled: canUndo,
            accent: accent,
            onTap: controller.undo,
          ),
          const SizedBox(width: 6),
          _UhCtlIconPill(
            icon: Icons.redo,
            label: 'redo',
            enabled: canRedo,
            accent: accent,
            onTap: controller.redo,
          ),
          const Spacer(),
          Text(
            'canUndo=$canUndo · canRedo=$canRedo',
            style: TextStyle(
              fontSize: 10,
              color: _UhCtlPalette.teakShadow.withValues(alpha: 0.85),
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _UhCtlIconPill extends StatelessWidget {
  const _UhCtlIconPill({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.accent,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool enabled;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: Material(
        color: accent.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: 14, color: accent),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _UhCtlPalette.teakShadow,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Focus indicator
// ============================================================================

class _UhCtlFocusIndicator extends StatefulWidget {
  const _UhCtlFocusIndicator({required this.focus});
  final FocusNode focus;

  @override
  State<_UhCtlFocusIndicator> createState() => _UhCtlFocusIndicatorState();
}

class _UhCtlFocusIndicatorState extends State<_UhCtlFocusIndicator> {
  @override
  void initState() {
    super.initState();
    widget.focus.addListener(_onFocus);
  }

  void _onFocus() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.focus.removeListener(_onFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool focused = widget.focus.hasFocus;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: focused
            ? _UhCtlPalette.leafGreen.withValues(alpha: 0.85)
            : _UhCtlPalette.sepiaDeep.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            focused ? Icons.edit : Icons.edit_off,
            size: 14,
            color: focused ? _UhCtlPalette.paper : _UhCtlPalette.teakShadow,
          ),
          const SizedBox(width: 4),
          Text(
            focused ? 'FOCUSED' : 'IDLE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: focused ? _UhCtlPalette.paper : _UhCtlPalette.teakShadow,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Keyboard shortcut reference gallery (scenario 5)
// ============================================================================

class _UhCtlKeyShortcut {
  const _UhCtlKeyShortcut({
    required this.platform,
    required this.keys,
    required this.purpose,
    required this.note,
  });
  final String platform;
  final List<String> keys;
  final String purpose;
  final String note;
}

const List<_UhCtlKeyShortcut> _uhCtlShortcuts = <_UhCtlKeyShortcut>[
  _UhCtlKeyShortcut(
    platform: 'Windows / Linux',
    keys: <String>['Ctrl', 'Z'],
    purpose: 'Undo last change',
    note: 'Works while the TextField has focus; drives the same stack as '
        'UndoHistoryController.undo().',
  ),
  _UhCtlKeyShortcut(
    platform: 'Windows / Linux',
    keys: <String>['Ctrl', 'Shift', 'Z'],
    purpose: 'Redo previously-undone change',
    note: 'Equivalent to UndoHistoryController.redo(). Some apps also accept '
        'Ctrl+Y.',
  ),
  _UhCtlKeyShortcut(
    platform: 'Windows / Linux',
    keys: <String>['Ctrl', 'Y'],
    purpose: 'Redo (alternative)',
    note: 'Honored on Windows by DefaultTextEditingShortcuts for parity with '
        'native editors.',
  ),
  _UhCtlKeyShortcut(
    platform: 'macOS',
    keys: <String>['⌘', 'Z'],
    purpose: 'Undo last change',
    note: 'Cmd+Z is the canonical Mac undo gesture; Flutter wires this the '
        'same way as Ctrl+Z on Linux/Windows.',
  ),
  _UhCtlKeyShortcut(
    platform: 'macOS',
    keys: <String>['⌘', '⇧', 'Z'],
    purpose: 'Redo previously-undone change',
    note: 'Shift+Cmd+Z is the mac-standard redo. The ValueListenable on the '
        'controller updates as soon as the stack actually moves.',
  ),
  _UhCtlKeyShortcut(
    platform: 'All',
    keys: <String>['Backspace'],
    purpose: 'Normal edit',
    note: 'Not an undo — but every edit pushes onto the stack, so '
        'UndoHistoryController.value will reflect it.',
  ),
];

class _UhCtlKeyboardGallery extends StatelessWidget {
  const _UhCtlKeyboardGallery();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_UhCtlPalette.teakLight, _UhCtlPalette.teak],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _UhCtlPalette.brassDark, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.keyboard, color: _UhCtlPalette.brassBright, size: 22),
              SizedBox(width: 8),
              Text(
                'Keyboard Shortcut Gallery',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _UhCtlPalette.sepiaLight,
                  fontFamily: 'serif',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'DefaultTextEditingShortcuts wires Ctrl/Cmd + Z and its variants '
            'into the same UndoHistory that UndoHistoryController drives. '
            'Your value listener stays accurate no matter which path '
            'triggers the change.',
            style: TextStyle(
              fontSize: 12.5,
              color: _UhCtlPalette.sepia.withValues(alpha: 0.9),
              fontFamily: 'serif',
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          ..._uhCtlShortcuts.map<Widget>(_UhCtlShortcutCard.new),
        ],
      ),
    );
  }
}

class _UhCtlShortcutCard extends StatelessWidget {
  const _UhCtlShortcutCard(this.entry);
  final _UhCtlKeyShortcut entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
      decoration: BoxDecoration(
        color: _UhCtlPalette.paper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _UhCtlPalette.brassDark.withValues(alpha: 0.65), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _UhCtlPalette.patinaDeep,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  entry.platform.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                    color: _UhCtlPalette.sepiaLight,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  entry.purpose,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _UhCtlPalette.teakShadow,
                    fontFamily: 'serif',
                  ),
                ),
              ),
              ...entry.keys.expand<Widget>(
                (String k) => <Widget>[
                  const SizedBox(width: 4),
                  _UhCtlKeyCap(label: k),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            entry.note,
            style: const TextStyle(
              fontSize: 11.5,
              color: _UhCtlPalette.ink,
              fontFamily: 'serif',
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _UhCtlKeyCap extends StatelessWidget {
  const _UhCtlKeyCap({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_UhCtlPalette.sepiaLight, _UhCtlPalette.paperAged],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _UhCtlPalette.teakShadow, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _UhCtlPalette.teakShadow.withValues(alpha: 0.35),
            offset: const Offset(0, 1.5),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: _UhCtlPalette.teakShadow,
          fontFamily: 'monospace',
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ============================================================================
// Autopilot panel (scenario 6)
// ============================================================================

class _UhCtlAutopilotStep {
  const _UhCtlAutopilotStep({
    required this.label,
    required this.action,
    required this.explanation,
    required this.icon,
  });
  final String label;
  final String action;
  final String explanation;
  final IconData icon;
}

const List<_UhCtlAutopilotStep> _uhCtlAutopilotScript = <_UhCtlAutopilotStep>[
  _UhCtlAutopilotStep(
    icon: Icons.keyboard,
    label: 'type',
    action: 'setState: text = "Hello"',
    explanation: 'Baseline snapshot: TextEditingValue("Hello", 5).',
  ),
  _UhCtlAutopilotStep(
    icon: Icons.keyboard,
    label: 'type',
    action: 'setState: text = "Hello, Tom"',
    explanation: 'A second snapshot — UndoHistory now has two states.',
  ),
  _UhCtlAutopilotStep(
    icon: Icons.keyboard,
    label: 'type',
    action: 'setState: text = "Hello, Tom!!!"',
    explanation: 'Third snapshot — canUndo is now true, canRedo still false.',
  ),
  _UhCtlAutopilotStep(
    icon: Icons.undo,
    label: 'undo',
    action: 'controller.undo()',
    explanation: 'Jumps back to "Hello, Tom"; controller fires onUndo and '
        'canRedo flips true.',
  ),
  _UhCtlAutopilotStep(
    icon: Icons.undo,
    label: 'undo',
    action: 'controller.undo()',
    explanation: 'Back to "Hello"; both capabilities remain active.',
  ),
  _UhCtlAutopilotStep(
    icon: Icons.redo,
    label: 'redo',
    action: 'controller.redo()',
    explanation: 'Forward to "Hello, Tom" again; onRedo fires once.',
  ),
  _UhCtlAutopilotStep(
    icon: Icons.keyboard,
    label: 'type',
    action: 'setState: text = "Hello, Tom — branched"',
    explanation: 'Editing after an undo chops the redo tail — canRedo flips '
        'back to false.',
  ),
  _UhCtlAutopilotStep(
    icon: Icons.history_toggle_off,
    label: 'final',
    action: 'inspect controller.value',
    explanation: 'UndoHistoryValue(canUndo: true, canRedo: false) — the '
        'single source of truth for our buttons.',
  ),
];

class _UhCtlAutopilotPanel extends StatelessWidget {
  const _UhCtlAutopilotPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: _UhCtlPalette.paperGradient(),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _UhCtlPalette.emberOrange.withValues(alpha: 0.75), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.auto_mode, color: _UhCtlPalette.emberOrange, size: 22),
              SizedBox(width: 8),
              Text(
                'Autopilot — the controller driving itself',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _UhCtlPalette.teakShadow,
                  fontFamily: 'serif',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'A scripted walk-through of what an imperative caller would do: '
            'type some text, undo twice, redo once, then branch. Notice '
            'how the controller\'s value tracks each transition even though '
            'no human pressed Ctrl+Z.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: _UhCtlPalette.teakShadow,
              fontFamily: 'serif',
            ),
          ),
          const SizedBox(height: 12),
          const _UhCtlAutopilotControls(),
          const SizedBox(height: 12),
          for (int i = 0; i < _uhCtlAutopilotScript.length; i++)
            _UhCtlAutopilotRow(
              step: _uhCtlAutopilotScript[i],
              index: i,
              isLast: i == _uhCtlAutopilotScript.length - 1,
            ),
        ],
      ),
    );
  }
}

class _UhCtlAutopilotControls extends StatefulWidget {
  const _UhCtlAutopilotControls();

  @override
  State<_UhCtlAutopilotControls> createState() => _UhCtlAutopilotControlsState();
}

class _UhCtlAutopilotControlsState extends State<_UhCtlAutopilotControls> {
  double _speed = 0.6;
  bool _deepHistory = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _UhCtlPalette.sepiaLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _UhCtlPalette.brassDark.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.speed, size: 18, color: _UhCtlPalette.rustRed),
          const SizedBox(width: 6),
          const Text(
            'Autopilot speed',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _UhCtlPalette.teakShadow,
              fontFamily: 'monospace',
            ),
          ),
          Expanded(
            child: Slider(
              value: _speed,
              min: 0.1,
              max: 1.0,
              divisions: 9,
              activeColor: _UhCtlPalette.rustRed,
              inactiveColor: _UhCtlPalette.sepiaDeep.withValues(alpha: 0.5),
              label: _speed.toStringAsFixed(1),
              onChanged: (double v) {
                setState(() {
                  _speed = v;
                });
                debugPrint('Autopilot speed set to ${v.toStringAsFixed(2)}');
              },
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.layers, size: 18, color: _UhCtlPalette.patinaDeep),
          const SizedBox(width: 4),
          const Text(
            'Deep',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _UhCtlPalette.teakShadow,
              fontFamily: 'monospace',
            ),
          ),
          Switch(
            value: _deepHistory,
            activeThumbColor: _UhCtlPalette.brassBright,
            activeTrackColor: _UhCtlPalette.brassDark,
            inactiveThumbColor: _UhCtlPalette.sepiaDeep,
            inactiveTrackColor: _UhCtlPalette.teakLight,
            onChanged: (bool v) {
              setState(() {
                _deepHistory = v;
              });
              debugPrint('Deep history toggled: $v');
            },
          ),
        ],
      ),
    );
  }
}

class _UhCtlAutopilotRow extends StatelessWidget {
  const _UhCtlAutopilotRow({
    required this.step,
    required this.index,
    required this.isLast,
  });
  final _UhCtlAutopilotStep step;
  final int index;
  final bool isLast;

  Color get _accent {
    switch (step.label) {
      case 'undo':
        return _UhCtlPalette.brassBright;
      case 'redo':
        return _UhCtlPalette.patina;
      case 'type':
        return _UhCtlPalette.skyBlue;
      default:
        return _UhCtlPalette.rustRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _accent,
                  shape: BoxShape.circle,
                  border: Border.all(color: _UhCtlPalette.teakShadow, width: 1.2),
                ),
                alignment: Alignment.center,
                child: Text(
                  (index + 1).toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _UhCtlPalette.teakShadow,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: _UhCtlPalette.brassDark.withValues(alpha: 0.5),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _UhCtlPalette.paper,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _accent.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(step.icon, size: 16, color: _accent),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: _accent.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          step.label.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: _accent.computeLuminance() > 0.6
                                ? _UhCtlPalette.teakShadow
                                : _UhCtlPalette.teakShadow,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          step.action,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: _UhCtlPalette.ink,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step.explanation,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _UhCtlPalette.teakShadow,
                      fontFamily: 'serif',
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Epilogue (scenario 7)
// ============================================================================

class _UhCtlEpilogueEntry {
  const _UhCtlEpilogueEntry({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });
  final IconData icon;
  final String title;
  final String body;
  final Color accent;
}

const List<_UhCtlEpilogueEntry> _uhCtlEpilogue = <_UhCtlEpilogueEntry>[
  _UhCtlEpilogueEntry(
    icon: Icons.delete_sweep,
    accent: _UhCtlPalette.rustRed,
    title: 'Always dispose()',
    body: 'UndoHistoryController owns two ChangeNotifiers (onUndo, onRedo). '
        'Forgetting to dispose leaks them. The canonical spot is the '
        'State\'s dispose() method — mirror your TextEditingController '
        'disposal discipline.',
  ),
  _UhCtlEpilogueEntry(
    icon: Icons.warning_amber,
    accent: _UhCtlPalette.emberOrange,
    title: 'Last-bound wins',
    body: 'Binding a single UndoHistoryController to multiple EditableTexts '
        'works but only the most-recently-attached field actually drives '
        'the value. Usually you want one controller per field.',
  ),
  _UhCtlEpilogueEntry(
    icon: Icons.memory,
    accent: _UhCtlPalette.patinaDeep,
    title: 'History is bounded',
    body: 'UndoHistory uses an internal stack with a cap '
        '(maxHistoryLength). The cap stops a long-lived field from '
        'eating unbounded memory. Configure it on the UndoHistory '
        'widget, not the controller.',
  ),
  _UhCtlEpilogueEntry(
    icon: Icons.sync_problem,
    accent: _UhCtlPalette.plum,
    title: 'Programmatic text writes still push states',
    body: 'Setting TextEditingController.text programmatically creates a '
        'new state that UndoHistory will record. Autopilot scripts that '
        'want "invisible" writes should use focusedContext carefully '
        'or pre-seed history.',
  ),
  _UhCtlEpilogueEntry(
    icon: Icons.visibility,
    accent: _UhCtlPalette.leafGreen,
    title: 'Prefer ValueListenableBuilder',
    body: 'For UI reactive to canUndo/canRedo, use the controller as a '
        'ValueListenable rather than subscribing to onUndo/onRedo. '
        'Those two ChangeNotifiers are great for side effects (sound, '
        'telemetry) but miss keyboard-driven edits.',
  ),
  _UhCtlEpilogueEntry(
    icon: Icons.shield_moon,
    accent: _UhCtlPalette.skyBlue,
    title: 'Interplay with form validation',
    body: 'Undo/redo bypasses the form validator pipeline; if your form '
        'validates on-change, make sure the validator also runs after '
        'an undo so error messages stay in sync with the restored '
        'text.',
  ),
];

class _UhCtlEpiloguePanel extends StatelessWidget {
  const _UhCtlEpiloguePanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _UhCtlPalette.paper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _UhCtlPalette.brassDark, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.menu_book, color: _UhCtlPalette.rustRed, size: 22),
              SizedBox(width: 8),
              Text(
                'Epilogue — lifecycle notes & gotchas',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _UhCtlPalette.teakShadow,
                  fontFamily: 'serif',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ..._uhCtlEpilogue.map<Widget>(_UhCtlEpilogueRow.new),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _UhCtlPalette.teakShadow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '// The quiet summary:\n'
              '// UndoHistoryController is a ValueNotifier with two bonus\n'
              '// ChangeNotifiers. Treat it like any other controller:\n'
              '// create in initState, dispose in dispose, observe via\n'
              '// ValueListenableBuilder, drive imperatively when needed.',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.5,
                color: _UhCtlPalette.brassBright,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UhCtlEpilogueRow extends StatelessWidget {
  const _UhCtlEpilogueRow(this.entry);
  final _UhCtlEpilogueEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: entry.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: entry.accent.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(entry.icon, color: entry.accent, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: _UhCtlPalette.teakShadow,
                    fontFamily: 'serif',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _UhCtlPalette.teakShadow,
                    fontFamily: 'serif',
                    height: 1.45,
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

// ============================================================================
// Footer — reference links (non-interactive)
// ============================================================================

class _UhCtlFooter extends StatelessWidget {
  const _UhCtlFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_UhCtlPalette.teakShadow, _UhCtlPalette.teak],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _UhCtlPalette.brassDark, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(Icons.link, color: _UhCtlPalette.brassBright, size: 18),
              SizedBox(width: 6),
              Text(
                'Further reading',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: _UhCtlPalette.sepiaLight,
                  fontFamily: 'serif',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final String line in <String>[
            '• packages/flutter/lib/src/widgets/undo_history.dart',
            '• packages/flutter/lib/src/widgets/editable_text.dart (undoController)',
            '• packages/flutter/lib/src/material/text_field.dart (undoController)',
            '• examples/api/lib/widgets/undo_history/undo_history_controller.0.dart',
            '• DefaultTextEditingShortcuts — Ctrl/Cmd+Z bindings',
          ])
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                line,
                style: TextStyle(
                  fontSize: 11.5,
                  color: _UhCtlPalette.sepia.withValues(alpha: 0.9),
                  fontFamily: 'monospace',
                ),
              ),
            ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _UhCtlPalette.brass,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Text(
                  'demo · d4rt',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: _UhCtlPalette.teakShadow,
                    fontFamily: 'monospace',
                    letterSpacing: 0.9,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'no runApp, no main — just build(BuildContext)',
                style: TextStyle(
                  fontSize: 11,
                  color: _UhCtlPalette.sepia.withValues(alpha: 0.85),
                  fontFamily: 'monospace',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Root demo widget
// ============================================================================

class _UhCtlDemo extends StatelessWidget {
  const _UhCtlDemo();

  @override
  Widget build(BuildContext context) {
    debugPrint('UndoHistoryController deep demo: assembling scroll view');
    return Theme(
      data: _uhCtlTheme(),
      child: Scaffold(
        backgroundColor: _UhCtlPalette.teak,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const _UhCtlMasthead(),
              const _UhCtlSectionHeader(
                index: 1,
                title: 'Preamble',
                subtitle: 'What, where, and when the controller matters.',
                icon: Icons.article,
              ),
              for (int i = 0; i < _uhCtlPreamble.length; i++)
                _UhCtlPreambleCard(entry: _uhCtlPreamble[i], index: i),
              const _UhCtlSectionHeader(
                index: 2,
                title: 'Time Machine',
                subtitle: 'A single field, a controller, a live history ribbon.',
                icon: Icons.cast_for_education,
              ),
              const _UhCtlTimeMachinePanel(),
              const _UhCtlSectionHeader(
                index: 3,
                title: 'Scoping',
                subtitle: 'Shared vs per-field controllers — and why it matters.',
                icon: Icons.scatter_plot,
              ),
              const _UhCtlTwinFieldsPanel(),
              const _UhCtlSectionHeader(
                index: 4,
                title: 'Keyboard',
                subtitle: 'The same stack, reachable via Ctrl / Cmd chords.',
                icon: Icons.keyboard,
              ),
              const _UhCtlKeyboardGallery(),
              const _UhCtlSectionHeader(
                index: 5,
                title: 'Autopilot',
                subtitle: 'A scripted walk-through of controller-driven state.',
                icon: Icons.smart_toy,
              ),
              const _UhCtlAutopilotPanel(),
              const _UhCtlSectionHeader(
                index: 6,
                title: 'Epilogue',
                subtitle: 'Lifecycle notes and the things that surprise you.',
                icon: Icons.emoji_objects,
              ),
              const _UhCtlEpiloguePanel(),
              const _UhCtlFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

ThemeData _uhCtlTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _UhCtlPalette.teak,
    colorScheme: const ColorScheme.dark(
      primary: _UhCtlPalette.brass,
      secondary: _UhCtlPalette.patina,
      surface: _UhCtlPalette.teak,
      onSurface: _UhCtlPalette.sepiaLight,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: _UhCtlPalette.rustRed,
      selectionColor: _UhCtlPalette.brass,
      selectionHandleColor: _UhCtlPalette.brassDark,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: _UhCtlPalette.rustRed,
      inactiveTrackColor: _UhCtlPalette.sepiaDeep.withValues(alpha: 0.5),
      thumbColor: _UhCtlPalette.brassBright,
    ),
  );
}

// ============================================================================
// d4rt harness entry point
// ============================================================================

dynamic build(BuildContext context) {
  debugPrint('--------------------------------------------------------');
  debugPrint('UndoHistoryController deep demo — d4rt AST harness start');
  debugPrint('Scenarios: preamble, time machine, twin scoping,');
  debugPrint('           history ribbon, keyboard gallery, autopilot,');
  debugPrint('           epilogue, footer.');
  debugPrint('--------------------------------------------------------');
  // Touch a bit of services just so the import earns its keep; also helps
  // downstream AST harnesses verify services is reachable in the d4rt
  // environment. We do not mutate any actual system state.
  final LogicalKeyboardKey zKey = LogicalKeyboardKey.keyZ;
  debugPrint('Keyboard Z key debug label: ${zKey.debugName ?? 'keyZ'}');
  return MaterialApp(
    title: 'UndoHistoryController · Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: _uhCtlTheme(),
    home: const _UhCtlDemo(),
  );
}
