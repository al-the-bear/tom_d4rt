// D4rt test script: Tests TextButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextButton test executing');

  // Test basic TextButton
  final basic = TextButton(
    onPressed: () {
      print('Basic TextButton pressed');
    },
    child: Text('Text Button'),
  );
  print('Basic TextButton created');

  // Test TextButton with icon
  final withIcon = TextButton.icon(
    onPressed: () {
      print('Icon TextButton pressed');
    },
    icon: Icon(Icons.favorite),
    label: Text('Like'),
  );
  print('TextButton.icon created');

  // Test TextButton with style
  final styled = TextButton(
    onPressed: () {},
    style: TextButton.styleFrom(
      foregroundColor: Colors.purple,
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    ),
    child: Text('Styled'),
  );
  print('Styled TextButton created');

  // Test disabled TextButton
  final disabled = TextButton(onPressed: null, child: Text('Disabled'));
  print('Disabled TextButton created');

  print('TextButton test completed');

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        basic,
        SizedBox(height: 8.0),
        withIcon,
        SizedBox(height: 8.0),
        styled,
        SizedBox(height: 8.0),
        disabled,
      ],
    ),
  );
}
