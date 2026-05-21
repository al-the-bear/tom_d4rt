// Master pane for the note_app sample — list of notes.
//
// Stateless: receives the store's snapshot via props and forwards
// taps back to the home page. Renders an empty-state placeholder
// when the list is empty so the layout doesn't show a blank pane
// (which can confuse first-time users — "is the app broken?").
//
// Each row is a `ListTile`:
//   * key `note-row-{id}` so tests can find the right row,
//   * title = `note.displayTitle`,
//   * subtitle = `note.previewLine`,
//   * trailing dot for the currently-selected row.
//
// Tap routes through `onSelect(id)` rather than mutating the store
// directly so the home page can drive narrow-layout `Navigator.push`
// behaviour on top of the selection change.
import 'package:flutter/material.dart';

import 'note.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  final int? selectedId;
  final void Function(int id) onSelect;

  const NoteList({
    super.key,
    required this.notes,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return Center(
        key: const Key('list-empty-state'),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'No notes yet — tap + to create one.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    return ListView.builder(
      key: const Key('note-list'),
      itemCount: notes.length,
      itemBuilder: (BuildContext _, int i) {
        final note = notes[i];
        final isSelected = note.id == selectedId;
        return ListTile(
          key: Key('note-row-${note.id}'),
          selected: isSelected,
          title: Text(
            note.displayTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            note.previewLine,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: isSelected
              ? const Icon(Icons.circle, size: 10.0)
              : null,
          onTap: () => onSelect(note.id),
        );
      },
    );
  }
}
