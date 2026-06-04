// Plain task model for the todo_list sample (example #13).
//
// Immutable triple (`id`, `text`, `done`). Mutations on the store are
// implemented as replace-by-id, so `Task` itself stays value-like and
// `==` is based purely on `id` for list-key purposes. The store owns
// the source of truth; widgets only read.
//
// Filter enum is co-located here because every UI layer (composer,
// filter bar, store, home) needs it.
import 'package:flutter/foundation.dart';

@immutable
class Task {
  final int id;
  final String text;
  final bool done;

  const Task({required this.id, required this.text, required this.done});

  Task copyWith({String? text, bool? done}) {
    return Task(
      id: id,
      text: text ?? this.text,
      done: done ?? this.done,
    );
  }

  @override
  bool operator ==(Object other) => other is Task && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Filter for the visible task list. Persisted on the store.
///
/// Ordered so the SegmentedButton renders All / Active / Completed
/// left-to-right matching `values`.
enum TaskFilter { all, active, completed }

/// Human-readable label for the filter bar.
String filterLabel(TaskFilter f) {
  switch (f) {
    case TaskFilter.all:
      return 'All';
    case TaskFilter.active:
      return 'Active';
    case TaskFilter.completed:
      return 'Completed';
  }
}

/// Apply [filter] to [tasks], preserving original order.
List<Task> applyFilter(List<Task> tasks, TaskFilter filter) {
  switch (filter) {
    case TaskFilter.all:
      return List<Task>.of(tasks);
    case TaskFilter.active:
      return tasks.where((t) => !t.done).toList();
    case TaskFilter.completed:
      return tasks.where((t) => t.done).toList();
  }
}
