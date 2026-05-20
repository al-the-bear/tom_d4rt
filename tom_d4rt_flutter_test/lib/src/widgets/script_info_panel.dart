/// Header panel that names the currently selected script and shows
/// progress through the corpus (e.g. "12 / 487").
library;

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../test_runner.dart';

/// Reads from a [TestRunner]; rebuilds on every runner notification.
///
/// Greys itself out when there are no scripts loaded — the surrounding
/// `PathBar` already explains *why* (path missing or empty), so this panel
/// just needs to convey "nothing to show" without crashing.
class ScriptInfoPanel extends StatelessWidget {
  final TestRunner runner;

  const ScriptInfoPanel({super.key, required this.runner});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: runner,
      builder: (context, _) {
        final theme = Theme.of(context);
        final empty = runner.scripts.isEmpty;
        final current = runner.current;
        final cluster = current == null ? '—' : _cluster(current.name);
        final scriptName =
            current == null ? 'No scripts loaded' : p.basename(current.name);
        final indexLabel = empty
            ? '0 / 0'
            : '${runner.currentIndex + 1} / ${runner.scripts.length}';

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Opacity(
            opacity: empty ? 0.55 : 1.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cluster,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        scriptName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontFamily: 'monospace',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                _IndexBadge(label: indexLabel, status: runner.status),
              ],
            ),
          ),
        );
      },
    );
  }

  /// First path segment of the script name, used as the cluster label.
  /// Returns `'<root>'` for scripts directly under the chosen root.
  static String _cluster(String relativeName) {
    final segments = p.split(relativeName);
    return segments.length > 1 ? segments.first : '<root>';
  }
}

class _IndexBadge extends StatelessWidget {
  final String label;
  final RunnerStatus status;

  const _IndexBadge({required this.label, required this.status});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (bg, fg) = switch (status) {
      RunnerStatus.executing => (scheme.primary, scheme.onPrimary),
      RunnerStatus.idle => (scheme.surfaceContainerHighest, scheme.onSurface),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
