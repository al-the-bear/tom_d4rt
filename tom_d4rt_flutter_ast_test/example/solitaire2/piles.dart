import 'package:flutter/material.dart';

import 'card_view.dart';
import 'engine.dart';

typedef MoveAction = void Function(String? Function() perform);

/// Stock pile — face-down cards. Tap to deal one to waste; tap when empty
/// to recycle the waste back.
class StockPile extends StatelessWidget {
  final List<PlayingCard> cards;
  final double cardWidth;
  final VoidCallback onTap;
  const StockPile({
    super.key,
    required this.cards,
    required this.cardWidth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: cards.isEmpty
          ? EmptySlot(width: cardWidth, icon: Icons.refresh)
          : Stack(
              clipBehavior: Clip.none,
              children: [
                if (cards.length > 1)
                  Positioned(
                    left: 1,
                    top: 1,
                    child: CardView(
                      card: cards[cards.length - 2],
                      width: cardWidth,
                    ),
                  ),
                CardView(card: cards.last, width: cardWidth),
              ],
            ),
    );
  }
}

/// Waste pile — face-up. Top card is draggable.
class WastePile extends StatelessWidget {
  final List<PlayingCard> cards;
  final double cardWidth;
  const WastePile({
    super.key,
    required this.cards,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return EmptySlot(width: cardWidth, icon: Icons.style_outlined);
    }
    final top = cards.last;
    final payload = DragPayload([top], 'waste');
    return Draggable<DragPayload>(
      data: payload,
      dragAnchorStrategy: childDragAnchorStrategy,
      feedback: Material(
        color: Colors.transparent,
        child: CardView(card: top, width: cardWidth),
      ),
      childWhenDragging: cards.length > 1
          ? CardView(card: cards[cards.length - 2], width: cardWidth)
          : EmptySlot(width: cardWidth, icon: Icons.style_outlined),
      child: CardView(card: top, width: cardWidth),
    );
  }
}

/// Foundation pile (one per suit slot).
class FoundationPile extends StatelessWidget {
  final int idx;
  final List<PlayingCard> cards;
  final double cardWidth;
  final Solitaire game;
  final MoveAction act;
  const FoundationPile({
    super.key,
    required this.idx,
    required this.cards,
    required this.cardWidth,
    required this.game,
    required this.act,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<DragPayload>(
      onWillAccept: (p) => p != null,
      onAccept: (p) {
        act(() => game.moveToFoundation(p, idx));
      },
      builder: (context, candidate, rejected) {
        final highlight = candidate.isNotEmpty;
        if (cards.isEmpty) {
          return EmptySlot(
            width: cardWidth,
            label: 'A',
            highlight: highlight,
          );
        }
        final top = cards.last;
        final payload = DragPayload([top], 'foundation:$idx');
        return Draggable<DragPayload>(
          data: payload,
          dragAnchorStrategy: childDragAnchorStrategy,
          feedback: Material(
            color: Colors.transparent,
            child: CardView(card: top, width: cardWidth),
          ),
          childWhenDragging: cards.length > 1
              ? CardView(card: cards[cards.length - 2], width: cardWidth)
              : EmptySlot(width: cardWidth, label: 'A'),
          child: CardView(
            card: top,
            width: cardWidth,
            highlight: highlight,
          ),
        );
      },
    );
  }
}

/// Tableau column — supports stacking, multi-card drag, drop highlight.
class TableauPile extends StatefulWidget {
  final int idx;
  final List<PlayingCard> cards;
  final double cardWidth;
  final Solitaire game;
  final MoveAction act;
  const TableauPile({
    super.key,
    required this.idx,
    required this.cards,
    required this.cardWidth,
    required this.game,
    required this.act,
  });

  @override
  State<TableauPile> createState() => _TableauPileState();
}

class _TableauPileState extends State<TableauPile> {
  int? _draggingFrom;

  void _resetDrag() {
    if (_draggingFrom != null) {
      setState(() => _draggingFrom = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.cardWidth;
    final cardHeight = w * 1.4;
    final faceDownOffset = w * 0.18;
    final faceUpOffset = w * 0.28;

    // Compute Y position of each card and the overall pile height.
    final positions = <double>[];
    double y = 0;
    for (var i = 0; i < widget.cards.length; i++) {
      positions.add(y);
      y += widget.cards[i].faceUp ? faceUpOffset : faceDownOffset;
    }
    final lastY = positions.isEmpty ? 0.0 : positions.last;
    double pileHeight = lastY + cardHeight;
    if (pileHeight < cardHeight) pileHeight = cardHeight;

    return DragTarget<DragPayload>(
      onWillAccept: (p) => p != null,
      onAccept: (p) {
        widget.act(() => widget.game.moveToTableau(p, widget.idx));
      },
      builder: (context, candidate, rejected) {
        final highlight = candidate.isNotEmpty;
        final children = <Widget>[
          // Non-positioned: gives the Stack its intrinsic size.
          EmptySlot(width: w, highlight: highlight && widget.cards.isEmpty),
        ];

        children.addAll(
          List.generate(widget.cards.length, (i) {
            return Positioned(
              top: positions[i],
              left: 0,
              child: _cardSlot(i),
            );
          }),
        );

        return SizedBox(
          width: w,
          height: pileHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: children,
          ),
        );
      },
    );
  }

  Widget _cardSlot(int i) {
    final card = widget.cards[i];
    final w = widget.cardWidth;

    if (!card.faceUp) {
      return CardView(card: card, width: w);
    }

    // If a drag started from an earlier index in this column, dim cards
    // below it (they're conceptually traveling with the dragged stack).
    if (_draggingFrom != null && i > _draggingFrom!) {
      return Opacity(opacity: 0.30, child: CardView(card: card, width: w));
    }

    final seq = widget.cards.sublist(i);
    final payload = DragPayload(seq, 'tableau:${widget.idx}:$i');

    return Draggable<DragPayload>(
      data: payload,
      dragAnchorStrategy: childDragAnchorStrategy,
      maxSimultaneousDrags: 1,
      feedback: _feedbackStack(seq),
      childWhenDragging: Opacity(
        opacity: 0.30,
        child: CardView(card: card, width: w),
      ),
      onDragStarted: () => setState(() => _draggingFrom = i),
      onDragEnd: (details) => _resetDrag(),
      onDraggableCanceled: (velocity, offset) => _resetDrag(),
      onDragCompleted: _resetDrag,
      child: CardView(card: card, width: w),
    );
  }

  Widget _feedbackStack(List<PlayingCard> seq) {
    final w = widget.cardWidth;
    final offset = w * 0.28;
    final h = w * 1.4 + offset * (seq.length - 1);
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: w,
        height: h,
        child: Stack(
          clipBehavior: Clip.none,
          children: List.generate(
            seq.length,
            (i) => Positioned(
              top: i * offset,
              left: 0,
              child: CardView(card: seq[i], width: w),
            ),
          ),
        ),
      ),
    );
  }
}
