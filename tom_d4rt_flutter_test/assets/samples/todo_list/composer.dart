// Top-of-page composer for the todo_list sample.
//
// Single-line TextField + IconButton. Pressing Enter or tapping the
// add button submits the trimmed text to the store and clears the
// field. Blank submissions are dropped by the store but the field is
// still cleared so the UI doesn't keep stale text around.
import 'package:flutter/material.dart';

class TaskComposer extends StatefulWidget {
  final void Function(String text) onSubmit;

  const TaskComposer({super.key, required this.onSubmit});

  @override
  State<TaskComposer> createState() => _TaskComposerState();
}

class _TaskComposerState extends State<TaskComposer> {
  late TextEditingController _controller;

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
    widget.onSubmit(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            key: const Key('composer-input'),
            controller: _controller,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: 'What needs doing?',
              isDense: true,
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _submit(),
          ),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          key: const Key('composer-add'),
          icon: const Icon(Icons.add),
          tooltip: 'Add task',
          onPressed: _submit,
        ),
      ],
    );
  }
}
