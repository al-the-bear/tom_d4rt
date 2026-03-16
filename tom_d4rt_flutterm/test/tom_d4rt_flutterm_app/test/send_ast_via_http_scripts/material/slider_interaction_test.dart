import 'package:flutter/material.dart';

/// Deep visual demo for SliderInteraction
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SliderInteraction Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Tap Only'), SliderTheme(data: SliderTheme.of(context).copyWith(allowedInteraction: SliderInteraction.tapOnly), child: Slider(value: 0.3, onChanged: (v) {})), Text('Slide Only'), SliderTheme(data: SliderTheme.of(context).copyWith(allowedInteraction: SliderInteraction.slideOnly), child: Slider(value: 0.5, onChanged: (v) {})), Text('Tap and Slide'), SliderTheme(data: SliderTheme.of(context).copyWith(allowedInteraction: SliderInteraction.tapAndSlide), child: Slider(value: 0.7, onChanged: (v) {})), Text('Slide Thumb'), SliderTheme(data: SliderTheme.of(context).copyWith(allowedInteraction: SliderInteraction.slideThumb), child: Slider(value: 0.9, onChanged: (v) {}))])));
}
