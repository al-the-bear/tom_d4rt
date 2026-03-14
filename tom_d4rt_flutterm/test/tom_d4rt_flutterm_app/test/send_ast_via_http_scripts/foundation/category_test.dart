// D4rt test script: Tests Category annotation from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Category test executing');
  print('=' * 50);

  // Create Category with single section
  final singleCat = Category(['widgets']);
  print('\nSingle section Category:');
  print('runtimeType: ${singleCat.runtimeType}');
  print('sections: ${singleCat.sections}');
  print('sections.length: ${singleCat.sections.length}');
  print('sections[0]: ${singleCat.sections[0]}');

  // Create Category with multiple sections
  final multiCat = Category(['animation', 'painting', 'rendering']);
  print('\nMultiple sections Category:');
  print('sections: ${multiCat.sections}');
  print('sections.length: ${multiCat.sections.length}');
  for (int i = 0; i < multiCat.sections.length; i++) {
    print('sections[$i]: ${multiCat.sections[i]}');
  }

  // Create Category with empty sections
  final emptyCat = Category([]);
  print('\nEmpty sections Category:');
  print('sections: ${emptyCat.sections}');
  print('sections.isEmpty: ${emptyCat.sections.isEmpty}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('Category is Object: ${singleCat is Object}');

  // Test sections list immutability characteristics
  print('\nSections list properties:');
  print('sections.runtimeType: ${singleCat.sections.runtimeType}');

  // Compare different categories
  final sameCat1 = Category(['widgets']);
  final sameCat2 = Category(['widgets']);
  print('\nCategory comparison:');
  print('sameCat1 == sameCat2: ${sameCat1 == sameCat2}');
  print('identical(sameCat1, sameCat2): ${identical(sameCat1, sameCat2)}');
  print(
    'sameCat1.sections == sameCat2.sections: ${sameCat1.sections[0] == sameCat2.sections[0]}',
  );

  // Common Flutter category examples
  print('\nCommon Category examples:');
  final widgetsCat = Category(['Widgets']);
  final materialCat = Category(['Material Design', 'Components']);
  final animationCat = Category(['Animation']);
  print('Widgets category: ${widgetsCat.sections}');
  print('Material category: ${materialCat.sections}');
  print('Animation category: ${animationCat.sections}');

  // Explain purpose
  print('\nCategory purpose:');
  print('- Annotation used to categorize APIs in documentation');
  print('- Helps organize Flutter API reference');
  print('- Connects related classes and functions');
  print('- Used by dartdoc to generate category pages');

  print('\n' + '=' * 50);
  print('Category test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Category Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${singleCat.runtimeType}'),
      Text('Single section: ${singleCat.sections}'),
      Text('Multi section: ${multiCat.sections}'),
      Text('Empty section: ${emptyCat.sections}'),
      Text('Purpose: Documentation categorization annotation'),
    ],
  );
}
