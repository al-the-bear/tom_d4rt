// ChangeNotifier-backed note store for the note_app sample.
//
// Owns the notes list, the currently selected id (or `null` when no
// note is selected), and a monotonically increasing id allocator.
// Every mutation emits a single `note.*` trail line so tests can
// assert behaviour without scraping widgets.
//
// Auto-save model — `update()` does NOT immediately fire a
// `note.save`. Instead the editor wires a `Future.delayed` debounce
// (see `editor.dart`) that calls `markSaved()` after the user pauses
// typing. The store just tracks "dirty" so the SnackBar can show
// the right message.
//
// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';

import 'note.dart';

class NoteStore extends ChangeNotifier {
  final List<Note> _notes = <Note>[];
  int? _selectedId;
  int _nextId = 1;
  bool _dirty = false;

  /// Unmodifiable view of the notes list. Mutations to the returned
  /// list are forbidden — the store owns the underlying storage.
  List<Note> get notes => List<Note>.unmodifiable(_notes);

  int? get selectedId => _selectedId;

  /// The currently-selected note, or `null` when no note is selected
  /// (either empty store or the user is on the empty placeholder).
  Note? get selected {
    final id = _selectedId;
    if (id == null) return null;
    for (final n in _notes) {
      if (n.id == id) return n;
    }
    return null;
  }

  /// `true` while there are unsaved edits in flight (between an
  /// `update` and the next `markSaved`). Drives the AppBar dot in
  /// the editor and the SnackBar's text.
  bool get dirty => _dirty;

  /// Append a new empty note, select it, and return its id so the
  /// caller can route navigation. The new note is intentionally
  /// blank — the editor renders placeholders for the title and body
  /// fields until the user types something.
  int addBlank() {
    final note = Note(id: _nextId, title: '', body: '');
    _nextId += 1;
    _notes.add(note);
    _selectedId = note.id;
    _dirty = false;
    print('note.add id=${note.id}');
    notifyListeners();
    return note.id;
  }

  /// Select the note with [id]. Pass `null` to clear the selection
  /// (used when the only note is deleted).
  void select(int? id) {
    if (id == _selectedId) return;
    _selectedId = id;
    _dirty = false;
    print('note.select id=$id');
    notifyListeners();
  }

  /// Replace the title and/or body of the selected note (no-op if
  /// nothing is selected). Marks the store dirty so the editor's
  /// debounce knows to schedule a save.
  void updateSelected({String? title, String? body}) {
    final id = _selectedId;
    if (id == null) return;
    final idx = _notes.indexWhere((n) => n.id == id);
    if (idx == -1) return;
    final old = _notes[idx];
    final next = old.copyWith(title: title, body: body);
    if (next.title == old.title && next.body == old.body) return;
    _notes[idx] = next;
    _dirty = true;
    print('note.update id=$id title="${next.title}" '
        'body.len=${next.body.length}');
    notifyListeners();
  }

  /// Flip the dirty flag back to clean. Called from the editor's
  /// debounced save after the SnackBar fires.
  void markSaved() {
    if (!_dirty) return;
    _dirty = false;
    print('note.save id=$_selectedId');
    notifyListeners();
  }

  /// Remove the note with [id]. If it was selected, advance the
  /// selection to the previous note (or clear when the list empties).
  void delete(int id) {
    final idx = _notes.indexWhere((n) => n.id == id);
    if (idx == -1) {
      print('note.delete.miss id=$id');
      return;
    }
    _notes.removeAt(idx);
    if (_selectedId == id) {
      if (_notes.isEmpty) {
        _selectedId = null;
      } else {
        final fallback = idx > 0 ? idx - 1 : 0;
        _selectedId = _notes[fallback].id;
      }
    }
    _dirty = false;
    print('note.delete id=$id remaining=${_notes.length} '
        'next_selected=$_selectedId');
    notifyListeners();
  }
}
