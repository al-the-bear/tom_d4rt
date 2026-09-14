// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import, unnecessary_type_check
// D4rt test script: Deep visual demo of ObjectEvent and its subclasses
// (ObjectCreated, ObjectDisposed) from package:flutter/foundation.dart.
//
// ObjectEvent is the abstract base class for memory-allocation events fired
// by FlutterMemoryAllocations. Subclasses describe lifecycle moments of an
// instrumented object: creation (with library + className) and disposal.
//
// This file is a hand-authored visual showcase that explores:
//   - the type hierarchy of ObjectEvent
//   - the per-subclass payload (which fields are required, which are optional)
//   - how the events fit into the FlutterMemoryAllocations dispatch model
//   - common pitfalls when instrumenting memory-allocation tracking
//   - a side-by-side comparison of ObjectCreated vs ObjectDisposed
//   - debugging recipes and a quick-reference cheat sheet
//
// Static motion only: AlwaysStoppedAnimation<double> + Duration.zero.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Construct sample events. ObjectEvent itself is abstract, so we exercise it
  // via its concrete subclasses ObjectCreated and ObjectDisposed.
  // ---------------------------------------------------------------------------
  final Object widgetObject = Object();
  final Object renderObject = Object();
  final Object stateObject = Object();
  final Object animationObject = Object();
  final Object controllerObject = Object();
  final Object disposedWidget = Object();
  final Object disposedRender = Object();
  final Object disposedState = Object();

  final ObjectCreated createdWidget = ObjectCreated(
    library: 'package:flutter/widgets.dart',
    className: 'Text',
    object: widgetObject,
  );
  final ObjectCreated createdRender = ObjectCreated(
    library: 'package:flutter/rendering.dart',
    className: 'RenderParagraph',
    object: renderObject,
  );
  final ObjectCreated createdState = ObjectCreated(
    library: 'package:flutter/widgets.dart',
    className: '_ScaffoldState',
    object: stateObject,
  );
  final ObjectCreated createdAnimation = ObjectCreated(
    library: 'package:flutter/animation.dart',
    className: 'AnimationController',
    object: animationObject,
  );
  final ObjectCreated createdController = ObjectCreated(
    library: 'package:flutter/material.dart',
    className: 'TextEditingController',
    object: controllerObject,
  );

  final ObjectDisposed disposedW = ObjectDisposed(object: disposedWidget);
  final ObjectDisposed disposedR = ObjectDisposed(object: disposedRender);
  final ObjectDisposed disposedS = ObjectDisposed(object: disposedState);

  // Polymorphic references to the abstract base type. These are real
  // ObjectEvent instances (because both subclasses extend ObjectEvent).
  final ObjectEvent eventA = createdWidget;
  final ObjectEvent eventB = disposedW;
  final ObjectEvent eventC = createdAnimation;
  final ObjectEvent eventD = disposedR;

  final List<ObjectEvent> mixedEvents = <ObjectEvent>[
    createdWidget,
    createdRender,
    disposedW,
    createdState,
    disposedR,
    createdAnimation,
    disposedS,
    createdController,
  ];

  // Static animation values for any decoration that asks for an Animation.
  final Animation<double> still = AlwaysStoppedAnimation<double>(1.0);
  final Animation<double> half = AlwaysStoppedAnimation<double>(0.5);
  final Duration noMotion = Duration.zero;

  return MaterialApp(
    home: Scaffold(
      backgroundColor: Color(0xFFF4F1FA),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Section 1
            _buildHeroHeader(),
            SizedBox(height: 28.0),

            // Section 2
            _buildSectionTitle('1. Anatomy of a Memory-Allocation Event'),
            SizedBox(height: 12.0),
            _buildAnatomy(),
            SizedBox(height: 28.0),

            // Section 3
            _buildSectionTitle('2. Subclass Cards: ObjectCreated'),
            SizedBox(height: 12.0),
            _buildObjectCreatedCard(createdWidget),
            SizedBox(height: 12.0),
            _buildObjectCreatedCard(createdRender),
            SizedBox(height: 12.0),
            _buildObjectCreatedCard(createdAnimation),
            SizedBox(height: 28.0),

            // Section 4
            _buildSectionTitle('3. Subclass Cards: ObjectDisposed'),
            SizedBox(height: 12.0),
            _buildObjectDisposedCard(disposedW, 'Text'),
            SizedBox(height: 12.0),
            _buildObjectDisposedCard(disposedR, 'RenderParagraph'),
            SizedBox(height: 12.0),
            _buildObjectDisposedCard(disposedS, '_ScaffoldState'),
            SizedBox(height: 28.0),

            // Section 5
            _buildSectionTitle('4. Type Hierarchy & is-Checks'),
            SizedBox(height: 12.0),
            _buildHierarchy(eventA, eventB, eventC, eventD),
            SizedBox(height: 28.0),

            // Section 6
            _buildSectionTitle('5. FlutterMemoryAllocations Recipes'),
            SizedBox(height: 12.0),
            _buildRecipes(),
            SizedBox(height: 28.0),

            // Section 7
            _buildSectionTitle('6. Pitfalls'),
            SizedBox(height: 12.0),
            _buildPitfalls(),
            SizedBox(height: 28.0),

            // Section 8
            _buildSectionTitle('7. Comparison Table'),
            SizedBox(height: 12.0),
            _buildComparisonTable(),
            SizedBox(height: 28.0),

            // Section 9
            _buildSectionTitle('8. Debugging Workflow'),
            SizedBox(height: 12.0),
            _buildDebuggingWorkflow(),
            SizedBox(height: 28.0),

            // Section 10
            _buildSectionTitle('9. Mixed Event Stream'),
            SizedBox(height: 12.0),
            _buildMixedStream(mixedEvents),
            SizedBox(height: 28.0),

            // Section 11
            _buildSectionTitle('10. Quick Reference'),
            SizedBox(height: 12.0),
            _buildQuickReference(),
            SizedBox(height: 28.0),

            // Section 12 - Footer
            _buildAsciiFooter(),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 1: Hero header
// =============================================================================

Widget _buildHeroHeader() {
  return Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF311B92),
          Color(0xFF512DA8),
          Color(0xFF7B1FA2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x66311B92),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFFFFFF), Color(0xFFE1BEE7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x55000000),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.memory,
                size: 44.0,
                color: Color(0xFF512DA8),
              ),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ObjectEvent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/foundation.dart',
                    style: TextStyle(
                      color: Color(0xFFE1BEE7),
                      fontSize: 14.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0x55FFFFFF), width: 1.0),
          ),
          child: Text(
            'Abstract base for memory-allocation events. Subclasses: '
            'ObjectCreated, ObjectDisposed. Fired through '
            'FlutterMemoryAllocations.dispatchObjectEvent.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            _buildPill('abstract', Color(0xFFFFD54F), Color(0xFF5D4037)),
            SizedBox(width: 8.0),
            _buildPill('foundation', Color(0xFF80DEEA), Color(0xFF004D40)),
            SizedBox(width: 8.0),
            _buildPill('memory', Color(0xFFF48FB1), Color(0xFF880E4F)),
            SizedBox(width: 8.0),
            _buildPill('debug-only', Color(0xFFA5D6A7), Color(0xFF1B5E20)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPill(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildSectionTitle(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFEDE7F6), Color(0xFFFFFFFF)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: Color(0xFF512DA8), width: 5.0),
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 19.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF311B92),
      ),
    ),
  );
}

// =============================================================================
// SECTION 2: Anatomy of a memory-allocation event
// =============================================================================

Widget _buildAnatomy() {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFFFFDE7), Color(0xFFFFF9C4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFFBC02D), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33FBC02D),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.architecture, color: Color(0xFFF57F17), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Event Anatomy',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _anatomyRow(
          Icons.label_important,
          'object',
          'Object',
          'Reference to the actual instrumented object. Required on every event.',
          Color(0xFFD84315),
        ),
        SizedBox(height: 8.0),
        _anatomyRow(
          Icons.menu_book,
          'library',
          'String',
          'Name of the instrumented library, e.g. package:flutter/widgets.dart. '
          '(Only on ObjectCreated.)',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 8.0),
        _anatomyRow(
          Icons.class_,
          'className',
          'String',
          'Concrete class name of the object, e.g. Text. '
          '(Only on ObjectCreated.)',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 8.0),
        _anatomyRow(
          Icons.fingerprint,
          'object.hashCode',
          'int',
          'Used as the inner key inside toMap() so multiple objects can be '
          'represented in the same flat map.',
          Color(0xFF2E7D32),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(
    IconData icon, String name, String type, String desc, Color color) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.0,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                desc,
                style: TextStyle(fontSize: 12.0, color: Color(0xFF424242)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3 / 4: Per-subclass cards
// =============================================================================

Widget _buildObjectCreatedCard(ObjectCreated event) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF388E3C), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33388E3C),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x66000000),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ObjectCreated',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  Text(
                    'extends ObjectEvent',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Color(0xFF388E3C),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Color(0xFF1B5E20),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'CREATE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _fieldRow('library', event.library, Icons.menu_book,
            Color(0xFF1565C0)),
        SizedBox(height: 6.0),
        _fieldRow('className', event.className, Icons.class_,
            Color(0xFF6A1B9A)),
        SizedBox(height: 6.0),
        _fieldRow('object', '<Object#${event.object.hashCode}>',
            Icons.label_important, Color(0xFFD84315)),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          "ObjectCreated(\n"
          "  library: '${event.library}',\n"
          "  className: '${event.className}',\n"
          "  object: <ref>,\n"
          ");",
        ),
      ],
    ),
  );
}

Widget _buildObjectDisposedCard(ObjectDisposed event, String hintClass) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFC62828), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33C62828),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFFC62828),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x66000000),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ObjectDisposed',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                  Text(
                    'extends ObjectEvent',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Color(0xFFC62828),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Color(0xFFB71C1C),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'DISPOSE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0x22B71C1C),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.info_outline,
                  color: Color(0xFFB71C1C), size: 16.0),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  'ObjectDisposed only carries the object reference; '
                  'class info is recovered by listeners that already saw '
                  'the matching ObjectCreated event.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF7F0000),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        _fieldRow('object', '<Object#${event.object.hashCode}>',
            Icons.label_important, Color(0xFFD84315)),
        SizedBox(height: 6.0),
        _fieldRow('hint(prev className)', hintClass, Icons.class_,
            Color(0xFF6A1B9A)),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          "ObjectDisposed(\n"
          "  object: <ref>,\n"
          ");",
        ),
      ],
    ),
  );
}

Widget _fieldRow(String name, String value, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        SizedBox(
          width: 130.0,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFF263238),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: Color(0xFFB2EBF2),
        height: 1.4,
      ),
    ),
  );
}

// =============================================================================
// SECTION 5: Type hierarchy
// =============================================================================

Widget _buildHierarchy(
    ObjectEvent a, ObjectEvent b, ObjectEvent c, ObjectEvent d) {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF1976D2), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x331976D2),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        // The base
        _hierarchyNode(
          'ObjectEvent',
          'abstract',
          Color(0xFF0D47A1),
          Icons.account_tree,
        ),
        SizedBox(height: 8.0),
        Icon(Icons.south, color: Color(0xFF1976D2), size: 28.0),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _hierarchyNode(
              'ObjectCreated',
              'concrete',
              Color(0xFF2E7D32),
              Icons.add_circle_outline,
            ),
            _hierarchyNode(
              'ObjectDisposed',
              'concrete',
              Color(0xFFC62828),
              Icons.delete_outline,
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'is-checks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(height: 8.0),
              _isCheckRow('eventA', 'ObjectCreated', a is ObjectCreated),
              _isCheckRow('eventA', 'ObjectDisposed', a is ObjectDisposed),
              _isCheckRow('eventA', 'ObjectEvent', a is ObjectEvent),
              Divider(),
              _isCheckRow('eventB', 'ObjectCreated', b is ObjectCreated),
              _isCheckRow('eventB', 'ObjectDisposed', b is ObjectDisposed),
              _isCheckRow('eventB', 'ObjectEvent', b is ObjectEvent),
              Divider(),
              _isCheckRow('eventC', 'ObjectCreated', c is ObjectCreated),
              _isCheckRow('eventD', 'ObjectDisposed', d is ObjectDisposed),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _hierarchyNode(
    String label, String tag, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: color, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            tag,
            style: TextStyle(
              fontSize: 10.0,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _isCheckRow(String varName, String type, bool result) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: <Widget>[
        Icon(
          result ? Icons.check_circle : Icons.cancel,
          size: 16.0,
          color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
        ),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            '$varName is $type',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFF263238),
            ),
          ),
        ),
        Text(
          result ? 'true' : 'false',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 6: Recipes for FlutterMemoryAllocations
// =============================================================================

Widget _buildRecipes() {
  return Column(
    children: <Widget>[
      _buildRecipeCard(
        'Dispatch on construction',
        Icons.add_circle_outline,
        Color(0xFF2E7D32),
        'In a constructor of an instrumented type, dispatch an ObjectCreated '
            'event so memory tooling can attribute the allocation.',
        "if (kFlutterMemoryAllocationsEnabled) {\n"
        "  FlutterMemoryAllocations.instance.dispatchObjectEvent(\n"
        "    ObjectCreated(\n"
        "      library: 'package:flutter/widgets.dart',\n"
        "      className: 'MyController',\n"
        "      object: this,\n"
        "    ),\n"
        "  );\n"
        "}",
      ),
      SizedBox(height: 12.0),
      _buildRecipeCard(
        'Dispatch on dispose',
        Icons.delete_outline,
        Color(0xFFC62828),
        'In dispose() / close(), pair every ObjectCreated with an '
            'ObjectDisposed referring to the same object instance.',
        "if (kFlutterMemoryAllocationsEnabled) {\n"
        "  FlutterMemoryAllocations.instance.dispatchObjectEvent(\n"
        "    ObjectDisposed(object: this),\n"
        "  );\n"
        "}",
      ),
      SizedBox(height: 12.0),
      _buildRecipeCard(
        'Listening for events',
        Icons.hearing,
        Color(0xFF1565C0),
        'Add a listener that switches on subclass type to track deltas.',
        "FlutterMemoryAllocations.instance.addListener(\n"
        "  (ObjectEvent event) {\n"
        "    if (event is ObjectCreated) {\n"
        "      counter[event.className] = (counter[event.className] ?? 0) + 1;\n"
        "    } else if (event is ObjectDisposed) {\n"
        "      // decrement using your own bookkeeping\n"
        "    }\n"
        "  },\n"
        ");",
      ),
    ],
  );
}

Widget _buildRecipeCard(String title, IconData icon, Color color,
    String description, String code) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.06),
          color.withValues(alpha: 0.16),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          description,
          style: TextStyle(fontSize: 12.5, color: Color(0xFF424242)),
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(code),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7: Pitfalls
// =============================================================================

Widget _buildPitfalls() {
  final List<List<String>> entries = <List<String>>[
    <String>[
      'Forgetting kFlutterMemoryAllocationsEnabled gate',
      'Always wrap dispatch calls in if (kFlutterMemoryAllocationsEnabled) so '
          'they tree-shake out of release builds.',
    ],
    <String>[
      'Mismatched create/dispose pairs',
      'Every ObjectCreated must be matched by exactly one ObjectDisposed for '
          'the same object reference; otherwise the allocation looks leaked.',
    ],
    <String>[
      'Using runtimeType.toString() for className',
      'Prefer hand-written string literals; runtimeType produces synthesized '
          'names for generics and obfuscated names in release.',
    ],
    <String>[
      'Treating ObjectEvent as if it carried className',
      'Only ObjectCreated has library/className. ObjectDisposed only has '
          'object — listeners must remember the class themselves.',
    ],
    <String>[
      'Dispatching from a different isolate',
      'FlutterMemoryAllocations is per-isolate; events dispatched on workers '
          'will not reach the root-isolate listeners.',
    ],
  ];

  return Column(
    children: entries
        .map((List<String> e) => Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
                border: Border(
                  left: BorderSide(color: Color(0xFFEF6C00), width: 5.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x33EF6C00),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.warning_amber,
                      color: Color(0xFFE65100), size: 22.0),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          e[0],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: Color(0xFFBF360C),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          e[1],
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xFF4E342E)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
        .toList(),
  );
}

// =============================================================================
// SECTION 8: Comparison table
// =============================================================================

Widget _buildComparisonTable() {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFB0BEC5), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _tableHeader('Aspect', 130.0, Color(0xFF455A64)),
            _tableHeader('ObjectCreated', 140.0, Color(0xFF2E7D32)),
            _tableHeader('ObjectDisposed', 140.0, Color(0xFFC62828)),
          ],
        ),
        Divider(height: 1.0, color: Color(0xFFB0BEC5)),
        _tableRow('Has object', 'yes', 'yes'),
        _tableRow('Has library', 'yes', 'no'),
        _tableRow('Has className', 'yes', 'no'),
        _tableRow('Lifecycle phase', 'allocation', 'reclamation'),
        _tableRow('Typical caller', 'constructor', 'dispose() / close()'),
        _tableRow('toMap() outer key',
            'package:lib/lib.dart/Class', 'unknown / matched'),
        _tableRow('Pairs with', 'one Disposed later', 'one earlier Created'),
      ],
    ),
  );
}

Widget _tableHeader(String text, double width, Color color) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: color,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _tableRow(String aspect, String created, String disposed) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFFECEFF1), width: 1.0),
      ),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 130.0,
          child: Text(
            aspect,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Color(0xFF263238),
            ),
          ),
        ),
        SizedBox(
          width: 140.0,
          child: Text(
            created,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Color(0xFF2E7D32),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 140.0,
          child: Text(
            disposed,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Color(0xFFC62828),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 9: Debugging workflow
// =============================================================================

Widget _buildDebuggingWorkflow() {
  final List<List<String>> steps = <List<String>>[
    <String>[
      '1',
      'Enable allocation tracking',
      'Make sure kFlutterMemoryAllocationsEnabled is true (debug or profile).',
    ],
    <String>[
      '2',
      'Attach a listener',
      'FlutterMemoryAllocations.instance.addListener(...).',
    ],
    <String>[
      '3',
      'Drive your scenario',
      'Open/close the route or feature you want to inspect repeatedly.',
    ],
    <String>[
      '4',
      'Diff create vs dispose',
      'Track ObjectCreated by class; subtract ObjectDisposed counts; non-zero '
          'deltas hint at leaks.',
    ],
    <String>[
      '5',
      'Cross-check with DevTools',
      'Open the Memory tab — these events feed the same allocation timeline.',
    ],
    <String>[
      '6',
      'Detach listener',
      'Always remove listeners during teardown to avoid retaining state.',
    ],
  ];

  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF00838F), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x3300838F),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps
          .map((List<String> s) => Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF00838F),
                            Color(0xFF26C6DA),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        s[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            s[1],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Color(0xFF006064),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            s[2],
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF263238),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    ),
  );
}

// =============================================================================
// SECTION 10: Mixed event stream
// =============================================================================

Widget _buildMixedStream(List<ObjectEvent> events) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.terminal, color: Color(0xFF80DEEA), size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'event stream (synthetic)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: Color(0xFF80DEEA),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (int i = 0; i < events.length; i++)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 30.0,
                  child: Text(
                    '#${i.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Color(0xFF607D8B),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: events[i] is ObjectCreated
                        ? Color(0xFF1B5E20)
                        : Color(0xFFB71C1C),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    events[i] is ObjectCreated ? 'CREATE' : 'DISPOSE',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _describeEvent(events[i]),
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: Color(0xFFCFD8DC),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

String _describeEvent(ObjectEvent e) {
  if (e is ObjectCreated) {
    return '${e.library} :: ${e.className} (#${e.object.hashCode})';
  }
  if (e is ObjectDisposed) {
    return 'object#${e.object.hashCode} reclaimed';
  }
  return 'unknown ObjectEvent subtype';
}

// =============================================================================
// SECTION 11: Quick reference
// =============================================================================

Widget _buildQuickReference() {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFF6A1B9A), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x336A1B9A),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.flash_on, color: Color(0xFF4A148C), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Quick Reference Cheat Sheet',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF4A148C),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _refLine('•',
            'ObjectEvent — abstract base, only field is `object` (Object).'),
        _refLine('•',
            'ObjectCreated — adds `library` (String) and `className` (String).'),
        _refLine('•',
            'ObjectDisposed — only carries the object reference back out.'),
        _refLine('•',
            'Both subclasses are dispatched via FlutterMemoryAllocations.instance.dispatchObjectEvent.'),
        _refLine('•',
            'kFlutterMemoryAllocationsEnabled gate keeps overhead at zero in release.'),
        _refLine('•',
            'toMap() returns Map<Object, Map<String, Object>> keyed by object.hashCode.'),
        _refLine('•',
            'Listeners receive ObjectEvent and must downcast with `is`.'),
        _refLine('•',
            'Pair every ObjectCreated with exactly one ObjectDisposed for that object.'),
      ],
    ),
  );
}

Widget _refLine(String bullet, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          bullet,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
            fontSize: 14.0,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.5, color: Color(0xFF311B92)),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 12: ASCII footer
// =============================================================================

Widget _buildAsciiFooter() {
  const String ascii =
      "  +------------------------------------------------+\n"
      "  |                  ObjectEvent                   |\n"
      "  |                  (abstract)                    |\n"
      "  +------------------------------------------------+\n"
      "             /                          \\\n"
      "            v                            v\n"
      "  +------------------+        +-----------------------+\n"
      "  |  ObjectCreated   |        |   ObjectDisposed      |\n"
      "  |  library         |        |   object              |\n"
      "  |  className       |        |                       |\n"
      "  |  object          |        |                       |\n"
      "  +------------------+        +-----------------------+\n"
      "                                                       \n"
      "        FlutterMemoryAllocations.instance              \n"
      "                .dispatchObjectEvent(...)              \n";

  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF0D1117), Color(0xFF161B22)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF30363D), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Text(
      ascii,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        height: 1.25,
        color: Color(0xFF7EE787),
      ),
    ),
  );
}
