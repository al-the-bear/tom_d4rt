// D4rt test script: Tests FocusNode and FocusScope widgets from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FocusNode test executing');

  // Test basic FocusNode
  final basicNode = FocusNode();
  print('Basic FocusNode created');
  print('FocusNode hasFocus: ${basicNode.hasFocus}');
  print('FocusNode hasPrimaryFocus: ${basicNode.hasPrimaryFocus}');
  print('FocusNode canRequestFocus: ${basicNode.canRequestFocus}');
  print('FocusNode skipTraversal: ${basicNode.skipTraversal}');

  // Test FocusNode with debugLabel
  final labeledNode = FocusNode(debugLabel: 'MyFocusNode');
  print('FocusNode with debugLabel created: ${labeledNode.debugLabel}');

  // Test FocusNode with skipTraversal
  final skipNode = FocusNode(skipTraversal: true);
  print('FocusNode with skipTraversal=true created');

  // Test FocusNode with canRequestFocus
  final noRequestNode = FocusNode(canRequestFocus: false);
  print('FocusNode with canRequestFocus=false created');

  // Test FocusNode with descendantsAreFocusable
  final noDescendantsNode = FocusNode(descendantsAreFocusable: false);
  print('FocusNode with descendantsAreFocusable=false created');

  // Test FocusNode methods
  print('FocusNode.requestFocus() - requests focus');
  print('FocusNode.unfocus() - removes focus');
  print('FocusNode.nextFocus() - moves to next');
  print('FocusNode.previousFocus() - moves to previous');
  print('FocusNode.dispose() - cleans up');

  // Test FocusNode with listener
  final listenNode = FocusNode();
  listenNode.addListener(() {
    print('FocusNode focus changed: ${listenNode.hasFocus}');
  });
  print('FocusNode with listener created');

  // Test FocusScope widget
  final focusScopeWidget = FocusScope(
    child: Column(
      children: [
        TextField(decoration: InputDecoration(labelText: 'Field 1')),
        TextField(decoration: InputDecoration(labelText: 'Field 2')),
        TextField(decoration: InputDecoration(labelText: 'Field 3')),
      ],
    ),
  );
  print('FocusScope widget with 3 text fields created');

  // Test FocusScope with autofocus
  final autofocusScope = FocusScope(
    autofocus: true,
    child: TextField(decoration: InputDecoration(labelText: 'Autofocus Scope')),
  );
  print('FocusScope with autofocus=true created');

  // Test FocusScope with skipTraversal
  final skipScope = FocusScope(
    skipTraversal: true,
    child: TextField(decoration: InputDecoration(labelText: 'Skip Traversal')),
  );
  print('FocusScope with skipTraversal=true created');

  // Test FocusScope with canRequestFocus
  final noFocusScope = FocusScope(
    canRequestFocus: false,
    child: TextField(decoration: InputDecoration(labelText: 'No Focus')),
  );
  print('FocusScope with canRequestFocus=false created');

  // Test FocusScope.of(context) methods
  print('FocusScope.of(context) - gets nearest FocusScopeNode');
  print('FocusScopeNode.requestFocus() - requests focus for node');
  print('FocusScopeNode.unfocus() - removes focus from scope');
  print('FocusScopeNode.nextFocus() - next in scope');
  print('FocusScopeNode.previousFocus() - previous in scope');

  // Test Focus widget
  final focusWidget = Focus(
    onFocusChange: (hasFocus) {
      print('Focus changed: $hasFocus');
    },
    child: Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue.shade100,
      child: Text('Focusable Container'),
    ),
  );
  print('Focus widget with onFocusChange created');

  // Test Focus with autofocus
  final autofocusWidget = Focus(
    autofocus: true,
    child: Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.green.shade100,
      child: Text('Autofocus Container'),
    ),
  );
  print('Focus widget with autofocus=true created');

  // Test Focus with focusNode
  final customNodeWidget = Focus(
    focusNode: FocusNode(debugLabel: 'Custom'),
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Custom Node Container'),
    ),
  );
  print('Focus widget with custom focusNode created');

  // Test Focus with onKey
  final keyHandlerWidget = Focus(
    onKey: (node, event) {
      print('Key event: ${event.logicalKey}');
      return KeyEventResult.ignored;
    },
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Key Handler Container'),
    ),
  );
  print('Focus widget with onKey handler created');

  // Test FocusTraversalGroup
  final traversalGroup = FocusTraversalGroup(
    policy: OrderedTraversalPolicy(),
    child: Column(
      children: [
        FocusTraversalOrder(
          order: NumericFocusOrder(2.0),
          child: TextField(decoration: InputDecoration(labelText: 'Second')),
        ),
        FocusTraversalOrder(
          order: NumericFocusOrder(1.0),
          child: TextField(decoration: InputDecoration(labelText: 'First')),
        ),
        FocusTraversalOrder(
          order: NumericFocusOrder(3.0),
          child: TextField(decoration: InputDecoration(labelText: 'Third')),
        ),
      ],
    ),
  );
  print('FocusTraversalGroup with OrderedTraversalPolicy created');

  // Test ReadingOrderTraversalPolicy
  final readingOrder = FocusTraversalGroup(
    policy: ReadingOrderTraversalPolicy(),
    child: Row(
      children: [
        Expanded(
          child: TextField(decoration: InputDecoration(labelText: 'Left')),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: TextField(decoration: InputDecoration(labelText: 'Right')),
        ),
      ],
    ),
  );
  print('FocusTraversalGroup with ReadingOrderTraversalPolicy created');

  // Test WidgetOrderTraversalPolicy
  final widgetOrder = FocusTraversalGroup(
    policy: WidgetOrderTraversalPolicy(),
    child: Column(
      children: [
        TextField(decoration: InputDecoration(labelText: 'Order 1')),
        TextField(decoration: InputDecoration(labelText: 'Order 2')),
      ],
    ),
  );
  print('FocusTraversalGroup with WidgetOrderTraversalPolicy created');

  // Test ExcludeFocus
  final excludeFocus = ExcludeFocus(
    child: TextField(decoration: InputDecoration(labelText: 'Excluded')),
  );
  print('ExcludeFocus widget created');

  // Test FocusNode tree structure
  print('FocusNode.parent - parent node');
  print('FocusNode.children - child nodes');
  print('FocusNode.ancestors - ancestor nodes');
  print('FocusNode.descendants - descendant nodes');

  print('FocusNode test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'FocusNode Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'FocusScope Widget:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        focusScopeWidget,
        SizedBox(height: 16.0),
        Text('Focus Widget:', style: TextStyle(fontWeight: FontWeight.bold)),
        focusWidget,
        SizedBox(height: 16.0),
        autofocusWidget,
        SizedBox(height: 16.0),
        Text('Traversal Group:', style: TextStyle(fontWeight: FontWeight.bold)),
        traversalGroup,
        SizedBox(height: 16.0),
        Text('Reading Order:', style: TextStyle(fontWeight: FontWeight.bold)),
        readingOrder,
        SizedBox(height: 16.0),
        Text('Widget Order:', style: TextStyle(fontWeight: FontWeight.bold)),
        widgetOrder,
      ],
    ),
  );
}
