// D4rt test script: Tests AnnotatedRegionLayer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnnotatedRegionLayer test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');
  
  // Create AnnotatedRegionLayer with String value
  final stringLayer = AnnotatedRegionLayer<String>(
    'test-region',
    size: Size(100, 100),
    offset: Offset(10, 20),
  );
  print('Created AnnotatedRegionLayer<String> with value: ${stringLayer.value}');
  results.add('Created layer with value: ${stringLayer.value}');
  
  // Test properties
  print('Layer size: ${stringLayer.size}');
  print('Layer offset: ${stringLayer.offset}');
  results.add('Size: ${stringLayer.size}, Offset: ${stringLayer.offset}');
  
  // ========== Section 2: Integer Annotation ==========
  print('--- Section 2: Integer Annotation ---');
  
  final intLayer = AnnotatedRegionLayer<int>(
    42,
    size: Size(200, 150),
    offset: Offset.zero,
  );
  print('Created AnnotatedRegionLayer<int> with value: ${intLayer.value}');
  results.add('Integer layer value: ${intLayer.value}');
  
  // ========== Section 3: Nullable Size ==========
  print('--- Section 3: Nullable Size ---');
  
  final nullSizeLayer = AnnotatedRegionLayer<String>(
    'unbounded-region',
    size: null,
    offset: Offset(5, 5),
  );
  print('Created layer with null size (unbounded): ${nullSizeLayer.size}');
  results.add('Null size layer: size=${nullSizeLayer.size}');
  
  // ========== Section 4: Custom Object Annotation ==========
  print('--- Section 4: Custom Object Annotation ---');
  
  // Using a Map as annotation value
  final mapAnnotation = {'id': 1, 'name': 'region-1'};
  final mapLayer = AnnotatedRegionLayer<Map<String, dynamic>>(
    mapAnnotation,
    size: Size(50, 50),
    offset: Offset(100, 100),
  );
  print('Created layer with Map annotation: ${mapLayer.value}');
  results.add('Map annotation: ${mapLayer.value}');
  
  // ========== Section 5: Layer Operations ==========
  print('--- Section 5: Layer Operations ---');
  
  // Test layer tree operations
  final parentLayer = ContainerLayer();
  final testLayer = AnnotatedRegionLayer<String>(
    'child-region',
    size: Size(80, 80),
  );
  
  parentLayer.append(testLayer);
  print('Appended annotation layer to parent');
  print('Parent has child: ${parentLayer.firstChild != null}');
  results.add('Layer attached to parent: ${parentLayer.firstChild != null}');
  
  // ========== Section 6: Find Annotation ==========
  print('--- Section 6: Find Annotation ---');
  
  final result = AnnotationResult<String>();
  // Note: findAnnotations uses local position within the layer
  final found = stringLayer.findAnnotations<String>(
    result,
    Offset(50, 50),
    onlyFirst: false,
  );
  print('Find annotations returned: $found');
  print('Result entries: ${result.entries.length}');
  results.add('Annotations found: ${result.entries.length}');
  
  // ========== Section 7: Multiple Layers in Hierarchy ==========
  print('--- Section 7: Multiple Layers in Hierarchy ---');
  
  final container = ContainerLayer();
  final layer1 = AnnotatedRegionLayer<int>(1, size: Size(100, 100));
  final layer2 = AnnotatedRegionLayer<int>(2, size: Size(100, 100));
  
  container.append(layer1);
  container.append(layer2);
  
  var childCount = 0;
  var child = container.firstChild;
  while (child != null) {
    childCount++;
    child = child.nextSibling;
  }
  print('Container has $childCount children');
  results.add('Hierarchy test: $childCount children');
  
  print('AnnotatedRegionLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('AnnotatedRegionLayer Tests', 
               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...results.map((r) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text('✓ $r', style: TextStyle(fontSize: 14)),
          )),
        ],
      ),
    ),
  );
}
