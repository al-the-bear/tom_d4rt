import 'package:flutter/material.dart';

/// Deep visual demo for Tabs
dynamic build(BuildContext context) {
  return Scaffold(body: DefaultTabController(length: 4, child: NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) => [SliverAppBar(title: Text('Tabs Demo'), pinned: true, floating: true, bottom: TabBar(tabs: [Tab(icon: Icon(Icons.home), text: 'Home'), Tab(icon: Icon(Icons.business), text: 'Business'), Tab(icon: Icon(Icons.school), text: 'School'), Tab(icon: Icon(Icons.flight), text: 'Travel')]))], body: TabBarView(children: [ListView.builder(itemCount: 20, itemBuilder: (c, i) => ListTile(title: Text('Home item i'))), ListView.builder(itemCount: 20, itemBuilder: (c, i) => ListTile(title: Text('Business item i'))), ListView.builder(itemCount: 20, itemBuilder: (c, i) => ListTile(title: Text('School item i'))), ListView.builder(itemCount: 20, itemBuilder: (c, i) => ListTile(title: Text('Travel item i')))]))));
}
