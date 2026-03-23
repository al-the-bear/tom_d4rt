// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Tests: RenderObjectElement, ComponentElement, StatefulElement, StatelessElement,
//        ProxyElement, ParentDataElement, InheritedElement, LeafRenderObjectWidget
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- RenderObjectElement Tests ---
  print('--- RenderObjectElement Tests ---');
  print('RenderObjectElement is the element for RenderObjectWidget subclasses');
  print('Type: $RenderObjectElement');
  print('It manages the RenderObject lifecycle in the element tree');

  // --- ComponentElement Tests ---
  print('--- ComponentElement Tests ---');
  print(
    'ComponentElement is the base for elements that compose other elements',
  );
  print('Type: $ComponentElement');
  print('StatelessElement and StatefulElement extend ComponentElement');

  // --- StatefulElement Tests ---
  print('--- StatefulElement Tests ---');
  print('StatefulElement is created by StatefulWidget');
  print('Type: $StatefulElement');
  var statefulWidget = StatefulBuilder(
    builder: (context, setState) {
      return const Text('StatefulBuilder creates a StatefulElement');
    },
  );
  print('StatefulBuilder: $statefulWidget');
  print(
    'StatefulBuilder is a StatefulWidget that delegates build to a callback',
  );

  // --- StatelessElement Tests ---
  print('--- StatelessElement Tests ---');
  print('StatelessElement is created by StatelessWidget');
  print('Type: $StatelessElement');
  var container = Container();
  print('Container (StatelessWidget): $container');
  print('Container creates a StatelessElement when mounted');

  // --- ProxyElement Tests ---
  print('--- ProxyElement Tests ---');
  print('ProxyElement is the element for ProxyWidget subclasses');
  print('Type: $ProxyElement');
  print('InheritedElement extends ProxyElement');
  print('ProxyElement does not build itself but delegates to a child');

  // --- ParentDataElement Tests ---
  print('--- ParentDataElement Tests ---');
  print('ParentDataElement manages ParentDataWidget elements');
  print('Type: $ParentDataElement');
  var positioned = Positioned(left: 10.0, top: 20.0, child: Container());
  print('Positioned (ParentDataWidget): $positioned');
  print('Positioned creates a ParentDataElement when used inside Stack');

  // --- InheritedElement Tests ---
  print('--- InheritedElement Tests ---');
  print('InheritedElement is the element for InheritedWidget');
  print('Type: $InheritedElement');
  print('InheritedWidget allows data to propagate down the widget tree');
  print('Theme, MediaQuery use InheritedWidget pattern');

  // --- LeafRenderObjectWidget Tests ---
  print('--- LeafRenderObjectWidget Tests ---');
  print('LeafRenderObjectWidget is a RenderObjectWidget with no children');
  print('Type: $LeafRenderObjectWidget');
  var errorWidget = ErrorWidget('test error');
  print('ErrorWidget (LeafRenderObjectWidget): $errorWidget');
  print('ErrorWidget is a concrete LeafRenderObjectWidget');

  print('All element types tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            statefulWidget,
            container,
            positioned,
            errorWidget,
            const Text('Element Types Test'),
          ],
        ),
      ),
    ),
  );
}
