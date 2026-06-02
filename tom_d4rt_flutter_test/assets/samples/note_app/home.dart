// Top-level page for the note_app sample (example #14).
//
// Owns the long-lived `NoteStore`. Listens to it via `ListenableBuilder`
// so the list, editor, and AppBar rebuild together on any mutation.
//
// Layout strategy via `LayoutBuilder`:
//   * wide (>= breakpoint): two-pane Row — `NoteList` (320 px) on
//     the left, `NoteEditor` filling the remaining space on the
//     right.
//   * narrow (< breakpoint): single-pane stack — the list is the
//     main page; tapping a row pushes the editor onto the
//     `Navigator` via `Navigator.push`. The FAB on the list page
//     creates a blank note and immediately pushes its editor.
//
// The home page hosts the `Scaffold` + `ScaffoldMessenger`, so
// dialog/sheet/SnackBar all root off the same `BuildContext`. The
// editor calls back into `_emitSaved` after its debounced save —
// the home page picks the SnackBar message from `_dirty` so the
// text reads "Saved" rather than "Saving…".
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'dialogs.dart';
import 'editor.dart';
import 'note.dart';
import 'note_list.dart';
import 'store.dart';

/// Pixel breakpoint between the side-by-side and stacked layouts.
/// Picked to match common phone widths (Pixel 5 is 412 dp).
const double _wideBreakpoint = 700.0;

class NoteAppHome extends StatefulWidget {
  const NoteAppHome({super.key});

  @override
  State<NoteAppHome> createState() => _NoteAppHomeState();
}

class _NoteAppHomeState extends State<NoteAppHome> {
  late NoteStore _store;

  @override
  void initState() {
    super.initState();
    _store = NoteStore();
    print('note.init n=${_store.notes.length}');
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  // ----- side-effects -----

  Future<void> _confirmDelete(BuildContext ctx, Note note) async {
    final ok = await confirmDelete(ctx, note);
    if (!ok) {
      print('note.delete.cancelled id=${note.id}');
      return;
    }
    _store.delete(note.id);
    if (!mounted) return;
    // If we're on the narrow stack the editor is the top route — pop
    // it so the user lands back on the list after delete.
    final navigator = Navigator.of(ctx);
    if (navigator.canPop()) navigator.pop();
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        key: const Key('snackbar-deleted'),
        duration: const Duration(milliseconds: 600),
        content: Text('Deleted "${note.displayTitle}"'),
      ),
    );
  }

  Future<void> _openShareSheet(BuildContext ctx, Note note) async {
    final ok = await showShareSheet(ctx, note);
    if (!ok) {
      print('note.share.cancelled id=${note.id}');
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        key: const Key('snackbar-shared'),
        duration: const Duration(milliseconds: 600),
        content: Text('Shared "${note.displayTitle}"'),
      ),
    );
  }

  void _emitSaved(BuildContext ctx, int noteId) {
    // The editor calls this after the debounce fires. We flip the
    // store's dirty flag (which would otherwise still be `true`) and
    // surface a SnackBar so the user sees confirmation.
    final wasDirty = _store.dirty;
    _store.markSaved();
    if (!mounted || !wasDirty) return;
    final messenger = ScaffoldMessenger.of(ctx);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      const SnackBar(
        key: Key('snackbar-saved'),
        duration: Duration(milliseconds: 600),
        content: Text('Saved'),
      ),
    );
  }

  // ----- narrow-layout navigation -----

  Future<void> _pushEditor(BuildContext rootCtx, int noteId) async {
    // Push a new MaterialPageRoute showing just the editor for the
    // selected note. The Navigator owns the route stack; popping
    // back returns the user to the list.
    await Navigator.of(rootCtx).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext routeCtx) {
          return ListenableBuilder(
            listenable: _store,
            builder: (BuildContext innerCtx, Widget? _) {
              final note = _store.selected;
              if (note == null || note.id != noteId) {
                // Note was deleted while the editor was open — pop
                // back. Schedule the pop after the current build so
                // we don't tear down the route mid-build.
                Future<void>.microtask(() {
                  if (Navigator.of(routeCtx).canPop()) {
                    Navigator.of(routeCtx).pop();
                  }
                });
                return const Scaffold(
                  body: Center(child: Text('Note no longer exists.')),
                );
              }
              return Scaffold(
                appBar: _buildEditorAppBar(routeCtx, note),
                body: NoteEditor(
                  key: ValueKey<int>(note.id),
                  note: note,
                  onChanged: _onEditorChanged,
                  onSaved: (id) => _emitSaved(routeCtx, id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  AppBar _buildEditorAppBar(BuildContext ctx, Note note) {
    return AppBar(
      key: Key('editor-appbar-${note.id}'),
      title: Text(
        note.displayTitle,
        key: Key('editor-appbar-title-${note.id}'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: <Widget>[
        IconButton(
          key: const Key('appbar-share'),
          icon: const Icon(Icons.share_outlined),
          tooltip: 'Share',
          onPressed: () => _openShareSheet(ctx, note),
        ),
        IconButton(
          key: const Key('appbar-delete'),
          icon: const Icon(Icons.delete_outline),
          tooltip: 'Delete',
          onPressed: () => _confirmDelete(ctx, note),
        ),
      ],
    );
  }

  // ----- store-bound callbacks -----

  void _onEditorChanged({String? title, String? body}) {
    _store.updateSelected(title: title, body: body);
  }

  Future<void> _onFabPressed(
      BuildContext rootCtx, bool isNarrow) async {
    final id = _store.addBlank();
    if (isNarrow) {
      await _pushEditor(rootCtx, id);
    }
  }

  // ----- build -----

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _store,
      builder: (BuildContext ctx, Widget? _) {
        return LayoutBuilder(
          builder: (BuildContext layoutCtx, BoxConstraints constraints) {
            final isNarrow = constraints.maxWidth < _wideBreakpoint;
            return Scaffold(
              key: ValueKey<bool>(isNarrow), // separate Messenger per layout
              appBar: _buildHomeAppBar(isNarrow),
              floatingActionButton: FloatingActionButton(
                key: const Key('fab-new-note'),
                onPressed: () => _onFabPressed(ctx, isNarrow),
                child: const Icon(Icons.add),
              ),
              body: isNarrow
                  ? _buildNarrow(ctx)
                  : _buildWide(ctx),
            );
          },
        );
      },
    );
  }

  AppBar _buildHomeAppBar(bool isNarrow) {
    final selected = _store.selected;
    final List<Widget> actions = <Widget>[];
    if (!isNarrow && selected != null) {
      actions.add(IconButton(
        key: const Key('appbar-share'),
        icon: const Icon(Icons.share_outlined),
        tooltip: 'Share',
        onPressed: () => _openShareSheet(context, selected),
      ));
      actions.add(IconButton(
        key: const Key('appbar-delete'),
        icon: const Icon(Icons.delete_outline),
        tooltip: 'Delete',
        onPressed: () => _confirmDelete(context, selected),
      ));
    }
    return AppBar(
      key: const Key('home-appbar'),
      title: Text(
        isNarrow ? 'Notes' : 'Notes (${_store.notes.length})',
        key: const Key('home-appbar-title'),
      ),
      actions: actions,
    );
  }

  Widget _buildWide(BuildContext ctx) {
    final selected = _store.selected;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: 320.0,
          child: Material(
            elevation: 0.0,
            child: NoteList(
              notes: _store.notes,
              selectedId: _store.selectedId,
              onSelect: _store.select,
            ),
          ),
        ),
        const VerticalDivider(width: 1.0),
        Expanded(
          child: selected == null
              ? Center(
                  key: const Key('editor-empty-state'),
                  child: Text(
                    'Pick a note on the left, or tap + to create one.',
                    style: Theme.of(ctx).textTheme.bodyMedium,
                  ),
                )
              // No ValueKey on `selected.id` here: we want the editor
              // State to persist across selection changes so its
              // `didUpdateWidget` runs and resets the controllers,
              // rather than tearing the State down and rebuilding it.
              : NoteEditor(
                  note: selected,
                  onChanged: _onEditorChanged,
                  onSaved: (id) => _emitSaved(ctx, id),
                ),
        ),
      ],
    );
  }

  Widget _buildNarrow(BuildContext ctx) {
    return NoteList(
      notes: _store.notes,
      selectedId: _store.selectedId,
      onSelect: (int id) async {
        _store.select(id);
        await _pushEditor(ctx, id);
      },
    );
  }
}
