// D4rt test script: Tests RenderObjectToWidgetElement behavior
// RenderObjectToWidgetElement bridges the widget tree to a render tree root
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjectToWidgetElement test executing');

  // RenderObjectToWidgetElement is used internally by runApp to attach widgets
  // to a RenderObject tree. We test the concepts through observable behavior.

  // Test 1: Access element via context
  print('--- Element Context Tests ---');
  final testKey = GlobalKey();
  
  // Widget that reports its element info
  Widget buildElementInspector(String label) {
    return Builder(
      key: label == 'Primary' ? testKey : null,
      builder: (context) {
        final element = context as Element;
        print('$label Element type: ${element.runtimeType}');
        print('$label Element depth: ${element.depth}');
        print('$label Element widget: ${element.widget.runtimeType}');
        print('$label Element owner: ${element.owner?.runtimeType}');
        print('$label Element mounted: ${element.mounted}');
        
        // Check render object if available
        if (context is RenderObjectElement) {
          print('$label RenderObject: ${context.renderObject.runtimeType}');
        }
        
        return Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$label Element', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Type: ${element.runtimeType}'),
              Text('Depth: ${element.depth}'),
              Text('Mounted: ${element.mounted}'),
            ],
          ),
        );
      },
    );
  }

  // Test 2: Element tree traversal
  print('--- Element Tree Traversal ---');
  Widget buildTreeDemo() {
    return Builder(builder: (context) {
      final element = context as Element;
      
      // Visit ancestors
      var ancestorCount = 0;
      element.visitAncestorElements((ancestor) {
        ancestorCount++;
        if (ancestorCount <= 5) {
          print('Ancestor $ancestorCount: ${ancestor.widget.runtimeType}');
        }
        return ancestorCount < 10;
      });
      print('Total ancestors visited: $ancestorCount');
      
      return Container(
        padding: EdgeInsets.all(12),
        color: Colors.green.shade50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Element Tree Demo'),
            Text('Ancestors: $ancestorCount'),
            SizedBox(height: 8),
            // Nested structure to test
            Container(
              color: Colors.green.shade100,
              padding: EdgeInsets.all(8),
              child: Builder(builder: (innerContext) {
                final innerElement = innerContext as Element;
                print('Inner element depth: ${innerElement.depth}');
                return Text('Inner (depth: ${innerElement.depth})');
              }),
            ),
          ],
        ),
      );
    });
  }

  // Test 3: Finding elements by type
  print('--- Find Element Tests ---');
  Widget buildFindDemo() {
    return Builder(builder: (context) {
      // Find ancestor of type
      final scaffoldState = Scaffold.maybeOf(context);
      print('Scaffold found: ${scaffoldState != null}');
      
      // Find inherited widget
      final theme = Theme.of(context);
      print('Theme primaryColor: ${theme.primaryColor}');
      
      final mediaQuery = MediaQuery.of(context);
      print('MediaQuery size: ${mediaQuery.size}');
      
      // Directionality
      final direction = Directionality.of(context);
      print('Text direction: $direction');
      
      return Container(
        padding: EdgeInsets.all(12),
        color: Colors.orange.shade50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Find Element Demo'),
            Text('Has Scaffold: ${scaffoldState != null}'),
            Text('Primary: ${theme.primaryColor}'),
            Text('Direction: $direction'),
          ],
        ),
      );
    });
  }

  // Test 4: Element lifecycle via StatefulWidget
  print('--- Element Lifecycle Tests ---');
  Widget buildLifecycleDemo() {
    return StatefulBuilder(
      builder: (context, setState) {
        final element = context as StatefulElement;
        print('StatefulElement state: ${element.state.runtimeType}');
        print('StatefulElement mounted: ${element.mounted}');
        
        return Container(
          padding: EdgeInsets.all(12),
          color: Colors.purple.shade50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Lifecycle Demo'),
              Text('Element: ${element.runtimeType}'),
              Text('Mounted: ${element.mounted}'),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => setState(() {}),
                child: Text('Trigger Rebuild'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Test 5: RenderObjectElement via Container
  print('--- RenderObjectElement Tests ---');
  Widget buildRenderObjectDemo() {
    return Builder(builder: (context) {
      // Access render box after layout
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (testKey.currentContext != null) {
          final renderBox = testKey.currentContext!.findRenderObject() as RenderBox?;
          if (renderBox != null && renderBox.hasSize) {
            print('RenderBox size: ${renderBox.size}');
            print('RenderBox constraints: ${renderBox.constraints}');
          }
        }
      });
      
      return Container(
        padding: EdgeInsets.all(12),
        color: Colors.cyan.shade50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('RenderObject Demo'),
            SizedBox(
              key: GlobalKey(),
              width: 100,
              height: 50,
              child: ColoredBox(
                color: Colors.cyan.shade200,
                child: Center(child: Text('100x50')),
              ),
            ),
          ],
        ),
      );
    });
  }

  print('RenderObjectToWidgetElement test completed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: Scaffold(
      appBar: AppBar(title: Text('RenderObjectToWidgetElement')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Element Tests',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            buildElementInspector('Primary'),
            SizedBox(height: 12),
            buildTreeDemo(),
            SizedBox(height: 12),
            buildFindDemo(),
            SizedBox(height: 12),
            buildLifecycleDemo(),
            SizedBox(height: 12),
            buildRenderObjectDemo(),
          ],
        ),
      ),
    ),
  );
}
