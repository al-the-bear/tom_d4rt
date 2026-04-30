/// Compact result panel showing the most recent script outcome.
///
/// Displays a pass/fail badge, the return-value type or error message,
/// captured print() output, and an expandable stack trace on failure.
/// The rendered widget itself lives in [D4rtScriptView] which sits above
/// this panel in the layout.
library;

import 'package:flutter/material.dart';

import '../test_runner.dart';

class ResultPanel extends StatelessWidget {
  final TestRunner runner;

  const ResultPanel({super.key, required this.runner});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: runner,
      builder: (context, _) {
        final result = runner.lastResult;
        if (result == null) {
          return const _EmptyState();
        }
        return _ResultBody(result: result);
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Text(
        'No result yet — press Play or Next',
        style: TextStyle(color: scheme.outline, fontSize: 12),
      ),
    );
  }
}

class _ResultBody extends StatefulWidget {
  final TestResult result;
  const _ResultBody({required this.result});

  @override
  State<_ResultBody> createState() => _ResultBodyState();
}

class _ResultBodyState extends State<_ResultBody> {
  bool _stackOpen = false;
  bool _outputOpen = false;

  @override
  void didUpdateWidget(_ResultBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Collapse expanded sections when a new result arrives so the user
    // sees the headline without scrolling.
    if (oldWidget.result != widget.result) {
      _stackOpen = false;
      _outputOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final result = widget.result;
    final scheme = theme.colorScheme;

    final accent = result.passed ? Colors.green.shade600 : scheme.error;
    final accentBg =
        result.passed ? Colors.green.shade50 : scheme.errorContainer;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Result headline ──────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: accentBg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: accent, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  result.passed ? Icons.check_circle : Icons.error,
                  color: accent,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.passed ? 'PASS' : 'FAIL',
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 2),
                      SelectableText(
                        result.info,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Captured output ──────────────────────────────────────────────
          if (result.output.isNotEmpty) ...[
            const SizedBox(height: 4),
            _SectionToggle(
              label: 'Output (${result.output.length} line'
                  '${result.output.length == 1 ? '' : 's'})',
              icon: Icons.terminal,
              open: _outputOpen,
              onToggle: () => setState(() => _outputOpen = !_outputOpen),
            ),
            if (_outputOpen) _OutputBlock(lines: result.output),
          ],

          // ── Stack trace ──────────────────────────────────────────────────
          if (result.stack != null) ...[
            const SizedBox(height: 4),
            _SectionToggle(
              label: 'Stack trace',
              icon: Icons.layers_outlined,
              open: _stackOpen,
              onToggle: () => setState(() => _stackOpen = !_stackOpen),
            ),
            if (_stackOpen) _StackBlock(stack: result.stack!),
          ],
        ],
      ),
    );
  }
}

class _SectionToggle extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool open;
  final VoidCallback onToggle;

  const _SectionToggle({
    required this.label,
    required this.icon,
    required this.open,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onToggle,
      icon: Icon(open ? Icons.expand_less : Icons.expand_more, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

class _OutputBlock extends StatelessWidget {
  final List<String> lines;
  const _OutputBlock({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(4),
      ),
      child: SelectableText(
        lines.join('\n'),
        style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
      ),
    );
  }
}

class _StackBlock extends StatelessWidget {
  final StackTrace stack;
  const _StackBlock({required this.stack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(4),
      ),
      child: SelectableText(
        stack.toString(),
        style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
      ),
    );
  }
}
