import 'package:flutter/material.dart';

/// Deep visual demo for TabIndicator
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TabIndicator Demo')), body: DefaultTabController(length: 3, child: Column(children: [TabBar(indicator: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(8)), tabs: [Tab(text: 'Box'), Tab(text: 'Indicator'), Tab(text: 'Demo')]), SizedBox(height: 20), TabBar(indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 4, color: Colors.orange)), tabs: [Tab(text: 'Underline'), Tab(text: 'Tab'), Tab(text: 'Demo')]), SizedBox(height: 20), TabBar(indicator: BoxDecoration(border: Border.all(color: Colors.green, width: 2), borderRadius: BorderRadius.circular(20)), tabs: [Tab(text: 'Border'), Tab(text: 'Style'), Tab(text: 'Demo')]), Expanded(child: TabBarView(children: [Center(child: Text('Content 1')), Center(child: Text('Content 2')), Center(child: Text('Content 3'))]))])));
}
