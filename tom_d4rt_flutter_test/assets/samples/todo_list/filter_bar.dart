// SegmentedButton<TaskFilter> filter bar for the todo_list sample.
//
// Each segment gets a stable Text label that doubles as a target for
// `find.text(...)` in tests. The button itself is keyed so the
// surrounding container can be found independently.
import 'package:flutter/material.dart';

import 'task.dart';

class TaskFilterBar extends StatelessWidget {
  final TaskFilter value;
  final ValueChanged<TaskFilter> onChanged;

  const TaskFilterBar({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<TaskFilter>(
      key: const Key('filter-bar'),
      segments: const <ButtonSegment<TaskFilter>>[
        ButtonSegment<TaskFilter>(
          value: TaskFilter.all,
          label: Text('All'),
        ),
        ButtonSegment<TaskFilter>(
          value: TaskFilter.active,
          label: Text('Active'),
        ),
        ButtonSegment<TaskFilter>(
          value: TaskFilter.completed,
          label: Text('Completed'),
        ),
      ],
      selected: <TaskFilter>{value},
      onSelectionChanged: (Set<TaskFilter> next) {
        if (next.isEmpty) return;
        onChanged(next.first);
      },
      showSelectedIcon: false,
    );
  }
}
