import 'package:flutter/material.dart';

/// Deep visual demo for StretchMode
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [SliverAppBar(expandedHeight: 200, stretch: true, flexibleSpace: FlexibleSpaceBar(title: Text('StretchMode Demo'), stretchModes: [StretchMode.zoomBackground, StretchMode.blurBackground, StretchMode.fadeTitle], background: Container(color: Colors.blue))), SliverList(delegate: SliverChildBuilderDelegate((c, i) => ListTile(title: Text('Item i')), childCount: 30))]));
}
