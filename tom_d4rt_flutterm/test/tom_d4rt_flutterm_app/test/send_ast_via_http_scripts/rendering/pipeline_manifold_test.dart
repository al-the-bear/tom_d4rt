// D4rt test script: Tests PipelineManifold from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Test implementation of PipelineManifold
class TestPipelineManifold extends PipelineManifold {
  final Set<Listenable> _semanticsListeners = {};
  
  @override
  void requestVisualUpdate() {
    print('  requestVisualUpdate called');
  }
  
  @override
  void addSemanticsListener(Listenable listener) {
    _semanticsListeners.add(listener);
    print('  addSemanticsListener: total listeners = ${_semanticsListeners.length}');
  }
  
  @override
  void removeSemanticsListener(Listenable listener) {
    _semanticsListeners.remove(listener);
    print('  removeSemanticsListener: total listeners = ${_semanticsListeners.length}');
  }
  
  int get listenerCount => _semanticsListeners.length;
}

/// A simple test Listenable for testing semantics listeners
class TestListenable extends ChangeNotifier {
  final String name;
  TestListenable(this.name);
}

dynamic build(BuildContext context) {
  print('PipelineManifold test executing');

  // ========== Basic PipelineManifold ==========
  print('--- Basic PipelineManifold ---');
  final manifold = TestPipelineManifold();
  print('  created: ${manifold.runtimeType}');
  print('  is PipelineManifold: ${manifold is PipelineManifold}');

  // ========== requestVisualUpdate method ==========
  print('--- requestVisualUpdate method ---');
  manifold.requestVisualUpdate();
  manifold.requestVisualUpdate();
  manifold.requestVisualUpdate();
  print('  requestVisualUpdate called 3 times');

  // ========== addSemanticsListener method ==========
  print('--- addSemanticsListener method ---');
  final listener1 = TestListenable('listener1');
  manifold.addSemanticsListener(listener1);
  
  final listener2 = TestListenable('listener2');
  manifold.addSemanticsListener(listener2);
  
  final listener3 = TestListenable('listener3');
  manifold.addSemanticsListener(listener3);
  
  print('  listener count after adding 3: ${manifold.listenerCount}');

  // ========== removeSemanticsListener method ==========
  print('--- removeSemanticsListener method ---');
  manifold.removeSemanticsListener(listener2);
  print('  listener count after removing 1: ${manifold.listenerCount}');
  
  manifold.removeSemanticsListener(listener1);
  print('  listener count after removing 2: ${manifold.listenerCount}');

  // ========== Multiple manifolds ==========
  print('--- Multiple manifolds ---');
  final manifold2 = TestPipelineManifold();
  final manifold3 = TestPipelineManifold();
  print('  manifold2: ${manifold2.runtimeType}');
  print('  manifold3: ${manifold3.runtimeType}');
  
  // Add listeners to multiple manifolds
  final sharedListener = TestListenable('shared');
  manifold2.addSemanticsListener(sharedListener);
  manifold3.addSemanticsListener(sharedListener);
  print('  shared listener added to manifold2 and manifold3');
  print('  manifold2 listener count: ${manifold2.listenerCount}');
  print('  manifold3 listener count: ${manifold3.listenerCount}');

  // ========== Adding same listener multiple times ==========
  print('--- Adding same listener multiple times ---');
  final newManifold = TestPipelineManifold();
  final sameListener = TestListenable('same');
  newManifold.addSemanticsListener(sameListener);
  newManifold.addSemanticsListener(sameListener); // Add again
  print('  added same listener twice, count: ${newManifold.listenerCount}'); // Set prevents duplicates

  // ========== Request visual update multiple times ==========
  print('--- Multiple visual update requests ---');
  final updateManifold = TestPipelineManifold();
  for (int i = 0; i < 5; i++) {
    updateManifold.requestVisualUpdate();
  }
  print('  requested visual update 5 times');

  // ========== Many listeners ==========
  print('--- Many listeners ---');
  final manyListenersManifold = TestPipelineManifold();
  final listeners = List.generate(10, (i) => TestListenable('listener_$i'));
  for (final l in listeners) {
    manyListenersManifold.addSemanticsListener(l);
  }
  print('  added 10 listeners, count: ${manyListenersManifold.listenerCount}');
  
  // Remove half
  for (int i = 0; i < 5; i++) {
    manyListenersManifold.removeSemanticsListener(listeners[i]);
  }
  print('  removed 5 listeners, count: ${manyListenersManifold.listenerCount}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  manifold.runtimeType: ${manifold.runtimeType}');
  print('  manifold2.runtimeType: ${manifold2.runtimeType}');
  print('  listener1.runtimeType: ${listener1.runtimeType}');

  print('PipelineManifold test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('PipelineManifold Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Type: ${manifold.runtimeType}'),
          Text('Interface: PipelineManifold'),
          SizedBox(height: 8.0),
          Text('Methods:'),
          Text('  - requestVisualUpdate()'),
          Text('  - addSemanticsListener(Listenable)'),
          Text('  - removeSemanticsListener(Listenable)'),
          SizedBox(height: 8.0),
          Text('Test results:'),
          Text('  manifold listener count: ${manifold.listenerCount}'),
          Text('  manifold2 listener count: ${manifold2.listenerCount}'),
          Text('  manifold3 listener count: ${manifold3.listenerCount}'),
          Text('  manyListeners count: ${manyListenersManifold.listenerCount}'),
          SizedBox(height: 8.0),
          Text('Purpose: Manages rendering pipeline'),
          Text('Used for semantics and visual updates'),
        ],
      ),
    ),
  );
}
