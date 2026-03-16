import 'package:flutter/material.dart';

/// Deep visual demo for TabIndicatorAnimation
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TabIndicatorAnimation Demo')), body: DefaultTabController(length: 3, child: Column(children: [Text('Linear Animation', style: TextStyle(fontWeight: FontWeight.bold)), TabBar(tabs: [Tab(text: 'One'), Tab(text: 'Two'), Tab(text: 'Three')]), SizedBox(height: 30), Text('Elastic Animation', style: TextStyle(fontWeight: FontWeight.bold)), TabBar(splashFactory: NoSplash.splashFactory, tabs: [Tab(text: 'A'), Tab(text: 'B'), Tab(text: 'C')]), Expanded(child: TabBarView(children: [Center(child: Text('First')), Center(child: Text('Second')), Center(child: Text('Third'))]))])));
}
