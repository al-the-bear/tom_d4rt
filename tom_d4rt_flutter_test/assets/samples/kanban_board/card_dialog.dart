// AlertDialog for editing or deleting a kanban card.
//
// `showCardDialog(...)` is the public entry point; it wraps
// `showDialog<CardDialogResult>` and returns the user's decision.
// The dialog itself is a stateful widget that owns a
// `TextEditingController` pre-populated with the card's title.
//
// Three exits:
//   * Save  → returns `CardDialogResult.save(newTitle)`
//   * Delete → returns `CardDialogResult.delete()`
//   * Cancel / barrier dismiss → returns `null`
//
// The home widget interprets `null` as "no change".
import 'package:flutter/material.dart';

import 'board.dart';

/// Result returned by the edit dialog. Using a small value object
/// (rather than e.g. a nullable String) lets the call-site
/// distinguish "delete" from "save with empty title".
class CardDialogResult {
  final bool deleted;
  final String? newTitle;

  const CardDialogResult.save(String title)
      : deleted = false,
        newTitle = title;

  const CardDialogResult.delete()
      : deleted = true,
        newTitle = null;
}

Future<CardDialogResult?> showCardDialog(
  BuildContext context,
  KanbanCard card,
) {
  return showDialog<CardDialogResult>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext ctx) {
      return _CardEditDialog(card: card);
    },
  );
}

class _CardEditDialog extends StatefulWidget {
  final KanbanCard card;

  const _CardEditDialog({required this.card});

  @override
  State<_CardEditDialog> createState() => _CardEditDialogState();
}

class _CardEditDialogState extends State<_CardEditDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.card.title);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final text = _controller.text;
    Navigator.of(context).pop(CardDialogResult.save(text));
  }

  void _delete() {
    Navigator.of(context).pop(const CardDialogResult.delete());
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: const Key('card-dialog'),
      title: const Text('Edit card'),
      content: TextField(
        key: const Key('card-dialog-input'),
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Title',
          border: OutlineInputBorder(),
        ),
        onSubmitted: (String _) => _save(),
      ),
      actions: <Widget>[
        TextButton(
          key: const Key('card-dialog-delete'),
          onPressed: _delete,
          style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
          child: const Text('Delete'),
        ),
        TextButton(
          key: const Key('card-dialog-cancel'),
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const Key('card-dialog-save'),
          onPressed: _save,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
