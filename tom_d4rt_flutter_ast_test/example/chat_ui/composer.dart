// Multiline composer.
//
// • A `TextField` with `FocusNode` and `TextEditingController` lets
//   the user type a message. The field is multiline (`maxLines: null`
//   with `minLines: 1`) so it grows as the user types.
// • Pressing Enter (via `onSubmitted`) or tapping the send button
//   submits the message. The current text is cleared and focus is
//   restored so the user can keep typing.
// • The button is only enabled when the current text isn't empty
//   after trimming.
import 'package:flutter/material.dart';

class Composer extends StatefulWidget {
  final void Function(String) onSend;

  const Composer({super.key, required this.onSend});

  @override
  State<Composer> createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _canSend = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final bool nextCanSend = _controller.text.trim().isNotEmpty;
    if (nextCanSend != _canSend) {
      setState(() {
        _canSend = nextCanSend;
      });
    }
  }

  void _submit() {
    final String text = _controller.text;
    if (text.trim().isEmpty) return;
    widget.onSend(text);
    _controller.clear();
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: TextField(
                key: const Key('composer-field'),
                controller: _controller,
                focusNode: _focus,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                decoration: const InputDecoration(
                  hintText: 'Type a message…',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onSubmitted: (String _) => _submit(),
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton(
              key: const Key('composer-send'),
              icon: const Icon(Icons.send),
              tooltip: 'Send',
              onPressed: _canSend ? _submit : null,
            ),
          ],
        ),
      ),
    );
  }
}
