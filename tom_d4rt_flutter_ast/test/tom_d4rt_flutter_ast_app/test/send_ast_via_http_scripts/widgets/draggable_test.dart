// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Draggable, DragTarget, LongPressDraggable from widgets
// Deep Demo: Visual configuration surface of drag-and-drop primitives
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Draggable Deep Demo executing');

  // ============================================================
  // SECTION 1: Drag-and-Drop Concept Overview
  // ============================================================
  print('=== Section 1: Drag-and-Drop Concept Overview ===');

  final conceptCards = <Widget>[];

  // Concept card 1: The Draggable (source)
  conceptCards.add(
    Container(
      width: 200.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.indigo.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.open_with, size: 40.0, color: Colors.blue.shade700),
          SizedBox(height: 8.0),
          Text(
            'Draggable<T>',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'The source.\nHolds a typed payload\nand starts the drag.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.blue.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept card 2: The Feedback widget
  conceptCards.add(
    Container(
      width: 200.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.touch_app,
            size: 40.0,
            color: Colors.orange.shade700,
          ),
          SizedBox(height: 8.0),
          Text(
            'feedback:',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'The ghost.\nFollows the pointer\nduring an active drag.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept card 3: The DragTarget
  conceptCards.add(
    Container(
      width: 200.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.teal.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.adjust,
            size: 40.0,
            color: Colors.green.shade700,
          ),
          SizedBox(height: 8.0),
          Text(
            'DragTarget<T>',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'The sink.\nDecides whether to\naccept the payload.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.green.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept flow diagram (arrow row)
  final conceptFlow = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFlowNode(Icons.drag_indicator, 'child', Colors.blue),
        Icon(Icons.arrow_forward, color: Colors.grey.shade600),
        _buildFlowNode(Icons.touch_app, 'feedback', Colors.orange),
        Icon(Icons.arrow_forward, color: Colors.grey.shade600),
        _buildFlowNode(Icons.adjust, 'target', Colors.green),
        Icon(Icons.arrow_forward, color: Colors.grey.shade600),
        _buildFlowNode(Icons.check_circle, 'onAccept', Colors.purple),
      ],
    ),
  );
  print('Created ${conceptCards.length} concept cards + flow diagram');

  // ============================================================
  // SECTION 2: Basic Draggable<String> + DragTarget<String> Pair
  // ============================================================
  print('=== Section 2: Basic Draggable + DragTarget Pair ===');

  final basicDraggable = Draggable<String>(
    data: 'apple',
    onDragStarted: () {
      print('basicDraggable: onDragStarted (apple)');
    },
    onDragEnd: (details) {
      print('basicDraggable: onDragEnd wasAccepted=${details.wasAccepted}');
    },
    onDraggableCanceled: (velocity, offset) {
      print('basicDraggable: canceled at $offset');
    },
    feedback: Material(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 120.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.blue.shade400,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            'apple',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    child: Container(
      width: 120.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.blue.shade700, width: 2.0),
      ),
      child: Center(
        child: Text(
          'Drag me',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
  print('Created basic Draggable<String>');

  final basicTarget = DragTarget<String>(
    builder: (context, candidateData, rejectedData) {
      return Container(
        width: 160.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: candidateData.isNotEmpty
              ? Colors.green.shade200
              : Colors.green.shade100,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.green.shade600,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Text(
            'Drop here',
            style: TextStyle(
              color: Colors.green.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    },
    onWillAccept: (data) {
      print('basicTarget: onWillAccept data=$data');
      return data != null;
    },
    onAccept: (data) {
      print('basicTarget: onAccept data=$data');
    },
    onLeave: (data) {
      print('basicTarget: onLeave data=$data');
    },
  );
  print('Created basic DragTarget<String>');

  final basicPair = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'Source -> Target',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            basicDraggable,
            Icon(
              Icons.east,
              size: 32.0,
              color: Colors.grey.shade500,
            ),
            basicTarget,
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Typed Payload Gallery
  // ============================================================
  print('=== Section 3: Typed Payload Gallery ===');

  // Draggable<int>
  final intDraggable = Draggable<int>(
    data: 42,
    onDragStarted: () {
      print('intDraggable: started (42)');
    },
    onDragCompleted: () {
      print('intDraggable: completed');
    },
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withValues(alpha: 0.5),
              blurRadius: 12.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            '42',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    child: Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade300,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '42',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );

  // Draggable<Color>
  final colorDraggable = Draggable<Color>(
    data: Colors.pink,
    onDragStarted: () {
      print('colorDraggable: started');
    },
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withValues(alpha: 0.5),
              blurRadius: 12.0,
            ),
          ],
        ),
        child: Icon(Icons.palette, color: Colors.white, size: 36.0),
      ),
    ),
    child: Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.pink.shade300,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Icon(Icons.palette, color: Colors.white, size: 32.0),
    ),
  );

  // Draggable<Map<String, dynamic>>
  final mapPayload = <String, dynamic>{
    'id': 7,
    'title': 'Task',
    'priority': 'high',
  };

  final mapDraggable = Draggable<Map<String, dynamic>>(
    data: mapPayload,
    onDragStarted: () {
      print('mapDraggable: started payload=$mapPayload');
    },
    onDragEnd: (details) {
      print('mapDraggable: end accepted=${details.wasAccepted}');
    },
    feedback: Material(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 140.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.teal.shade500,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.task_alt, color: Colors.white),
            Text(
              'Task #7',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
    child: Container(
      width: 140.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.teal.shade300,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.task_alt, color: Colors.white),
          Text(
            'Task Map',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'priority: high',
            style: TextStyle(color: Colors.white70, fontSize: 10.0),
          ),
        ],
      ),
    ),
  );

  // Typed target row that accepts int
  final intTarget = DragTarget<int>(
    builder: (context, candidateData, rejectedData) {
      return Container(
        width: 110.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.deepPurple.shade400,
            width: 2.0,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.numbers, color: Colors.deepPurple),
              Text(
                'int sink',
                style: TextStyle(
                  color: Colors.deepPurple.shade900,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
      );
    },
    onWillAccept: (data) {
      print('intTarget: willAccept $data');
      return data != null && data > 0;
    },
    onAccept: (data) {
      print('intTarget: accepted $data');
    },
  );

  final typedGallery = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'Typed payloads (drag source row + typed target)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                intDraggable,
                SizedBox(height: 4.0),
                Text(
                  'Draggable<int>',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                colorDraggable,
                SizedBox(height: 4.0),
                Text(
                  'Draggable<Color>',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                mapDraggable,
                SizedBox(height: 4.0),
                Text(
                  'Draggable<Map>',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                intTarget,
                SizedBox(height: 4.0),
                Text(
                  'DragTarget<int>',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Feedback Widget Variations
  // ============================================================
  print('=== Section 4: Feedback Widget Variations ===');

  // Small feedback
  final smallFeedback = Draggable<String>(
    data: 'small',
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.red.shade300,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Text(
          'small fb',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    ),
  );

  // Large feedback
  final largeFeedback = Draggable<String>(
    data: 'large',
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 200.0,
        height: 120.0,
        decoration: BoxDecoration(
          color: Colors.indigo.shade600,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withValues(alpha: 0.6),
              blurRadius: 20.0,
              spreadRadius: 4.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            'LARGE',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.indigo.shade300,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Text(
          'large fb',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    ),
  );

  // Styled (rotated + opacity) feedback
  final styledFeedback = Draggable<String>(
    data: 'styled',
    feedback: Material(
      color: Colors.transparent,
      child: Transform.rotate(
        angle: 0.1,
        child: Opacity(
          opacity: 0.85,
          child: Container(
            width: 110.0,
            height: 70.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber, Colors.orange],
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.6),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'tilted',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.amber.shade400,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Text(
          'styled fb',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    ),
  );

  // Custom anchor strategy feedback
  final anchorFeedback = Draggable<String>(
    data: 'anchored',
    dragAnchorStrategy: childDragAnchorStrategy,
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 100.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.cyan.shade600,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.withValues(alpha: 0.4),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            'anchored',
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.cyan.shade400,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Text(
          'anchor',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    ),
  );

  final feedbackVariations = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'feedback: variations (the ghost shown next to its child)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 18.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: [
            _buildFeedbackPair(
              'small',
              smallFeedback,
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            _buildFeedbackPair(
              'large',
              largeFeedback,
              Container(
                width: 80.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade600,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: Text(
                    'LARGE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ),
            ),
            _buildFeedbackPair(
              'styled',
              styledFeedback,
              Transform.rotate(
                angle: 0.1,
                child: Container(
                  width: 80.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber, Colors.orange],
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'tilted',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _buildFeedbackPair(
              'anchor',
              anchorFeedback,
              Container(
                width: 80.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.cyan.shade600,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: Text(
                    'anchored',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: childWhenDragging Variations
  // ============================================================
  print('=== Section 5: childWhenDragging Variations ===');

  // Ghosted (low opacity)
  final ghostedWhenDragging = Draggable<String>(
    data: 'ghosted',
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 100.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade700,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Text(
            'moving',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
    childWhenDragging: Opacity(
      opacity: 0.25,
      child: Container(
        width: 100.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade500,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Text(
            'ghosted',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade500,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Text(
          'ghosted',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );

  // Hidden (sized box)
  final hiddenWhenDragging = Draggable<String>(
    data: 'hidden',
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 100.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Text(
            'flying',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
    childWhenDragging: SizedBox(width: 100.0, height: 60.0),
    child: Container(
      width: 100.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Text(
          'hidden',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );

  // Placeholder (dashed border style)
  final placeholderWhenDragging = Draggable<String>(
    data: 'placeholder',
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 100.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Text(
            'moving',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
    childWhenDragging: Container(
      width: 100.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: Colors.purple,
          width: 2.0,
        ),
      ),
      child: Center(
        child: Text(
          'slot',
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Text(
          'card',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );

  final childWhenDraggingVariations = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'childWhenDragging: shown in original slot while drag is active',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 18.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: [
            _buildLabeledWidget('ghosted', ghostedWhenDragging),
            _buildLabeledWidget('hidden', hiddenWhenDragging),
            _buildLabeledWidget('placeholder', placeholderWhenDragging),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '(Demo is static — the variants render their child state)',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: LongPressDraggable Contrast
  // ============================================================
  print('=== Section 6: LongPressDraggable Contrast ===');

  final longPressBasic = LongPressDraggable<String>(
    data: 'longpress',
    delay: Duration(milliseconds: 500),
    onDragStarted: () {
      print('longPressBasic: started after delay');
    },
    onDragEnd: (details) {
      print('longPressBasic: end accepted=${details.wasAccepted}');
    },
    feedback: Material(
      elevation: 12.0,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 140.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.red.shade600,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            'long-press!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    child: Container(
      width: 140.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.red.shade400,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          'Long-press me',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );

  final longPressHaptic = LongPressDraggable<String>(
    data: 'haptic',
    hapticFeedbackOnStart: true,
    delay: Duration(milliseconds: 350),
    onDragStarted: () {
      print('longPressHaptic: started with haptic feedback');
    },
    onDragCompleted: () {
      print('longPressHaptic: completed');
    },
    feedback: Material(
      elevation: 12.0,
      child: Container(
        width: 140.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            'haptic on!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    childWhenDragging: Container(
      width: 140.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.deepOrange, width: 2.0),
      ),
      child: Center(
        child: Text(
          'lifted',
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),
    ),
    child: Container(
      width: 140.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          'Haptic LP',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );

  final longPressContrast = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.timer, color: Colors.red.shade700),
            SizedBox(width: 8.0),
            Text(
              'LongPressDraggable<T>',
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Same API as Draggable but requires a press-and-hold to start.',
          style: TextStyle(fontSize: 11.0, color: Colors.red.shade700),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: [
            _buildLabeledWidget('delay 500ms', longPressBasic),
            _buildLabeledWidget('haptic + ghost', longPressHaptic),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Axis-Locked Dragging
  // ============================================================
  print('=== Section 7: Axis-Locked Dragging ===');

  final horizontalLocked = Draggable<String>(
    data: 'h-locked',
    axis: Axis.horizontal,
    onDragStarted: () {
      print('horizontalLocked: started (axis=horizontal)');
    },
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 100.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Icon(Icons.swap_horiz, color: Colors.white),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.purple.shade400,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.swap_horiz, color: Colors.white, size: 18.0),
            SizedBox(width: 4.0),
            Text(
              'H-only',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ],
        ),
      ),
    ),
  );

  final verticalLocked = Draggable<String>(
    data: 'v-locked',
    axis: Axis.vertical,
    onDragStarted: () {
      print('verticalLocked: started (axis=vertical)');
    },
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 100.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Icon(Icons.swap_vert, color: Colors.white),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.teal.shade400,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.swap_vert, color: Colors.white, size: 18.0),
            SizedBox(width: 4.0),
            Text(
              'V-only',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ],
        ),
      ),
    ),
  );

  final freeDrag = Draggable<String>(
    data: 'free',
    onDragStarted: () {
      print('freeDrag: started (no axis lock)');
    },
    feedback: Material(
      color: Colors.transparent,
      child: Container(
        width: 100.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Icon(Icons.open_with, color: Colors.white),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade400,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.open_with, color: Colors.white, size: 18.0),
            SizedBox(width: 4.0),
            Text(
              'free',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ],
        ),
      ),
    ),
  );

  final axisDemo = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'axis: Axis.horizontal | Axis.vertical | null (free)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                horizontalLocked,
                SizedBox(height: 4.0),
                Text(
                  'Axis.horizontal',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                verticalLocked,
                SizedBox(height: 4.0),
                Text(
                  'Axis.vertical',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                freeDrag,
                SizedBox(height: 4.0),
                Text(
                  'axis: null',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Kanban Board (3 columns x 3 cards)
  // ============================================================
  print('=== Section 8: Kanban Board ===');

  final kanbanColumns = <Map<String, dynamic>>[
    {
      'title': 'Backlog',
      'color': Colors.grey,
      'icon': Icons.inbox,
      'cards': [
        {'title': 'Design tokens', 'priority': 'low', 'badge': 'design'},
        {'title': 'Audit logging', 'priority': 'med', 'badge': 'backend'},
        {'title': 'Spec review', 'priority': 'low', 'badge': 'docs'},
      ],
    },
    {
      'title': 'In Progress',
      'color': Colors.blue,
      'icon': Icons.engineering,
      'cards': [
        {'title': 'Drag-and-drop demo', 'priority': 'high', 'badge': 'ui'},
        {'title': 'Bridge hierarchy fix', 'priority': 'high', 'badge': 'd4rt'},
        {'title': 'Schema validator', 'priority': 'med', 'badge': 'tools'},
      ],
    },
    {
      'title': 'Done',
      'color': Colors.green,
      'icon': Icons.check_circle,
      'cards': [
        {'title': 'Init repo', 'priority': 'low', 'badge': 'meta'},
        {'title': 'Reflection regen', 'priority': 'med', 'badge': 'gen'},
        {'title': 'Bridge cache', 'priority': 'high', 'badge': 'perf'},
      ],
    },
  ];

  final kanbanWidgets = <Widget>[];
  for (int colIdx = 0; colIdx < kanbanColumns.length; colIdx++) {
    final col = kanbanColumns[colIdx];
    final colColor = col['color'] as MaterialColor;
    final colTitle = col['title'] as String;
    final colIcon = col['icon'] as IconData;
    final cards = col['cards'] as List<dynamic>;

    print('Building Kanban column: $colTitle (${cards.length} cards)');

    final cardWidgets = <Widget>[];
    for (int cardIdx = 0; cardIdx < cards.length; cardIdx++) {
      final card = cards[cardIdx] as Map<String, dynamic>;
      final priority = card['priority'] as String;
      final badge = card['badge'] as String;
      final title = card['title'] as String;

      Color priorityColor;
      if (priority == 'high') {
        priorityColor = Colors.red;
      } else if (priority == 'med') {
        priorityColor = Colors.orange;
      } else {
        priorityColor = Colors.green;
      }

      final cardPayload = <String, dynamic>{
        'column': colTitle,
        'title': title,
        'priority': priority,
      };

      final cardWidget = Draggable<Map<String, dynamic>>(
        data: cardPayload,
        onDragStarted: () {
          print('kanban card "$title" drag started');
        },
        onDragEnd: (details) {
          print('kanban card "$title" drag end wasAccepted=${details.wasAccepted}');
        },
        feedback: Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: 180.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: colColor.shade400, width: 2.0),
            ),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        childWhenDragging: Container(
          width: 180.0,
          height: 84.0,
          margin: EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            color: colColor.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: colColor.shade300,
              width: 1.0,
            ),
          ),
        ),
        child: Container(
          width: 180.0,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: colColor.shade200, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: priorityColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: colColor.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        fontSize: 9.0,
                        color: colColor.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(
                    Icons.flag,
                    size: 11.0,
                    color: priorityColor,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    priority,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: priorityColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      cardWidgets.add(cardWidget);
    }

    final columnTarget = DragTarget<Map<String, dynamic>>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 210.0,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: candidateData.isNotEmpty
                ? colColor.shade100
                : colColor.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: colColor.shade300,
              width: 2.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(colIcon, color: colColor.shade700, size: 18.0),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      colTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colColor.shade900,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: colColor.shade200,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      '${cards.length}',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: colColor.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                height: 1.0,
                color: colColor.shade200,
              ),
              SizedBox(height: 8.0),
              ...cardWidgets,
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: colColor.shade200,
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+ drop card here',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: colColor.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onWillAccept: (data) {
        print('column "$colTitle" willAccept payload=$data');
        return data != null && data['column'] != colTitle;
      },
      onAccept: (data) {
        print('column "$colTitle" accepted "${data['title']}"');
      },
      onLeave: (data) {
        print('column "$colTitle" leave $data');
      },
    );

    kanbanWidgets.add(columnTarget);
  }
  print('Kanban built: ${kanbanWidgets.length} columns');

  final kanbanBoard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: [
              Icon(Icons.view_kanban, color: Colors.blueGrey.shade800),
              SizedBox(width: 8.0),
              Text(
                'Kanban (3 columns x 3 cards)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: kanbanWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Code Examples
  // ============================================================
  print('=== Section 9: Code Examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Usage Patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Basic Draggable + DragTarget pair\n'
            'Draggable<String>(\n'
            '  data: "apple",\n'
            '  feedback: Material(child: ChipWidget()),\n'
            '  childWhenDragging: Opacity(opacity: 0.3, child: child),\n'
            '  child: ChipWidget(),\n'
            ');\n'
            '\n'
            'DragTarget<String>(\n'
            '  builder: (ctx, candidate, rejected) => Box(),\n'
            '  onWillAccept: (data) => data != null,\n'
            '  onAccept: (data) => print("got \$data"),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Axis-locked + long-press variant\n'
            'Draggable<int>(\n'
            '  axis: Axis.horizontal,\n'
            '  data: 42,\n'
            '  feedback: Bubble(),\n'
            '  child: Bubble(),\n'
            ');\n'
            '\n'
            'LongPressDraggable<String>(\n'
            '  data: "card",\n'
            '  hapticFeedbackOnStart: true,\n'
            '  delay: Duration(milliseconds: 350),\n'
            '  feedback: Lifted(),\n'
            '  child: Card(),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// DragTarget builder reacts to candidate state\n'
            'DragTarget<Map<String, dynamic>>(\n'
            '  builder: (ctx, candidate, rejected) {\n'
            '    final hovering = candidate.isNotEmpty;\n'
            '    return Container(\n'
            '      color: hovering ? hot : cool,\n'
            '      child: Text(hovering ? "Drop!" : "Drop here"),\n'
            '    );\n'
            '  },\n'
            '  onWillAccept: (data) => data?["priority"] == "high",\n'
            '  onAccept: (data) => store.add(data),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amber.shade300,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Summary Panel
  // ============================================================
  print('=== Section 10: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.drag_indicator,
          'Three roles',
          'child / feedback / target — every drag has all three',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.label,
          'Typed payloads',
          'Draggable<T> data flows to DragTarget<T> — type-safe end to end',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.touch_app,
          'Feedback widget',
          'A separate widget rendered under the pointer during drag',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.visibility_off,
          'childWhenDragging',
          'What shows in the source slot while the drag is in flight',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.timer,
          'LongPressDraggable',
          'Same API, but requires a press-and-hold to start',
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.swap_horiz,
          'Axis lock',
          'axis: Axis.horizontal | Axis.vertical constrains the drag',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.check_circle,
          'Acceptance flow',
          'onWillAccept gates -> onAccept commits -> onLeave on exit',
          Colors.indigo,
        ),
      ],
    ),
  );

  print('Draggable Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.open_with, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'Draggable / DragTarget',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Drag-and-drop configuration surface',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1: Concepts
        Text(
          '1. Drag-and-Drop Concepts',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: conceptCards,
        ),
        SizedBox(height: 12.0),
        conceptFlow,
        SizedBox(height: 32.0),

        // Section 2: Basic pair
        Text(
          '2. Basic Draggable + DragTarget Pair',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        basicPair,
        SizedBox(height: 32.0),

        // Section 3: Typed payload gallery
        Text(
          '3. Typed Payload Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        typedGallery,
        SizedBox(height: 32.0),

        // Section 4: Feedback variations
        Text(
          '4. feedback: Variations',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        feedbackVariations,
        SizedBox(height: 32.0),

        // Section 5: childWhenDragging variations
        Text(
          '5. childWhenDragging: Variations',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        childWhenDraggingVariations,
        SizedBox(height: 32.0),

        // Section 6: LongPressDraggable
        Text(
          '6. LongPressDraggable Contrast',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        longPressContrast,
        SizedBox(height: 32.0),

        // Section 7: Axis-locked dragging
        Text(
          '7. Axis-Locked Dragging',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        axisDemo,
        SizedBox(height: 32.0),

        // Section 8: Kanban board
        Text(
          '8. Kanban Board (real-world layout)',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        kanbanBoard,
        SizedBox(height: 32.0),

        // Section 9: Code examples
        Text(
          '9. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeExamples,
        SizedBox(height: 32.0),

        // Section 10: Summary
        Text(
          '10. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// Helper: Build a small concept-flow node
Widget _buildFlowNode(IconData icon, String label, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 44.0,
        height: 44.0,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2.0),
        ),
        child: Icon(icon, color: color, size: 22.0),
      ),
      SizedBox(height: 4.0),
      Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.0,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

// Helper: Build a feedback pair (live draggable + static preview of feedback)
Widget _buildFeedbackPair(String label, Widget draggable, Widget feedbackPreview) {
  return Container(
    width: 130.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'child:',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 4.0),
        draggable,
        SizedBox(height: 8.0),
        Text(
          'feedback:',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 4.0),
        feedbackPreview,
      ],
    ),
  );
}

// Helper: Wrap a widget with a small monospace label
Widget _buildLabeledWidget(String label, Widget widget) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      widget,
      SizedBox(height: 4.0),
      Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.0,
          color: Colors.grey.shade700,
        ),
      ),
    ],
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
