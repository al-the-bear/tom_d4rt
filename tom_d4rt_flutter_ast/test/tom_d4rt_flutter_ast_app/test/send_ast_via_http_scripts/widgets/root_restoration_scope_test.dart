// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RootRestorationScope
// Demonstrates RootRestorationScope — the top-level widget that
// establishes the root of a restoration hierarchy. It enables state
// restoration after the OS kills and relaunches the app, preserving
// user interactions like scroll positions, text fields, and navigation.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RootRestorationScope Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is State Restoration?
  // ============================================================
  print('=== Section 1: Concept ===');

  // When Android or iOS kills a backgrounded app to reclaim
  // resources, the user expects their state to be preserved.
  // State restoration works through a hierarchy:
  //
  //   RootRestorationScope (provides restorationId)
  //   └── RestorationScope (child scope with own id)
  //       └── RestorableProperty values (scroll pos, text, etc.)
  //
  // RootRestorationScope is the topmost node. Without it,
  // child RestorationScope widgets have no root to save to.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF1565C0), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.restore, size: 36.0, color: Color(0xFF1565C0)),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'RootRestorationScope',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'The top-level widget that establishes the root of a '
          'state restoration hierarchy. When the OS kills and '
          'relaunches your app, all descendant RestorableProperty '
          'values are automatically saved and restored.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFF1565C0)),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What gets restored:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(height: 8.0),
              _buildRestoreBullet(
                'Scroll positions (ListView, GridView)',
                Color(0xFF1565C0),
              ),
              _buildRestoreBullet(
                'Text field contents',
                Color(0xFF2E7D32),
              ),
              _buildRestoreBullet(
                'Selected tabs and navigation state',
                Color(0xFFE65100),
              ),
              _buildRestoreBullet(
                'Toggle states (switches, checkboxes)',
                Color(0xFF6A1B9A),
              ),
              _buildRestoreBullet(
                'Any custom RestorableProperty',
                Color(0xFF37474F),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Restoration Hierarchy
  // ============================================================
  print('=== Section 2: Restoration hierarchy ===');

  Widget buildHierNode(
    String label,
    String id,
    Color color,
    int indent,
    IconData icon,
    List<String> properties,
  ) {
    return Container(
      margin: EdgeInsets.only(
        left: indent * 20.0,
        top: 3.0,
        bottom: 3.0,
        right: 8.0,
      ),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'id: "$id"',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9.0,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          if (properties.isNotEmpty) ...[
            SizedBox(height: 6.0),
            ...properties.map(
              (p) => Padding(
                padding: EdgeInsets.only(left: 26.0, top: 2.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.data_object,
                      size: 12.0,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      p,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  final hierarchySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Restoration Hierarchy',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each scope stores its own restoration data keyed by restorationId.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        buildHierNode(
          'RootRestorationScope',
          'root',
          Color(0xFF1565C0),
          0,
          Icons.account_tree,
          [],
        ),
        buildHierNode(
          'MaterialApp (RestorationScope)',
          'app',
          Color(0xFF2E7D32),
          1,
          Icons.apps,
          ['Navigator state'],
        ),
        buildHierNode(
          'HomePage (RestorationMixin)',
          'home',
          Color(0xFFE65100),
          2,
          Icons.home,
          ['RestorableInt _counter', 'RestorableString _name'],
        ),
        buildHierNode(
          'TabBar (RestorationScope)',
          'tabs',
          Color(0xFF6A1B9A),
          3,
          Icons.tab,
          ['RestorableInt _tabIndex'],
        ),
        buildHierNode(
          'ListView (RestorationScope)',
          'list',
          Color(0xFF37474F),
          3,
          Icons.list,
          ['RestorableDouble _scrollOffset'],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: App Lifecycle & Restoration
  // ============================================================
  print('=== Section 3: App lifecycle ===');

  Widget buildLifecyclePhase(
    String phase,
    String detail,
    IconData icon,
    Color color,
    bool isDestructive,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isDestructive
            ? color.withValues(alpha: 0.15)
            : color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: color.withValues(alpha: isDestructive ? 0.8 : 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18.0),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phase,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final lifecycleSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Color(0xFFF57C00), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'App Lifecycle & Restoration',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        buildLifecyclePhase(
          '1. App Running',
          'User interacts normally. RestorableProperty values track state.',
          Icons.play_arrow,
          Color(0xFF2E7D32),
          false,
        ),
        buildLifecyclePhase(
          '2. App Backgrounded',
          'User switches to another app. Framework serialises restoration data.',
          Icons.pause,
          Color(0xFF1565C0),
          false,
        ),
        buildLifecyclePhase(
          '3. OS Kills App',
          'System needs memory. App process is terminated. Restoration data persists.',
          Icons.dangerous,
          Color(0xFFC62828),
          true,
        ),
        buildLifecyclePhase(
          '4. User Returns',
          'App relaunches from scratch. RootRestorationScope provides saved data.',
          Icons.restart_alt,
          Color(0xFFF57C00),
          false,
        ),
        buildLifecyclePhase(
          '5. State Restored',
          'All RestorableProperty values are populated from the saved bucket.',
          Icons.check_circle,
          Color(0xFF2E7D32),
          false,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Restorable Properties Overview
  // ============================================================
  print('=== Section 4: Restorable properties ===');

  Widget buildPropertyRow(
    String type,
    String example,
    Color color,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18.0),
          SizedBox(width: 10.0),
          SizedBox(
            width: 140.0,
            child: Text(
              type,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              example,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final propertiesSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF6A1B9A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.data_object,
                color: Color(0xFF6A1B9A), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Built-in Restorable Properties',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        buildPropertyRow(
          'RestorableInt',
          'Counter values, tab indices',
          Color(0xFF1565C0),
          Icons.tag,
        ),
        buildPropertyRow(
          'RestorableDouble',
          'Scroll positions, slider values',
          Color(0xFF2E7D32),
          Icons.straighten,
        ),
        buildPropertyRow(
          'RestorableBool',
          'Toggle states, feature flags',
          Color(0xFFE65100),
          Icons.toggle_on,
        ),
        buildPropertyRow(
          'RestorableString',
          'Text input, search queries',
          Color(0xFF6A1B9A),
          Icons.text_fields,
        ),
        buildPropertyRow(
          'RestorableNum',
          'Generic numeric values',
          Color(0xFF37474F),
          Icons.numbers,
        ),
        buildPropertyRow(
          'RestorableDateTime',
          'Selected dates, timers',
          Color(0xFFC62828),
          Icons.calendar_today,
        ),
        buildPropertyRow(
          'RestorableTextEdititing',
          'Full TextEditingController state',
          Color(0xFF00695C),
          Icons.edit,
        ),
        buildPropertyRow(
          'RestorableEnum<T>',
          'Typed enum selections',
          Color(0xFF4E342E),
          Icons.list_alt,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: With vs Without Restoration
  // ============================================================
  print('=== Section 5: With vs without restoration ===');

  Widget buildComparisonPanel(
    String title,
    bool hasRestoration,
    List<Map<String, String>> steps,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    hasRestoration
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: color,
                    size: 18.0,
                  ),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: steps.map((step) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['icon'] ?? '•',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            step['text'] ?? '',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'With vs Without Restoration',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'What happens when the OS kills your backgrounded app.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildComparisonPanel(
              'Without Restoration',
              false,
              [
                {'icon': '1.', 'text': 'User fills in form'},
                {'icon': '2.', 'text': 'Switches to camera app'},
                {'icon': '3.', 'text': 'OS kills your app'},
                {'icon': '4.', 'text': 'User returns'},
                {'icon': '❌', 'text': 'Form is empty!'},
                {'icon': '❌', 'text': 'Scroll pos reset to top'},
                {'icon': '❌', 'text': 'Tab set to first tab'},
              ],
              Color(0xFFC62828),
            ),
            buildComparisonPanel(
              'With RootRestorationScope',
              true,
              [
                {'icon': '1.', 'text': 'User fills in form'},
                {'icon': '2.', 'text': 'Switches to camera app'},
                {'icon': '3.', 'text': 'OS kills your app'},
                {'icon': '4.', 'text': 'User returns'},
                {'icon': '✅', 'text': 'Form data restored'},
                {'icon': '✅', 'text': 'Scroll pos maintained'},
                {'icon': '✅', 'text': 'Same tab selected'},
              ],
              Color(0xFF2E7D32),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Code Example
  // ============================================================
  print('=== Section 6: Code example ===');

  final codeExampleSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Color(0xFF37474F), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Code Example',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // App-level setup
        Container(
          padding: EdgeInsets.all(4.0),
          margin: EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFF1565C0).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            '  Step 1: Wrap your app',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: Color(0xFF1565C0),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.only(bottom: 14.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'void main() {\n'
            '  runApp(\n'
            '    RootRestorationScope(\n'
            '      restorationId: \'root\',\n'
            '      child: MyApp(),\n'
            '    ),\n'
            '  );\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
        // Widget-level usage
        Container(
          padding: EdgeInsets.all(4.0),
          margin: EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFF2E7D32).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            '  Step 2: Use RestorationMixin in State',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: Color(0xFF2E7D32),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'class _MyPageState extends State<MyPage>\n'
            '    with RestorationMixin {\n'
            '\n'
            '  final _counter = RestorableInt(0);\n'
            '  final _name = RestorableString(\'\');\n'
            '\n'
            '  @override\n'
            '  String? get restorationId => \'my_page\';\n'
            '\n'
            '  @override\n'
            '  void restoreState(\n'
            '    RestorationBucket? old, bool initial,\n'
            '  ) {\n'
            '    registerForRestoration(\n'
            '      _counter, \'counter\',\n'
            '    );\n'
            '    registerForRestoration(\n'
            '      _name, \'name\',\n'
            '    );\n'
            '  }\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: RestorationScope vs RootRestorationScope
  // ============================================================
  print('=== Section 7: Scope comparison ===');

  Widget buildCompareRow(
    String feature,
    String rootScope,
    String childScope,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100.0,
            child: Text(
              feature,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4.0),
              margin: EdgeInsets.only(right: 4.0),
              decoration: BoxDecoration(
                color: Color(0xFF1565C0).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                rootScope,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Color(0xFF1565C0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                childScope,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 100.0),
              Expanded(
                child: Center(
                  child: Text(
                    'RootRestorationScope',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'RestorationScope',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              buildCompareRow(
                'Position',
                'Top of widget tree',
                'Any level below root',
              ),
              buildCompareRow(
                'Parent bucket',
                'Created by framework',
                'Inherits from parent scope',
              ),
              buildCompareRow(
                'Persistence',
                'Platform-managed save',
                'Delegates to root bucket',
              ),
              buildCompareRow(
                'Typical usage',
                'One per app, in main()',
                'Per-page or per-feature',
              ),
              buildCompareRow(
                'restorationId',
                'Required; identifies app',
                'Required; unique within parent',
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: When Not to Use
  // ============================================================
  print('=== Section 8: When not needed ===');

  Widget buildDoDonotCard(
    String title,
    IconData icon,
    Color color,
    List<String> items,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 18.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            ...items.map(
              (item) => Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 4.0),
                      width: 5.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey.shade700,
                        ),
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
  }

  final doDonotSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'When to Use Restoration',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDoDonotCard(
              'Use Restoration',
              Icons.check_circle,
              Color(0xFF2E7D32),
              [
                'Form data the user typed',
                'Scroll positions in lists',
                'Selected tab index',
                'Toggle / switch states',
                'Dialog or sheet open state',
              ],
            ),
            buildDoDonotCard(
              'Don\'t Restore',
              Icons.cancel,
              Color(0xFFC62828),
              [
                'Auth tokens — use secure storage',
                'API responses — refetch on restart',
                'Animations — replay from start',
                'Ephemeral UI effects',
                'Large data — use a database',
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Summary
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF1565C0), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFF1565C0), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRestoreSummaryItem(
          Icons.restore,
          'Root of restoration tree',
          'Provides the top-level RestorationBucket for the entire app',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 8.0),
        _buildRestoreSummaryItem(
          Icons.save,
          'Automatic persistence',
          'Framework serialises / deserialises restoration data via platform',
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 8.0),
        _buildRestoreSummaryItem(
          Icons.account_tree,
          'Hierarchical scoping',
          'Child RestorationScopes nest under root with unique ids',
          Color(0xFFE65100),
        ),
        SizedBox(height: 8.0),
        _buildRestoreSummaryItem(
          Icons.data_object,
          'RestorableProperty types',
          'Int, Double, Bool, String, DateTime, Enum, TextEditing',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 8.0),
        _buildRestoreSummaryItem(
          Icons.phone_android,
          'OS kill recovery',
          'Seamlessly restores user state after system-initiated kills',
          Color(0xFF37474F),
        ),
      ],
    ),
  );

  print('RootRestorationScope Deep Demo complete');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D47A1),
                Color(0xFF1565C0),
                Color(0xFF1976D2),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.restore, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'RootRestorationScope',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'State restoration after OS kills your app',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        conceptCard,

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2. Restoration Hierarchy',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        hierarchySection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. App Lifecycle',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        lifecycleSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Restorable Properties',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        propertiesSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. With vs Without',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        comparisonSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Code Example',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        codeExampleSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. Root vs Child Scope',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        comparisonTable,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. When to Use',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        doDonotSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '9. Summary',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        summaryPanel,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ================================================================
// Helpers
// ================================================================
Widget _buildRestoreBullet(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: color),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRestoreSummaryItem(
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
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
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
