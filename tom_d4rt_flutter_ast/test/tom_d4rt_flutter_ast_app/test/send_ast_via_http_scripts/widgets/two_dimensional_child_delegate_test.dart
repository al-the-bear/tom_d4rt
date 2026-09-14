// D4rt AST harness script — Deep visual study of TwoDimensionalChildDelegate.
//
// This file is NOT a flutter_test file. There is no main(), no runApp() and
// no WidgetTester. The AST harness mounts the top-level `build(BuildContext)`
// function and expects a MaterialApp back.
//
// TwoDimensionalChildDelegate is the ABSTRACT base class every 2D scroll view
// delegate in Flutter extends (TwoDimensionalChildBuilderDelegate and
// TwoDimensionalChildListDelegate being the two stock subclasses). Subclasses
// MUST override:
//
//   Widget? build(BuildContext context, ChildVicinity vicinity);
//   bool shouldRebuild(covariant TwoDimensionalChildDelegate oldDelegate);
//
// The demo below showcases the abstract class by authoring hand-rolled
// concrete subclasses (a chessboard delegate, a Go board delegate and a
// "drift" delegate that animates piece positions via shouldRebuild). The
// chessboard and Go board share a re-authored minimal 2D viewport surface so
// the viewer can see how the SAME viewport pipes two unrelated delegates.
//
// Theme — classic chess: ivory #F0D9B5, ebony #B58863, deep green #586E26,
// jade #8FBC8F on a parchment canvas.

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PALETTE
// ─────────────────────────────────────────────────────────────────────────────

const Color _twoDDelIvory = Color(0xFFF0D9B5);
const Color _twoDDelEbony = Color(0xFFB58863);
const Color _twoDDelDeepGreen = Color(0xFF586E26);
const Color _twoDDelJade = Color(0xFF8FBC8F);
const Color _twoDDelParchment = Color(0xFFFBF3DE);
const Color _twoDDelInk = Color(0xFF2A2017);
const Color _twoDDelRust = Color(0xFFA0522D);
const Color _twoDDelSepia = Color(0xFF5D4037);
const Color _twoDDelGoBoard = Color(0xFFE6C36F);
const Color _twoDDelGoLines = Color(0xFF3E2A14);
const Color _twoDDelCrimson = Color(0xFF8B2635);
const Color _twoDDelGold = Color(0xFFD4AF37);

// ─────────────────────────────────────────────────────────────────────────────
// ENTRY POINT
// ─────────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  debugPrint('[twoDDel] mounting TwoDimensionalChildDelegate deep demo');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TwoDimensionalChildDelegate — abstract anatomy',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _twoDDelParchment,
      colorScheme: const ColorScheme.light(
        primary: _twoDDelDeepGreen,
        onPrimary: _twoDDelParchment,
        secondary: _twoDDelRust,
        onSecondary: _twoDDelParchment,
        surface: _twoDDelIvory,
        onSurface: _twoDDelInk,
      ),
      fontFamily: 'serif',
    ),
    home: const _TwoDDelHome(),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// HOME PAGE — owns top-level interactive state
// ─────────────────────────────────────────────────────────────────────────────

enum _TwoDDelStartingPosition { standard, chess960, endgamePuzzle }

enum _TwoDDelBoardFlavor { chess, go }

class _TwoDDelHome extends StatefulWidget {
  const _TwoDDelHome();

  @override
  State<_TwoDDelHome> createState() => _TwoDDelHomeState();
}

class _TwoDDelHomeState extends State<_TwoDDelHome>
    with TickerProviderStateMixin {
  _TwoDDelStartingPosition _position = _TwoDDelStartingPosition.standard;
  _TwoDDelBoardFlavor _flavor = _TwoDDelBoardFlavor.chess;
  bool _showCoords = true;
  bool _jadeHighlights = true;
  int _driftTick = 0;
  ChildVicinity? _inspected;

  late final AnimationController _driftController;

  @override
  void initState() {
    super.initState();
    _driftController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _driftController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _driftTick = (_driftTick + 1) % 8;
        });
        _driftController.forward(from: 0);
      }
    });
    _driftController.forward();
    debugPrint('[twoDDel] drift animator armed (3s period, 8-step cycle)');
  }

  @override
  void dispose() {
    _driftController.dispose();
    super.dispose();
  }

  void _setPosition(_TwoDDelStartingPosition p) {
    setState(() {
      _position = p;
      _inspected = null;
      debugPrint('[twoDDel] starting position set to $p');
    });
  }

  void _setFlavor(_TwoDDelBoardFlavor f) {
    setState(() {
      _flavor = f;
      _inspected = null;
      debugPrint('[twoDDel] board flavor switched to $f');
    });
  }

  void _toggleCoords(bool v) {
    setState(() => _showCoords = v);
  }

  void _toggleJade(bool v) {
    setState(() => _jadeHighlights = v);
  }

  void _inspect(ChildVicinity v) {
    setState(() {
      _inspected = v;
      debugPrint('[twoDDel] inspected vicinity xIndex=${v.xIndex} yIndex=${v.yIndex}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _twoDDelDeepGreen,
        foregroundColor: _twoDDelParchment,
        elevation: 0,
        title: const Text(
          'TwoDimensionalChildDelegate',
          style: TextStyle(
            fontFamily: 'serif',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[_twoDDelGold, _twoDDelRust, _twoDDelGold],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        children: <Widget>[
          const _TwoDDelPreambleCard(),
          const SizedBox(height: 20),
          _TwoDDelControlsStrip(
            position: _position,
            flavor: _flavor,
            showCoords: _showCoords,
            jadeHighlights: _jadeHighlights,
            onPositionChanged: _setPosition,
            onFlavorChanged: _setFlavor,
            onCoordsChanged: _toggleCoords,
            onJadeChanged: _toggleJade,
          ),
          const SizedBox(height: 24),
          _TwoDDelSceneSwitcher(
            position: _position,
            flavor: _flavor,
            showCoords: _showCoords,
            jadeHighlights: _jadeHighlights,
            inspected: _inspected,
            onTap: _inspect,
          ),
          const SizedBox(height: 24),
          _TwoDDelCoordinateInspector(
            inspected: _inspected,
            flavor: _flavor,
          ),
          const SizedBox(height: 24),
          _TwoDDelDriftDemo(tick: _driftTick),
          const SizedBox(height: 24),
          const _TwoDDelShouldRebuildNarrator(),
          const SizedBox(height: 24),
          const _TwoDDelAbstractAnatomyCard(),
          const SizedBox(height: 24),
          const _TwoDDelMiniViewportSource(),
          const SizedBox(height: 24),
          const _TwoDDelPieceGlossaryCard(),
          const SizedBox(height: 24),
          const _TwoDDelVicinityGrid(),
          const SizedBox(height: 24),
          const _TwoDDelEpilogue(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PREAMBLE CARD — introduces the abstract class in prose
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelPreambleCard extends StatelessWidget {
  const _TwoDDelPreambleCard();

  @override
  Widget build(BuildContext context) {
    return _TwoDDelFramedPanel(
      ribbon: 'PREAMBLE',
      title: 'The abstract contract behind every 2D scroll view',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _TwoDDelProseParagraph(
            text:
                'TwoDimensionalChildDelegate is the abstract base class behind '
                'every delegate plugged into a TwoDimensionalScrollView. It is a '
                'ChangeNotifier so subclasses can signal piece-by-piece updates '
                'to the underlying RenderTwoDimensionalViewport without having '
                'to swap the whole delegate instance.',
          ),
          SizedBox(height: 12),
          _TwoDDelProseParagraph(
            text:
                'Subclasses must implement two methods. The first, build, '
                'receives a ChildVicinity — an (xIndex, yIndex) pair — and '
                'returns the widget that should occupy that cell, or null if '
                'no cell exists there. The second, shouldRebuild, is called '
                'when a new delegate is handed to the viewport; it must return '
                'true when the new delegate would emit different widgets than '
                'the previous one.',
          ),
          SizedBox(height: 12),
          _TwoDDelProseParagraph(
            text:
                'The stock subclasses — TwoDimensionalChildBuilderDelegate and '
                'TwoDimensionalChildListDelegate — cover most callsites, but '
                'writing your own subclass pays off when the mapping from '
                'vicinity to widget is opinionated enough that a plain builder '
                'callback would drown in conditionals. A chess board is the '
                'canonical case: every (file, rank) has a deterministic square '
                'colour and sometimes a piece, and the delegate itself is the '
                'most natural place for that domain logic to live.',
          ),
          SizedBox(height: 14),
          _TwoDDelContractBadgeRow(),
        ],
      ),
    );
  }
}

class _TwoDDelContractBadgeRow extends StatelessWidget {
  const _TwoDDelContractBadgeRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const <Widget>[
        _TwoDDelContractBadge(
          label: 'extends ChangeNotifier',
          hint: 'notifyListeners rebuilds viewport',
        ),
        _TwoDDelContractBadge(
          label: 'build(context, vicinity)',
          hint: 'required override',
        ),
        _TwoDDelContractBadge(
          label: 'shouldRebuild(old)',
          hint: 'covariant, required',
        ),
        _TwoDDelContractBadge(
          label: 'covariant ChildVicinity',
          hint: 'subclasses may narrow',
        ),
      ],
    );
  }
}

class _TwoDDelContractBadge extends StatelessWidget {
  const _TwoDDelContractBadge({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _twoDDelIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _twoDDelSepia.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _twoDDelSepia,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            hint,
            style: TextStyle(
              fontSize: 11,
              color: _twoDDelInk.withValues(alpha: 0.7),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CONTROLS STRIP — position picker, flavor toggle, coord toggle, jade toggle
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelControlsStrip extends StatelessWidget {
  const _TwoDDelControlsStrip({
    required this.position,
    required this.flavor,
    required this.showCoords,
    required this.jadeHighlights,
    required this.onPositionChanged,
    required this.onFlavorChanged,
    required this.onCoordsChanged,
    required this.onJadeChanged,
  });

  final _TwoDDelStartingPosition position;
  final _TwoDDelBoardFlavor flavor;
  final bool showCoords;
  final bool jadeHighlights;
  final ValueChanged<_TwoDDelStartingPosition> onPositionChanged;
  final ValueChanged<_TwoDDelBoardFlavor> onFlavorChanged;
  final ValueChanged<bool> onCoordsChanged;
  final ValueChanged<bool> onJadeChanged;

  @override
  Widget build(BuildContext context) {
    return _TwoDDelFramedPanel(
      ribbon: 'CONTROLS',
      title: 'Reconfigure the delegate live',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 20,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              _TwoDDelLabeledControl(
                label: 'Starting position',
                child: DropdownButton<_TwoDDelStartingPosition>(
                  value: position,
                  dropdownColor: _twoDDelIvory,
                  style: const TextStyle(
                    color: _twoDDelInk,
                    fontSize: 13,
                    fontFamily: 'serif',
                  ),
                  items: const <DropdownMenuItem<_TwoDDelStartingPosition>>[
                    DropdownMenuItem<_TwoDDelStartingPosition>(
                      value: _TwoDDelStartingPosition.standard,
                      child: Text('Standard'),
                    ),
                    DropdownMenuItem<_TwoDDelStartingPosition>(
                      value: _TwoDDelStartingPosition.chess960,
                      child: Text('Chess960 (Fischer)'),
                    ),
                    DropdownMenuItem<_TwoDDelStartingPosition>(
                      value: _TwoDDelStartingPosition.endgamePuzzle,
                      child: Text('Endgame puzzle'),
                    ),
                  ],
                  onChanged: (_TwoDDelStartingPosition? v) {
                    if (v != null) onPositionChanged(v);
                  },
                ),
              ),
              _TwoDDelLabeledControl(
                label: 'Delegate flavor',
                child: SegmentedButton<_TwoDDelBoardFlavor>(
                  segments: const <ButtonSegment<_TwoDDelBoardFlavor>>[
                    ButtonSegment<_TwoDDelBoardFlavor>(
                      value: _TwoDDelBoardFlavor.chess,
                      label: Text('Chess'),
                    ),
                    ButtonSegment<_TwoDDelBoardFlavor>(
                      value: _TwoDDelBoardFlavor.go,
                      label: Text('Go'),
                    ),
                  ],
                  selected: <_TwoDDelBoardFlavor>{flavor},
                  onSelectionChanged: (Set<_TwoDDelBoardFlavor> set) {
                    onFlavorChanged(set.first);
                  },
                ),
              ),
              _TwoDDelLabeledControl(
                label: 'Coordinate labels',
                child: Switch(
                  value: showCoords,
                  activeThumbColor: _twoDDelDeepGreen,
                  onChanged: onCoordsChanged,
                ),
              ),
              _TwoDDelLabeledControl(
                label: 'Jade highlights',
                child: Switch(
                  value: jadeHighlights,
                  activeThumbColor: _twoDDelJade,
                  onChanged: onJadeChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Every toggle produces a brand-new delegate instance. The '
            'TwoDimensionalScrollView handing the new delegate to the viewport '
            'asks shouldRebuild(oldDelegate); only a true return rebuilds '
            'affected cells.',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: _twoDDelInk.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDDelLabeledControl extends StatelessWidget {
  const _TwoDDelLabeledControl({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: _twoDDelSepia.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SCENE SWITCHER — shows the chessboard or go board via the same mini viewport
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelSceneSwitcher extends StatelessWidget {
  const _TwoDDelSceneSwitcher({
    required this.position,
    required this.flavor,
    required this.showCoords,
    required this.jadeHighlights,
    required this.inspected,
    required this.onTap,
  });

  final _TwoDDelStartingPosition position;
  final _TwoDDelBoardFlavor flavor;
  final bool showCoords;
  final bool jadeHighlights;
  final ChildVicinity? inspected;
  final ValueChanged<ChildVicinity> onTap;

  @override
  Widget build(BuildContext context) {
    final TwoDimensionalChildDelegate delegate = flavor == _TwoDDelBoardFlavor.chess
        ? _TwoDDelChessboardDelegate(
            position: position,
            showCoords: showCoords,
            jadeHighlights: jadeHighlights,
            inspected: inspected,
          )
        : _TwoDDelGoBoardDelegate(
            showCoords: showCoords,
            inspected: inspected,
            jadeHighlights: jadeHighlights,
          );

    final String caption = flavor == _TwoDDelBoardFlavor.chess
        ? 'Chessboard rendered through _TwoDDelChessboardDelegate '
            '(extends TwoDimensionalChildDelegate).'
        : 'Go board rendered through _TwoDDelGoBoardDelegate — the same '
            'abstract contract, a very different visual grammar.';

    final int xCount = flavor == _TwoDDelBoardFlavor.chess ? 8 : 9;
    final int yCount = flavor == _TwoDDelBoardFlavor.chess ? 8 : 9;

    return _TwoDDelFramedPanel(
      ribbon: flavor == _TwoDDelBoardFlavor.chess ? 'SCENE 01' : 'SCENE 02',
      title: flavor == _TwoDDelBoardFlavor.chess
          ? 'Chessboard delegate in action'
          : 'Alternate delegate — Go board',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _TwoDDelProseParagraph(text: caption),
          const SizedBox(height: 14),
          Center(
            child: _TwoDDelMiniViewport(
              delegate: delegate,
              xCount: xCount,
              yCount: yCount,
              cellSize: flavor == _TwoDDelBoardFlavor.chess ? 38 : 32,
              onTap: onTap,
              frameColor: flavor == _TwoDDelBoardFlavor.chess
                  ? _twoDDelSepia
                  : _twoDDelGoLines,
              backdrop: flavor == _TwoDDelBoardFlavor.chess
                  ? _twoDDelIvory
                  : _twoDDelGoBoard,
            ),
          ),
          const SizedBox(height: 12),
          _TwoDDelDelegateHeader(flavor: flavor),
        ],
      ),
    );
  }
}

class _TwoDDelDelegateHeader extends StatelessWidget {
  const _TwoDDelDelegateHeader({required this.flavor});

  final _TwoDDelBoardFlavor flavor;

  @override
  Widget build(BuildContext context) {
    final String name = flavor == _TwoDDelBoardFlavor.chess
        ? '_TwoDDelChessboardDelegate'
        : '_TwoDDelGoBoardDelegate';
    final String parent = flavor == _TwoDDelBoardFlavor.chess
        ? 'extends TwoDimensionalChildDelegate'
        : 'extends TwoDimensionalChildDelegate';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _twoDDelIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _twoDDelSepia.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.account_tree, size: 18, color: _twoDDelDeepGreen),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _twoDDelInk,
                  ),
                ),
                Text(
                  parent,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: _twoDDelSepia,
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

// ─────────────────────────────────────────────────────────────────────────────
// MINI 2D VIEWPORT — a hand-authored StatelessWidget that consumes a
// TwoDimensionalChildDelegate the same way TwoDimensionalScrollView /
// TwoDimensionalViewport / RenderTwoDimensionalViewport do: ask the delegate
// for build(context, ChildVicinity(x, y)) for every visible cell, wrap each
// returned widget in a RepaintBoundary-equivalent border and position it via
// the (xIndex, yIndex) pair. The real SDK viewport adds scrolling, culling
// and caching; this miniature keeps the spirit (delegate contract) while
// standing on fixed-size box children.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelMiniViewport extends StatelessWidget {
  const _TwoDDelMiniViewport({
    required this.delegate,
    required this.xCount,
    required this.yCount,
    required this.cellSize,
    required this.onTap,
    required this.frameColor,
    required this.backdrop,
  });

  final TwoDimensionalChildDelegate delegate;
  final int xCount;
  final int yCount;
  final double cellSize;
  final ValueChanged<ChildVicinity> onTap;
  final Color frameColor;
  final Color backdrop;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backdrop,
        border: Border.all(color: frameColor, width: 2),
        borderRadius: BorderRadius.circular(6),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _twoDDelInk.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(yCount, (int y) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(xCount, (int x) {
              final ChildVicinity vicinity =
                  ChildVicinity(xIndex: x, yIndex: y);
              final Widget? cell = delegate.build(context, vicinity);
              return GestureDetector(
                onTap: () => onTap(vicinity),
                child: SizedBox(
                  width: cellSize,
                  height: cellSize,
                  child: cell ?? const SizedBox.shrink(),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CHESS DOMAIN MODEL — a piece is a glyph + owner.
// ─────────────────────────────────────────────────────────────────────────────

enum _TwoDDelPieceKind { king, queen, rook, bishop, knight, pawn }

enum _TwoDDelPieceOwner { white, black }

class _TwoDDelPiece {
  const _TwoDDelPiece(this.kind, this.owner);

  final _TwoDDelPieceKind kind;
  final _TwoDDelPieceOwner owner;

  String get glyph {
    switch (owner) {
      case _TwoDDelPieceOwner.white:
        switch (kind) {
          case _TwoDDelPieceKind.king:
            return '\u2654';
          case _TwoDDelPieceKind.queen:
            return '\u2655';
          case _TwoDDelPieceKind.rook:
            return '\u2656';
          case _TwoDDelPieceKind.bishop:
            return '\u2657';
          case _TwoDDelPieceKind.knight:
            return '\u2658';
          case _TwoDDelPieceKind.pawn:
            return '\u2659';
        }
      case _TwoDDelPieceOwner.black:
        switch (kind) {
          case _TwoDDelPieceKind.king:
            return '\u265A';
          case _TwoDDelPieceKind.queen:
            return '\u265B';
          case _TwoDDelPieceKind.rook:
            return '\u265C';
          case _TwoDDelPieceKind.bishop:
            return '\u265D';
          case _TwoDDelPieceKind.knight:
            return '\u265E';
          case _TwoDDelPieceKind.pawn:
            return '\u265F';
        }
    }
  }

  Color get color => owner == _TwoDDelPieceOwner.white
      ? const Color(0xFFFFFDF4)
      : const Color(0xFF1D140A);
}

// Build a position map keyed by ChildVicinity.
Map<ChildVicinity, _TwoDDelPiece> _twoDDelBuildPosition(
  _TwoDDelStartingPosition p,
) {
  final Map<ChildVicinity, _TwoDDelPiece> m = <ChildVicinity, _TwoDDelPiece>{};
  switch (p) {
    case _TwoDDelStartingPosition.standard:
      _twoDDelStandardLayout(m);
      break;
    case _TwoDDelStartingPosition.chess960:
      _twoDDelChess960Layout(m);
      break;
    case _TwoDDelStartingPosition.endgamePuzzle:
      _twoDDelEndgameLayout(m);
      break;
  }
  return m;
}

void _twoDDelStandardLayout(Map<ChildVicinity, _TwoDDelPiece> m) {
  const List<_TwoDDelPieceKind> backRank = <_TwoDDelPieceKind>[
    _TwoDDelPieceKind.rook,
    _TwoDDelPieceKind.knight,
    _TwoDDelPieceKind.bishop,
    _TwoDDelPieceKind.queen,
    _TwoDDelPieceKind.king,
    _TwoDDelPieceKind.bishop,
    _TwoDDelPieceKind.knight,
    _TwoDDelPieceKind.rook,
  ];
  for (int x = 0; x < 8; x++) {
    m[ChildVicinity(xIndex: x, yIndex: 0)] =
        _TwoDDelPiece(backRank[x], _TwoDDelPieceOwner.black);
    m[ChildVicinity(xIndex: x, yIndex: 1)] =
        const _TwoDDelPiece(_TwoDDelPieceKind.pawn, _TwoDDelPieceOwner.black);
    m[ChildVicinity(xIndex: x, yIndex: 6)] =
        const _TwoDDelPiece(_TwoDDelPieceKind.pawn, _TwoDDelPieceOwner.white);
    m[ChildVicinity(xIndex: x, yIndex: 7)] =
        _TwoDDelPiece(backRank[x], _TwoDDelPieceOwner.white);
  }
}

void _twoDDelChess960Layout(Map<ChildVicinity, _TwoDDelPiece> m) {
  // One canonical Chess960 starting array (RNBQKBNR scrambled): BQNBRKRN.
  const List<_TwoDDelPieceKind> fischer = <_TwoDDelPieceKind>[
    _TwoDDelPieceKind.bishop,
    _TwoDDelPieceKind.queen,
    _TwoDDelPieceKind.knight,
    _TwoDDelPieceKind.bishop,
    _TwoDDelPieceKind.rook,
    _TwoDDelPieceKind.king,
    _TwoDDelPieceKind.rook,
    _TwoDDelPieceKind.knight,
  ];
  for (int x = 0; x < 8; x++) {
    m[ChildVicinity(xIndex: x, yIndex: 0)] =
        _TwoDDelPiece(fischer[x], _TwoDDelPieceOwner.black);
    m[ChildVicinity(xIndex: x, yIndex: 1)] =
        const _TwoDDelPiece(_TwoDDelPieceKind.pawn, _TwoDDelPieceOwner.black);
    m[ChildVicinity(xIndex: x, yIndex: 6)] =
        const _TwoDDelPiece(_TwoDDelPieceKind.pawn, _TwoDDelPieceOwner.white);
    m[ChildVicinity(xIndex: x, yIndex: 7)] =
        _TwoDDelPiece(fischer[x], _TwoDDelPieceOwner.white);
  }
}

void _twoDDelEndgameLayout(Map<ChildVicinity, _TwoDDelPiece> m) {
  // Minimal K+R vs K endgame — white king on e1, white rook on a7, black king on e8.
  m[const ChildVicinity(xIndex: 4, yIndex: 7)] =
      const _TwoDDelPiece(_TwoDDelPieceKind.king, _TwoDDelPieceOwner.white);
  m[const ChildVicinity(xIndex: 0, yIndex: 1)] =
      const _TwoDDelPiece(_TwoDDelPieceKind.rook, _TwoDDelPieceOwner.white);
  m[const ChildVicinity(xIndex: 4, yIndex: 0)] =
      const _TwoDDelPiece(_TwoDDelPieceKind.king, _TwoDDelPieceOwner.black);
  // A stray black pawn stranded on c3 to make it a study.
  m[const ChildVicinity(xIndex: 2, yIndex: 5)] =
      const _TwoDDelPiece(_TwoDDelPieceKind.pawn, _TwoDDelPieceOwner.black);
}

// ─────────────────────────────────────────────────────────────────────────────
// _TwoDDelChessboardDelegate — concrete subclass of TwoDimensionalChildDelegate.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelChessboardDelegate extends TwoDimensionalChildDelegate {
  _TwoDDelChessboardDelegate({
    required this.position,
    required this.showCoords,
    required this.jadeHighlights,
    required this.inspected,
  }) : pieces = _twoDDelBuildPosition(position);

  final _TwoDDelStartingPosition position;
  final bool showCoords;
  final bool jadeHighlights;
  final ChildVicinity? inspected;
  final Map<ChildVicinity, _TwoDDelPiece> pieces;

  @override
  Widget? build(BuildContext context, covariant ChildVicinity vicinity) {
    // xIndex is the file (0 = a, 7 = h); yIndex is the rank from the top.
    if (vicinity.xIndex < 0 || vicinity.xIndex > 7) return null;
    if (vicinity.yIndex < 0 || vicinity.yIndex > 7) return null;
    final bool isDark = (vicinity.xIndex + vicinity.yIndex).isOdd;
    final _TwoDDelPiece? piece = pieces[vicinity];
    final bool isInspected = inspected == vicinity;
    return _TwoDDelChessSquare(
      square: isDark ? _twoDDelEbony : _twoDDelIvory,
      piece: piece,
      coord: showCoords ? _twoDDelChessCoord(vicinity) : null,
      highlighted: isInspected && jadeHighlights,
    );
  }

  @override
  bool shouldRebuild(covariant _TwoDDelChessboardDelegate oldDelegate) {
    return oldDelegate.position != position ||
        oldDelegate.showCoords != showCoords ||
        oldDelegate.jadeHighlights != jadeHighlights ||
        oldDelegate.inspected != inspected;
  }
}

String _twoDDelChessCoord(ChildVicinity v) {
  const String files = 'abcdefgh';
  final String file = files[v.xIndex];
  final int rank = 8 - v.yIndex;
  return '$file$rank';
}

class _TwoDDelChessSquare extends StatelessWidget {
  const _TwoDDelChessSquare({
    required this.square,
    required this.piece,
    required this.coord,
    required this.highlighted,
  });

  final Color square;
  final _TwoDDelPiece? piece;
  final String? coord;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: square,
        border: highlighted
            ? Border.all(color: _twoDDelJade, width: 3)
            : Border.all(color: _twoDDelSepia.withValues(alpha: 0.15), width: 0.5),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          if (coord != null)
            Positioned(
              left: 2,
              top: 2,
              child: Text(
                coord!,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: square == _twoDDelIvory
                      ? _twoDDelSepia.withValues(alpha: 0.8)
                      : _twoDDelParchment.withValues(alpha: 0.8),
                ),
              ),
            ),
          if (piece != null)
            Center(
              child: Text(
                piece!.glyph,
                style: TextStyle(
                  fontSize: 26,
                  color: piece!.color,
                  shadows: <Shadow>[
                    Shadow(
                      color: _twoDDelInk.withValues(alpha: 0.4),
                      blurRadius: 1.5,
                      offset: const Offset(0.5, 0.5),
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

// ─────────────────────────────────────────────────────────────────────────────
// _TwoDDelGoBoardDelegate — second concrete subclass, 9x9 intersection board.
// ─────────────────────────────────────────────────────────────────────────────

enum _TwoDDelStone { none, black, white }

class _TwoDDelGoBoardDelegate extends TwoDimensionalChildDelegate {
  _TwoDDelGoBoardDelegate({
    required this.showCoords,
    required this.inspected,
    required this.jadeHighlights,
  });

  final bool showCoords;
  final ChildVicinity? inspected;
  final bool jadeHighlights;

  // A seeded mid-game position — deterministic so the delegate stays pure.
  // ChildVicinity overrides == / hashCode so the map cannot be const; we
  // build it once at class init and expose it as a static final.
  static final Map<ChildVicinity, _TwoDDelStone> _stones =
      <ChildVicinity, _TwoDDelStone>{
    const ChildVicinity(xIndex: 2, yIndex: 2): _TwoDDelStone.black,
    const ChildVicinity(xIndex: 2, yIndex: 6): _TwoDDelStone.white,
    const ChildVicinity(xIndex: 6, yIndex: 2): _TwoDDelStone.white,
    const ChildVicinity(xIndex: 6, yIndex: 6): _TwoDDelStone.black,
    const ChildVicinity(xIndex: 4, yIndex: 4): _TwoDDelStone.black,
    const ChildVicinity(xIndex: 3, yIndex: 4): _TwoDDelStone.white,
    const ChildVicinity(xIndex: 5, yIndex: 4): _TwoDDelStone.white,
    const ChildVicinity(xIndex: 4, yIndex: 3): _TwoDDelStone.black,
    const ChildVicinity(xIndex: 4, yIndex: 5): _TwoDDelStone.black,
  };

  @override
  Widget? build(BuildContext context, covariant ChildVicinity vicinity) {
    if (vicinity.xIndex < 0 || vicinity.xIndex > 8) return null;
    if (vicinity.yIndex < 0 || vicinity.yIndex > 8) return null;
    final _TwoDDelStone stone = _stones[vicinity] ?? _TwoDDelStone.none;
    final bool isInspected = inspected == vicinity;
    return _TwoDDelGoIntersection(
      vicinity: vicinity,
      stone: stone,
      coord: showCoords ? _twoDDelGoCoord(vicinity) : null,
      highlighted: isInspected && jadeHighlights,
    );
  }

  @override
  bool shouldRebuild(covariant _TwoDDelGoBoardDelegate oldDelegate) {
    return oldDelegate.showCoords != showCoords ||
        oldDelegate.inspected != inspected ||
        oldDelegate.jadeHighlights != jadeHighlights;
  }
}

String _twoDDelGoCoord(ChildVicinity v) {
  const String cols = 'ABCDEFGHJ'; // Go omits I by convention.
  final String col = cols[v.xIndex];
  final int row = 9 - v.yIndex;
  return '$col$row';
}

class _TwoDDelGoIntersection extends StatelessWidget {
  const _TwoDDelGoIntersection({
    required this.vicinity,
    required this.stone,
    required this.coord,
    required this.highlighted,
  });

  final ChildVicinity vicinity;
  final _TwoDDelStone stone;
  final String? coord;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TwoDDelGoCellPainter(
        vicinity: vicinity,
        stone: stone,
        coord: coord,
        highlighted: highlighted,
      ),
    );
  }
}

class _TwoDDelGoCellPainter extends CustomPainter {
  const _TwoDDelGoCellPainter({
    required this.vicinity,
    required this.stone,
    required this.coord,
    required this.highlighted,
  });

  final ChildVicinity vicinity;
  final _TwoDDelStone stone;
  final String? coord;
  final bool highlighted;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _twoDDelGoBoard;
    canvas.drawRect(Offset.zero & size, bg);

    final Paint line = Paint()
      ..color = _twoDDelGoLines
      ..strokeWidth = 1.2;

    // Draw intersection lines — only inward facing so edges look natural.
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final bool hasWest = vicinity.xIndex > 0;
    final bool hasEast = vicinity.xIndex < 8;
    final bool hasNorth = vicinity.yIndex > 0;
    final bool hasSouth = vicinity.yIndex < 8;
    if (hasWest) canvas.drawLine(Offset(0, cy), Offset(cx, cy), line);
    if (hasEast) canvas.drawLine(Offset(cx, cy), Offset(size.width, cy), line);
    if (hasNorth) canvas.drawLine(Offset(cx, 0), Offset(cx, cy), line);
    if (hasSouth) canvas.drawLine(Offset(cx, cy), Offset(cx, size.height), line);

    // Star points (hoshi) on a 9x9 board. Not const because ChildVicinity
    // overrides == / hashCode and therefore can't live inside a const set.
    final Set<ChildVicinity> hoshi = <ChildVicinity>{
      const ChildVicinity(xIndex: 2, yIndex: 2),
      const ChildVicinity(xIndex: 6, yIndex: 2),
      const ChildVicinity(xIndex: 4, yIndex: 4),
      const ChildVicinity(xIndex: 2, yIndex: 6),
      const ChildVicinity(xIndex: 6, yIndex: 6),
    };
    if (hoshi.contains(vicinity)) {
      canvas.drawCircle(Offset(cx, cy), 2.2, Paint()..color = _twoDDelGoLines);
    }

    if (stone != _TwoDDelStone.none) {
      final double r = size.shortestSide * 0.42;
      final Paint stoneFill = Paint()
        ..color = stone == _TwoDDelStone.black
            ? const Color(0xFF0B0A08)
            : const Color(0xFFF8F4E6);
      final Paint stoneEdge = Paint()
        ..color = stone == _TwoDDelStone.black
            ? const Color(0xFF4A3C2A)
            : const Color(0xFFBAA880)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawCircle(Offset(cx, cy), r, stoneFill);
      canvas.drawCircle(Offset(cx, cy), r, stoneEdge);
    }

    if (highlighted) {
      final Paint glow = Paint()
        ..color = _twoDDelJade
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRect(
        Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
        glow,
      );
    }

    if (coord != null) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: coord,
          style: TextStyle(
            fontSize: 7,
            color: _twoDDelGoLines.withValues(alpha: 0.85),
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, const Offset(2, 2));
    }
  }

  @override
  bool shouldRepaint(covariant _TwoDDelGoCellPainter old) =>
      old.stone != stone ||
      old.coord != coord ||
      old.highlighted != highlighted ||
      old.vicinity != vicinity;
}

// ─────────────────────────────────────────────────────────────────────────────
// COORDINATE INSPECTOR — shows vicinity + chess/Go notation for last tap.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelCoordinateInspector extends StatelessWidget {
  const _TwoDDelCoordinateInspector({
    required this.inspected,
    required this.flavor,
  });

  final ChildVicinity? inspected;
  final _TwoDDelBoardFlavor flavor;

  @override
  Widget build(BuildContext context) {
    final ChildVicinity? v = inspected;
    return _TwoDDelFramedPanel(
      ribbon: 'SCENE 05',
      title: 'Coordinate inspector',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _TwoDDelProseParagraph(
            text:
                'Tap any square or intersection above. The delegate does not '
                'need to know that an InkWell was tapped — the parent scene '
                'simply records which ChildVicinity was hit and passes it back '
                'so the delegate can re-render that cell with a jade halo.',
          ),
          const SizedBox(height: 12),
          if (v == null)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _twoDDelIvory,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _twoDDelSepia.withValues(alpha: 0.3)),
              ),
              child: const Text(
                'No cell selected yet — tap a square or intersection above.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          else
            _TwoDDelInspectorCard(vicinity: v, flavor: flavor),
        ],
      ),
    );
  }
}

class _TwoDDelInspectorCard extends StatelessWidget {
  const _TwoDDelInspectorCard({required this.vicinity, required this.flavor});

  final ChildVicinity vicinity;
  final _TwoDDelBoardFlavor flavor;

  @override
  Widget build(BuildContext context) {
    final String notation = flavor == _TwoDDelBoardFlavor.chess
        ? _twoDDelChessCoord(vicinity)
        : _twoDDelGoCoord(vicinity);
    final String compareTo = flavor == _TwoDDelBoardFlavor.chess
        ? 'y=0 is the 8th rank (black back line), y=7 is the 1st rank.'
        : 'y=0 is the top row, y=8 is the bottom row of a 9x9 board.';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _twoDDelIvory,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _twoDDelDeepGreen, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.grid_on, color: _twoDDelDeepGreen),
              const SizedBox(width: 8),
              Text(
                'ChildVicinity(xIndex: ${vicinity.xIndex}, yIndex: ${vicinity.yIndex})',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _twoDDelInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _TwoDDelInspectorRow(
            label: flavor == _TwoDDelBoardFlavor.chess ? 'Algebraic' : 'Board',
            value: notation,
          ),
          _TwoDDelInspectorRow(
            label: 'Sequence index',
            value: '${vicinity.compareTo(ChildVicinity.invalid)}',
          ),
          _TwoDDelInspectorRow(
            label: 'hashCode',
            value: '${vicinity.hashCode}',
          ),
          const SizedBox(height: 8),
          Text(
            'Note: $compareTo',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 12,
              color: _twoDDelInk.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDDelInspectorRow extends StatelessWidget {
  const _TwoDDelInspectorRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _twoDDelSepia.withValues(alpha: 0.85),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: _twoDDelInk,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DRIFT DELEGATE — a third delegate that mutates its piece positions over time,
// driven by a tick counter from the home state. Each tick creates a new
// delegate with shifted coordinates; shouldRebuild returns true whenever the
// tick differs, which is why the viewport reflects the drift at all.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelDriftDelegate extends TwoDimensionalChildDelegate {
  _TwoDDelDriftDelegate({required this.tick});

  final int tick;

  static const List<_TwoDDelPieceKind> _driftKinds = <_TwoDDelPieceKind>[
    _TwoDDelPieceKind.knight,
    _TwoDDelPieceKind.bishop,
    _TwoDDelPieceKind.rook,
    _TwoDDelPieceKind.queen,
  ];

  @override
  Widget? build(BuildContext context, covariant ChildVicinity vicinity) {
    if (vicinity.xIndex < 0 || vicinity.xIndex > 7) return null;
    if (vicinity.yIndex < 0 || vicinity.yIndex > 3) return null;
    final bool isDark = (vicinity.xIndex + vicinity.yIndex).isOdd;
    _TwoDDelPiece? piece;
    for (int i = 0; i < _driftKinds.length; i++) {
      final int driftedX = (i * 2 + tick) % 8;
      final int driftedY = i;
      if (vicinity.xIndex == driftedX && vicinity.yIndex == driftedY) {
        piece = _TwoDDelPiece(
          _driftKinds[i],
          i.isEven ? _TwoDDelPieceOwner.white : _TwoDDelPieceOwner.black,
        );
      }
    }
    return _TwoDDelChessSquare(
      square: isDark ? _twoDDelEbony : _twoDDelIvory,
      piece: piece,
      coord: null,
      highlighted: false,
    );
  }

  @override
  bool shouldRebuild(covariant _TwoDDelDriftDelegate oldDelegate) {
    // A live demonstration: if we returned false here, the viewport would
    // cache the previous build outputs and the pieces would appear frozen.
    return oldDelegate.tick != tick;
  }
}

class _TwoDDelDriftDemo extends StatelessWidget {
  const _TwoDDelDriftDemo({required this.tick});

  final int tick;

  @override
  Widget build(BuildContext context) {
    final TwoDimensionalChildDelegate delegate =
        _TwoDDelDriftDelegate(tick: tick);
    return _TwoDDelFramedPanel(
      ribbon: 'SCENE 04',
      title: 'Dynamic drift — shouldRebuild in motion',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _TwoDDelProseParagraph(
            text:
                'Every 3 seconds the home state bumps a tick counter and rebuilds. '
                'That rebuild hands a brand-new _TwoDDelDriftDelegate to the '
                'viewport. shouldRebuild returns true because the ticks differ, '
                'so the viewport invalidates the cached cells and queries '
                'build(context, vicinity) again — and the pieces march.',
          ),
          const SizedBox(height: 12),
          Center(
            child: _TwoDDelMiniViewport(
              delegate: delegate,
              xCount: 8,
              yCount: 4,
              cellSize: 32,
              onTap: (ChildVicinity _) {},
              frameColor: _twoDDelSepia,
              backdrop: _twoDDelIvory,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              const Icon(Icons.timelapse, size: 16, color: _twoDDelDeepGreen),
              const SizedBox(width: 8),
              Text(
                'Tick: $tick  /  cycle length: 8',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _twoDDelSepia,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHOULD REBUILD NARRATOR — explains why returning true matters.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelShouldRebuildNarrator extends StatelessWidget {
  const _TwoDDelShouldRebuildNarrator();

  @override
  Widget build(BuildContext context) {
    return _TwoDDelFramedPanel(
      ribbon: 'NARRATOR',
      title: 'Why shouldRebuild must tell the truth',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _TwoDDelProseParagraph(
            text:
                'shouldRebuild is consulted whenever the enclosing element tree '
                'reconciles and produces a new delegate instance. If it returns '
                'false, the framework assumes both delegates would emit the '
                'same widget for every vicinity and skips rebuilding cells.',
          ),
          SizedBox(height: 10),
          _TwoDDelProseParagraph(
            text:
                'Return true eagerly if in doubt — false positives cost a '
                'single extra build pass, while false negatives leave stale '
                'widgets on screen and can be maddening to diagnose.',
          ),
          SizedBox(height: 14),
          _TwoDDelScenarioTable(),
        ],
      ),
    );
  }
}

class _TwoDDelScenarioTable extends StatelessWidget {
  const _TwoDDelScenarioTable();

  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = <List<String>>[
      <String>['Same data, same colours', 'false', 'No visible change, save a build'],
      <String>['Piece moved (drift)', 'true', 'Viewport rebuilds affected cells'],
      <String>['Position changed', 'true', 'Full 64-cell rebuild'],
      <String>['Coord toggle', 'true', 'Labels re-render in each cell'],
      <String>['Jade halo toggle', 'true', 'Border re-renders on inspected cell'],
      <String>['Internal theme tweak in app', 'false', 'Delegate itself unchanged'],
    ];
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _twoDDelDeepGreen.withValues(alpha: 0.12),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
          child: Row(
            children: const <Widget>[
              Expanded(flex: 4, child: Text('Change', style: TextStyle(fontWeight: FontWeight.w700))),
              Expanded(flex: 2, child: Text('Return', style: TextStyle(fontWeight: FontWeight.w700))),
              Expanded(flex: 5, child: Text('Consequence', style: TextStyle(fontWeight: FontWeight.w700))),
            ],
          ),
        ),
        ...rows.map((List<String> r) {
          final bool isTrue = r[1] == 'true';
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: _twoDDelSepia.withValues(alpha: 0.15)),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex: 4, child: Text(r[0])),
                Expanded(
                  flex: 2,
                  child: Text(
                    r[1],
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: isTrue ? _twoDDelCrimson : _twoDDelDeepGreen,
                    ),
                  ),
                ),
                Expanded(flex: 5, child: Text(r[2])),
              ],
            ),
          );
        }),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ABSTRACT ANATOMY CARD — a big illustrated method table.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelAbstractAnatomyCard extends StatelessWidget {
  const _TwoDDelAbstractAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _TwoDDelFramedPanel(
      ribbon: 'ANATOMY',
      title: 'Required overrides and their purposes',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _TwoDDelMethodEntry(
            returnType: 'Widget?',
            signature: 'build(BuildContext context, covariant ChildVicinity vicinity)',
            purpose:
                'Produces the widget for an (xIndex, yIndex) position. Returning '
                'null indicates no widget at that vicinity. Subclasses typically '
                'wrap results in RepaintBoundary to insulate sibling cells.',
            obligation: 'required',
          ),
          SizedBox(height: 10),
          _TwoDDelMethodEntry(
            returnType: 'bool',
            signature: 'shouldRebuild(covariant TwoDimensionalChildDelegate oldDelegate)',
            purpose:
                'Called when a new delegate replaces an old one on the viewport. '
                'Returns true if the widgets returned by build could differ; '
                'false skips the rebuild pass.',
            obligation: 'required',
          ),
          SizedBox(height: 10),
          _TwoDDelMethodEntry(
            returnType: 'void',
            signature: 'notifyListeners()',
            purpose:
                'Inherited from ChangeNotifier. Call this when the delegate '
                'mutates in place (e.g., dropped a piece via a drag) so the '
                'viewport re-queries build for affected cells without a fresh '
                'delegate instance.',
            obligation: 'inherited',
          ),
          SizedBox(height: 10),
          _TwoDDelMethodEntry(
            returnType: 'void',
            signature: 'dispose()',
            purpose:
                'Inherited from ChangeNotifier. Subclasses that own mutable '
                'resources (streams, controllers) should release them here.',
            obligation: 'optional override',
          ),
          SizedBox(height: 14),
          _TwoDDelAnatomyDiagram(),
        ],
      ),
    );
  }
}

class _TwoDDelMethodEntry extends StatelessWidget {
  const _TwoDDelMethodEntry({
    required this.returnType,
    required this.signature,
    required this.purpose,
    required this.obligation,
  });

  final String returnType;
  final String signature;
  final String purpose;
  final String obligation;

  @override
  Widget build(BuildContext context) {
    final Color tag = obligation == 'required'
        ? _twoDDelCrimson
        : obligation == 'inherited'
            ? _twoDDelDeepGreen
            : _twoDDelRust;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _twoDDelIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _twoDDelSepia.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: tag.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: tag),
                ),
                child: Text(
                  obligation,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: tag,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                returnType,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _twoDDelDeepGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            signature,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _twoDDelInk,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            purpose,
            style: TextStyle(
              fontSize: 12,
              color: _twoDDelInk.withValues(alpha: 0.85),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDDelAnatomyDiagram extends StatelessWidget {
  const _TwoDDelAnatomyDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _twoDDelDeepGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _twoDDelDeepGreen.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Class hierarchy',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: _twoDDelDeepGreen,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          _TwoDDelHierarchyRow(
            depth: 0,
            label: 'ChangeNotifier',
            hint: 'dart listenable base',
          ),
          _TwoDDelHierarchyRow(
            depth: 1,
            label: 'TwoDimensionalChildDelegate',
            hint: 'abstract — contract enforced here',
            emphasize: true,
          ),
          _TwoDDelHierarchyRow(
            depth: 2,
            label: 'TwoDimensionalChildBuilderDelegate',
            hint: 'builder callback variant',
          ),
          _TwoDDelHierarchyRow(
            depth: 2,
            label: 'TwoDimensionalChildListDelegate',
            hint: 'explicit 2D list variant',
          ),
          _TwoDDelHierarchyRow(
            depth: 2,
            label: '_TwoDDelChessboardDelegate',
            hint: 'this demo — chess logic',
            emphasize: true,
          ),
          _TwoDDelHierarchyRow(
            depth: 2,
            label: '_TwoDDelGoBoardDelegate',
            hint: 'this demo — go intersections',
            emphasize: true,
          ),
          _TwoDDelHierarchyRow(
            depth: 2,
            label: '_TwoDDelDriftDelegate',
            hint: 'this demo — animated pieces',
            emphasize: true,
          ),
        ],
      ),
    );
  }
}

class _TwoDDelHierarchyRow extends StatelessWidget {
  const _TwoDDelHierarchyRow({
    required this.depth,
    required this.label,
    required this.hint,
    this.emphasize = false,
  });

  final int depth;
  final String label;
  final String hint;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 18.0, top: 2, bottom: 2),
      child: Row(
        children: <Widget>[
          Text(
            depth == 0 ? '└─ ' : '├─ ',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _twoDDelSepia,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: emphasize ? FontWeight.w800 : FontWeight.w500,
              color: emphasize ? _twoDDelCrimson : _twoDDelInk,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              hint,
              style: TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: _twoDDelInk.withValues(alpha: 0.65),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MINI VIEWPORT SOURCE — prose + code-style cards showing how a real
// TwoDimensionalScrollView / TwoDimensionalViewport pair would plug the
// delegate in. The actual mini viewport above is simpler (no culling, no
// scrolling), but it respects the same contract.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelMiniViewportSource extends StatelessWidget {
  const _TwoDDelMiniViewportSource();

  @override
  Widget build(BuildContext context) {
    return _TwoDDelFramedPanel(
      ribbon: 'SCENE 06',
      title: 'The viewport that drives a delegate',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _TwoDDelProseParagraph(
            text:
                'The SDK ships TwoDimensionalScrollView (abstract) and '
                'TwoDimensionalViewport (abstract). Combining them with a '
                'delegate is a three-step recipe: declare a concrete '
                'scroll-view subclass that overrides buildViewport, declare a '
                'concrete viewport subclass that overrides createRenderObject, '
                'then hand the delegate instance to the view constructor.',
          ),
          SizedBox(height: 12),
          _TwoDDelCodeCard(
            title: 'Sketch of a scroll-view subclass',
            code: ''
                'class _TwoDDelScrollView extends TwoDimensionalScrollView {\n'
                '  const _TwoDDelScrollView({required super.delegate})\n'
                '    : super(\n'
                '        verticalDetails: const ScrollableDetails.vertical(),\n'
                '        horizontalDetails: const ScrollableDetails.horizontal(),\n'
                '        diagonalDragBehavior: DiagonalDragBehavior.free,\n'
                '      );\n'
                '\n'
                '  @override\n'
                '  Widget buildViewport(BuildContext context,\n'
                '      ViewportOffset verticalOffset,\n'
                '      ViewportOffset horizontalOffset) {\n'
                '    return _TwoDDelViewport(\n'
                '      delegate: delegate,\n'
                '      verticalOffset: verticalOffset,\n'
                '      horizontalOffset: horizontalOffset,\n'
                '      verticalAxisDirection: AxisDirection.down,\n'
                '      horizontalAxisDirection: AxisDirection.right,\n'
                '      mainAxis: Axis.vertical,\n'
                '    );\n'
                '  }\n'
                '}',
          ),
          SizedBox(height: 12),
          _TwoDDelCodeCard(
            title: 'Sketch of the viewport subclass',
            code: ''
                'class _TwoDDelViewport extends TwoDimensionalViewport {\n'
                '  const _TwoDDelViewport({\n'
                '    required super.delegate,\n'
                '    required super.verticalOffset,\n'
                '    required super.horizontalOffset,\n'
                '    required super.verticalAxisDirection,\n'
                '    required super.horizontalAxisDirection,\n'
                '    required super.mainAxis,\n'
                '  });\n'
                '\n'
                '  @override\n'
                '  RenderObject createRenderObject(BuildContext context) {\n'
                '    return _TwoDDelRenderViewport(\n'
                '      delegate: delegate,\n'
                '      verticalOffset: verticalOffset,\n'
                '      horizontalOffset: horizontalOffset,\n'
                '      verticalAxisDirection: verticalAxisDirection,\n'
                '      horizontalAxisDirection: horizontalAxisDirection,\n'
                '      mainAxis: mainAxis,\n'
                '      childManager: context as TwoDimensionalChildManager,\n'
                '    );\n'
                '  }\n'
                '}',
          ),
          SizedBox(height: 12),
          _TwoDDelCodeCard(
            title: 'Consuming the delegate',
            code: ''
                'final TwoDimensionalChildDelegate chess =\n'
                '    _TwoDDelChessboardDelegate(\n'
                '      position: _TwoDDelStartingPosition.standard,\n'
                '      showCoords: true,\n'
                '      jadeHighlights: true,\n'
                '      inspected: null,\n'
                '    );\n'
                '\n'
                '_TwoDDelScrollView(delegate: chess); // done.',
          ),
          SizedBox(height: 12),
          _TwoDDelProseParagraph(
            text:
                'The mini viewport rendered in this demo uses fixed box rows '
                'and columns instead of a render-object, so we can showcase the '
                'delegate contract without drowning the reader in layout code. '
                'The contract is identical: ask the delegate build(context, '
                'ChildVicinity(x, y)) for every live cell.',
          ),
        ],
      ),
    );
  }
}

class _TwoDDelCodeCard extends StatelessWidget {
  const _TwoDDelCodeCard({required this.title, required this.code});

  final String title;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _twoDDelInk,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _twoDDelGold.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _twoDDelGold,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.45,
              color: _twoDDelParchment,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// EPILOGUE — when to roll your own.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelEpilogue extends StatelessWidget {
  const _TwoDDelEpilogue();

  @override
  Widget build(BuildContext context) {
    return _TwoDDelFramedPanel(
      ribbon: 'EPILOGUE',
      title: 'When to write your own delegate',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _TwoDDelProseParagraph(
            text:
                'Reach for TwoDimensionalChildBuilderDelegate when the mapping '
                'from vicinity to widget is a plain closure — it handles '
                'RepaintBoundary wrapping and bounds-checking for you.',
          ),
          SizedBox(height: 8),
          _TwoDDelProseParagraph(
            text:
                'Reach for TwoDimensionalChildListDelegate when you have a '
                'finite list of lists of widgets ready to paint. It is the '
                'least ceremonious option, akin to the single-dimension '
                'SliverChildListDelegate.',
          ),
          SizedBox(height: 8),
          _TwoDDelProseParagraph(
            text:
                'Subclass TwoDimensionalChildDelegate yourself when domain '
                'logic starts to sprawl inside the builder closure — chess '
                'positions, spreadsheet pivots, tile-map editors, kakuro '
                'grids. Promoting the logic into the delegate produces a '
                'testable, reusable object with explicit shouldRebuild '
                'semantics.',
          ),
          SizedBox(height: 14),
          _TwoDDelTakeawayCard(),
        ],
      ),
    );
  }
}

class _TwoDDelTakeawayCard extends StatelessWidget {
  const _TwoDDelTakeawayCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _twoDDelDeepGreen,
            _twoDDelSepia,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Takeaway',
            style: TextStyle(
              color: _twoDDelParchment,
              letterSpacing: 2,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'TwoDimensionalChildDelegate reduces a 2D scrolling design to two '
            'questions: given an (xIndex, yIndex), what widget lives there, '
            'and when should the viewport throw the cache away? Answering '
            'those two questions precisely — with rich domain logic or animated '
            'drift — is the payoff for subclassing the abstract base over '
            'reaching for the builder or list variants.',
            style: TextStyle(
              color: _twoDDelParchment.withValues(alpha: 0.95),
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED — framed panel with ribbon, prose paragraph helper.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelFramedPanel extends StatelessWidget {
  const _TwoDDelFramedPanel({
    required this.ribbon,
    required this.title,
    required this.body,
  });

  final String ribbon;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _twoDDelParchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _twoDDelSepia.withValues(alpha: 0.55), width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _twoDDelInk.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _TwoDDelPanelHeader(ribbon: ribbon, title: title),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
            child: body,
          ),
        ],
      ),
    );
  }
}

class _TwoDDelPanelHeader extends StatelessWidget {
  const _TwoDDelPanelHeader({required this.ribbon, required this.title});

  final String ribbon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
      decoration: BoxDecoration(
        color: _twoDDelDeepGreen.withValues(alpha: 0.08),
        border: Border(
          bottom: BorderSide(color: _twoDDelSepia.withValues(alpha: 0.35)),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _twoDDelDeepGreen,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              ribbon,
              style: const TextStyle(
                color: _twoDDelParchment,
                letterSpacing: 1.6,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _twoDDelInk,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDDelProseParagraph extends StatelessWidget {
  const _TwoDDelProseParagraph({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        height: 1.55,
        color: _twoDDelInk.withValues(alpha: 0.9),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// APPENDIX A — exhaustive field-by-field piece glossary. Enumerated here as
// inert widgets to make the study more than a single interactive scene and to
// give readers a cross-reference when they inspect squares.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelPieceGlossaryEntry {
  const _TwoDDelPieceGlossaryEntry({
    required this.kind,
    required this.whiteGlyph,
    required this.blackGlyph,
    required this.description,
  });

  final _TwoDDelPieceKind kind;
  final String whiteGlyph;
  final String blackGlyph;
  final String description;
}

const List<_TwoDDelPieceGlossaryEntry> _twoDDelPieceGlossary =
    <_TwoDDelPieceGlossaryEntry>[
  _TwoDDelPieceGlossaryEntry(
    kind: _TwoDDelPieceKind.king,
    whiteGlyph: '\u2654',
    blackGlyph: '\u265A',
    description:
        'Moves one square in any direction. Demo uses it as the centrepiece of '
        'the endgame puzzle starting position.',
  ),
  _TwoDDelPieceGlossaryEntry(
    kind: _TwoDDelPieceKind.queen,
    whiteGlyph: '\u2655',
    blackGlyph: '\u265B',
    description:
        'Combines rook and bishop movement. In _TwoDDelDriftDelegate the queen '
        'is the index-3 drifter, making the longest sweep each tick.',
  ),
  _TwoDDelPieceGlossaryEntry(
    kind: _TwoDDelPieceKind.rook,
    whiteGlyph: '\u2656',
    blackGlyph: '\u265C',
    description:
        'Moves in straight lines. In the endgame preset a lone white rook '
        'demonstrates the delegate handling sparse boards gracefully.',
  ),
  _TwoDDelPieceGlossaryEntry(
    kind: _TwoDDelPieceKind.bishop,
    whiteGlyph: '\u2657',
    blackGlyph: '\u265D',
    description:
        'Moves diagonally. In Chess960 the bishops are scattered across the '
        'back rank, highlighting how a delegate decouples visual position from '
        'canonical algebraic notation.',
  ),
  _TwoDDelPieceGlossaryEntry(
    kind: _TwoDDelPieceKind.knight,
    whiteGlyph: '\u2658',
    blackGlyph: '\u265E',
    description:
        'L-shape mover. First knight in the drift cycle, setting the phase '
        'offset that cascades into the bishop, rook and queen cycles.',
  ),
  _TwoDDelPieceGlossaryEntry(
    kind: _TwoDDelPieceKind.pawn,
    whiteGlyph: '\u2659',
    blackGlyph: '\u265F',
    description:
        'Moves one square forward (two on first move), captures diagonally. '
        'A stray black pawn on c3 appears in the endgame puzzle to make the '
        'study non-trivial.',
  ),
];

class _TwoDDelPieceGlossaryCard extends StatelessWidget {
  const _TwoDDelPieceGlossaryCard();

  @override
  Widget build(BuildContext context) {
    return _TwoDDelFramedPanel(
      ribbon: 'APPENDIX A',
      title: 'Piece glossary',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _TwoDDelProseParagraph(
            text:
                'Every glyph the chess delegate can emit, listed with Unicode '
                'codepoints and the role each piece plays in the demo scenes.',
          ),
          const SizedBox(height: 14),
          ..._twoDDelPieceGlossary.map(
            (_TwoDDelPieceGlossaryEntry e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _TwoDDelGlossaryRow(entry: e),
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoDDelGlossaryRow extends StatelessWidget {
  const _TwoDDelGlossaryRow({required this.entry});

  final _TwoDDelPieceGlossaryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _twoDDelIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _twoDDelSepia.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 70,
            child: Column(
              children: <Widget>[
                Text(
                  entry.whiteGlyph,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xFFFFFDF4),
                    shadows: <Shadow>[
                      Shadow(
                        color: _twoDDelSepia,
                        blurRadius: 1,
                        offset: Offset(0.5, 0.5),
                      ),
                    ],
                  ),
                ),
                Text(
                  entry.blackGlyph,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xFF1D140A),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.kind.name.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    fontSize: 12,
                    color: _twoDDelDeepGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.description,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: _twoDDelInk.withValues(alpha: 0.85),
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

// ─────────────────────────────────────────────────────────────────────────────
// APPENDIX B — ChildVicinity sequence grid. Rendered as a read-only decorated
// table mapping (xIndex, yIndex) → compareTo/hashCode preview. Useful when
// debugging why a delegate's build(context, vicinity) is called N times.
// ─────────────────────────────────────────────────────────────────────────────

class _TwoDDelVicinityGrid extends StatelessWidget {
  const _TwoDDelVicinityGrid();

  static const int _size = 4;

  @override
  Widget build(BuildContext context) {
    return _TwoDDelFramedPanel(
      ribbon: 'APPENDIX B',
      title: 'Inspecting ChildVicinity arithmetic',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _TwoDDelProseParagraph(
            text:
                'Each cell below shows a ChildVicinity alongside its hashCode '
                'and compareTo result against ChildVicinity.invalid. The grid '
                'is deliberately tiny (4 x 4) so every identity is visible at '
                'once; the viewport will exercise the same arithmetic across '
                'every visible cell during layoutChildSequence.',
          ),
          const SizedBox(height: 14),
          _buildGrid(),
          const SizedBox(height: 10),
          Text(
            'ChildVicinity.invalid = (xIndex: -1, yIndex: -1). compareTo uses '
            'xIndex as primary, yIndex as secondary, which is why the grid '
            'reads column-major when sorted.',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: _twoDDelInk.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _twoDDelIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _twoDDelSepia.withValues(alpha: 0.35)),
      ),
      child: Column(
        children: List<Widget>.generate(_size, (int y) {
          return Row(
            children: List<Widget>.generate(_size, (int x) {
              final ChildVicinity v = ChildVicinity(xIndex: x, yIndex: y);
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _twoDDelParchment,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _twoDDelDeepGreen.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '(${v.xIndex}, ${v.yIndex})',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: _twoDDelInk,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'h: ${v.hashCode.toRadixString(16).substring(0, 4)}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: _twoDDelSepia.withValues(alpha: 0.85),
                        ),
                      ),
                      Text(
                        'cmp: ${v.compareTo(ChildVicinity.invalid)}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: _twoDDelSepia.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
