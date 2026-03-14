// D4rt test script: Tests CustomPainterSemantics from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('CustomPainterSemantics test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');

  final basic = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 100, 50),
    properties: SemanticsProperties(label: 'Test label'),
  );
  print('Created basic CustomPainterSemantics');
  print('Rect: ${basic.rect}');
  results.add('Created with rect: ${basic.rect}');

  // ========== Section 2: With Key ==========
  print('--- Section 2: With Key ---');

  final withKey = CustomPainterSemantics(
    key: ValueKey('semantics-1'),
    rect: Rect.fromLTWH(10, 20, 80, 40),
    properties: SemanticsProperties(label: 'Keyed semantics'),
  );
  print('Created with key: ${withKey.key}');
  print('Key type: ${withKey.key.runtimeType}');
  results.add('Key: ${withKey.key}');

  // ========== Section 3: Transform ==========
  print('--- Section 3: Transform ---');

  final transform = Matrix4.identity()..translate(50.0, 25.0);
  final withTransform = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 100, 100),
    transform: transform,
    properties: SemanticsProperties(label: 'Transformed'),
  );
  print('Created with transform');
  print('Has transform: ${withTransform.transform != null}');
  results.add('Has transform: ${withTransform.transform != null}');

  // ========== Section 4: Semantics Properties ==========
  print('--- Section 4: Semantics Properties ---');

  final propsSemantics = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 200, 100),
    properties: SemanticsProperties(
      label: 'Button',
      hint: 'Tap to activate',
      button: true,
      enabled: true,
    ),
  );
  print('Properties label: ${propsSemantics.properties.label}');
  print('Properties hint: ${propsSemantics.properties.hint}');
  print('Is button: ${propsSemantics.properties.button}');
  results.add(
    'Properties: label=${propsSemantics.properties.label}, button=${propsSemantics.properties.button}',
  );

  // ========== Section 5: Multiple Semantics ==========
  print('--- Section 5: Multiple Semantics ---');

  final semanticsList = <CustomPainterSemantics>[
    CustomPainterSemantics(
      rect: Rect.fromLTWH(0, 0, 100, 50),
      properties: SemanticsProperties(label: 'Item 1'),
    ),
    CustomPainterSemantics(
      rect: Rect.fromLTWH(0, 50, 100, 50),
      properties: SemanticsProperties(label: 'Item 2'),
    ),
    CustomPainterSemantics(
      rect: Rect.fromLTWH(0, 100, 100, 50),
      properties: SemanticsProperties(label: 'Item 3'),
    ),
  ];

  print('Created ${semanticsList.length} semantics');
  for (var i = 0; i < semanticsList.length; i++) {
    print('  Item $i: rect=${semanticsList[i].rect}');
  }
  results.add('Multiple semantics: ${semanticsList.length} items');

  // ========== Section 6: Tags ==========
  print('--- Section 6: Tags ---');

  final tag1 = SemanticsTag('custom-tag-1');
  final tag2 = SemanticsTag('custom-tag-2');

  final taggedSemantics = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 50, 50),
    tags: {tag1, tag2},
    properties: SemanticsProperties(label: 'Tagged'),
  );
  print('Created with tags');
  print('Tags count: ${taggedSemantics.tags?.length ?? 0}');
  results.add('Tags count: ${taggedSemantics.tags?.length ?? 0}');

  // ========== Section 7: Actions ==========
  print('--- Section 7: Actions ---');

  var tapCount = 0;
  final actionSemantics = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 100, 40),
    properties: SemanticsProperties(
      label: 'Clickable',
      onTap: () {
        tapCount++;
        print('Tap action triggered');
      },
    ),
  );
  print('Created with onTap action');
  print('Has onTap: ${actionSemantics.properties.onTap != null}');
  results.add('Has onTap: ${actionSemantics.properties.onTap != null}');

  // ========== Section 8: Rect Properties ==========
  print('--- Section 8: Rect Properties ---');

  final rectTest = CustomPainterSemantics(
    rect: Rect.fromLTRB(10, 20, 110, 70),
    properties: SemanticsProperties(label: 'Rect test'),
  );
  print('Rect left: ${rectTest.rect.left}');
  print('Rect top: ${rectTest.rect.top}');
  print('Rect right: ${rectTest.rect.right}');
  print('Rect bottom: ${rectTest.rect.bottom}');
  print('Rect width: ${rectTest.rect.width}');
  print('Rect height: ${rectTest.rect.height}');
  results.add('Rect: ${rectTest.rect.width}x${rectTest.rect.height}');

  // ========== Section 9: Empty Properties ==========
  print('--- Section 9: Empty Properties ---');

  final emptyProps = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 30, 30),
    properties: SemanticsProperties(),
  );
  print('Created with empty properties');
  print('Label is null: ${emptyProps.properties.label == null}');
  results.add('Empty props label: ${emptyProps.properties.label}');

  // ========== Section 10: Zero Rect ==========
  print('--- Section 10: Zero Rect ---');

  final zeroRect = CustomPainterSemantics(
    rect: Rect.zero,
    properties: SemanticsProperties(label: 'Zero rect'),
  );
  print('Zero rect: ${zeroRect.rect}');
  print('Is zero: ${zeroRect.rect == Rect.zero}');
  results.add('Zero rect: ${zeroRect.rect == Rect.zero}');

  print('CustomPainterSemantics test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'CustomPainterSemantics Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
