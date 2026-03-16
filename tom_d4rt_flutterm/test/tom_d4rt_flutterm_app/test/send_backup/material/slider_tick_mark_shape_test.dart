import 'package:flutter/material.dart';

/// Deep visual demo for SliderTickMarkShape
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SliderTickMarkShape Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Round Tick Marks'), SliderTheme(data: SliderTheme.of(context).copyWith(tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 4)), child: Slider(value: 0.5, divisions: 5, onChanged: (v) {})), SizedBox(height: 30), Text('Larger Tick Marks'), SliderTheme(data: SliderTheme.of(context).copyWith(tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 8)), child: Slider(value: 0.7, divisions: 10, onChanged: (v) {}))])));
}
