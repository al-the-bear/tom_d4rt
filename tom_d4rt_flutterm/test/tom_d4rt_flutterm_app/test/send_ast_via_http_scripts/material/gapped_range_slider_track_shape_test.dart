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
                child: RangeSlider(
                  values: range,
                  min: 0,
                  max: 1,
                  onChanged: null,
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
