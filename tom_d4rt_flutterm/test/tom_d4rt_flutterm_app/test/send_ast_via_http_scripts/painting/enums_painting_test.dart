import 'package:flutter/material.dart';

/// Deep visual demo for PaintingEnums
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Painting Enums Demo')), body: ListView(padding: EdgeInsets.all(16), children: [ListTile(title: Text('BoxFit'), subtitle: Text('fill, contain, cover, fitWidth, fitHeight, none, scaleDown')), ListTile(title: Text('BoxShape'), subtitle: Text('rectangle, circle')), ListTile(title: Text('ImageRepeat'), subtitle: Text('repeat, repeatX, repeatY, noRepeat')), ListTile(title: Text('FilterQuality'), subtitle: Text('none, low, medium, high')), ListTile(title: Text('Axis'), subtitle: Text('horizontal, vertical'))]));
}
