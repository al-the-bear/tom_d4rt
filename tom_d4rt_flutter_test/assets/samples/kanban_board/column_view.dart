// One vertical column on the kanban board.
//
// Renders the column title at the top, a `ReorderableListView`
// for within-column drag reordering, and a `Composer` at the
// bottom. The whole column is wrapped in a `DragTarget<KanbanCard>`
// so cards dragged from another column (via `LongPressDraggable`
// inside each tile) drop here and call `board.moveCard`.
//
// The column listens to the board through the parent (Home owns
// the `AnimatedBuilder`), so when the board mutates the column
// rebuilds.
import 'package:flutter/material.dart';

import 'board.dart';
import 'card_tile.dart';
import 'composer.dart';

class ColumnView extends StatelessWidget {
  final KanbanBoard board;
  final int columnIndex;

  /// Open the edit dialog for [card]. Plumbed in from `Home` so
  /// the dialog runs against the root `BuildContext` (so the
  /// dialog is portable across columns).
  final void Function(KanbanCard card) onCardTap;

  const ColumnView({
    super.key,
    required this.board,
    required this.columnIndex,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    final String title = board.columnTitles[columnIndex];
    final List<KanbanCard> cards = board.columns[columnIndex];

    return DragTarget<KanbanCard>(
      onWillAcceptWithDetails: (DragTargetDetails<KanbanCard> details) {
        // Only accept cards from a different column.
        return board.columnOf(details.data) != columnIndex;
      },
      onAcceptWithDetails: (DragTargetDetails<KanbanCard> details) {
        board.moveCard(details.data, columnIndex);
      },
      builder: (
        BuildContext ctx,
        List<KanbanCard?> candidates,
        List<dynamic> rejects,
      ) {
        final bool highlight = candidates.isNotEmpty;
        return Container(
          key: Key('column-$columnIndex'),
          margin: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: highlight ? Colors.blue.shade50 : Colors.grey.shade100,
            border: Border.all(
              color: highlight ? Colors.blueAccent : Colors.grey.shade300,
              width: highlight ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      key: Key('column-title-$columnIndex'),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      key: Key('column-count-$columnIndex'),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        '${cards.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: cards.isEmpty
                    ? Center(
                        key: Key('column-empty-$columnIndex'),
                        child: const Text(
                          'Drop here',
                          style: TextStyle(color: Colors.black38),
                        ),
                      )
                    : ReorderableListView.builder(
                        key: Key('column-list-$columnIndex'),
                        buildDefaultDragHandles: true,
                        itemCount: cards.length,
                        onReorder: (int oldIndex, int newIndex) {
                          board.reorderInColumn(
                            columnIndex,
                            oldIndex,
                            newIndex,
                          );
                        },
                        itemBuilder: (BuildContext c, int index) {
                          final KanbanCard card = cards[index];
                          return _buildDraggable(card, index, cards.length);
                        },
                      ),
              ),
              Composer(
                columnTitle: title,
                columnIndex: columnIndex,
                onAdd: (int col, String text) => board.addCard(col, text),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDraggable(KanbanCard card, int index, int count) {
    final tile = CardTile(
      key: ValueKey<int>(card.id),
      card: card,
      canMoveLeft: columnIndex > 0,
      canMoveRight: columnIndex < 2,
      canMoveUp: index > 0,
      canMoveDown: index < count - 1,
      onTap: () => onCardTap(card),
      onMoveLeft: () => board.moveCard(card, columnIndex - 1),
      onMoveRight: () => board.moveCard(card, columnIndex + 1),
      onMoveUp: () => board.reorderInColumn(columnIndex, index, index - 1),
      onMoveDown: () =>
          board.reorderInColumn(columnIndex, index, index + 2),
    );

    // Wrap the tile in LongPressDraggable so a long-press starts a
    // cross-column drag. The reorderable list's own drag handle
    // (long press anywhere on the tile) is used for within-column
    // reorder; cross-column drag uses the same gesture but the
    // DragTarget on the *other* column catches it.
    return LongPressDraggable<KanbanCard>(
      key: ValueKey<String>('drag-${card.id}'),
      data: card,
      feedback: Material(
        elevation: 6.0,
        color: Colors.transparent,
        child: SizedBox(
          width: 200.0,
          child: tile,
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: tile),
      child: tile,
    );
  }
}
