// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IconTheme, IconThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IconTheme test executing');

  // ========== ICONTHEMEDATA ==========
  print('--- IconThemeData Tests ---');

  // Test basic IconThemeData
  final basicIconTheme = IconThemeData();
  print('Basic IconThemeData created: $basicIconTheme');

  // Test IconThemeData with color
  final coloredIconTheme = IconThemeData(color: Colors.blue);
  print('IconThemeData with color created: $coloredIconTheme');

  // Test IconThemeData with opacity
  final opacityIconTheme = IconThemeData(opacity: 0.5);
  print('IconThemeData with opacity created: $opacityIconTheme');

  // Test IconThemeData with size
  final sizedIconTheme = IconThemeData(size: 32.0);
  print('IconThemeData with size created: $sizedIconTheme');

  // Test IconThemeData with fill
  final filledIconTheme = IconThemeData(fill: 1.0);
  print('IconThemeData with fill created: $filledIconTheme');

  // Test IconThemeData with weight
  final weightedIconTheme = IconThemeData(weight: 700.0);
  print('IconThemeData with weight created: $weightedIconTheme');

  // Test IconThemeData with grade
  final gradedIconTheme = IconThemeData(grade: 200.0);
  print('IconThemeData with grade created: $gradedIconTheme');

  // Test IconThemeData with opticalSize
  final opticalIconTheme = IconThemeData(opticalSize: 48.0);
  print('IconThemeData with opticalSize created: $opticalIconTheme');

  // Test IconThemeData with shadows
  final shadowedIconTheme = IconThemeData(
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.3),
        offset: Offset(2.0, 2.0),
        blurRadius: 4.0,
      ),
    ],
  );
  print('IconThemeData with shadows created: $shadowedIconTheme');

  // Test IconThemeData with applyTextScaling
  final scaledIconTheme = IconThemeData(applyTextScaling: true);
  print('IconThemeData with applyTextScaling created: $scaledIconTheme');

  // Test IconThemeData with all properties
  final fullIconTheme = IconThemeData(
    color: Colors.purple,
    opacity: 0.8,
    size: 28.0,
    fill: 0.5,
    weight: 500.0,
    grade: 100.0,
    opticalSize: 40.0,
    shadows: [
      Shadow(
        color: Colors.purple.withOpacity(0.2),
        offset: Offset(1.0, 1.0),
        blurRadius: 2.0,
      ),
    ],
    applyTextScaling: false,
  );
  print('IconThemeData with all properties created');

  // Test IconThemeData copyWith
  final copiedIconTheme = fullIconTheme.copyWith(
    color: Colors.orange,
    size: 36.0,
  );
  print(
    'IconThemeData copyWith created: color=${copiedIconTheme.color}, size=${copiedIconTheme.size}',
  );

  // Test IconThemeData merge
  final baseTheme = IconThemeData(color: Colors.red, size: 24.0);
  final overrideTheme = IconThemeData(size: 32.0, opacity: 0.9);
  final mergedTheme = baseTheme.merge(overrideTheme);
  print(
    'IconThemeData merge: color=${mergedTheme.color}, size=${mergedTheme.size}, opacity=${mergedTheme.opacity}',
  );

  // Test IconThemeData resolve
  final resolvedTheme = IconThemeData(color: Colors.green).resolve(context);
  print('IconThemeData resolve: resolved=${resolvedTheme.color}');

  // Test IconThemeData isConcrete
  final concreteTheme = IconThemeData(
    color: Colors.blue,
    size: 24.0,
    opacity: 1.0,
  );
  print('IconThemeData isConcrete: ${concreteTheme.isConcrete}');

  // ========== ICONTHEME WIDGET ==========
  print('--- IconTheme Widget Tests ---');

  // Test basic IconTheme
  final basicIconThemeWidget = IconTheme(
    data: IconThemeData(color: Colors.blue, size: 24.0),
    child: Row(
      children: [Icon(Icons.home), Icon(Icons.settings), Icon(Icons.person)],
    ),
  );
  print('Basic IconTheme widget created');

  // Test IconTheme with large icons
  final largeIconThemeWidget = IconTheme(
    data: IconThemeData(color: Colors.red, size: 48.0),
    child: Row(
      children: [Icon(Icons.star), Icon(Icons.favorite), Icon(Icons.thumb_up)],
    ),
  );
  print('IconTheme with large icons created');

  // Test IconTheme with opacity
  final opacityIconThemeWidget = IconTheme(
    data: IconThemeData(color: Colors.green, size: 32.0, opacity: 0.5),
    child: Row(children: [Icon(Icons.visibility), Icon(Icons.visibility_off)]),
  );
  print('IconTheme with opacity created');

  // Test nested IconThemes
  final nestedIconThemeWidget = IconTheme(
    data: IconThemeData(color: Colors.blue, size: 32.0),
    child: Column(
      children: [
        Row(children: [Icon(Icons.cloud), Icon(Icons.sunny)]),
        IconTheme(
          data: IconThemeData(color: Colors.orange, size: 48.0),
          child: Row(children: [Icon(Icons.star), Icon(Icons.star_border)]),
        ),
      ],
    ),
  );
  print('Nested IconTheme widgets created');

  // Test IconTheme.merge
  final mergeIconThemeWidget = IconTheme.merge(
    data: IconThemeData(size: 36.0),
    child: Row(children: [Icon(Icons.add), Icon(Icons.remove)]),
  );
  print('IconTheme.merge created');

  // Test IconTheme.of
  // Note: IconTheme.of(context) would get the current theme
  print('IconTheme.of concept noted (requires actual widget tree context)');

  print('IconTheme test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IconTheme Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'Basic IconTheme (blue, 24px):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        basicIconThemeWidget,

        SizedBox(height: 24.0),
        Text(
          'Large IconTheme (red, 48px):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        largeIconThemeWidget,

        SizedBox(height: 24.0),
        Text(
          'IconTheme with Opacity (green, 50%):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        opacityIconThemeWidget,

        SizedBox(height: 24.0),
        Text(
          'Nested IconThemes:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        nestedIconThemeWidget,

        SizedBox(height: 24.0),
        Text('IconTheme.merge:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        IconTheme(
          data: IconThemeData(color: Colors.purple),
          child: mergeIconThemeWidget,
        ),

        SizedBox(height: 24.0),
        Text(
          'Various Icon Sizes:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            IconTheme(
              data: IconThemeData(size: 16.0, color: Colors.teal),
              child: Icon(Icons.circle),
            ),
            SizedBox(width: 8.0),
            IconTheme(
              data: IconThemeData(size: 24.0, color: Colors.teal),
              child: Icon(Icons.circle),
            ),
            SizedBox(width: 8.0),
            IconTheme(
              data: IconThemeData(size: 32.0, color: Colors.teal),
              child: Icon(Icons.circle),
            ),
            SizedBox(width: 8.0),
            IconTheme(
              data: IconThemeData(size: 48.0, color: Colors.teal),
              child: Icon(Icons.circle),
            ),
            SizedBox(width: 8.0),
            IconTheme(
              data: IconThemeData(size: 64.0, color: Colors.teal),
              child: Icon(Icons.circle),
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'Icon Colors via Theme:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: [
            IconTheme(
              data: IconThemeData(color: Colors.red, size: 32.0),
              child: Icon(Icons.favorite),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.orange, size: 32.0),
              child: Icon(Icons.star),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.yellow, size: 32.0),
              child: Icon(Icons.bolt),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.green, size: 32.0),
              child: Icon(Icons.check_circle),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.blue, size: 32.0),
              child: Icon(Icons.water_drop),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.purple, size: 32.0),
              child: Icon(Icons.diamond),
            ),
          ],
        ),
      ],
    ),
  );
}
