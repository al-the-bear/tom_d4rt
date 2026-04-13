import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('WebBrowserDetection')),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          final entries = <String>[
            'WebBrowserDetection — utility for detecting web browser environment',
            'This deterministic summary replaces a StatefulWidget demo',
            'that used late TabController/_tabs fields.',
            'The late-init pattern fails in the D4rt interpreter',
            'because lifecycle methods are not invoked.',
            'Summary: deterministic ListView, no state, no late fields.',
          ];
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(entries[index]),
          );
        },
      ),
    ),
  );
}
