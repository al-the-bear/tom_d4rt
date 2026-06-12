// Material 3 `SegmentedButton<FieldMode>` rendering the three available
// modes. Identical to the original sample's selector — it is already a
// `StatelessWidget` taking `(mode, onChanged)`, so in the optimized page it
// is wrapped in a `ValueListenableBuilder<FieldMode>` that only rebuilds it
// on an actual mode change (not on every physics frame).
import 'package:flutter/material.dart';

import 'field.dart';

class ModeSelector extends StatelessWidget {
  final FieldMode mode;
  final ValueChanged<FieldMode> onChanged;

  const ModeSelector({
    super.key,
    required this.mode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<FieldMode>(
      key: const Key('mode-selector'),
      segments: const <ButtonSegment<FieldMode>>[
        ButtonSegment<FieldMode>(
          value: FieldMode.attract,
          label: Text('Attract'),
        ),
        ButtonSegment<FieldMode>(
          value: FieldMode.repel,
          label: Text('Repel'),
        ),
        ButtonSegment<FieldMode>(
          value: FieldMode.orbit,
          label: Text('Orbit'),
        ),
      ],
      selected: <FieldMode>{mode},
      onSelectionChanged: (Set<FieldMode> next) {
        if (next.isEmpty) return;
        onChanged(next.first);
      },
    );
  }
}
