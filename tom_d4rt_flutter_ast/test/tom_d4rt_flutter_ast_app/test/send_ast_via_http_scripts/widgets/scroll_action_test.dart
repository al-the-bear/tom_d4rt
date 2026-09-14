import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =====================================================================
// Keyboard Shortcut Scroller — a deep visual demo of ScrollAction and
// ScrollIntent. The file is structured as a single hand-sculpted tree:
// each labelled section builds its own widgets, no shared factories.
//
// Palette (deep-green mechanical-keyboard theme):
//   body:      0xFF1F3D2B
//   rim:       0xFF2F5A40
//   highlight: 0xFFCFE8D8
//   amber:     0xFFF2B134
//
// Entry point for the d4rt AST harness.
// =====================================================================

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollAction & ScrollIntent',
    home: _KeyboardShortcutScrollerHome(),
  );
}

// ---------------------------------------------------------------------
// Top-level home — holds state for the last intent log and the last
// pressed key highlight. Uses a StatefulWidget because we want to
// react to key events and keep a live HUD.
// ---------------------------------------------------------------------

class _KeyboardShortcutScrollerHome extends StatefulWidget {
  const _KeyboardShortcutScrollerHome();

  @override
  State<_KeyboardShortcutScrollerHome> createState() =>
      _KeyboardShortcutScrollerHomeState();
}

class _KeyboardShortcutScrollerHomeState
    extends State<_KeyboardShortcutScrollerHome> {
  // Log of the most recent scroll intents fired by the custom action.
  final List<_IntentLogEntry> _intentLog = <_IntentLogEntry>[];

  // Which key was last pressed (for the keyboard visualization glow).
  String _lastPressedKey = '';
  DateTime _lastPressedAt = DateTime.fromMillisecondsSinceEpoch(0);

  // Focus nodes and scroll controllers for the two scrollers.
  final FocusNode _verticalFocus = FocusNode(debugLabel: 'vertical-scroller');
  final FocusNode _horizontalFocus =
      FocusNode(debugLabel: 'horizontal-scroller');
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Give the vertical scroller initial focus so keystrokes are captured.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _verticalFocus.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _verticalFocus.dispose();
    _horizontalFocus.dispose();
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  // Called by the custom ScrollAction when it invokes a scroll intent.
  void _registerIntent(ScrollIntent intent) {
    final String arrow = _arrowFor(intent.direction);
    final String type = _labelFor(intent.type);
    final DateTime now = DateTime.now();
    setState(() {
      _intentLog.insert(
        0,
        _IntentLogEntry(arrow: arrow, type: type, at: now),
      );
      if (_intentLog.length > 6) {
        _intentLog.removeLast();
      }
      _lastPressedKey = _keyLabelFor(intent);
      _lastPressedAt = now;
    });
    debugPrint('ScrollIntent fired: $arrow $type at ${now.toIso8601String()}');
  }

  String _arrowFor(AxisDirection d) {
    switch (d) {
      case AxisDirection.up:
        return '↑';
      case AxisDirection.down:
        return '↓';
      case AxisDirection.left:
        return '←';
      case AxisDirection.right:
        return '→';
    }
  }

  String _labelFor(ScrollIncrementType t) {
    switch (t) {
      case ScrollIncrementType.line:
        return 'line';
      case ScrollIncrementType.page:
        return 'page';
    }
  }

  String _keyLabelFor(ScrollIntent intent) {
    if (intent.type == ScrollIncrementType.page) {
      return intent.direction == AxisDirection.up ? 'PageUp' : 'PageDown';
    }
    if (intent.direction == AxisDirection.up) {
      return 'ArrowUp';
    }
    if (intent.direction == AxisDirection.down) {
      return 'ArrowDown';
    }
    if (intent.direction == AxisDirection.left) {
      return 'ArrowLeft';
    }
    return 'ArrowRight';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F3),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            // SECTION 1 — Hero header with decorative keycap.
            SliverToBoxAdapter(child: _buildHeroHeader()),
            // SECTION 2 — Primary vertical scroller with ScrollAction.
            SliverToBoxAdapter(child: _buildPrimaryScrollerSection()),
            // SECTION 3 — Horizontal arrow-key scroller.
            SliverToBoxAdapter(child: _buildHorizontalScrollerSection()),
            // SECTION 4 — Mini keyboard visualization row.
            SliverToBoxAdapter(child: _buildKeycapVisualizationRow()),
            // SECTION 5 — Live Actions table.
            SliverToBoxAdapter(child: _buildActionsTable()),
            // SECTION 6 — Inline custom ScrollAction source example.
            SliverToBoxAdapter(child: _buildCustomActionExample()),
            // SECTION 7 — Teaching panel.
            SliverToBoxAdapter(child: _buildTeachingPanel()),
            // SECTION 8 — Scenarios strip.
            SliverToBoxAdapter(child: _buildScenariosStrip()),
            // SECTION 9 — Footer.
            SliverToBoxAdapter(child: _buildFooter()),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 1 — Hero header
  // -------------------------------------------------------------------

  Widget _buildHeroHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(32, 40, 32, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF12271B),
            Color(0xFF1F3D2B),
            Color(0xFF2F5A40),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Decorative mechanical keycap drawn entirely with Containers.
          _buildHeroKeycap(),
          const SizedBox(width: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2B134).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: const Color(0xFFF2B134).withValues(alpha: 0.55),
                    ),
                  ),
                  child: const Text(
                    'flutter • actions framework',
                    style: TextStyle(
                      color: Color(0xFFF2B134),
                      fontSize: 11,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'ScrollAction & ScrollIntent',
                  style: TextStyle(
                    color: Color(0xFFCFE8D8),
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Keyboard-first scrolling through the Actions tree — '
                  'dispatch ScrollIntent via Shortcuts, let ScrollAction '
                  'drive the nearest Scrollable.',
                  style: TextStyle(
                    color: Color(0xFFD8E7DF),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: <Widget>[
                    _buildHeroStat('6', 'bound keys'),
                    const SizedBox(width: 24),
                    _buildHeroStat('2', 'scroll axes'),
                    const SizedBox(width: 24),
                    _buildHeroStat('1', 'custom action'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroKeycap() {
    // A nested Container stack that renders a chunky keycap with shadow,
    // bevel, and a printed glyph ("Pg ↓"). No decoration helpers — just
    // raw Containers with BoxShadow lists.
    return Container(
      width: 124,
      height: 132,
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F14),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x552F5A40),
            blurRadius: 40,
            offset: Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F3D2B),
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0xFFCFE8D8).withValues(alpha: 0.10),
              blurRadius: 0,
              offset: const Offset(0, -2),
            ),
            const BoxShadow(
              color: Color(0xFF0A180F),
              blurRadius: 0,
              offset: Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2F5A40),
            borderRadius: BorderRadius.circular(9),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF2F5A40), Color(0xFF234732)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Pg',
                style: TextStyle(
                  color: Color(0xFFCFE8D8),
                  fontFamily: 'monospace',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 36,
                height: 2,
                color: const Color(0xFFCFE8D8).withValues(alpha: 0.35),
              ),
              const SizedBox(height: 4),
              const Text(
                '↓',
                style: TextStyle(
                  color: Color(0xFFF2B134),
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFF2B134),
            fontSize: 26,
            fontWeight: FontWeight.w800,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFCFE8D8),
            fontSize: 11,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------
  // SECTION 2 — Primary vertical scroller with Shortcuts + Actions +
  // a custom _LoggingScrollAction that records every intent.
  // -------------------------------------------------------------------

  Widget _buildPrimaryScrollerSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 36, 32, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionHeader(
            number: '02',
            title: 'Primary keyboard scroller',
            subtitle: 'PageDown / PageUp / ArrowDown / ArrowUp / Home / End',
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: _buildVerticalScrollerCard(),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: _buildIntentHud(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalScrollerCard() {
    return Container(
      height: 420,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1F3D2B).withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.pageDown): ScrollIntent(
            direction: AxisDirection.down,
            type: ScrollIncrementType.page,
          ),
          SingleActivator(LogicalKeyboardKey.pageUp): ScrollIntent(
            direction: AxisDirection.up,
            type: ScrollIncrementType.page,
          ),
          SingleActivator(LogicalKeyboardKey.arrowDown): ScrollIntent(
            direction: AxisDirection.down,
            type: ScrollIncrementType.line,
          ),
          SingleActivator(LogicalKeyboardKey.arrowUp): ScrollIntent(
            direction: AxisDirection.up,
            type: ScrollIncrementType.line,
          ),
          SingleActivator(LogicalKeyboardKey.home): ScrollIntent(
            direction: AxisDirection.up,
            type: ScrollIncrementType.page,
          ),
          SingleActivator(LogicalKeyboardKey.end): ScrollIntent(
            direction: AxisDirection.down,
            type: ScrollIncrementType.page,
          ),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            ScrollIntent: _LoggingScrollAction(onInvoke: _registerIntent),
          },
          child: Focus(
            focusNode: _verticalFocus,
            autofocus: true,
            child: AnimatedBuilder(
              animation: _verticalFocus,
              builder: (BuildContext context, Widget? child) {
                final bool hasFocus = _verticalFocus.hasFocus;
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: hasFocus
                          ? const Color(0xFFF2B134)
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: child,
                );
              },
              child: Column(
                children: <Widget>[
                  _buildScrollerBanner(
                    title: 'Vertical tile list',
                    hint: 'Click the card, then press PgUp / PgDn / ↑ / ↓',
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _verticalController,
                      primary: false,
                      itemCount: 40,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildVerticalTile(index);
                      },
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

  Widget _buildScrollerBanner({required String title, required String hint}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Color(0xFFEFF6F1),
        border: Border(
          bottom: BorderSide(color: Color(0xFFCFE8D8), width: 1),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF2F5A40),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1F3D2B),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            hint,
            style: const TextStyle(
              color: Color(0xFF2F5A40),
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalTile(int index) {
    // Coloured tile — alternating accents so scrolling motion is visible.
    final List<Color> palette = <Color>[
      const Color(0xFF1F3D2B),
      const Color(0xFF2F5A40),
      const Color(0xFFF2B134),
      const Color(0xFFCFE8D8),
    ];
    final Color accent = palette[index % palette.length];
    final bool isLight = accent.computeLuminance() > 0.5;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.35), width: 1),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}'.padLeft(2, '0'),
              style: TextStyle(
                color: isLight
                    ? const Color(0xFF1F3D2B)
                    : const Color(0xFFCFE8D8),
                fontWeight: FontWeight.w700,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'tile-${index.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: Color(0xFF12271B),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _tileDescriptionFor(index),
                  style: const TextStyle(
                    color: Color(0xFF33493D),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: accent, size: 20),
        ],
      ),
    );
  }

  String _tileDescriptionFor(int index) {
    final List<String> phrases = <String>[
      'keyboard-driven row',
      'pressing PgDn advances one viewport',
      'ArrowDown nudges line-by-line',
      'Actions.invoke walks the tree',
      'ScrollAction resolves the controller',
      'PrimaryScrollController used when present',
      'an intent is not a method call',
      'shortcut bindings live above actions',
      'test this with a synthetic key event',
      'every tile is reachable by keyboard',
    ];
    return phrases[index % phrases.length];
  }

  Widget _buildIntentHud() {
    return Container(
      height: 420,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F14),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1F3D2B).withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2B134),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'intent log',
                style: TextStyle(
                  color: Color(0xFFCFE8D8),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              Text(
                '${_intentLog.length} / 6',
                style: const TextStyle(
                  color: Color(0xFF8FB79E),
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: const Color(0xFF2F5A40)),
          const SizedBox(height: 12),
          Expanded(
            child: _intentLog.isEmpty
                ? _buildEmptyHud()
                : ListView.builder(
                    itemCount: _intentLog.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildHudEntry(_intentLog[index], index);
                    },
                  ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1F3D2B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.bolt_rounded,
                    color: Color(0xFFF2B134), size: 14),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _lastPressedKey.isEmpty
                        ? 'awaiting keystroke'
                        : 'last: $_lastPressedKey',
                    style: const TextStyle(
                      color: Color(0xFFCFE8D8),
                      fontFamily: 'monospace',
                      fontSize: 11,
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

  Widget _buildEmptyHud() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.keyboard_alt_outlined,
            color: const Color(0xFFCFE8D8).withValues(alpha: 0.4),
            size: 38,
          ),
          const SizedBox(height: 10),
          const Text(
            'press a bound key',
            style: TextStyle(
              color: Color(0xFF8FB79E),
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'the list above captures focus',
            style: TextStyle(
              color: Color(0xFF5E7B6B),
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHudEntry(_IntentLogEntry entry, int position) {
    final double opacity = 1.0 - (position * 0.12);
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1F3D2B).withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF2F5A40),
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF2B134).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              entry.arrow,
              style: const TextStyle(
                color: Color(0xFFF2B134),
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.type,
                  style: const TextStyle(
                    color: Color(0xFFCFE8D8),
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  _formatTimestamp(entry.at),
                  style: const TextStyle(
                    color: Color(0xFF8FB79E),
                    fontFamily: 'monospace',
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime t) {
    String two(int v) => v.toString().padLeft(2, '0');
    String three(int v) => v.toString().padLeft(3, '0');
    return '${two(t.hour)}:${two(t.minute)}:${two(t.second)}.${three(t.millisecond)}';
  }

  // -------------------------------------------------------------------
  // SECTION 3 — Horizontal scroller bound to Arrow Left / Arrow Right.
  // -------------------------------------------------------------------

  Widget _buildHorizontalScrollerSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionHeader(
            number: '03',
            title: 'Horizontal scroller — arrow keys',
            subtitle:
                'ArrowLeft / ArrowRight fire ScrollIntent along the horizontal axis',
          ),
          const SizedBox(height: 20),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFF1F3D2B).withValues(alpha: 0.08),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Shortcuts(
              shortcuts: const <ShortcutActivator, Intent>{
                SingleActivator(LogicalKeyboardKey.arrowLeft): ScrollIntent(
                  direction: AxisDirection.left,
                  type: ScrollIncrementType.line,
                ),
                SingleActivator(LogicalKeyboardKey.arrowRight): ScrollIntent(
                  direction: AxisDirection.right,
                  type: ScrollIncrementType.line,
                ),
              },
              child: Actions(
                actions: <Type, Action<Intent>>{
                  ScrollIntent: _LoggingScrollAction(onInvoke: _registerIntent),
                },
                child: Focus(
                  focusNode: _horizontalFocus,
                  child: AnimatedBuilder(
                    animation: _horizontalFocus,
                    builder: (BuildContext context, Widget? child) {
                      final bool hasFocus = _horizontalFocus.hasFocus;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: hasFocus
                                ? const Color(0xFFF2B134)
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: child,
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        _buildScrollerBanner(
                          title: 'Horizontal card rail',
                          hint: 'Click first, then press ← or →',
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: _horizontalController,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: 24,
                            padding: const EdgeInsets.all(12),
                            itemBuilder: (BuildContext context, int index) {
                              return _buildHorizontalCard(index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCard(int index) {
    final List<Color> palette = <Color>[
      const Color(0xFF1F3D2B),
      const Color(0xFF2F5A40),
      const Color(0xFFF2B134),
    ];
    final Color accent = palette[index % palette.length];
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.35), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${index + 1}'.padLeft(2, '0'),
              style: const TextStyle(
                color: Color(0xFFCFE8D8),
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'card-${index.toString().padLeft(2, '0')}',
            style: const TextStyle(
              color: Color(0xFF12271B),
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'arrow key\nnavigation',
            style: TextStyle(
              color: Color(0xFF33493D),
              fontSize: 11,
              height: 1.3,
            ),
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              Icon(Icons.west_rounded, color: accent, size: 14),
              const SizedBox(width: 4),
              Icon(Icons.east_rounded, color: accent, size: 14),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 4 — Mini keyboard visualization.
  // -------------------------------------------------------------------

  Widget _buildKeycapVisualizationRow() {
    final List<_KeyCap> topRow = <_KeyCap>[
      _KeyCap(label: 'PageUp', glyph: 'PgUp', width: 78),
      _KeyCap(label: 'PageDown', glyph: 'PgDn', width: 78),
      _KeyCap(label: 'Home', glyph: 'Home', width: 70),
      _KeyCap(label: 'End', glyph: 'End', width: 70),
    ];
    final List<_KeyCap> arrowRow = <_KeyCap>[
      _KeyCap(label: 'ArrowUp', glyph: '↑', width: 56),
      _KeyCap(label: 'ArrowDown', glyph: '↓', width: 56),
      _KeyCap(label: 'ArrowLeft', glyph: '←', width: 56),
      _KeyCap(label: 'ArrowRight', glyph: '→', width: 56),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionHeader(
            number: '04',
            title: 'Keycap visualization',
            subtitle:
                'last-pressed key glows amber — pure Container art, no asset',
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 26),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1F14),
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFF1F3D2B).withValues(alpha: 0.25),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'navigation cluster',
                  style: TextStyle(
                    color: Color(0xFF8FB79E),
                    fontFamily: 'monospace',
                    fontSize: 11,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: topRow.map((_KeyCap k) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: _buildMiniKeycap(k),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),
                const Text(
                  'arrow cluster',
                  style: TextStyle(
                    color: Color(0xFF8FB79E),
                    fontFamily: 'monospace',
                    fontSize: 11,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: arrowRow.map((_KeyCap k) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: _buildMiniKeycap(k),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),
                Container(height: 1, color: const Color(0xFF1F3D2B)),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2B134),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _lastPressedKey.isEmpty
                            ? 'no key captured yet — focus a scroller and press a bound key'
                            : 'captured: $_lastPressedKey at ${_formatTimestamp(_lastPressedAt)}',
                        style: const TextStyle(
                          color: Color(0xFFCFE8D8),
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniKeycap(_KeyCap cap) {
    final bool isActive = cap.label == _lastPressedKey;
    final Duration sinceMs = DateTime.now().difference(_lastPressedAt);
    final bool glow = isActive && sinceMs.inMilliseconds < 400;
    final Color body = const Color(0xFF1F3D2B);
    final Color rim = const Color(0xFF2F5A40);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: cap.width,
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFF0A180F),
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: glow
                ? const Color(0xFFF2B134).withValues(alpha: 0.55)
                : Colors.transparent,
            blurRadius: glow ? 18 : 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: body,
          borderRadius: BorderRadius.circular(7),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0xFFCFE8D8).withValues(alpha: 0.08),
              offset: const Offset(0, -1),
            ),
            BoxShadow(
              color: glow
                  ? const Color(0xFFF2B134).withValues(alpha: 0.9)
                  : const Color(0xFF0A180F),
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: rim,
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              colors: <Color>[
                glow
                    ? const Color(0xFFF2B134).withValues(alpha: 0.35)
                    : rim,
                rim,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            cap.glyph,
            style: TextStyle(
              color: glow
                  ? const Color(0xFFF2B134)
                  : const Color(0xFFCFE8D8),
              fontFamily: 'monospace',
              fontSize: cap.glyph.length > 2 ? 13 : 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 5 — Live Actions table.
  // -------------------------------------------------------------------

  Widget _buildActionsTable() {
    final List<_ActionRow> rows = <_ActionRow>[
      _ActionRow(
        activator: 'SingleActivator(pageDown)',
        intent: 'ScrollIntent(down, page)',
      ),
      _ActionRow(
        activator: 'SingleActivator(pageUp)',
        intent: 'ScrollIntent(up, page)',
      ),
      _ActionRow(
        activator: 'SingleActivator(arrowDown)',
        intent: 'ScrollIntent(down, line)',
      ),
      _ActionRow(
        activator: 'SingleActivator(arrowUp)',
        intent: 'ScrollIntent(up, line)',
      ),
      _ActionRow(
        activator: 'SingleActivator(home)',
        intent: 'ScrollIntent(up, page)',
      ),
      _ActionRow(
        activator: 'SingleActivator(end)',
        intent: 'ScrollIntent(down, page)',
      ),
      _ActionRow(
        activator: 'SingleActivator(arrowLeft)',
        intent: 'ScrollIntent(left, line)',
      ),
      _ActionRow(
        activator: 'SingleActivator(arrowRight)',
        intent: 'ScrollIntent(right, line)',
      ),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionHeader(
            number: '05',
            title: 'Live actions table',
            subtitle: 'every activator bound above — at a glance',
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFF1F3D2B).withValues(alpha: 0.08),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFF6F1),
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFCFE8D8), width: 1),
                    ),
                  ),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          'shortcut activator',
                          style: TextStyle(
                            color: Color(0xFF1F3D2B),
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'mapped intent',
                          style: TextStyle(
                            color: Color(0xFF1F3D2B),
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...List<Widget>.generate(rows.length, (int i) {
                  final _ActionRow r = rows[i];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      color: i.isEven ? Colors.white : const Color(0xFFF9FCFA),
                      border: const Border(
                        bottom: BorderSide(
                          color: Color(0xFFE6F0EA),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            r.activator,
                            style: const TextStyle(
                              color: Color(0xFF12271B),
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            r.intent,
                            style: const TextStyle(
                              color: Color(0xFF2F5A40),
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 6 — Inline custom ScrollAction source example.
  // -------------------------------------------------------------------

  Widget _buildCustomActionExample() {
    const String source = '''
class _LoggingScrollAction extends ScrollAction {
  _LoggingScrollAction({required this.onInvoke});
  final void Function(ScrollIntent) onInvoke;

  @override
  void invoke(ScrollIntent intent, [BuildContext? context]) {
    // Instrument first, so the HUD updates even if super throws.
    onInvoke(intent);
    super.invoke(intent, context);
  }
}''';
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionHeader(
            number: '06',
            title: 'Custom ScrollAction',
            subtitle: 'subclass ScrollAction to instrument scroll dispatch',
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1F14),
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFF1F3D2B).withValues(alpha: 0.22),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(Icons.code_rounded,
                        color: Color(0xFFF2B134), size: 16),
                    SizedBox(width: 8),
                    Text(
                      'scroll_action_test.dart',
                      style: TextStyle(
                        color: Color(0xFFCFE8D8),
                        fontFamily: 'monospace',
                        fontSize: 12,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12271B),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2F5A40)),
                  ),
                  child: const Text(
                    source,
                    style: TextStyle(
                      color: Color(0xFFCFE8D8),
                      fontFamily: 'monospace',
                      fontSize: 12,
                      height: 1.45,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'This subclass is a drop-in replacement that records every '
                  'ScrollIntent before delegating to the stock behaviour. Use '
                  'the same pattern for telemetry, rate-limiting, snap-to-grid '
                  'overrides, or a tween-based alternative to the default '
                  'jump.',
                  style: TextStyle(
                    color: Color(0xFFD8E7DF),
                    fontSize: 13,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 7 — Teaching panel.
  // -------------------------------------------------------------------

  Widget _buildTeachingPanel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionHeader(
            number: '07',
            title: 'Teaching panel',
            subtitle: 'why Intents, how the Actions tree resolves, what '
                'increment types mean',
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _buildTeachingTile(
                  headline: 'ScrollIntent vs animateTo',
                  body: 'An Intent is an abstract command — it can be routed, '
                      'intercepted and tested without mocking a controller. '
                      'ScrollController.animateTo is a direct call; it '
                      'couples the caller to the specific scroll target and '
                      'leaks controller references through the widget tree.',
                  accent: const Color(0xFF1F3D2B),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTeachingTile(
                  headline: 'Actions.invoke walks the tree',
                  body: 'The Actions widget registers an Action<Intent> for a '
                      'given Intent type. When the shortcut dispatches an '
                      'intent, the framework walks from the focus node '
                      'upward, asking each Actions ancestor whether it can '
                      'handle it — the first match wins.',
                  accent: const Color(0xFF2F5A40),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _buildTeachingTile(
                  headline: 'ScrollIncrementType.line / page / …',
                  body: 'line ≈ 50 logical pixels, a sensible nudge for a '
                      'single arrow keystroke. page ≈ one viewport, the '
                      'natural unit for PgUp/PgDn. You can also drive raw '
                      'pixel scrolling by composing a custom Action — this '
                      'is what momentum-style shortcuts do.',
                  accent: const Color(0xFFF2B134),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTeachingTile(
                  headline: 'PrimaryScrollController matters',
                  body: 'ScrollAction resolves the target by first checking '
                      'a Scrollable ancestor, then falling back to the '
                      'nearest PrimaryScrollController. In typical apps the '
                      'body ListView auto-registers as primary — that is why '
                      'no explicit controller is needed inside the primary '
                      'scroller card.',
                  accent: const Color(0xFF0D1F14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeachingTile({
    required String headline,
    required String body,
    required Color accent,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6F0EA), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1F3D2B).withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  headline,
                  style: const TextStyle(
                    color: Color(0xFF12271B),
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: const TextStyle(
              color: Color(0xFF33493D),
              fontSize: 13,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 8 — Scenarios strip.
  // -------------------------------------------------------------------

  Widget _buildScenariosStrip() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionHeader(
            number: '08',
            title: 'Scenarios',
            subtitle: 'where a keyboard-first scroll layer earns its place',
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _buildScenarioCard(
                  icon: Icons.laptop_chromebook_rounded,
                  title: 'Desktop power users',
                  body: 'Long tabular views where PgUp/PgDn and Home/End are '
                      'muscle-memory. Binding them to ScrollIntent preserves '
                      'that ritual in Flutter desktop apps.',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildScenarioCard(
                  icon: Icons.accessibility_new_rounded,
                  title: 'Accessibility',
                  body: 'Users navigating with screen readers or switch '
                      'devices rely on keyboard intents. ScrollIntent lets '
                      'assistive tech trigger exactly the same path a mouse '
                      'wheel would.',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildScenarioCard(
                  icon: Icons.auto_awesome_rounded,
                  title: 'Custom gestures',
                  body: 'Map a two-finger flick or a chorded modifier to a '
                      'ScrollIntent — no new controller plumbing needed, '
                      'and the existing Actions handler does the rest.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioCard({
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1F3D2B), Color(0xFF2F5A40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1F3D2B).withValues(alpha: 0.20),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF2B134).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFF2B134), size: 22),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFCFE8D8),
              fontWeight: FontWeight.w800,
              fontSize: 16,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              color: Color(0xFFD8E7DF),
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 9 — Footer.
  // -------------------------------------------------------------------

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 40),
      child: Container(
        padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1F14),
          borderRadius: BorderRadius.circular(22),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0xFF1F3D2B).withValues(alpha: 0.22),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF2B134).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.keyboard_alt_rounded,
                  color: Color(0xFFF2B134), size: 28),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Shortcuts ▸ Actions ▸ ScrollAction',
                    style: TextStyle(
                      color: Color(0xFFCFE8D8),
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'One bound keystroke, one Intent, one Action — the entire '
                    'scroll pipeline is a tree walk. Subclass, observe, or '
                    'replace any step without touching the scrollers '
                    'themselves.',
                    style: TextStyle(
                      color: Color(0xFFD8E7DF),
                      fontSize: 12.5,
                      height: 1.55,
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

  // -------------------------------------------------------------------
  // Shared section header used by every titled section.
  // -------------------------------------------------------------------

  Widget _buildSectionHeader({
    required String number,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF1F3D2B),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Color(0xFFF2B134),
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
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
                  color: Color(0xFF12271B),
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF33493D),
                  fontSize: 13,
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

// =====================================================================
// Custom ScrollAction — logs every invocation before delegating to the
// stock behaviour. Exactly the pattern the teaching panel describes.
// =====================================================================

class _LoggingScrollAction extends ScrollAction {
  _LoggingScrollAction({required this.onInvoke});

  final void Function(ScrollIntent intent) onInvoke;

  @override
  void invoke(ScrollIntent intent, [BuildContext? context]) {
    // Record first so the HUD still updates if the super call no-ops
    // (e.g. there is no Scrollable ancestor to actually scroll).
    onInvoke(intent);
    super.invoke(intent, context);
  }
}

// =====================================================================
// Tiny value types — one per concern. Kept as plain constructors; no
// equals/hash needed because they only live in the live state.
// =====================================================================

class _IntentLogEntry {
  _IntentLogEntry({
    required this.arrow,
    required this.type,
    required this.at,
  });

  final String arrow;
  final String type;
  final DateTime at;
}

class _KeyCap {
  _KeyCap({
    required this.label,
    required this.glyph,
    required this.width,
  });

  final String label;
  final String glyph;
  final double width;
}

class _ActionRow {
  _ActionRow({required this.activator, required this.intent});

  final String activator;
  final String intent;
}
