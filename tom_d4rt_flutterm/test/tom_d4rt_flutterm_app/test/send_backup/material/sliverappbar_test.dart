import 'package:flutter/material.dart';

/// Deep visual demo for SliverAppBar
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(slivers: [SliverAppBar(expandedHeight: 200, floating: false, pinned: true, flexibleSpace: FlexibleSpaceBar(title: Text('SliverAppBar'), background: Container(color: Colors.blue)), actions: [IconButton(icon: Icon(Icons.search), onPressed: () {}), IconButton(icon: Icon(Icons.more_vert), onPressed: () {})]), SliverList(delegate: SliverChildBuilderDelegate((c, i) => ListTile(title: Text('Item \$i')), childCount: 30))]));
}
