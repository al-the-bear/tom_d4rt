import 'package:flutter/material.dart';

/// Deep visual demo for ShowValueIndicator
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ShowValueIndicator Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [SliderTheme(data: SliderTheme.of(context).copyWith(showValueIndicator: ShowValueIndicator.always), child: Slider(value: 0.5, onChanged: (v) {}, label: 'Always')), SliderTheme(data: SliderTheme.of(context).copyWith(showValueIndicator: ShowValueIndicator.onlyForDiscrete), child: Slider(value: 0.7, divisions: 5, onChanged: (v) {}, label: 'Discrete')), SliderTheme(data: SliderTheme.of(context).copyWith(showValueIndicator: ShowValueIndicator.onlyForContinuous), child: Slider(value: 0.3, onChanged: (v) {}, label: 'Continuous')), SliderTheme(data: SliderTheme.of(context).copyWith(showValueIndicator: ShowValueIndicator.never), child: Slider(value: 0.6, onChanged: (v) {}, label: 'Never'))])));
}
