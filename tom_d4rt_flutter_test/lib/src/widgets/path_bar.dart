/// Top-of-window strip showing the current script-root path with a Browse
/// button and a "Path not found" affordance when the path does not resolve.
library;

import 'package:flutter/material.dart';

import '../script_root_notifier.dart';

/// Horizontal bar bound to a [ScriptRootNotifier].
///
/// Rebuilds whenever the notifier fires — both on path changes and after the
/// user dismisses the directory picker — so the `exists` check stays current
/// without polling.
class PathBar extends StatelessWidget {
  final ScriptRootNotifier notifier;

  const PathBar({super.key, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        final scheme = Theme.of(context).colorScheme;
        final exists = notifier.exists;
        return Material(
          color: exists ? scheme.surfaceContainerLow : scheme.errorContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Icon(
                  exists ? Icons.folder_outlined : Icons.folder_off_outlined,
                  size: 18,
                  color: exists ? scheme.onSurface : scheme.onErrorContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Tooltip(
                    message: notifier.root,
                    child: Text(
                      notifier.root,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: exists
                            ? scheme.onSurface
                            : scheme.onErrorContainer,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                if (!exists) ...[
                  const SizedBox(width: 8),
                  const _NotFoundChip(),
                ],
                const SizedBox(width: 8),
                FilledButton.tonalIcon(
                  onPressed: notifier.pickDirectory,
                  icon: const Icon(Icons.folder_open, size: 16),
                  label: const Text('Browse'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NotFoundChip extends StatelessWidget {
  const _NotFoundChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.amber.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Path not found',
        style: TextStyle(
          fontSize: 11,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
