/// "Paste & Run" tab: paste a D4rt script and render it live.
///
/// A pasted script is a single Dart file with a top-level
/// `Widget build(BuildContext context)` — the same shape the bundled snippets
/// in `assets/copy_paste_samples/` use. Pressing Execute interprets it with
/// [SourceFlutterD4rt.build] and shows the resulting widget tree below.
library;

import 'package:flutter/material.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

import 'asset_catalog.dart';

/// Default script shown when the tab first opens.
const String _starterScript = '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Paste & Run')),
    body: const Center(
      child: Text(
        'Edit this code and press Execute,\\n'
        'or load a snippet from the menu above.',
        textAlign: TextAlign.center,
      ),
    ),
  );
}
''';

class PasteRunTab extends StatefulWidget {
  final SourceFlutterD4rt d4rt;
  final AssetCatalog catalog;

  const PasteRunTab({super.key, required this.d4rt, required this.catalog});

  @override
  State<PasteRunTab> createState() => _PasteRunTabState();
}

class _PasteRunTabState extends State<PasteRunTab>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller =
      TextEditingController(text: _starterScript.trim());

  List<FileNode> _snippets = const [];

  // Source pending interpretation. Interpretation runs inside [build] so a
  // real BuildContext (Theme/Navigator/MediaQuery) is in scope, mirroring the
  // proven SampleHostPage pattern.
  String? _runSource;
  Widget? _built;
  String? _error;
  StackTrace? _stack;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    widget.catalog.snippets().then((s) {
      if (mounted) setState(() => _snippets = s);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _execute() {
    setState(() {
      _runSource = _controller.text;
      _built = null;
      _error = null;
      _stack = null;
    });
  }

  void _clear() {
    setState(() {
      _controller.clear();
      _runSource = null;
      _built = null;
      _error = null;
      _stack = null;
    });
  }

  Future<void> _loadSnippet(FileNode node) async {
    final src = await widget.catalog.loadContent(node);
    if (!mounted) return;
    setState(() {
      _controller.text = src;
      _runSource = null;
      _built = null;
      _error = null;
      _stack = null;
    });
  }

  void _interpret(BuildContext context) {
    try {
      // Drop any previously script-declared names so re-running the same
      // snippet (or a different one) starts clean on the shared interpreter.
      widget.d4rt.resetScript();
      _built = widget.d4rt.build<Widget>(_runSource!, context);
    } on SourceFlutterD4rtException catch (e) {
      _error = e.message;
    } catch (e, st) {
      _error = e.toString();
      _stack = st;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_runSource != null && _built == null && _error == null) {
      _interpret(context);
    }
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _toolbar(scheme),
        const Divider(height: 1),
        Expanded(
          flex: 2,
          child: Container(
            color: scheme.surfaceContainerLowest,
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              expands: true,
              maxLines: null,
              minLines: null,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Paste a D4rt script with a top-level '
                    'Widget build(BuildContext context) { ... }',
                isDense: true,
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        Expanded(
          flex: 3,
          child: _result(scheme),
        ),
      ],
    );
  }

  Widget _toolbar(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          PopupMenuButton<FileNode>(
            enabled: _snippets.isNotEmpty,
            onSelected: _loadSnippet,
            itemBuilder: (_) => [
              for (final s in _snippets)
                PopupMenuItem<FileNode>(
                  value: s,
                  child: Text(
                    s.relPath,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.unfold_more, size: 20),
                SizedBox(width: 4),
                Text('Load snippet'),
              ],
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: _clear,
            icon: const Icon(Icons.clear),
            label: const Text('Clear'),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: _execute,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Execute'),
          ),
        ],
      ),
    );
  }

  Widget _result(ColorScheme scheme) {
    if (_error != null) {
      return _PasteError(message: _error!, stack: _stack);
    }
    if (_built != null) {
      return _built!;
    }
    return Center(
      child: Text(
        'Press Execute to render your script.',
        style: TextStyle(color: scheme.outline),
      ),
    );
  }
}

class _PasteError extends StatelessWidget {
  final String message;
  final StackTrace? stack;
  const _PasteError({required this.message, this.stack});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: scheme.error),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.error_outline, color: scheme.error, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Interpretation failed',
                      style: TextStyle(
                        color: scheme.error,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SelectableText(
                  message,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: scheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
          if (stack != null) ...[
            const SizedBox(height: 12),
            SelectableText(
              stack.toString(),
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }
}
