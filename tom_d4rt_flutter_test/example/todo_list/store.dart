// ChangeNotifier-backed task store for the todo_list sample.
//
// Owns the list of tasks, the current filter, and a monotonically
// increasing id allocator. All mutations route through dedicated
// methods that emit a single `todo.*` trail line so tests can assert
// behaviour without scraping widgets.
//
// `visibleTasks` applies the current filter on read; widgets bound
// via `ListenableBuilder(listenable: store, …)` rebuild whenever any
// mutation fires `notifyListeners()`.
//
// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';

import 'task.dart';

class TaskStore extends ChangeNotifier {
  final List<Task> _tasks = <Task>[];
  TaskFilter _filter = TaskFilter.all;
  int _nextId = 1;

  /// Live snapshot of every task (any filter). Mutations to the
  /// returned list are forbidden — the store owns the list. Returned
  /// as an unmodifiable view to make accidental edits fail loudly.
  List<Task> get tasks => List<Task>.unmodifiable(_tasks);

  TaskFilter get filter => _filter;

  /// Apply [filter] to the internal task list (preserves order).
  List<Task> get visibleTasks => applyFilter(_tasks, _filter);

  /// Append a new task with auto-allocated id. No-op for blank text
  /// so the composer can safely call `add` on every submit without
  /// pre-filtering.
  void add(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      print('todo.add.skip reason=empty');
      return;
    }
    final task = Task(id: _nextId, text: trimmed, done: false);
    _nextId += 1;
    _tasks.add(task);
    print('todo.add id=${task.id} text="${task.text}"');
    notifyListeners();
  }

  /// Toggle the `done` flag on the task with [id]. Silently ignores
  /// unknown ids — tests treat that as an interpreter bug, not a
  /// runtime concern.
  void toggle(int id) {
    final idx = _tasks.indexWhere((t) => t.id == id);
    if (idx == -1) {
      print('todo.toggle.miss id=$id');
      return;
    }
    final updated = _tasks[idx].copyWith(done: !_tasks[idx].done);
    _tasks[idx] = updated;
    print('todo.toggle id=$id done=${updated.done}');
    notifyListeners();
  }

  /// Remove the task with [id].
  void remove(int id) {
    final idx = _tasks.indexWhere((t) => t.id == id);
    if (idx == -1) {
      print('todo.remove.miss id=$id');
      return;
    }
    _tasks.removeAt(idx);
    print('todo.remove id=$id');
    notifyListeners();
  }

  /// Move the task at [oldIndex] to [newIndex] within the full task
  /// list. Indices are interpreted against [tasks] (not
  /// [visibleTasks]) so a filtered view doesn't surprise the store.
  ///
  /// Mirrors `ReorderableListView`'s `onReorder` contract: the new
  /// index is computed *after* the original element is removed, so
  /// `newIndex > oldIndex` is shifted by one.
  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= _tasks.length) return;
    var target = newIndex;
    if (target > oldIndex) target -= 1;
    if (target < 0) target = 0;
    if (target >= _tasks.length) target = _tasks.length - 1;
    final moved = _tasks.removeAt(oldIndex);
    _tasks.insert(target, moved);
    print('todo.reorder old=$oldIndex new=$target id=${moved.id}');
    notifyListeners();
  }

  /// Switch the active filter. No-op if the value didn't change.
  void setFilter(TaskFilter next) {
    if (next == _filter) return;
    _filter = next;
    print('todo.filter value=${next.name}');
    notifyListeners();
  }
}
