import 'package:flutter/material.dart';

/// Deep visual demo for TimePickerWidget
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TimePicker Widget Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.schedule, size: 64, color: Colors.blue), SizedBox(height: 20), Text('Time Picker', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), SizedBox(height: 30), ElevatedButton.icon(icon: Icon(Icons.access_time), label: Text('Pick Time'), onPressed: () async { final time = await showTimePicker(context: context, initialTime: TimeOfDay.now()); if (time != null) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected: ' + time.format(context)))); }), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: Text('showTimePicker() returns TimeOfDay?', style: TextStyle(fontFamily: 'monospace', fontSize: 12)))])));
}
