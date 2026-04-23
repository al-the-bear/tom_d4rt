import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =====================================================================
// Select-All Command Center — a hand-authored, deep visual demo of
// SelectAllTextIntent. It shows three concentric rings of usage:
//
//   Tier A  TextField   inside a Shortcuts + Actions scope. The custom
//                       action logs the dispatch and then delegates
//                       to the framework's default handler by walking
//                       up the Actions chain via Actions.maybeInvoke.
//
//   Tier B  SelectableText wrapped in Shortcuts + Actions where the
//                       keyboard-origin intent carries
//                       SelectionChangedCause.keyboard.
//
//   Tier C  SelectionArea around a rich passage, with a toolbar
//                       button that dispatches
//                       SelectAllTextIntent(SelectionChangedCause.toolbar)
//                       via Actions.invoke.
//
// Along the way the demo draws: a keycap HUD that glows each time the
// intent is fired, a dispatch log with timestamp + cause + source
// tier, a cross-platform shortcut table, three instructional panels,
// and a wide animated hero strip that sweeps a dotted selection
// rectangle across simulated glyphs left-to-right.
//
// Palette
//   slate          0xFF1E293B
//   slate-dark     0xFF0F172A
//   amber          0xFFFBBF24
//   amber-soft     0xFFF59E0B
//   cream          0xFFFEF3C7
//   ink            0xFF111827
//
// Entry point for the d4rt AST harness — no main(), no runApp().
// =====================================================================

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SelectAllTextIntent Command Center',
    home: _SelectAllCommandCenterHome(),
  );
}

// ---------------------------------------------------------------------
// Root — owns: dispatch log, keycap pulse timer, hero sweep animation,
// focus nodes for each tier, and platform-aware activator selection.
// ---------------------------------------------------------------------

class _SelectAllCommandCenterHome extends StatefulWidget {
  const _SelectAllCommandCenterHome();

  @override
  State<_SelectAllCommandCenterHome> createState() =>
      _SelectAllCommandCenterHomeState();
}

class _SelectAllCommandCenterHomeState
    extends State<_SelectAllCommandCenterHome>
    with TickerProviderStateMixin {
  // Dispatch log — newest first, max 8 rows.
  final List<_DispatchLogEntry> _log = <_DispatchLogEntry>[];

  // Focus nodes so each tier can individually receive keystrokes.
  final FocusNode _tierAFocus = FocusNode(debugLabel: 'tier-A-textfield');
  final FocusNode _tierBFocus = FocusNode(debugLabel: 'tier-B-selectable');
  final FocusNode _tierCFocus = FocusNode(debugLabel: 'tier-C-selection-area');

  // Controllers / selection state for the tiers.
  final TextEditingController _tierAController = TextEditingController(
    text:
        'Tier A — a classic TextField.\n'
        'Press Ctrl/Cmd+A to fire the SelectAllTextIntent.\n'
        'The custom action logs and delegates to the default handler.',
  );

  // Key used to render the toolbar button's ripple target in Tier C.
  final GlobalKey _tierCButtonKey = GlobalKey();

  // Keycap HUD pulse controller — drives ripple + glow on each fire.
  late final AnimationController _keycapPulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 620),
  );

  // Hero sweep controller — drives the dotted selection rectangle
  // creeping across the simulated glyph strip at the top of the page.
  late final AnimationController _heroSweep = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat(reverse: true);

  // Most recent label shown on the keycap HUD.
  String _lastKeycapLabel = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _tierAFocus.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _tierAFocus.dispose();
    _tierBFocus.dispose();
    _tierCFocus.dispose();
    _tierAController.dispose();
    _keycapPulse.dispose();
    _heroSweep.dispose();
    super.dispose();
  }

  // Central dispatch logger used by every tier's action.
  void _recordDispatch({
    required String tier,
    required SelectionChangedCause cause,
    required String origin,
    required String keycapLabel,
  }) {
    final DateTime now = DateTime.now();
    setState(() {
      _log.insert(
        0,
        _DispatchLogEntry(
          tier: tier,
          cause: cause,
          origin: origin,
          at: now,
        ),
      );
      if (_log.length > 8) {
        _log.removeLast();
      }
      _lastKeycapLabel = keycapLabel;
    });
    _keycapPulse
      ..stop()
      ..forward(from: 0);
    debugPrint(
      'SelectAllTextIntent dispatched — tier=$tier cause=${cause.name} '
      'origin=$origin at=${now.toIso8601String()}',
    );
  }

  // Returns the appropriate Ctrl/Cmd activator for the host platform.
  SingleActivator _selectAllActivator() {
    final bool useMeta = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.iOS;
    return SingleActivator(
      LogicalKeyboardKey.keyA,
      meta: useMeta,
      control: !useMeta,
    );
  }

  // Human-readable keycap label for the platform.
  String _platformKeycapLabel() {
    final bool useMeta = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.iOS;
    return useMeta ? 'Cmd+A' : 'Ctrl+A';
  }

  @override
  Widget build(BuildContext context) {
    final SingleActivator selectAllActivator = _selectAllActivator();
    final String keycapLabel = _platformKeycapLabel();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SelectionSweepHero(progress: _heroSweep),
              const SizedBox(height: 22),
              _SelectAllKeycapHero(
                pulse: _keycapPulse,
                keycapLabel:
                    _lastKeycapLabel.isEmpty ? keycapLabel : _lastKeycapLabel,
              ),
              const SizedBox(height: 24),
              _buildTierA(selectAllActivator, keycapLabel),
              const SizedBox(height: 18),
              _buildTierB(selectAllActivator, keycapLabel),
              const SizedBox(height: 18),
              _buildTierC(),
              const SizedBox(height: 22),
              _DispatchLog(entries: _log),
              const SizedBox(height: 22),
              const _PlatformMappingTable(),
              const SizedBox(height: 22),
              const _InstructionalTrio(),
              const SizedBox(height: 22),
              const _FooterBadge(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1E293B),
      foregroundColor: const Color(0xFFFEF3C7),
      elevation: 0,
      title: Row(
        children: const <Widget>[
          Icon(Icons.select_all, color: Color(0xFFFBBF24)),
          SizedBox(width: 10),
          Text(
            'Select-All Command Center',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(width: 12),
          _HeaderChip(label: 'SelectAllTextIntent'),
        ],
      ),
      actions: const <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Center(child: _HeaderChip(label: 'Intents / Actions')),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------
  // Tier A — TextField, Shortcuts + Actions. Logs + delegates.
  // -------------------------------------------------------------------
  Widget _buildTierA(SingleActivator activator, String keycapLabel) {
    return _TierCard(
      tag: 'A',
      accent: const Color(0xFFFBBF24),
      title: 'Tier A — System handler + logger',
      subtitle:
          'TextField inside Shortcuts + Actions. Custom action logs the '
          'intent and then delegates to the next Actions scope up the '
          'tree via Actions.maybeInvoke, letting the default system '
          'handler perform the actual selection.',
      chips: const <String>['TextField', 'Shortcuts', 'Actions.maybeInvoke'],
      body: Focus(
        focusNode: _tierAFocus,
        child: Shortcuts(
          shortcuts: <ShortcutActivator, Intent>{
            activator: const SelectAllTextIntent(SelectionChangedCause.keyboard),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              SelectAllTextIntent: _TierALoggingSelectAllAction(
                onDispatched: (SelectionChangedCause cause) {
                  _recordDispatch(
                    tier: 'A',
                    cause: cause,
                    origin: 'keyboard shortcut',
                    keycapLabel: keycapLabel,
                  );
                },
              ),
            },
            child: Builder(
              builder: (BuildContext builderContext) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFFBBF24)
                              .withValues(alpha: 0.55),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _tierAController,
                        maxLines: 3,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontFamily: 'monospace',
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        _CauseBadge(
                          cause: SelectionChangedCause.keyboard,
                          accent: const Color(0xFFFBBF24),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Focus the field above and press $keycapLabel.',
                            style: const TextStyle(
                              color: Color(0xFFCBD5F5),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        _SimulateButton(
                          label: 'Simulate key',
                          onPressed: () {
                            Actions.maybeInvoke<SelectAllTextIntent>(
                              builderContext,
                              const SelectAllTextIntent(
                                SelectionChangedCause.keyboard,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // Tier B — SelectableText with a keyboard-origin intent.
  // -------------------------------------------------------------------
  Widget _buildTierB(SingleActivator activator, String keycapLabel) {
    return _TierCard(
      tag: 'B',
      accent: const Color(0xFFF59E0B),
      title: 'Tier B — SelectableText + keyboard cause',
      subtitle:
          'A SelectableText wrapped in its own Shortcuts + Actions scope. '
          'The dispatched intent carries SelectionChangedCause.keyboard, '
          'signalling to the framework that the selection change '
          'originated from a physical keypress.',
      chips: const <String>[
        'SelectableText',
        'Shortcuts',
        'cause = keyboard',
      ],
      body: Focus(
        focusNode: _tierBFocus,
        child: Shortcuts(
          shortcuts: <ShortcutActivator, Intent>{
            activator: const SelectAllTextIntent(SelectionChangedCause.keyboard),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              SelectAllTextIntent: _TierBSelectableLogger(
                onDispatched: (SelectionChangedCause cause) {
                  _recordDispatch(
                    tier: 'B',
                    cause: cause,
                    origin: 'keyboard shortcut',
                    keycapLabel: keycapLabel,
                  );
                },
              ),
            },
            child: Builder(
              builder: (BuildContext builderContext) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _tierBFocus.requestFocus(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFF59E0B)
                                .withValues(alpha: 0.55),
                          ),
                        ),
                        padding: const EdgeInsets.all(14),
                        child: const SelectableText(
                          'Tier B is a SelectableText widget. When this '
                          'scope is focused the Ctrl/Cmd+A shortcut is '
                          'caught by the Shortcuts above, turned into a '
                          'SelectAllTextIntent, and handed to this tier\'s '
                          'Action which marks the cause as "keyboard".',
                          style: TextStyle(
                            color: Color(0xFF111827),
                            height: 1.45,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        _CauseBadge(
                          cause: SelectionChangedCause.keyboard,
                          accent: const Color(0xFFF59E0B),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Click inside once to focus, then press '
                            '$keycapLabel.',
                            style: const TextStyle(
                              color: Color(0xFFCBD5F5),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        _SimulateButton(
                          label: 'Simulate intent',
                          onPressed: () {
                            Actions.maybeInvoke<SelectAllTextIntent>(
                              builderContext,
                              const SelectAllTextIntent(
                                SelectionChangedCause.keyboard,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // Tier C — SelectionArea + toolbar dispatch.
  // -------------------------------------------------------------------
  Widget _buildTierC() {
    return _TierCard(
      tag: 'C',
      accent: const Color(0xFFEAB308),
      title: 'Tier C — Toolbar dispatch (cause = toolbar)',
      subtitle:
          'A rich passage wrapped in SelectionArea. A toolbar button '
          'dispatches SelectAllTextIntent(SelectionChangedCause.toolbar) '
          'through Actions.invoke of the button\'s BuildContext, showing '
          'that Intents unify keyboard and toolbar code paths.',
      chips: const <String>[
        'SelectionArea',
        'Actions.invoke',
        'cause = toolbar',
      ],
      body: Focus(
        focusNode: _tierCFocus,
        child: Actions(
          actions: <Type, Action<Intent>>{
            SelectAllTextIntent: _TierCToolbarLogger(
              onDispatched: (SelectionChangedCause cause) {
                _recordDispatch(
                  tier: 'C',
                  cause: cause,
                  origin: 'toolbar button',
                  keycapLabel: _platformKeycapLabel(),
                );
              },
            ),
          },
          child: Builder(
            builder: (BuildContext builderContext) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SelectionArea(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFEAB308)
                              .withValues(alpha: 0.55),
                        ),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: const _RichPassage(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      _CauseBadge(
                        cause: SelectionChangedCause.toolbar,
                        accent: const Color(0xFFEAB308),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'No keyboard here — the button dispatches the '
                          'intent with a toolbar cause.',
                          style: TextStyle(
                            color: Color(0xFFCBD5F5),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      _ToolbarDispatchButton(
                        buttonKey: _tierCButtonKey,
                        onPressed: () {
                          Actions.invoke<SelectAllTextIntent>(
                            builderContext,
                            const SelectAllTextIntent(
                              SelectionChangedCause.toolbar,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// Hero strip — a CustomPainter that sweeps a dotted selection
// rectangle across a row of simulated glyph blocks, left to right,
// to visually suggest "select all".
// =====================================================================

class _SelectionSweepHero extends StatelessWidget {
  const _SelectionSweepHero({required this.progress});

  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF1E293B), Color(0xFF0F172A)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFBBF24).withValues(alpha: 0.3),
          width: 1.1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: AnimatedBuilder(
        animation: progress,
        builder: (BuildContext context, Widget? child) {
          return CustomPaint(
            painter: _SelectionSweepPainter(progress: progress.value),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _SelectionSweepPainter extends CustomPainter {
  _SelectionSweepPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw a row of simulated glyph blocks of varying widths.
    final math.Random rand = math.Random(42);
    final List<double> glyphWidths = <double>[];
    double cursor = 0;
    while (cursor < size.width - 18) {
      final double w = 6 + rand.nextDouble() * 14;
      glyphWidths.add(w);
      cursor += w + 4;
    }

    final Paint glyphPaint = Paint()
      ..color = const Color(0xFFFEF3C7).withValues(alpha: 0.78);
    final double glyphTop = size.height * 0.35;
    final double glyphHeight = size.height * 0.30;

    double x = 0;
    for (final double w in glyphWidths) {
      final Rect r = Rect.fromLTWH(x, glyphTop, w, glyphHeight);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(2));
      canvas.drawRRect(rr, glyphPaint);
      x += w + 4;
    }

    // Dotted "selection" rectangle that sweeps left→right as progress
    // rises from 0 to 1. Progress oscillates (0→1→0) so the hero
    // sweeps back and forth like a scanning beam.
    final double sweepWidth = size.width * 0.96;
    final double selectionRight = sweepWidth * progress;
    final Rect selection = Rect.fromLTWH(
      0,
      glyphTop - 6,
      selectionRight,
      glyphHeight + 12,
    );

    final Paint highlight = Paint()
      ..color = const Color(0xFFFBBF24).withValues(alpha: 0.22);
    canvas.drawRRect(
      RRect.fromRectAndRadius(selection, const Radius.circular(4)),
      highlight,
    );

    // Dotted border around the selection.
    final Paint dotPaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..strokeWidth = 1.6;
    const double dot = 3;
    const double gap = 3;
    final double rectTop = selection.top;
    final double rectBottom = selection.bottom;
    double xx = 0;
    while (xx < selection.right) {
      canvas.drawLine(
        Offset(xx, rectTop),
        Offset(math.min(xx + dot, selection.right), rectTop),
        dotPaint,
      );
      canvas.drawLine(
        Offset(xx, rectBottom),
        Offset(math.min(xx + dot, selection.right), rectBottom),
        dotPaint,
      );
      xx += dot + gap;
    }
    double yy = rectTop;
    while (yy < rectBottom) {
      canvas.drawLine(
        Offset(selection.right, yy),
        Offset(selection.right, math.min(yy + dot, rectBottom)),
        dotPaint,
      );
      yy += dot + gap;
    }

    // Tiny caret at the sweep frontier.
    final Paint caretPaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..strokeWidth = 2.0;
    canvas.drawLine(
      Offset(selection.right, rectTop - 3),
      Offset(selection.right, rectBottom + 3),
      caretPaint,
    );

    // Title line across the top.
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'Sweep of SelectAllTextIntent — cause travels with the intent',
        style: TextStyle(
          color: Color(0xFFFEF3C7),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    tp.paint(canvas, Offset(0, 4));
  }

  @override
  bool shouldRepaint(covariant _SelectionSweepPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// =====================================================================
// Keycap HUD — oversized Ctrl/Cmd + A keys rendered via CustomPaint,
// with a ripple + amber glow that fires on each dispatched intent.
// =====================================================================

class _SelectAllKeycapHero extends StatelessWidget {
  const _SelectAllKeycapHero({
    required this.pulse,
    required this.keycapLabel,
  });

  final Animation<double> pulse;
  final String keycapLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFBBF24).withValues(alpha: 0.45),
          width: 1.2,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.keyboard_alt_outlined,
                  color: Color(0xFFFBBF24), size: 20),
              SizedBox(width: 8),
              Text(
                'Keycap HUD',
                style: TextStyle(
                  color: Color(0xFFFEF3C7),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(width: 10),
              _HeaderChip(label: 'pulses on each dispatch'),
            ],
          ),
          const SizedBox(height: 14),
          AnimatedBuilder(
            animation: pulse,
            builder: (BuildContext context, Widget? child) {
              return SizedBox(
                height: 120,
                child: CustomPaint(
                  painter: _KeycapHeroPainter(
                    pulse: pulse.value,
                    label: keycapLabel,
                  ),
                  child: const SizedBox.expand(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _KeycapHeroPainter extends CustomPainter {
  _KeycapHeroPainter({required this.pulse, required this.label});

  final double pulse;
  final String label;

  @override
  void paint(Canvas canvas, Size size) {
    // Divide into two keycaps: left = modifier, right = A.
    const double gap = 22;
    final double keyW = (size.width - gap) / 2;
    final Rect leftRect =
        Rect.fromLTWH(0, 0, keyW, size.height).deflate(6);
    final Rect rightRect =
        Rect.fromLTWH(keyW + gap, 0, keyW, size.height).deflate(6);

    _drawKeycap(
      canvas,
      rect: leftRect,
      label: label.startsWith('Cmd') ? 'Cmd' : 'Ctrl',
      glow: pulse,
      accent: const Color(0xFFFBBF24),
    );
    _drawKeycap(
      canvas,
      rect: rightRect,
      label: 'A',
      glow: pulse,
      accent: const Color(0xFFF59E0B),
      bigLabel: true,
    );

    // Plus sign between them.
    final Paint plus = Paint()
      ..color = const Color(0xFFFEF3C7)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    final Offset center = Offset(keyW + gap / 2, size.height / 2);
    canvas.drawLine(
      center.translate(-7, 0),
      center.translate(7, 0),
      plus,
    );
    canvas.drawLine(
      center.translate(0, -7),
      center.translate(0, 7),
      plus,
    );
  }

  void _drawKeycap(
    Canvas canvas, {
    required Rect rect,
    required String label,
    required double glow,
    required Color accent,
    bool bigLabel = false,
  }) {
    // Ripple ring — expands and fades as pulse rises.
    if (glow > 0) {
      final Paint ripple = Paint()
        ..color = accent.withValues(alpha: (1 - glow) * 0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      final double expand = glow * 28;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          rect.inflate(expand),
          Radius.circular(18 + expand * 0.4),
        ),
        ripple,
      );
    }

    // Keycap body.
    final Paint body = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          const Color(0xFF334155),
          const Color(0xFF1E293B),
        ],
      ).createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(14)),
      body,
    );

    // Inner lip.
    final Paint lip = Paint()
      ..color = accent.withValues(alpha: 0.55 + glow * 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect.deflate(5), const Radius.circular(10)),
      lip,
    );

    // Glow overlay — brighter when pulse is fresh.
    if (glow > 0) {
      final Paint glowPaint = Paint()
        ..color = accent.withValues(alpha: (1 - glow) * 0.22);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect.deflate(3), const Radius.circular(12)),
        glowPaint,
      );
    }

    // Label text.
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: const Color(0xFFFEF3C7),
          fontSize: bigLabel ? 42 : 24,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(
        rect.center.dx - tp.width / 2,
        rect.center.dy - tp.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _KeycapHeroPainter oldDelegate) =>
      oldDelegate.pulse != pulse || oldDelegate.label != label;
}

// =====================================================================
// TierCard — the shared frame used by each of the three tier sections.
// It's implemented here (not as a reusable library) to match the
// hand-sculpted style of this demo.
// =====================================================================

class _TierCard extends StatelessWidget {
  const _TierCard({
    required this.tag,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.chips,
    required this.body,
  });

  final String tag;
  final Color accent;
  final String title;
  final String subtitle;
  final List<String> chips;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: accent.withValues(alpha: 0.45),
          width: 1.1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              _TierTag(tag: tag, accent: accent),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFFEF3C7),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFFCBD5F5),
              fontSize: 12,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: chips
                .map<Widget>((String c) => _InlineChip(label: c, accent: accent))
                .toList(growable: false),
          ),
          const SizedBox(height: 14),
          body,
        ],
      ),
    );
  }
}

class _TierTag extends StatelessWidget {
  const _TierTag({required this.tag, required this.accent});

  final String tag;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.8)),
      ),
      alignment: Alignment.center,
      child: Text(
        tag,
        style: TextStyle(
          color: accent,
          fontWeight: FontWeight.w800,
          fontSize: 16,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _InlineChip extends StatelessWidget {
  const _InlineChip({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accent.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: accent,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFFBBF24).withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFFBBF24).withValues(alpha: 0.65),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFFBBF24),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// =====================================================================
// CauseBadge — shows the SelectionChangedCause as a pill.
// =====================================================================

class _CauseBadge extends StatelessWidget {
  const _CauseBadge({required this.cause, required this.accent});

  final SelectionChangedCause cause;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(_iconFor(cause), size: 14, color: accent),
          const SizedBox(width: 6),
          Text(
            'cause = ${cause.name}',
            style: TextStyle(
              color: accent,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(SelectionChangedCause cause) {
    switch (cause) {
      case SelectionChangedCause.keyboard:
        return Icons.keyboard_alt_outlined;
      case SelectionChangedCause.toolbar:
        return Icons.build_circle_outlined;
      case SelectionChangedCause.tap:
        return Icons.touch_app_outlined;
      case SelectionChangedCause.doubleTap:
        return Icons.touch_app;
      case SelectionChangedCause.longPress:
        return Icons.front_hand_outlined;
      case SelectionChangedCause.drag:
        return Icons.drag_indicator;
      case SelectionChangedCause.forcePress:
        return Icons.pan_tool_alt_outlined;
      case SelectionChangedCause.stylusHandwriting:
        return Icons.brush_outlined;
    }
  }
}

// =====================================================================
// SimulateButton — a compact amber pill used by Tier A / B to invoke
// the intent without real keyboard input, handy in tests & previews.
// =====================================================================

class _SimulateButton extends StatelessWidget {
  const _SimulateButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFBBF24).withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFFBBF24).withValues(alpha: 0.8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.play_arrow, size: 14, color: Color(0xFFFBBF24)),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFFBBF24),
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolbarDispatchButton extends StatelessWidget {
  const _ToolbarDispatchButton({
    required this.buttonKey,
    required this.onPressed,
  });

  final GlobalKey buttonKey;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: buttonKey,
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[Color(0xFFFBBF24), Color(0xFFF59E0B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(Icons.select_all, size: 16, color: Color(0xFF1E293B)),
            SizedBox(width: 6),
            Text(
              'Select All (toolbar)',
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// RichPassage — the Tier C content. Hand-laid Text.rich with alternating
// weights, italics, and amber accents to look like documentation text.
// =====================================================================

class _RichPassage extends StatelessWidget {
  const _RichPassage();

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        style: TextStyle(
          color: Color(0xFF111827),
          height: 1.5,
          fontSize: 13.5,
        ),
        children: <InlineSpan>[
          TextSpan(text: 'Tier C wraps this passage in a '),
          TextSpan(
            text: 'SelectionArea',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFFB45309),
            ),
          ),
          TextSpan(text: '. There is '),
          TextSpan(
            text: 'no keyboard focus',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color(0xFF7C2D12),
            ),
          ),
          TextSpan(
            text:
                ' inside this widget — instead, a toolbar button below '
                'dispatches a SelectAllTextIntent whose cause is ',
          ),
          TextSpan(
            text: 'SelectionChangedCause.toolbar',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: Color(0xFFB45309),
            ),
          ),
          TextSpan(
            text:
                '. The unifying superpower of Intents: the same Action '
                'can service both origins, differentiated only by the '
                'cause field carried on the Intent.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Custom Actions — one per tier so they're individually inspectable.
// =====================================================================

/// Tier A action: logs the dispatch, then delegates to the framework's
/// default handler by calling Actions.maybeInvoke on the next scope.
class _TierALoggingSelectAllAction extends Action<SelectAllTextIntent> {
  _TierALoggingSelectAllAction({required this.onDispatched});

  final void Function(SelectionChangedCause cause) onDispatched;

  @override
  Object? invoke(SelectAllTextIntent intent) {
    onDispatched(intent.cause);
    // Delegate upward — the TextField's own Actions scope higher in the
    // tree will perform the actual selection change.
    final BuildContext? ctx = primaryFocus?.context;
    if (ctx != null) {
      Actions.maybeInvoke<SelectAllTextIntent>(ctx, intent);
    }
    return null;
  }

  @override
  bool isEnabled(SelectAllTextIntent intent) => true;

  @override
  bool consumesKey(SelectAllTextIntent intent) => true;
}

/// Tier B action: purely logs — the SelectableText still ships its own
/// handler, so in production this would also delegate, but we keep it
/// focused on logging for visual clarity in the demo.
class _TierBSelectableLogger extends Action<SelectAllTextIntent> {
  _TierBSelectableLogger({required this.onDispatched});

  final void Function(SelectionChangedCause cause) onDispatched;

  @override
  Object? invoke(SelectAllTextIntent intent) {
    onDispatched(intent.cause);
    return null;
  }

  @override
  bool isEnabled(SelectAllTextIntent intent) => true;
}

/// Tier C action: logs the toolbar-origin dispatch.
class _TierCToolbarLogger extends Action<SelectAllTextIntent> {
  _TierCToolbarLogger({required this.onDispatched});

  final void Function(SelectionChangedCause cause) onDispatched;

  @override
  Object? invoke(SelectAllTextIntent intent) {
    onDispatched(intent.cause);
    return null;
  }

  @override
  bool isEnabled(SelectAllTextIntent intent) => true;
}

// =====================================================================
// DispatchLog — rolling list of recent dispatches with timestamp,
// cause, origin, and source tier.
// =====================================================================

class _DispatchLogEntry {
  _DispatchLogEntry({
    required this.tier,
    required this.cause,
    required this.origin,
    required this.at,
  });

  final String tier;
  final SelectionChangedCause cause;
  final String origin;
  final DateTime at;
}

class _DispatchLog extends StatelessWidget {
  const _DispatchLog({required this.entries});

  final List<_DispatchLogEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFFBBF24).withValues(alpha: 0.5),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.list_alt, color: Color(0xFFFBBF24), size: 18),
              SizedBox(width: 8),
              Text(
                'Dispatch log',
                style: TextStyle(
                  color: Color(0xFFFEF3C7),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(width: 10),
              _HeaderChip(label: 'newest first · max 8 rows'),
            ],
          ),
          const SizedBox(height: 10),
          if (entries.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'No dispatches yet. Press Ctrl/Cmd+A in Tier A or B, or '
                'use the Tier C toolbar button.',
                style: TextStyle(
                  color: Color(0xFFCBD5F5),
                  fontSize: 12,
                ),
              ),
            )
          else
            Column(
              children: <Widget>[
                for (int i = 0; i < entries.length; i++)
                  _DispatchLogRow(
                    entry: entries[i],
                    isNewest: i == 0,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _DispatchLogRow extends StatelessWidget {
  const _DispatchLogRow({required this.entry, required this.isNewest});

  final _DispatchLogEntry entry;
  final bool isNewest;

  @override
  Widget build(BuildContext context) {
    final Color rowAccent = isNewest
        ? const Color(0xFFFBBF24)
        : const Color(0xFFFBBF24).withValues(alpha: 0.55);
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: isNewest
            ? const Color(0xFFFBBF24).withValues(alpha: 0.09)
            : const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: rowAccent.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: rowAccent.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: rowAccent),
            ),
            alignment: Alignment.center,
            child: Text(
              entry.tier,
              style: TextStyle(
                color: rowAccent,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 86,
            child: Text(
              _formatTime(entry.at),
              style: const TextStyle(
                color: Color(0xFFFEF3C7),
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'cause=${entry.cause.name}  ·  ${entry.origin}',
              style: const TextStyle(
                color: Color(0xFFCBD5F5),
                fontSize: 12,
              ),
            ),
          ),
          if (isNewest)
            const Padding(
              padding: EdgeInsets.only(left: 6),
              child: _HeaderChip(label: 'newest'),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime t) {
    String two(int v) => v.toString().padLeft(2, '0');
    String three(int v) => v.toString().padLeft(3, '0');
    return '${two(t.hour)}:${two(t.minute)}:${two(t.second)}.${three(t.millisecond)}';
  }
}

// =====================================================================
// Cross-platform mapping table.
// =====================================================================

class _PlatformMappingTable extends StatelessWidget {
  const _PlatformMappingTable();

  @override
  Widget build(BuildContext context) {
    const List<_PlatformRow> rows = <_PlatformRow>[
      _PlatformRow(
        platform: 'macOS',
        icon: Icons.laptop_mac,
        shortcut: 'Cmd + A',
        activator: 'SingleActivator(keyA, meta: true)',
        note:
            'SingleActivator uses meta: true for macOS so the Cmd key '
            'is the matched modifier.',
      ),
      _PlatformRow(
        platform: 'Windows',
        icon: Icons.desktop_windows_outlined,
        shortcut: 'Ctrl + A',
        activator: 'SingleActivator(keyA, control: true)',
        note:
            'Windows uses control: true; SingleActivator routes the '
            'Ctrl key path verbatim.',
      ),
      _PlatformRow(
        platform: 'Linux',
        icon: Icons.terminal,
        shortcut: 'Ctrl + A',
        activator: 'SingleActivator(keyA, control: true)',
        note:
            'Linux mirrors Windows; same SingleActivator configuration '
            'works on both.',
      ),
      _PlatformRow(
        platform: 'iOS',
        icon: Icons.phone_iphone,
        shortcut: 'Cmd + A (hw) / Toolbar',
        activator: 'SingleActivator(keyA, meta: true) + toolbar',
        note:
            'Hardware keyboards use Cmd. Without a keyboard users fall '
            'back to the selection toolbar which dispatches the intent '
            'with cause = toolbar.',
      ),
      _PlatformRow(
        platform: 'Android',
        icon: Icons.phone_android,
        shortcut: 'Ctrl + A (hw) / Toolbar',
        activator: 'SingleActivator(keyA, control: true) + toolbar',
        note:
            'Android hardware keyboards use Ctrl. Touch-only devices '
            'dispatch through the native selection toolbar.',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFFBBF24).withValues(alpha: 0.5),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.public, color: Color(0xFFFBBF24), size: 18),
              SizedBox(width: 8),
              Text(
                'Cross-platform shortcut mapping',
                style: TextStyle(
                  color: Color(0xFFFEF3C7),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(width: 10),
              _HeaderChip(label: 'SingleActivator handles meta vs control'),
            ],
          ),
          const SizedBox(height: 10),
          for (final _PlatformRow r in rows) _PlatformRowTile(row: r),
          const SizedBox(height: 6),
          Text(
            'One liner: use defaultTargetPlatform to pick meta: true on '
            'macOS / iOS, control: true everywhere else. The '
            'SingleActivator matches exactly one of the two modifier '
            'variants per platform — no duplicate declarations needed.',
            style: TextStyle(
              color: const Color(0xFFFEF3C7).withValues(alpha: 0.82),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformRow {
  const _PlatformRow({
    required this.platform,
    required this.icon,
    required this.shortcut,
    required this.activator,
    required this.note,
  });

  final String platform;
  final IconData icon;
  final String shortcut;
  final String activator;
  final String note;
}

class _PlatformRowTile extends StatelessWidget {
  const _PlatformRowTile({required this.row});

  final _PlatformRow row;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFFBBF24).withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(row.icon, color: const Color(0xFFFBBF24), size: 18),
          const SizedBox(width: 10),
          SizedBox(
            width: 90,
            child: Text(
              row.platform,
              style: const TextStyle(
                color: Color(0xFFFEF3C7),
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              row.shortcut,
              style: const TextStyle(
                color: Color(0xFFFBBF24),
                fontSize: 12.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  row.activator,
                  style: const TextStyle(
                    color: Color(0xFFFEF3C7),
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  row.note,
                  style: TextStyle(
                    color: const Color(0xFFFEF3C7).withValues(alpha: 0.75),
                    fontSize: 11.5,
                    height: 1.4,
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

// =====================================================================
// Instructional trio — three side-by-side panels explaining what the
// intent carries, why Intents are preferred over callbacks, and what
// gotchas to watch for.
// =====================================================================

class _InstructionalTrio extends StatelessWidget {
  const _InstructionalTrio();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        final bool wide = c.maxWidth > 720;
        final List<Widget> panels = <Widget>[
          _InstructionalPanel(
            icon: Icons.inventory_2_outlined,
            title: 'What a SelectAllTextIntent carries',
            bullets: const <String>[
              'Only one field: `cause` of type SelectionChangedCause.',
              'cause is final — set once at construction.',
              'Typical values: keyboard, toolbar (demo), plus tap, '
                  'doubleTap, longPress, drag, etc.',
              'Used by the framework to decide whether to show the '
                  'selection toolbar, whether to animate the caret, and '
                  'whether to emit haptic feedback.',
            ],
          ),
          _InstructionalPanel(
            icon: Icons.extension_outlined,
            title: 'Why Intents (not callbacks)',
            bullets: const <String>[
              'Composability — anybody up the tree can handle it.',
              'Overridable — wrap a scope in your own Actions map to '
                  'intercept the intent before the default handler.',
              'Unifies keyboard and toolbar origins: one Action services '
                  'both by inspecting cause.',
              'Testable — you can Actions.invoke directly in widget tests '
                  'without emulating key strokes.',
            ],
          ),
          _InstructionalPanel(
            icon: Icons.warning_amber_outlined,
            title: 'Gotchas',
            bullets: const <String>[
              'Must be inside an Actions + Shortcuts scope that maps '
                  'SelectAllTextIntent; otherwise the intent silently '
                  'no-ops.',
              'Widget must support selection — TextField, SelectableText, '
                  'or something wrapped in SelectionArea.',
              'SingleActivator is exact-match. On macOS include meta: '
                  'true, not control: true, or Cmd+A will be ignored.',
              'Actions.maybeInvoke returns null if nothing up the tree '
                  'handles the intent — check the return value.',
            ],
          ),
        ];
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: panels[0]),
              const SizedBox(width: 12),
              Expanded(child: panels[1]),
              const SizedBox(width: 12),
              Expanded(child: panels[2]),
            ],
          );
        }
        return Column(
          children: <Widget>[
            panels[0],
            const SizedBox(height: 12),
            panels[1],
            const SizedBox(height: 12),
            panels[2],
          ],
        );
      },
    );
  }
}

class _InstructionalPanel extends StatelessWidget {
  const _InstructionalPanel({
    required this.icon,
    required this.title,
    required this.bullets,
  });

  final IconData icon;
  final String title;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFFBBF24).withValues(alpha: 0.7),
          width: 1.1,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: const Color(0xFFB45309)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final String b in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    '• ',
                    style: TextStyle(
                      color: Color(0xFFB45309),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 12,
                        height: 1.4,
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

// =====================================================================
// Footer.
// =====================================================================

class _FooterBadge extends StatelessWidget {
  const _FooterBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFFBBF24).withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        children: const <Widget>[
          Icon(Icons.select_all, color: Color(0xFFFBBF24), size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'SelectAllTextIntent — one Intent, two origins, one unified '
              'Actions pipeline. The cause field is what ties it all '
              'together, letting widgets react appropriately to keyboard '
              'vs toolbar vs touch-originated selection requests.',
              style: TextStyle(
                color: Color(0xFFFEF3C7),
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
