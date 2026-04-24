// Deep visual demo for the Flutter framework class `UndoHistoryState<T>`.
//
// `UndoHistoryState<T>` is the `State` class of `UndoHistory<T>`, a stateful
// widget declared in `package:flutter/src/widgets/undo_history.dart`. It is
// marked `@visibleForTesting` because most consumers interact with it only
// through an `UndoHistoryController`: the widget observes a `ValueNotifier<T>`,
// throttles pushes onto an internal `_UndoStack<T>`, and exposes `undo()`,
// `redo()`, `canUndo` and `canRedo` on the controller.
//
// This file is a d4rt AST harness script. It exports a top-level
// `build(BuildContext)` and returns a single `MaterialApp`. There is no
// `main()` and no `runApp()`. The harness serialises the resulting AST and
// renders the produced `MaterialApp` in its surface.
//
// Theme: archival notebook — cream paper, navy ink, mustard tabs, brown
// leather spine drawn via `CustomPainter`. Content text is monospace so the
// demo reads like an engineer's field book.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  _UhStPalette — the whole visual vocabulary. Every widget below picks from
//  this palette so the long scroll reads like one bound notebook rather than
//  a stack of disconnected demos.
// ---------------------------------------------------------------------------

class _UhStPalette {
  const _UhStPalette._();

  // Paper backgrounds.
  static const Color paper = Color(0xFFF4ECD6);
  static const Color paperWarm = Color(0xFFEDE2C4);
  static const Color paperDeep = Color(0xFFE2D6B2);
  static const Color paperInset = Color(0xFFE8DCBA);

  // Ink — primary text / strokes.
  static const Color navyDeep = Color(0xFF111C2E);
  static const Color navyInk = Color(0xFF1B2A44);
  static const Color navyMid = Color(0xFF2C3E5E);
  static const Color navySoft = Color(0xFF45547A);

  // Mustard tab / accent.
  static const Color mustard = Color(0xFFD5A02F);
  static const Color mustardDeep = Color(0xFFB4831F);
  static const Color mustardSoft = Color(0xFFE6C069);

  // Leather spine / binding.
  static const Color leather = Color(0xFF5E3A23);
  static const Color leatherDeep = Color(0xFF3E2616);
  static const Color leatherWarm = Color(0xFF7A4B2D);
  static const Color leatherStitch = Color(0xFFE3C98A);

  // Status colours used sparingly.
  static const Color sealRed = Color(0xFF9B2A2A);
  static const Color ferncrest = Color(0xFF486A3C);
  static const Color slateChalk = Color(0xFF8A8875);

  // Rule lines.
  static const Color ruleFaint = Color(0xFFC9BE9A);
  static const Color ruleMid = Color(0xFFA99E7A);
  static const Color ruleBold = Color(0xFF6D6348);
}

// ---------------------------------------------------------------------------
//  build() — the d4rt harness entry point. It returns a single `MaterialApp`.
//  Everything else lives below as private widgets with the `_UhSt` prefix so
//  nothing leaks into the AST harness's top-level namespace.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'UndoHistoryState Field Notebook',
    theme: _buildNotebookTheme(),
    home: const _UhStNotebookRoot(),
  );
}

ThemeData _buildNotebookTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: _UhStPalette.paper,
    colorScheme: base.colorScheme.copyWith(
      primary: _UhStPalette.navyInk,
      onPrimary: _UhStPalette.paper,
      secondary: _UhStPalette.mustard,
      onSecondary: _UhStPalette.navyDeep,
      surface: _UhStPalette.paperWarm,
      onSurface: _UhStPalette.navyDeep,
      error: _UhStPalette.sealRed,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: _UhStPalette.navyInk,
      displayColor: _UhStPalette.navyDeep,
      fontFamily: 'monospace',
      fontFamilyFallback: const <String>['Courier New', 'monospace'],
    ),
    dividerColor: _UhStPalette.ruleMid,
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {
        if (s.contains(WidgetState.selected)) {
          return _UhStPalette.mustard;
        }
        return _UhStPalette.paperDeep;
      }),
      thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> s) {
        if (s.contains(WidgetState.selected)) {
          return _UhStPalette.navyInk;
        }
        return _UhStPalette.navySoft;
      }),
    ),
    sliderTheme: base.sliderTheme.copyWith(
      activeTrackColor: _UhStPalette.mustard,
      inactiveTrackColor: _UhStPalette.paperDeep,
      thumbColor: _UhStPalette.navyInk,
      overlayColor: _UhStPalette.mustardSoft.withValues(alpha: 0.35),
      valueIndicatorColor: _UhStPalette.navyInk,
      valueIndicatorTextStyle: const TextStyle(
        color: _UhStPalette.paper,
        fontFamily: 'monospace',
        fontSize: 12,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
//  _UhStNotebookRoot — bound notebook with a leather spine on the left and a
//  scrollable page on the right. Holds global state (strict predicate toggle
//  and stack cap) which is threaded down through a plain inherited widget so
//  each chapter can react without owning it.
// ---------------------------------------------------------------------------

class _UhStNotebookRoot extends StatefulWidget {
  const _UhStNotebookRoot();

  @override
  State<_UhStNotebookRoot> createState() => _UhStNotebookRootState();
}

class _UhStNotebookRootState extends State<_UhStNotebookRoot> {
  bool _strictPredicate = false;
  double _stackCap = 24;
  final ScrollController _scroll = ScrollController();
  int _globalCommits = 0;
  int _globalReverts = 0;

  void _registerCommit() {
    setState(() => _globalCommits += 1);
  }

  void _registerRevert() {
    setState(() => _globalReverts += 1);
  }

  void _toggleStrict(bool v) {
    setState(() => _strictPredicate = v);
  }

  void _setStackCap(double v) {
    setState(() => _stackCap = v);
  }

  void _jumpToChapter(double offset) {
    if (_scroll.hasClients) {
      _scroll.animateTo(
        offset,
        duration: const Duration(milliseconds: 480),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _UhStSettings(
      strictPredicate: _strictPredicate,
      stackCap: _stackCap.round(),
      onCommit: _registerCommit,
      onRevert: _registerRevert,
      child: Scaffold(
        backgroundColor: _UhStPalette.paper,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _UhStLeatherSpine(
                strict: _strictPredicate,
                stackCap: _stackCap,
                commits: _globalCommits,
                reverts: _globalReverts,
                onToggleStrict: _toggleStrict,
                onStackCap: _setStackCap,
                onJump: _jumpToChapter,
              ),
              Expanded(
                child: _UhStPage(scroll: _scroll),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  _UhStSettings — inherited settings propagated to chapters. Hand-rolled so
//  no provider / riverpod style dependency is introduced into the harness.
// ---------------------------------------------------------------------------

class _UhStSettings extends InheritedWidget {
  const _UhStSettings({
    required this.strictPredicate,
    required this.stackCap,
    required this.onCommit,
    required this.onRevert,
    required super.child,
  });

  final bool strictPredicate;
  final int stackCap;
  final VoidCallback onCommit;
  final VoidCallback onRevert;

  static _UhStSettings of(BuildContext context) {
    final _UhStSettings? found =
        context.dependOnInheritedWidgetOfExactType<_UhStSettings>();
    assert(found != null, '_UhStSettings missing above this context');
    return found!;
  }

  @override
  bool updateShouldNotify(_UhStSettings old) {
    return strictPredicate != old.strictPredicate || stackCap != old.stackCap;
  }
}

// ---------------------------------------------------------------------------
//  _UhStLeatherSpine — the bound-notebook spine on the left edge. Custom
//  painted leather, stitched mustard, and navigation tabs for each chapter.
//  It hosts the global controls: strict predicate switch and stack cap slider.
// ---------------------------------------------------------------------------

class _UhStLeatherSpine extends StatelessWidget {
  const _UhStLeatherSpine({
    required this.strict,
    required this.stackCap,
    required this.commits,
    required this.reverts,
    required this.onToggleStrict,
    required this.onStackCap,
    required this.onJump,
  });

  final bool strict;
  final double stackCap;
  final int commits;
  final int reverts;
  final ValueChanged<bool> onToggleStrict;
  final ValueChanged<double> onStackCap;
  final ValueChanged<double> onJump;

  static const List<_UhStChapterRef> _chapters = <_UhStChapterRef>[
    _UhStChapterRef('I', 'Preamble', 0),
    _UhStChapterRef('II', 'Anatomy', 420),
    _UhStChapterRef('III', 'Typewriter', 980),
    _UhStChapterRef('IV', 'Swatches', 1680),
    _UhStChapterRef('V', 'Stack Diagram', 2380),
    _UhStChapterRef('VI', 'Predicate Gate', 2960),
    _UhStChapterRef('VII', 'Dual Fields', 3560),
    _UhStChapterRef('VIII', 'Epilogue', 4240),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 232,
      child: CustomPaint(
        painter: _UhStLeatherPainter(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'FIELD\nNOTEBOOK',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: _UhStPalette.leatherStitch,
                  fontSize: 15,
                  letterSpacing: 2.6,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Container(height: 1, color: _UhStPalette.leatherStitch),
              const SizedBox(height: 14),
              const Text(
                'UndoHistoryState<T>',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: _UhStPalette.paper,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'widgets / undo_history.dart',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: _UhStPalette.mustardSoft,
                  fontSize: 10.5,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 18),
              ..._chapters.map((_UhStChapterRef c) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: _UhStSpineTab(
                    label: c.label,
                    numeral: c.numeral,
                    onTap: () => onJump(c.offset),
                  ),
                );
              }),
              const SizedBox(height: 20),
              Container(height: 1, color: _UhStPalette.leatherStitch),
              const SizedBox(height: 14),
              const Text(
                'CONTROLS',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: _UhStPalette.leatherStitch,
                  fontSize: 11,
                  letterSpacing: 2.2,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'strict pred.',
                      style: TextStyle(
                        color: _UhStPalette.paper,
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: strict,
                      onChanged: onToggleStrict,
                      activeTrackColor: _UhStPalette.mustard,
                      inactiveTrackColor: _UhStPalette.leatherDeep,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'stack cap: ${stackCap.round()}',
                style: const TextStyle(
                  color: _UhStPalette.paper,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: _UhStPalette.mustard,
                  inactiveTrackColor: _UhStPalette.leatherDeep,
                  thumbColor: _UhStPalette.paper,
                  overlayColor:
                      _UhStPalette.mustardSoft.withValues(alpha: 0.3),
                ),
                child: Slider(
                  min: 4,
                  max: 48,
                  divisions: 44,
                  value: stackCap.clamp(4, 48),
                  onChanged: onStackCap,
                ),
              ),
              const Spacer(),
              _UhStCounterRow(label: 'commits', value: commits),
              _UhStCounterRow(label: 'reverts', value: reverts),
            ],
          ),
        ),
      ),
    );
  }
}

class _UhStChapterRef {
  const _UhStChapterRef(this.numeral, this.label, this.offset);
  final String numeral;
  final String label;
  final double offset;
}

class _UhStSpineTab extends StatelessWidget {
  const _UhStSpineTab({
    required this.numeral,
    required this.label,
    required this.onTap,
  });

  final String numeral;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: _UhStPalette.leatherWarm.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _UhStPalette.leatherStitch, width: 0.6),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 30,
              child: Text(
                numeral,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: _UhStPalette.mustard,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: _UhStPalette.paper,
                  fontSize: 11.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UhStCounterRow extends StatelessWidget {
  const _UhStCounterRow({required this.label, required this.value});
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _UhStPalette.mustardSoft,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _UhStPalette.leatherDeep,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: _UhStPalette.leatherStitch, width: 0.5),
            ),
            child: Text(
              value.toString().padLeft(3, '0'),
              style: const TextStyle(
                color: _UhStPalette.mustard,
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
//  _UhStLeatherPainter — hand-drawn leather texture for the spine: warm base
//  gradient, gold-thread double stitching along both edges, horizontal bands
//  at top and bottom where a real bound notebook would have its headbands.
// ---------------------------------------------------------------------------

class _UhStLeatherPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect full = Offset.zero & size;
    final Paint base = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _UhStPalette.leather,
          _UhStPalette.leatherDeep,
          _UhStPalette.leatherWarm,
        ],
        stops: <double>[0.0, 0.5, 1.0],
      ).createShader(full);
    canvas.drawRect(full, base);

    // Subtle vertical grain ("leather pores").
    final Paint grain = Paint()
      ..color = _UhStPalette.leatherStitch.withValues(alpha: 0.05)
      ..strokeWidth = 0.6;
    for (double x = 2; x < size.width; x += 3.5) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grain);
    }

    // Right-edge darker shadow (book fold toward the page).
    final Paint fold = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0x00000000),
          Color(0x66000000),
        ],
      ).createShader(Rect.fromLTWH(size.width - 28, 0, 28, size.height));
    canvas.drawRect(
      Rect.fromLTWH(size.width - 28, 0, 28, size.height),
      fold,
    );

    // Gold double stitching along both long edges.
    final Paint stitch = Paint()
      ..color = _UhStPalette.leatherStitch
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke;
    const double dashLen = 4;
    const double gap = 3;
    for (double x in <double>[7, size.width - 7]) {
      double y = 12;
      while (y < size.height - 12) {
        canvas.drawLine(
          Offset(x, y),
          Offset(x, y + dashLen),
          stitch,
        );
        y += dashLen + gap;
      }
    }

    // Horizontal headbands top and bottom.
    final Paint band = Paint()..color = _UhStPalette.mustardDeep;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, 6), band);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - 6, size.width, 6),
      band,
    );
    final Paint bandStripe = Paint()..color = _UhStPalette.mustardSoft;
    for (int i = 0; i < size.width.toInt(); i += 8) {
      canvas.drawRect(
        Rect.fromLTWH(i.toDouble(), 1, 4, 4),
        bandStripe,
      );
      canvas.drawRect(
        Rect.fromLTWH(i.toDouble(), size.height - 5, 4, 4),
        bandStripe,
      );
    }
  }

  @override
  bool shouldRepaint(_UhStLeatherPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
//  _UhStPage — the right-hand scrolling page. Renders every chapter in a
//  long vertical scroll so readers can jump from the spine tabs. The outer
//  container paints faint horizontal ruled lines and a vertical red margin
//  rule, like the paper a physical notebook would have.
// ---------------------------------------------------------------------------

class _UhStPage extends StatelessWidget {
  const _UhStPage({required this.scroll});

  final ScrollController scroll;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _UhStPalette.paper,
            _UhStPalette.paperWarm,
          ],
        ),
      ),
      child: CustomPaint(
        painter: _UhStRuledPagePainter(),
        child: ListView(
          controller: scroll,
          padding: const EdgeInsets.fromLTRB(56, 28, 40, 56),
          children: const <Widget>[
            _UhStPreamble(),
            SizedBox(height: 32),
            _UhStAnatomy(),
            SizedBox(height: 32),
            _UhStTypewriter(),
            SizedBox(height: 32),
            _UhStSwatches(),
            SizedBox(height: 32),
            _UhStStackDiagram(),
            SizedBox(height: 32),
            _UhStPredicateGate(),
            SizedBox(height: 32),
            _UhStDualFields(),
            SizedBox(height: 32),
            _UhStEpilogue(),
          ],
        ),
      ),
    );
  }
}

class _UhStRuledPagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Faint horizontal rules.
    final Paint rule = Paint()
      ..color = _UhStPalette.ruleFaint
      ..strokeWidth = 0.6;
    const double spacing = 28;
    for (double y = 40; y < size.height; y += spacing) {
      canvas.drawLine(Offset(28, y), Offset(size.width - 16, y), rule);
    }
    // Red left margin rule — classic composition book cue.
    final Paint margin = Paint()
      ..color = _UhStPalette.sealRed.withValues(alpha: 0.4)
      ..strokeWidth = 1.1;
    canvas.drawLine(
      const Offset(44, 0),
      Offset(44, size.height),
      margin,
    );
    // Second margin rule to form a double line.
    canvas.drawLine(
      const Offset(47, 0),
      Offset(47, size.height),
      Paint()
        ..color = _UhStPalette.sealRed.withValues(alpha: 0.2)
        ..strokeWidth = 0.6,
    );
  }

  @override
  bool shouldRepaint(_UhStRuledPagePainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
//  _UhStCard — reusable chapter wrapper: a numbered chapter header, a short
//  abstract, and a body slot.
// ---------------------------------------------------------------------------

class _UhStCard extends StatelessWidget {
  const _UhStCard({
    required this.numeral,
    required this.title,
    required this.abstractText,
    required this.child,
  });

  final String numeral;
  final String title;
  final String abstractText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _UhStPalette.paperWarm,
        border: Border.all(color: _UhStPalette.ruleMid, width: 1.1),
        borderRadius: BorderRadius.circular(6),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _UhStPalette.navyDeep.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _UhStPalette.mustard,
                  border:
                      Border.all(color: _UhStPalette.navyDeep, width: 1.2),
                ),
                child: Text(
                  numeral,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: _UhStPalette.navyDeep,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: _UhStPalette.navyDeep,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: _UhStPalette.ruleBold),
          const SizedBox(height: 12),
          Text(
            abstractText,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _UhStPalette.navyMid,
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Chapter I — Preamble. Describes what `UndoHistoryState<T>` is and when
//  Flutter instantiates it.
// ---------------------------------------------------------------------------

class _UhStPreamble extends StatelessWidget {
  const _UhStPreamble();

  @override
  Widget build(BuildContext context) {
    return _UhStCard(
      numeral: 'I',
      title: 'Preamble — a quiet state class',
      abstractText:
          'UndoHistoryState<T> is the State class of UndoHistory<T>. It is '
          'never instantiated by hand; the framework creates it through '
          'createState() when the widget is mounted into the tree. Most '
          'consumers never call a method on it directly and instead talk to '
          'an UndoHistoryController. The field notebook that follows unpacks '
          'the relationship between the widget, its state, and the controller.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _UhStFactGrid(
            entries: const <_UhStFact>[
              _UhStFact('Library', 'package:flutter/widgets.dart'),
              _UhStFact('File', 'src/widgets/undo_history.dart'),
              _UhStFact('Widget', 'UndoHistory<T> extends StatefulWidget'),
              _UhStFact('State', 'UndoHistoryState<T> extends State<...> '
                  'with UndoManagerClient'),
              _UhStFact('Annotation', '@visibleForTesting'),
              _UhStFact('Exposes', 'undo(), redo(), canUndo, canRedo'),
              _UhStFact('Observes', 'ValueNotifier<T> passed as `value`'),
              _UhStFact('Throttle', '500 ms between stack pushes'),
              _UhStFact('Controller', 'UndoHistoryController, optional'),
              _UhStFact('Platform', 'integrates UndoManager on iOS'),
            ],
          ),
          const SizedBox(height: 18),
          const _UhStCallout(
            title: 'Why is it @visibleForTesting?',
            body:
                'The class exists to back UndoHistory<T> and is intentionally '
                'de-emphasised in the public API: the supported path is to '
                'supply an UndoHistoryController to the widget and call '
                'controller.undo() / controller.redo(). Tests keep reaching '
                'in through the State directly, hence the annotation.',
          ),
          SizedBox(height: 14),
          _UhStCallout(
            title: 'Single-responsibility, three collaborators',
            body:
                'The trio to remember: UndoHistory<T> is the widget that '
                'knows about your ValueNotifier and FocusNode; '
                'UndoHistoryState<T> is the throttled stack machine; '
                'UndoHistoryController is the ValueListenable<UndoHistoryValue> '
                'that lets other UI drive undo / redo without holding the '
                'state itself.',
          ),
        ],
      ),
    );
  }
}

class _UhStFact {
  const _UhStFact(this.label, this.value);
  final String label;
  final String value;
}

class _UhStFactGrid extends StatelessWidget {
  const _UhStFactGrid({required this.entries});
  final List<_UhStFact> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < entries.length; i++)
          Container(
            decoration: BoxDecoration(
              color: i.isEven ? _UhStPalette.paper : _UhStPalette.paperInset,
              border: Border(
                top: BorderSide(
                  color: _UhStPalette.ruleFaint,
                  width: i == 0 ? 1 : 0,
                ),
                bottom: const BorderSide(
                  color: _UhStPalette.ruleFaint,
                  width: 1,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 118,
                  child: Text(
                    entries[i].label,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: _UhStPalette.navySoft,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    entries[i].value,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: _UhStPalette.navyDeep,
                      fontSize: 12.5,
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

class _UhStCallout extends StatelessWidget {
  const _UhStCallout({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: _UhStPalette.paperDeep,
        border: Border(
          left: BorderSide(color: _UhStPalette.mustardDeep, width: 4),
          top: BorderSide(color: _UhStPalette.ruleFaint, width: 0.8),
          right: BorderSide(color: _UhStPalette.ruleFaint, width: 0.8),
          bottom: BorderSide(color: _UhStPalette.ruleFaint, width: 0.8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _UhStPalette.navyDeep,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _UhStPalette.navyMid,
              fontSize: 12.3,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Chapter II — Anatomy. Expanded reference table of every public member of
//  UndoHistoryState<T>, plus annotated lifecycle.
// ---------------------------------------------------------------------------

class _UhStAnatomy extends StatelessWidget {
  const _UhStAnatomy();

  @override
  Widget build(BuildContext context) {
    return _UhStCard(
      numeral: 'II',
      title: 'Anatomy — members & lifecycle',
      abstractText:
          'Every effective method and field on UndoHistoryState<T>. The left '
          'column is the signature as-declared; the right column is a plain-'
          'English gloss. The third panel is the lifecycle — what runs during '
          'initState, didUpdateWidget, dispose — because the class is very '
          'sensitive to changes in value / focusNode / controller identity.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _UhStSectionLabel('Members'),
          _UhStSignatureTable(rows: const <_UhStSignatureRow>[
            _UhStSignatureRow(
              'void undo()',
              'Pop one entry from the past stack, call widget.onTriggered '
                  'with the previous value. If a throttled push is still in '
                  'flight it is cancelled and treated as the "current" entry.',
            ),
            _UhStSignatureRow(
              'void redo()',
              'Move one entry from the future stack back onto the present. '
                  'Calls onTriggered. Does nothing if the future stack is '
                  'empty.',
            ),
            _UhStSignatureRow(
              'bool get canUndo',
              'True when at least one earlier value is recorded.',
            ),
            _UhStSignatureRow(
              'bool get canRedo',
              'True when at least one value was un-done since the last commit.',
            ),
            _UhStSignatureRow(
              'void handlePlatformUndo(UndoDirection d)',
              'UndoManagerClient hook: called from native undo menu on iOS. '
                  'Forwards to undo() / redo().',
            ),
            _UhStSignatureRow(
              'Widget build(BuildContext c)',
              'Installs Actions for UndoTextIntent and RedoTextIntent so '
                  'platform-level keyboard shortcuts are wired up.',
            ),
          ]),
          const SizedBox(height: 18),
          const _UhStSectionLabel('Lifecycle'),
          const _UhStLifecycleList(),
          const SizedBox(height: 18),
          const _UhStSectionLabel('Why it is wrapped in a controller'),
          const _UhStCallout(
            title: 'One State, many listeners',
            body:
                'UndoHistoryController is a ValueNotifier<UndoHistoryValue>. '
                'Toolbars, menu items, and accessibility services subscribe '
                'to the controller and get notified when canUndo / canRedo '
                'flip. UndoHistoryState<T> is the single writer: on every '
                'throttled push and every undo/redo it updates the '
                'controller.value. That is the fan-out.',
          ),
          SizedBox(height: 10),
          _UhStCallout(
            title: 'Never long-lived references',
            body:
                'Because UndoHistoryState<T> is @visibleForTesting you should '
                'not retain references to it in application code. Capture the '
                'controller instead — it is the stable handle, and it survives '
                'widget rebuilds that swap the State out from under you.',
          ),
        ],
      ),
    );
  }
}

class _UhStSectionLabel extends StatelessWidget {
  const _UhStSectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 4,
            height: 18,
            color: _UhStPalette.navyInk,
          ),
          const SizedBox(width: 10),
          Text(
            text.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _UhStPalette.navyInk,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _UhStSignatureRow {
  const _UhStSignatureRow(this.sig, this.gloss);
  final String sig;
  final String gloss;
}

class _UhStSignatureTable extends StatelessWidget {
  const _UhStSignatureTable({required this.rows});
  final List<_UhStSignatureRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _UhStPalette.ruleBold, width: 1),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            Container(
              decoration: BoxDecoration(
                color: i.isEven ? _UhStPalette.paper : _UhStPalette.paperInset,
                border: Border(
                  bottom: BorderSide(
                    color: _UhStPalette.ruleFaint,
                    width: i == rows.length - 1 ? 0 : 1,
                  ),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 260,
                    child: Text(
                      rows[i].sig,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: _UhStPalette.navyDeep,
                        fontSize: 12.4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      rows[i].gloss,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: _UhStPalette.navyMid,
                        fontSize: 12,
                        height: 1.5,
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

class _UhStLifecycleList extends StatelessWidget {
  const _UhStLifecycleList();

  static const List<List<String>> _steps = <List<String>>[
    <String>['initState',
        'Build the throttled pusher with a 500 ms cadence, push the initial '
            'value onto the stack, attach listeners to value, focusNode, and '
            'the effective controller\'s onUndo / onRedo notifiers.'],
    <String>['didUpdateWidget',
        'If widget.value changed, clear the stack and swap listeners. If '
            'widget.focusNode changed, swap focus listeners. If '
            'widget.controller changed, detach the old controller, allocate a '
            'new implicit one if needed.'],
    <String>['_push (triggered by value change)',
        'Early-returns if value is unchanged, if an undo/redo is in flight, '
            'if shouldChangeUndoStack returned false, or if the value '
            'transformed through undoStackModifier matches the last '
            'recorded. Otherwise schedules a throttled push.'],
    <String>['undo / redo',
        'Pops / un-pops a value and calls widget.onTriggered. Updates '
            'controller.value and, on iOS, the platform UndoManager state.'],
    <String>['dispose',
        'Detach listeners, dispose any implicit controller, cancel the '
            'pending throttle timer, clear UndoManager.client if this was it.'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (int i = 0; i < _steps.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: _UhStPalette.navyInk,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: _UhStPalette.mustardSoft,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        _steps[i][0],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          color: _UhStPalette.navyDeep,
                          fontSize: 12.8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _steps[i][1],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          color: _UhStPalette.navyMid,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
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
//  Chapter III — Typewriter notebook. Hosts a real UndoHistory<TextEditingValue>
//  wrapped around a TextField, driven by an UndoHistoryController. Shows how
//  the State surfaces through the controller's ValueListenable.
// ---------------------------------------------------------------------------

class _UhStTypewriter extends StatefulWidget {
  const _UhStTypewriter();

  @override
  State<_UhStTypewriter> createState() => _UhStTypewriterState();
}

class _UhStTypewriterState extends State<_UhStTypewriter> {
  late final TextEditingController _textController;
  late final FocusNode _focus;
  late final UndoHistoryController _undoController;
  int _commits = 0;
  int _rejected = 0;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: 'The field notebook begins.',
    );
    _focus = FocusNode(debugLabel: 'uhst-typewriter');
    _undoController = UndoHistoryController();
    _undoController.addListener(_onHistoryChanged);
  }

  void _onHistoryChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _undoController.removeListener(_onHistoryChanged);
    _undoController.dispose();
    _textController.dispose();
    _focus.dispose();
    super.dispose();
  }

  bool _shouldChange(TextEditingValue? oldValue, TextEditingValue newValue) {
    final _UhStSettings settings = _UhStSettings.of(context);
    // Always allow the initial push.
    if (oldValue == null) {
      _commits += 1;
      return true;
    }
    // In strict mode, only keep commits that end in a word boundary so the
    // user's undo stack does not fill with every keystroke.
    if (settings.strictPredicate) {
      final bool endsAtBoundary = newValue.text.isEmpty ||
          newValue.text.endsWith(' ') ||
          newValue.text.endsWith('.') ||
          newValue.text.endsWith(',') ||
          newValue.text.endsWith('\n');
      if (!endsAtBoundary) {
        _rejected += 1;
        return false;
      }
    }
    _commits += 1;
    settings.onCommit();
    return true;
  }

  void _handleClear() {
    _textController.text = '';
    _focus.requestFocus();
  }

  void _handleInsertDated() {
    final String now = DateTime.now().toIso8601String().split('T').first;
    final TextEditingValue cur = _textController.value;
    final String insertion = '[$now] ';
    _textController.value = TextEditingValue(
      text: '${cur.text}$insertion',
      selection: TextSelection.collapsed(offset: cur.text.length + insertion.length),
    );
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final _UhStSettings settings = _UhStSettings.of(context);
    return _UhStCard(
      numeral: 'III',
      title: 'Typewriter — UndoHistory<TextEditingValue>',
      abstractText:
          'A TextField sits inside UndoHistory<TextEditingValue>. Every time '
          'the TextEditingController notifies a new value, the State schedules '
          'a throttled push onto the stack. The controller\'s canUndo / canRedo '
          'drive the toolbar above. Flip the strict-predicate switch in the '
          'spine to watch shouldChangeUndoStack reject mid-word commits.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _UhStToolbar(
            undoController: _undoController,
            onClear: _handleClear,
            onInsert: _handleInsertDated,
            strict: settings.strictPredicate,
          ),
          const SizedBox(height: 12),
          UndoHistory<TextEditingValue>(
            controller: _undoController,
            focusNode: _focus,
            value: _textController,
            shouldChangeUndoStack: _shouldChange,
            onTriggered: (TextEditingValue v) {
              _textController.value = v;
              _UhStSettings.of(context).onRevert();
            },
            child: _UhStTypewriterField(
              controller: _textController,
              focus: _focus,
            ),
          ),
          const SizedBox(height: 12),
          _UhStTypewriterMetrics(
            controller: _undoController,
            text: _textController,
            committed: _commits,
            rejected: _rejected,
          ),
        ],
      ),
    );
  }
}

class _UhStToolbar extends StatelessWidget {
  const _UhStToolbar({
    required this.undoController,
    required this.onClear,
    required this.onInsert,
    required this.strict,
  });

  final UndoHistoryController undoController;
  final VoidCallback onClear;
  final VoidCallback onInsert;
  final bool strict;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: undoController,
      builder: (BuildContext context, Widget? _) {
        final UndoHistoryValue v = undoController.value;
        return Container(
          decoration: BoxDecoration(
            color: _UhStPalette.paperDeep,
            border: Border.all(color: _UhStPalette.ruleBold, width: 1),
          ),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(
            children: <Widget>[
              _UhStToolbarButton(
                label: 'undo',
                enabled: v.canUndo,
                onPressed: v.canUndo ? undoController.undo : null,
              ),
              const SizedBox(width: 8),
              _UhStToolbarButton(
                label: 'redo',
                enabled: v.canRedo,
                onPressed: v.canRedo ? undoController.redo : null,
              ),
              const SizedBox(width: 14),
              Container(width: 1, height: 22, color: _UhStPalette.ruleMid),
              const SizedBox(width: 14),
              _UhStToolbarButton(
                label: 'clear',
                enabled: true,
                onPressed: onClear,
              ),
              const SizedBox(width: 8),
              _UhStToolbarButton(
                label: 'insert date',
                enabled: true,
                onPressed: onInsert,
              ),
              const Spacer(),
              _UhStBadge(
                label: strict ? 'STRICT' : 'OPEN',
                tone: strict ? _UhStPalette.sealRed : _UhStPalette.ferncrest,
              ),
              const SizedBox(width: 8),
              _UhStBadge(
                label: v.canUndo ? 'past OK' : 'past empty',
                tone: _UhStPalette.navyInk,
              ),
              const SizedBox(width: 8),
              _UhStBadge(
                label: v.canRedo ? 'future OK' : 'future empty',
                tone: _UhStPalette.navyInk,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UhStToolbarButton extends StatelessWidget {
  const _UhStToolbarButton({
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: enabled ? _UhStPalette.navyInk : _UhStPalette.paperInset,
          border: Border.all(
            color: enabled ? _UhStPalette.navyDeep : _UhStPalette.ruleMid,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            color: enabled ? _UhStPalette.mustardSoft : _UhStPalette.slateChalk,
            fontSize: 11.5,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _UhStBadge extends StatelessWidget {
  const _UhStBadge({required this.label, required this.tone});
  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: _UhStPalette.paper,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _UhStTypewriterField extends StatelessWidget {
  const _UhStTypewriterField({required this.controller, required this.focus});

  final TextEditingController controller;
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _UhStPalette.paper,
        border: Border.all(color: _UhStPalette.navyInk, width: 1.2),
      ),
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        focusNode: focus,
        minLines: 4,
        maxLines: 8,
        cursorColor: _UhStPalette.navyInk,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: _UhStPalette.navyDeep,
          fontSize: 13,
          height: 1.6,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          hintText: 'Begin typing — every keystroke feeds the undo stack.',
          hintStyle: TextStyle(
            fontFamily: 'monospace',
            color: _UhStPalette.slateChalk,
            fontSize: 13,
          ),
        ),
        // Keyboard shortcuts for undo/redo are handled by UndoHistory.
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
      ),
    );
  }
}

class _UhStTypewriterMetrics extends StatelessWidget {
  const _UhStTypewriterMetrics({
    required this.controller,
    required this.text,
    required this.committed,
    required this.rejected,
  });

  final UndoHistoryController controller;
  final TextEditingController text;
  final int committed;
  final int rejected;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[controller, text]),
      builder: (BuildContext context, Widget? _) {
        final UndoHistoryValue v = controller.value;
        return Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: BoxDecoration(
            color: _UhStPalette.paperInset,
            border: Border.all(color: _UhStPalette.ruleMid, width: 1),
          ),
          child: Row(
            children: <Widget>[
              _UhStMetric(label: 'can undo', value: v.canUndo ? 'yes' : 'no'),
              _UhStMetric(label: 'can redo', value: v.canRedo ? 'yes' : 'no'),
              _UhStMetric(label: 'length', value: '${text.text.length}'),
              _UhStMetric(label: 'commits', value: '$committed'),
              _UhStMetric(label: 'rejected', value: '$rejected'),
            ],
          ),
        );
      },
    );
  }
}

class _UhStMetric extends StatelessWidget {
  const _UhStMetric({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _UhStPalette.navySoft,
              fontSize: 10.5,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _UhStPalette.navyDeep,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Chapter IV — Swatches. UndoHistory<Color> backed by a ValueNotifier<Color>
//  and an explicit UndoHistoryController. Users tap colour swatches; undo /
//  redo march through the colour journal.
// ---------------------------------------------------------------------------

class _UhStSwatches extends StatefulWidget {
  const _UhStSwatches();

  @override
  State<_UhStSwatches> createState() => _UhStSwatchesState();
}

class _UhStSwatchesState extends State<_UhStSwatches> {
  late final ValueNotifier<Color> _colour;
  late final FocusNode _focus;
  late final UndoHistoryController _controller;
  int _picks = 0;

  static const List<Color> _palette = <Color>[
    Color(0xFF9B2A2A), // seal red
    Color(0xFFD5A02F), // mustard
    Color(0xFF486A3C), // ferncrest
    Color(0xFF1B2A44), // navy
    Color(0xFF5E3A23), // leather
    Color(0xFF7A4B2D), // leather warm
    Color(0xFF2C3E5E), // navy mid
    Color(0xFFB4831F), // mustard deep
  ];

  @override
  void initState() {
    super.initState();
    _colour = ValueNotifier<Color>(_palette.first);
    _focus = FocusNode(debugLabel: 'uhst-swatches');
    _controller = UndoHistoryController();
    _controller.addListener(_rebuild);
    _colour.addListener(_rebuild);
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_rebuild);
    _colour.removeListener(_rebuild);
    _controller.dispose();
    _colour.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _pick(Color c) {
    if (_colour.value == c) return;
    _colour.value = c;
    _picks += 1;
    _UhStSettings.of(context).onCommit();
  }

  @override
  Widget build(BuildContext context) {
    return _UhStCard(
      numeral: 'IV',
      title: 'Swatches — UndoHistory<Color>',
      abstractText:
          'UndoHistory<T> is not limited to TextEditingValue; any type with a '
          'stable equals will do. Here a ValueNotifier<Color> drives the '
          'state, tapping a swatch is a commit, and the controller\'s undo / '
          'redo walk through the colour history. Notice how the swatch bar '
          'highlights the live colour without re-touching the undo stack.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          UndoHistory<Color>(
            controller: _controller,
            focusNode: _focus,
            value: _colour,
            onTriggered: (Color next) {
              _colour.value = next;
              _UhStSettings.of(context).onRevert();
            },
            child: _UhStSwatchViewer(
              colour: _colour.value,
              controller: _controller,
            ),
          ),
          const SizedBox(height: 14),
          _UhStSwatchStrip(
            palette: _palette,
            current: _colour.value,
            onPick: _pick,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: _UhStPalette.paperInset,
              border: Border.all(color: _UhStPalette.ruleMid, width: 1),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'picks: $_picks   |   can undo: ${_controller.value.canUndo}'
                    '   |   can redo: ${_controller.value.canRedo}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: _UhStPalette.navyDeep,
                      fontSize: 12.5,
                    ),
                  ),
                ),
                _UhStToolbarButton(
                  label: 'undo',
                  enabled: _controller.value.canUndo,
                  onPressed: _controller.value.canUndo ? _controller.undo : null,
                ),
                const SizedBox(width: 6),
                _UhStToolbarButton(
                  label: 'redo',
                  enabled: _controller.value.canRedo,
                  onPressed: _controller.value.canRedo ? _controller.redo : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UhStSwatchViewer extends StatelessWidget {
  const _UhStSwatchViewer({required this.colour, required this.controller});

  final Color colour;
  final UndoHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: FocusScope.of(context).focusedChild,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: colour,
          border: Border.all(color: _UhStPalette.navyDeep, width: 1.2),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: CustomPaint(painter: _UhStSwatchGuilloche(colour: colour)),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                color: _UhStPalette.paper.withValues(alpha: 0.88),
                child: Text(
                  _hex(colour),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: _UhStPalette.navyDeep,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _hex(Color c) {
    final int v = c.toARGB32() & 0x00FFFFFF;
    return '#${v.toRadixString(16).toUpperCase().padLeft(6, '0')}';
  }
}

class _UhStSwatchGuilloche extends CustomPainter {
  _UhStSwatchGuilloche({required this.colour});
  final Color colour;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = _UhStPalette.paper.withValues(alpha: 0.15)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;
    for (double y = 0; y < size.height; y += 6) {
      final Path p = Path()..moveTo(0, y);
      for (double x = 0; x <= size.width; x += 6) {
        final double yy = y + 2.5 * ((x / 30) % 2 == 0 ? 1 : -1);
        p.lineTo(x, yy);
      }
      canvas.drawPath(p, line);
    }
  }

  @override
  bool shouldRepaint(_UhStSwatchGuilloche old) => old.colour != colour;
}

class _UhStSwatchStrip extends StatelessWidget {
  const _UhStSwatchStrip({
    required this.palette,
    required this.current,
    required this.onPick,
  });

  final List<Color> palette;
  final Color current;
  final ValueChanged<Color> onPick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: palette.length,
        separatorBuilder: (BuildContext _, int _) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int i) {
          final Color c = palette[i];
          final bool selected = c == current;
          return InkWell(
            onTap: () => onPick(c),
            child: Container(
              width: 54,
              decoration: BoxDecoration(
                color: c,
                border: Border.all(
                  color: selected ? _UhStPalette.mustard : _UhStPalette.navyDeep,
                  width: selected ? 3 : 1,
                ),
              ),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: selected ? _UhStPalette.paper : _UhStPalette.paper,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Chapter V — Stack diagram. A CustomPainter drawing of the three mental
//  stacks (past / present / future) that the internal _UndoStack<T> keeps,
//  with live counts driven by a small synthetic model.
// ---------------------------------------------------------------------------

class _UhStStackDiagram extends StatefulWidget {
  const _UhStStackDiagram();

  @override
  State<_UhStStackDiagram> createState() => _UhStStackDiagramState();
}

class _UhStStackDiagramState extends State<_UhStStackDiagram> {
  // A synthetic undo stack so the diagram stays lively without reaching into
  // the internal _UndoStack<T>. Mirrors the same past / present / future model
  // that UndoHistoryState<T> uses internally.
  final List<String> _past = <String>[];
  String _present = 'snapshot-000';
  final List<String> _future = <String>[];
  int _counter = 0;

  void _commit() {
    setState(() {
      _past.add(_present);
      _counter += 1;
      _present = 'snapshot-${_counter.toString().padLeft(3, '0')}';
      _future.clear();
    });
  }

  void _undo() {
    if (_past.isEmpty) return;
    setState(() {
      _future.add(_present);
      _present = _past.removeLast();
    });
  }

  void _redo() {
    if (_future.isEmpty) return;
    setState(() {
      _past.add(_present);
      _present = _future.removeLast();
    });
  }

  void _clear() {
    setState(() {
      _past.clear();
      _future.clear();
      _counter = 0;
      _present = 'snapshot-000';
    });
  }

  @override
  Widget build(BuildContext context) {
    final int cap = _UhStSettings.of(context).stackCap;
    // Respect the stack cap: if past exceeds the cap, drop the oldest.
    while (_past.length > cap) {
      _past.removeAt(0);
    }
    return _UhStCard(
      numeral: 'V',
      title: 'Stack diagram — past / present / future',
      abstractText:
          'Internally UndoHistoryState<T> keeps a _UndoStack<T> with three '
          'slots: the past (earlier values), the present (current value), and '
          'the future (values that were un-done). Commits move present -> '
          'past; undo pops past -> present; redo pops future -> present. The '
          'diagram below is a live, scaled reproduction of that model. Use '
          'the spine slider to reshape the stack cap.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 260,
            child: CustomPaint(
              painter: _UhStStackPainter(
                past: _past,
                present: _present,
                future: _future,
                cap: cap,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _UhStToolbarButton(
                  label: 'commit', enabled: true, onPressed: _commit),
              _UhStToolbarButton(
                label: 'undo',
                enabled: _past.isNotEmpty,
                onPressed: _past.isNotEmpty ? _undo : null,
              ),
              _UhStToolbarButton(
                label: 'redo',
                enabled: _future.isNotEmpty,
                onPressed: _future.isNotEmpty ? _redo : null,
              ),
              _UhStToolbarButton(
                label: 'clear all', enabled: true, onPressed: _clear),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              _UhStMetric(label: 'past', value: '${_past.length}'),
              _UhStMetric(label: 'present', value: _present),
              _UhStMetric(label: 'future', value: '${_future.length}'),
              _UhStMetric(label: 'cap', value: '$cap'),
            ],
          ),
        ],
      ),
    );
  }
}

class _UhStStackPainter extends CustomPainter {
  _UhStStackPainter({
    required this.past,
    required this.present,
    required this.future,
    required this.cap,
  });

  final List<String> past;
  final String present;
  final List<String> future;
  final int cap;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _UhStPalette.paperInset;
    canvas.drawRect(Offset.zero & size, bg);
    final Paint frame = Paint()
      ..color = _UhStPalette.ruleBold
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawRect(
      Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1),
      frame,
    );

    final double col = size.width / 3;
    final double top = 32;
    final double bottom = size.height - 12;
    final double usable = bottom - top;

    _drawColumn(canvas, 'PAST', 0, col, top, bottom, usable, past,
        _UhStPalette.navyInk);
    _drawPresent(canvas, col, col, top, bottom, present);
    _drawColumn(canvas, 'FUTURE', col * 2, col, top, bottom, usable, future,
        _UhStPalette.leather);

    // Column headers.
    final TextPainter capLabel = TextPainter(
      text: TextSpan(
        text: 'stack cap = $cap',
        style: const TextStyle(
          color: _UhStPalette.navyInk,
          fontFamily: 'monospace',
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    capLabel.paint(canvas, Offset(size.width - capLabel.width - 10, 10));
  }

  void _drawColumn(
    Canvas canvas,
    String header,
    double x,
    double width,
    double top,
    double bottom,
    double usable,
    List<String> entries,
    Color base,
  ) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: header,
        style: const TextStyle(
          color: _UhStPalette.navyDeep,
          fontFamily: 'monospace',
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(x + 10, 10));

    if (entries.isEmpty) {
      final TextPainter empty = TextPainter(
        text: const TextSpan(
          text: '(empty)',
          style: TextStyle(
            color: _UhStPalette.slateChalk,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      empty.paint(canvas,
          Offset(x + (width - empty.width) / 2, top + usable / 2 - 6));
      return;
    }

    final double slot = (usable / entries.length).clamp(10, 30).toDouble();
    for (int i = 0; i < entries.length; i++) {
      final double y = bottom - (i + 1) * slot;
      final Rect r =
          Rect.fromLTWH(x + 10, y + 2, width - 20, slot - 4);
      final Paint p = Paint()
        ..color = base.withValues(alpha: 0.08 + 0.08 * (i % 6));
      canvas.drawRect(r, p);
      canvas.drawRect(
        r,
        Paint()
          ..color = base
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
      if (slot > 14) {
        final TextPainter label = TextPainter(
          text: TextSpan(
            text: entries[i],
            style: TextStyle(
              color: base,
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          textDirection: TextDirection.ltr,
          maxLines: 1,
          ellipsis: '..',
        )..layout(maxWidth: r.width - 8);
        label.paint(canvas, Offset(r.left + 6, r.top + (r.height - label.height) / 2));
      }
    }
  }

  void _drawPresent(
    Canvas canvas,
    double x,
    double width,
    double top,
    double bottom,
    String value,
  ) {
    final TextPainter head = TextPainter(
      text: const TextSpan(
        text: 'PRESENT',
        style: TextStyle(
          color: _UhStPalette.mustardDeep,
          fontFamily: 'monospace',
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    head.paint(canvas, Offset(x + 10, 10));
    final Rect hero = Rect.fromLTWH(x + 10, top + 10, width - 20, 48);
    final Paint fill = Paint()..color = _UhStPalette.mustardSoft;
    final Paint stroke = Paint()
      ..color = _UhStPalette.mustardDeep
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(hero, fill);
    canvas.drawRect(hero, stroke);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: value,
        style: const TextStyle(
          color: _UhStPalette.navyDeep,
          fontFamily: 'monospace',
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '..',
    )..layout(maxWidth: hero.width - 12);
    tp.paint(canvas,
        Offset(hero.left + 10, hero.top + (hero.height - tp.height) / 2));

    final Paint arrow = Paint()
      ..color = _UhStPalette.navyInk
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(hero.left - 10, hero.center.dy),
      Offset(hero.left - 30, hero.center.dy),
      arrow,
    );
    canvas.drawLine(
      Offset(hero.right + 10, hero.center.dy),
      Offset(hero.right + 30, hero.center.dy),
      arrow,
    );
  }

  @override
  bool shouldRepaint(_UhStStackPainter old) =>
      old.past != past ||
      old.present != present ||
      old.future != future ||
      old.cap != cap;
}

// ---------------------------------------------------------------------------
//  Chapter VI — Predicate Gate. A small editor where shouldChangeUndoStack
//  selectively rejects commits. The panel is side-by-side: left side always
//  accepts; right side runs in strict mode. Both share the same stream of
//  user edits.
// ---------------------------------------------------------------------------

class _UhStPredicateGate extends StatefulWidget {
  const _UhStPredicateGate();

  @override
  State<_UhStPredicateGate> createState() => _UhStPredicateGateState();
}

class _UhStPredicateGateState extends State<_UhStPredicateGate> {
  late final ValueNotifier<String> _openValue;
  late final ValueNotifier<String> _strictValue;
  late final FocusNode _openFocus;
  late final FocusNode _strictFocus;
  late final UndoHistoryController _openCtrl;
  late final UndoHistoryController _strictCtrl;
  final TextEditingController _echo =
      TextEditingController(text: 'Try typing: hello world.\n');
  final int _openRejects = 0;
  int _strictRejects = 0;

  @override
  void initState() {
    super.initState();
    _openValue = ValueNotifier<String>(_echo.text);
    _strictValue = ValueNotifier<String>(_echo.text);
    _openFocus = FocusNode(debugLabel: 'uhst-gate-open');
    _strictFocus = FocusNode(debugLabel: 'uhst-gate-strict');
    _openCtrl = UndoHistoryController();
    _strictCtrl = UndoHistoryController();
    _echo.addListener(_syncFromEcho);
    _openCtrl.addListener(_rebuild);
    _strictCtrl.addListener(_rebuild);
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  void _syncFromEcho() {
    _openValue.value = _echo.text;
    _strictValue.value = _echo.text;
  }

  @override
  void dispose() {
    _echo.removeListener(_syncFromEcho);
    _openCtrl.removeListener(_rebuild);
    _strictCtrl.removeListener(_rebuild);
    _echo.dispose();
    _openValue.dispose();
    _strictValue.dispose();
    _openFocus.dispose();
    _strictFocus.dispose();
    _openCtrl.dispose();
    _strictCtrl.dispose();
    super.dispose();
  }

  bool _openPredicate(String? _, String _) => true;

  bool _strictPredicate(String? oldValue, String newValue) {
    if (oldValue == null) return true;
    final bool atBoundary = newValue.isEmpty ||
        newValue.endsWith(' ') ||
        newValue.endsWith('.') ||
        newValue.endsWith('\n');
    if (!atBoundary) {
      _strictRejects += 1;
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return _UhStCard(
      numeral: 'VI',
      title: 'Predicate Gate — shouldChangeUndoStack',
      abstractText:
          'The optional `shouldChangeUndoStack` predicate decides whether a '
          'value change earns a slot in the history. The two panels below '
          'share one editor but feed their values through two UndoHistory '
          'instances: an open one that always accepts, and a strict one '
          'that only accepts when the text ends on a word boundary. Type a '
          'sentence slowly and compare the undo depth of each.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _UhStEditor(controller: _echo),
          const SizedBox(height: 12),
          // Plant both UndoHistory widgets invisibly so their state machines
          // are live. The Focus widget wraps them because UndoHistory requires
          // a focus node.
          UndoHistory<String>(
            controller: _openCtrl,
            focusNode: _openFocus,
            value: _openValue,
            shouldChangeUndoStack: _openPredicate,
            onTriggered: (String v) {
              _echo.text = v;
              _UhStSettings.of(context).onRevert();
            },
            child: Focus(focusNode: _openFocus, child: const SizedBox.shrink()),
          ),
          UndoHistory<String>(
            controller: _strictCtrl,
            focusNode: _strictFocus,
            value: _strictValue,
            shouldChangeUndoStack: _strictPredicate,
            onTriggered: (String v) {
              _echo.text = v;
              _UhStSettings.of(context).onRevert();
            },
            child:
                Focus(focusNode: _strictFocus, child: const SizedBox.shrink()),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _UhStGatePanel(
                  label: 'OPEN — always accept',
                  canUndo: _openCtrl.value.canUndo,
                  canRedo: _openCtrl.value.canRedo,
                  rejected: _openRejects,
                  onUndo: _openCtrl.value.canUndo
                      ? () {
                          _openFocus.requestFocus();
                          _openCtrl.undo();
                        }
                      : null,
                  onRedo: _openCtrl.value.canRedo
                      ? () {
                          _openFocus.requestFocus();
                          _openCtrl.redo();
                        }
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _UhStGatePanel(
                  label: 'STRICT — word-boundary only',
                  canUndo: _strictCtrl.value.canUndo,
                  canRedo: _strictCtrl.value.canRedo,
                  rejected: _strictRejects,
                  onUndo: _strictCtrl.value.canUndo
                      ? () {
                          _strictFocus.requestFocus();
                          _strictCtrl.undo();
                        }
                      : null,
                  onRedo: _strictCtrl.value.canRedo
                      ? () {
                          _strictFocus.requestFocus();
                          _strictCtrl.redo();
                        }
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UhStEditor extends StatelessWidget {
  const _UhStEditor({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _UhStPalette.paper,
        border: Border.all(color: _UhStPalette.navyInk, width: 1.2),
      ),
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        minLines: 3,
        maxLines: 6,
        cursorColor: _UhStPalette.navyInk,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: _UhStPalette.navyDeep,
          fontSize: 13,
          height: 1.55,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          hintText: 'Shared editor — drives both gates.',
          hintStyle: TextStyle(
            fontFamily: 'monospace',
            color: _UhStPalette.slateChalk,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _UhStGatePanel extends StatelessWidget {
  const _UhStGatePanel({
    required this.label,
    required this.canUndo,
    required this.canRedo,
    required this.rejected,
    required this.onUndo,
    required this.onRedo,
  });

  final String label;
  final bool canUndo;
  final bool canRedo;
  final int rejected;
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: _UhStPalette.paperInset,
        border: Border.all(color: _UhStPalette.ruleMid, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _UhStPalette.navyDeep,
              fontSize: 12.6,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'can undo: $canUndo\ncan redo: $canRedo\nrejected: $rejected',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _UhStPalette.navyMid,
              fontSize: 12,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              _UhStToolbarButton(
                  label: 'undo', enabled: canUndo, onPressed: onUndo),
              const SizedBox(width: 6),
              _UhStToolbarButton(
                  label: 'redo', enabled: canRedo, onPressed: onRedo),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Chapter VII — Dual Fields. Two completely independent UndoHistory<String>
//  instances, each with its own controller. Demonstrates that the State is
//  per-widget; nothing leaks between instances.
// ---------------------------------------------------------------------------

class _UhStDualFields extends StatefulWidget {
  const _UhStDualFields();

  @override
  State<_UhStDualFields> createState() => _UhStDualFieldsState();
}

class _UhStDualFieldsState extends State<_UhStDualFields> {
  late final _UhStFieldBundle _left;
  late final _UhStFieldBundle _right;

  @override
  void initState() {
    super.initState();
    _left = _UhStFieldBundle(
      initial: 'left seed',
      focusLabel: 'uhst-dual-left',
      onRebuild: _rebuild,
    );
    _right = _UhStFieldBundle(
      initial: 'right seed',
      focusLabel: 'uhst-dual-right',
      onRebuild: _rebuild,
    );
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _left.dispose();
    _right.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _UhStCard(
      numeral: 'VII',
      title: 'Dual Fields — two States, two stacks',
      abstractText:
          'Every UndoHistory<T> has its own UndoHistoryState<T>. When you '
          'need independent undo journals (for example, two text fields or '
          'two drawing boards in the same page), allocate one controller per '
          'field. The panels below have fully isolated histories: undoing on '
          'the left does not affect the right.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: _UhStDualPanel(title: 'LEFT', bundle: _left)),
          const SizedBox(width: 14),
          Expanded(child: _UhStDualPanel(title: 'RIGHT', bundle: _right)),
        ],
      ),
    );
  }
}

class _UhStFieldBundle {
  _UhStFieldBundle({
    required String initial,
    required String focusLabel,
    required this.onRebuild,
  })  : text = TextEditingController(text: initial),
        value = ValueNotifier<String>(initial),
        focus = FocusNode(debugLabel: focusLabel),
        controller = UndoHistoryController() {
    text.addListener(_syncFromText);
    controller.addListener(onRebuild);
  }

  final TextEditingController text;
  final ValueNotifier<String> value;
  final FocusNode focus;
  final UndoHistoryController controller;
  final VoidCallback onRebuild;
  int commits = 0;

  void _syncFromText() {
    if (value.value != text.text) {
      value.value = text.text;
      commits += 1;
    }
  }

  void dispose() {
    text.removeListener(_syncFromText);
    controller.removeListener(onRebuild);
    text.dispose();
    value.dispose();
    focus.dispose();
    controller.dispose();
  }
}

class _UhStDualPanel extends StatelessWidget {
  const _UhStDualPanel({required this.title, required this.bundle});

  final String title;
  final _UhStFieldBundle bundle;

  @override
  Widget build(BuildContext context) {
    return UndoHistory<String>(
      controller: bundle.controller,
      focusNode: bundle.focus,
      value: bundle.value,
      onTriggered: (String v) {
        bundle.text.text = v;
        _UhStSettings.of(context).onRevert();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        decoration: BoxDecoration(
          color: _UhStPalette.paperInset,
          border: Border.all(color: _UhStPalette.ruleMid, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: _UhStPalette.navyDeep,
                    fontSize: 12.4,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
                const Spacer(),
                _UhStBadge(
                  label: 'commits ${bundle.commits}',
                  tone: _UhStPalette.navyInk,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: _UhStPalette.paper,
                border: Border.all(color: _UhStPalette.navyInk, width: 1),
              ),
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: bundle.text,
                focusNode: bundle.focus,
                minLines: 2,
                maxLines: 4,
                cursorColor: _UhStPalette.navyInk,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: _UhStPalette.navyDeep,
                  fontSize: 13,
                  height: 1.55,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                _UhStToolbarButton(
                  label: 'undo',
                  enabled: bundle.controller.value.canUndo,
                  onPressed: bundle.controller.value.canUndo
                      ? () {
                          bundle.focus.requestFocus();
                          bundle.controller.undo();
                        }
                      : null,
                ),
                const SizedBox(width: 6),
                _UhStToolbarButton(
                  label: 'redo',
                  enabled: bundle.controller.value.canRedo,
                  onPressed: bundle.controller.value.canRedo
                      ? () {
                          bundle.focus.requestFocus();
                          bundle.controller.redo();
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Chapter VIII — Epilogue. Composition recipes and performance notes, closing
//  the notebook with a signed-off colophon.
// ---------------------------------------------------------------------------

class _UhStEpilogue extends StatelessWidget {
  const _UhStEpilogue();

  @override
  Widget build(BuildContext context) {
    return _UhStCard(
      numeral: 'VIII',
      title: 'Epilogue — recipes, tips, colophon',
      abstractText:
          'A handful of recipes for working with UndoHistory<T> and '
          'UndoHistoryState<T> in anger. None of them require reaching into '
          'the State — they all go through the controller and the '
          'ValueNotifier, which is the supported public surface.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _UhStSectionLabel('Recipe 01 — wire an EditableText'),
          _UhStCodeBlock(
            code: 'final TextEditingController text = TextEditingController();\n'
                'final FocusNode focus = FocusNode();\n'
                'final UndoHistoryController history = UndoHistoryController();\n'
                '\n'
                'UndoHistory<TextEditingValue>(\n'
                '  value: text,\n'
                '  controller: history,\n'
                '  focusNode: focus,\n'
                '  onTriggered: (v) => text.value = v,\n'
                '  child: TextField(\n'
                '    controller: text,\n'
                '    focusNode: focus,\n'
                '  ),\n'
                ')',
          ),
          const SizedBox(height: 14),
          const _UhStSectionLabel('Recipe 02 — custom data type'),
          _UhStCodeBlock(
            code: 'final ValueNotifier<AppDoc> doc = ValueNotifier<AppDoc>(AppDoc.empty());\n'
                'final FocusNode focus = FocusNode();\n'
                'final UndoHistoryController ctrl = UndoHistoryController();\n'
                '\n'
                'UndoHistory<AppDoc>(\n'
                '  value: doc,\n'
                '  controller: ctrl,\n'
                '  focusNode: focus,\n'
                '  onTriggered: (AppDoc prev) => doc.value = prev,\n'
                '  shouldChangeUndoStack: (AppDoc? o, AppDoc n) => o == null || n.isStableSnapshot,\n'
                '  undoStackModifier: (AppDoc n) => n.stripTransient(),\n'
                '  child: DocEditor(doc: doc, focusNode: focus),\n'
                ')',
          ),
          const SizedBox(height: 14),
          const _UhStSectionLabel('Recipe 03 — drive a toolbar from the controller'),
          _UhStCodeBlock(
            code: 'ValueListenableBuilder<UndoHistoryValue>(\n'
                '  valueListenable: history,\n'
                '  builder: (context, v, _) => Row(\n'
                '    children: [\n'
                '      IconButton(\n'
                '        icon: const Icon(Icons.undo),\n'
                '        onPressed: v.canUndo ? history.undo : null,\n'
                '      ),\n'
                '      IconButton(\n'
                '        icon: const Icon(Icons.redo),\n'
                '        onPressed: v.canRedo ? history.redo : null,\n'
                '      ),\n'
                '    ],\n'
                '  ),\n'
                ')',
          ),
          const SizedBox(height: 14),
          const _UhStSectionLabel('Performance'),
          const _UhStBullet(
            text: 'The internal push is throttled by 500 ms; a tight typing '
                'burst generates only a small number of snapshots.',
          ),
          const _UhStBullet(
            text: 'If T is expensive to copy, use `undoStackModifier` to push '
                'a cheaper representation onto the stack.',
          ),
          const _UhStBullet(
            text: 'shouldChangeUndoStack runs on every ValueNotifier '
                'notification — keep it cheap.',
          ),
          const SizedBox(height: 14),
          const _UhStSectionLabel('Cautions'),
          const _UhStBullet(
            text: 'Do not mutate the value during onTriggered; UndoHistory '
                'asserts that widget.value.value equals the value it just '
                'pushed back.',
          ),
          const _UhStBullet(
            text: 'Changing widget.value identity clears the stack (see '
                'didUpdateWidget). Keep the ValueNotifier stable across '
                'rebuilds.',
          ),
          const _UhStBullet(
            text: 'Keep a long-lived reference to the controller, not the '
                'State. The State is @visibleForTesting.',
          ),
          const SizedBox(height: 18),
          _UhStColophon(),
        ],
      ),
    );
  }
}

class _UhStCodeBlock extends StatelessWidget {
  const _UhStCodeBlock({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _UhStPalette.navyDeep,
        border: Border.all(color: _UhStPalette.navyInk, width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            color: _UhStPalette.mustardSoft,
            fontSize: 12.3,
            height: 1.55,
          ),
        ),
      ),
    );
  }
}

class _UhStBullet extends StatelessWidget {
  const _UhStBullet({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6, right: 10),
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: _UhStPalette.mustardDeep,
              shape: BoxShape.rectangle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _UhStPalette.navyMid,
                fontSize: 12.3,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UhStColophon extends StatelessWidget {
  const _UhStColophon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: _UhStPalette.paperWarm,
        border: Border.all(color: _UhStPalette.navyDeep, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _UhStPalette.sealRed,
                  shape: BoxShape.circle,
                  border: Border.all(color: _UhStPalette.navyDeep, width: 1.4),
                ),
                child: const Text(
                  'UH',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _UhStPalette.paper,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'COLOPHON',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _UhStPalette.navyDeep,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'This notebook was set by hand in the monospace cream-and-navy '
            'style of the Tom workspace field books. Every scenario draws a '
            'live UndoHistory<T> widget and exercises its State through the '
            'public controller, never through the @visibleForTesting surface. '
            'Bound in brown leather with gold-thread double stitching; '
            'margin ruled in two reds.',
            style: TextStyle(
              fontFamily: 'monospace',
              color: _UhStPalette.navyMid,
              fontSize: 12.2,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
//  Keyboard shortcuts note (for readers who read the source): because the
//  UndoHistory widget already installs Actions for UndoTextIntent and
//  RedoTextIntent, system-default shortcuts (Ctrl/Cmd+Z, Ctrl/Cmd+Shift+Z
//  or Ctrl+Y) are wired through the WidgetsApp default shortcut map without
//  any extra code here. The Actions installed by UndoHistoryState.build() are
//  overridable, so an outer Actions widget can replace or decorate them.
// ---------------------------------------------------------------------------

// End of notebook.
