import 'package:flutter/material.dart';

/// Deep visual demo for SliderTrackShape
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SliderTrackShape Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Rounded Rectangle Track'), SliderTheme(data: SliderTheme.of(context).copyWith(trackShape: RoundedRectSliderTrackShape()), child: Slider(value: 0.4, onChanged: (v) {})), SizedBox(height: 30), Text('Rectangular Track'), SliderTheme(data: SliderTheme.of(context).copyWith(trackShape: RectangularSliderTrackShape()), child: Slider(value: 0.6, onChanged: (v) {}))])));
}
