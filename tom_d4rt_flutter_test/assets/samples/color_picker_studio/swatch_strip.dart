// Recents/swatch strip for the color_picker_studio sample.
//
// Renders up to `kRecentsMax` square swatches in a horizontal row.
// Each swatch is `GestureDetector`-wrapped (not `InkWell`, which
// requires a `Material` ancestor that not every bridged context
// provides reliably) and carries `Key('swatch-$index')` so tests can
// target a specific index without depending on the displayed colour.
import 'package:flutter/material.dart';

import 'color_model.dart';

class SwatchStrip extends StatelessWidget {
  final List<Color> swatches;
  final ValueChanged<Color> onPicked;

  const SwatchStrip({
    super.key,
    required this.swatches,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    final tiles = <Widget>[];
    for (var i = 0; i < swatches.length && i < kRecentsMax; i++) {
      final c = swatches[i];
      tiles.add(
        GestureDetector(
          key: Key('swatch-$i'),
          behavior: HitTestBehavior.opaque,
          onTap: () => onPicked(c),
          child: Container(
            width: 32.0,
            height: 32.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: c,
              border: Border.all(color: Colors.black54, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      key: const Key('swatch-strip'),
      height: 48.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: tiles,
      ),
    );
  }
}
