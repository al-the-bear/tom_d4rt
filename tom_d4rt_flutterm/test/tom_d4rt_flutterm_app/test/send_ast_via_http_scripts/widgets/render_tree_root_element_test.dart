// D4rt test script: Tests RenderTreeRootElement concepts and related root widget behavior
// RenderTreeRootElement is the base for root elements that own the render tree
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderTreeRootElement test executing');

  // RenderTreeRootElement is a mixin used by root elements (View, etc.)
  // We test its behavior through widgets that use root element concepts

  // Test 1: Root element detection
  print('--- Root Element Detection ---');
  Widget buildRootDetector() {
    return Builder(
      builder: (context) {
        final element = context as Element;

        // Walk up to find root-like elements
        var depth = 0;
        Element? rootCandidate;
        element.visitAncestorElements((ancestor) {
          depth++;
          rootCandidate = ancestor;
          print('Depth $depth: ${ancestor.widget.runtimeType}');
          return true; // continue visiting
        });

        print('Total tree depth from this point: $depth');
        if (rootCandidate != null) {
          print('Top ancestor widget: ${rootCandidate!.widget.runtimeType}');
        }

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Root Detection',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Tree depth: $depth'),
              if (rootCandidate != null)
                Text('Top: ${rootCandidate!.widget.runtimeType}'),
            ],
          ),
        );
      },
    );
  }

  // Test 2: Render tree owner access
  print('--- Render Tree Owner ---');
  Widget buildOwnerDemo() {
    return Builder(
      builder: (context) {
        final element = context as Element;
        final owner = element.owner;

        print('BuildOwner: ${owner?.runtimeType}');
        if (owner != null) {
          print('BuildOwner debugBuilding: ${owner.debugBuilding}');
        }

        // Access pipeline owner through render object
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final renderObject = context.findRenderObject();
          if (renderObject != null) {
            final pipelineOwner = renderObject.owner;
            print('PipelineOwner: ${pipelineOwner?.runtimeType}');
            if (pipelineOwner != null) {
              print(
                'Semantics enabled: ${pipelineOwner.semanticsOwner != null}',
              );
            }
          }
        });

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tree Owner', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('BuildOwner: ${owner?.runtimeType}'),
              Text('Has owner: ${owner != null}'),
            ],
          ),
        );
      },
    );
  }

  // Test 3: View widget (root widget concept)
  print('--- View Widget Tests ---');
  Widget buildViewDemo() {
    return Builder(
      builder: (context) {
        final view = View.maybeOf(context);
        print('View.maybeOf result: ${view != null}');

        if (view != null) {
          print('FlutterView devicePixelRatio: ${view.devicePixelRatio}');
          print('FlutterView physicalSize: ${view.physicalSize}');
        }

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View Access',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Has View: ${view != null}'),
              if (view != null) ...[
                Text('DPR: ${view.devicePixelRatio.toStringAsFixed(2)}'),
                Text('Size: ${view.physicalSize}'),
              ],
            ],
          ),
        );
      },
    );
  }

  // Test 4: WidgetsBinding and root interaction
  print('--- WidgetsBinding Root ---');
  Widget buildBindingDemo() {
    final binding = WidgetsBinding.instance;
    print('WidgetsBinding: ${binding.runtimeType}');
    print('BuildOwner: ${binding.buildOwner?.runtimeType}');
    print('PipelineOwner: ${binding.rootPipelineOwner.runtimeType}');

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('WidgetsBinding', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Type: ${binding.runtimeType}'),
          Text('BuildOwner: ${binding.buildOwner?.runtimeType}'),
          Text('RootPipeline: ${binding.rootPipelineOwner.runtimeType}'),
        ],
      ),
    );
  }

  // Test 5: Root render object properties
  print('--- Root RenderObject ---');
  Widget buildRenderRootDemo() {
    return Builder(
      builder: (context) {
        // Schedule post-frame to access render tree
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final renderObject = context.findRenderObject();
          if (renderObject != null) {
            // Traverse up to find root
            RenderObject? current = renderObject;
            var levels = 0;
            while (current?.parent != null) {
              current = current!.parent;
              levels++;
            }
            print('Levels to root RenderObject: $levels');
            print('Root RenderObject type: ${current?.runtimeType}');

            if (current is RenderBox) {
              print(
                'Root is RenderBox with size: ${current.hasSize ? current.size : "no size"}',
              );
            }
          }
        });

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Render Root',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Check console for render tree info'),
            ],
          ),
        );
      },
    );
  }

  // Test 6: Root element rebuild behavior
  print('--- Root Rebuild ---');
  Widget buildRebuildDemo() {
    return StatefulBuilder(
      builder: (context, setState) {
        final element = context as Element;

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Rebuild Demo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Element: ${element.runtimeType}'),
              Text('Depth: ${element.depth}'),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  print('Triggering setState rebuild...');
                  setState(() {});
                  print('Rebuild scheduled');
                },
                child: Text('Trigger Rebuild'),
              ),
            ],
          ),
        );
      },
    );
  }

  print('RenderTreeRootElement test completed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('RenderTreeRootElement')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Root Element Concepts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            buildRootDetector(),
            SizedBox(height: 12),
            buildOwnerDemo(),
            SizedBox(height: 12),
            buildViewDemo(),
            SizedBox(height: 12),
            buildBindingDemo(),
            SizedBox(height: 12),
            buildRenderRootDemo(),
            SizedBox(height: 12),
            buildRebuildDemo(),
          ],
        ),
      ),
    ),
  );
}
