import 'package:flutter/material.dart';

/// Deep visual demo for UnderlineTabIndicator
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('UnderlineTabIndicator Demo')), body: DefaultTabController(length: 3, child: Column(children: [TabBar(indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 2)), tabs: [Tab(text: 'Default')]), SizedBox(height: 10), TabBar(indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 4, color: Colors.blue)), tabs: [Tab(text: 'Blue')]), SizedBox(height: 10), TabBar(indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 3, color: Colors.orange), insets: EdgeInsets.symmetric(horizontal: 20)), tabs: [Tab(text: 'Inset')]), SizedBox(height: 10), TabBar(indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 5, color: Colors.purple), borderRadius: BorderRadius.circular(4)), tabs: [Tab(text: 'Rounded')]), Expanded(child: TabBarView(children: [Center(child: Text('Tab 1')), Center(child: Text('Tab 2')), Center(child: Text('Tab 3'))]))])));
}
