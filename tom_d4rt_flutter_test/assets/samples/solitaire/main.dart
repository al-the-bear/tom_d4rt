import 'dart:math';
import 'package:flutter/material.dart';

const double cardWidth = 60;
const double cardHeight = 84;
const double cardOffset = 18;

enum Suit { hearts, diamonds, clubs, spades }

class CardModel {
  final Suit suit;
  final int rank; // 1=A, 11=J, 12=Q, 13=K
  bool faceUp;
  CardModel(this.suit, this.rank, {this.faceUp = false});

  bool get isRed => suit == Suit.hearts || suit == Suit.diamonds;

  String get suitSymbol {
    switch (suit) {
      case Suit.hearts:
        return '\u2665';
      case Suit.diamonds:
        return '\u2666';
      case Suit.clubs:
        return '\u2663';
      case Suit.spades:
        return '\u2660';
    }
  }

  String get rankLabel {
    if (rank == 1) return 'A';
    if (rank == 11) return 'J';
    if (rank == 12) return 'Q';
    if (rank == 13) return 'K';
    return rank.toString();
  }
}

class DragData {
  final String sourceType; // 'tableau' | 'waste' | 'foundation'
  final int sourceIndex;
  final int cardIndex;
  final List<CardModel> cards;
  DragData(this.sourceType, this.sourceIndex, this.cardIndex, this.cards);
}

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Solitaire',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
    home: const SolitaireHome(),
  );
}

class SolitaireHome extends StatefulWidget {
  const SolitaireHome({super.key});
  @override
  State<SolitaireHome> createState() => _SolitaireHomeState();
}

class _SolitaireHomeState extends State<SolitaireHome> {
  late List<List<CardModel>> tableau;
  late List<List<CardModel>> foundations;
  late List<CardModel> stock;
  late List<CardModel> waste;
  int moves = 0;
  bool won = false;

  @override
  void initState() {
    super.initState();
    _newGame();
  }

  void _newGame() {
    final deck = <CardModel>[];
    for (final s in Suit.values) {
      for (var r = 1; r <= 13; r++) {
        deck.add(CardModel(s, r));
      }
    }
    deck.shuffle(Random());

    tableau = List.generate(7, (_) => <CardModel>[]);
    for (var col = 0; col < 7; col++) {
      for (var i = 0; i <= col; i++) {
        final c = deck.removeLast();
        c.faceUp = (i == col);
        tableau[col].add(c);
      }
    }
    stock = deck;
    waste = <CardModel>[];
    foundations = List.generate(4, (_) => <CardModel>[]);
    moves = 0;
    won = false;
    print('New game dealt. ${stock.length} cards remain in stock.');
  }

  void _drawStock() {
    setState(() {
      if (stock.isEmpty) {
        for (var i = waste.length - 1; i >= 0; i--) {
          final c = waste[i];
          c.faceUp = false;
          stock.add(c);
        }
        waste.clear();
        print('Recycled waste -> stock.');
      } else {
        final c = stock.removeLast();
        c.faceUp = true;
        waste.add(c);
        print('Drew ${c.rankLabel}${c.suitSymbol}.');
      }
      moves++;
    });
  }

  bool _canPlaceOnTableau(CardModel card, int col) {
    if (tableau[col].isEmpty) return card.rank == 13;
    final top = tableau[col].last;
    if (!top.faceUp) return false;
    return top.isRed != card.isRed && top.rank == card.rank + 1;
  }

  bool _canPlaceOnFoundation(CardModel card, int idx) {
    if (foundations[idx].isEmpty) return card.rank == 1;
    final top = foundations[idx].last;
    return top.suit == card.suit && card.rank == top.rank + 1;
  }

  void _doMove(DragData data, String destType, int destIdx) {
    setState(() {
      if (data.sourceType == 'tableau') {
        final pile = tableau[data.sourceIndex];
        pile.removeRange(data.cardIndex, pile.length);
        if (pile.isNotEmpty) pile.last.faceUp = true;
      } else if (data.sourceType == 'waste') {
        waste.removeLast();
      } else if (data.sourceType == 'foundation') {
        foundations[data.sourceIndex].removeLast();
      }
      if (destType == 'tableau') {
        tableau[destIdx].addAll(data.cards);
      } else if (destType == 'foundation') {
        foundations[destIdx].addAll(data.cards);
      }
      moves++;
    });
    print(
        'Move ${data.cards.length} card(s) from ${data.sourceType}[${data.sourceIndex}] -> $destType[$destIdx]');
    _checkWin();
  }

  void _checkWin() {
    var total = 0;
    for (final f in foundations) {
      total += f.length;
    }
    if (total == 52 && !won) {
      won = true;
      print('You won!');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 You won! Press refresh for a new deal.'),
            duration: Duration(seconds: 4),
          ),
        );
      });
    }
  }

  // ---------------- visuals ----------------

  Widget _cardFace(CardModel card) {
    final color =
        card.isRed ? const Color(0xFFC0392B) : const Color(0xFF1B1B1B);
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black26),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, blurRadius: 2, offset: Offset(1, 1)),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 3,
            left: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(card.rankLabel,
                    style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.0)),
                Text(card.suitSymbol,
                    style: TextStyle(
                        color: color, fontSize: 13, height: 1.0)),
              ],
            ),
          ),
          Center(
            child: Text(card.suitSymbol,
                style: TextStyle(color: color, fontSize: 30)),
          ),
        ],
      ),
    );
  }

  Widget _cardBack() {
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white70, width: 1.4),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E40AF), Color(0xFF312E81)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Container(
          width: cardWidth - 14,
          height: cardHeight - 14,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(Icons.diamond_outlined,
              color: Colors.white24, size: 22),
        ),
      ),
    );
  }

  Widget _emptySlot({IconData? icon}) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white24, width: 1.2),
      ),
      child: icon != null ? Icon(icon, color: Colors.white54) : null,
    );
  }

  // ---------------- piles ----------------

  Widget _buildStock() {
    final child =
        stock.isEmpty ? _emptySlot(icon: Icons.refresh) : _cardBack();
    return GestureDetector(
      onTap: _drawStock,
      child: child,
    );
  }

  Widget _buildWaste() {
    if (waste.isEmpty) return _emptySlot();
    final top = waste.last;
    final under = waste.length > 1
        ? _cardFace(waste[waste.length - 2])
        : _emptySlot();
    return Draggable<DragData>(
      data: DragData('waste', 0, waste.length - 1, [top]),
      feedback: _cardFace(top),
      childWhenDragging: under,
      child: _cardFace(top),
    );
  }

  Widget _buildFoundation(int idx) {
    return DragTarget<DragData>(
      onWillAccept: (data) {
        if (data == null) return false;
        if (data.cards.length != 1) return false;
        return _canPlaceOnFoundation(data.cards.first, idx);
      },
      onAccept: (data) => _doMove(data, 'foundation', idx),
      builder: (context, candidate, rejected) {
        Widget inner;
        if (foundations[idx].isEmpty) {
          inner = _emptySlot();
        } else {
          final top = foundations[idx].last;
          final under = foundations[idx].length > 1
              ? _cardFace(foundations[idx][foundations[idx].length - 2])
              : _emptySlot();
          inner = Draggable<DragData>(
            data: DragData(
                'foundation', idx, foundations[idx].length - 1, [top]),
            feedback: _cardFace(top),
            childWhenDragging: under,
            child: _cardFace(top),
          );
        }
        final hi = candidate.isNotEmpty;
        return Container(
          width: cardWidth + 4,
          height: cardHeight + 4,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hi ? Colors.yellowAccent : Colors.transparent,
              width: 2,
            ),
          ),
          child: inner,
        );
      },
    );
  }

  Widget _stackedFeedback(List<CardModel> cards) {
    final h = (cards.length - 1) * cardOffset + cardHeight;
    return SizedBox(
      width: cardWidth,
      height: h,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(
          cards.length,
          (i) => Positioned(
            top: i * cardOffset,
            left: 0,
            child: _cardFace(cards[i]),
          ),
        ),
      ),
    );
  }

  Widget _buildTableauCol(int col) {
    return DragTarget<DragData>(
      onWillAccept: (data) {
        if (data == null) return false;
        if (data.sourceType == 'tableau' && data.sourceIndex == col) {
          return false;
        }
        return _canPlaceOnTableau(data.cards.first, col);
      },
      onAccept: (data) => _doMove(data, 'tableau', col),
      builder: (context, candidate, rejected) {
        final pile = tableau[col];
        final hi = candidate.isNotEmpty;
        final borderColor = hi ? Colors.yellowAccent : Colors.transparent;

        if (pile.isEmpty) {
          return Container(
            width: cardWidth + 4,
            height: cardHeight + 4,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: _emptySlot(),
          );
        }

        final totalHeight = (pile.length - 1) * cardOffset + cardHeight;
        final children = List.generate(pile.length, (i) {
          final card = pile[i];
          Widget w;
          if (!card.faceUp) {
            w = _cardBack();
          } else {
            final cards = pile.sublist(i);
            w = Draggable<DragData>(
              data: DragData('tableau', col, i, cards),
              feedback: _stackedFeedback(cards),
              childWhenDragging:
                  const SizedBox(width: cardWidth, height: cardHeight),
              child: _cardFace(card),
            );
          }
          return Positioned(top: i * cardOffset, left: 0, child: w);
        });

        return Container(
          width: cardWidth + 4,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: SizedBox(
            width: cardWidth,
            height: totalHeight,
            child: Stack(clipBehavior: Clip.none, children: children),
          ),
        );
      },
    );
  }

  Widget _buildGame() {
    return Container(
      color: const Color(0xFF0B5D2E),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildStock(),
              const SizedBox(width: 8),
              _buildWaste(),
              const Spacer(),
              _buildFoundation(0),
              const SizedBox(width: 4),
              _buildFoundation(1),
              const SizedBox(width: 4),
              _buildFoundation(2),
              const SizedBox(width: 4),
              _buildFoundation(3),
            ],
          ),
          const SizedBox(height: 14),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (c) => _buildTableauCol(c)),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.swap_horiz,
                  color: Colors.white70, size: 16),
              const SizedBox(width: 4),
              Text('Moves: $moves',
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 12)),
              const Spacer(),
              if (won)
                const Text('🏆 You won!',
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRules() {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      color: scheme.surface,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.menu_book, color: scheme.primary),
                const SizedBox(width: 8),
                Text('How to play',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 2),
            Text('Klondike Solitaire',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: scheme.primary)),
            const Divider(height: 24),
            const _RuleSection(
              title: 'Goal',
              body:
                  'Move all 52 cards onto the four foundation piles at the top-right. '
                  'Each foundation builds UP by suit — Ace, 2, 3, …, J, Q, K.',
            ),
            const _RuleSection(
              title: 'The board',
              body: '• 7 tableau columns at the bottom.\n'
                  '• 4 foundation piles (one per suit) at the top-right.\n'
                  '• Stock pile (top-left, face-down) — tap to deal.\n'
                  '• Waste pile next to the stock — its top card is playable.',
            ),
            const _RuleSection(
              title: 'Tableau rules',
              body:
                  '• Cards stack DOWN in rank and ALTERNATE colors (red on black, black on red).\n'
                  '• Only a King may go on an empty column.\n'
                  '• When you drag a face-up card, any cards already on top of it come along.',
            ),
            const _RuleSection(
              title: 'Foundation rules',
              body: '• Start each foundation with an Ace.\n'
                  '• Then play 2 → K, all of the same suit.\n'
                  '• Only one card at a time may be played to a foundation.',
            ),
            const _RuleSection(
              title: 'Stock & waste',
              body:
                  'Tap the stock pile to flip one card onto the waste. '
                  'When the stock empties, tap once more to recycle the waste back into the stock.',
            ),
            const _RuleSection(
              title: 'Controls',
              body: '• Drag any card to move it.\n'
                  '• A yellow outline shows a legal drop target.\n'
                  '• Press the refresh icon for a new deal.',
            ),
            const _RuleSection(
              title: 'Winning',
              body:
                  'You win when all four foundations are complete (A → K). '
                  'Not every deal is winnable — don\'t hesitate to start over!',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solitaire'),
        actions: [
          IconButton(
            tooltip: 'New game',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _newGame();
              });
            },
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 820;
        if (wide) {
          return Row(
            children: [
              Expanded(child: _buildGame()),
              const VerticalDivider(width: 1),
              SizedBox(width: 320, child: _buildRules()),
            ],
          );
        }
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              children: [
                SizedBox(
                  height: 580,
                  child: _buildGame(),
                ),
                const Divider(height: 1),
                _buildRules(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _RuleSection extends StatelessWidget {
  final String title;
  final String body;
  const _RuleSection({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(body, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}