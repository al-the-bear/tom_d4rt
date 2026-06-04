// State container for the kanban_board sample.
//
// `KanbanBoard` extends `ChangeNotifier` and owns the three columns
// of cards (To do / Doing / Done). It is the single source of truth
// — `Home`, the columns, the composer and the dialog all read from
// and mutate the same notifier.
//
// Every public mutation calls `_emit` which `print`s a trail line.
// The test harness scrapes those prints to verify the right state
// transition happened without having to drive every interaction
// through the rendered widgets.
//
// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';

/// One kanban card. Mutable on purpose — the dialog edits `title`
/// in place so existing references stay valid.
class KanbanCard {
  final int id;
  String title;

  KanbanCard({required this.id, required this.title});

  @override
  String toString() => 'KanbanCard(id=$id, title="$title")';
}

class KanbanBoard extends ChangeNotifier {
  /// Column titles, parallel to [columns]. Length is fixed at 3 for
  /// this sample (To do / Doing / Done).
  final List<String> columnTitles = const <String>['To do', 'Doing', 'Done'];

  /// `columns[i]` holds the cards currently in column `i`. The list
  /// is in display order (top-to-bottom).
  late final List<List<KanbanCard>> columns;

  int _nextId = 0;

  KanbanBoard() {
    // Seed three columns with a handful of cards so the sample
    // boots into a non-empty state. The exact titles double as
    // anchors the tests look for (e.g. find.text('Write proposal')).
    columns = <List<KanbanCard>>[
      <KanbanCard>[
        _make('Write proposal'),
        _make('Review PR'),
      ],
      <KanbanCard>[
        _make('Refactor API'),
      ],
      <KanbanCard>[
        _make('Ship release'),
      ],
    ];
    _emit('kanban.init cols=${columnTitles.length} cards=$cardCount');
  }

  KanbanCard _make(String title) {
    final card = KanbanCard(id: _nextId, title: title);
    _nextId += 1;
    return card;
  }

  int get cardCount {
    var n = 0;
    for (var i = 0; i < columns.length; i += 1) {
      n += columns[i].length;
    }
    return n;
  }

  /// Index of the column that currently holds [card], or `-1` if
  /// not found.
  int columnOf(KanbanCard card) {
    for (var i = 0; i < columns.length; i += 1) {
      for (var j = 0; j < columns[i].length; j += 1) {
        if (columns[i][j].id == card.id) {
          return i;
        }
      }
    }
    return -1;
  }

  /// Append a new card to [col] with [title]. No-op on whitespace.
  void addCard(int col, String title) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return;
    final card = _make(trimmed);
    columns[col].add(card);
    _emit('kanban.add col=$col id=${card.id} title=$trimmed');
    notifyListeners();
  }

  /// Remove [card] from whichever column currently holds it.
  void removeCard(KanbanCard card) {
    final col = columnOf(card);
    if (col < 0) return;
    columns[col].removeWhere((KanbanCard c) => c.id == card.id);
    _emit('kanban.remove col=$col id=${card.id}');
    notifyListeners();
  }

  /// Edit a card's title in place.
  void updateTitle(KanbanCard card, String newTitle) {
    final trimmed = newTitle.trim();
    if (trimmed.isEmpty) return;
    card.title = trimmed;
    _emit('kanban.rename id=${card.id} new=$trimmed');
    notifyListeners();
  }

  /// Move [card] to the bottom of column [toCol]. Cross-column drag
  /// drops call this, as do the left/right arrows on each card.
  void moveCard(KanbanCard card, int toCol) {
    final fromCol = columnOf(card);
    if (fromCol < 0) return;
    if (fromCol == toCol) return;
    columns[fromCol].removeWhere((KanbanCard c) => c.id == card.id);
    columns[toCol].add(card);
    _emit('kanban.move id=${card.id} from=$fromCol to=$toCol');
    notifyListeners();
  }

  /// Reorder a card within its column. `oldIndex` / `newIndex`
  /// follow the `ReorderableListView.onReorder` contract: if you
  /// drag downwards Flutter passes `newIndex == oldIndex + 1`
  /// meaning "place it just after the old position" — we apply the
  /// classic `newIndex -= 1` correction inside this method.
  void reorderInColumn(int col, int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= columns[col].length) return;
    var target = newIndex;
    if (target > oldIndex) target -= 1;
    if (target < 0) target = 0;
    if (target >= columns[col].length) target = columns[col].length - 1;
    if (target == oldIndex) return;
    final card = columns[col].removeAt(oldIndex);
    columns[col].insert(target, card);
    _emit('kanban.reorder col=$col from=$oldIndex to=$target');
    notifyListeners();
  }

  void _emit(String msg) {
    print(msg);
  }
}
