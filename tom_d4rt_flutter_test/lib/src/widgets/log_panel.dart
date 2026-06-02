/// "Log" tab — renders streamed thinking, assistant text, status lines,
/// and errors. When the generator reaches the done state, the panel
/// surfaces a "Run" button that routes the host into [SampleAppPage]
/// with the freshly written sample.
library;

import 'package:flutter/material.dart';

import '../generator/generator_notifier.dart';
import '../sample_apps_notifier.dart';

class LogPanel extends StatefulWidget {
  final GeneratorNotifier notifier;
  final SampleAppsNotifier samples;
  final void Function(SampleAppEntry sample) onRun;

  const LogPanel({
    super.key,
    required this.notifier,
    required this.samples,
    required this.onRun,
  });

  @override
  State<LogPanel> createState() => _LogPanelState();
}

class _LogPanelState extends State<LogPanel> {
  final _scroll = ScrollController();
  int _lastBlockCount = 0;
  int _lastTailLength = 0;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_onNotifierChanged);
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onNotifierChanged);
    _scroll.dispose();
    super.dispose();
  }

  void _onNotifierChanged() {
    final blocks = widget.notifier.blocks;
    final tailLen = blocks.isEmpty ? 0 : blocks.last.text.length;
    final changed = blocks.length != _lastBlockCount || tailLen != _lastTailLength;
    _lastBlockCount = blocks.length;
    _lastTailLength = tailLen;
    setState(() {});
    if (changed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scroll.hasClients) return;
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _runGenerated() {
    final name = widget.notifier.generatedAppName;
    if (name == null) return;
    SampleAppEntry? match;
    for (final s in widget.samples.samples) {
      if (s.name == name) {
        match = s;
        break;
      }
    }
    // Desktop-only path: the disk source uses the main.dart path as the
    // entry locator, so this matches the freshly generated app on disk.
    match ??= widget.samples.samples
        .where((s) => s.locator == widget.notifier.generatedMainPath)
        .firstOrNull;
    if (match != null) widget.onRun(match);
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.notifier;
    final blocks = n.blocks;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(notifier: n),
        const Divider(height: 1),
        Expanded(
          child: blocks.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No generation yet. Open the Generate tab, '
                      'enter a description, then click "Send prompt".',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: scheme.outline),
                    ),
                  ),
                )
              : ListView.builder(
                  controller: _scroll,
                  padding: const EdgeInsets.all(12),
                  itemCount: blocks.length,
                  itemBuilder: (context, i) => _BlockTile(block: blocks[i]),
                ),
        ),
        if (n.canRun) _RunBar(onRun: _runGenerated, notifier: n),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final GeneratorNotifier notifier;
  const _Header({required this.notifier});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Color color;
    String label;
    IconData icon;
    switch (notifier.state) {
      case GenerationState.idle:
        color = scheme.outline;
        label = 'Idle';
        icon = Icons.circle_outlined;
      case GenerationState.sending:
        color = scheme.primary;
        label = 'Sending…';
        icon = Icons.cloud_upload_outlined;
      case GenerationState.streaming:
        color = scheme.primary;
        label = 'Streaming…';
        icon = Icons.bolt_outlined;
      case GenerationState.executingTools:
        color = scheme.primary;
        label = 'Executing tool calls…';
        icon = Icons.build_outlined;
      case GenerationState.done:
        color = scheme.tertiary;
        label = 'Done — ready to run';
        icon = Icons.check_circle_outline;
      case GenerationState.error:
        color = scheme.error;
        label = notifier.errorMessage ?? 'Error';
        icon = Icons.error_outline;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: scheme.surfaceContainerHigh,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ),
          if (notifier.isBusy)
            TextButton.icon(
              onPressed: notifier.cancel,
              icon: const Icon(Icons.cancel_outlined, size: 16),
              label: const Text('Cancel'),
            )
          else if (notifier.blocks.isNotEmpty)
            TextButton.icon(
              // "Clear" wipes the whole session (FS + history + log)
              // — the only honest interpretation now that we keep
              // state across follow-up prompts. The button label
              // matches that semantics.
              onPressed: notifier.resetSession,
              icon: const Icon(Icons.delete_outline, size: 16),
              label: const Text('Reset session'),
            ),
        ],
      ),
    );
  }
}

class _BlockTile extends StatelessWidget {
  final LogBlock block;
  const _BlockTile({required this.block});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    late Color background;
    late Color foreground;
    late String tag;
    late IconData icon;
    switch (block.kind) {
      case LogBlockKind.status:
        background = scheme.surfaceContainerHigh;
        foreground = scheme.onSurfaceVariant;
        tag = 'STATUS';
        icon = Icons.info_outline;
      case LogBlockKind.thinking:
        background = scheme.secondaryContainer;
        foreground = scheme.onSecondaryContainer;
        tag = 'THINKING';
        icon = Icons.psychology_outlined;
      case LogBlockKind.text:
        background = scheme.surface;
        foreground = scheme.onSurface;
        tag = 'TEXT';
        icon = Icons.chat_bubble_outline;
      case LogBlockKind.toolCall:
        background = scheme.tertiaryContainer;
        foreground = scheme.onTertiaryContainer;
        tag = 'TOOL CALL';
        icon = Icons.build_outlined;
      case LogBlockKind.toolResult:
        background = scheme.surfaceContainerHigh;
        foreground = scheme.onSurfaceVariant;
        tag = 'TOOL RESULT';
        icon = Icons.check_outlined;
      case LogBlockKind.error:
        background = scheme.errorContainer;
        foreground = scheme.onErrorContainer;
        tag = 'ERROR';
        icon = Icons.error_outline;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
            child: Row(
              children: [
                Icon(icon, size: 14, color: foreground),
                const SizedBox(width: 6),
                Text(
                  tag,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                    color: foreground,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: SelectableText(
              block.text,
              style: TextStyle(
                fontFamily: block.kind == LogBlockKind.text ||
                        block.kind == LogBlockKind.thinking
                    ? null
                    : 'monospace',
                // Italicise THINKING so it reads visibly as
                // reasoning rather than the model's final answer.
                fontStyle: block.kind == LogBlockKind.thinking
                    ? FontStyle.italic
                    : FontStyle.normal,
                fontSize: 13,
                height: 1.4,
                color: foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RunBar extends StatelessWidget {
  final VoidCallback onRun;
  final GeneratorNotifier notifier;
  const _RunBar({required this.onRun, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      color: scheme.tertiaryContainer,
      child: Row(
        children: [
          Icon(Icons.play_circle_outline, color: scheme.onTertiaryContainer),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Generated "${notifier.generatedAppName}" — '
              'click Run to interpret it.',
              style: TextStyle(
                color: scheme.onTertiaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FilledButton.icon(
            onPressed: onRun,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Run'),
          ),
        ],
      ),
    );
  }
}
