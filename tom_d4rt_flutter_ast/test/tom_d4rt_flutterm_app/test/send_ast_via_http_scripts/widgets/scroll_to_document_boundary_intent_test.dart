import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// ScrollToDocumentBoundaryIntent — Deep Visual Demo
// ============================================================================
//
// This demo explores Flutter's `ScrollToDocumentBoundaryIntent`, an Intent
// used by Flutter's default text / scroll behavior to describe the action
// of jumping straight to the start or end of the currently-focused document.
//
// Signature:
//   ScrollToDocumentBoundaryIntent({required bool forward})
//
//   forward == false -> jump to the document's beginning (offset 0)
//   forward == true  -> jump to the document's end (maxScrollExtent)
//
// In Flutter's default shortcut table, this intent is bound to Ctrl+Home /
// Ctrl+End on Windows & Linux, and to Cmd+Up / Cmd+Down on macOS. The paired
// `ScrollToDocumentBoundaryAction` animates the PrimaryScrollController to
// the respective boundary.
//
// The demo is organised as an eleven-section "Document Boundary Jumper":
//
//   1. Hero header with decorative parchment strip and pennants.
//   2. Document-style scroller (60 paragraph blocks) — keyboard-driven.
//   3. Edge-flash animation when a boundary is reached.
//   4. Intent history timeline (last ~10 dispatches).
//   5. Manual dispatch buttons (Actions.invoke).
//   6. Intent anatomy card (constructor signature).
//   7. Comparison with other scroll intents.
//   8. Platform shortcut reference card.
//   9. Teaching panel (three mental-model tiles).
//   10. Use cases strip (readers, chat, changelogs, settings).
//   11. Footer summary card.
//
// Palette:
//   parchment  0xFFFAF1E4
//   ink        0xFF1B1B1B
//   seal-red   0xFFB23A48
//   leaf-green 0xFF6A994E
//
// Harness: d4rt `build(BuildContext context)` returning a MaterialApp. No
// main(), no runApp(). Only `material.dart` + `services.dart` are imported.
// All disposal is handled by the stateful widget inside.
// ============================================================================

const Color kParchment = Color(0xFFFAF1E4);
const Color kInk = Color(0xFF1B1B1B);
const Color kSealRed = Color(0xFFB23A48);
const Color kLeafGreen = Color(0xFF6A994E);
const Color kDim = Color(0xFF8A7E6B);
const Color kSoft = Color(0xFFEFE4CF);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollToDocumentBoundaryIntent Demo',
    theme: ThemeData(
      primaryColor: kSealRed,
      scaffoldBackgroundColor: kParchment,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kSealRed,
        primary: kSealRed,
        secondary: kLeafGreen,
        surface: kParchment,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: kInk,
        foregroundColor: kParchment,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'serif',
          fontWeight: FontWeight.w700,
          color: kInk,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'serif',
          fontWeight: FontWeight.w700,
          color: kInk,
        ),
        titleLarge: TextStyle(
          fontFamily: 'serif',
          fontWeight: FontWeight.w600,
          color: kInk,
        ),
        bodyLarge: TextStyle(fontFamily: 'serif', color: kInk),
        bodyMedium: TextStyle(fontFamily: 'serif', color: kInk),
        labelLarge: TextStyle(fontFamily: 'serif', color: kInk),
      ),
    ),
    home: const _DocumentBoundaryJumperPage(),
  );
}

// ----------------------------------------------------------------------------
// Page shell
// ----------------------------------------------------------------------------

class _DocumentBoundaryJumperPage extends StatefulWidget {
  const _DocumentBoundaryJumperPage();

  @override
  State<_DocumentBoundaryJumperPage> createState() =>
      _DocumentBoundaryJumperPageState();
}

class _DocumentBoundaryJumperPageState
    extends State<_DocumentBoundaryJumperPage>
    with TickerProviderStateMixin {
  // Scroll controllers ---------------------------------------------------
  late final ScrollController _pageController;
  late final ScrollController _documentController;

  // Focus nodes ----------------------------------------------------------
  late final FocusNode _documentFocus;

  // Edge-flash animation controllers ------------------------------------
  late final AnimationController _topFlashController;
  late final AnimationController _bottomFlashController;

  // Intent dispatch log --------------------------------------------------
  final List<_IntentRecord> _history = <_IntentRecord>[];
  static const int _historyLimit = 10;

  // Inner document metrics ----------------------------------------------
  double _currentOffset = 0;
  double _maxOffset = 0;
  bool _atTop = true;
  bool _atBottom = false;

  @override
  void initState() {
    super.initState();
    _pageController = ScrollController();
    _documentController = ScrollController();
    _documentFocus = FocusNode(debugLabel: 'document-scroller');

    _topFlashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _bottomFlashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _documentController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _documentController.removeListener(_handleScroll);
    _pageController.dispose();
    _documentController.dispose();
    _documentFocus.dispose();
    _topFlashController.dispose();
    _bottomFlashController.dispose();
    super.dispose();
  }

  // ----- Scroll handling ------------------------------------------------

  void _handleScroll() {
    if (!_documentController.hasClients) return;
    final pos = _documentController.position;
    final atTop = pos.pixels <= pos.minScrollExtent + 0.5;
    final atBottom = pos.pixels >= pos.maxScrollExtent - 0.5;

    if (atTop && !_atTop) {
      _topFlashController.forward(from: 0).then((_) {
        if (mounted) _topFlashController.reverse();
      });
    }
    if (atBottom && !_atBottom) {
      _bottomFlashController.forward(from: 0).then((_) {
        if (mounted) _bottomFlashController.reverse();
      });
    }
    setState(() {
      _currentOffset = pos.pixels;
      _maxOffset = pos.maxScrollExtent;
      _atTop = atTop;
      _atBottom = atBottom;
    });
  }

  // ----- Intent bookkeeping --------------------------------------------

  void _recordIntent(bool forward, String source) {
    setState(() {
      _history.insert(
        0,
        _IntentRecord(
          forward: forward,
          source: source,
          at: DateTime.now(),
        ),
      );
      if (_history.length > _historyLimit) {
        _history.removeRange(_historyLimit, _history.length);
      }
    });
    debugPrint(
      'ScrollToDocumentBoundaryIntent(forward: $forward) dispatched via $source',
    );
  }

  // ----- Programmatic invocation ---------------------------------------

  void _invokeBoundary(bool forward, {String source = 'button'}) {
    _recordIntent(forward, source);
    final ctx = _documentFocus.context ?? context;
    Actions.maybeInvoke<ScrollToDocumentBoundaryIntent>(
      ctx,
      ScrollToDocumentBoundaryIntent(forward: forward),
    );
  }

  // ----- Build ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Boundary Jumper'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                'ScrollToDocumentBoundaryIntent',
                style: TextStyle(
                  color: kParchment.withValues(alpha: 0.85),
                  fontFamily: 'serif',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Scrollbar(
        controller: _pageController,
        child: SingleChildScrollView(
          controller: _pageController,
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroHeader(),
              const SizedBox(height: 24),
              _SectionTitle(
                number: '02',
                title: 'Document-style scroller',
                subtitle:
                    'Focus the document below and press Ctrl+Home / Ctrl+End.',
              ),
              const SizedBox(height: 12),
              _DocumentScroller(
                controller: _documentController,
                focusNode: _documentFocus,
                topFlash: _topFlashController,
                bottomFlash: _bottomFlashController,
                onIntent: _recordIntent,
                currentOffset: _currentOffset,
                maxOffset: _maxOffset,
                atTop: _atTop,
                atBottom: _atBottom,
              ),
              const SizedBox(height: 24),
              _SectionTitle(
                number: '04',
                title: 'Intent dispatch timeline',
                subtitle:
                    'Last ten intents — seal-red means start, leaf-green means end.',
              ),
              const SizedBox(height: 12),
              _IntentHistoryStrip(history: _history),
              const SizedBox(height: 24),
              _SectionTitle(
                number: '05',
                title: 'Manual dispatch',
                subtitle:
                    'Actions.maybeInvoke lets non-keyboard triggers fire the same intent.',
              ),
              const SizedBox(height: 12),
              _ManualDispatchButtons(
                onJumpStart: () => _invokeBoundary(false, source: 'button'),
                onJumpEnd: () => _invokeBoundary(true, source: 'button'),
              ),
              const SizedBox(height: 24),
              _SectionTitle(
                number: '06',
                title: 'Intent anatomy',
                subtitle: 'A single required boolean decides the direction.',
              ),
              const SizedBox(height: 12),
              const _IntentAnatomyCard(),
              const SizedBox(height: 24),
              _SectionTitle(
                number: '07',
                title: 'Compared to other scroll intents',
                subtitle:
                    'Line / page / boundary / imperative — pick the right tool.',
              ),
              const SizedBox(height: 12),
              const _ComparisonTable(),
              const SizedBox(height: 24),
              _SectionTitle(
                number: '08',
                title: 'Platform shortcut reference',
                subtitle:
                    'Flutter ships these bindings out-of-the-box on desktop.',
              ),
              const SizedBox(height: 12),
              const _PlatformShortcutCard(),
              const SizedBox(height: 24),
              _SectionTitle(
                number: '09',
                title: 'Teaching panel',
                subtitle: 'Three rules of thumb for working with boundaries.',
              ),
              const SizedBox(height: 12),
              const _TeachingPanel(),
              const SizedBox(height: 24),
              _SectionTitle(
                number: '10',
                title: 'Use cases',
                subtitle: 'Where absolute jumps really shine.',
              ),
              const SizedBox(height: 12),
              const _UseCasesStrip(),
              const SizedBox(height: 24),
              const _FooterSummaryCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 1. Hero header
// ============================================================================

class _HeroHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: kInk.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
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
                  color: kSealRed,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'INTENT • 01',
                  style: TextStyle(
                    color: kParchment,
                    fontFamily: 'serif',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Document edge jumps, baked in',
                style: TextStyle(
                  color: kParchment.withValues(alpha: 0.7),
                  fontFamily: 'serif',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'ScrollToDocumentBoundaryIntent',
            style: TextStyle(
              color: kParchment,
              fontFamily: 'serif',
              fontSize: 30,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Snap to start, snap to end.',
            style: TextStyle(
              color: kParchment.withValues(alpha: 0.75),
              fontFamily: 'serif',
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),
          const _ParchmentStrip(),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _HeroChip(label: 'Flutter 3.41.6'),
              _HeroChip(label: 'Intent + Action pair'),
              _HeroChip(label: 'Default on desktop'),
              _HeroChip(label: 'Animates via ScrollPosition'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final String label;
  const _HeroChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: kParchment.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: kParchment.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: kParchment.withValues(alpha: 0.85),
          fontFamily: 'serif',
          fontSize: 12,
        ),
      ),
    );
  }
}

class _ParchmentStrip extends StatelessWidget {
  const _ParchmentStrip();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Row(
        children: [
          _Pennant(color: kSealRed, label: 'START', leading: true),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: kParchment,
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kParchment,
                    kParchment.withValues(alpha: 0.93),
                    kSoft,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: kInk.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CustomPaint(painter: _ParchmentTexturePainter()),
            ),
          ),
          _Pennant(color: kLeafGreen, label: 'END', leading: false),
        ],
      ),
    );
  }
}

class _Pennant extends StatelessWidget {
  final Color color;
  final String label;
  final bool leading;
  const _Pennant({
    required this.color,
    required this.label,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: CustomPaint(
        painter: _PennantPainter(color: color, leading: leading),
        child: Align(
          alignment: leading ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: leading ? 14 : 14,
              vertical: 6,
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: kParchment,
                fontFamily: 'serif',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PennantPainter extends CustomPainter {
  final Color color;
  final bool leading;
  _PennantPainter({required this.color, required this.leading});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    if (leading) {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width - 14, size.height / 2)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
    } else {
      path
        ..moveTo(size.width, 0)
        ..lineTo(0, 0)
        ..lineTo(14, size.height / 2)
        ..lineTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..close();
    }
    canvas.drawShadow(path, kInk.withValues(alpha: 0.5), 3, false);
    canvas.drawPath(path, paint);

    final trim = Paint()
      ..color = kParchment.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(path, trim);
  }

  @override
  bool shouldRepaint(covariant _PennantPainter old) =>
      old.color != color || old.leading != leading;
}

class _ParchmentTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kInk.withValues(alpha: 0.06)
      ..strokeWidth = 1;
    for (double y = 10; y < size.height; y += 12) {
      canvas.drawLine(
        Offset(10, y),
        Offset(size.width - 10, y),
        paint,
      );
    }
    final dotPaint = Paint()..color = kSealRed.withValues(alpha: 0.3);
    canvas.drawCircle(Offset(size.width * 0.25, size.height / 2), 3, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height / 2), 3, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.75, size.height / 2), 3, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _ParchmentTexturePainter old) => false;
}

// ============================================================================
// Section titles
// ============================================================================

class _SectionTitle extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  const _SectionTitle({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: kSealRed,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: kParchment,
              fontFamily: 'serif',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'serif',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: kInk,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 14,
                  color: kInk.withValues(alpha: 0.65),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 2 & 3. Document scroller with edge flashes
// ============================================================================

class _DocumentScroller extends StatelessWidget {
  final ScrollController controller;
  final FocusNode focusNode;
  final AnimationController topFlash;
  final AnimationController bottomFlash;
  final void Function(bool forward, String source) onIntent;
  final double currentOffset;
  final double maxOffset;
  final bool atTop;
  final bool atBottom;

  const _DocumentScroller({
    required this.controller,
    required this.focusNode,
    required this.topFlash,
    required this.bottomFlash,
    required this.onIntent,
    required this.currentOffset,
    required this.maxOffset,
    required this.atTop,
    required this.atBottom,
  });

  static final Map<ShortcutActivator, Intent> _shortcuts =
      <ShortcutActivator, Intent>{
    const SingleActivator(LogicalKeyboardKey.home, control: true):
        const ScrollToDocumentBoundaryIntent(forward: false),
    const SingleActivator(LogicalKeyboardKey.end, control: true):
        const ScrollToDocumentBoundaryIntent(forward: true),
    // On macOS, platform default is Cmd+Up / Cmd+Down — show both.
    const SingleActivator(LogicalKeyboardKey.arrowUp, meta: true):
        const ScrollToDocumentBoundaryIntent(forward: false),
    const SingleActivator(LogicalKeyboardKey.arrowDown, meta: true):
        const ScrollToDocumentBoundaryIntent(forward: true),
  };

  @override
  Widget build(BuildContext context) {
    final actions = <Type, Action<Intent>>{
      ScrollToDocumentBoundaryIntent: _LoggingBoundaryAction(
        controller: controller,
        onFire: (forward) => onIntent(forward, 'keyboard'),
      ),
    };

    return Container(
      decoration: BoxDecoration(
        color: kParchment,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kInk.withValues(alpha: 0.2), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: kInk.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DocumentToolbar(
            atTop: atTop,
            atBottom: atBottom,
            offset: currentOffset,
            max: maxOffset,
            focusNode: focusNode,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 360,
            child: Shortcuts(
              shortcuts: _shortcuts,
              child: Actions(
                actions: actions,
                child: Focus(
                  focusNode: focusNode,
                  autofocus: false,
                  child: Stack(
                    children: [
                      PrimaryScrollController(
                        controller: controller,
                        child: Scrollbar(
                          controller: controller,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: controller,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List<Widget>.generate(
                                60,
                                (i) => _DocumentBlock(
                                  index: i,
                                  title: _blockTitle(i),
                                  body: _blockBody(i),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      _EdgeFlash(
                        controller: topFlash,
                        alignment: Alignment.topCenter,
                        color: kLeafGreen,
                      ),
                      _EdgeFlash(
                        controller: bottomFlash,
                        alignment: Alignment.bottomCenter,
                        color: kLeafGreen,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _blockTitle(int i) {
    const titles = <String>[
      'Chapter of firsts',
      'A small warning',
      'The ledger of intents',
      'On default shortcuts',
      'Why boundaries matter',
      'A short history of Ctrl+Home',
      'Primary scrollables',
      'Smooth versus snap',
      'The contract of Action',
      'Focus is the compass',
    ];
    return '${i + 1}. ${titles[i % titles.length]}';
  }

  String _blockBody(int i) {
    const lines = <String>[
      'A long document invites readers to lose their place. The boundary intent is a lifeline — one keystroke and you are back at the top.',
      'Intents describe meaning; Actions describe execution. ScrollToDocumentBoundaryIntent is pure intent: "go to the edge".',
      'The default ScrollToDocumentBoundaryAction animates the PrimaryScrollController to zero or maxScrollExtent, avoiding the jolt of jumpTo.',
      'This matters for accessibility too. A screen-reader user expects Ctrl+Home to fully rewind the document, not to scroll one page at a time.',
      'Flutter already binds these on desktop; you usually get them for free when your widget participates in PrimaryScrollController.',
      'When you override, remember the boundary intent honours the focused scrollable, not necessarily the literal primary one.',
      'A boundary is absolute. Unlike a page- or line-scroll, it does not compose: two Ctrl+Ends are the same as one.',
      'Pair boundary jumps with visual feedback — a soft flash at the edge confirms the jump landed where the user expected.',
      'Consider keeping a short history of boundary jumps; it helps debug focus and navigation surprises.',
      'Above all, never break the default. Users trust Ctrl+Home — earn that trust back if you replace it.',
    ];
    return lines[i % lines.length];
  }
}

class _DocumentToolbar extends StatelessWidget {
  final bool atTop;
  final bool atBottom;
  final double offset;
  final double max;
  final FocusNode focusNode;

  const _DocumentToolbar({
    required this.atTop,
    required this.atBottom,
    required this.offset,
    required this.max,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final progress = max <= 0 ? 0.0 : (offset / max).clamp(0.0, 1.0);
    return Row(
      children: [
        _StatusDot(label: 'TOP', active: atTop, color: kLeafGreen),
        const SizedBox(width: 8),
        _StatusDot(label: 'BOTTOM', active: atBottom, color: kLeafGreen),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: kInk.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: kSealRed,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '${offset.toStringAsFixed(0)} / ${max.toStringAsFixed(0)}',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 12,
            color: kInk.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () => focusNode.requestFocus(),
          style: ElevatedButton.styleFrom(
            backgroundColor: kInk,
            foregroundColor: kParchment,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          icon: const Icon(Icons.center_focus_strong, size: 16),
          label: const Text('Focus document'),
        ),
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  final String label;
  final bool active;
  final Color color;
  const _StatusDot({
    required this.label,
    required this.active,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            active ? color.withValues(alpha: 0.2) : kInk.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color:
              active ? color : kInk.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: active ? color : kInk.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: active ? color : kInk.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentBlock extends StatelessWidget {
  final int index;
  final String title;
  final String body;
  const _DocumentBlock({
    required this.index,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final isEven = index.isEven;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isEven
            ? kSoft.withValues(alpha: 0.55)
            : kParchment.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: kInk.withValues(alpha: isEven ? 0.12 : 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kInk,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 14,
              color: kInk.withValues(alpha: 0.85),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _EdgeFlash extends StatelessWidget {
  final AnimationController controller;
  final Alignment alignment;
  final Color color;
  const _EdgeFlash({
    required this.controller,
    required this.alignment,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final v = controller.value;
          return Align(
            alignment: alignment,
            child: Opacity(
              opacity: v,
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: alignment == Alignment.topCenter
                        ? Alignment.topCenter
                        : Alignment.bottomCenter,
                    end: alignment == Alignment.topCenter
                        ? Alignment.bottomCenter
                        : Alignment.topCenter,
                    colors: [
                      color.withValues(alpha: 0.55),
                      color.withValues(alpha: 0.0),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: alignment == Alignment.topCenter
                        ? const Radius.circular(8)
                        : Radius.zero,
                    topRight: alignment == Alignment.topCenter
                        ? const Radius.circular(8)
                        : Radius.zero,
                    bottomLeft: alignment == Alignment.bottomCenter
                        ? const Radius.circular(8)
                        : Radius.zero,
                    bottomRight: alignment == Alignment.bottomCenter
                        ? const Radius.circular(8)
                        : Radius.zero,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Our own action implementation for the intent. Flutter's framework handles
// ScrollToDocumentBoundaryIntent inside EditableText — there is no public
// ScrollToDocumentBoundaryAction class exported. For this demo we animate
// a regular ScrollController between minScrollExtent and maxScrollExtent,
// reproducing the same observable behaviour for a plain scrollable.
class _LoggingBoundaryAction extends Action<ScrollToDocumentBoundaryIntent> {
  final ScrollController controller;
  final void Function(bool forward) onFire;
  _LoggingBoundaryAction({required this.controller, required this.onFire});

  @override
  Object? invoke(ScrollToDocumentBoundaryIntent intent) {
    onFire(intent.forward);
    if (!controller.hasClients) return null;
    final position = controller.position;
    final target = intent.forward
        ? position.maxScrollExtent
        : position.minScrollExtent;
    controller.animateTo(
      target,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
    return null;
  }
}

// ============================================================================
// 4. Intent history timeline
// ============================================================================

class _IntentRecord {
  final bool forward;
  final String source;
  final DateTime at;
  _IntentRecord({
    required this.forward,
    required this.source,
    required this.at,
  });
}

class _IntentHistoryStrip extends StatelessWidget {
  final List<_IntentRecord> history;
  const _IntentHistoryStrip({required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: kParchment,
        border: Border.all(color: kInk.withValues(alpha: 0.15)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: history.isEmpty
          ? Center(
              child: Text(
                'No intents yet — press Ctrl+Home or Ctrl+End in the document.',
                style: TextStyle(
                  fontFamily: 'serif',
                  color: kInk.withValues(alpha: 0.55),
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: history.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final r = history[i];
                return _IntentChip(record: r, index: i);
              },
            ),
    );
  }
}

class _IntentChip extends StatelessWidget {
  final _IntentRecord record;
  final int index;
  const _IntentChip({required this.record, required this.index});

  @override
  Widget build(BuildContext context) {
    final color = record.forward ? kLeafGreen : kSealRed;
    final label = record.forward ? 'End ->' : '<- Start';
    final time = _fmtTime(record.at);
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${index + 1}',
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 11,
                  color: kInk.withValues(alpha: 0.55),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            '${record.source} · $time',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 11,
              color: kInk.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  String _fmtTime(DateTime t) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(t.hour)}:${two(t.minute)}:${two(t.second)}';
  }
}

// ============================================================================
// 5. Manual dispatch buttons
// ============================================================================

class _ManualDispatchButtons extends StatelessWidget {
  final VoidCallback onJumpStart;
  final VoidCallback onJumpEnd;
  const _ManualDispatchButtons({
    required this.onJumpStart,
    required this.onJumpEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _BigButton(
            onPressed: onJumpStart,
            color: kSealRed,
            icon: Icons.first_page,
            title: 'Jump to start',
            subtitle: 'ScrollToDocumentBoundaryIntent(forward: false)',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _BigButton(
            onPressed: onJumpEnd,
            color: kLeafGreen,
            icon: Icons.last_page,
            title: 'Jump to end',
            subtitle: 'ScrollToDocumentBoundaryIntent(forward: true)',
          ),
        ),
      ],
    );
  }
}

class _BigButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  const _BigButton({
    required this.onPressed,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: kParchment.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: kParchment, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: kParchment,
                        fontFamily: 'serif',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: kParchment.withValues(alpha: 0.85),
                        fontFamily: 'serif',
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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

// ============================================================================
// 6. Intent anatomy card
// ============================================================================

class _IntentAnatomyCard extends StatelessWidget {
  const _IntentAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Constructor',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 12,
              color: kParchment.withValues(alpha: 0.6),
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kParchment.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kParchment.withValues(alpha: 0.2)),
            ),
            child: const SelectableText(
              'const ScrollToDocumentBoundaryIntent({required bool forward})',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: kParchment,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _AnatomyRow(
            label: 'forward',
            type: 'bool (required)',
            desc:
                'true -> maxScrollExtent (end of document). false -> 0 (start).',
            color: kSealRed,
          ),
          const SizedBox(height: 10),
          _AnatomyRow(
            label: 'paired Action',
            type: 'ScrollToDocumentBoundaryAction',
            desc:
                'Animates the PrimaryScrollController to the requested edge.',
            color: kLeafGreen,
          ),
          const SizedBox(height: 10),
          _AnatomyRow(
            label: 'dispatched by',
            type: 'Shortcuts / Actions.invoke',
            desc:
                'Keyboard bindings + programmatic invocation both produce the same effect.',
            color: kParchment,
          ),
        ],
      ),
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  final String label;
  final String type;
  final String desc;
  final Color color;
  const _AnatomyRow({
    required this.label,
    required this.type,
    required this.desc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 52,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: kParchment,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: kParchment.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: kParchment.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 13,
                  color: kParchment.withValues(alpha: 0.78),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 7. Comparison table
// ============================================================================

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kParchment,
        border: Border.all(color: kInk.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: kInk.withValues(alpha: 0.06),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: const [
                _ComparisonCell('Mechanism', flex: 3, bold: true),
                _ComparisonCell('Granularity', flex: 2, bold: true),
                _ComparisonCell('Animates?', flex: 2, bold: true),
                _ComparisonCell('Use when', flex: 4, bold: true),
              ],
            ),
          ),
          _ComparisonRow(
            mechanism: 'ScrollIntent(line)',
            granularity: 'Line',
            animates: 'Yes',
            useWhen: 'Arrow keys inside a focused scrollable.',
            accent: kDim,
          ),
          _ComparisonRow(
            mechanism: 'ScrollIntent(page)',
            granularity: 'Viewport',
            animates: 'Yes',
            useWhen: 'PageUp / PageDown in readers.',
            accent: kDim,
          ),
          _ComparisonRow(
            mechanism: 'ScrollToDocumentBoundaryIntent(forward)',
            granularity: 'Document',
            animates: 'Yes',
            useWhen: 'Ctrl+Home / Ctrl+End — jump to the absolute edges.',
            accent: kSealRed,
            highlight: true,
          ),
          _ComparisonRow(
            mechanism: 'ScrollController.animateTo',
            granularity: 'Arbitrary',
            animates: 'Yes (curve configurable)',
            useWhen: 'Imperative programmatic scrolling.',
            accent: kLeafGreen,
          ),
          _ComparisonRow(
            mechanism: 'ScrollController.jumpTo',
            granularity: 'Arbitrary',
            animates: 'No — teleport',
            useWhen: 'Instant restore on resize / state rebuild.',
            accent: kDim,
            last: true,
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String mechanism;
  final String granularity;
  final String animates;
  final String useWhen;
  final Color accent;
  final bool highlight;
  final bool last;

  const _ComparisonRow({
    required this.mechanism,
    required this.granularity,
    required this.animates,
    required this.useWhen,
    required this.accent,
    this.highlight = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: highlight
            ? kSealRed.withValues(alpha: 0.06)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: last ? Colors.transparent : kInk.withValues(alpha: 0.08),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    mechanism,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: kInk,
                      fontWeight:
                          highlight ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _ComparisonCell(granularity, flex: 2),
          _ComparisonCell(animates, flex: 2),
          _ComparisonCell(useWhen, flex: 4),
        ],
      ),
    );
  }
}

class _ComparisonCell extends StatelessWidget {
  final String text;
  final int flex;
  final bool bold;
  const _ComparisonCell(this.text, {required this.flex, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'serif',
          fontSize: bold ? 12 : 13,
          color: kInk.withValues(alpha: bold ? 0.85 : 0.8),
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          letterSpacing: bold ? 1.1 : 0,
        ),
      ),
    );
  }
}

// ============================================================================
// 8. Platform shortcut reference card
// ============================================================================

class _PlatformShortcutCard extends StatelessWidget {
  const _PlatformShortcutCard();

  @override
  Widget build(BuildContext context) {
    const entries = <_PlatformEntry>[
      _PlatformEntry(
        platform: 'Windows / Linux',
        start: 'Ctrl + Home',
        end: 'Ctrl + End',
        notes: 'Default Flutter desktop bindings — our demo uses these.',
      ),
      _PlatformEntry(
        platform: 'macOS',
        start: 'Cmd + Up (or Home)',
        end: 'Cmd + Down (or End)',
        notes: 'Flutter binds Cmd+Up/Down by convention on macOS.',
      ),
      _PlatformEntry(
        platform: 'Web',
        start: 'Ctrl + Home',
        end: 'Ctrl + End',
        notes:
            'Browser may intercept — make sure the focused scrollable swallows the event first.',
      ),
      _PlatformEntry(
        platform: 'Mobile (iOS / Android)',
        start: 'not bound',
        end: 'not bound',
        notes:
            'Mobile relies on scroll gestures; invoke the intent programmatically if needed.',
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: kParchment,
        border: Border.all(color: kInk.withValues(alpha: 0.15)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          for (int i = 0; i < entries.length; i++)
            _PlatformRow(entry: entries[i], last: i == entries.length - 1),
        ],
      ),
    );
  }
}

class _PlatformEntry {
  final String platform;
  final String start;
  final String end;
  final String notes;
  const _PlatformEntry({
    required this.platform,
    required this.start,
    required this.end,
    required this.notes,
  });
}

class _PlatformRow extends StatelessWidget {
  final _PlatformEntry entry;
  final bool last;
  const _PlatformRow({required this.entry, required this.last});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: last ? Colors.transparent : kInk.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              entry.platform,
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: kInk,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _ShortcutKeyPill(label: entry.start, color: kSealRed),
                    const SizedBox(width: 8),
                    _ShortcutKeyPill(label: entry.end, color: kLeafGreen),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  entry.notes,
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 13,
                    color: kInk.withValues(alpha: 0.7),
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

class _ShortcutKeyPill extends StatelessWidget {
  final String label;
  final Color color;
  const _ShortcutKeyPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ============================================================================
// 9. Teaching panel
// ============================================================================

class _TeachingPanel extends StatelessWidget {
  const _TeachingPanel();

  @override
  Widget build(BuildContext context) {
    const tiles = <_TeachingTile>[
      _TeachingTile(
        number: '01',
        headline: 'Prefer the intent over custom keybindings',
        body:
            'Flutter already ships default bindings on desktop. Reinventing them diverges your app from user expectations.',
        color: kSealRed,
      ),
      _TeachingTile(
        number: '02',
        headline: 'Mind the primary scrollable',
        body:
            'The default action targets the PrimaryScrollController. Make the scrollable primary, or ensure it owns focus when the shortcut fires.',
        color: kLeafGreen,
      ),
      _TeachingTile(
        number: '03',
        headline: 'Animate, do not teleport',
        body:
            'The paired action animates smoothly — an improvement over jumpTo(0) which jolts the viewport.',
        color: kInk,
      ),
    ];
    return Column(
      children: [
        for (final t in tiles) ...[
          t,
          if (t != tiles.last) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _TeachingTile extends StatelessWidget {
  final String number;
  final String headline;
  final String body;
  final Color color;
  const _TeachingTile({
    required this.number,
    required this.headline,
    required this.body,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kParchment,
        border: Border.all(color: color.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                color: kParchment,
                fontFamily: 'serif',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headline,
                  style: const TextStyle(
                    fontFamily: 'serif',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 13.5,
                    color: kInk.withValues(alpha: 0.78),
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
// 10. Use cases strip
// ============================================================================

class _UseCasesStrip extends StatelessWidget {
  const _UseCasesStrip();

  @override
  Widget build(BuildContext context) {
    const cases = <_UseCaseTile>[
      _UseCaseTile(
        icon: Icons.menu_book,
        title: 'Document readers',
        body: 'Ebooks, PDFs, markdown viewers — rewind to cover or jump to the back matter.',
        color: kSealRed,
      ),
      _UseCaseTile(
        icon: Icons.forum,
        title: 'Chat logs',
        body: 'Bounce from the oldest pinned message to the freshest reply.',
        color: kLeafGreen,
      ),
      _UseCaseTile(
        icon: Icons.history_edu,
        title: 'Changelogs',
        body: 'Show the newest release or walk back to v0.1.',
        color: kInk,
      ),
      _UseCaseTile(
        icon: Icons.settings,
        title: 'Long settings pages',
        body: 'Snap between the overview at the top and the danger zone at the bottom.',
        color: kDim,
      ),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.1,
      children: cases,
    );
  }
}

class _UseCaseTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  const _UseCaseTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kParchment,
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'serif',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    body,
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 12,
                      color: kInk.withValues(alpha: 0.72),
                      height: 1.35,
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

// ============================================================================
// 11. Footer summary card
// ============================================================================

class _FooterSummaryCard extends StatelessWidget {
  const _FooterSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: kLeafGreen,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'SUMMARY',
                  style: TextStyle(
                    color: kInk,
                    fontFamily: 'serif',
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.8,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Snap, flash, remember — three moves of a great doc jumper.',
                style: TextStyle(
                  color: kParchment.withValues(alpha: 0.8),
                  fontFamily: 'serif',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'ScrollToDocumentBoundaryIntent is the abstract verb for "take me to the edge of this scroll". '
            'Pair it with the default ScrollToDocumentBoundaryAction and your scrollable already plays nicely '
            'with Ctrl+Home / Ctrl+End. Wrap the Action if you need side-effects like analytics or visual '
            'feedback, keep the underlying smooth animation, and always honour the platform convention.',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 14,
              color: kParchment.withValues(alpha: 0.88),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _FooterChip(label: 'forward: false -> start'),
              _FooterChip(label: 'forward: true -> end'),
              _FooterChip(label: 'animated via ScrollPosition'),
              _FooterChip(label: 'Actions.invoke-friendly'),
              _FooterChip(label: 'focus-aware'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterChip extends StatelessWidget {
  final String label;
  const _FooterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: kParchment.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: kParchment.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: kParchment.withValues(alpha: 0.9),
          fontFamily: 'serif',
          fontSize: 12,
        ),
      ),
    );
  }
}

// ============================================================================
// End of ScrollToDocumentBoundaryIntent visual demo.
// ============================================================================
