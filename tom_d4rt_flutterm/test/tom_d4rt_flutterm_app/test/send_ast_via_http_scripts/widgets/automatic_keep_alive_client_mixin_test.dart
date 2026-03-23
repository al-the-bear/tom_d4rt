// ignore_for_file: avoid_print
// D4rt test script: Tests AutomaticKeepAliveClientMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AutomaticKeepAliveClientMixin test executing');

  // AutomaticKeepAliveClientMixin - Keeps widgets alive in lazy lists
  // Prevents disposal when scrolling off-screen
  
  print('AutomaticKeepAliveClientMixin purpose:');
  print('- Keeps widget state when scrolling off-screen');
  print('- Prevents rebuild on scroll back');
  print('- Preserves form input, scroll position, etc.');
  print('- Works with ListView, GridView, etc.');
  
  // Usage pattern
  print('\nUsage pattern:');
  print('class _ItemState extends State<Item>');
  print('    with AutomaticKeepAliveClientMixin {');
  print('  @override bool get wantKeepAlive => true;');
  print('  @override Widget build(context) {');
  print('    super.build(context); // Required!');
  print('    return MyWidget();');
  print('  }');
  print('}');
  
  // Key points
  print('\nKey points:');
  print('- Override wantKeepAlive to return true');
  print('- MUST call super.build(context) in build');
  print('- Uses KeepAliveNotification internally');
  print('- Can be dynamic (change wantKeepAlive)');  
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('AutomaticKeepAliveClientMixin is mixin on State');
  print('Sends KeepAliveNotification to parent');
  print('AutomaticKeepAlive widget receives notification');
  
  // Use cases
  print('\nUse cases:');
  print('- Chat messages with media');
  print('- Form fields in list');
  print('- Video players in feed');
  print('- Complex list items with state');

  print('\nAutomaticKeepAliveClientMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AutomaticKeepAliveClientMixin Tests'),
      Text('Keep widget alive when off-screen'),
      Text('wantKeepAlive => true'),
      Text('Must call super.build(context)'),
    ],
  );
}
