import 'package:flutter/material.dart';

import 'engine.dart';
import 'piles.dart';
import 'rules.dart';

class SolitaireHome extends StatefulWidget {
  const SolitaireHome({super.key});

  @override
  State<SolitaireHome> createState() => _SolitaireHomeState();
}

class _SolitaireHomeState extends State<SolitaireHome> {
  final Solitaire game = Solitaire();
  int _moves = 0;
  bool _winAnnounced = false;

  @override
  void initState() {
    super.initState();
    game.newGame();
  }

  void _act(String? Function() perform) {
    final err = perform();
    if (err != null) {
      _showError(err);
      return;
    }
    setState(() {
      _moves++;
    });
    if (game.isWon && !_winAnnounced) {
      _winAnnounced = true;
      _showWin();
    }
  }

  void _showError(String msg) {
    print('Illegal move: $msg');
    final m = ScaffoldMessenger.of(context);
    m.clearSnackBars();
    m.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.block, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(msg, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFC62828),
        duration: const Duration(milliseconds: 2800),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showWin() {
    print('Won in $_moves moves.');
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('You win! 🎉'),
        content: Text('All foundations completed in $_moves moves.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _newGame();
            },
            child: const Text('Play again'),
          ),
        ],
      ),
    );
  }

  void _newGame() {
    setState(() {
      game.newGame();
      _moves = 0;
      _winAnnounced = false;
    });
  }

  void _undo() {
    if (!game.undo()) {
      _showError('Nothing to undo.');
      return;
    }
    setState(() {
      _moves = _moves > 0 ? _moves - 1 : 0;
      _winAnnounced = false;
    });
  }

  void _tapStock() {
    _act(() => game.drawFromStock());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F6B2C),
      appBar: AppBar(
        title: const Text('Solitaire'),
        backgroundColor: const Color(0xFF0A4E1F),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                'Moves: $_moves',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Undo',
            onPressed: _undo,
            icon: const Icon(Icons.undo),
          ),
          IconButton(
            tooltip: 'New game',
            onPressed: _newGame,
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          final wide = c.maxWidth >= 900;
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _Board(
                    game: game,
                    onTapStock: _tapStock,
                    act: _act,
                  ),
                ),
                const SizedBox(width: 320, child: RulesSide()),
              ],
            );
          }
          return Column(
            children: [
              Expanded(
                child: _Board(
                  game: game,
                  onTapStock: _tapStock,
                  act: _act,
                ),
              ),
              const RulesFlip(),
            ],
          );
        },
      ),
    );
  }
}

class _Board extends StatelessWidget {
  final Solitaire game;
  final VoidCallback onTapStock;
  final MoveAction act;
  const _Board({
    required this.game,
    required this.onTapStock,
    required this.act,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        const padding = 12.0;
        const gap = 10.0;
        final availW = c.maxWidth - padding * 2;
        // 7 cards + 6 gaps along a row.
        final raw = (availW - gap * 6) / 7;
        final cardWidth = raw.clamp(46.0, 110.0);
        final cardHeight = cardWidth * 1.4;

        final stock = StockPile(
          cards: game.stock,
          cardWidth: cardWidth,
          onTap: onTapStock,
        );
        final waste = WastePile(
          cards: game.waste,
          cardWidth: cardWidth,
        );

        final foundationWidgets = List.generate(4, (i) {
          return FoundationPile(
            idx: i,
            cards: game.foundations[i],
            cardWidth: cardWidth,
            game: game,
            act: act,
          );
        });

        final tableauWidgets = List.generate(7, (i) {
          return TableauPile(
            idx: i,
            cards: game.tableau[i],
            cardWidth: cardWidth,
            game: game,
            act: act,
          );
        });

        return Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ----- Top row: stock + waste . . . . . . foundations -----
              SizedBox(
                height: cardHeight,
                child: Row(
                  children: [
                    stock,
                    const SizedBox(width: gap),
                    waste,
                    const Spacer(),
                    foundationWidgets[0],
                    const SizedBox(width: gap),
                    foundationWidgets[1],
                    const SizedBox(width: gap),
                    foundationWidgets[2],
                    const SizedBox(width: gap),
                    foundationWidgets[3],
                  ],
                ),
              ),
              const SizedBox(height: gap * 1.6),
              // ----- Tableau -----
              Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tableauWidgets[0],
                      const SizedBox(width: gap),
                      tableauWidgets[1],
                      const SizedBox(width: gap),
                      tableauWidgets[2],
                      const SizedBox(width: gap),
                      tableauWidgets[3],
                      const SizedBox(width: gap),
                      tableauWidgets[4],
                      const SizedBox(width: gap),
                      tableauWidgets[5],
                      const SizedBox(width: gap),
                      tableauWidgets[6],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
