import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverFillRemaining
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Fill Remaining')), body: CustomScrollView(slivers: [
    SliverToBoxAdapter(child: Container(height: 100, margin: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(8)),
      child: Center(child: Text('Fixed Header')))),
    SliverFillRemaining(hasScrollBody: false,
      child: Container(margin: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(8)),
        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.fullscreen, size: 64, color: Colors.purple),
          Text('Fills Remaining Space', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ])))),
  ]));
}
