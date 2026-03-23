// ignore_for_file: avoid_print
// D4rt test script: Tests Icon from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Icon test executing');

  // Test basic Icon
  final basic = Icon(Icons.home);
  print('Basic Icon created');

  // Test Icon with size
  final sized = Icon(Icons.star, size: 48.0);
  print('Sized Icon created');

  // Test Icon with color
  final colored = Icon(Icons.favorite, color: Colors.red);
  print('Colored Icon created');

  // Test Icon with size and color
  final styledIcon = Icon(Icons.settings, size: 36.0, color: Colors.blue);
  print('Styled Icon created');

  // Test various common icons
  print('Testing various icons...');

  print('Icon test completed');

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [Text('Basic: '), basic]),
        SizedBox(height: 8.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Sized (48): '), sized],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Colored: '), colored],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Styled: '), styledIcon],
        ),
        SizedBox(height: 16.0),
        Text('Common Icons:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: [
            Icon(Icons.add, color: Colors.green),
            Icon(Icons.remove, color: Colors.red),
            Icon(Icons.edit, color: Colors.orange),
            Icon(Icons.delete, color: Colors.grey),
            Icon(Icons.search, color: Colors.blue),
            Icon(Icons.menu, color: Colors.purple),
            Icon(Icons.close, color: Colors.brown),
            Icon(Icons.check, color: Colors.teal),
            Icon(Icons.arrow_back),
            Icon(Icons.arrow_forward),
            Icon(Icons.refresh, color: Colors.cyan),
            Icon(Icons.share, color: Colors.pink),
          ],
        ),
      ],
    ),
  );
}
