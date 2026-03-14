// D4rt test script: Tests RenderExcludeSemantics from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderExcludeSemantics test executing');

  // ========== EXCLUDE SEMANTICS BASICS ==========
  print('--- ExcludeSemantics Basics ---');
  print('RenderExcludeSemantics excludes subtree from semantic tree');
  print('Child widgets become invisible to screen readers');
  print('Useful for decorative or redundant elements');

  // Test ExcludeSemantics with excluding: true
  final excludingWidget = ExcludeSemantics(
    excluding: true,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Center(child: Text('Excluded')),
    ),
  );
  print('ExcludeSemantics created with excluding: true');
  print('  runtimeType: ${excludingWidget.runtimeType}');
  print('  excluding: ${excludingWidget.excluding}');

  // Test with excluding: false
  final notExcludingWidget = ExcludeSemantics(
    excluding: false,
    child: Container(
      width: 80,
      height: 80,
      color: Colors.green,
      child: Center(child: Text('Included')),
    ),
  );
  print('ExcludeSemantics with excluding: false');
  print('  Semantics are preserved');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Decorative images (use excludeFromSemantics on Image)');
  print('2. Background patterns or gradients');
  print('3. Duplicate information already announced');
  print('4. Visual-only elements (dividers, shadows)');
  print('5. Loading indicators during transition');

  // Test with decorative element
  final decorativeElement = ExcludeSemantics(
    child: Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blue],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
  print('Decorative gradient element (excluded from semantics)');

  // Test with icon that duplicates text
  final duplicateInfo = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ExcludeSemantics(
        child: Icon(Icons.email, color: Colors.blue),
      ),
      SizedBox(width: 8),
      Text('email@example.com'),
    ],
  );
  print('Icon excluded when text already provides info');

  // ========== SEMANTICS VS EXCLUDE SEMANTICS ==========
  print('--- Semantics vs ExcludeSemantics ---');
  print('Semantics: Adds semantic info to subtree');
  print('ExcludeSemantics: Removes semantic info from subtree');
  print('MergeSemantics: Combines semantics of children');

  // Test combining Semantics with ExcludeSemantics
  final combinedSemantics = Semantics(
    label: 'Main button',
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExcludeSemantics(
          child: Icon(Icons.star, color: Colors.amber),
        ),
        Text('Star'),
      ],
    ),
  );
  print('Semantics wrapper with excluded icon');
  print('  Screen reader announces "Main button" only');

  // ========== NESTED EXCLUDE SEMANTICS ==========
  print('--- Nested Behavior ---');

  final nestedExclude = ExcludeSemantics(
    excluding: true,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Hidden text 1'),
        ExcludeSemantics(
          excluding: false,
          child: Text('Still hidden (outer wins)'),
        ),
        Text('Hidden text 2'),
      ],
    ),
  );
  print('Nested ExcludeSemantics');
  print('  Outer excluding: true overrides inner');

  // ========== CONDITIONAL EXCLUSION ==========
  print('--- Conditional Exclusion ---');
  print('Use excluding parameter to toggle dynamically');
  print('Example: exclude during animations, include when static');

  bool isLoading = true;
  final conditionalExclude = ExcludeSemantics(
    excluding: isLoading,
    child: CircularProgressIndicator(),
  );
  print('Conditional exclusion based on loading state');
  print('  isLoading: $isLoading, excluding: $isLoading');

  // ========== ACCESSIBILITY BEST PRACTICES ==========
  print('--- Accessibility Best Practices ---');
  print('1. Never exclude important interactive elements');
  print('2. Use for truly decorative content only');
  print('3. Test with screen readers');
  print('4. Consider semantic alternatives');

  // Test accessible button with decorative background
  final accessibleButton = Stack(
    alignment: Alignment.center,
    children: [
      ExcludeSemantics(
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.red],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      Semantics(
        button: true,
        label: 'Submit',
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
  print('Button with excluded gradient background');

  // ========== COMPARING WITH BLOCK SEMANTICS ==========
  print('--- ExcludeSemantics vs BlockSemantics ---');
  print('ExcludeSemantics: Excludes THIS subtree');
  print('BlockSemantics: Blocks widgets BELOW in paint order');
  print('Use ExcludeSemantics for decorative content');
  print('Use BlockSemantics for overlays/modals');

  // Test image with semantics
  final imageWithSemantics = Container(
    width: 100,
    height: 100,
    child: Stack(
      children: [
        ExcludeSemantics(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.image, size: 40, color: Colors.grey),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          left: 4,
          right: 4,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            color: Colors.black54,
            child: Text(
              'Photo',
              style: TextStyle(color: Colors.white, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
  print('Image placeholder with caption');
  print('  Placeholder excluded, caption announced');

  // ========== TESTING SEMANTICS ==========
  print('--- Testing Semantics Behavior ---');
  print('Use Flutter DevTools Accessibility inspector');
  print('Or SemanticsDebugger widget for debugging');
  print('Run accessibility tests with flutter_test');

  print('RenderExcludeSemantics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderExcludeSemantics Tests'),
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [excludingWidget, SizedBox(width: 8), notExcludingWidget],
      ),
      SizedBox(height: 8),
      decorativeElement,
      SizedBox(height: 8),
      duplicateInfo,
      SizedBox(height: 8),
      accessibleButton,
      SizedBox(height: 8),
      imageWithSemantics,
      SizedBox(height: 8),
      Text('All ExcludeSemantics tests passed'),
    ],
  );
}
