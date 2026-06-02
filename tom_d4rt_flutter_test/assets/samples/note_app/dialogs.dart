// Dialog + bottom-sheet helpers for the note_app sample.
//
// Centralised here (rather than inlined into the editor) so the
// editor's build method stays focused on the form. Both helpers
// return `Future<bool>` — the editor only triggers a side-effect
// when the user confirms.
//
// `confirmDelete` uses `showDialog` + `AlertDialog`. The dialog
// pops `true` on the destructive button and `false`/`null` on cancel
// or barrier dismiss.
//
// `showShareSheet` uses `showModalBottomSheet`. It pops `true` once
// the user picks an option so the caller can emit a "shared"
// SnackBar. The sheet itself is read-only — the buttons exist to
// exercise the sheet's tap targets in the tester, not to actually
// send anything anywhere.
import 'package:flutter/material.dart';

import 'note.dart';

/// Show a confirm-delete `AlertDialog` for [note]. Resolves to
/// `true` only when the user explicitly taps the destructive
/// button; `false` for cancel / barrier dismiss / Esc.
Future<bool> confirmDelete(BuildContext context, Note note) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogCtx) {
      return AlertDialog(
        key: const Key('delete-dialog'),
        title: const Text('Delete note?'),
        content: Text(
          'This will permanently delete "${note.displayTitle}". '
          'You cannot undo this action.',
        ),
        actions: <Widget>[
          TextButton(
            key: const Key('delete-cancel'),
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton.tonal(
            key: const Key('delete-confirm'),
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
  return result ?? false;
}

/// Show the share `showModalBottomSheet` for [note]. The sheet
/// surfaces three pretend-share entries; tapping any of them pops
/// `true`. Cancel / drag-down resolves to `false`.
Future<bool> showShareSheet(BuildContext context, Note note) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    builder: (BuildContext sheetCtx) {
      return SafeArea(
        key: const Key('share-sheet'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                'Share "${note.displayTitle}"',
                key: const Key('share-title'),
                style: Theme.of(sheetCtx).textTheme.titleMedium,
              ),
            ),
            ListTile(
              key: const Key('share-copy'),
              leading: const Icon(Icons.copy_outlined),
              title: const Text('Copy text'),
              onTap: () => Navigator.of(sheetCtx).pop(true),
            ),
            ListTile(
              key: const Key('share-email'),
              leading: const Icon(Icons.mail_outline),
              title: const Text('Send via email'),
              onTap: () => Navigator.of(sheetCtx).pop(true),
            ),
            ListTile(
              key: const Key('share-link'),
              leading: const Icon(Icons.link),
              title: const Text('Get shareable link'),
              onTap: () => Navigator.of(sheetCtx).pop(true),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      );
    },
  );
  return result ?? false;
}
