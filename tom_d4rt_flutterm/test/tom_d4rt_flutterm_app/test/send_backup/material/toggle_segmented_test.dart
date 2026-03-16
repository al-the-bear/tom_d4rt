import 'package:flutter/material.dart';

/// Deep visual demo for SegmentedButton
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SegmentedButton Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [SegmentedButton<int>(segments: [ButtonSegment(value: 0, label: Text('Day'), icon: Icon(Icons.calendar_today)), ButtonSegment(value: 1, label: Text('Week'), icon: Icon(Icons.date_range)), ButtonSegment(value: 2, label: Text('Month'), icon: Icon(Icons.calendar_month))], selected: {0}, onSelectionChanged: (s) {}), SizedBox(height: 30), SegmentedButton<String>(segments: [ButtonSegment(value: 'S', label: Text('S')), ButtonSegment(value: 'M', label: Text('M')), ButtonSegment(value: 'L', label: Text('L')), ButtonSegment(value: 'XL', label: Text('XL'))], selected: {'M'}, onSelectionChanged: (s) {}), SizedBox(height: 30), SegmentedButton<int>(multiSelectionEnabled: true, segments: [ButtonSegment(value: 0, icon: Icon(Icons.format_bold)), ButtonSegment(value: 1, icon: Icon(Icons.format_italic)), ButtonSegment(value: 2, icon: Icon(Icons.format_underline))], selected: {0, 2}, onSelectionChanged: (s) {})])));
}
