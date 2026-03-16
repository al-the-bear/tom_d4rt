import 'package:flutter/material.dart';

/// Deep visual demo for SliderComponentShape
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SliderComponentShape Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Custom Slider Component Shapes'), SizedBox(height: 20), SliderTheme(data: SliderTheme.of(context).copyWith(thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15), overlayShape: RoundSliderOverlayShape(overlayRadius: 30)), child: Slider(value: 0.5, onChanged: (v) {})), SliderTheme(data: SliderTheme.of(context).copyWith(thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8)), child: Slider(value: 0.7, onChanged: (v) {}))])));
}
