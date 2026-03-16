import 'package:flutter/material.dart';

/// Deep visual demo for TabAlignment
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TabAlignment Demo')), body: DefaultTabController(length: 4, child: Column(children: [TabBar(tabAlignment: TabAlignment.start, isScrollable: true, tabs: [Tab(text: 'Start 1'), Tab(text: 'Start 2'), Tab(text: 'Start 3'), Tab(text: 'Start 4')]), SizedBox(height: 20), TabBar(tabAlignment: TabAlignment.center, isScrollable: true, tabs: [Tab(text: 'Center 1'), Tab(text: 'Center 2'), Tab(text: 'Center 3'), Tab(text: 'Center 4')]), SizedBox(height: 20), TabBar(tabAlignment: TabAlignment.fill, tabs: [Tab(text: 'Fill 1'), Tab(text: 'Fill 2'), Tab(text: 'Fill 3'), Tab(text: 'Fill 4')]), Expanded(child: TabBarView(children: [Center(child: Text('Content 1')), Center(child: Text('Content 2')), Center(child: Text('Content 3')), Center(child: Text('Content 4'))]))])));
}
