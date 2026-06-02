// Plain note model for the note_app sample (example #14).
//
// Immutable triple (`id`, `title`, `body`). The store owns the source
// of truth and replaces notes by id whenever the editor commits a
// change, so `Note` itself stays value-like.
//
// `previewLine` is the first non-empty line of `body` (falling back
// to the title) — the list pane shows it under the title to mimic
// the master/detail apps the spec is modelled on.
import 'package:flutter/foundation.dart';

@immutable
class Note {
  final int id;
  final String title;
  final String body;

  const Note({required this.id, required this.title, required this.body});

  /// Replace-by-field copy. Pass `null` to leave a field unchanged.
  Note copyWith({String? title, String? body}) {
    return Note(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  /// First non-empty line of [body], trimmed. Falls back to a
  /// constant placeholder so the list never renders a blank
  /// subtitle (which makes ListTile shrink vertically).
  String get previewLine {
    for (final line in body.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.isNotEmpty) return trimmed;
    }
    return 'No content yet';
  }

  /// What the list shows when the title is empty — keeps the row
  /// height stable across edits.
  String get displayTitle => title.trim().isEmpty ? 'Untitled' : title;

  @override
  bool operator ==(Object other) => other is Note && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
