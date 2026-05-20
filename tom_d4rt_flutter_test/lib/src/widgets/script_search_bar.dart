/// Search field plus a 3-row preview of upcoming matches.
///
/// Typing in the field updates [TestRunner.setFilter] on every keystroke,
/// narrowing the navigable script list to entries whose full path contains
/// the substring (case-insensitive, position-independent).
///
/// Below the field, up to three rows show the current script and the next
/// two upcoming matches so the user can verify the filter matched the
/// intended files. Each row is clickable: tapping a row calls
/// [TestRunner.jumpTo] and runs that script immediately.
library;

import 'package:flutter/material.dart';

import '../test_runner.dart';
import '../test_script_loader.dart';

/// Search bar wired to a [TestRunner].
class ScriptSearchBar extends StatefulWidget {
  final TestRunner runner;

  const ScriptSearchBar({super.key, required this.runner});

  @override
  State<ScriptSearchBar> createState() => _ScriptSearchBarState();
}

class _ScriptSearchBarState extends State<ScriptSearchBar> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.runner.filterQuery);
    _ctrl.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    widget.runner.setFilter(_ctrl.text);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onTextChanged);
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return ListenableBuilder(
      listenable: widget.runner,
      builder: (context, _) {
        final runner = widget.runner;
        final hasFilter = runner.filterQuery.isNotEmpty;
        final filteredCount = runner.scripts.length;
        final totalCount = runner.totalScriptCount;
        return Material(
          color: scheme.surfaceContainerLowest,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.search, size: 18, color: scheme.onSurface),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.5,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Filter by name '
                              '(case-insensitive, anywhere in path)',
                          hintStyle: TextStyle(
                            fontSize: 12.5,
                            color: scheme.outline,
                          ),
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (hasFilter)
                      IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        tooltip: 'Clear filter',
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 28,
                          minHeight: 28,
                        ),
                        onPressed: _ctrl.clear,
                      ),
                    const SizedBox(width: 4),
                    _MatchCountBadge(
                      filtered: filteredCount,
                      total: totalCount,
                      hasFilter: hasFilter,
                    ),
                  ],
                ),
                _MatchPreviewList(runner: runner),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Renders up to three rows: the current script plus the next two upcoming
/// matches in the filtered view. Each row is tappable to jump+run.
///
/// When the filtered list is empty (search matched nothing), shows a single
/// "no matches" hint instead. When the list has fewer than 3 entries the
/// preview shrinks naturally — no padding rows.
class _MatchPreviewList extends StatelessWidget {
  final TestRunner runner;

  const _MatchPreviewList({required this.runner});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final scripts = runner.scripts;
    if (scripts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 4, left: 26),
        child: Text(
          runner.filterQuery.isEmpty
              ? 'No scripts loaded — check the path bar above.'
              : 'No matches for "${runner.filterQuery}".',
          style: TextStyle(
            fontSize: 11,
            color: scheme.outline,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    final currentIdx = runner.currentIndex.clamp(0, scripts.length - 1);
    final start = currentIdx;
    final end = (start + 3).clamp(0, scripts.length);
    final running = runner.status == RunnerStatus.executing;

    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = start; i < end; i++)
            _PreviewRow(
              index: i,
              script: scripts[i],
              isCurrent: i == currentIdx,
              disabled: running,
              onTap: running ? null : () => runner.jumpTo(i),
            ),
        ],
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  final int index;
  final TestScript script;
  final bool isCurrent;
  final bool disabled;
  final VoidCallback? onTap;

  const _PreviewRow({
    required this.index,
    required this.script,
    required this.isCurrent,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = disabled
        ? scheme.outline
        : (isCurrent ? scheme.primary : scheme.onSurface);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        child: Row(
          children: [
            Icon(
              isCurrent
                  ? Icons.play_arrow
                  : Icons.subdirectory_arrow_right,
              size: 14,
              color: color,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                script.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: color,
                  fontWeight:
                      isCurrent ? FontWeight.w700 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '#${index + 1}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: scheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MatchCountBadge extends StatelessWidget {
  final int filtered;
  final int total;
  final bool hasFilter;

  const _MatchCountBadge({
    required this.filtered,
    required this.total,
    required this.hasFilter,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = hasFilter ? '$filtered / $total' : '$total';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: hasFilter
            ? scheme.primaryContainer
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: hasFilter
              ? scheme.onPrimaryContainer
              : scheme.onSurface,
        ),
      ),
    );
  }
}
