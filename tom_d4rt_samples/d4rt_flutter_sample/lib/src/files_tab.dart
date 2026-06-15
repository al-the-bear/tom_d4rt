/// "Files" tab: browse every bundled `.dart` file in a tree and read its
/// content in a read-only, copyable pane.
///
/// The tree (left) lists each sample group plus the hand-authored
/// `copy-paste-samples` group; selecting a file shows its source (right). The
/// viewer is read-only but fully selectable, with a Copy button.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

import 'asset_catalog.dart';

class FilesTab extends StatefulWidget {
  final AssetCatalog catalog;

  const FilesTab({super.key, required this.catalog});

  @override
  State<FilesTab> createState() => _FilesTabState();
}

class _FilesTabState extends State<FilesTab>
    with AutomaticKeepAliveClientMixin {
  List<SampleFiles> _groups = const [];
  bool _loading = true;
  String? _loadError;

  FileNode? _selected;
  String? _content;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final groups = await widget.catalog.groups();
      if (!mounted) return;
      setState(() {
        _groups = groups;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadError = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _select(FileNode node) async {
    setState(() {
      _selected = node;
      _content = null;
    });
    final content = await widget.catalog.loadContent(node);
    if (!mounted) return;
    setState(() => _content = content);
  }

  Future<void> _copy() async {
    if (_content == null) return;
    await Clipboard.setData(ClipboardData(text: _content!));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_loadError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Could not list files:\n\n$_loadError',
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ),
      );
    }

    final width = MediaQuery.sizeOf(context).width;
    final treeWidth = width < 720 ? 200.0 : 300.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: treeWidth, child: _tree()),
        const VerticalDivider(width: 1),
        Expanded(child: _viewer()),
      ],
    );
  }

  Widget _tree() {
    return ListView(
      children: [
        for (final group in _groups)
          _GroupTile(
            group: group,
            selected: _selected,
            onSelect: _select,
          ),
      ],
    );
  }

  Widget _viewer() {
    final scheme = Theme.of(context).colorScheme;
    if (_selected == null) {
      return Center(
        child: Text(
          'Select a file to view its source.',
          style: TextStyle(color: scheme.outline),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: scheme.surfaceContainerHigh,
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _selected!.relPath,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Copy',
                onPressed: _content == null ? null : _copy,
                icon: const Icon(Icons.copy, size: 18),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: _content == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: SelectableText(
                    _content!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _GroupTile extends StatelessWidget {
  final SampleFiles group;
  final FileNode? selected;
  final ValueChanged<FileNode> onSelect;

  const _GroupTile({
    required this.group,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ExpansionTile(
      initiallyExpanded: group.runnable,
      leading: Icon(
        group.runnable ? Icons.folder_outlined : Icons.content_paste_outlined,
        size: 20,
      ),
      title: Text(
        group.name,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      subtitle: group.runnable
          ? null
          : Text('snippets', style: TextStyle(color: scheme.outline, fontSize: 11)),
      childrenPadding: const EdgeInsets.only(left: 8),
      children: [
        for (final file in group.files)
          ListTile(
            dense: true,
            leading: const Icon(Icons.description_outlined, size: 18),
            title: Text(
              file.relPath,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
            ),
            selected: file.assetKey == selected?.assetKey,
            selectedTileColor: scheme.secondaryContainer,
            onTap: () => onSelect(file),
          ),
      ],
    );
  }
}
