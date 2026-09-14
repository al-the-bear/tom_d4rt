// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderObjectToWidgetElement behavior
// Deep Demo: Visual demonstration of RenderObjectToWidgetElement and RenderObjectToWidgetAdapter
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderObjectToWidgetElement Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept Cards
  // ============================================================
  print('=== Section 1: What is RenderObjectToWidgetElement ===');

  final conceptCards = <Widget>[];

  // Card 1: RenderObjectToWidgetElement
  conceptCards.add(
    Container(
      width: 260.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree, size: 36.0, color: Colors.indigo),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'RenderObjectToWidgetElement',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'The single root element that owns the\nentire widget-tree branch attached to a\npre-existing RenderObject.',
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.indigo.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'extends RootRenderObjectElement',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.indigo.shade900,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Card 2: RenderObjectToWidgetAdapter
  conceptCards.add(
    Container(
      width: 260.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade100],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.swap_horiz, size: 36.0, color: Colors.orange),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'RenderObjectToWidgetAdapter',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'The widget that wraps the root\nRenderObject, allowing the framework\nto present it as a Widget to runApp.',
            style: TextStyle(fontSize: 12.0, color: Colors.orange.shade800),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.orange.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'extends RenderObjectWidget',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.orange.shade900,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Card 3: bridges the two worlds
  conceptCards.add(
    Container(
      width: 260.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.teal.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.merge_type, size: 36.0, color: Colors.teal),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The Bridge',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Together they let an external\nRenderObject (the screen) become\nthe root of a widget tree built by\nyou.',
            style: TextStyle(fontSize: 12.0, color: Colors.teal.shade800),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.teal.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'runApp uses both internally',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.teal.shade900,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Widget Tree -> Element Tree -> RenderObject Tree
  // ============================================================
  print('=== Section 2: Three-Tree Architecture Diagram ===');

  Widget treeNode(String label, String sub, Color color, IconData icon) {
    return Container(
      width: 130.0,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18.0),
          SizedBox(height: 4.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            sub,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget downArrow(Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Container(width: 2.0, height: 14.0, color: color),
          Icon(Icons.arrow_drop_down, color: color, size: 24.0),
        ],
      ),
    );
  }

  Widget rightArrow(Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 14.0, height: 2.0, color: color),
          Icon(Icons.arrow_right, color: color, size: 28.0),
        ],
      ),
    );
  }

  final widgetColumn = Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade700,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'Widget Tree',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
      SizedBox(height: 10.0),
      treeNode(
        'RenderObject\nToWidgetAdapter',
        '(root widget)',
        Colors.blue,
        Icons.crop_din,
      ),
      downArrow(Colors.blue.shade300),
      treeNode('MaterialApp', '(StatefulWidget)', Colors.blue, Icons.apps),
      downArrow(Colors.blue.shade300),
      treeNode('Scaffold', '(StatelessWidget)', Colors.blue, Icons.web_asset),
      downArrow(Colors.blue.shade300),
      treeNode('Text', '(LeafWidget)', Colors.blue, Icons.text_fields),
    ],
  );

  final elementColumn = Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.purple.shade700,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'Element Tree',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
      SizedBox(height: 10.0),
      treeNode(
        'RenderObject\nToWidgetElement',
        '(root element)',
        Colors.purple,
        Icons.account_tree,
      ),
      downArrow(Colors.purple.shade300),
      treeNode(
        'StatefulElement',
        '(holds State)',
        Colors.purple,
        Icons.toggle_on,
      ),
      downArrow(Colors.purple.shade300),
      treeNode(
        'StatelessElement',
        '(rebuilds on demand)',
        Colors.purple,
        Icons.refresh,
      ),
      downArrow(Colors.purple.shade300),
      treeNode(
        'LeafRenderObject\nElement',
        '(no children)',
        Colors.purple,
        Icons.circle,
      ),
    ],
  );

  final renderColumn = Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.green.shade700,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'RenderObject Tree',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
      SizedBox(height: 10.0),
      treeNode('RenderView', '(provided externally)', Colors.green, Icons.tv),
      downArrow(Colors.green.shade300),
      treeNode(
        'RenderObject',
        '(layout + paint)',
        Colors.green,
        Icons.crop_square,
      ),
      downArrow(Colors.green.shade300),
      treeNode('RenderBox', '(2D box)', Colors.green, Icons.square_foot),
      downArrow(Colors.green.shade300),
      treeNode(
        'RenderParagraph',
        '(text leaf)',
        Colors.green,
        Icons.format_align_left,
      ),
    ],
  );

  Widget treeArrowSection(String title, Color color) {
    return SizedBox(
      width: 90.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30.0),
          rightArrow(color),
          SizedBox(height: 4.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final threeTreeDiagram = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        widgetColumn,
        treeArrowSection('createElement()', Colors.blueGrey),
        elementColumn,
        treeArrowSection('createRenderObject()', Colors.blueGrey),
        renderColumn,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Mount Lifecycle Timeline
  // ============================================================
  print('=== Section 3: Mount Lifecycle Timeline ===');

  final lifecycleSteps = [
    {
      'step': 'build()',
      'desc':
          'Framework requests the widget configuration from the parent. This is the first phase.',
      'icon': Icons.build,
      'color': Colors.blue,
      'code': 'Widget build(BuildContext context) => ...',
    },
    {
      'step': 'createElement()',
      'desc':
          'Widget.createElement() is called. For RenderObjectToWidgetAdapter, it returns a RenderObjectToWidgetElement.',
      'icon': Icons.add_box,
      'color': Colors.teal,
      'code':
          'RenderObjectToWidgetElement<T> createElement() =>\n  RenderObjectToWidgetElement<T>(this);',
    },
    {
      'step': 'mount()',
      'desc':
          'Element is inserted into the tree. The RenderObjectToWidgetElement is mounted with a null parent because it is the root.',
      'icon': Icons.input,
      'color': Colors.purple,
      'code': 'element.mount(null, null);  // root: no parent slot',
    },
    {
      'step': 'attachToRenderTree()',
      'desc':
          'A unique step for RenderObjectToWidgetElement that wires the element to the pre-existing RenderObject root.',
      'icon': Icons.link,
      'color': Colors.indigo,
      'code':
          'void attachToRenderTree(\n  BuildOwner owner, [\n  RenderObjectToWidgetElement<T>? element]\n)',
    },
    {
      'step': 'activate()',
      'desc':
          'Element is in the active state and is part of the live tree. Hooks fire on descendant State objects.',
      'icon': Icons.power,
      'color': Colors.green,
      'code':
          'void activate() {\n  super.activate();\n  // marks element as active\n}',
    },
    {
      'step': 'deactivate()',
      'desc':
          'Element is removed from the active tree but not yet unmounted. Used during reparenting via GlobalKey.',
      'icon': Icons.power_off,
      'color': Colors.orange,
      'code': 'void deactivate() {\n  super.deactivate();\n}',
    },
    {
      'step': 'unmount()',
      'desc':
          'Final teardown. RenderObjectToWidgetElement detaches from its RenderObject and is permanently disposed.',
      'icon': Icons.delete_sweep,
      'color': Colors.red,
      'code':
          'void unmount() {\n  renderObject.dispose();\n  super.unmount();\n}',
    },
  ];

  final timelineWidgets = <Widget>[];
  for (int i = 0; i < lifecycleSteps.length; i++) {
    final step = lifecycleSteps[i];
    final color = step['color'] as Color;
    final isLast = i == lifecycleSteps.length - 1;

    timelineWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: Colors.white,
                  size: 22.0,
                ),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 90.0,
                  color: color.withValues(alpha: 0.5),
                ),
            ],
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 14.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'STEP ${i + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        step['step'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      step['code'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.0,
                        color: Colors.lightGreenAccent.shade100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  print('Created ${timelineWidgets.length} lifecycle steps');

  // ============================================================
  // SECTION 4: Role of RenderObjectToWidgetAdapter in runApp
  // ============================================================
  print('=== Section 4: Role inside runApp ===');

  Widget runAppNode(
    String title,
    String description,
    Color color,
    IconData icon,
  ) {
    return Container(
      width: 220.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32.0),
          SizedBox(height: 6.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 13.0,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }

  Widget verticalArrowLabeled(String label, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        children: [
          Container(width: 2.0, height: 18.0, color: color),
          Icon(Icons.arrow_drop_down, color: color, size: 28.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final runAppFlow = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.cyan.shade300),
    ),
    child: Column(
      children: [
        runAppNode(
          'User calls runApp(MyApp())',
          'Entry point of every Flutter application',
          Colors.blue,
          Icons.play_circle_fill,
        ),
        verticalArrowLabeled('runApp(widget)', Colors.blueGrey),
        runAppNode(
          'WidgetsFlutterBinding\n.ensureInitialized()',
          'Binding picks up the platform RenderView',
          Colors.indigo,
          Icons.settings_input_component,
        ),
        verticalArrowLabeled('attachRootWidget()', Colors.blueGrey),
        runAppNode(
          'Wraps MyApp() in\nRenderObjectToWidgetAdapter',
          'The adapter widget receives the user widget as its child',
          Colors.orange,
          Icons.swap_horiz,
        ),
        verticalArrowLabeled('attachToRenderTree()', Colors.blueGrey),
        runAppNode(
          'Creates\nRenderObjectToWidgetElement',
          'Root element bridges the widget tree to the RenderView',
          Colors.purple,
          Icons.account_tree,
        ),
        verticalArrowLabeled('mount(null, null)', Colors.blueGrey),
        runAppNode(
          'Root element mounted',
          'Owns the user widget tree and the existing RenderView',
          Colors.green,
          Icons.check_circle,
        ),
        verticalArrowLabeled('scheduleFrame()', Colors.blueGrey),
        runAppNode(
          'Engine renders first frame',
          'Layout, paint, composite via the live RenderObject tree',
          Colors.teal,
          Icons.movie_creation,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Child-Element Ownership Diagram
  // ============================================================
  print('=== Section 5: Child-Element Ownership ===');

  Widget ownershipBox(
    String title,
    String detail,
    Color color, {
    bool isRoot = false,
  }) {
    return Container(
      width: 200.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.18), color.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: color,
          width: isRoot ? 3.0 : 1.5,
        ),
        boxShadow: isRoot
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 12.0,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          if (isRoot)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'ROOT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isRoot) SizedBox(height: 6.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: color,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey.shade700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget ownsArrow(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          SizedBox(height: 4.0),
          Transform.rotate(
            angle: 0.0,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.deepPurple,
              size: 28.0,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final ownershipRow1 = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ownershipBox(
        'RenderObjectToWidgetElement',
        'depth: 1\nparent: null',
        Colors.deepPurple,
        isRoot: true,
      ),
      ownsArrow('owns child'),
      ownershipBox(
        'Child Element',
        '(user widget root)\ndepth: 2',
        Colors.blue,
      ),
    ],
  );

  Widget ownershipDownArrow(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        children: [
          Container(width: 2.0, height: 14.0, color: Colors.deepPurple),
          Icon(Icons.arrow_downward, color: Colors.deepPurple, size: 22.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final ownershipDiagram = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Parent / Child Ownership',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        ownershipRow1,
        ownershipDownArrow('inflateWidget()'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ownershipBox(
              'Grandchild Element',
              'depth: 3\n(StatefulElement)',
              Colors.teal,
            ),
            ownsArrow('owns child'),
            ownershipBox(
              'Leaf Element',
              'depth: 4\n(RenderObjectElement)',
              Colors.green,
            ),
          ],
        ),
        ownershipDownArrow('createRenderObject()'),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.amber.shade400, width: 2.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info, color: Colors.amber.shade800, size: 20.0),
                  SizedBox(width: 8.0),
                  Text(
                    'Parent Data Flow',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Text(
                'The root element does NOT have parent data because it has no parent.\n'
                'Children of the root inherit slots from the root element. Parent data\n'
                'is set during the layout walk, not during element mounting.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.amber.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Code Panel - What runApp does under the hood
  // ============================================================
  print('=== Section 6: Code Panel ===');

  Widget codeBlock(String title, String code, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.25),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.code, color: accent, size: 16.0),
                SizedBox(width: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.lightGreenAccent.shade100,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final codePanel = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.lightBlueAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Under the hood of runApp',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        codeBlock(
          'runApp() entry point',
          '// flutter/lib/src/widgets/binding.dart\n'
              'void runApp(Widget app) {\n'
              '  final WidgetsBinding binding =\n'
              '    WidgetsFlutterBinding.ensureInitialized();\n'
              '  binding\n'
              '    ..scheduleAttachRootWidget(app)\n'
              '    ..scheduleWarmUpFrame();\n'
              '}',
          Colors.cyanAccent,
        ),
        codeBlock(
          'attachRootWidget',
          'void attachRootWidget(Widget rootWidget) {\n'
              '  _readyToProduceFrames = true;\n'
              '  _rootElement = RenderObjectToWidgetAdapter<RenderBox>(\n'
              '    container: renderView,\n'
              '    debugShortDescription: "[root]",\n'
              '    child: rootWidget,\n'
              '  ).attachToRenderTree(buildOwner!, _rootElement);\n'
              '}',
          Colors.orangeAccent,
        ),
        codeBlock(
          'RenderObjectToWidgetAdapter',
          'class RenderObjectToWidgetAdapter<T extends RenderObject>\n'
              '    extends RenderObjectWidget {\n'
              '  final RenderObjectWithChildMixin<T> container;\n'
              '  final Widget? child;\n'
              '\n'
              '  @override\n'
              '  RenderObjectToWidgetElement<T> createElement() =>\n'
              '    RenderObjectToWidgetElement<T>(this);\n'
              '\n'
              '  @override\n'
              '  RenderObjectWithChildMixin<T> createRenderObject(\n'
              '    BuildContext context) => container;\n'
              '}',
          Colors.purpleAccent,
        ),
        codeBlock(
          'RenderObjectToWidgetElement.attachToRenderTree',
          'RenderObjectToWidgetElement<T> attachToRenderTree(\n'
              '  BuildOwner owner, [\n'
              '  RenderObjectToWidgetElement<T>? element]) {\n'
              '  if (element == null) {\n'
              '    owner.lockState(() {\n'
              '      element = createElement();\n'
              '      element!.assignOwner(owner);\n'
              '    });\n'
              '    owner.buildScope(element!, () {\n'
              '      element!.mount(null, null);\n'
              '    });\n'
              '  } else {\n'
              '    element._newWidget = this;\n'
              '    element.markNeedsBuild();\n'
              '  }\n'
              '  return element!;\n'
              '}',
          Colors.greenAccent,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Summary Panel
  // ============================================================
  print('=== Section 7: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(8.0),
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
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.account_tree,
          'Tree Root',
          'RenderObjectToWidgetElement is the single root of every Flutter app element tree',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.swap_horiz,
          'Adapter Pattern',
          'RenderObjectToWidgetAdapter wraps the platform RenderView so it becomes a Widget',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.link,
          'Bridge Behaviour',
          'attachToRenderTree() wires the element to the pre-existing RenderObject root',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.loop,
          'Lifecycle',
          'createElement -> mount -> activate -> deactivate -> unmount, just like every Element',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.code,
          'Internal Only',
          'You never instantiate it directly; runApp() does it for you',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.layers,
          'Parent Data',
          'Root element has no parent data because no parent exists',
          Colors.teal,
        ),
      ],
    ),
  );

  print('RenderObjectToWidgetElement Deep Demo completed successfully');

  // ============================================================
  // Final Return: Single Scroll Container
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
              colors: [Colors.indigo, Colors.deepPurple, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 12.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.account_tree, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'RenderObjectToWidgetElement',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'The bridge between Widget land and RenderObject land',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 28.0),

        // Section 1
        Text(
          '1. Concept Cards',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0),
        Text(
          'The two classes that form the bridge.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 32.0),

        // Section 2
        Text(
          '2. Three-Tree Architecture',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0),
        Text(
          'Every Flutter app maintains three parallel trees. The root of each tree '
          'is owned by the RenderObjectToWidget pair.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        threeTreeDiagram,
        SizedBox(height: 32.0),

        // Section 3
        Text(
          '3. Mount Lifecycle Timeline',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0),
        Text(
          'From the call to runApp() until the element is finally unmounted.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: timelineWidgets),
        ),
        SizedBox(height: 32.0),

        // Section 4
        Text(
          '4. Role inside runApp',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0),
        Text(
          'Step-by-step flow that runApp executes to bootstrap a Flutter app.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        runAppFlow,
        SizedBox(height: 32.0),

        // Section 5
        Text(
          '5. Child-Element Ownership',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0),
        Text(
          'How the root element owns the rest of the element tree.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        ownershipDiagram,
        SizedBox(height: 32.0),

        // Section 6
        Text(
          '6. Under-the-hood Code',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0),
        Text(
          'The actual Flutter framework code (paraphrased) that wires it all up.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        codePanel,
        SizedBox(height: 32.0),

        // Section 7
        Text(
          '7. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        summaryPanel,
        SizedBox(height: 24.0),

        // Footer
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, color: Colors.grey.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Text(
                'End of RenderObjectToWidgetElement deep demo',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
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
          child: Icon(icon, color: color, size: 22.0),
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
              SizedBox(height: 2.0),
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
