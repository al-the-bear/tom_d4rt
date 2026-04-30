// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== GappedSliderTrackShape Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'GappedSliderTrackShape',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Provides explicit trackGap in SliderThemeData.'),
              const SizedBox(height: 16),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(trackGap: 2.0),
                child: const Slider(
                  value: 0.6,
                  min: 0,
                  max: 1,
                  onChanged: null,
                ),
              ),
              const SizedBox(height: 8),
              const Text('trackGap=2.0'),
            ],
          ),
        ),
      ),
    ),
  );
}
