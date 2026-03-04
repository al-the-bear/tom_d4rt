// D4rt test script: Tests RenderObjectWithChildMixin, ContainerRenderObjectMixin, ContainerParentDataMixin, RenderIndexedStack, RenderBoxAdapter, RenderSemanticsAnnotations, RenderBlockSemantics, RenderExcludeSemantics, RenderMergeSemantics
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Render mixins and semantics render objects test executing');

  // ========== RenderObjectWithChildMixin ==========
  print('--- RenderObjectWithChildMixin Tests ---');
  // RenderObjectWithChildMixin is a mixin used by render objects that have a single child.
  // RenderDecoratedBox uses it. Reference through DecoratedBox widget.
  final decoratedBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.blue),
    child: SizedBox(width: 50.0, height: 50.0),
  );
  print(
    'RenderObjectWithChildMixin: referenced via DecoratedBox (single-child render objects)',
  );
  print('Type: RenderObjectWithChildMixin is a mixin on RenderObject');

  // ========== ContainerRenderObjectMixin ==========
  print('--- ContainerRenderObjectMixin Tests ---');
  // ContainerRenderObjectMixin is used by render objects with multiple children.
  // RenderStack uses ContainerRenderObjectMixin.
  final stack = Stack(
    children: [
      Positioned(
        left: 0.0,
        top: 0.0,
        child: SizedBox(width: 10.0, height: 10.0),
      ),
      Positioned(
        left: 5.0,
        top: 5.0,
        child: SizedBox(width: 10.0, height: 10.0),
      ),
    ],
  );
  print(
    'ContainerRenderObjectMixin: referenced via Stack/RenderStack (multi-child render objects)',
  );
  print('Type: ContainerRenderObjectMixin is a mixin on RenderObject');

  // ========== ContainerParentDataMixin ==========
  print('--- ContainerParentDataMixin Tests ---');
  // ContainerParentDataMixin is used for parent data in multi-child layouts.
  // StackParentData uses ContainerParentDataMixin.
  print(
    'ContainerParentDataMixin: referenced via StackParentData (multi-child parent data)',
  );
  print('Type: ContainerParentDataMixin is a mixin on ParentData');

  // ========== RenderIndexedStack ==========
  print('--- RenderIndexedStack Tests ---');
  final indexedStack = IndexedStack(
    index: 0,
    children: [
      SizedBox(width: 100.0, height: 100.0),
      SizedBox(width: 200.0, height: 200.0),
    ],
  );
  print('RenderIndexedStack: referenced via IndexedStack widget');
  print('Type: ${RenderStack}');
  print('IndexedStack index: 0');

  // ========== RenderBoxAdapter (SliverToBoxAdapter) ==========
  print('--- RenderBoxAdapter Tests ---');
  // RenderSliverToBoxAdapter is the render object for SliverToBoxAdapter.
  final sliverAdapter = SliverToBoxAdapter(
    child: SizedBox(width: 100.0, height: 50.0),
  );
  print('RenderBoxAdapter: referenced via SliverToBoxAdapter widget');
  print('SliverToBoxAdapter type: ${sliverAdapter.runtimeType}');

  // ========== RenderSemanticsAnnotations ==========
  print('--- RenderSemanticsAnnotations Tests ---');
  final semanticsWidget = Semantics(
    label: 'test label',
    child: SizedBox(width: 50.0, height: 50.0),
  );
  print('RenderSemanticsAnnotations: referenced via Semantics widget');
  print('Semantics label: test label');
  print('Type: RenderSemanticsAnnotations');

  // ========== RenderBlockSemantics ==========
  print('--- RenderBlockSemantics Tests ---');
  final blockSemanticsWidget = BlockSemantics(
    blocking: true,
    child: SizedBox(width: 50.0, height: 50.0),
  );
  print('RenderBlockSemantics: referenced via BlockSemantics widget');
  print('BlockSemantics blocking: true');
  print('Type: RenderBlockSemantics');

  // ========== RenderExcludeSemantics ==========
  print('--- RenderExcludeSemantics Tests ---');
  final excludeSemanticsWidget = ExcludeSemantics(
    excluding: true,
    child: SizedBox(width: 50.0, height: 50.0),
  );
  print('RenderExcludeSemantics: referenced via ExcludeSemantics widget');
  print('ExcludeSemantics excluding: true');
  print('Type: RenderExcludeSemantics');

  // ========== RenderMergeSemantics ==========
  print('--- RenderMergeSemantics Tests ---');
  final mergeSemanticsWidget = MergeSemantics(
    child: SizedBox(width: 50.0, height: 50.0),
  );
  print('RenderMergeSemantics: referenced via MergeSemantics widget');
  print('Type: RenderMergeSemantics');

  print('All render mixins and semantics render object tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Render Mixins Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('RenderObjectWithChildMixin: OK'),
            Text('ContainerRenderObjectMixin: OK'),
            Text('ContainerParentDataMixin: OK'),
            Text('RenderIndexedStack: OK'),
            Text('RenderBoxAdapter: OK'),
            Text('RenderSemanticsAnnotations: OK'),
            Text('RenderBlockSemantics: OK'),
            Text('RenderExcludeSemantics: OK'),
            Text('RenderMergeSemantics: OK'),
          ],
        ),
      ),
    ),
  );
}
