import 'package:flutter/material.dart';

/// Deep visual demo for TooltipVisibility
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TooltipVisibility Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [TooltipVisibility(visible: true, child: Tooltip(message: 'This tooltip is visible', child: ElevatedButton(onPressed: () {}, child: Text('Tooltips Enabled')))), SizedBox(height: 30), TooltipVisibility(visible: false, child: Tooltip(message: 'This will not show', child: ElevatedButton(onPressed: () {}, child: Text('Tooltips Disabled')))), SizedBox(height: 30), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: Text('Use TooltipVisibility to control tooltip display in subtree', style: TextStyle(fontSize: 12)))])));
}
