import 'package:flutter/material.dart';

/// Deep visual demo for sliver fill remaining with scrollable content
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Scrollable Fill')), body: CustomScrollView(slivers: [
    SliverAppBar(title: Text('Sliver App Bar'), floating: true),
    SliverFillRemaining(hasScrollBody: true,
      child: ListView(children: List.generate(20, (i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(8)),
        child: Text('Nested item ${i + 1}'))))),
  ]));
}
