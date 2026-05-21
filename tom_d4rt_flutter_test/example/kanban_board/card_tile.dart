// Visual representation of a single kanban card.
//
// `CardTile` is stateless — it just renders the card's title and a
// row of arrows (left / right to move between columns, up / down to
// reorder within the column). Behaviour is parented up to the
// `ColumnView` via callbacks because the column owns the board
// reference and knows the column index.
//
// The tile also drives `onTap`, which the column wires to a
// `showDialog` for editing the card details.
import 'package:flutter/material.dart';

import 'board.dart';

class CardTile extends StatelessWidget {
  final KanbanCard card;

  /// True if this card is in the leftmost column (To do). The "←"
  /// button is hidden in that case.
  final bool canMoveLeft;

  /// True if this card is in the rightmost column (Done). The "→"
  /// button is hidden in that case.
  final bool canMoveRight;

  /// True if this card has a card above it in the same column. The
  /// "↑" button is hidden otherwise.
  final bool canMoveUp;

  /// True if this card has a card below it in the same column. The
  /// "↓" button is hidden otherwise.
  final bool canMoveDown;

  final VoidCallback onTap;
  final VoidCallback onMoveLeft;
  final VoidCallback onMoveRight;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  const CardTile({
    super.key,
    required this.card,
    required this.canMoveLeft,
    required this.canMoveRight,
    required this.canMoveUp,
    required this.canMoveDown,
    required this.onTap,
    required this.onMoveLeft,
    required this.onMoveRight,
    required this.onMoveUp,
    required this.onMoveDown,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('card-${card.id}'),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      elevation: 2.0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                card.title,
                key: Key('card-title-${card.id}'),
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    key: Key('card-left-${card.id}'),
                    icon: const Icon(Icons.arrow_back, size: 18.0),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: canMoveLeft ? onMoveLeft : null,
                  ),
                  IconButton(
                    key: Key('card-up-${card.id}'),
                    icon: const Icon(Icons.arrow_upward, size: 18.0),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: canMoveUp ? onMoveUp : null,
                  ),
                  IconButton(
                    key: Key('card-down-${card.id}'),
                    icon: const Icon(Icons.arrow_downward, size: 18.0),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: canMoveDown ? onMoveDown : null,
                  ),
                  IconButton(
                    key: Key('card-right-${card.id}'),
                    icon: const Icon(Icons.arrow_forward, size: 18.0),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: canMoveRight ? onMoveRight : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
