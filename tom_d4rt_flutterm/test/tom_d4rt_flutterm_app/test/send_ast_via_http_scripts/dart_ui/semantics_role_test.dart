// D4rt test script: Comprehensive visual demonstration of SemanticsRole from dart_ui
// This enum describes semantic roles for accessibility, helping assistive technologies
// understand the purpose and structure of UI elements.
import 'dart:ui';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS - Must be declared before build() for D4rt compatibility
// ═══════════════════════════════════════════════════════════════════════════════

/// Builds the main header section explaining SemanticsRole
Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.accessibility,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SemanticsRole',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'dart:ui enum • 29 values',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Describes the semantic role of UI elements, helping screen readers '
            'and other assistive technologies understand the purpose and structure '
            'of widgets. Roles range from basic UI elements to complex layouts.',
            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

/// Builds a category section with multiple role items
Widget _buildRoleCategory(
  String title,
  String description,
  IconData icon,
  Color color,
  List<Widget> children,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            border: Border(
              bottom: BorderSide(color: color.withValues(alpha: 0.2)),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Role items
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(spacing: 8, runSpacing: 8, children: children),
        ),
      ],
    ),
  );
}

/// Builds a chip for a single role value
Widget _buildRoleChip(SemanticsRole role, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          role.name,
          style: TextStyle(
            color: color,
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

/// Builds the tabs & dialogs category
Widget _buildTabsDialogsCategory() {
  return _buildRoleCategory(
    'Tabs & Dialogs',
    'Navigation tabs and modal dialogs',
    Icons.tab,
    Colors.blue,
    [
      _buildRoleChip(SemanticsRole.tab, Colors.blue, Icons.tab),
      _buildRoleChip(SemanticsRole.tabBar, Colors.blue, Icons.tab_unselected),
      _buildRoleChip(SemanticsRole.tabPanel, Colors.blue, Icons.view_carousel),
      _buildRoleChip(SemanticsRole.dialog, Colors.blue, Icons.message),
      _buildRoleChip(SemanticsRole.alertDialog, Colors.blue, Icons.warning),
    ],
  );
}

/// Builds the tables category
Widget _buildTablesCategory() {
  return _buildRoleCategory(
    'Tables',
    'Structured data in rows and columns',
    Icons.table_chart,
    Colors.teal,
    [
      _buildRoleChip(SemanticsRole.table, Colors.teal, Icons.table_chart),
      _buildRoleChip(SemanticsRole.row, Colors.teal, Icons.table_rows),
      _buildRoleChip(SemanticsRole.cell, Colors.teal, Icons.crop_square),
      _buildRoleChip(
        SemanticsRole.columnHeader,
        Colors.teal,
        Icons.view_column,
      ),
    ],
  );
}

/// Builds the menus category
Widget _buildMenusCategory() {
  return _buildRoleCategory(
    'Menus',
    'Dropdown menus and menu items',
    Icons.menu,
    Colors.purple,
    [
      _buildRoleChip(SemanticsRole.menuBar, Colors.purple, Icons.menu),
      _buildRoleChip(SemanticsRole.menu, Colors.purple, Icons.list),
      _buildRoleChip(
        SemanticsRole.menuItem,
        Colors.purple,
        Icons.chevron_right,
      ),
      _buildRoleChip(
        SemanticsRole.menuItemCheckbox,
        Colors.purple,
        Icons.check_box,
      ),
      _buildRoleChip(
        SemanticsRole.menuItemRadio,
        Colors.purple,
        Icons.radio_button_checked,
      ),
      _buildRoleChip(
        SemanticsRole.comboBox,
        Colors.purple,
        Icons.arrow_drop_down_circle,
      ),
    ],
  );
}

/// Builds the lists category
Widget _buildListsCategory() {
  return _buildRoleCategory(
    'Lists',
    'Vertical and horizontal item lists',
    Icons.format_list_bulleted,
    Colors.orange,
    [
      _buildRoleChip(SemanticsRole.list, Colors.orange, Icons.view_list),
      _buildRoleChip(
        SemanticsRole.listItem,
        Colors.orange,
        Icons.fiber_manual_record,
      ),
    ],
  );
}

/// Builds the controls category
Widget _buildControlsCategory() {
  return _buildRoleCategory(
    'Controls',
    'Interactive UI controls',
    Icons.touch_app,
    Colors.green,
    [
      _buildRoleChip(SemanticsRole.dragHandle, Colors.green, Icons.drag_handle),
      _buildRoleChip(SemanticsRole.spinButton, Colors.green, Icons.replay),
      _buildRoleChip(
        SemanticsRole.radioGroup,
        Colors.green,
        Icons.radio_button_checked,
      ),
      _buildRoleChip(SemanticsRole.hotKey, Colors.green, Icons.keyboard),
      _buildRoleChip(SemanticsRole.form, Colors.green, Icons.description),
    ],
  );
}

/// Builds the feedback category
Widget _buildFeedbackCategory() {
  return _buildRoleCategory(
    'Feedback & Status',
    'Progress indicators and alerts',
    Icons.notifications,
    Colors.red,
    [
      _buildRoleChip(SemanticsRole.loadingSpinner, Colors.red, Icons.refresh),
      _buildRoleChip(SemanticsRole.progressBar, Colors.red, Icons.linear_scale),
      _buildRoleChip(SemanticsRole.tooltip, Colors.red, Icons.help_outline),
      _buildRoleChip(SemanticsRole.status, Colors.red, Icons.info_outline),
      _buildRoleChip(SemanticsRole.alert, Colors.red, Icons.error_outline),
    ],
  );
}

/// Builds the landmarks category
Widget _buildLandmarksCategory() {
  return _buildRoleCategory(
    'Landmarks',
    'Page regions for navigation',
    Icons.map,
    Colors.indigo,
    [
      _buildRoleChip(SemanticsRole.main, Colors.indigo, Icons.home),
      _buildRoleChip(SemanticsRole.navigation, Colors.indigo, Icons.navigation),
      _buildRoleChip(SemanticsRole.contentInfo, Colors.indigo, Icons.info),
      _buildRoleChip(
        SemanticsRole.complementary,
        Colors.indigo,
        Icons.view_sidebar,
      ),
      _buildRoleChip(SemanticsRole.region, Colors.indigo, Icons.crop_free),
    ],
  );
}

/// Builds the special category for none
Widget _buildSpecialCategory() {
  return _buildRoleCategory(
    'Special',
    'No specific semantic role',
    Icons.block,
    Colors.grey,
    [_buildRoleChip(SemanticsRole.none, Colors.grey, Icons.block)],
  );
}

/// Builds visual demonstration of role relationships
Widget _buildRoleRelationships() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.cyan.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Role Hierarchies',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Tab hierarchy
        _buildHierarchyItem('Tab System', [
          'tabBar → tab (contains)',
          'tabBar → tabPanel (displays)',
        ], Colors.blue),
        const SizedBox(height: 12),
        // Table hierarchy
        _buildHierarchyItem('Table System', [
          'table → row → cell',
          'table → row → columnHeader',
        ], Colors.teal),
        const SizedBox(height: 12),
        // Menu hierarchy
        _buildHierarchyItem('Menu System', [
          'menuBar → menu → menuItem',
          'menu → menuItemCheckbox',
          'menu → menuItemRadio',
        ], Colors.purple),
        const SizedBox(height: 12),
        // List hierarchy
        _buildHierarchyItem('List System', [
          'list → listItem (contains)',
        ], Colors.orange),
      ],
    ),
  );
}

/// Builds a hierarchy item row
Widget _buildHierarchyItem(
  String title,
  List<String> relationships,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        ...relationships.map(
          (r) => Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Row(
              children: [
                Icon(
                  Icons.subdirectory_arrow_right,
                  size: 14,
                  color: color.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 6),
                Text(
                  r,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                    fontFamily: 'monospace',
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

/// Builds landmark visual layout
Widget _buildLandmarkLayout() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dashboard, color: Colors.indigo.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Page Landmark Layout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Navigation
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(7),
                  ),
                ),
                child: Center(
                  child: Text(
                    'navigation',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Body
              Expanded(
                child: Row(
                  children: [
                    // Complementary (sidebar)
                    Container(
                      width: 80,
                      color: Colors.purple.shade50,
                      child: Center(
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'complementary',
                            style: TextStyle(
                              color: Colors.purple.shade700,
                              fontFamily: 'monospace',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Main
                    Expanded(
                      child: Container(
                        color: Colors.green.shade50,
                        child: Center(
                          child: Text(
                            'main',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontFamily: 'monospace',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Region
                    Container(
                      width: 60,
                      color: Colors.orange.shade50,
                      child: Center(
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            'region',
                            style: TextStyle(
                              color: Colors.orange.shade700,
                              fontFamily: 'monospace',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content Info (footer)
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(7),
                  ),
                ),
                child: Center(
                  child: Text(
                    'contentInfo',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
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

/// Builds accessibility benefits section
Widget _buildAccessibilityBenefits() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.accessibility_new,
              color: Colors.amber.shade700,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Why Semantic Roles Matter',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          'Screen Reader Navigation',
          'Users can jump between landmarks (main, navigation) for faster navigation',
          Icons.navigation,
        ),
        const SizedBox(height: 10),
        _buildBenefitItem(
          'Structure Understanding',
          'Assistive tech explains "Table with 5 rows" or "Menu with 3 items"',
          Icons.account_tree,
        ),
        const SizedBox(height: 10),
        _buildBenefitItem(
          'Context Awareness',
          'Alerts and dialogs are announced with appropriate urgency',
          Icons.notifications_active,
        ),
        const SizedBox(height: 10),
        _buildBenefitItem(
          'Keyboard Navigation',
          'Proper roles enable expected keyboard shortcuts (arrows in menus)',
          Icons.keyboard,
        ),
      ],
    ),
  );
}

/// Builds a benefit item row
Widget _buildBenefitItem(String title, String description, IconData icon) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: Colors.amber.shade700, size: 18),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
                fontSize: 13,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.amber.shade700,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

/// Builds API documentation section
Widget _buildApiSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.blueGrey.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'API Reference',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildApiRow('Library', 'dart:ui'),
        _buildApiRow('Type', 'enum'),
        _buildApiRow('Value Count', '29 values'),
        _buildApiRow('Properties', '.name, .index'),
        _buildApiRow('Static', 'SemanticsRole.values (List)'),
      ],
    ),
  );
}

/// Builds an API documentation row
Widget _buildApiRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.blueGrey.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.blueGrey.shade800,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds a summary section showing all values
Widget _buildAllValuesSummary() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list, color: Colors.deepPurple.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'All 29 Values',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: SemanticsRole.values.map((role) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),
              child: Text(
                role.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.deepPurple.shade700,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== SemanticsRole Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUMERATE ALL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final values = SemanticsRole.values;
  print('Total values: ${values.length}');

  for (final v in values) {
    print('SemanticsRole.${v.name}: index=${v.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: CATEGORIES OF VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  // Tabs & Dialogs
  print('--- Tabs & Dialogs ---');
  print('tab: ${SemanticsRole.tab}');
  print('tabBar: ${SemanticsRole.tabBar}');
  print('tabPanel: ${SemanticsRole.tabPanel}');
  print('dialog: ${SemanticsRole.dialog}');
  print('alertDialog: ${SemanticsRole.alertDialog}');

  // Tables
  print('--- Tables ---');
  print('table: ${SemanticsRole.table}');
  print('row: ${SemanticsRole.row}');
  print('cell: ${SemanticsRole.cell}');
  print('columnHeader: ${SemanticsRole.columnHeader}');

  // Menus
  print('--- Menus ---');
  print('menuBar: ${SemanticsRole.menuBar}');
  print('menu: ${SemanticsRole.menu}');
  print('menuItem: ${SemanticsRole.menuItem}');
  print('menuItemCheckbox: ${SemanticsRole.menuItemCheckbox}');
  print('menuItemRadio: ${SemanticsRole.menuItemRadio}');
  print('comboBox: ${SemanticsRole.comboBox}');

  // Lists
  print('--- Lists ---');
  print('list: ${SemanticsRole.list}');
  print('listItem: ${SemanticsRole.listItem}');

  // Controls
  print('--- Controls ---');
  print('dragHandle: ${SemanticsRole.dragHandle}');
  print('spinButton: ${SemanticsRole.spinButton}');
  print('radioGroup: ${SemanticsRole.radioGroup}');
  print('hotKey: ${SemanticsRole.hotKey}');
  print('form: ${SemanticsRole.form}');

  // Feedback
  print('--- Feedback ---');
  print('loadingSpinner: ${SemanticsRole.loadingSpinner}');
  print('progressBar: ${SemanticsRole.progressBar}');
  print('tooltip: ${SemanticsRole.tooltip}');
  print('status: ${SemanticsRole.status}');
  print('alert: ${SemanticsRole.alert}');

  // Landmarks
  print('--- Landmarks ---');
  print('main: ${SemanticsRole.main}');
  print('navigation: ${SemanticsRole.navigation}');
  print('contentInfo: ${SemanticsRole.contentInfo}');
  print('complementary: ${SemanticsRole.complementary}');
  print('region: ${SemanticsRole.region}');

  // Special
  print('--- Special ---');
  print('none: ${SemanticsRole.none}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: COMPARISONS
  // ═══════════════════════════════════════════════════════════════════════════

  final tab = SemanticsRole.tab;
  print('tab == tab: ${tab == SemanticsRole.tab}');
  print('tab == dialog: ${tab == SemanticsRole.dialog}');
  print('tab.hashCode: ${tab.hashCode}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: INDEX-BASED ACCESS
  // ═══════════════════════════════════════════════════════════════════════════

  print('First: ${values.first}');
  print('Last: ${values.last}');

  print('=== SemanticsRole Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Roboto'),
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('SemanticsRole'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),

            const Text(
              'Role Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildTabsDialogsCategory(),
            _buildTablesCategory(),
            _buildMenusCategory(),
            _buildListsCategory(),
            _buildControlsCategory(),
            _buildFeedbackCategory(),
            _buildLandmarksCategory(),
            _buildSpecialCategory(),

            const SizedBox(height: 8),
            _buildRoleRelationships(),
            const SizedBox(height: 16),

            _buildLandmarkLayout(),
            const SizedBox(height: 16),

            _buildAccessibilityBenefits(),
            const SizedBox(height: 16),

            _buildAllValuesSummary(),
            const SizedBox(height: 16),

            _buildApiSection(),
            const SizedBox(height: 20),

            // Summary footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.accessibility,
                    color: Colors.deepPurple.shade700,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SemanticsRole provides 29 values to describe the purpose '
                    'of UI elements, enabling assistive technologies to help '
                    'users navigate and understand your app\'s structure.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepPurple.shade700,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
