// Detail pane for the note_app sample — title + body editor.
//
// Owns two `TextEditingController`s for the title and body fields.
// The controllers' text is treated as the authoritative live value;
// the store snapshot is only read when the selected note changes
// (`didUpdateWidget`), so a typing user never has their cursor
// snapped back to the start by a rebuild from `notifyListeners`.
//
// Debounced auto-save:
//   * every keystroke increments `_saveToken` and schedules a
//     `Future.delayed(saveDebounce)`.
//   * after the delay, if `_saveToken` hasn't moved the editor calls
//     `store.markSaved()` and emits a SnackBar via the
//     `ScaffoldMessenger` passed in by the home page. If the user
//     kept typing, the stale firing is dropped — the latest one
//     wins. This is the classic debounce-via-token pattern (no
//     cancellable timer needed).
//
// Selection-change lifecycle:
//   * `didUpdateWidget` watches for `oldWidget.note.id !=
//     widget.note.id`. When it changes, the editor flushes any
//     pending debounce, resets the controllers to the new note's
//     content, and bumps the token so a stale Future.delayed
//     callback for the old note can't fire a SnackBar against the
//     new one.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'note.dart';

class NoteEditor extends StatefulWidget {
  final Note note;

  /// Push title/body changes back to the store.
  final void Function({String? title, String? body}) onChanged;

  /// Called after the debounce fires and `store.markSaved()` ran —
  /// the home page is responsible for emitting the actual SnackBar
  /// (it owns the `ScaffoldMessenger`).
  final void Function(int noteId) onSaved;

  /// Debounce delay between the last keystroke and the auto-save.
  /// Defaults to a short value so the tester doesn't wait long; a
  /// real app would pick 500–800ms.
  final Duration saveDebounce;

  const NoteEditor({
    super.key,
    required this.note,
    required this.onChanged,
    required this.onSaved,
    this.saveDebounce = const Duration(milliseconds: 250),
  });

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  late TextEditingController _titleCtrl;
  late TextEditingController _bodyCtrl;

  /// Token incremented on every change. The Future.delayed callback
  /// captures the token-at-schedule-time and only fires the save if
  /// no further change has arrived since.
  int _saveToken = 0;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.note.title);
    _bodyCtrl = TextEditingController(text: widget.note.body);
  }

  @override
  void didUpdateWidget(NoteEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.note.id != widget.note.id) {
      // Selection changed — reset the field contents and drop any
      // pending debounce against the previous note.
      _saveToken += 1;
      _titleCtrl.text = widget.note.title;
      _bodyCtrl.text = widget.note.body;
      print('editor.swap note=${widget.note.id}');
    } else {
      // Same note but store rebroadcast — sync only when the store
      // value diverges from what the user is typing (e.g. external
      // update). Skipping this on every parent rebuild keeps the
      // cursor stable.
      if (_titleCtrl.text != widget.note.title) {
        _titleCtrl.text = widget.note.title;
      }
      if (_bodyCtrl.text != widget.note.body) {
        _bodyCtrl.text = widget.note.body;
      }
    }
  }

  @override
  void dispose() {
    _saveToken += 1; // poison any in-flight debounce
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  void _scheduleSave() {
    _saveToken += 1;
    final token = _saveToken;
    final noteId = widget.note.id;
    Future<void>.delayed(widget.saveDebounce, () {
      if (!mounted) return;
      if (token != _saveToken) return;
      if (widget.note.id != noteId) return;
      widget.onSaved(noteId);
    });
  }

  void _onTitleChanged(String value) {
    widget.onChanged(title: value);
    _scheduleSave();
  }

  void _onBodyChanged(String value) {
    widget.onChanged(body: value);
    _scheduleSave();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            key: const Key('editor-title'),
            controller: _titleCtrl,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            onChanged: _onTitleChanged,
          ),
          const SizedBox(height: 12.0),
          Expanded(
            child: TextField(
              key: const Key('editor-body'),
              controller: _bodyCtrl,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                labelText: 'Body',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              onChanged: _onBodyChanged,
            ),
          ),
        ],
      ),
    );
  }
}
