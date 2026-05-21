/// "File Inspector" tab — split view over the generator's in-memory
/// virtual filesystem. Left pane lists every file the session has
/// produced so far (sorted alphabetically); right pane shows the
/// content of whichever file the user taps.
///
/// Listens to [GeneratorNotifier]: as the model streams `write_file`
/// tool calls during a turn, the list updates live and the active
/// viewer refreshes if the selected file changed.
library;

import 'package:flutter/material.dart';

import '../generator/generator_notifier.dart';

class FileInspectorPanel extends StatefulWidget {
  final GeneratorNotifier notifier;
  const FileInspectorPanel({super.key, required this.notifier});

  @override
  State<FileInspectorPanel> createState() => _FileInspectorPanelState();
}

class _FileInspectorPanelState extends State<FileInspectorPanel> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_onNotifierChanged);
    _autoSelectIfNeeded();
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onNotifierChanged);
    super.dispose();
  }

  void _onNotifierChanged() {
    if (!mounted) return;
    setState(() {
      // If the previously-selected file no longer exists (deleted or
      // session reset), drop the selection so the right pane shows
      // the empty placeholder instead of stale content.
      if (_selected != null &&
          widget.notifier.readSessionFile(_selected!) == null) {
        _selected = null;
      }
      _autoSelectIfNeeded();
    });
  }

  /// Helpful default: when the session first produces files, pre-
  /// select `main.dart` (if present) so the user lands on something
  /// meaningful without having to click.
  void _autoSelectIfNeeded() {
    if (_selected != null) return;
    final files = widget.notifier.sessionFiles;
    if (files.isEmpty) return;
    if (files.contains('main.dart')) {
      _selected = 'main.dart';
    } else {
      _selected = files.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.notifier;
    final files = n.sessionFiles;
    final scheme = Theme.of(context).colorScheme;
    if (files.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            n.hasSession
                ? 'Session is active but no files yet — start a turn '
                    'that calls write_file.'
                : 'No active session. Send a prompt from the Generate '
                    'tab and the files will appear here as the model '
                    'writes them.',
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.outline),
          ),
        ),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FileList(
          files: files,
          selected: _selected,
          notifier: n,
          onPick: (path) => setState(() => _selected = path),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: _FileViewer(
            notifier: n,
            path: _selected,
          ),
        ),
      ],
    );
  }
}

class _FileList extends StatelessWidget {
  final List<String> files;
  final String? selected;
  final GeneratorNotifier notifier;
  final void Function(String path) onPick;

  const _FileList({
    required this.files,
    required this.selected,
    required this.notifier,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
            color: scheme.surfaceContainerHigh,
            child: Row(
              children: [
                Icon(Icons.folder_open, size: 16, color: scheme.onSurfaceVariant),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    notifier.sessionAppName ?? 'session',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
                Text(
                  '${files.length}',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.outline,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, i) {
                final path = files[i];
                final content = notifier.readSessionFile(path);
                final size = content?.length ?? 0;
                final selectedThis = path == selected;
                return InkWell(
                  onTap: () => onPick(path),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
                    color: selectedThis
                        ? scheme.primaryContainer
                        : Colors.transparent,
                    child: Row(
                      children: [
                        Icon(
                          _iconFor(path),
                          size: 14,
                          color: selectedThis
                              ? scheme.onPrimaryContainer
                              : scheme.outline,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            path,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12.5,
                              fontWeight: selectedThis
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: selectedThis
                                  ? scheme.onPrimaryContainer
                                  : scheme.onSurface,
                            ),
                          ),
                        ),
                        Text(
                          _humanSize(size),
                          style: TextStyle(
                            fontSize: 11,
                            color: selectedThis
                                ? scheme.onPrimaryContainer
                                : scheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String path) {
    if (path.endsWith('.dart')) return Icons.code;
    if (path.endsWith('.yaml') || path.endsWith('.yml')) {
      return Icons.settings_outlined;
    }
    if (path.endsWith('.md')) return Icons.description_outlined;
    if (path.endsWith('.json')) return Icons.data_object;
    return Icons.insert_drive_file_outlined;
  }

  String _humanSize(int n) {
    if (n < 1024) return '${n}b';
    final kb = n / 1024;
    if (kb < 100) return '${kb.toStringAsFixed(1)}k';
    return '${kb.toStringAsFixed(0)}k';
  }
}

class _FileViewer extends StatelessWidget {
  final GeneratorNotifier notifier;
  final String? path;

  const _FileViewer({required this.notifier, required this.path});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (path == null) {
      return Center(
        child: Text(
          'Select a file on the left to view its content.',
          style: TextStyle(color: scheme.outline),
        ),
      );
    }
    final content = notifier.readSessionFile(path!);
    if (content == null) {
      return Center(
        child: Text(
          'File no longer exists: $path',
          style: TextStyle(color: scheme.outline),
        ),
      );
    }
    final lineCount = '\n'.allMatches(content).length + 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
          color: scheme.surfaceContainerHigh,
          child: Row(
            children: [
              Icon(Icons.description_outlined,
                  size: 16, color: scheme.onSurfaceVariant),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  path!,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              Text(
                '$lineCount lines · ${content.length} chars',
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.outline,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          // Two-axis scrolling — Dart source code with long lines
          // (build trees, comments) would otherwise wrap and lose
          // readability. Horizontal viewport keeps lines intact.
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SelectableText(
                  content,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
