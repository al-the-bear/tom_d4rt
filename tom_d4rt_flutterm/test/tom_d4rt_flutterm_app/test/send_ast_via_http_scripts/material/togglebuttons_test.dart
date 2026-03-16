import 'package:flutter/material.dart';

/// Deep visual demo for ToggleButtons
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ToggleButtons Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [ToggleButtons(isSelected: [true, false, false], onPressed: (i) {}, children: [Icon(Icons.format_bold), Icon(Icons.format_italic), Icon(Icons.format_underline)]), SizedBox(height: 20), ToggleButtons(isSelected: [false, true, false], borderRadius: BorderRadius.circular(8), selectedColor: Colors.white, fillColor: Colors.blue, onPressed: (i) {}, children: [Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('S')), Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('M')), Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('L'))]), SizedBox(height: 20), ToggleButtons(isSelected: [true, true, false], direction: Axis.vertical, onPressed: (i) {}, children: [Icon(Icons.wifi), Icon(Icons.bluetooth), Icon(Icons.nfc)])])));
}
