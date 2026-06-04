// RGB sliders panel for the color_picker_studio sample.
//
// Three independent `Slider`s (R / G / B), each labelled with the
// current integer channel value. Slider keys are stable
// (`Key('slider-r')` etc.) so tests can drive them without depending
// on label text. Changes are dispatched through a single
// `ValueChanged<Color>` callback owned by the parent — this panel is
// stateless and never owns the colour itself.
import 'package:flutter/material.dart';

class RgbPanel extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onChanged;

  const RgbPanel({
    super.key,
    required this.color,
    required this.onChanged,
  });

  Color _withR(int r) => Color.fromARGB(0xFF, r, color.green, color.blue);
  Color _withG(int g) => Color.fromARGB(0xFF, color.red, g, color.blue);
  Color _withB(int b) => Color.fromARGB(0xFF, color.red, color.green, b);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('rgb-panel'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('R ${color.red}', key: const Key('rgb-r-label')),
        Slider(
          key: const Key('slider-r'),
          min: 0.0,
          max: 255.0,
          divisions: 255,
          value: color.red.toDouble(),
          onChanged: (double v) => onChanged(_withR(v.round())),
        ),
        Text('G ${color.green}', key: const Key('rgb-g-label')),
        Slider(
          key: const Key('slider-g'),
          min: 0.0,
          max: 255.0,
          divisions: 255,
          value: color.green.toDouble(),
          onChanged: (double v) => onChanged(_withG(v.round())),
        ),
        Text('B ${color.blue}', key: const Key('rgb-b-label')),
        Slider(
          key: const Key('slider-b'),
          min: 0.0,
          max: 255.0,
          divisions: 255,
          value: color.blue.toDouble(),
          onChanged: (double v) => onChanged(_withB(v.round())),
        ),
      ],
    );
  }
}
