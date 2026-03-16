import 'package:flutter/material.dart';

/// Deep visual demo for TooltipFeedback
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Tooltip Feedback Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Tooltip(message: 'Add new item', triggerMode: TooltipTriggerMode.tap, child: ElevatedButton.icon(icon: Icon(Icons.add), label: Text('Tap for tooltip'), onPressed: () {})), SizedBox(height: 30), Tooltip(message: 'Edit item', triggerMode: TooltipTriggerMode.longPress, showDuration: Duration(seconds: 3), child: ElevatedButton.icon(icon: Icon(Icons.edit), label: Text('Long press'), onPressed: () {})), SizedBox(height: 30), Tooltip(message: 'Delete item', triggerMode: TooltipTriggerMode.manual, child: ElevatedButton.icon(icon: Icon(Icons.delete), label: Text('Manual trigger'), onPressed: () {}))])));
}
