// D4rt test script: Tests AnnotationEntry from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnnotationEntry test executing');

  // AnnotationEntry - Wraps an annotation with hit test position info
  // Used in AnnotatedRegionLayer hit testing to return annotation with local position
  
  // Create a simple annotation object
  final annotation = 'test-annotation-data';
  
  // Create an AnnotationEntry
  final entry = AnnotationEntry<String>(
    annotation: annotation,
    localPosition: const Offset(50.0, 75.0),
  );
  
  print('AnnotationEntry created: $entry');
  print('annotation: ${entry.annotation}');
  print('localPosition: ${entry.localPosition}');
  
  // Generic type allows any annotation data
  print('\nGeneric annotation types:');
  print('AnnotationEntry<String> - String data');
  print('AnnotationEntry<int> - Integer data');
  print('AnnotationEntry<MyClass> - Custom class');
  print('AnnotationEntry<MouseTrackerAnnotation> - Mouse tracking');
  
  // Create with different types
  final intEntry = AnnotationEntry<int>(
    annotation: 42,
    localPosition: Offset.zero,
  );
  print('\nInt annotation entry:');
  print('annotation: ${intEntry.annotation}');
  print('localPosition: ${intEntry.localPosition}');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('AnnotationEntry<T> is a standalone class');
  print('Returned by AnnotationResult.entries');
  print('Used with AnnotatedRegionLayer for hit testing');
  
  // Use cases
  print('\nUse cases:');
  print('- Semantic hit testing with position');
  print('- Mouse region detection');
  print('- Custom annotation layers');
  print('- Accessibility region tracking');

  print('\nAnnotationEntry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnnotationEntry Tests'),
      Text('annotation: test-annotation-data'),
      Text('localPosition: (50, 75)'),
      Text('Generic type for any annotation data'),
    ],
  );
}
