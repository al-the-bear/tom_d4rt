import 'package:flutter/material.dart';

/// Deep visual demo for render mixins
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Render Mixins')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Render Object Mixins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _MixinCard('RenderObjectWithChildMixin', 'Single child', Colors.blue),
      _MixinCard('ContainerRenderObjectMixin', 'Multiple children', Colors.green),
      _MixinCard('RenderProxyBoxMixin', 'Proxy single child box', Colors.orange),
      _MixinCard('RelayoutWhenSystemFontsChangeMixin', 'Font change handling', Colors.purple),
      _MixinCard('DebugOverflowIndicatorMixin', 'Yellow/black stripes', Colors.red),
      _MixinCard('RenderAnimatedOpacityMixin', 'Animated opacity', Colors.indigo),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Mixins add common behaviors to custom RenderObjects', style: TextStyle(fontSize: 11))),
  ])));
}

class _MixinCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _MixinCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.extension, color: color), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, fontFamily: 'monospace')), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
