import 'package:flutter/material.dart';

/// Deep visual demo for TimePickerEntryMode
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TimePickerEntryMode Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [ElevatedButton.icon(icon: Icon(Icons.dialpad), label: Text('Dial Mode'), onPressed: () => showTimePicker(context: context, initialTime: TimeOfDay.now(), initialEntryMode: TimePickerEntryMode.dial)), SizedBox(height: 16), ElevatedButton.icon(icon: Icon(Icons.keyboard), label: Text('Input Mode'), onPressed: () => showTimePicker(context: context, initialTime: TimeOfDay.now(), initialEntryMode: TimePickerEntryMode.input)), SizedBox(height: 16), ElevatedButton.icon(icon: Icon(Icons.access_time), label: Text('Dial Only'), onPressed: () => showTimePicker(context: context, initialTime: TimeOfDay.now(), initialEntryMode: TimePickerEntryMode.dialOnly)), SizedBox(height: 16), ElevatedButton.icon(icon: Icon(Icons.edit), label: Text('Input Only'), onPressed: () => showTimePicker(context: context, initialTime: TimeOfDay.now(), initialEntryMode: TimePickerEntryMode.inputOnly))])));
}
