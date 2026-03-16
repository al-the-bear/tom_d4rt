import 'package:flutter/material.dart';

/// Deep visual demo for Thumb
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Thumb Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Slider Thumb Shapes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 30), SliderTheme(data: SliderTheme.of(context).copyWith(thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12)), child: Slider(value: 0.5, onChanged: (v) {})), Text('Round Thumb (default)'), SizedBox(height: 20), SliderTheme(data: SliderTheme.of(context).copyWith(thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8, pressedElevation: 8)), child: Slider(value: 0.7, onChanged: (v) {})), Text('Smaller with elevation'), SizedBox(height: 20), SliderTheme(data: SliderTheme.of(context).copyWith(thumbColor: Colors.orange), child: Slider(value: 0.3, onChanged: (v) {})), Text('Custom color')])));
}
