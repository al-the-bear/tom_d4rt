// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Icon widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Icon test executing');

  // Test basic Icon with Material icon
  final basicIcon = Icon(Icons.home);
  print('Basic Icon with Icons.home created');

  // Test Icon with custom size
  final sizedIcon = Icon(Icons.star, size: 48.0);
  print('Icon with size=48.0 created');

  // Test Icon with custom color
  final coloredIcon = Icon(Icons.favorite, color: Colors.red);
  print('Icon with color=red created');

  // Test Icon with size and color
  final styledIcon = Icon(Icons.settings, size: 36.0, color: Colors.blue);
  print('Icon with size=36.0 and color=blue created');

  // Test Icon with semanticLabel
  final labeledIcon = Icon(
    Icons.accessibility,
    semanticLabel: 'Accessibility icon',
    size: 32.0,
  );
  print('Icon with semanticLabel created');

  // Test various Material icons
  final iconsRow = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.add, size: 24.0),
      SizedBox(width: 8.0),
      Icon(Icons.remove, size: 24.0),
      SizedBox(width: 8.0),
      Icon(Icons.close, size: 24.0),
      SizedBox(width: 8.0),
      Icon(Icons.check, size: 24.0),
      SizedBox(width: 8.0),
      Icon(Icons.menu, size: 24.0),
    ],
  );
  print('Row of various Material icons created');

  // Test Icon with different icon categories
  final categoryIcons = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.folder, color: Colors.amber),
          SizedBox(width: 4.0),
          Icon(Icons.file_copy, color: Colors.grey),
          SizedBox(width: 4.0),
          Icon(Icons.delete, color: Colors.red),
        ],
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_arrow, color: Colors.green),
          SizedBox(width: 4.0),
          Icon(Icons.pause, color: Colors.orange),
          SizedBox(width: 4.0),
          Icon(Icons.stop, color: Colors.red),
        ],
      ),
    ],
  );
  print('Category icons created: $categoryIcons');

  // Test Icon with gradient using ShaderMask (if supported)
  final iconWithTextDirection = Directionality(
    textDirection: TextDirection.ltr,
    child: Icon(Icons.arrow_forward, size: 32.0),
  );
  print('Icon with text direction created: $iconWithTextDirection');

  print('Icon test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      basicIcon,
      SizedBox(height: 8.0),
      sizedIcon,
      SizedBox(height: 8.0),
      coloredIcon,
      SizedBox(height: 8.0),
      styledIcon,
      SizedBox(height: 8.0),
      labeledIcon,
      SizedBox(height: 16.0),
      iconsRow,
      SizedBox(height: 16.0),
      categoryIcons,
    ],
  );
}
