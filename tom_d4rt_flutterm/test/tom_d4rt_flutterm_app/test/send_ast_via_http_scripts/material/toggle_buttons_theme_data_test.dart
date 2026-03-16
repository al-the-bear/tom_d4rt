import 'package:flutter/material.dart';

/// Deep visual demo for ToggleButtonsThemeData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ToggleButtonsThemeData Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [ToggleButtons(isSelected: [true, false, false], onPressed: (i) {}, children: [Icon(Icons.grid_view), Icon(Icons.list), Icon(Icons.view_module)]), SizedBox(height: 30), Theme(data: Theme.of(context).copyWith(toggleButtonsTheme: ToggleButtonsThemeData(fillColor: Colors.purple, selectedColor: Colors.white, borderRadius: BorderRadius.circular(20), constraints: BoxConstraints(minWidth: 60, minHeight: 60))), child: ToggleButtons(isSelected: [false, true, false], onPressed: (i) {}, children: [Icon(Icons.grid_view), Icon(Icons.list), Icon(Icons.view_module)])), SizedBox(height: 20), Text('Custom themed toggle buttons', style: TextStyle(color: Colors.grey))])));
}
