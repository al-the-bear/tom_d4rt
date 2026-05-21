// Home page for the color_picker_studio sample (example #11).
//
// State model:
//   * `_notifier`   - `ValueNotifier<Color>` shared with every panel.
//                     The single source of truth for the selected
//                     colour. Panels read it via `ValueListenableBuilder`
//                     and write back through `_apply(...)`.
//   * `_recents`    - `ValueNotifier<List<Color>>` for the swatch
//                     strip. Pushed when the user commits a colour
//                     via the hex field or a slider release; capped
//                     at `kRecentsMax` and de-duplicated.
//
// Trail (`picker.*` prefix) lines are ASCII and stable so tests can
// scan with `startsWith`. Each user-driven mutation prints one line
// naming the source channel (hex, rgb, hsv, swatch) plus the
// resulting hex value.
//
// ignore_for_file: avoid_print - print lines are the test trail.
import 'package:flutter/material.dart';

import 'color_model.dart';
import 'hex_field.dart';
import 'hsv_panel.dart';
import 'rgb_panel.dart';
import 'swatch_strip.dart';

class ColorPickerStudioHome extends StatefulWidget {
  const ColorPickerStudioHome({super.key});

  @override
  State<ColorPickerStudioHome> createState() => _ColorPickerStudioHomeState();
}

class _ColorPickerStudioHomeState extends State<ColorPickerStudioHome> {
  late ValueNotifier<Color> _notifier;
  late ValueNotifier<List<Color>> _recents;

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<Color>(kInitialColor);
    _recents = ValueNotifier<List<Color>>(List<Color>.from(kDefaultPalette));
    print('picker.init hex=${colorToHex(kInitialColor)} '
        'r=${kInitialColor.red} g=${kInitialColor.green} '
        'b=${kInitialColor.blue} recents=${_recents.value.length}');
  }

  @override
  void dispose() {
    _notifier.dispose();
    _recents.dispose();
    super.dispose();
  }

  bool _apply(Color next, String source) {
    if (next.value == _notifier.value.value) return false;
    _notifier.value = next;
    print('picker.$source hex=${colorToHex(next)} '
        'r=${next.red} g=${next.green} b=${next.blue}');
    return true;
  }

  void _commitRecent(Color next, String source) {
    if (!_apply(next, source)) return;
    final updated = recentsAdd(_recents.value, next);
    _recents.value = updated;
    print('picker.recent hex=${colorToHex(next)} '
        'count=${updated.length} source=$source');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Picker Studio')),
      body: SingleChildScrollView(
        key: const Key('picker-scroll'),
        padding: const EdgeInsets.all(12.0),
        child: ValueListenableBuilder<Color>(
          valueListenable: _notifier,
          builder: (BuildContext context, Color color, Widget? _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  key: const Key('preview-swatch'),
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(color: Colors.black54, width: 1.0),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    colorToHex(color),
                    key: const Key('preview-hex-label'),
                    style: TextStyle(
                      color: color.computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                HexField(
                  color: color,
                  onSubmitted: (Color c) => _commitRecent(c, 'hex'),
                ),
                const SizedBox(height: 12.0),
                RgbPanel(
                  color: color,
                  onChanged: (Color c) => _apply(c, 'rgb'),
                ),
                const SizedBox(height: 4.0),
                HsvPanel(
                  color: color,
                  onChanged: (Color c) => _apply(c, 'hsv'),
                ),
                const SizedBox(height: 12.0),
                ValueListenableBuilder<List<Color>>(
                  valueListenable: _recents,
                  builder: (BuildContext context, List<Color> list, Widget? _) {
                    return SwatchStrip(
                      swatches: list,
                      onPicked: (Color c) => _commitRecent(c, 'swatch'),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
