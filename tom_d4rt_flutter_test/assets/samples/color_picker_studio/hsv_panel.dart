// HSV sliders panel for the color_picker_studio sample.
//
// Pure layout — derives current HSV from the supplied `Color` via
// `rgbToHsv`, fires `onChanged(Color)` back through `hsvToRgb` when a
// slider moves. The panel never owns state; the parent's
// `ValueNotifier<Color>` is the single source of truth.
import 'package:flutter/material.dart';

import 'color_model.dart';

class HsvPanel extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onChanged;

  const HsvPanel({
    super.key,
    required this.color,
    required this.onChanged,
  });

  void _emit(double h, double s, double v) {
    final rgb = hsvToRgb(h, s, v);
    onChanged(Color.fromARGB(0xFF, rgb[0], rgb[1], rgb[2]));
  }

  @override
  Widget build(BuildContext context) {
    final hsv = rgbToHsv(color.red, color.green, color.blue);
    final h = hsv[0];
    final s = hsv[1];
    final v = hsv[2];
    return Column(
      key: const Key('hsv-panel'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('H ${h.toStringAsFixed(0)}', key: const Key('hsv-h-label')),
        Slider(
          key: const Key('slider-h'),
          min: 0.0,
          max: 360.0,
          divisions: 360,
          value: h.clamp(0.0, 360.0),
          onChanged: (double nh) => _emit(nh, s, v),
        ),
        Text('S ${s.toStringAsFixed(0)}', key: const Key('hsv-s-label')),
        Slider(
          key: const Key('slider-s'),
          min: 0.0,
          max: 100.0,
          divisions: 100,
          value: s.clamp(0.0, 100.0),
          onChanged: (double ns) => _emit(h, ns, v),
        ),
        Text('V ${v.toStringAsFixed(0)}', key: const Key('hsv-v-label')),
        Slider(
          key: const Key('slider-v'),
          min: 0.0,
          max: 100.0,
          divisions: 100,
          value: v.clamp(0.0, 100.0),
          onChanged: (double nv) => _emit(h, s, nv),
        ),
      ],
    );
  }
}
