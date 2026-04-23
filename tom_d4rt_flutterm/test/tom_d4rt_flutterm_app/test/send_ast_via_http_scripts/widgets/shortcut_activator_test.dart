import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Activator Workshop — a deep visual demo of ShortcutActivator and its three
// public concrete subclasses: SingleActivator, CharacterActivator, and the
// legacy-but-still-useful LogicalKeySet.
//
// ShortcutActivator is the abstract surface that Flutter's Shortcuts widget
// uses to decide whether a keyboard event should trigger an Intent. Every
// activator must implement:
//   • bool accepts(KeyEvent event, HardwareKeyboardState state)
//   • Iterable<LogicalKeyboardKey>? get triggers
//   • String debugDescribeKeys()
//
// In practice you almost never implement it directly — you pick one of the
// three concrete subclasses below.
//
//   SingleActivator    : one trigger key + modifier booleans (Ctrl/Shift/Alt/Meta)
//   CharacterActivator : matches a typed character string (e.g. '?')
//   LogicalKeySet      : an unordered set of 1..4 logical keys pressed together
//
// Harness contract (d4rt AST):
//   dynamic build(BuildContext context) returning a MaterialApp.
//   No main(), no runApp().
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const _ActivatorWorkshopApp();
}

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------

class _Palette {
  final Color violet; // hero accent
  final Color violetDeep;
  final Color violetSoft;
  final Color neon; // glow / success pulses
  final Color neonSoft;
  final Color slate; // background shell
  final Color slateDeep;
  final Color slateSoft;
  final Color parchment;
  final Color ink;
  final Color muted;

  const _Palette({
    required this.violet,
    required this.violetDeep,
    required this.violetSoft,
    required this.neon,
    required this.neonSoft,
    required this.slate,
    required this.slateDeep,
    required this.slateSoft,
    required this.parchment,
    required this.ink,
    required this.muted,
  });
}

const _Palette _p = _Palette(
  violet: Color(0xFF7C3AED),
  violetDeep: Color(0xFF4C1D95),
  violetSoft: Color(0xFFC4B5FD),
  neon: Color(0xFF22C55E),
  neonSoft: Color(0xFF86EFAC),
  slate: Color(0xFF1E293B),
  slateDeep: Color(0xFF0F172A),
  slateSoft: Color(0xFF334155),
  parchment: Color(0xFFF8FAFC),
  ink: Color(0xFFE2E8F0),
  muted: Color(0xFF94A3B8),
);

// ---------------------------------------------------------------------------
// Intent classes (distinct types for Actions dispatch)
// ---------------------------------------------------------------------------

class _SaveIntent extends Intent {
  const _SaveIntent();
}

class _HelpIntent extends Intent {
  const _HelpIntent();
}

class _LockIntent extends Intent {
  const _LockIntent();
}

// ---------------------------------------------------------------------------
// Activation log entry
// ---------------------------------------------------------------------------

class _LogEntry {
  final DateTime when;
  final String activatorKind; // SingleActivator / CharacterActivator / LogicalKeySet
  final String pressedSummary; // list of keys + modifiers
  final String intentName; // _SaveIntent / _HelpIntent / _LockIntent
  final Color tint;

  const _LogEntry({
    required this.when,
    required this.activatorKind,
    required this.pressedSummary,
    required this.intentName,
    required this.tint,
  });
}

// ---------------------------------------------------------------------------
// Root application
// ---------------------------------------------------------------------------

class _ActivatorWorkshopApp extends StatelessWidget {
  const _ActivatorWorkshopApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShortcutActivator Workshop',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _p.slateDeep,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _p.violet,
          brightness: Brightness.dark,
        ).copyWith(
          primary: _p.violet,
          secondary: _p.neon,
          surface: _p.slate,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFFF8FAFC),
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF8FAFC),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFFE2E8F0),
          ),
        ),
      ),
      home: const _ActivatorWorkshopScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// Workshop screen — hosts the whole experience
// ---------------------------------------------------------------------------

class _ActivatorWorkshopScreen extends StatefulWidget {
  const _ActivatorWorkshopScreen();

  @override
  State<_ActivatorWorkshopScreen> createState() =>
      _ActivatorWorkshopScreenState();
}

class _ActivatorWorkshopScreenState extends State<_ActivatorWorkshopScreen>
    with TickerProviderStateMixin {
  // Focus node that owns every Shortcuts scope in the page.
  final FocusNode _shellFocus = FocusNode(debugLabel: 'activator-workshop-shell');

  // Hero keycap controller — animates the "ring glow" when an activator fires.
  late final AnimationController _heroController;

  // Save card state
  bool _saveFlashing = false;
  int _saveCounter = 0;
  late final AnimationController _saveController;

  // Help overlay state
  OverlayEntry? _helpOverlay;
  bool _helpShown = false;
  int _helpCounter = 0;

  // Lock card state
  bool _locked = false;
  int _lockCounter = 0;
  late final AnimationController _lockController;

  // Modifier LEDs — observed via HardwareKeyboard.
  final Set<LogicalKeyboardKey> _held = <LogicalKeyboardKey>{};

  // Activation log
  final List<_LogEntry> _log = <_LogEntry>[];

  // Platform selector for SingleActivator (Ctrl vs Cmd)
  bool _useMetaForSave = false;

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _saveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _lockController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );

    HardwareKeyboard.instance.addHandler(_handleRawKey);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleRawKey);
    _helpOverlay?.remove();
    _helpOverlay = null;
    _shellFocus.dispose();
    _heroController.dispose();
    _saveController.dispose();
    _lockController.dispose();
    super.dispose();
  }

  bool _handleRawKey(KeyEvent event) {
    // Purely observational — we only mirror modifier/trigger keys onto the LED row.
    final pressed = HardwareKeyboard.instance.logicalKeysPressed;
    setState(() {
      _held
        ..clear()
        ..addAll(pressed);
    });
    return false; // do not consume
  }

  // ---------------------------------------------------------------------
  // Log helpers
  // ---------------------------------------------------------------------

  void _pushLog({
    required String kind,
    required String pressedSummary,
    required String intentName,
    required Color tint,
  }) {
    setState(() {
      _log.insert(
        0,
        _LogEntry(
          when: DateTime.now(),
          activatorKind: kind,
          pressedSummary: pressedSummary,
          intentName: intentName,
          tint: tint,
        ),
      );
      if (_log.length > 40) {
        _log.removeRange(40, _log.length);
      }
    });
    _heroController
      ..reset()
      ..forward();
  }

  String _summariseHeldKeys() {
    if (_held.isEmpty) return '<none>';
    final names = _held.map(_describeKey).toList()..sort();
    return names.join(' + ');
  }

  // ---------------------------------------------------------------------
  // Intent handlers
  // ---------------------------------------------------------------------

  void _onSave() {
    setState(() {
      _saveFlashing = true;
      _saveCounter += 1;
    });
    _saveController
      ..reset()
      ..forward().whenComplete(() {
        if (!mounted) return;
        setState(() => _saveFlashing = false);
      });
    _pushLog(
      kind: 'SingleActivator',
      pressedSummary: _summariseHeldKeys(),
      intentName: '_SaveIntent',
      tint: _p.violet,
    );
  }

  void _onHelp() {
    _helpCounter += 1;
    _showHelpOverlay();
    _pushLog(
      kind: 'CharacterActivator',
      pressedSummary: _summariseHeldKeys(),
      intentName: '_HelpIntent',
      tint: _p.neon,
    );
  }

  void _onLock() {
    setState(() {
      _locked = !_locked;
      _lockCounter += 1;
    });
    _lockController
      ..reset()
      ..forward();
    _pushLog(
      kind: 'LogicalKeySet',
      pressedSummary: _summariseHeldKeys(),
      intentName: '_LockIntent',
      tint: _p.violetSoft,
    );
  }

  // Help overlay — dismisses itself after a few seconds or on tap.
  void _showHelpOverlay() {
    _helpOverlay?.remove();
    final entry = OverlayEntry(
      builder: (ctx) {
        return Positioned(
          top: 96,
          right: 40,
          width: 360,
          child: Material(
            color: Colors.transparent,
            child: _HelpCheatsheet(
              onClose: () {
                _helpOverlay?.remove();
                _helpOverlay = null;
                if (mounted) setState(() => _helpShown = false);
              },
            ),
          ),
        );
      },
    );
    Overlay.of(context, rootOverlay: true).insert(entry);
    _helpOverlay = entry;
    setState(() => _helpShown = true);
    Future<void>.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      if (_helpOverlay == entry) {
        _helpOverlay?.remove();
        _helpOverlay = null;
        setState(() => _helpShown = false);
      }
    });
  }

  // ---------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final saveActivator = SingleActivator(
      LogicalKeyboardKey.keyS,
      control: !_useMetaForSave,
      meta: _useMetaForSave,
    );
    const helpActivator = CharacterActivator('?');
    final lockActivator = LogicalKeySet(
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.keyL,
    );

    return Scaffold(
      backgroundColor: _p.slateDeep,
      appBar: _buildAppBar(),
      body: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          saveActivator: const _SaveIntent(),
          helpActivator: const _HelpIntent(),
          lockActivator: const _LockIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _SaveIntent: CallbackAction<_SaveIntent>(
              onInvoke: (intent) {
                _onSave();
                return null;
              },
            ),
            _HelpIntent: CallbackAction<_HelpIntent>(
              onInvoke: (intent) {
                _onHelp();
                return null;
              },
            ),
            _LockIntent: CallbackAction<_LockIntent>(
              onInvoke: (intent) {
                _onLock();
                return null;
              },
            ),
          },
          child: Focus(
            focusNode: _shellFocus,
            autofocus: true,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _shellFocus.requestFocus(),
              child: _buildBody(),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _p.slate,
      elevation: 0,
      title: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[_palDeepViolet, _palViolet],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _p.violet.withValues(alpha: 0.55),
                  blurRadius: 14,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(Icons.keyboard_alt_outlined,
                size: 22, color: Colors.white),
          ),
          const SizedBox(width: 14),
          const Text('ShortcutActivator Workshop'),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _p.neon.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: _p.neon.withValues(alpha: 0.55)),
            ),
            child: const Text(
              'Three activators, one discipline',
              style: TextStyle(
                fontSize: 12,
                color: _palNeon,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Save uses',
              style: TextStyle(color: _palInk, fontSize: 13),
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('Ctrl'),
              selected: !_useMetaForSave,
              onSelected: (v) {
                if (v) setState(() => _useMetaForSave = false);
              },
              selectedColor: _p.violet,
              labelStyle: TextStyle(
                color: !_useMetaForSave ? Colors.white : _p.muted,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: _p.slateSoft,
            ),
            const SizedBox(width: 6),
            ChoiceChip(
              label: const Text('Cmd'),
              selected: _useMetaForSave,
              onSelected: (v) {
                if (v) setState(() => _useMetaForSave = true);
              },
              selectedColor: _p.violet,
              labelStyle: TextStyle(
                color: _useMetaForSave ? Colors.white : _p.muted,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: _p.slateSoft,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ],
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final wide = constraints.maxWidth >= 1180;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SurfacePanel(
                title: 'ShortcutActivator surface',
                subtitle:
                    'The abstract base type used by Flutter\'s Shortcuts widget.',
                children: const <Widget>[
                  _InstructionalRow(
                    icon: Icons.filter_center_focus,
                    title: 'accepts(KeyEvent, HardwareKeyboardState)',
                    body:
                        'Activators evaluate a KeyEvent against the current hardware '
                        'state and return true when their contract is satisfied.',
                  ),
                  _InstructionalRow(
                    icon: Icons.device_hub_outlined,
                    title: 'triggers',
                    body:
                        'A set of logical keys that the manager subscribes to. Only '
                        'events for these keys are forwarded — an optimisation.',
                  ),
                  _InstructionalRow(
                    icon: Icons.info_outline,
                    title: 'debugDescribeKeys()',
                    body:
                        'A human-readable summary rendered by the DiagnosticableTree '
                        'machinery, helpful in Shortcuts.describeKeys inspector output.',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _KeycapHero(
                controller: _heroController,
                held: _held,
                useMeta: _useMetaForSave,
              ),
              const SizedBox(height: 20),
              if (wide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _SingleActivatorCard(
                        useMeta: _useMetaForSave,
                        fired: _saveFlashing,
                        counter: _saveCounter,
                        controller: _saveController,
                        onManualFire: _onSave,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: _CharacterActivatorCard(
                        helpVisible: _helpShown,
                        counter: _helpCounter,
                        onManualFire: _onHelp,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: _LogicalKeySetCard(
                        locked: _locked,
                        counter: _lockCounter,
                        controller: _lockController,
                        onManualFire: _onLock,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _SingleActivatorCard(
                      useMeta: _useMetaForSave,
                      fired: _saveFlashing,
                      counter: _saveCounter,
                      controller: _saveController,
                      onManualFire: _onSave,
                    ),
                    const SizedBox(height: 16),
                    _CharacterActivatorCard(
                      helpVisible: _helpShown,
                      counter: _helpCounter,
                      onManualFire: _onHelp,
                    ),
                    const SizedBox(height: 16),
                    _LogicalKeySetCard(
                      locked: _locked,
                      counter: _lockCounter,
                      controller: _lockController,
                      onManualFire: _onLock,
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              const _ComparisonTable(),
              const SizedBox(height: 20),
              _ModifierLEDRow(held: _held),
              const SizedBox(height: 20),
              const _GotchasPanel(),
              const SizedBox(height: 20),
              _ActivationLog(entries: _log),
              const SizedBox(height: 28),
              _Footer(logSize: _log.length, helpShown: _helpShown),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Hero: Keycap row with glow when an activator fires
// ---------------------------------------------------------------------------

class _KeycapHero extends StatelessWidget {
  final AnimationController controller;
  final Set<LogicalKeyboardKey> held;
  final bool useMeta;

  const _KeycapHero({
    required this.controller,
    required this.held,
    required this.useMeta,
  });

  @override
  Widget build(BuildContext context) {
    final primaryLabel = useMeta ? 'Cmd' : 'Ctrl';
    final primaryKey =
        useMeta ? LogicalKeyboardKey.meta : LogicalKeyboardKey.control;

    return AnimatedBuilder(
      animation: controller,
      builder: (ctx, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                _p.violetDeep.withValues(alpha: 0.92),
                _p.slate,
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _p.violet.withValues(alpha: 0.6)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _p.violet.withValues(alpha: 0.35),
                blurRadius: 30,
                spreadRadius: -4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.auto_awesome,
                      color: _palNeonSoft, size: 22),
                  const SizedBox(width: 10),
                  const Text(
                    'Keycap Hero',
                    style: TextStyle(
                      color: _palInk,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '— pulse fires on every dispatched activator',
                    style: TextStyle(
                      color: _p.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 150,
                child: CustomPaint(
                  painter: _KeycapPainter(
                    glow: controller.value,
                    primaryLabel: primaryLabel,
                    primaryHeld: held.contains(primaryKey),
                    shiftHeld: held.contains(LogicalKeyboardKey.shift) ||
                        held.contains(LogicalKeyboardKey.shiftLeft) ||
                        held.contains(LogicalKeyboardKey.shiftRight),
                    kHeld: held.contains(LogicalKeyboardKey.keyK),
                  ),
                  child: Container(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  _KeycapBadge(
                    label: 'Ctrl+Shift+K',
                    describe:
                        'Classic SingleActivator target — this hero visualises the canonical shape.',
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Pulse intensity = ${(controller.value * 100).round()}%',
                    style: TextStyle(
                      color: _p.ink.withValues(alpha: 0.7),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _KeycapPainter extends CustomPainter {
  final double glow;
  final String primaryLabel;
  final bool primaryHeld;
  final bool shiftHeld;
  final bool kHeld;

  _KeycapPainter({
    required this.glow,
    required this.primaryLabel,
    required this.primaryHeld,
    required this.shiftHeld,
    required this.kHeld,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final keys = <({String label, bool held})>[
      (label: primaryLabel, held: primaryHeld),
      (label: 'Shift', held: shiftHeld),
      (label: 'K', held: kHeld),
    ];
    const gap = 18.0;
    final totalGap = gap * (keys.length - 1);
    final keyW = (size.width - totalGap) / keys.length;
    final keyH = size.height.clamp(60, size.height).toDouble();

    for (var i = 0; i < keys.length; i++) {
      final x = i * (keyW + gap);
      final rect = Rect.fromLTWH(x, 0, keyW, keyH);
      _paintKey(canvas, rect, keys[i].label, keys[i].held);
    }
  }

  void _paintKey(Canvas canvas, Rect rect, String label, bool held) {
    final radius = Radius.circular(14);
    final rrect = RRect.fromRectAndRadius(rect.deflate(3), radius);

    // Shadow
    canvas.drawRRect(
      rrect.shift(const Offset(0, 5)),
      Paint()..color = _p.slateDeep.withValues(alpha: 0.65),
    );

    // Body gradient
    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: held
            ? <Color>[_p.violet, _p.violetDeep]
            : <Color>[_p.slateSoft, _p.slateDeep],
      ).createShader(rrect.outerRect);
    canvas.drawRRect(rrect, bodyPaint);

    // Top edge highlight
    final highlight = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(rrect.deflate(2), highlight);

    // Glow ring driven by animation. Use a sinusoidal envelope so the
    // opacity pulses instead of fading linearly — looks more alive.
    if (glow > 0) {
      final envelope = math.sin(glow * math.pi);
      final ringPaint = Paint()
        ..color = _p.neon.withValues(alpha: 0.85 * envelope)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3 + (envelope * 6);
      canvas.drawRRect(rrect.inflate(2 + envelope * 9), ringPaint);
    }

    // Label
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: held ? Colors.white : _p.ink,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final center = rrect.center;
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _KeycapPainter oldDelegate) {
    return oldDelegate.glow != glow ||
        oldDelegate.primaryLabel != primaryLabel ||
        oldDelegate.primaryHeld != primaryHeld ||
        oldDelegate.shiftHeld != shiftHeld ||
        oldDelegate.kHeld != kHeld;
  }
}

class _KeycapBadge extends StatelessWidget {
  final String label;
  final String describe;

  const _KeycapBadge({required this.label, required this.describe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _p.slate.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.violetSoft.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: _palNeon,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              describe,
              style: TextStyle(
                color: _p.ink.withValues(alpha: 0.75),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Card A — SingleActivator demo
// ---------------------------------------------------------------------------

class _SingleActivatorCard extends StatelessWidget {
  final bool useMeta;
  final bool fired;
  final int counter;
  final AnimationController controller;
  final VoidCallback onManualFire;

  const _SingleActivatorCard({
    required this.useMeta,
    required this.fired,
    required this.counter,
    required this.controller,
    required this.onManualFire,
  });

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      accent: _p.violet,
      tag: 'SingleActivator',
      title: useMeta ? 'Cmd + S' : 'Ctrl + S',
      subtitle: 'Native-feeling save shortcut — platform-adaptive.',
      signatureLines: const <String>[
        'SingleActivator(',
        '  LogicalKeyboardKey.keyS,',
        '  control: true,      // or meta on macOS',
        '  shift: false,',
        '  alt: false,',
        '  includeRepeats: false,',
        ')',
      ],
      guidance: const <String>[
        'Use for OS-style shortcuts where one key + 0..4 booleans is enough.',
        'Set includeRepeats:false to avoid auto-repeat storms during long holds.',
        'Toggle control/meta per platform to feel native on both Linux and macOS.',
      ],
      body: AnimatedBuilder(
        animation: controller,
        builder: (ctx, _) {
          final pulse = controller.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: _p.slateDeep.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: fired
                        ? _p.neon.withValues(alpha: 0.9)
                        : _p.violet.withValues(alpha: 0.45),
                    width: 1.4,
                  ),
                  boxShadow: fired
                      ? <BoxShadow>[
                          BoxShadow(
                            color: _p.neon.withValues(alpha: 0.4),
                            blurRadius: 20 + pulse * 12,
                            spreadRadius: 1 + pulse * 3,
                          ),
                        ]
                      : const <BoxShadow>[],
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _DocumentPainter(
                          flashStrength: fired ? (1.0 - pulse) : 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      top: 14,
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.description_outlined,
                              color: _palInk, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'untitled.dart',
                            style: TextStyle(
                              color: _p.ink.withValues(alpha: 0.85),
                              fontFamily: 'monospace',
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (fired)
                      Positioned(
                        right: 16,
                        top: 12,
                        child: Opacity(
                          opacity: (1 - pulse).clamp(0.0, 1.0),
                          child: Row(
                            children: const <Widget>[
                              Icon(Icons.save_rounded,
                                  color: _palNeon, size: 20),
                              SizedBox(width: 6),
                              Text(
                                'saved!',
                                style: TextStyle(
                                  color: _palNeon,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Positioned(
                      left: 14,
                      bottom: 10,
                      child: Text(
                        'Saves: $counter',
                        style: TextStyle(
                          color: _p.muted,
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  OutlinedButton.icon(
                    onPressed: onManualFire,
                    icon: const Icon(Icons.bolt_outlined),
                    label: const Text('Fire manually'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _p.ink,
                      side: BorderSide(
                          color: _p.violet.withValues(alpha: 0.6)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'or press the combo while this card is in focus.',
                    style: TextStyle(
                      color: _p.muted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DocumentPainter extends CustomPainter {
  final double flashStrength;

  _DocumentPainter({required this.flashStrength});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _p.ink.withValues(alpha: 0.16)
      ..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final y = 42.0 + i * 14.0;
      final w = (size.width - 28) * (0.55 + (i % 3) * 0.12);
      final r = Rect.fromLTWH(14, y, w, 6);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(3)),
        paint,
      );
    }
    if (flashStrength > 0) {
      final flashPaint = Paint()
        ..color = _p.neon.withValues(alpha: 0.25 * flashStrength);
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        flashPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DocumentPainter oldDelegate) {
    return oldDelegate.flashStrength != flashStrength;
  }
}

// ---------------------------------------------------------------------------
// Card B — CharacterActivator demo
// ---------------------------------------------------------------------------

class _CharacterActivatorCard extends StatelessWidget {
  final bool helpVisible;
  final int counter;
  final VoidCallback onManualFire;

  const _CharacterActivatorCard({
    required this.helpVisible,
    required this.counter,
    required this.onManualFire,
  });

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      accent: _p.neon,
      tag: 'CharacterActivator',
      title: 'Type "?" anywhere',
      subtitle:
          'Matches a typed character regardless of physical key layout.',
      signatureLines: const <String>[
        "CharacterActivator('?')",
        '// optionally: includeRepeats: false,',
        '// optionally: control: true, alt: true,',
        '//             meta: true',
      ],
      guidance: const <String>[
        'Great for layout-independent shortcuts (Azerty, Qwertz, Dvorak).',
        'Do NOT use inside a TextField — the activator will also match when typing.',
        'Combine with a Focus scope to limit it to non-editing regions.',
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: _p.slateDeep.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: helpVisible
                    ? _p.neon.withValues(alpha: 0.9)
                    : _p.neon.withValues(alpha: 0.4),
                width: 1.4,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 14,
                  top: 14,
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.help_outline,
                          color: _palNeonSoft, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Press ? for help',
                        style: TextStyle(
                          color: _palInk,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 14,
                  top: 46,
                  right: 14,
                  child: Text(
                    'CharacterActivator matches the produced character, so '
                    'Shift+/ on US layout, AltGr+ß on DE, etc., all resolve to "?".',
                    style: TextStyle(
                      color: _p.muted,
                      fontSize: 12,
                    ),
                  ),
                ),
                Positioned(
                  left: 14,
                  bottom: 12,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _p.neon.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: _p.neon.withValues(alpha: 0.5)),
                        ),
                        child: Text(
                          'Help fires: $counter',
                          style: const TextStyle(
                            color: _palNeon,
                            fontSize: 11,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        helpVisible ? 'overlay VISIBLE' : 'overlay hidden',
                        style: TextStyle(
                          color:
                              helpVisible ? _p.neon : _p.muted,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              OutlinedButton.icon(
                onPressed: onManualFire,
                icon: const Icon(Icons.help_center_outlined),
                label: const Text('Show help overlay'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _p.ink,
                  side: BorderSide(color: _p.neon.withValues(alpha: 0.6)),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Overlay auto-dismisses in 4s.',
                style: TextStyle(color: _p.muted, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Card C — LogicalKeySet demo
// ---------------------------------------------------------------------------

class _LogicalKeySetCard extends StatelessWidget {
  final bool locked;
  final int counter;
  final AnimationController controller;
  final VoidCallback onManualFire;

  const _LogicalKeySetCard({
    required this.locked,
    required this.counter,
    required this.controller,
    required this.onManualFire,
  });

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      accent: _p.violetSoft,
      tag: 'LogicalKeySet',
      title: 'Ctrl + Alt + L',
      subtitle:
          'Order-independent multi-key set — up to 4 keys held simultaneously.',
      signatureLines: const <String>[
        'LogicalKeySet(',
        '  LogicalKeyboardKey.control,',
        '  LogicalKeyboardKey.alt,',
        '  LogicalKeyboardKey.keyL,',
        ')  // order does not matter',
      ],
      guidance: const <String>[
        'LogicalKeySet treats its arguments as a set: the trigger fires when the '
        'last key completes the set, regardless of order.',
        'Useful for non-conventional combos or when you genuinely want "three '
        'keys held together" semantics.',
        'Prefer SingleActivator when the combo is "modifier + single key" — it '
        'has nicer OS-integration and repeat handling.',
      ],
      body: AnimatedBuilder(
        animation: controller,
        builder: (ctx, _) {
          final pulse = controller.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: locked
                      ? _p.slateDeep.withValues(alpha: 0.85)
                      : _p.slate.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: locked
                        ? _p.violetSoft.withValues(alpha: 0.9)
                        : _p.violetSoft.withValues(alpha: 0.45),
                    width: 1.4,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Opacity(
                        opacity: locked ? 0.45 : 1.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: const <Widget>[
                                  Icon(Icons.dashboard_customize_outlined,
                                      color: _palInk, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Privileged Panel',
                                    style: TextStyle(
                                      color: _palInk,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _FakeListRow(label: 'Audit logs'),
                              const SizedBox(height: 6),
                              _FakeListRow(label: 'Secret config'),
                              const SizedBox(height: 6),
                              _FakeListRow(label: 'Deploy token'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (locked)
                      Center(
                        child: Transform.scale(
                          scale: 1.0 + (1 - pulse) * 0.15,
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: _p.violet.withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: _p.violet.withValues(alpha: 0.55),
                                  blurRadius: 24,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.lock,
                                color: Colors.white, size: 36),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  OutlinedButton.icon(
                    onPressed: onManualFire,
                    icon: Icon(locked ? Icons.lock_open : Icons.lock_outline),
                    label: Text(locked ? 'Unlock panel' : 'Lock panel'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _p.ink,
                      side: BorderSide(
                          color: _p.violetSoft.withValues(alpha: 0.7)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Toggled $counter ×',
                    style: TextStyle(
                      color: _p.muted,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FakeListRow extends StatelessWidget {
  final String label;

  const _FakeListRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: _p.neon.withValues(alpha: 0.85),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: _p.ink.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: _p.ink.withValues(alpha: 0.75),
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Demo card scaffold
// ---------------------------------------------------------------------------

class _DemoCard extends StatelessWidget {
  final Color accent;
  final String tag;
  final String title;
  final String subtitle;
  final List<String> signatureLines;
  final List<String> guidance;
  final Widget body;

  const _DemoCard({
    required this.accent,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.signatureLines,
    required this.guidance,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _p.slate.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: accent.withValues(alpha: 0.6)),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: accent,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _palInk,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: _p.ink.withValues(alpha: 0.8),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          _SignatureBlock(lines: signatureLines, accent: accent),
          const SizedBox(height: 12),
          body,
          const SizedBox(height: 12),
          _GuidanceBullets(items: guidance, accent: accent),
        ],
      ),
    );
  }
}

class _SignatureBlock extends StatelessWidget {
  final List<String> lines;
  final Color accent;

  const _SignatureBlock({required this.lines, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _p.slateDeep.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final line in lines)
            Text(
              line,
              style: TextStyle(
                color: _p.ink.withValues(alpha: 0.9),
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.35,
              ),
            ),
        ],
      ),
    );
  }
}

class _GuidanceBullets extends StatelessWidget {
  final List<String> items;
  final Color accent;

  const _GuidanceBullets({required this.items, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      color: _p.ink.withValues(alpha: 0.82),
                      fontSize: 12,
                      height: 1.4,
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

// ---------------------------------------------------------------------------
// Comparison Table
// ---------------------------------------------------------------------------

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    final rows = <_ComparisonRow>[
      const _ComparisonRow(
        scenario: 'Typing "?" in a chat to summon help',
        single: 'Awkward — would need to know the physical key',
        character: 'Perfect — matches produced character',
        logicalSet: 'Unnecessary — overkill for one char',
        best: 'CharacterActivator',
      ),
      const _ComparisonRow(
        scenario: 'Native Save: Ctrl+S on Linux, Cmd+S on macOS',
        single: 'Ideal — flip control/meta per platform',
        character: 'Cannot express modifiers elegantly',
        logicalSet: 'Works but less ergonomic',
        best: 'SingleActivator',
      ),
      const _ComparisonRow(
        scenario: 'Hold Ctrl+Alt+L in any order to lock',
        single: 'Only one trigger key — alt must be modifier only',
        character: 'Not about characters at all',
        logicalSet: 'Exact fit — 3-key unordered set',
        best: 'LogicalKeySet',
      ),
      const _ComparisonRow(
        scenario: 'Accessibility: press space in a button',
        single: 'Fine, but framework already does it',
        character: 'Avoid — space has meaning in text entry',
        logicalSet: 'Overkill',
        best: 'SingleActivator',
      ),
      const _ComparisonRow(
        scenario: 'Shortcut inside a TextField (cut/copy)',
        single: 'Use SingleActivator + DefaultTextEditingShortcuts',
        character:
            'Dangerous — fires while typing that character',
        logicalSet: 'Works but verbose',
        best: 'SingleActivator',
      ),
      const _ComparisonRow(
        scenario: 'Keyboard cheat-code: K K K',
        single: 'Cannot express repetition',
        character: 'Not a combo',
        logicalSet:
            'No — set does not care about ordering/repetition',
        best: 'Custom ShortcutActivator subclass',
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: _p.slate.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.muted.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.table_chart_outlined,
                  color: _palViolet, size: 20),
              SizedBox(width: 8),
              Text(
                'When to choose each subclass',
                style: TextStyle(
                  color: _palInk,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Heuristic: match the shape of what you\'re describing. '
            'Characters → CharacterActivator. Modifier + key → SingleActivator. '
            '3+ keys held in any order → LogicalKeySet.',
            style: TextStyle(
              color: _p.ink.withValues(alpha: 0.82),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 940),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _ComparisonHeader(),
                  const SizedBox(height: 4),
                  for (var i = 0; i < rows.length; i++) ...<Widget>[
                    _ComparisonRowView(row: rows[i], zebra: i.isOdd),
                    const SizedBox(height: 2),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonHeader extends StatelessWidget {
  const _ComparisonHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _p.violetDeep.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.violet.withValues(alpha: 0.55)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: const <Widget>[
          _ComparisonCell(
              text: 'Scenario', width: 240, bold: true, color: _palInk),
          _ComparisonCell(
              text: 'SingleActivator', width: 180, bold: true, color: _palInk),
          _ComparisonCell(
              text: 'CharacterActivator',
              width: 180,
              bold: true,
              color: _palInk),
          _ComparisonCell(
              text: 'LogicalKeySet',
              width: 180,
              bold: true,
              color: _palInk),
          _ComparisonCell(
              text: 'Best choice', width: 160, bold: true, color: _palNeon),
        ],
      ),
    );
  }
}

class _ComparisonRow {
  final String scenario;
  final String single;
  final String character;
  final String logicalSet;
  final String best;

  const _ComparisonRow({
    required this.scenario,
    required this.single,
    required this.character,
    required this.logicalSet,
    required this.best,
  });
}

class _ComparisonRowView extends StatelessWidget {
  final _ComparisonRow row;
  final bool zebra;

  const _ComparisonRowView({required this.row, required this.zebra});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: zebra
            ? _p.slateDeep.withValues(alpha: 0.6)
            : _p.slate.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ComparisonCell(text: row.scenario, width: 240, bold: true),
          _ComparisonCell(text: row.single, width: 180),
          _ComparisonCell(text: row.character, width: 180),
          _ComparisonCell(text: row.logicalSet, width: 180),
          _ComparisonCell(
              text: row.best, width: 160, bold: true, color: _palNeon),
        ],
      ),
    );
  }
}

class _ComparisonCell extends StatelessWidget {
  final String text;
  final double width;
  final bool bold;
  final Color? color;

  const _ComparisonCell({
    required this.text,
    required this.width,
    this.bold = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? _p.ink.withValues(alpha: 0.88),
          fontSize: 12,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          height: 1.4,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Modifier LED row — lights up when Ctrl/Shift/Alt/Meta are held
// ---------------------------------------------------------------------------

class _ModifierLEDRow extends StatelessWidget {
  final Set<LogicalKeyboardKey> held;

  const _ModifierLEDRow({required this.held});

  bool _ctrl() =>
      held.contains(LogicalKeyboardKey.control) ||
      held.contains(LogicalKeyboardKey.controlLeft) ||
      held.contains(LogicalKeyboardKey.controlRight);
  bool _shift() =>
      held.contains(LogicalKeyboardKey.shift) ||
      held.contains(LogicalKeyboardKey.shiftLeft) ||
      held.contains(LogicalKeyboardKey.shiftRight);
  bool _alt() =>
      held.contains(LogicalKeyboardKey.alt) ||
      held.contains(LogicalKeyboardKey.altLeft) ||
      held.contains(LogicalKeyboardKey.altRight);
  bool _meta() =>
      held.contains(LogicalKeyboardKey.meta) ||
      held.contains(LogicalKeyboardKey.metaLeft) ||
      held.contains(LogicalKeyboardKey.metaRight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _p.slate.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.tune_outlined, color: _palNeonSoft, size: 20),
              SizedBox(width: 8),
              Text(
                'Modifier LEDs',
                style: TextStyle(
                  color: _palInk,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'live via HardwareKeyboard.instance.logicalKeysPressed',
                  style: TextStyle(
                    color: _palMuted,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              _LEDLamp(label: 'Ctrl', active: _ctrl()),
              const SizedBox(width: 14),
              _LEDLamp(label: 'Shift', active: _shift()),
              const SizedBox(width: 14),
              _LEDLamp(label: 'Alt', active: _alt()),
              const SizedBox(width: 14),
              _LEDLamp(label: 'Meta', active: _meta()),
              const Spacer(),
              _HeldKeyChips(held: held),
            ],
          ),
        ],
      ),
    );
  }
}

class _LEDLamp extends StatelessWidget {
  final String label;
  final bool active;

  const _LEDLamp({required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active
            ? _p.neon.withValues(alpha: 0.25)
            : _p.slateDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: active
              ? _p.neon.withValues(alpha: 0.85)
              : _p.muted.withValues(alpha: 0.35),
          width: 1.4,
        ),
        boxShadow: active
            ? <BoxShadow>[
                BoxShadow(
                  color: _p.neon.withValues(alpha: 0.65),
                  blurRadius: 14,
                  spreadRadius: 1,
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? _p.neon : _p.muted.withValues(alpha: 0.4),
              boxShadow: active
                  ? <BoxShadow>[
                      BoxShadow(
                        color: _p.neon.withValues(alpha: 0.85),
                        blurRadius: 12,
                      ),
                    ]
                  : const <BoxShadow>[],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : _p.ink.withValues(alpha: 0.75),
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeldKeyChips extends StatelessWidget {
  final Set<LogicalKeyboardKey> held;

  const _HeldKeyChips({required this.held});

  @override
  Widget build(BuildContext context) {
    if (held.isEmpty) {
      return Text(
        'no keys held',
        style: TextStyle(
          color: _p.muted,
          fontFamily: 'monospace',
          fontSize: 12,
        ),
      );
    }
    final items = held.map(_describeKey).toList()..sort();
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: <Widget>[
        for (final label in items)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _p.violet.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: _p.violet.withValues(alpha: 0.5)),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: _palInk,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Activation Log
// ---------------------------------------------------------------------------

class _ActivationLog extends StatelessWidget {
  final List<_LogEntry> entries;

  const _ActivationLog({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _p.slate.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.violet.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.history, color: _palViolet, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Activation Log',
                style: TextStyle(
                  color: _palInk,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _p.neon.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _p.neon.withValues(alpha: 0.55)),
                ),
                child: Text(
                  '${entries.length} entries',
                  style: const TextStyle(
                    color: _palNeon,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 280),
            child: entries.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      'No activations yet. Press Ctrl+S, ?, or Ctrl+Alt+L '
                      '(or click the card buttons) to log one.',
                      style: TextStyle(
                        color: _p.muted,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: entries.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 4),
                    itemBuilder: (ctx, i) => _ActivationRow(entry: entries[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ActivationRow extends StatelessWidget {
  final _LogEntry entry;

  const _ActivationRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _p.slateDeep.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: entry.tint.withValues(alpha: 0.55)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: entry.tint,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: entry.tint.withValues(alpha: 0.75),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 68,
            child: Text(
              _fmtTime(entry.when),
              style: TextStyle(
                color: _p.muted,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              entry.activatorKind,
              style: const TextStyle(
                color: _palInk,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              entry.pressedSummary,
              style: TextStyle(
                color: _p.ink.withValues(alpha: 0.78),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: entry.tint.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: entry.tint.withValues(alpha: 0.6)),
            ),
            child: Text(
              entry.intentName,
              style: TextStyle(
                color: entry.tint,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Help overlay widget
// ---------------------------------------------------------------------------

class _HelpCheatsheet extends StatelessWidget {
  final VoidCallback onClose;

  const _HelpCheatsheet({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: _p.slateDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _p.neon.withValues(alpha: 0.75), width: 1.4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _p.neon.withValues(alpha: 0.3),
            blurRadius: 22,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.help_outline, color: _palNeon, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Shortcut Cheatsheet',
                style: TextStyle(
                  color: _palInk,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onClose,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(Icons.close,
                      color: _p.muted.withValues(alpha: 0.9), size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _CheatRow(combo: 'Ctrl/Cmd + S', what: 'Save document'),
          const _CheatRow(combo: '?', what: 'Show this help'),
          const _CheatRow(combo: 'Ctrl + Alt + L', what: 'Lock panel'),
          const SizedBox(height: 8),
          Text(
            'Auto-dismiss in a few seconds.',
            style: TextStyle(
              color: _p.muted,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _CheatRow extends StatelessWidget {
  final String combo;
  final String what;

  const _CheatRow({required this.combo, required this.what});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _p.violet.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _p.violet.withValues(alpha: 0.6)),
            ),
            child: Text(
              combo,
              style: const TextStyle(
                color: _palInk,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              what,
              style: TextStyle(
                color: _p.ink.withValues(alpha: 0.85),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Instructional surface panel
// ---------------------------------------------------------------------------

class _SurfacePanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const _SurfacePanel({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _p.slate.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.violet.withValues(alpha: 0.35)),
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _p.violet.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: _p.violet.withValues(alpha: 0.55)),
                ),
                child: const Icon(Icons.architecture_outlined,
                    color: _palViolet, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: _palInk,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: _p.ink.withValues(alpha: 0.78),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _InstructionalRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _InstructionalRow({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: _p.neon.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _p.neon.withValues(alpha: 0.5)),
            ),
            child: Icon(icon, color: _p.neon, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _palInk,
                    fontSize: 14,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: TextStyle(
                    color: _p.ink.withValues(alpha: 0.82),
                    fontSize: 12.5,
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

// ---------------------------------------------------------------------------
// Gotchas panel
// ---------------------------------------------------------------------------

class _GotchasPanel extends StatelessWidget {
  const _GotchasPanel();

  static const List<_Gotcha> _gotchas = <_Gotcha>[
    _Gotcha(
      title: 'Focus scope must include the Shortcuts widget',
      body:
          'A ShortcutActivator only fires when the corresponding Shortcuts widget '
          'is an ancestor of the focus owner. Put your Shortcuts above the '
          'Scaffold body and request focus into a child, or wrap the whole page '
          'in a Focus widget with autofocus:true.',
    ),
    _Gotcha(
      title: 'CharacterActivator conflicts with text input',
      body:
          'If a TextField has focus, typing the activator character will fire '
          'both the Shortcut and the text edit. Narrow the scope with a '
          'child-level Shortcuts widget, or switch to SingleActivator with '
          'a modifier key for in-editor shortcuts.',
    ),
    _Gotcha(
      title: 'LogicalKeySet is legacy-flavoured',
      body:
          'The Flutter team recommends SingleActivator or CharacterActivator for '
          'new code. LogicalKeySet remains in the framework for true "unordered '
          'key set" semantics and for migration of older shortcut maps.',
    ),
    _Gotcha(
      title: 'includeRepeats default changed',
      body:
          'SingleActivator defaults to includeRepeats:false, which is what you '
          'want 99% of the time. Only set it to true for scroll/jog-style '
          'shortcuts where a held key should repeat the intent.',
    ),
    _Gotcha(
      title: 'meta vs control per platform',
      body:
          'On macOS the native modifier is Cmd (meta). On Windows/Linux it is '
          'Ctrl. Detect via defaultTargetPlatform and toggle control/meta in '
          'your SingleActivator so your app feels native everywhere.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _p.slate.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.neon.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.warning_amber_rounded,
                  color: _palNeonSoft, size: 20),
              SizedBox(width: 8),
              Text(
                'Gotchas',
                style: TextStyle(
                  color: _palInk,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final g in _gotchas)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _GotchaRow(gotcha: g),
            ),
        ],
      ),
    );
  }
}

class _Gotcha {
  final String title;
  final String body;

  const _Gotcha({required this.title, required this.body});
}

class _GotchaRow extends StatelessWidget {
  final _Gotcha gotcha;

  const _GotchaRow({required this.gotcha});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _p.slateDeep.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _p.neon.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _p.neon.withValues(alpha: 0.45)),
            ),
            child: const Icon(Icons.priority_high,
                color: _palNeon, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  gotcha.title,
                  style: const TextStyle(
                    color: _palInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  gotcha.body,
                  style: TextStyle(
                    color: _p.ink.withValues(alpha: 0.82),
                    fontSize: 12.5,
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

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

class _Footer extends StatelessWidget {
  final int logSize;
  final bool helpShown;

  const _Footer({required this.logSize, required this.helpShown});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: _palNeon,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _palNeon,
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Harness ready — $logSize activations logged'
          '${helpShown ? ", help overlay up" : ""}.',
          style: TextStyle(
            color: _p.ink.withValues(alpha: 0.78),
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
        const Spacer(),
        Text(
          'd4rt AST harness • dynamic build(BuildContext) => MaterialApp',
          style: TextStyle(
            color: _p.muted,
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Utilities
// ---------------------------------------------------------------------------

String _describeKey(LogicalKeyboardKey k) {
  // Map the common keys to friendly names; fallback to keyLabel / debugName.
  final synonyms = <LogicalKeyboardKey, String>{
    LogicalKeyboardKey.control: 'Ctrl',
    LogicalKeyboardKey.controlLeft: 'CtrlL',
    LogicalKeyboardKey.controlRight: 'CtrlR',
    LogicalKeyboardKey.shift: 'Shift',
    LogicalKeyboardKey.shiftLeft: 'ShiftL',
    LogicalKeyboardKey.shiftRight: 'ShiftR',
    LogicalKeyboardKey.alt: 'Alt',
    LogicalKeyboardKey.altLeft: 'AltL',
    LogicalKeyboardKey.altRight: 'AltR',
    LogicalKeyboardKey.meta: 'Meta',
    LogicalKeyboardKey.metaLeft: 'MetaL',
    LogicalKeyboardKey.metaRight: 'MetaR',
    LogicalKeyboardKey.space: 'Space',
    LogicalKeyboardKey.enter: 'Enter',
    LogicalKeyboardKey.escape: 'Esc',
  };
  final direct = synonyms[k];
  if (direct != null) return direct;
  final label = k.keyLabel;
  if (label.isNotEmpty) return label;
  return k.debugName ?? 'Key(${k.keyId.toRadixString(16)})';
}

String _fmtTime(DateTime t) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(t.hour)}:${two(t.minute)}:${two(t.second)}';
}

// ---------------------------------------------------------------------------
// Palette constants reused as const-initializable values
// ---------------------------------------------------------------------------

const Color _palViolet = Color(0xFF7C3AED);
const Color _palDeepViolet = Color(0xFF4C1D95);
const Color _palNeon = Color(0xFF22C55E);
const Color _palNeonSoft = Color(0xFF86EFAC);
const Color _palInk = Color(0xFFE2E8F0);
const Color _palMuted = Color(0xFF94A3B8);
