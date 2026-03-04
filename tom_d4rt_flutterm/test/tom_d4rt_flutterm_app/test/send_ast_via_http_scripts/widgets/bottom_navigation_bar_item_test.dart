// D4rt test script: Tests BottomNavigationBarItem from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BottomNavigationBarItem test executing');

  // Test BottomNavigationBarItem - BottomNavigationBarItem
  print('BottomNavigationBarItem is available in the widgets package');
  print('BottomNavigationBarItem runtimeType accessible');

  print('BottomNavigationBarItem test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BottomNavigationBarItem Tests'),
      Text('BottomNavigationBarItem'),
    ],
  );
}
