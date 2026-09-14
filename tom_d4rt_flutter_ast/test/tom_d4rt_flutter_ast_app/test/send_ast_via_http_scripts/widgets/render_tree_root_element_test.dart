// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderTreeRootElement from widgets
// Deep Demo: Visual exploration of the abstract root-element bridge between
// the Element tree and the RenderObject tree.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderTreeRootElement Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept Cards — what is RenderTreeRootElement?
  // ============================================================
  print('=== Section 1: Concept Cards ===');

  final conceptCards = <Widget>[];

  // Concept 1: The bridge
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.alt_route, size: 44.0, color: Colors.indigo),
          SizedBox(height: 10.0),
          Text(
            'A Bridge',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Connects the Element-tree\nto the RenderObject-tree at its root.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: Parentless mount
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.flag_outlined, size: 44.0, color: Colors.teal),
          SizedBox(height: 10.0),
          Text(
            'Parentless Mount',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Mounted with parent == null;\nthere is nothing above it in the tree.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.teal.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 3: PipelineOwner host
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.pink.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.purple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.hub, size: 44.0, color: Colors.purple),
          SizedBox(height: 10.0),
          Text(
            'Hosts PipelineOwner',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Owns the PipelineOwner that\ndrives layout, paint and semantics.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.purple.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 4: Engine attaches here
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.settings_input_antenna, size: 44.0, color: Colors.orange),
          SizedBox(height: 10.0),
          Text(
            'Engine Attach Point',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'The engine attaches its FlutterView\nthrough this element\'s render object.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.5, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );

  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Class Hierarchy Diagram
  // ============================================================
  print('=== Section 2: Class Hierarchy ===');

  Widget buildHierarchyNode({
    required String name,
    required String subtitle,
    required IconData icon,
    required Color color,
    bool abstractClass = false,
  }) {
    return Container(
      width: 360.0,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: color.withValues(alpha: 0.6),
          width: abstractClass ? 2.5 : 1.4,
          style: abstractClass ? BorderStyle.solid : BorderStyle.solid,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22.0),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        color: color,
                      ),
                    ),
                    if (abstractClass) ...[
                      SizedBox(width: 8.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'abstract',
                          style: TextStyle(
                            fontSize: 9.0,
                            fontFamily: 'monospace',
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDownArrow(Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Transform.rotate(
        angle: 1.5707963, // pi/2
        child: Icon(Icons.arrow_forward, color: color, size: 28.0),
      ),
    );
  }

  final hierarchyDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      children: [
        Text(
          'extends',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: Colors.blueGrey.shade600,
          ),
        ),
        buildHierarchyNode(
          name: 'DiagnosticableTree',
          subtitle: 'Diagnostics base for tree-printable objects',
          icon: Icons.account_tree_outlined,
          color: Colors.grey.shade700,
        ),
        buildDownArrow(Colors.grey.shade400),
        buildHierarchyNode(
          name: 'Element',
          subtitle: 'A node in the element tree (BuildContext)',
          icon: Icons.widgets_outlined,
          color: Colors.indigo,
          abstractClass: true,
        ),
        buildDownArrow(Colors.indigo.shade300),
        buildHierarchyNode(
          name: 'RenderObjectElement',
          subtitle: 'Element backed by a RenderObject',
          icon: Icons.dashboard_outlined,
          color: Colors.blue,
          abstractClass: true,
        ),
        buildDownArrow(Colors.blue.shade300),
        buildHierarchyNode(
          name: 'RenderTreeRootElement',
          subtitle: 'Root of an independent render-object subtree',
          icon: Icons.flag,
          color: Colors.deepOrange,
          abstractClass: true,
        ),
        buildDownArrow(Colors.deepOrange.shade300),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green.shade400),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.crop_landscape, color: Colors.green, size: 26.0),
                      SizedBox(height: 4.0),
                      Text(
                        'RawView\n_Element',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Backs the View widget',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.purple.shade400),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.dashboard_customize, color: Colors.purple, size: 26.0),
                      SizedBox(height: 4.0),
                      Text(
                        'RenderObjectTo\nWidgetElement',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade900,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Legacy runApp root',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.purple.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Concrete subclasses live in flutter/src/widgets/.',
          style: TextStyle(
            fontSize: 10.0,
            fontStyle: FontStyle.italic,
            color: Colors.blueGrey.shade700,
          ),
        ),
      ],
    ),
  );
  print('Built hierarchy diagram');

  // ============================================================
  // SECTION 3: Responsibility Table
  // ============================================================
  print('=== Section 3: Responsibility Table ===');

  Widget buildRespRow(
    String responsibility,
    bool normalElement,
    bool rootElement,
    String detail,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  responsibility,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Icon(
                normalElement ? Icons.check_circle : Icons.cancel,
                color: normalElement ? Colors.green : Colors.red.shade300,
                size: 22.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Icon(
                rootElement ? Icons.check_circle : Icons.cancel,
                color: rootElement ? Colors.green : Colors.red.shade300,
                size: 22.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final responsibilityTable = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blueGrey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Responsibility',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Regular',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Root',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        buildRespRow(
          'Has an Element parent',
          true,
          false,
          'Root elements are mounted with parent = null.',
        ),
        buildRespRow(
          'Inserts into parent\'s slot',
          true,
          false,
          'No parent => insertRenderObjectChild is never called from above.',
        ),
        buildRespRow(
          'Owns a PipelineOwner',
          false,
          true,
          'Root attaches its render object to a (possibly dedicated) PipelineOwner.',
        ),
        buildRespRow(
          'Backed by RenderObject',
          true,
          true,
          'Both extend RenderObjectElement; both have a renderObject.',
        ),
        buildRespRow(
          'Attached by the engine',
          false,
          true,
          'The engine drives root attachment through the binding.',
        ),
        buildRespRow(
          'Drives layout / paint pipeline',
          false,
          true,
          'Schedules flushLayout/flushPaint via its PipelineOwner.',
        ),
        buildRespRow(
          'Participates in inheritance chain',
          true,
          true,
          'Still a normal BuildContext below, ancestors propagate downward.',
        ),
        buildRespRow(
          'Has Element above it in tree',
          true,
          false,
          'There is no Element above a RenderTreeRootElement.',
        ),
      ],
    ),
  );
  print('Built responsibility table');

  // ============================================================
  // SECTION 4: Lifecycle Timeline
  // ============================================================
  print('=== Section 4: Lifecycle Timeline ===');

  Widget buildLifecycleStep({
    required int number,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 8.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 3.0,
                height: 56.0,
                color: color.withValues(alpha: 0.4),
              ),
          ],
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: isLast ? 0 : 14.0),
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 22.0),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontFamily: 'monospace',
                          fontSize: 13.5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  final lifecycleTimeline = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      children: [
        buildLifecycleStep(
          number: 1,
          title: 'createElement()',
          description:
              'A root widget (e.g. View, RenderObjectToWidgetAdapter) creates '
              'its element. The element starts in the "initial" lifecycle state.',
          icon: Icons.create_new_folder_outlined,
          color: Colors.blue,
          isLast: false,
        ),
        buildLifecycleStep(
          number: 2,
          title: 'mount(parent: null, slot: null)',
          description:
              'The binding mounts the element with no parent. '
              'RenderTreeRootElement overrides mount to skip parent-slot insertion '
              'because there is nothing above it.',
          icon: Icons.anchor,
          color: Colors.green,
          isLast: false,
        ),
        buildLifecycleStep(
          number: 3,
          title: 'attachRenderObject(slot: null)',
          description:
              'The render object is attached to a PipelineOwner instead of being '
              'inserted into a parent render object. This is the bridge handoff.',
          icon: Icons.link,
          color: Colors.deepOrange,
          isLast: false,
        ),
        buildLifecycleStep(
          number: 4,
          title: 'Engine attaches FlutterView',
          description:
              'The engine binds a FlutterView to the root render object via the '
              'binding. Frames can now flow: build => layout => paint.',
          icon: Icons.cable,
          color: Colors.purple,
          isLast: false,
        ),
        buildLifecycleStep(
          number: 5,
          title: 'active',
          description:
              'The root element is live. Its subtree builds normally; the '
              'PipelineOwner schedules flushLayout / flushPaint each frame.',
          icon: Icons.play_circle_fill,
          color: Colors.teal,
          isLast: false,
        ),
        buildLifecycleStep(
          number: 6,
          title: 'deactivate() => unmount()',
          description:
              'On shutdown or view detach, the root deactivates, detaches the '
              'render object from its PipelineOwner, then unmounts cleanly.',
          icon: Icons.power_settings_new,
          color: Colors.red,
          isLast: true,
        ),
      ],
    ),
  );
  print('Built lifecycle timeline');

  // ============================================================
  // SECTION 5: Adapter <-> Element 2-column diagram
  // ============================================================
  print('=== Section 5: Adapter <-> Element ===');

  Widget buildAdapterCard({
    required String title,
    required String subtitle,
    required List<String> bullets,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22.0),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: color,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          ...bullets.map(
            (b) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle,
                    size: 6.0,
                    color: color.withValues(alpha: 0.7),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      b,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey.shade800,
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

  Widget buildHorizontalArrow(Color color, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 4.0),
        Icon(Icons.swap_horiz, color: color, size: 28.0),
      ],
    );
  }

  final adapterDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      children: [
        Text(
          'Widget side  ⟷  Element side',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildAdapterCard(
                title: 'RenderObjectToWidgetAdapter',
                subtitle: 'A RenderObjectWidget',
                bullets: [
                  'Declares the configuration.',
                  'Holds the desired child widget.',
                  'Provides createElement() factory.',
                  'Provides createRenderObject() for the root container.',
                  'Immutable — replaced when configuration changes.',
                ],
                icon: Icons.extension,
                color: Colors.cyan.shade700,
              ),
            ),
            SizedBox(width: 8.0),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: buildHorizontalArrow(
                Colors.deepOrange,
                'creates / mounts',
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: buildAdapterCard(
                title: 'RenderObjectToWidgetElement',
                subtitle: 'A RenderTreeRootElement',
                bullets: [
                  'Mutable — lives across frames.',
                  'Holds the actual RenderObject.',
                  'Mounted with parent = null.',
                  'Attaches the root render object to a PipelineOwner.',
                  'Drives layout/paint via the binding.',
                ],
                icon: Icons.dashboard,
                color: Colors.purple.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.blueGrey.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blueGrey, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'In legacy runApp(), the framework wraps the user widget in a '
                  'RenderObjectToWidgetAdapter and attaches it to the binding\'s '
                  'rootPipelineOwner.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Built adapter <-> element diagram');

  // ============================================================
  // SECTION 6: View widget integration (Flutter 3.10+ multi-view)
  // ============================================================
  print('=== Section 6: View widget integration ===');

  Widget buildViewBox({
    required String title,
    required String tag,
    required IconData icon,
    required Color color,
    required String descr,
  }) {
    return Container(
      width: 220.0,
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              tag,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 9.0,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Icon(icon, color: color, size: 32.0),
          SizedBox(height: 6.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: color,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            descr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget buildVerticalArrow(Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Transform.rotate(
        angle: 1.5707963,
        child: Icon(Icons.arrow_forward, color: color, size: 30.0),
      ),
    );
  }

  final viewIntegration = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.devices, color: Colors.green.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Multi-view (Flutter 3.10+)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Engine layer
        buildViewBox(
          title: 'FlutterView',
          tag: 'engine',
          icon: Icons.monitor,
          color: Colors.grey.shade700,
          descr: 'The physical view provided by the engine (window or surface).',
        ),
        buildVerticalArrow(Colors.grey.shade500),
        // View widget
        buildViewBox(
          title: 'View(view: ...)',
          tag: 'Widget',
          icon: Icons.flip_to_front,
          color: Colors.blue.shade700,
          descr:
              'Declarative wrapper that binds a FlutterView to a subtree.',
        ),
        buildVerticalArrow(Colors.blue.shade400),
        // RawView (internal)
        buildViewBox(
          title: '_RawView',
          tag: 'Widget(internal)',
          icon: Icons.layers_outlined,
          color: Colors.indigo,
          descr:
              'Internal RenderObjectWidget that owns the view-bound root subtree.',
        ),
        buildVerticalArrow(Colors.indigo.shade300),
        // RenderTreeRootElement
        buildViewBox(
          title: 'RenderTreeRootElement',
          tag: 'Element(abstract)',
          icon: Icons.flag,
          color: Colors.deepOrange,
          descr:
              'Concrete subclass mounted with parent = null; bridges into the render tree.',
        ),
        buildVerticalArrow(Colors.deepOrange.shade300),
        // RenderView
        buildViewBox(
          title: 'RenderView',
          tag: 'RenderObject',
          icon: Icons.view_in_ar,
          color: Colors.purple.shade700,
          descr:
              'Root render object: composites layers and reports to the engine.',
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Colors.green.shade700, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'With multi-view, each View widget creates its own '
                  'RenderTreeRootElement and PipelineOwner subtree, so multiple '
                  'independent render trees can coexist in one app.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.green.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Built View integration diagram');

  // ============================================================
  // SECTION 7: Code snippet panels — abstract API & overrides
  // ============================================================
  print('=== Section 7: Code snippet panels ===');

  Widget buildCodePanel({
    required String heading,
    required String code,
    required Color accent,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: accent, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                heading,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.green.shade200,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final codePanels = Column(
    children: [
      buildCodePanel(
        heading: '// Abstract class declaration',
        accent: Colors.cyan.shade300,
        code:
            'abstract class RenderTreeRootElement\n'
            '    extends RenderObjectElement {\n'
            '  RenderTreeRootElement(super.widget);\n'
            '\n'
            '  // Marker: this is the root of an independent render tree.\n'
            '  // Subclasses must NOT have an Element parent.\n'
            '}',
      ),
      buildCodePanel(
        heading: '// mount() — no parent slot insertion',
        accent: Colors.orange.shade300,
        code:
            '@override\n'
            'void mount(Element? parent, Object? newSlot) {\n'
            '  // RenderTreeRootElement is always mounted with parent == null.\n'
            '  assert(parent == null);\n'
            '  assert(newSlot == null);\n'
            '  super.mount(parent, newSlot);\n'
            '  // No insertRenderObjectChild upward — there is no parent.\n'
            '}',
      ),
      buildCodePanel(
        heading: '// attachRenderObject() — bind to PipelineOwner',
        accent: Colors.purple.shade300,
        code:
            '@override\n'
            'void attachRenderObject(Object? newSlot) {\n'
            '  assert(newSlot == null);\n'
            '  // No parent render object => no insertion to perform.\n'
            '  // The PipelineOwner is established by the binding/host.\n'
            '  _renderObject.attach(pipelineOwner);\n'
            '}',
      ),
      buildCodePanel(
        heading: '// detachRenderObject() / unmount()',
        accent: Colors.red.shade300,
        code:
            '@override\n'
            'void detachRenderObject() {\n'
            '  // Detach root from PipelineOwner; no parent slot to clear.\n'
            '  _renderObject.detach();\n'
            '  super.detachRenderObject();\n'
            '}\n'
            '\n'
            '@override\n'
            'void unmount() {\n'
            '  // Final cleanup before the element is discarded.\n'
            '  super.unmount();\n'
            '}',
      ),
      buildCodePanel(
        heading: '// Subclass example: a hypothetical RootElement',
        accent: Colors.lightGreen.shade300,
        code:
            'class MyRootElement extends RenderTreeRootElement {\n'
            '  MyRootElement(MyRootWidget super.widget, this.pipelineOwner);\n'
            '\n'
            '  @override\n'
            '  final PipelineOwner pipelineOwner;\n'
            '\n'
            '  @override\n'
            '  void insertRenderObjectChild(RenderObject child, Object? slot) {\n'
            '    // Place the single child under the root render object.\n'
            '    (renderObject as RenderProxyBox).child = child as RenderBox;\n'
            '  }\n'
            '}',
      ),
    ],
  );
  print('Built code panels');

  // ============================================================
  // SECTION 8: Summary takeaways
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade100, Colors.amber.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade900,
          ),
        ),
        SizedBox(height: 14.0),
        _buildSummaryItem(
          Icons.alt_route,
          'Tree-world bridge',
          'Joins Element-tree and RenderObject-tree at a single root point.',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.flag_outlined,
          'Mounted parentless',
          'Always mounted with parent == null and slot == null.',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.hub,
          'Owns a PipelineOwner',
          'Drives flushLayout / flushPaint / flushSemantics for its subtree.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.settings_input_antenna,
          'Engine attach point',
          'The engine binds a FlutterView via this element\'s render object.',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.dashboard_customize,
          'Multiple concrete subclasses',
          'RawView, RenderObjectToWidgetElement, and custom roots all extend it.',
          Colors.deepOrange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.devices,
          'Multi-view ready',
          'Each View widget owns its own RenderTreeRootElement subtree.',
          Colors.green,
        ),
      ],
    ),
  );
  print('Built summary panel');

  print('RenderTreeRootElement Deep Demo completed successfully');

  // ============================================================
  // Final return — single SingleChildScrollView
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
              colors: [Colors.deepOrange, Colors.amber],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrange.withValues(alpha: 0.3),
                blurRadius: 12.0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.flag, size: 60.0, color: Colors.white),
              SizedBox(height: 10.0),
              Text(
                'RenderTreeRootElement',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'The abstract root of every render tree',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'package:flutter/src/widgets/framework.dart',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.white,
                  ),
                ),
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
        SizedBox(height: 8.0),
        Text(
          'What RenderTreeRootElement is, and why the framework needs it.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 32.0),

        // Section 2
        Text(
          '2. Class Hierarchy',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'Where the abstract class sits in the framework class chain.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        hierarchyDiagram,
        SizedBox(height: 24.0),

        // Section 3
        Text(
          '3. Responsibility Table',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'How root elements differ from ordinary RenderObjectElements.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        responsibilityTable,
        SizedBox(height: 24.0),

        // Section 4
        Text(
          '4. Lifecycle Timeline',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'From createElement() through mount, attach, active, to unmount.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        lifecycleTimeline,
        SizedBox(height: 32.0),

        // Section 5
        Text(
          '5. Adapter \u2194 Element',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'RenderObjectToWidgetAdapter (Widget) creates / mounts '
          'RenderObjectToWidgetElement (RenderTreeRootElement).',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        adapterDiagram,
        SizedBox(height: 24.0),

        // Section 6
        Text(
          '6. View Widget Integration',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'How the modern View widget plugs a FlutterView into the framework.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        viewIntegration,
        SizedBox(height: 24.0),

        // Section 7
        Text(
          '7. Abstract API & Overrides',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'Code snippets illustrating what subclasses override.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8.0),
        codePanels,
        SizedBox(height: 24.0),

        // Section 8
        Text(
          '8. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'Key takeaways you can rely on when reading framework source.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        summaryPanel,
        SizedBox(height: 24.0),
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
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.22),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
