import 'package:flutter/material.dart';

/// Deep visual demo for ImageProviders
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageProviders Demo')), body: ListView(padding: EdgeInsets.all(16), children: [ListTile(leading: Icon(Icons.folder, color: Colors.blue), title: Text('AssetImage'), subtitle: Text('Load from assets')), ListTile(leading: Icon(Icons.cloud, color: Colors.green), title: Text('NetworkImage'), subtitle: Text('Load from URL')), ListTile(leading: Icon(Icons.memory, color: Colors.orange), title: Text('MemoryImage'), subtitle: Text('Load from bytes')), ListTile(leading: Icon(Icons.insert_drive_file, color: Colors.purple), title: Text('FileImage'), subtitle: Text('Load from file')), ListTile(leading: Icon(Icons.photo_size_select_actual, color: Colors.red), title: Text('ResizeImage'), subtitle: Text('Resize on decode'))]));
}
