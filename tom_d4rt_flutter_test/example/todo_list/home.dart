// Top-level page for the todo_list sample (example #13).
//
// Owns the long-lived `TaskStore`. Listens to it via
// `ListenableBuilder` so the composer, filter bar, count line, and
// list rebuild together whenever a mutation lands.
//
// Layout:
//   * `TaskComposer`       — text field + add button
//   * `TaskFilterBar`      — SegmentedButton<TaskFilter>
//   * count caption        — "{n} active / {m} done"
//   * `ReorderableListView.builder` — keyed list of `TaskTile`s
//
// The bottom-sheet confirmation for `Dismissible` is hosted here
// (not in `TaskTile`) so we only ever surface one sheet at a time
// even if multiple tiles are mid-dismiss.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'composer.dart';
import 'filter_bar.dart';
import 'store.dart';
import 'task.dart';
import 'task_tile.dart';

class TodoListHome extends StatefulWidget {
  const TodoListHome({super.key});

  @override
  State<TodoListHome> createState() => _TodoListHomeState();
}

class _TodoListHomeState extends State<TodoListHome> {
  late TaskStore _store;

  @override
  void initState() {
    super.initState();
    _store = TaskStore();
    print('todo.init n=${_store.tasks.length}');
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  Future<bool> _confirmDismiss(Task task) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext sheetCtx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Delete "${task.text}"?',
                  style: Theme.of(sheetCtx).textTheme.titleMedium,
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      key: const Key('dismiss-cancel'),
                      onPressed: () => Navigator.of(sheetCtx).pop(false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      key: const Key('dismiss-confirm'),
                      onPressed: () => Navigator.of(sheetCtx).pop(true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListenableBuilder(
          listenable: _store,
          builder: (BuildContext ctx, Widget? _) {
            final visible = _store.visibleTasks;
            final activeCount =
                _store.tasks.where((t) => !t.done).length;
            final doneCount = _store.tasks.length - activeCount;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TaskComposer(onSubmit: _store.add),
                const SizedBox(height: 12.0),
                Center(
                  child: TaskFilterBar(
                    value: _store.filter,
                    onChanged: _store.setFilter,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '$activeCount active · $doneCount done',
                  key: const Key('count-line'),
                  textAlign: TextAlign.center,
                  style: Theme.of(ctx).textTheme.bodySmall,
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: visible.isEmpty
                      ? Center(
                          key: const Key('empty-state'),
                          child: Text(
                            _store.tasks.isEmpty
                                ? 'No tasks yet — add one above.'
                                : 'Nothing in this filter.',
                            style: Theme.of(ctx).textTheme.bodyMedium,
                          ),
                        )
                      : ReorderableListView.builder(
                          key: const Key('todo-list'),
                          itemCount: visible.length,
                          buildDefaultDragHandles: false,
                          onReorder: (int oldIndex, int newIndex) {
                            // Translate visible-list indices to
                            // full-list indices. With the All filter
                            // the visible list IS the full list, so
                            // the mapping is identity. With Active /
                            // Completed filters we look up by id.
                            final movedId = visible[oldIndex].id;
                            final realOld = _store.tasks
                                .indexWhere((t) => t.id == movedId);
                            int realNew;
                            if (newIndex >= visible.length) {
                              // Dropped past the end of the visible
                              // list — anchor to the position after
                              // the last visible item in the full
                              // list.
                              final lastVisible =
                                  visible[visible.length - 1].id;
                              realNew = _store.tasks
                                      .indexWhere((t) => t.id == lastVisible) +
                                  1;
                            } else {
                              final anchorId = visible[newIndex].id;
                              realNew = _store.tasks
                                  .indexWhere((t) => t.id == anchorId);
                              if (realOld < realNew) realNew += 1;
                            }
                            _store.reorder(realOld, realNew);
                          },
                          itemBuilder: (BuildContext _, int i) {
                            final task = visible[i];
                            return TaskTile(
                              key: ValueKey<int>(task.id),
                              task: task,
                              index: i,
                              onToggle: () => _store.toggle(task.id),
                              onAskDismiss: () => _confirmDismiss(task),
                              onConfirmedDismiss: () =>
                                  _store.remove(task.id),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
