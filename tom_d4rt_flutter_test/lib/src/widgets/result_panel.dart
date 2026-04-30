/// Scrollable panel showing the most-recent script outcome — pass/fail
/// badge, the result type or error message, and an expandable stack trace
/// on failure.
library;

import 'package:flutter/material.dart';

import '../test_runner.dart';

/// Listens to [TestRunner.lastResult] and renders the most recent outcome.
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
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.play_circle_outline,
            size: 48,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(
            'Press Play to start the script run',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final result = widget.result;
    final scheme = theme.colorScheme;
    final accent = result.passed
        ? Colors.green.shade600
        : scheme.error;
    final accentBg = result.passed
        ? Colors.green.shade50
        : scheme.errorContainer;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accent, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      result.passed ? Icons.check_circle : Icons.error,
                      color: accent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      result.passed ? 'PASS' : 'FAIL',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        result.scriptName,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SelectableText(
                  result.info,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (result.stack != null) ...[
            const SizedBox(height: 12),
            _StackToggle(
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

class _StackToggle extends StatelessWidget {
  final bool open;
  final VoidCallback onToggle;
  const _StackToggle({required this.open, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onToggle,
      icon: Icon(open ? Icons.expand_less : Icons.expand_more, size: 18),
      label: Text(open ? 'Hide stack trace' : 'Show stack trace'),
      style: TextButton.styleFrom(alignment: Alignment.centerLeft),
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
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(6),
      ),
      child: SelectableText(
        stack.toString(),
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
        ),
      ),
    );
  }
}
