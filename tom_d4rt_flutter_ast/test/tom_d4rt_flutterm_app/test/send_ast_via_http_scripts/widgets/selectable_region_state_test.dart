// D4rt AST deep demo: SelectableRegionState — "Selection Laboratory".
//
// This demo is deliberately hand-authored (no generator, no shared helpers)
// to exercise the d4rt AST test harness on a single self-contained Flutter
// screen. It focuses on the State object backing SelectableRegion and how
// callers interact with it programmatically via GlobalKey<SelectableRegionState>.
//
// API notes, verified against Flutter 3.41.6
// (packages/flutter/lib/src/widgets/selectable_region.dart):
//
//   * SelectableRegionState is the public State class; it mixes in
//     TextSelectionDelegate and implements SelectionRegistrar, which is
//     how child Selectables discover their host region.
//   * Public methods we drive from buttons:
//        void selectAll([SelectionChangedCause? cause])
//        void clearSelection()
//        void copySelection(SelectionChangedCause cause)
//        void cutSelection(SelectionChangedCause cause)
//     `pasteText` exists from the TextSelectionDelegate mixin but is a no-op
//     for non-editable SelectableRegion, so we omit it from the buttons.
//   * SelectableRegion's constructor requires `selectionControls` and `child`.
//     Optional: `focusNode`, `magnifierConfiguration`, `onSelectionChanged`,
//     `contextMenuBuilder`. There is NO standalone `selectionHandles` field
//     on the public SelectableRegion widget in 3.41.6 — handle rendering is
//     driven by the TextSelectionControls implementation you pass in. The
//     field-reference table below therefore documents
//     "selectionControls (drives handles + toolbar)" rather than pretending
//     a separate handles slot exists.
//   * We intentionally avoid `SelectionArea` here; the whole point of the
//     demo is to show the low-level SelectableRegion + its State.
//
// Entry point contract for the d4rt harness: a single top-level function
//     dynamic build(BuildContext context)
// returning MaterialApp(home: Scaffold(...)). No main(), no runApp().

import 'dart:math' as math;

import 'package:flutter/material.dart';

// SelectedContent lives in package:flutter/rendering.dart and is not
// re-exported by package:flutter/material.dart. This demo is restricted to
// material + dart:math, so the callback signatures below use `dynamic` and
// we pick the plain text off the runtime object via a small helper. This
// matches the way the d4rt harness sees these values anyway.

// ---------------------------------------------------------------------------
// Palette + small text helpers shared across this file only.
// ---------------------------------------------------------------------------

const Color _parchment = Color(0xFFF7EFE3);
const Color _parchmentDeep = Color(0xFFEFE2CC);
const Color _indigo = Color(0xFF3F3D56);
const Color _indigoSoft = Color(0xFF5A587A);
const Color _amber = Color(0xFFF9A826);
const Color _amberSoft = Color(0xFFFFC368);
const Color _inkDark = Color(0xFF25243A);
const Color _inkMuted = Color(0xFF6B6A82);

const String _heroTitle = 'SelectableRegionState';
const String _heroSubtitle =
    'The State object behind SelectableRegion — manages selection, handles, '
    'and toolbar controls across a subtree of Selectables.';

// The canvas prose used inside the big SelectableRegion.
const String _paraOne =
    'The humble SelectableRegion sits quietly beneath your widgets, watching '
    'pointers, clicks, and keyboards. When the user begins a drag, its State '
    'object springs awake: it updates selection handles, notifies child '
    'Selectables through the SelectionRegistrar contract, and redraws the '
    'highlight overlay across every run of text it can reach.';

const String _paraTwo =
    'Unlike SelectableText, SelectableRegion does not own a single string. '
    'It is a region — a coordinator. Children register themselves via the '
    'SelectionContainer mechanism, and the region stitches their individual '
    'selection geometries into one coherent, scrollable ribbon.';

const String _paraThree =
    'Programmatic control lives on the State class. Hold a '
    'GlobalKey<SelectableRegionState>, and you can call selectAll(), '
    'clearSelection(), and copySelection(cause) without ever touching '
    'the user\'s keyboard or mouse.';

const List<String> _bulletPoints = <String>[
  'Single source of truth for the active selection geometry.',
  'Implements SelectionRegistrar so Selectables can register.',
  'Drives the overlay that paints handles and the toolbar.',
  'Delegates handle painting to TextSelectionControls.',
  'Notifies listeners through onSelectionChanged.',
];

const String _monospaceBlock =
    'final key = GlobalKey<SelectableRegionState>();\n'
    '\n'
    'SelectableRegion(\n'
    '  key: key,\n'
    '  selectionControls: materialTextSelectionControls,\n'
    '  onSelectionChanged: (SelectedContent? c) => debugPrint(c?.plainText),\n'
    '  child: const Text(\'Drag me, or press Select All\'),\n'
    ');\n'
    '\n'
    '// Later…\n'
    'key.currentState?.selectAll(SelectionChangedCause.toolbar);\n'
    'Clipboard.setData(ClipboardData(text: lastSelectedText));\n'
    'key.currentState?.clearSelection();';

// The auto-hide demo uses two smaller prose snippets side-by-side so users can
// compare "always-visible controls" against "focus-gated / auto-hide".
const String _compareLeftProse =
    'Left region — always wired to materialTextSelectionControls with no '
    'focus node. Handles and toolbar behave per the platform default. '
    'Clearing selection is manual (button or tap outside).';

const String _compareRightProse =
    'Right region — owns an explicit FocusNode. When focus leaves the region '
    'the State auto-clears its selection in _handleFocusChanged(), giving '
    'you a crude "auto-hide" behaviour for multi-region layouts.';

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('SelectableRegionState deep demo: build() entry');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SelectableRegionState — Selection Laboratory',
    home: _SelectionLabScaffold(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold.
// ---------------------------------------------------------------------------

class _SelectionLabScaffold extends StatefulWidget {
  const _SelectionLabScaffold();

  @override
  State<_SelectionLabScaffold> createState() => _SelectionLabScaffoldState();
}

class _SelectionLabScaffoldState extends State<_SelectionLabScaffold> {
  final GlobalKey<SelectableRegionState> _canvasKey =
      GlobalKey<SelectableRegionState>();

  final GlobalKey<SelectableRegionState> _compareLeftKey =
      GlobalKey<SelectableRegionState>();

  final GlobalKey<SelectableRegionState> _compareRightKey =
      GlobalKey<SelectableRegionState>();

  final FocusNode _compareRightFocus =
      FocusNode(debugLabel: 'compareRightRegion');

  // Current selection echoed from the canvas region's onSelectionChanged.
  String _canvasSelection = '';
  int _canvasChangeCount = 0;

  // Side-by-side compare selections.
  String _compareLeftSelection = '';
  String _compareRightSelection = '';

  // Toggle for the "auto-hide" demo card: true means we keep the right-hand
  // region's focus grabbed (so selection persists), false lets it drop.
  bool _stickyRightFocus = true;

  @override
  void dispose() {
    _compareRightFocus.dispose();
    super.dispose();
  }

  void _onCanvasSelectionChanged(dynamic content) {
    setState(() {
      _canvasSelection = _plainTextOf(content);
      _canvasChangeCount += 1;
    });
  }

  void _onCompareLeftChanged(dynamic content) {
    setState(() {
      _compareLeftSelection = _plainTextOf(content);
    });
  }

  void _onCompareRightChanged(dynamic content) {
    setState(() {
      _compareRightSelection = _plainTextOf(content);
    });
  }

  void _doSelectAll() {
    debugPrint('SelectionLab: selectAll() via toolbar cause');
    _canvasKey.currentState?.selectAll(SelectionChangedCause.toolbar);
  }

  void _doClearSelection() {
    debugPrint('SelectionLab: clearSelection()');
    _canvasKey.currentState?.clearSelection();
  }

  /// Inner context captured by a Builder *inside* the canvas SelectableRegion.
  /// SelectableRegionState registers its Actions just above `widget.child`, so
  /// the outer GlobalKey's context cannot find CopySelectionTextIntent — we
  /// have to dispatch the intent from a context that lives inside the
  /// Actions scope.
  BuildContext? _canvasInnerContext;

  void _registerCanvasInnerContext(BuildContext innerContext) {
    _canvasInnerContext = innerContext;
  }

  void _doCopySelection() {
    // SelectableRegionState.copySelection is marked @deprecated in Flutter
    // 3.41.6 ("Use `contextMenuBuilder` instead."), and this demo is
    // forbidden from calling deprecated APIs. The non-deprecated path is to
    // invoke the CopySelectionTextIntent through the Actions scope the State
    // installed just above its child — which is exactly what the built-in
    // toolbar does under the hood.
    if (_canvasSelection.isEmpty) {
      debugPrint('SelectionLab: copy requested with empty selection; ignoring');
      return;
    }
    final BuildContext? inner = _canvasInnerContext;
    if (inner == null || !inner.mounted) {
      debugPrint('SelectionLab: copy deferred — inner context not yet attached');
      return;
    }
    debugPrint(
      'SelectionLab: Actions.maybeInvoke(CopySelectionTextIntent) on '
      '${_canvasSelection.length} chars',
    );
    Actions.maybeInvoke<CopySelectionTextIntent>(
      inner,
      CopySelectionTextIntent.copy,
    );
  }

  void _doCompareLeftSelectAll() {
    _compareLeftKey.currentState?.selectAll(SelectionChangedCause.toolbar);
  }

  void _doCompareRightSelectAll() {
    _compareRightFocus.requestFocus();
    _compareRightKey.currentState?.selectAll(SelectionChangedCause.toolbar);
  }

  void _doCompareLeftClear() {
    _compareLeftKey.currentState?.clearSelection();
  }

  void _doCompareRightClear() {
    _compareRightKey.currentState?.clearSelection();
  }

  void _toggleStickyFocus(bool value) {
    setState(() {
      _stickyRightFocus = value;
      if (value) {
        _compareRightFocus.requestFocus();
      } else {
        _compareRightFocus.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _parchment,
      appBar: AppBar(
        backgroundColor: _indigo,
        foregroundColor: _parchment,
        elevation: 0,
        title: const Text(
          'SelectableRegionState — Selection Laboratory',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: _IndigoAmberBar(),
        ),
      ),
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _CaratHeroCard(),
                  const SizedBox(height: 18),
                  _SelectionCanvasCard(
                    canvasKey: _canvasKey,
                    onSelectionChanged: _onCanvasSelectionChanged,
                    liveSelection: _canvasSelection,
                    liveChangeCount: _canvasChangeCount,
                    onInnerContext: _registerCanvasInnerContext,
                  ),
                  const SizedBox(height: 18),
                  _SelectionInspectorPanel(
                    liveSelection: _canvasSelection,
                    liveChangeCount: _canvasChangeCount,
                  ),
                  const SizedBox(height: 18),
                  _ProgrammaticControlsCard(
                    onSelectAll: _doSelectAll,
                    onClear: _doClearSelection,
                    onCopy: _doCopySelection,
                    selectionPreview: _canvasSelection,
                  ),
                  const SizedBox(height: 18),
                  _AutoHideDemo(
                    compareLeftKey: _compareLeftKey,
                    compareRightKey: _compareRightKey,
                    compareRightFocus: _compareRightFocus,
                    compareLeftSelection: _compareLeftSelection,
                    compareRightSelection: _compareRightSelection,
                    onCompareLeftChanged: _onCompareLeftChanged,
                    onCompareRightChanged: _onCompareRightChanged,
                    onCompareLeftSelectAll: _doCompareLeftSelectAll,
                    onCompareRightSelectAll: _doCompareRightSelectAll,
                    onCompareLeftClear: _doCompareLeftClear,
                    onCompareRightClear: _doCompareRightClear,
                    stickyRightFocus: _stickyRightFocus,
                    onStickyToggled: _toggleStickyFocus,
                  ),
                  const SizedBox(height: 18),
                  const _FieldReferenceTableCard(),
                  const SizedBox(height: 18),
                  const _InstructionalPanelsCard(),
                  const SizedBox(height: 18),
                  const _FooterSignature(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Thin amber/indigo stripe under the AppBar.
// ---------------------------------------------------------------------------

class _IndigoAmberBar extends StatelessWidget {
  const _IndigoAmberBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_indigo, _indigoSoft, _amberSoft, _amber],
          stops: <double>[0.0, 0.55, 0.8, 1.0],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero card — large painted "selection carat".
// ---------------------------------------------------------------------------

class _CaratHeroCard extends StatefulWidget {
  const _CaratHeroCard();

  @override
  State<_CaratHeroCard> createState() => _CaratHeroCardState();
}

class _CaratHeroCardState extends State<_CaratHeroCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Hero — SelectableRegionState',
      subtitle: _heroSubtitle,
      child: SizedBox(
        height: 260,
        child: AnimatedBuilder(
          animation: _blinkController,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              painter: _CaratHeroPainter(
                blink: _blinkController.value,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _heroTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      height: 1.1,
                      fontWeight: FontWeight.w700,
                      color: _parchment,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CaratHeroPainter extends CustomPainter {
  _CaratHeroPainter({required this.blink});

  final double blink; // 0..1, used for amber cursor opacity.

  @override
  void paint(Canvas canvas, Size size) {
    // Deep indigo background with subtle vignette.
    final Rect rect = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_indigo, _indigoSoft],
      ).createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(16)),
      bg,
    );

    // Draw a soft starfield of little amber dots to suggest a "selection
    // universe" behind the carat.
    final math.Random rng = math.Random(1312);
    final Paint dotPaint = Paint()
      ..color = _amberSoft.withValues(alpha: 0.18);
    for (int i = 0; i < 40; i++) {
      final double dx = rng.nextDouble() * size.width;
      final double dy = rng.nextDouble() * size.height;
      final double r = rng.nextDouble() * 1.6 + 0.6;
      canvas.drawCircle(Offset(dx, dy), r, dotPaint);
    }

    // Indigo highlight bar — representing the "selected text ribbon".
    final double barHeight = 46;
    final double barY = size.height * 0.68;
    final double barPadding = 38;
    final RRect bar = RRect.fromLTRBR(
      barPadding,
      barY - barHeight / 2,
      size.width - barPadding,
      barY + barHeight / 2,
      const Radius.circular(10),
    );
    final Paint barPaint = Paint()
      ..color = _parchment.withValues(alpha: 0.18);
    canvas.drawRRect(bar, barPaint);

    // Inner highlight strip to imitate selected background.
    final RRect innerBar = RRect.fromLTRBR(
      barPadding + 4,
      barY - barHeight / 2 + 4,
      size.width - barPadding - 4,
      barY + barHeight / 2 - 4,
      const Radius.circular(7),
    );
    final Paint innerPaint = Paint()
      ..color = _amber.withValues(alpha: 0.28);
    canvas.drawRRect(innerBar, innerPaint);

    // Blinking amber cursor at the right end of the bar.
    final double cursorX = size.width - barPadding - 10;
    final Paint cursorPaint = Paint()
      ..color = _amber.withValues(alpha: 0.15 + 0.85 * blink)
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(cursorX, barY - barHeight / 2 + 8),
      Offset(cursorX, barY + barHeight / 2 - 8),
      cursorPaint,
    );

    // Draw the two "handles" — small triangles — at each end of the bar.
    final Paint handlePaint = Paint()..color = _amber;
    _drawHandle(
      canvas,
      handlePaint,
      Offset(barPadding, barY + barHeight / 2),
      pointsLeft: true,
    );
    _drawHandle(
      canvas,
      handlePaint,
      Offset(size.width - barPadding, barY + barHeight / 2),
      pointsLeft: false,
    );

    // A tiny caption below the bar to tell the reader what they are looking at.
    const TextStyle captionStyle = TextStyle(
      fontSize: 12,
      color: _parchment,
      letterSpacing: 0.6,
      fontWeight: FontWeight.w500,
    );
    final TextPainter caption = TextPainter(
      text: const TextSpan(
        text: 'selection geometry  —  handles  —  toolbar anchor',
        style: captionStyle,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - barPadding * 2);
    caption.paint(
      canvas,
      Offset(
        (size.width - caption.width) / 2,
        barY + barHeight / 2 + 14,
      ),
    );
  }

  void _drawHandle(
    Canvas canvas,
    Paint paint,
    Offset tip, {
    required bool pointsLeft,
  }) {
    const double size = 14;
    final Path path = Path();
    if (pointsLeft) {
      path
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(tip.dx - size, tip.dy + size)
        ..lineTo(tip.dx, tip.dy + size)
        ..close();
    } else {
      path
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(tip.dx + size, tip.dy + size)
        ..lineTo(tip.dx, tip.dy + size)
        ..close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CaratHeroPainter oldDelegate) =>
      oldDelegate.blink != blink;
}

// ---------------------------------------------------------------------------
// Card 2 — the big selection canvas wrapping rich prose.
// ---------------------------------------------------------------------------

class _SelectionCanvasCard extends StatelessWidget {
  const _SelectionCanvasCard({
    required this.canvasKey,
    required this.onSelectionChanged,
    required this.liveSelection,
    required this.liveChangeCount,
    required this.onInnerContext,
  });

  final GlobalKey<SelectableRegionState> canvasKey;
  final ValueChanged<dynamic> onSelectionChanged;
  final String liveSelection;
  final int liveChangeCount;
  final ValueChanged<BuildContext> onInnerContext;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Canvas — one SelectableRegion, many Selectables',
      subtitle: 'Drag across headings, paragraphs, the list, or the code '
          'block. Selection is stitched across all descendants. Buttons below '
          'call into SelectableRegionState directly.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: _parchmentDeep,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _indigo.withValues(alpha: 0.14)),
            ),
            padding: const EdgeInsets.all(18),
            child: SelectableRegion(
              key: canvasKey,
              selectionControls: materialTextSelectionControls,
              onSelectionChanged: onSelectionChanged,
              contextMenuBuilder: _buildCanvasContextMenu,
              child: Builder(
                builder: (BuildContext innerContext) {
                  // Capture an inner context that lives *inside* the Actions
                  // scope installed by SelectableRegionState, so external
                  // buttons can dispatch CopySelectionTextIntent through it.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (innerContext.mounted) {
                      onInnerContext(innerContext);
                    }
                  });
                  return const _CanvasProse();
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          _LiveBadge(
            liveSelection: liveSelection,
            liveChangeCount: liveChangeCount,
          ),
        ],
      ),
    );
  }

  Widget _buildCanvasContextMenu(
    BuildContext context,
    SelectableRegionState state,
  ) {
    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: state.contextMenuAnchors,
      buttonItems: state.contextMenuButtonItems,
    );
  }
}

class _CanvasProse extends StatelessWidget {
  const _CanvasProse();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Drag to select, or use the buttons below.',
          style: TextStyle(
            fontSize: 13,
            color: _inkMuted,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'The SelectableRegion contract',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: _indigo,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          _paraOne,
          style: TextStyle(
            fontSize: 15,
            height: 1.45,
            color: _inkDark,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Why it is a region',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _indigo,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          _paraTwo,
          style: TextStyle(
            fontSize: 15,
            height: 1.45,
            color: _inkDark,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Programmatic control',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _indigo,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          _paraThree,
          style: TextStyle(
            fontSize: 15,
            height: 1.45,
            color: _inkDark,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Responsibilities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _indigo,
          ),
        ),
        const SizedBox(height: 6),
        ..._bulletPoints.map(
          (String b) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 6, right: 10),
                  child: Icon(Icons.circle, size: 7, color: _amber),
                ),
                Expanded(
                  child: Text(
                    b,
                    style: const TextStyle(
                      fontSize: 14.5,
                      height: 1.4,
                      color: _inkDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Minimal usage snippet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _indigo,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _indigo,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _amber.withValues(alpha: 0.45)),
          ),
          child: const Text(
            _monospaceBlock,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.4,
              color: _parchment,
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Image placeholder Container — represents how SelectableRegion
        // surrounds non-text content gracefully.
        Row(
          children: <Widget>[
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: _amberSoft.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _indigo.withValues(alpha: 0.25)),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.image_outlined,
                size: 42,
                color: _indigo,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Text(
                'Non-selectable placeholders (Containers, images) are '
                'skipped gracefully by the registrar: the region only '
                'attempts to select Selectable children it has discovered.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: _inkDark,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge({
    required this.liveSelection,
    required this.liveChangeCount,
  });

  final String liveSelection;
  final int liveChangeCount;

  @override
  Widget build(BuildContext context) {
    final String preview = liveSelection.isEmpty
        ? '(no active selection)'
        : _truncate(liveSelection, 80);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _indigo.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _indigo.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.notifications_active,
              size: 18, color: _indigo),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'onSelectionChanged fired $liveChangeCount times · "$preview"',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: _indigo,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _truncate(String text, int max) {
  if (text.length <= max) return text;
  return '${text.substring(0, max - 1)}…';
}

/// Pulls the `.plainText` property off a runtime SelectedContent without
/// importing the rendering library (forbidden by this demo's import budget).
String _plainTextOf(dynamic content) {
  if (content == null) return '';
  try {
    final dynamic text = content.plainText;
    if (text is String) return text;
  } catch (_) {
    // Fall through: unknown runtime shape, treat as empty.
  }
  return '';
}

// ---------------------------------------------------------------------------
// Card 3 — Live Selection Inspector (sidebar-like panel).
// ---------------------------------------------------------------------------

class _SelectionInspectorPanel extends StatelessWidget {
  const _SelectionInspectorPanel({
    required this.liveSelection,
    required this.liveChangeCount,
  });

  final String liveSelection;
  final int liveChangeCount;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Live Selection Inspector',
      subtitle:
          'A simulated inspector panel: excerpt, character count, and a '
          'painted bounding box that grows with the selection length.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: _InspectorStatsColumn(
              liveSelection: liveSelection,
              liveChangeCount: liveChangeCount,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 200,
              child: CustomPaint(
                painter: _SelectionRectOverlayPainter(
                  selectionLength: liveSelection.length,
                  changeCount: liveChangeCount,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InspectorStatsColumn extends StatelessWidget {
  const _InspectorStatsColumn({
    required this.liveSelection,
    required this.liveChangeCount,
  });

  final String liveSelection;
  final int liveChangeCount;

  @override
  Widget build(BuildContext context) {
    final int wordCount = _countWords(liveSelection);
    final int lineCount = liveSelection.isEmpty
        ? 0
        : liveSelection.split('\n').length;
    final String excerpt = liveSelection.isEmpty
        ? '— empty —'
        : _truncate(liveSelection, 160);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Excerpt',
          style: TextStyle(
            fontSize: 12,
            color: _inkMuted,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _parchmentDeep,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _indigo.withValues(alpha: 0.18)),
          ),
          child: Text(
            excerpt,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.4,
              color: _inkDark,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _StatRow(label: 'Characters', value: liveSelection.length.toString()),
        _StatRow(label: 'Words', value: wordCount.toString()),
        _StatRow(label: 'Lines', value: lineCount.toString()),
        _StatRow(
          label: 'Change events',
          value: liveChangeCount.toString(),
        ),
      ],
    );
  }

  int _countWords(String s) {
    if (s.trim().isEmpty) return 0;
    return s
        .trim()
        .split(RegExp(r'\s+'))
        .where((String w) => w.isNotEmpty)
        .length;
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: _inkMuted,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _amber.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _indigo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionRectOverlayPainter extends CustomPainter {
  _SelectionRectOverlayPainter({
    required this.selectionLength,
    required this.changeCount,
  });

  final int selectionLength;
  final int changeCount;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect full = Offset.zero & size;
    final Paint bg = Paint()
      ..color = _parchmentDeep;
    canvas.drawRRect(
      RRect.fromRectAndRadius(full, const Radius.circular(10)),
      bg,
    );

    // Dashed frame to suggest "viewport".
    final Paint frame = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _indigo.withValues(alpha: 0.3);
    _drawDashedRRect(
      canvas,
      RRect.fromRectAndRadius(
        full.deflate(4),
        const Radius.circular(8),
      ),
      frame,
    );

    if (selectionLength == 0) {
      const TextStyle style = TextStyle(
        color: _inkMuted,
        fontSize: 13,
        fontStyle: FontStyle.italic,
      );
      final TextPainter tp = TextPainter(
        text: const TextSpan(
          text: 'waiting for a selection…',
          style: style,
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(
          (size.width - tp.width) / 2,
          (size.height - tp.height) / 2,
        ),
      );
      return;
    }

    // Clamp selection length into a 0..1 scale; 600 chars considered "full".
    final double t = math.min(1.0, selectionLength / 600.0);
    final double boxWidth = 40 + (size.width - 56) * t;
    final double boxHeight = 24 + (size.height - 80) * t;
    final double bx = (size.width - boxWidth) / 2;
    final double by = (size.height - boxHeight) / 2 - 8;
    final RRect box = RRect.fromLTRBR(
      bx,
      by,
      bx + boxWidth,
      by + boxHeight,
      const Radius.circular(8),
    );
    final Paint boxPaint = Paint()
      ..color = _amber.withValues(alpha: 0.35);
    final Paint boxStroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = _amber
      ..strokeWidth = 2.2;
    canvas.drawRRect(box, boxPaint);
    canvas.drawRRect(box, boxStroke);

    // Show the numeric change count near the bottom-right.
    final TextPainter label = TextPainter(
      text: TextSpan(
        text: 'Δ $changeCount',
        style: const TextStyle(
          color: _indigo,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    label.paint(
      canvas,
      Offset(size.width - label.width - 12, size.height - label.height - 10),
    );
  }

  void _drawDashedRRect(Canvas canvas, RRect rrect, Paint paint) {
    // Note: PathMetric would let us extract segments of a curved path, but it
    // lives in dart:ui which this file intentionally does not import. We
    // approximate dashes by drawing short line segments along the straight
    // edges of the rounded rectangle — the corners are drawn solid, which
    // reads fine at this size.
    const double dashWidth = 6;
    const double dashGap = 4;
    final double left = rrect.left;
    final double top = rrect.top;
    final double right = rrect.right;
    final double bottom = rrect.bottom;
    final double r = rrect.tlRadiusX;

    // Top edge (between rounded corners).
    _dashLine(
      canvas,
      paint,
      Offset(left + r, top),
      Offset(right - r, top),
      dashWidth,
      dashGap,
    );
    // Bottom edge.
    _dashLine(
      canvas,
      paint,
      Offset(left + r, bottom),
      Offset(right - r, bottom),
      dashWidth,
      dashGap,
    );
    // Left edge.
    _dashLine(
      canvas,
      paint,
      Offset(left, top + r),
      Offset(left, bottom - r),
      dashWidth,
      dashGap,
    );
    // Right edge.
    _dashLine(
      canvas,
      paint,
      Offset(right, top + r),
      Offset(right, bottom - r),
      dashWidth,
      dashGap,
    );

    // Draw the four corner arcs solid so the frame still looks continuous.
    final Path corners = Path()
      ..addArc(
        Rect.fromLTWH(left, top, r * 2, r * 2),
        math.pi,
        math.pi / 2,
      )
      ..addArc(
        Rect.fromLTWH(right - r * 2, top, r * 2, r * 2),
        -math.pi / 2,
        math.pi / 2,
      )
      ..addArc(
        Rect.fromLTWH(right - r * 2, bottom - r * 2, r * 2, r * 2),
        0,
        math.pi / 2,
      )
      ..addArc(
        Rect.fromLTWH(left, bottom - r * 2, r * 2, r * 2),
        math.pi / 2,
        math.pi / 2,
      );
    canvas.drawPath(corners, paint);
  }

  void _dashLine(
    Canvas canvas,
    Paint paint,
    Offset start,
    Offset end,
    double dashWidth,
    double dashGap,
  ) {
    final double dx = end.dx - start.dx;
    final double dy = end.dy - start.dy;
    final double length = math.sqrt(dx * dx + dy * dy);
    if (length <= 0) return;
    final double nx = dx / length;
    final double ny = dy / length;
    double travelled = 0;
    while (travelled < length) {
      final double next = math.min(travelled + dashWidth, length);
      canvas.drawLine(
        Offset(start.dx + nx * travelled, start.dy + ny * travelled),
        Offset(start.dx + nx * next, start.dy + ny * next),
        paint,
      );
      travelled = next + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _SelectionRectOverlayPainter oldDelegate) {
    return oldDelegate.selectionLength != selectionLength ||
        oldDelegate.changeCount != changeCount;
  }
}

// ---------------------------------------------------------------------------
// Card 4 — programmatic control buttons driving SelectableRegionState.
// ---------------------------------------------------------------------------

class _ProgrammaticControlsCard extends StatelessWidget {
  const _ProgrammaticControlsCard({
    required this.onSelectAll,
    required this.onClear,
    required this.onCopy,
    required this.selectionPreview,
  });

  final VoidCallback onSelectAll;
  final VoidCallback onClear;
  final VoidCallback onCopy;
  final String selectionPreview;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Programmatic controls',
      subtitle:
          'Each button reaches into the SelectableRegionState via '
          'GlobalKey.currentState and invokes its public API directly.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              _LabBigButton(
                icon: Icons.select_all,
                label: 'Select All',
                hint: 'selectAll(SelectionChangedCause.toolbar)',
                onPressed: onSelectAll,
                primary: true,
              ),
              _LabBigButton(
                icon: Icons.clear_all,
                label: 'Clear Selection',
                hint: 'clearSelection()',
                onPressed: onClear,
                primary: false,
              ),
              _LabBigButton(
                icon: Icons.copy_all,
                label: 'Copy Selection',
                hint: 'Clipboard.setData(selection)  // not deprecated',
                onPressed: onCopy,
                primary: false,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _parchmentDeep,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _indigo.withValues(alpha: 0.18)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.content_paste_search,
                    size: 20, color: _indigo),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    selectionPreview.isEmpty
                        ? 'No selection yet. Drag in the canvas above, or tap "Select All".'
                        : 'Current selection (truncated): "${_truncate(selectionPreview, 220)}"',
                    style: const TextStyle(
                      fontSize: 13.5,
                      height: 1.4,
                      color: _inkDark,
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

class _LabBigButton extends StatelessWidget {
  const _LabBigButton({
    required this.icon,
    required this.label,
    required this.hint,
    required this.onPressed,
    required this.primary,
  });

  final IconData icon;
  final String label;
  final String hint;
  final VoidCallback onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final Color background = primary ? _indigo : _parchmentDeep;
    final Color foreground = primary ? _parchment : _indigo;
    final Color hintColor = primary
        ? _parchment.withValues(alpha: 0.8)
        : _inkMuted;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: primary ? _amber : _indigo.withValues(alpha: 0.35),
            width: primary ? 1.4 : 1.0,
          ),
        ),
        elevation: primary ? 2 : 0,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                hint,
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: hintColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Card 5 — auto-hide / focus-gated compare.
// ---------------------------------------------------------------------------

class _AutoHideDemo extends StatelessWidget {
  const _AutoHideDemo({
    required this.compareLeftKey,
    required this.compareRightKey,
    required this.compareRightFocus,
    required this.compareLeftSelection,
    required this.compareRightSelection,
    required this.onCompareLeftChanged,
    required this.onCompareRightChanged,
    required this.onCompareLeftSelectAll,
    required this.onCompareRightSelectAll,
    required this.onCompareLeftClear,
    required this.onCompareRightClear,
    required this.stickyRightFocus,
    required this.onStickyToggled,
  });

  final GlobalKey<SelectableRegionState> compareLeftKey;
  final GlobalKey<SelectableRegionState> compareRightKey;
  final FocusNode compareRightFocus;
  final String compareLeftSelection;
  final String compareRightSelection;
  final ValueChanged<dynamic> onCompareLeftChanged;
  final ValueChanged<dynamic> onCompareRightChanged;
  final VoidCallback onCompareLeftSelectAll;
  final VoidCallback onCompareRightSelectAll;
  final VoidCallback onCompareLeftClear;
  final VoidCallback onCompareRightClear;
  final bool stickyRightFocus;
  final ValueChanged<bool> onStickyToggled;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Auto-hide vs always-on controls',
      subtitle:
          'Two SelectableRegions side-by-side. The right one owns its own '
          'FocusNode; toggle the switch to "sticky" focus on or off to see '
          'how the State auto-clears selection on focus loss.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.visibility, size: 18, color: _indigo),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Keep right-hand region focused (retain selection)',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: _inkDark,
                  ),
                ),
              ),
              Switch(
                value: stickyRightFocus,
                onChanged: onStickyToggled,
                activeThumbColor: _amber,
                activeTrackColor: _amberSoft,
                inactiveThumbColor: _indigoSoft,
                inactiveTrackColor: _indigo.withValues(alpha: 0.24),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool stacked = constraints.maxWidth < 640;
              final List<Widget> children = <Widget>[
                Expanded(
                  flex: stacked ? 0 : 1,
                  child: _CompareRegion(
                    title: 'Always-on controls',
                    tagline: 'materialTextSelectionControls, no focus node',
                    prose: _compareLeftProse,
                    regionKey: compareLeftKey,
                    onSelectionChanged: onCompareLeftChanged,
                    liveSelection: compareLeftSelection,
                    accent: _indigo,
                    onSelectAll: onCompareLeftSelectAll,
                    onClear: onCompareLeftClear,
                  ),
                ),
                SizedBox(width: stacked ? 0 : 14, height: stacked ? 14 : 0),
                Expanded(
                  flex: stacked ? 0 : 1,
                  child: _CompareRegion(
                    title: 'Focus-gated / auto-hide',
                    tagline:
                        'owns FocusNode — clears on blur, configurable via Switch',
                    prose: _compareRightProse,
                    regionKey: compareRightKey,
                    onSelectionChanged: onCompareRightChanged,
                    liveSelection: compareRightSelection,
                    accent: _amber,
                    focusNode: compareRightFocus,
                    onSelectAll: onCompareRightSelectAll,
                    onClear: onCompareRightClear,
                  ),
                ),
              ];
              if (stacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children
                      .map<Widget>(
                        (Widget w) => w is Expanded ? w.child : w,
                      )
                      .toList(),
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CompareRegion extends StatelessWidget {
  const _CompareRegion({
    required this.title,
    required this.tagline,
    required this.prose,
    required this.regionKey,
    required this.onSelectionChanged,
    required this.liveSelection,
    required this.accent,
    required this.onSelectAll,
    required this.onClear,
    this.focusNode,
  });

  final String title;
  final String tagline;
  final String prose;
  final GlobalKey<SelectableRegionState> regionKey;
  final ValueChanged<dynamic> onSelectionChanged;
  final String liveSelection;
  final Color accent;
  final VoidCallback onSelectAll;
  final VoidCallback onClear;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _parchmentDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _indigo,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            tagline,
            style: const TextStyle(
              fontSize: 11.5,
              color: _inkMuted,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 10),
          SelectableRegion(
            key: regionKey,
            focusNode: focusNode,
            selectionControls: materialTextSelectionControls,
            onSelectionChanged: onSelectionChanged,
            child: Text(
              prose,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.45,
                color: _inkDark,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: _indigo,
                  side: BorderSide(color: accent),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                ),
                onPressed: onSelectAll,
                icon: const Icon(Icons.select_all, size: 16),
                label: const Text('selectAll()',
                    style: TextStyle(fontSize: 12)),
              ),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: _indigo,
                  side: BorderSide(color: accent.withValues(alpha: 0.55)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                ),
                onPressed: onClear,
                icon: const Icon(Icons.clear, size: 16),
                label: const Text('clearSelection()',
                    style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              liveSelection.isEmpty
                  ? 'live: (empty)'
                  : 'live: "${_truncate(liveSelection, 60)}"',
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                color: _inkDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Card 6 — field reference table.
// ---------------------------------------------------------------------------

class _FieldReferenceTableCard extends StatelessWidget {
  const _FieldReferenceTableCard();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      title: 'SelectableRegion / SelectableRegionState field reference',
      subtitle:
          'Public surface visible to consumers — values marked (State) live '
          'on the State object and are reached via GlobalKey.currentState.',
      child: _ApiTable(),
    );
  }
}

class _ApiTable extends StatelessWidget {
  const _ApiTable();

  @override
  Widget build(BuildContext context) {
    final List<_ApiRow> rows = <_ApiRow>[
      _ApiRow(
        name: 'focusNode',
        type: 'FocusNode?',
        location: 'widget',
        notes:
            'Optional external focus. When null, the State lazily creates a '
            'FocusNode(debugLabel: "SelectableRegion").',
      ),
      _ApiRow(
        name: 'selectionControls',
        type: 'TextSelectionControls',
        location: 'widget (required)',
        notes:
            'Drives both handles and toolbar UI. There is no separate '
            '"selectionHandles" property in 3.41.6 — handle rendering is '
            'the controls object\'s responsibility.',
      ),
      _ApiRow(
        name: 'magnifierConfiguration',
        type: 'TextMagnifierConfiguration',
        location: 'widget',
        notes:
            'Defaults to disabled. Pass TextMagnifierConfiguration.disabled '
            'or a custom one to enable the mobile magnifier.',
      ),
      _ApiRow(
        name: 'onSelectionChanged',
        type: 'ValueChanged<SelectedContent?>?',
        location: 'widget',
        notes:
            'Fires whenever the State\'s geometry changes. Passes a '
            'SelectedContent with .plainText or null when empty.',
      ),
      _ApiRow(
        name: 'contextMenuBuilder',
        type: 'SelectableRegionContextMenuBuilder?',
        location: 'widget',
        notes:
            'Builds the context menu from the State\'s contextMenuAnchors '
            'and contextMenuButtonItems.',
      ),
      _ApiRow(
        name: 'selectAll(cause)',
        type: 'void (State)',
        location: 'SelectableRegionState',
        notes:
            'Selects every registered Selectable in the region. Pass '
            'SelectionChangedCause.toolbar or .keyboard for parity with the '
            'built-in toolbar.',
      ),
      _ApiRow(
        name: 'clearSelection()',
        type: 'void (State)',
        location: 'SelectableRegionState',
        notes:
            'Collapses the selection, tears down the overlay, and notifies '
            'listeners with an empty SelectedContent.',
      ),
      _ApiRow(
        name: 'copySelection(cause)',
        type: 'void (State, deprecated)',
        location: 'SelectableRegionState',
        notes:
            'Inherited from TextSelectionDelegate. Deprecated in 3.41.6 in '
            'favour of contextMenuBuilder; for programmatic copy prefer '
            'Clipboard.setData with the plainText from onSelectionChanged.',
      ),
      _ApiRow(
        name: 'contextMenuAnchors',
        type: 'TextSelectionToolbarAnchors (State)',
        location: 'SelectableRegionState',
        notes:
            'Anchors you pass to AdaptiveTextSelectionToolbar inside a '
            'contextMenuBuilder.',
      ),
      _ApiRow(
        name: 'contextMenuButtonItems',
        type: 'List<ContextMenuButtonItem> (State)',
        location: 'SelectableRegionState',
        notes:
            'Default Copy / Select All / Share buttons tailored to the '
            'current SelectionGeometry.',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _indigo.withValues(alpha: 0.2)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          const _ApiTableHeader(),
          for (int i = 0; i < rows.length; i++)
            _ApiTableRow(row: rows[i], striped: i.isOdd),
        ],
      ),
    );
  }
}

class _ApiRow {
  const _ApiRow({
    required this.name,
    required this.type,
    required this.location,
    required this.notes,
  });

  final String name;
  final String type;
  final String location;
  final String notes;
}

class _ApiTableHeader extends StatelessWidget {
  const _ApiTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _indigo,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: const Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Name',
              style: TextStyle(
                color: _parchment,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Type',
              style: TextStyle(
                color: _parchment,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Where',
              style: TextStyle(
                color: _parchment,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              'Notes',
              style: TextStyle(
                color: _parchment,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiTableRow extends StatelessWidget {
  const _ApiTableRow({required this.row, required this.striped});

  final _ApiRow row;
  final bool striped;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: striped ? _parchmentDeep : _parchment,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              row.name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: _indigo,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _inkDark,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.location,
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: _inkMuted,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              row.notes,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.35,
                color: _inkDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Card 7 — instructional panels (when to use / vs SelectableText / gotchas).
// ---------------------------------------------------------------------------

class _InstructionalPanelsCard extends StatelessWidget {
  const _InstructionalPanelsCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Field notes',
      subtitle:
          'Opinionated guidance gathered from the SelectableRegion source '
          'and common app patterns.',
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool narrow = constraints.maxWidth < 720;
          const List<_InstructionalPanel> panels = <_InstructionalPanel>[
            _InstructionalPanel(
              icon: Icons.check_circle_outline,
              title: 'When to use',
              accent: _indigo,
              bullets: <String>[
                'You need selection across multiple Text / RichText widgets.',
                'You want fine-grained control over selection controls and '
                    'the context menu.',
                'You need a stable handle on the State object to drive '
                    'selection from outside the tree.',
                'You want to listen to onSelectionChanged for live UI.',
              ],
            ),
            _InstructionalPanel(
              icon: Icons.compare_arrows,
              title: 'vs SelectableText',
              accent: _amber,
              bullets: <String>[
                'SelectableText owns a single String and its own '
                    'TextEditingController — no multi-widget selection.',
                'SelectableRegion is a region over arbitrary Selectables '
                    'discovered through SelectionContainer.',
                'For a single paragraph with a toolbar, SelectableText is '
                    'simpler; reach for SelectableRegion when you want '
                    'cross-widget stitched selection.',
              ],
            ),
            _InstructionalPanel(
              icon: Icons.warning_amber_rounded,
              title: 'Gotchas',
              accent: _indigoSoft,
              bullets: <String>[
                'Must sit inside a Directionality (MaterialApp provides one).',
                'A SelectableRegion is not inherited: if you wrap a subtree '
                    'inside another SelectionArea, selection may be handled '
                    'by the nearest ancestor instead.',
                'clearSelection() is called implicitly on focus loss while '
                    'the app is resumed — if selection keeps vanishing, '
                    'audit your FocusNode lifecycle.',
                'Non-text children (Container, Image) are silently ignored '
                    'by the selection engine; do not rely on them being '
                    'part of the copied plain text.',
              ],
            ),
          ];

          if (narrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: panels
                  .map<Widget>(
                    (_InstructionalPanel p) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _InstructionalPanelView(panel: p),
                    ),
                  )
                  .toList(),
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < panels.length; i++) ...<Widget>[
                Expanded(child: _InstructionalPanelView(panel: panels[i])),
                if (i != panels.length - 1) const SizedBox(width: 14),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _InstructionalPanel {
  const _InstructionalPanel({
    required this.icon,
    required this.title,
    required this.accent,
    required this.bullets,
  });

  final IconData icon;
  final String title;
  final Color accent;
  final List<String> bullets;
}

class _InstructionalPanelView extends StatelessWidget {
  const _InstructionalPanelView({required this.panel});

  final _InstructionalPanel panel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _parchmentDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: panel.accent.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: panel.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(panel.icon, color: panel.accent, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  panel.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _indigo,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...panel.bullets.map(
            (String b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6, right: 8),
                    child: Icon(
                      Icons.fiber_manual_record,
                      size: 7,
                      color: panel.accent,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: _inkDark,
                      ),
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

// ---------------------------------------------------------------------------
// Footer.
// ---------------------------------------------------------------------------

class _FooterSignature extends StatelessWidget {
  const _FooterSignature();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _indigo,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: _amber,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Selection Laboratory — hand-authored d4rt AST demo for '
              'SelectableRegionState.',
              style: TextStyle(
                color: _parchment,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
          const Icon(Icons.architecture, color: _amber, size: 20),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared section card used by every top-level section above.
// ---------------------------------------------------------------------------

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: _parchment,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: _indigo.withValues(alpha: 0.18)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 6,
                  height: 22,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[_indigo, _amber],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _indigo,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: _inkMuted,
              ),
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}
