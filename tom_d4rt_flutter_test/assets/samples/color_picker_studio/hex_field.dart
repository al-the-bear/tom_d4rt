// Hex input field for the color_picker_studio sample.
//
// `TextField` with a `TextEditingController` that mirrors the current
// colour. On submit the parent receives a `Color` parsed via
// `hexToColor`. Invalid input is silently ignored — the visible text
// is reset to the current colour's hex string on every rebuild so
// the user can see their bad entry was rejected.
//
// The field key is `Key('hex-field')` and the submit button (visible
// alternative for tests that can't trigger `onSubmitted` cleanly) is
// `Key('hex-submit')`.
import 'package:flutter/material.dart';

import 'color_model.dart';

class HexField extends StatefulWidget {
  final Color color;
  final ValueChanged<Color> onSubmitted;

  const HexField({
    super.key,
    required this.color,
    required this.onSubmitted,
  });

  @override
  State<HexField> createState() => _HexFieldState();
}

class _HexFieldState extends State<HexField> {
  late TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: colorToHex(widget.color));
  }

  @override
  void didUpdateWidget(HexField old) {
    super.didUpdateWidget(old);
    final hex = colorToHex(widget.color);
    if (hex != _controller.text) {
      _controller.text = hex;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final raw = _controller.text;
    final parsed = hexToColor(raw);
    if (parsed == null) {
      setState(() {
        _error = 'invalid hex';
      });
      print('picker.hex.invalid raw=$raw');
      return;
    }
    if (_error != null) {
      setState(() {
        _error = null;
      });
    }
    widget.onSubmitted(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('hex-row'),
      children: <Widget>[
        Expanded(
          child: TextField(
            key: const Key('hex-field'),
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Hex',
              errorText: _error,
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (_) => _submit(),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          key: const Key('hex-submit'),
          onPressed: _submit,
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
