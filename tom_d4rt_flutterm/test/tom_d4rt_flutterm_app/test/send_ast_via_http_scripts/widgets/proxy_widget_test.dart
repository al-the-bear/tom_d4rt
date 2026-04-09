// ignore_for_file: avoid_print
// D4rt test script: Tests ProxyWidget from widgets library
// Deep Demo: Visual demonstration of the invisible-wrapper paradigm
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ProxyWidget Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ProxyWidget?
  // ============================================================
  print('=== Section 1: ProxyWidget Overview ===');

  // Color palette: Burgundy / Rose
  final burgundy900 = Color(0xFF3B0A1E);
  final burgundy800 = Color(0xFF5C1030);
  final burgundy700 = Color(0xFF7D1842);
  final burgundy600 = Color(0xFF9E2054);
  final burgundy500 = Color(0xFFBF2866);
  final rose400 = Color(0xFFD45A8A);
  final rose300 = Color(0xFFE28BAE);
  final rose200 = Color(0xFFEDB5CB);
  final rose100 = Color(0xFFF5D7E3);
  final rose50 = Color(0xFFFBEDF3);

  final overviewCards = <Widget>[];

  // Hero card
  overviewCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [burgundy900, burgundy600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: burgundy900.withValues(alpha: 0.5),
            blurRadius: 14.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.filter_none_rounded, size: 38.0, color: rose200),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'ProxyWidget',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: rose400.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'abstract class ProxyWidget extends Widget',
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: rose200,
              ),
            ),
          ),
          SizedBox(height: 14.0),
          Text(
            'The "invisible wrapper" — a widget that has exactly one child '
            'and adds behavior without changing the visual tree. ProxyWidget '
            'is the base class for InheritedWidget (data propagation down '
            'the tree) and ParentDataWidget (layout configuration up to '
            'the parent RenderObject). It never renders anything itself.',
            style: TextStyle(
              fontSize: 13.5,
              color: rose100,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Key characteristics
  final characteristics = <Map<String, String>>[
    {
      'label': 'Nature',
      'value': 'Abstract class — never instantiated directly',
    },
    {
      'label': 'Extends',
      'value': 'Widget (the root of all widget classes)',
    },
    {
      'label': 'Fields',
      'value': 'final Widget child — exactly one child widget',
    },
    {
      'label': 'Constructor',
      'value': 'const ProxyWidget({Key? key, required this.child})',
    },
    {
      'label': 'Purpose',
      'value': 'Provide metadata/context without rendering',
    },
  ];

  for (final entry in characteristics) {
    overviewCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: burgundy900.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(color: burgundy700, width: 3.5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90.0,
              child: Text(
                entry['label']!,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: burgundy700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Expanded(
              child: Text(
                entry['value']!,
                style: TextStyle(
                  fontSize: 12.5,
                  color: burgundy800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('  ProxyWidget: abstract, const constructor, single child property');
  print('  Subclasses: InheritedWidget, ParentDataWidget');

  // ============================================================
  // SECTION 2: The Widget Class Hierarchy
  // ============================================================
  print('=== Section 2: Widget Class Hierarchy ===');

  final hierarchyCards = <Widget>[];

  // Section header
  hierarchyCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.account_tree, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Text(
            'Section 2: Widget Class Hierarchy',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  // The four branches
  final branches = <Map<String, dynamic>>[
    {
      'name': 'StatelessWidget',
      'icon': Icons.circle_outlined,
      'color': Color(0xFF2E7D32),
      'desc': 'Immutable — build() returns widget tree, no state',
      'example': 'Icon, Text, Container (conceptually)',
    },
    {
      'name': 'StatefulWidget',
      'icon': Icons.sync_alt,
      'color': Color(0xFF1565C0),
      'desc': 'Mutable — createState() returns State with setState()',
      'example': 'Checkbox, TextField, AnimatedBuilder',
    },
    {
      'name': 'RenderObjectWidget',
      'icon': Icons.brush,
      'color': Color(0xFFE65100),
      'desc': 'Creates RenderObjects that do actual painting/layout',
      'example': 'RichText, Padding, Opacity (via Leaf/Single/Multi)',
    },
    {
      'name': 'ProxyWidget',
      'icon': Icons.filter_none_rounded,
      'color': burgundy600,
      'desc': 'Passes child through — adds context without rendering',
      'example': 'InheritedWidget, ParentDataWidget',
    },
  ];

  // Widget root
  hierarchyCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF37474F), Color(0xFF546E7A)],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              'Widget',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'The root of all widget classes',
              style: TextStyle(fontSize: 11.0, color: Colors.white70),
            ),
            SizedBox(height: 10.0),
            Icon(Icons.arrow_downward, color: Colors.white54, size: 22.0),
          ],
        ),
      ),
    ),
  );

  // Four branches
  for (final branch in branches) {
    final isProxy = branch['name'] == 'ProxyWidget';
    hierarchyCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: isProxy ? burgundy600.withValues(alpha: 0.12) : Colors.grey.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isProxy ? burgundy500 : (branch['color'] as Color).withValues(alpha: 0.3),
            width: isProxy ? 2.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: (branch['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                branch['icon'] as IconData,
                color: branch['color'] as Color,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    branch['name'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: isProxy ? burgundy700 : Color(0xFF37474F),
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    branch['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: isProxy ? burgundy600 : Color(0xFF616161),
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'Examples: ${branch['example']}',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            if (isProxy)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: burgundy500,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'THIS',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  hierarchyCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: rose50,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        'Key insight: StatelessWidget, StatefulWidget, and RenderObjectWidget '
        'all produce visual output. ProxyWidget is the only branch that '
        'adds invisible behavior — data, configuration, or context — '
        'without painting anything itself.',
        style: TextStyle(
          fontSize: 12.0,
          color: burgundy800,
          height: 1.5,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
  );

  print('  Widget has 4 main branches: Stateless, Stateful, RenderObject, Proxy');
  print('  ProxyWidget is the invisible one — no rendering, just context');

  // ============================================================
  // SECTION 3: The `child` Property
  // ============================================================
  print('=== Section 3: The child Property ===');

  final childCards = <Widget>[];

  childCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.child_care, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Text(
            'Section 3: The child Property',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  // Single child constraint visualization
  childCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: rose100.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: rose300, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'final Widget child',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: burgundy700,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'ProxyWidget has exactly one child — it wraps a single widget. '
            'This enforces a clean contract: one wrapper, one wrapped widget. '
            'If you need multiple children, your child should be a Row, Column, '
            'Stack, or other multi-child widget.',
            style: TextStyle(
              fontSize: 12.5,
              color: burgundy800,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Visual: wrapper → child relationship
  childCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [burgundy700, burgundy500],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Icon(Icons.filter_none_rounded, color: rose200, size: 28.0),
                  SizedBox(height: 6.0),
                  Text(
                    'ProxyWidget',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '(invisible)',
                    style: TextStyle(fontSize: 10.0, color: rose300),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.arrow_forward, color: burgundy600, size: 28.0),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: rose50,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: rose300),
              ),
              child: Column(
                children: [
                  Icon(Icons.widgets, color: burgundy600, size: 28.0),
                  SizedBox(height: 6.0),
                  Text(
                    'child',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: burgundy700,
                    ),
                  ),
                  Text(
                    '(any Widget)',
                    style: TextStyle(fontSize: 10.0, color: burgundy600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Multiple children workaround
  childCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: Color(0xFFE65100), width: 3.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: Color(0xFFE65100), size: 20.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Need multiple children? Make child a Column, Row, or Stack. '
              'The ProxyWidget wraps the multi-child widget, which in turn '
              'holds many children. The proxy itself always has exactly one.',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF4E342E),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('  ProxyWidget.child: exactly one child widget (required, final)');
  print('  For multiple children: wrap a Row/Column/Stack as the child');

  // ============================================================
  // SECTION 4: InheritedWidget — Primary Subclass
  // ============================================================
  print('=== Section 4: InheritedWidget — Primary Subclass ===');

  final inheritedCards = <Widget>[];

  inheritedCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_downward, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 4: InheritedWidget — Data Down',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // InheritedWidget concept
  inheritedCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF283593)],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'InheritedWidget extends ProxyWidget',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: Color(0xFFBBDEFB),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'InheritedWidget pushes data DOWN the tree. Any descendant can '
            'call dependOnInheritedWidgetOfExactType<T>() to read the data, '
            'and the framework automatically rebuilds dependents when the '
            'InheritedWidget changes (per updateShouldNotify).',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Visual data flow
  final dataFlowLevels = <Map<String, dynamic>>[
    {
      'label': 'InheritedWidget',
      'sub': 'Holds data (e.g., ThemeData)',
      'icon': Icons.source,
      'depth': 0,
    },
    {
      'label': 'child (Container, Column, etc.)',
      'sub': 'Passes through — does not consume',
      'icon': Icons.arrow_downward,
      'depth': 1,
    },
    {
      'label': 'Grandchild widget',
      'sub': 'Passes through — does not consume',
      'icon': Icons.arrow_downward,
      'depth': 2,
    },
    {
      'label': 'Consumer widget',
      'sub': 'dependOnInheritedWidgetOfExactType<T>()',
      'icon': Icons.download,
      'depth': 3,
    },
  ];

  for (final level in dataFlowLevels) {
    final depth = level['depth'] as int;
    inheritedCards.add(
      Container(
        margin: EdgeInsets.only(
          left: 12.0 + (depth * 20.0),
          right: 12.0,
          top: 3.0,
          bottom: 3.0,
        ),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: depth == 0
              ? Color(0xFF1A237E).withValues(alpha: 0.1)
              : depth == 3
                  ? Color(0xFF2E7D32).withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(
              color: depth == 0
                  ? Color(0xFF1A237E)
                  : depth == 3
                      ? Color(0xFF2E7D32)
                      : Colors.grey.withValues(alpha: 0.3),
              width: 3.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              level['icon'] as IconData,
              size: 18.0,
              color: depth == 0
                  ? Color(0xFF1A237E)
                  : depth == 3
                      ? Color(0xFF2E7D32)
                      : Colors.grey,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level['label'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                  Text(
                    level['sub'] as String,
                    style: TextStyle(fontSize: 10.5, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('  InheritedWidget: primary ProxyWidget subclass');
  print('  Pushes data down the tree — dependents auto-rebuild');

  // ============================================================
  // SECTION 5: ParentDataWidget — The Other Subclass
  // ============================================================
  print('=== Section 5: ParentDataWidget — Layout Config Up ===');

  final parentDataCards = <Widget>[];

  parentDataCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_upward, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 5: ParentDataWidget — Config Up',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // ParentDataWidget concept
  parentDataCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFF57C00)],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ParentDataWidget<T extends ParentData>',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: Color(0xFFFFE0B2),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'ParentDataWidget sends configuration UP to the parent '
            'RenderObject. It wraps a child and calls applyParentData() '
            'to configure how the parent positions/lays out that child. '
            'Positioned (in Stack) and Flexible (in Flex) are the classic examples.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Comparison: InheritedWidget vs ParentDataWidget
  parentDataCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Color(0xFF1A237E).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0xFF1A237E).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.arrow_downward, color: Color(0xFF1A237E), size: 26.0),
                  SizedBox(height: 6.0),
                  Text(
                    'InheritedWidget',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Data flows DOWN\nto descendants',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF37474F)),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Theme, MediaQuery',
                    style: TextStyle(
                      fontSize: 9.5,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Color(0xFFE65100).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0xFFE65100).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.arrow_upward, color: Color(0xFFE65100), size: 26.0),
                  SizedBox(height: 6.0),
                  Text(
                    'ParentDataWidget',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Config flows UP\nto parent layout',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF37474F)),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Positioned, Flexible',
                    style: TextStyle(
                      fontSize: 9.5,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('  ParentDataWidget: sends config UP to parent RenderObject');
  print('  InheritedWidget: sends data DOWN to descendants');
  print('  Both extend ProxyWidget — opposite directions');

  // ============================================================
  // SECTION 6: Custom InheritedWidget Pattern
  // ============================================================
  print('=== Section 6: Custom InheritedWidget Pattern ===');

  final customInheritedCards = <Widget>[];

  customInheritedCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.code, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 6: Custom InheritedWidget',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Implementation pattern steps
  final patternSteps = <Map<String, String>>[
    {
      'step': '1',
      'title': 'Extend InheritedWidget',
      'code': 'class MyData extends InheritedWidget',
      'desc': 'Add your data fields (final) and a const constructor',
    },
    {
      'step': '2',
      'title': 'Implement updateShouldNotify()',
      'code': 'bool updateShouldNotify(MyData old) => data != old.data',
      'desc': 'Return true when the data actually changed — prevents unnecessary rebuilds',
    },
    {
      'step': '3',
      'title': 'Add static of() accessor',
      'code':
          'static MyData of(BuildContext ctx) =>\n'
          '  ctx.dependOnInherited...OfExactType<MyData>()!',
      'desc': 'Registers context as dependent — auto-rebuilds when data changes',
    },
    {
      'step': '4',
      'title': 'Optional: maybeOf() variant',
      'code':
          'static MyData? maybeOf(BuildContext ctx) =>\n'
          '  ctx.dependOnInherited...OfExactType<MyData>()',
      'desc': 'Returns null instead of throwing if widget not found in tree',
    },
  ];

  for (final step in patternSteps) {
    customInheritedCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: rose50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: rose200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: burgundy600,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step['step']!,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title']!,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: burgundy700,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF263238).withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      step['code']!,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                        color: burgundy800,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    step['desc']!,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF616161),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('  Pattern: extend InheritedWidget, add of/maybeOf, updateShouldNotify');

  // ============================================================
  // SECTION 7: Familiar ProxyWidgets in Flutter
  // ============================================================
  print('=== Section 7: Familiar ProxyWidgets ===');

  final familiarCards = <Widget>[];

  familiarCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.star, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 7: Familiar ProxyWidgets',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  final familiarProxies = <Map<String, dynamic>>[
    {
      'name': 'Theme',
      'type': 'InheritedWidget',
      'what': 'Provides ThemeData (colors, typography, shapes) to entire subtree',
      'icon': Icons.palette,
      'color': Color(0xFF6A1B9A),
    },
    {
      'name': 'MediaQuery',
      'type': 'InheritedWidget',
      'what': 'Screen size, orientation, text scale, padding, insets',
      'icon': Icons.devices,
      'color': Color(0xFF00838F),
    },
    {
      'name': 'DefaultTextStyle',
      'type': 'InheritedWidget',
      'what': 'Fallback text style for all Text widgets below',
      'icon': Icons.text_fields,
      'color': Color(0xFF2E7D32),
    },
    {
      'name': 'Directionality',
      'type': 'InheritedWidget',
      'what': 'Text direction (LTR or RTL) for the subtree',
      'icon': Icons.format_textdirection_l_to_r,
      'color': Color(0xFFEF6C00),
    },
    {
      'name': 'Positioned',
      'type': 'ParentDataWidget',
      'what': 'Tells Stack where to place a child (top, left, right, bottom)',
      'icon': Icons.open_with,
      'color': Color(0xFFC62828),
    },
    {
      'name': 'Flexible / Expanded',
      'type': 'ParentDataWidget',
      'what': 'Tells Row/Column how much space a child should take (flex factor)',
      'icon': Icons.swap_horiz,
      'color': Color(0xFF1565C0),
    },
  ];

  for (final proxy in familiarProxies) {
    final isParent = (proxy['type'] as String).contains('Parent');
    familiarCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: (proxy['color'] as Color).withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(
              color: proxy['color'] as Color,
              width: 3.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: (proxy['color'] as Color).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                proxy['icon'] as IconData,
                color: proxy['color'] as Color,
                size: 20.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        proxy['name'] as String,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: proxy['color'] as Color,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: isParent
                              ? Color(0xFFE65100).withValues(alpha: 0.1)
                              : Color(0xFF1A237E).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          proxy['type'] as String,
                          style: TextStyle(
                            fontSize: 9.0,
                            fontWeight: FontWeight.w600,
                            color: isParent ? Color(0xFFE65100) : Color(0xFF1A237E),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    proxy['what'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF616161),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('  Theme, MediaQuery, DefaultTextStyle — InheritedWidget examples');
  print('  Positioned, Flexible — ParentDataWidget examples');

  // ============================================================
  // SECTION 8: updateShouldNotify Gating
  // ============================================================
  print('=== Section 8: updateShouldNotify ===');

  final updateCards = <Widget>[];

  updateCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.compare_arrows, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 8: updateShouldNotify',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Explanation card
  updateCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: rose100.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: rose300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'bool updateShouldNotify(covariant InheritedWidget old)',
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: burgundy700,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Called when the InheritedWidget is rebuilt. If it returns false, '
            'dependents are NOT rebuilt even though the widget itself changed. '
            'This is the performance optimization gate — it prevents cascading '
            'rebuilds when the actual data has not changed.',
            style: TextStyle(
              fontSize: 12.5,
              color: burgundy800,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Flow diagram
  final flowSteps = <Map<String, String>>[
    {'label': 'Parent rebuilds', 'desc': 'Triggers InheritedWidget rebuild'},
    {'label': 'Framework compares', 'desc': 'Calls updateShouldNotify(oldWidget)'},
    {'label': 'Returns true?', 'desc': 'Data changed → rebuild all dependents'},
    {'label': 'Returns false?', 'desc': 'Data same → skip dependent rebuilds'},
  ];

  for (var i = 0; i < flowSteps.length; i++) {
    final step = flowSteps[i];
    final isDecision = i >= 2;
    updateCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isDecision
              ? (i == 2 ? Color(0xFFC62828).withValues(alpha: 0.08) : Color(0xFF2E7D32).withValues(alpha: 0.08))
              : burgundy600.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(
              color: isDecision
                  ? (i == 2 ? Color(0xFFC62828) : Color(0xFF2E7D32))
                  : burgundy500,
              width: 3.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              isDecision ? (i == 2 ? Icons.refresh : Icons.block) : Icons.arrow_downward,
              size: 16.0,
              color: isDecision
                  ? (i == 2 ? Color(0xFFC62828) : Color(0xFF2E7D32))
                  : burgundy500,
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step['label']!,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
                Text(
                  step['desc']!,
                  style: TextStyle(fontSize: 10.5, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  print('  updateShouldNotify: the performance gate for InheritedWidgets');
  print('  Returns false → dependents skip rebuild — keeps UI fast');

  // ============================================================
  // SECTION 9: Positioned & Flexible — ParentDataWidget Examples
  // ============================================================
  print('=== Section 9: Positioned & Flexible ===');

  final posFlexCards = <Widget>[];

  posFlexCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.open_with, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 9: Positioned & Flexible',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Positioned demo in a Stack
  posFlexCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: rose50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: rose200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Positioned in a Stack',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: burgundy700,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 160.0,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10.0,
                  left: 10.0,
                  child: Container(
                    width: 70.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: burgundy700,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(
                        'top:10\nleft:10',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 15.0,
                  right: 15.0,
                  child: Container(
                    width: 70.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: burgundy500,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(
                        'top:15\nright:15',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 40.0,
                  right: 40.0,
                  child: Container(
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: rose400,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(
                        'bottom:10  left:40  right:40',
                        style: TextStyle(fontSize: 9.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Each Positioned is a ParentDataWidget that tells the Stack '
            'exactly where to put its child via applyParentData().',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF616161),
              fontStyle: FontStyle.italic,
              height: 1.3,
            ),
          ),
        ],
      ),
    ),
  );

  // Flexible demo in a Row
  posFlexCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: rose50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: rose200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flexible / Expanded in a Row',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: burgundy700,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: burgundy700,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(
                        'flex: 1',
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: burgundy500,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(
                        'flex: 2',
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: rose400,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(
                        'flex: 3',
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Each Flexible is a ParentDataWidget that tells the Row/Column '
            'what proportion of space (flex factor) this child should receive.',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF616161),
              fontStyle: FontStyle.italic,
              height: 1.3,
            ),
          ),
        ],
      ),
    ),
  );

  print('  Positioned: tells Stack where to place child');
  print('  Flexible: tells Row/Column how much space');

  // ============================================================
  // SECTION 10: ProxyElement Connection
  // ============================================================
  print('=== Section 10: ProxyElement Connection ===');

  final proxyElemCards = <Widget>[];

  proxyElemCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.link, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 10: ProxyElement Connection',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Widget → Element mapping
  final mappings = <Map<String, String>>[
    {
      'widget': 'StatelessWidget',
      'element': 'StatelessElement',
      'method': 'build() → widget tree',
    },
    {
      'widget': 'StatefulWidget',
      'element': 'StatefulElement',
      'method': 'state.build() → widget tree',
    },
    {
      'widget': 'ProxyWidget',
      'element': 'ProxyElement',
      'method': 'build() → widget.child (pass-through!)',
    },
    {
      'widget': '  InheritedWidget',
      'element': '  InheritedElement',
      'method': 'notifyClients → dependency tracking',
    },
    {
      'widget': '  ParentDataWidget',
      'element': '  ParentDataElement',
      'method': 'applyParentData → layout config',
    },
  ];

  for (var i = 0; i < mappings.length; i++) {
    final m = mappings[i];
    final isProxy = i >= 2;
    proxyElemCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isProxy ? burgundy600.withValues(alpha: 0.07) : Colors.grey.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: isProxy
              ? Border.all(color: rose300.withValues(alpha: 0.5))
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                m['widget']!,
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  fontWeight: isProxy ? FontWeight.bold : FontWeight.normal,
                  color: isProxy ? burgundy700 : Color(0xFF37474F),
                ),
              ),
            ),
            Icon(Icons.arrow_forward, size: 14.0, color: Colors.grey),
            Expanded(
              flex: 3,
              child: Text(
                m['element']!,
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: isProxy ? burgundy600 : Color(0xFF616161),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                m['method']!,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Key insight
  proxyElemCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: rose50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: burgundy500, width: 3.5),
        ),
      ),
      child: Text(
        'ProxyElement.build() simply returns widget.child — it does not '
        'create a new widget tree, just passes the child through. This is '
        'why ProxyWidgets are invisible: their element never produces '
        'a new subtree, only wraps existing ones with context.',
        style: TextStyle(
          fontSize: 12.0,
          color: burgundy800,
          height: 1.5,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
  );

  print('  ProxyWidget → ProxyElement (build returns widget.child)');
  print('  InheritedWidget → InheritedElement (dependency tracking)');
  print('  ParentDataWidget → ParentDataElement (applyParentData)');

  // ============================================================
  // SECTION 11: Nested ProxyWidget Stacking
  // ============================================================
  print('=== Section 11: Wrapper Tower Pattern ===');

  final stackingCards = <Widget>[];

  stackingCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.stacked_bar_chart, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 11: The Wrapper Tower',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // The wrapper tower visual — concentric boxes
  final towerLayers = <Map<String, dynamic>>[
    {'name': 'Theme', 'color': Color(0xFF6A1B9A), 'depth': 0},
    {'name': 'MediaQuery', 'color': Color(0xFF00838F), 'depth': 1},
    {'name': 'Directionality', 'color': Color(0xFFEF6C00), 'depth': 2},
    {'name': 'DefaultTextStyle', 'color': Color(0xFF2E7D32), 'depth': 3},
    {'name': 'Your Widget', 'color': burgundy600, 'depth': 4},
  ];

  stackingCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: rose50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: rose200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ProxyWidgets stack around MaterialApp',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: burgundy700,
            ),
          ),
          SizedBox(height: 10.0),
          ...towerLayers.map((layer) {
            final depth = layer['depth'] as int;
            final layerColor = layer['color'] as Color;
            return Container(
              margin: EdgeInsets.only(
                left: depth * 14.0,
                right: depth * 14.0,
                top: 4.0,
                bottom: 4.0,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: layerColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: layerColor.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: layerColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    layer['name'] as String,
                    style: TextStyle(
                      fontSize: depth == 4 ? 12.0 : 11.0,
                      fontWeight: depth == 4 ? FontWeight.bold : FontWeight.w500,
                      color: layerColor,
                    ),
                  ),
                  if (depth < 4) ...[
                    Spacer(),
                    Text(
                      'ProxyWidget',
                      style: TextStyle(
                        fontSize: 9.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                  if (depth == 4) ...[
                    Spacer(),
                    Text(
                      'actual content',
                      style: TextStyle(
                        fontSize: 9.0,
                        fontStyle: FontStyle.italic,
                        color: burgundy600,
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
          SizedBox(height: 8.0),
          Text(
            'This is the "wrapper tower" pattern. MaterialApp wraps your '
            'widget in many ProxyWidgets: Theme, MediaQuery, Directionality, '
            'DefaultTextStyle, and more. Each layer adds data silently — '
            'they are all invisible in the rendered output.',
            style: TextStyle(
              fontSize: 11.5,
              color: Color(0xFF616161),
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

  print('  MaterialApp wraps content in many ProxyWidget layers');
  print('  The wrapper tower is invisible — only data, no rendering');

  // ============================================================
  // SECTION 12: Const Constructors & Widget Caching
  // ============================================================
  print('=== Section 12: Const Constructors ===');

  final constCards = <Widget>[];

  constCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.memory, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 12: Const Constructors',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Why const matters
  constCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: rose100.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: rose300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'const ProxyWidget({Key? key, required this.child})',
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: burgundy700,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'ProxyWidget has a const constructor, and so do both InheritedWidget '
            'and ParentDataWidget. This means that if the data does not change, '
            'the widget can be compile-time constant. The framework uses identical() '
            'to detect const widgets and skip rebuilds entirely — the widget '
            'is not just equal, it is literally the same object in memory.',
            style: TextStyle(
              fontSize: 12.5,
              color: burgundy800,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Const vs non-const comparison
  constCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0xFF2E7D32).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 24.0),
                  SizedBox(height: 6.0),
                  Text(
                    'const MyTheme(\nchild: Text("Hi")\n)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Same identity\nSkip rebuild',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF37474F)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Color(0xFFC62828).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0xFFC62828).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.warning, color: Color(0xFFC62828), size: 24.0),
                  SizedBox(height: 6.0),
                  Text(
                    'MyTheme(\nchild: Text("Hi")\n)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: Color(0xFFC62828),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'New instance\nMust check again',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF37474F)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('  Const ProxyWidgets: compile-time identity → zero-cost rebuilds');
  print('  Non-const: new instance each time → updateShouldNotify called');

  // ============================================================
  // SECTION 13: InheritedModel — Finer-Grained Dependency
  // ============================================================
  print('=== Section 13: InheritedModel ===');

  final modelCards = <Widget>[];

  modelCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.tune, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 13: InheritedModel',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // InheritedModel explanation
  modelCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'InheritedModel<T> extends InheritedWidget',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: Color(0xFFCE93D8),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'InheritedModel adds aspect-based dependency: instead of '
            'rebuilding ALL dependents when any data changes, each dependent '
            'can specify which aspect it depends on. Only dependents of '
            'the changed aspect rebuild. This is a specialized ProxyWidget '
            'for high-performance scenarios.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Comparison: InheritedWidget vs InheritedModel
  modelCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color(0xFF1A237E).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0xFF1A237E).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'InheritedWidget',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'All dependents\nrebuild together',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.5, color: Color(0xFF37474F)),
                  ),
                  SizedBox(height: 4.0),
                  Icon(Icons.group, color: Color(0xFF1A237E), size: 20.0),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color(0xFF4A148C).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0xFF4A148C).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'InheritedModel',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Per-aspect rebuild\n(finer-grained)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.5, color: Color(0xFF37474F)),
                  ),
                  SizedBox(height: 4.0),
                  Icon(Icons.filter_alt, color: Color(0xFF4A148C), size: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('  InheritedModel: aspect-based dependency — finer rebuild control');
  print('  A specialized InheritedWidget (which is a ProxyWidget)');

  // ============================================================
  // SECTION 14: Provider Pattern Built on ProxyWidget
  // ============================================================
  print('=== Section 14: Provider Pattern ===');

  final providerCards = <Widget>[];

  providerCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: burgundy800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.architecture, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Section 14: Provider Pattern',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Provider architecture
  providerCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: rose100.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: rose300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Provider uses InheritedWidget',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: burgundy700,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'The well-known Provider package from pub.dev is built entirely '
            'on top of InheritedWidget (which extends ProxyWidget). Provider '
            'wraps the ceremony of creating an InheritedWidget, implementing '
            'updateShouldNotify, and providing the static of()/watch()/read() '
            'accessors. Under the hood, it is all ProxyWidgets.',
            style: TextStyle(
              fontSize: 12.5,
              color: burgundy800,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Architecture stack
  final providerStack = <Map<String, String>>[
    {'name': 'Provider / Consumer API', 'level': 'Package API'},
    {'name': 'InheritedProvider', 'level': 'Package internals'},
    {'name': 'InheritedWidget', 'level': 'Flutter framework'},
    {'name': 'ProxyWidget', 'level': 'Base class'},
    {'name': 'Widget', 'level': 'Root'},
  ];

  for (var i = 0; i < providerStack.length; i++) {
    final entry = providerStack[i];
    final isProxy = i >= 3;
    providerCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isProxy
              ? burgundy600.withValues(alpha: 0.08)
              : Color(0xFF263238).withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(6.0),
          border: Border(
            left: BorderSide(
              color: isProxy ? burgundy500 : Color(0xFF546E7A),
              width: 3.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entry['name']!,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: isProxy ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'monospace',
                color: isProxy ? burgundy700 : Color(0xFF37474F),
              ),
            ),
            Text(
              entry['level']!,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('  Provider package is built on InheritedWidget → ProxyWidget');
  print('  All state management solutions use ProxyWidget at their core');

  // ============================================================
  // SECTION 15: Integration Summary
  // ============================================================
  print('=== Section 15: Integration Summary ===');

  final summaryCards = <Widget>[];

  summaryCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [burgundy900, burgundy700],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.summarize, size: 24.0, color: rose200),
          SizedBox(width: 10.0),
          Text(
            'Section 15: Integration Summary',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  final summaryPoints = <Map<String, String>>[
    {
      'key': 'Identity',
      'value': 'Abstract class with one field: final Widget child',
    },
    {
      'key': 'Hierarchy',
      'value': 'Widget → ProxyWidget (one of 4 main branches)',
    },
    {
      'key': 'Subclass 1',
      'value': 'InheritedWidget — data DOWN the tree (Theme, MediaQuery)',
    },
    {
      'key': 'Subclass 2',
      'value': 'ParentDataWidget — config UP to parent (Positioned, Flexible)',
    },
    {
      'key': 'Element',
      'value': 'ProxyElement — build() returns widget.child (pass-through)',
    },
    {
      'key': 'Performance',
      'value': 'updateShouldNotify gates rebuilds; const enables identity skip',
    },
    {
      'key': 'Advanced',
      'value': 'InheritedModel adds per-aspect dependency for fine control',
    },
    {
      'key': 'Real World',
      'value': 'Provider, Riverpod, BLoC — all built on ProxyWidget',
    },
    {
      'key': 'Wrapper Tower',
      'value': 'MaterialApp nests many ProxyWidgets around your content',
    },
    {
      'key': 'Key Insight',
      'value': 'The invisible infrastructure that makes Flutter composition possible',
    },
  ];

  for (final point in summaryPoints) {
    summaryCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: burgundy600.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: rose400, width: 3.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80.0,
              child: Text(
                point['key']!,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: burgundy700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                point['value']!,
                style: TextStyle(
                  fontSize: 12.0,
                  color: burgundy800,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Final badge
  summaryCards.add(
    Container(
      margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 20.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [burgundy900, burgundy600],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.filter_none_rounded, color: rose200, size: 30.0),
          SizedBox(width: 12.0),
          Expanded(
            child: Text(
              'ProxyWidget — the invisible wrapper that makes '
              'data propagation, layout configuration, and state '
              'management composition possible in Flutter.',
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('  ProxyWidget: the invisible infrastructure of Flutter');
  print('ProxyWidget Deep Demo complete');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: burgundy700,
      scaffoldBackgroundColor: Color(0xFFFFFBFD),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('ProxyWidget Deep Demo'),
        backgroundColor: burgundy800,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...overviewCards,
            ...hierarchyCards,
            ...childCards,
            ...inheritedCards,
            ...parentDataCards,
            ...customInheritedCards,
            ...familiarCards,
            ...updateCards,
            ...posFlexCards,
            ...proxyElemCards,
            ...stackingCards,
            ...constCards,
            ...modelCards,
            ...providerCards,
            ...summaryCards,
          ],
        ),
      ),
    ),
  );
}
