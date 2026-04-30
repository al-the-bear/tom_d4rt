// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== GappedRangeSliderTrackShape Deep Demo (Harness-Safe) ===');

  const range = RangeValues(0.25, 0.75);

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'GappedRangeSliderTrackShape',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Static range slider preview with deterministic values.'),
              const SizedBox(height: 16),
              SliderTheme(
                data: SliderTheme.of(context),
                // E17 script-side fix — `onChanged: null` puts the slider on
                // the disabled-paint code path, which under M3 defaults can
                // resolve a `MaterialStateProperty` track-color slot to null
                // and trip the gapped track shape's paint method. A no-op
                // `onChanged` keeps the slider enabled (still a static
                // preview because the values are not stored back), so the
                // gapped track shape paints through the well-supported
                // enabled branch regardless of theme defaults.
                child: RangeSlider(
                  values: range,
                  min: 0,
                  max: 1,
                  onChanged: (RangeValues _) {},
                ),
              ),
              const SizedBox(height: 8),
              const Text('start=0.25, end=0.75'),
            ],
          ),
        ),
      ),
    ),
  );
}
