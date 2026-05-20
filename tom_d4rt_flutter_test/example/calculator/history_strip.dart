// History strip — horizontal scrollable list of past calculations,
// most-recent-last so the freshest result sits closest to the keypad.
//
// Empty state renders a placeholder hint. Tapping the "clear" icon
// invokes the host callback which calls
// `CalculatorEngine.clearHistory()` followed by `setState`.
//
// Each entry is keyed by its array position so the framework's
// element-recycling stays predictable across rebuilds.
import 'package:flutter/material.dart';

import 'engine.dart';

class HistoryStrip extends StatelessWidget {
  final List<HistoryEntry> entries;
  final VoidCallback onClear;

  /// When the user taps an entry, we surface it to the host so it can
  /// "recall" the result back into the operand line. Tests don't
  /// exercise this path yet but the hook is here for completeness.
  final void Function(HistoryEntry entry)? onRecall;

  const HistoryStrip({
    super.key,
    required this.entries,
    required this.onClear,
    this.onRecall,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      key: const ValueKey<String>('history-strip'),
      height: 64,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        border: Border(
          top: BorderSide(color: scheme.outlineVariant, width: 0.5),
          bottom: BorderSide(color: scheme.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: entries.isEmpty
                ? _EmptyHint(scheme: scheme)
                : _EntriesList(
                    entries: entries,
                    scheme: scheme,
                    onRecall: onRecall,
                  ),
          ),
          IconButton(
            key: const ValueKey<String>('history-clear'),
            tooltip: 'Clear history',
            onPressed: entries.isEmpty ? null : onClear,
            icon: Icon(
              Icons.delete_sweep_outlined,
              color: entries.isEmpty
                  ? scheme.onSurfaceVariant.withValues(alpha: 0.4)
                  : scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  final ColorScheme scheme;

  const _EmptyHint({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'No history yet',
          key: const ValueKey<String>('history-empty'),
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontStyle: FontStyle.italic,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _EntriesList extends StatelessWidget {
  final List<HistoryEntry> entries;
  final ColorScheme scheme;
  final void Function(HistoryEntry entry)? onRecall;

  const _EntriesList({
    required this.entries,
    required this.scheme,
    required this.onRecall,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const ValueKey<String>('history-list'),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      itemCount: entries.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return _HistoryChip(
          entry: entry,
          index: index,
          scheme: scheme,
          onRecall: onRecall,
        );
      },
    );
  }
}

class _HistoryChip extends StatelessWidget {
  final HistoryEntry entry;
  final int index;
  final ColorScheme scheme;
  final void Function(HistoryEntry entry)? onRecall;

  const _HistoryChip({
    required this.entry,
    required this.index,
    required this.scheme,
    required this.onRecall,
  });

  @override
  Widget build(BuildContext context) {
    final isError = entry.result == 'Error';
    final background =
        isError ? scheme.errorContainer : scheme.primaryContainer;
    final foreground =
        isError ? scheme.onErrorContainer : scheme.onPrimaryContainer;
    return Material(
      key: ValueKey<String>('history-entry-$index'),
      color: background,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onRecall == null ? null : () => onRecall!(entry),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                entry.expression,
                style: TextStyle(
                  color: foreground.withValues(alpha: 0.8),
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '=',
                style: TextStyle(
                  color: foreground.withValues(alpha: 0.6),
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                entry.result,
                style: TextStyle(
                  color: foreground,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
