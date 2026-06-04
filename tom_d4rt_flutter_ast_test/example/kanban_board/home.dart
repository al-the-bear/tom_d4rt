// Top-level Kanban page.
//
// Owns the `KanbanBoard` notifier and rebuilds via
// `AnimatedBuilder`. The three `ColumnView`s sit in a `Row` and
// share the same board. Card taps route through `_editCard` which
// calls `showCardDialog` and applies the result.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'board.dart';
import 'card_dialog.dart';
import 'column_view.dart';

class KanbanHome extends StatefulWidget {
  const KanbanHome({super.key});

  @override
  State<KanbanHome> createState() => _KanbanHomeState();
}

class _KanbanHomeState extends State<KanbanHome> {
  late final KanbanBoard _board;

  @override
  void initState() {
    super.initState();
    _board = KanbanBoard();
  }

  @override
  void dispose() {
    _board.dispose();
    super.dispose();
  }

  Future<void> _editCard(KanbanCard card) async {
    final CardDialogResult? result = await showCardDialog(context, card);
    if (result == null) {
      return;
    }
    if (result.deleted) {
      _board.removeCard(card);
      return;
    }
    final String? newTitle = result.newTitle;
    if (newTitle == null) return;
    if (newTitle.trim().isEmpty) return;
    if (newTitle == card.title) return;
    _board.updateTitle(card, newTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('kanban-appbar'),
        title: const Text('Kanban Board'),
      ),
      body: AnimatedBuilder(
        animation: _board,
        builder: (BuildContext ctx, Widget? _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              key: const Key('kanban-row'),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ColumnView(
                    board: _board,
                    columnIndex: 0,
                    onCardTap: _editCard,
                  ),
                ),
                Expanded(
                  child: ColumnView(
                    board: _board,
                    columnIndex: 1,
                    onCardTap: _editCard,
                  ),
                ),
                Expanded(
                  child: ColumnView(
                    board: _board,
                    columnIndex: 2,
                    onCardTap: _editCard,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
