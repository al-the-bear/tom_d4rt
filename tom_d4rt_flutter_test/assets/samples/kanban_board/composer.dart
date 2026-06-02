// "Add card" composer at the bottom of each kanban column.
//
// Stateful because it owns a `TextEditingController`. The composer
// is intentionally minimal — a text field + a primary button that
// commits the new card and clears the field. Empty submissions are
// silently ignored.
import 'package:flutter/material.dart';

class Composer extends StatefulWidget {
  /// Title of the column this composer belongs to. Used purely for
  /// the input's `hintText` ("Add to To do…").
  final String columnTitle;

  /// Column index; passed through to the parent on add so the board
  /// knows where to insert.
  final int columnIndex;

  final void Function(int columnIndex, String title) onAdd;

  const Composer({
    super.key,
    required this.columnTitle,
    required this.columnIndex,
    required this.onAdd,
  });

  @override
  State<Composer> createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    widget.onAdd(widget.columnIndex, text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              key: Key('composer-input-${widget.columnIndex}'),
              controller: _controller,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Add to ${widget.columnTitle}…',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
              ),
              onSubmitted: (String _) => _submit(),
            ),
          ),
          const SizedBox(width: 6.0),
          IconButton(
            key: Key('composer-add-${widget.columnIndex}'),
            icon: const Icon(Icons.add_circle),
            color: Colors.blueAccent,
            onPressed: _submit,
            tooltip: 'Add card',
          ),
        ],
      ),
    );
  }
}
