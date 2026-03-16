import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for Clipboard
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Clipboard')), body: _ClipboardDemo());
}

class _ClipboardDemo extends StatefulWidget {
  @override State<_ClipboardDemo> createState() => _ClipboardDemoState();
}

class _ClipboardDemoState extends State<_ClipboardDemo> {
  String _text = '';
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Clipboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Row(children: [
      Expanded(child: ElevatedButton.icon(onPressed: () async { await Clipboard.setData(ClipboardData(text: 'Hello!')); }, icon: Icon(Icons.copy), label: Text('Copy'))),
      SizedBox(width: 8),
      Expanded(child: ElevatedButton.icon(onPressed: () async {
        final data = await Clipboard.getData(Clipboard.kTextPlain);
        setState(() => _text = data?.text ?? 'Empty');
      }, icon: Icon(Icons.paste), label: Text('Paste'))),
    ]),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), width: double.infinity, decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text(_text.isEmpty ? 'Press Paste to see clipboard' : _text, style: TextStyle(fontFamily: 'monospace'))),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Clipboard.setData / Clipboard.getData', style: TextStyle(fontFamily: 'monospace', fontSize: 10))),
  ]));
}
