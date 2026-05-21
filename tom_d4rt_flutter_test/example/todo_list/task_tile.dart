// One row in the todo list.
//
// Wraps the visible content in a `Dismissible` for swipe-to-delete
// and uses an `AnimatedContainer` to fade the strikethrough decoration
// in / out when `done` toggles. Tapping anywhere on the tile toggles
// completion; the leading `Checkbox` shares the same handler.
//
// A small `ReorderableDragStartListener` exposes a drag handle on the
// trailing edge so tests can drive reorder via pointer events without
// fighting long-press timing.
//
// The `Dismissible.confirmDismiss` returns the value of a
// `showModalBottomSheet` confirmation. When the user accepts, the
// outer `onConfirmedDismiss` runs to mutate the store; when the user
// cancels, the tile snaps back via Flutter's framework.
import 'package:flutter/material.dart';

import 'task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  /// Position of the tile in the *visible* list, used to mount the
  /// drag handle (`ReorderableDragStartListener` needs the index).
  final int index;

  final VoidCallback onToggle;
  final VoidCallback onConfirmedDismiss;

  /// Confirmation hook — returns `true` to accept the dismiss,
  /// `false`/`null` to cancel. The home page wires this to a
  /// `showModalBottomSheet` callback so the bottom sheet UI lives at
  /// the page level (one bottom sheet at a time).
  final Future<bool> Function() onAskDismiss;

  const TaskTile({
    super.key,
    required this.task,
    required this.index,
    required this.onToggle,
    required this.onAskDismiss,
    required this.onConfirmedDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final baseStyle = theme.bodyLarge ?? const TextStyle(fontSize: 16.0);

    return Dismissible(
      key: ValueKey<int>(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Icon(
          Icons.delete_outline,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
      confirmDismiss: (_) async {
        final ok = await onAskDismiss();
        return ok;
      },
      onDismissed: (_) => onConfirmedDismiss(),
      child: ListTile(
        key: Key('task-tile-${task.id}'),
        leading: Checkbox(
          key: Key('task-check-${task.id}'),
          value: task.done,
          onChanged: (_) => onToggle(),
        ),
        title: AnimatedContainer(
          key: Key('task-text-${task.id}'),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Text(
            task.text,
            style: baseStyle.copyWith(
              decoration: task.done
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: task.done
                  ? baseStyle.color?.withOpacity(0.5)
                  : baseStyle.color,
            ),
          ),
        ),
        trailing: ReorderableDragStartListener(
          key: Key('drag-handle-${task.id}'),
          index: index,
          child: const Icon(Icons.drag_handle),
        ),
        onTap: onToggle,
      ),
    );
  }
}
