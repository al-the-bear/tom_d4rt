// Deep visual test for RootElement
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

/// Deep visual exploration of RootElement
/// The concrete element at the very top of the element tree.
/// Created when you call runApp(), it extends Element with RootElementMixin.
///
/// RootElement:
/// - Has exactly one child (the app's root widget tree)
/// - Parent is always null (the root of everything)
/// - Receives BuildOwner via assignOwner() from WidgetsBinding
/// - Lives for the entire duration of the app process
/// - Coordinates the entire build/rebuild pipeline
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A120E),
    ),
    home: _RootElementDemo(),
  );
}

// =============================================================================
// PALETTE: Brown 500 / Cyan A200
// =============================================================================
const Color _kPrimary = Color(0xFF795548); // Brown 500
const Color _kAccent = Color(0xFF18FFFF); // Cyan A200
const Color _kSurface = Color(0xFF211810);
const Color _kCardBg = Color(0xFF2E2018);
const Color _kTextPrimary = Color(0xFFEFEBE9);
const Color _kTextSecondary = Color(0xFFA1887F);
const Color _kDivider = Color(0xFF4E3B2F);
const Color _kRoot = Color(0xFFFF7043); // DeepOrange 400
const Color _kChild = Color(0xFF66BB6A); // Green 400
const Color _kBinding = Color(0xFF42A5F5); // Blue 400
const Color _kWidget = Color(0xFFAB47BC); // Purple 400
const Color _kBuild = Color(0xFFFFCA28); // Amber 400
const Color _kRender = Color(0xFFEC407A); // Pink 400

// =============================================================================
// MAIN DEMO
// =============================================================================
class _RootElementDemo extends StatefulWidget {
  @override
  State<_RootElementDemo> createState() => _RootElementDemoState();
}

class _RootElementDemoState extends State<_RootElementDemo>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RootElement Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.architecture), text: 'Architecture'),
            Tab(icon: Icon(Icons.account_tree), text: 'Tree Explorer'),
            Tab(icon: Icon(Icons.construction), text: 'Build Pipeline'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ArchitectureTab(),
          _TreeExplorerTab(),
          _BuildPipelineTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: ARCHITECTURE
// =============================================================================
class _ArchitectureTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderCard(),
          SizedBox(height: 20),
          _buildSingleChildModel(),
          SizedBox(height: 20),
          _buildClassHierarchy(),
          SizedBox(height: 20),
          _buildAPIContract(),
          SizedBox(height: 20),
          _buildRootWidgetConnection(),
          SizedBox(height: 20),
          _buildComparisonSection(),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary.withOpacity(0.35), _kAccent.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kPrimary.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: _kRoot.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.location_on, color: _kRoot, size: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RootElement',
                      style: TextStyle(
                        color: _kTextPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        _badge('CONCRETE', _kChild),
                        SizedBox(width: 6),
                        _badge('SINGLETON per app', _kRoot),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'The single element at depth 0 of every Flutter element tree. '
            'Created when you call runApp(), it is the anchor point that '
            'connects the widget tree to the WidgetsBinding and BuildOwner. '
            'Every other element in your app is a descendant of this one.',
            style: TextStyle(color: _kTextSecondary, fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _kRoot.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'class RootElement extends Element with RootElementMixin',
              style: TextStyle(color: _kBinding, fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      margin: EdgeInsets.only(top: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSingleChildModel() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Single-Child Model'),
          SizedBox(height: 12),
          Text(
            'RootElement holds exactly one child element — the element for '
            'the widget you pass to runApp(). The _child field is the entire '
            'rest of your application.',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 16),
          // Diagram
          Center(
            child: Column(
              children: [
                _boxBlock('RootElement', _kRoot, 200),
                Container(width: 2, height: 12, color: _kDivider),
                _boxBlock('_child (Element?)', _kChild, 200),
                Container(width: 2, height: 12, color: _kDivider),
                _boxBlock('Your entire app tree', _kWidget, 200),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Accessor methods
          _methodRow('visitChildren(visitor)', 'Calls visitor(_child) if _child is not null', _kChild),
          _methodRow('forgetChild(child)', 'Sets _child = null; used during tree mutations', _kRoot),
          _methodRow('inflateWidget(child, slot)', 'Creates _child from the widget configured in RootWidget', _kBinding),
        ],
      ),
    );
  }

  Widget _boxBlock(String label, Color color, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _methodRow(String method, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.functions, color: color, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(method, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassHierarchy() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Class Hierarchy'),
          SizedBox(height: 16),
          _hierarchyNode(0, 'DiagnosticableTree', _kTextSecondary, 'Debug output'),
          _connector(),
          _hierarchyNode(1, 'Element', _kTextSecondary, 'Core element lifecycle'),
          _connector(),
          _hierarchyNode(2, 'RootElement', _kRoot, '+ RootElementMixin → single child root'),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From Element:',
                  style: TextStyle(color: _kAccent, fontSize: 11, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '• lifecycle (mount, update, unmount, deactivate)\n'
                  '• owner access, dependency tracking\n'
                  '• widget reference, dirty marking',
                  style: TextStyle(color: _kTextPrimary, fontSize: 10, height: 1.4),
                ),
                SizedBox(height: 8),
                Text(
                  'From RootElementMixin:',
                  style: TextStyle(color: _kAccent, fontSize: 11, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '• assignOwner(BuildOwner)\n'
                  '• mount(null, null) assertion\n'
                  '• _parentBuildScope creation',
                  style: TextStyle(color: _kTextPrimary, fontSize: 10, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hierarchyNode(int depth, String name, Color color, String desc) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11)),
                  Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _connector() {
    return Padding(
      padding: EdgeInsets.only(left: 24),
      child: Container(width: 2, height: 12, color: _kDivider),
    );
  }

  Widget _buildAPIContract() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('RootElement API'),
          SizedBox(height: 16),
          _apiCard('mount(null, null)', 'Mounts the element with no parent and no slot. '
              'Creates the child via inflateWidget.', _kRoot),
          SizedBox(height: 8),
          _apiCard('visitChildren(visitor)', 'Calls visitor on the single _child if present.', _kChild),
          SizedBox(height: 8),
          _apiCard('forgetChild(child)', 'Nulls out the _child reference when the tree mutates.', _kBinding),
          SizedBox(height: 8),
          _apiCard('performRebuild()', 'Called when the widget changes. Deactivates old child, '
              'inflates new child from the updated widget.', _kBuild),
          SizedBox(height: 8),
          _apiCard('update(newWidget)', 'Receives a new RootWidget. Triggers performRebuild '
              'if the child widget has changed.', _kWidget),
          SizedBox(height: 8),
          _apiCard('assignOwner(owner)', 'From RootElementMixin. Sets BuildOwner and creates root scope.', _kRender),
        ],
      ),
    );
  }

  Widget _apiCard(String name, String desc, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.code, color: color, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRootWidgetConnection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('RootWidget → RootElement Connection'),
          SizedBox(height: 12),
          Text(
            'RootElement is always paired with a RootWidget. The widget '
            'owns a single child and delegates element creation:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _connectionCard(
                  'RootWidget',
                  _kWidget,
                  [
                    'Widget child',
                    'createElement() → RootElement',
                    'attach(buildOwner, element)',
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Icon(Icons.arrow_forward, color: _kDivider, size: 20),
              ),
              Expanded(
                child: _connectionCard(
                  'RootElement',
                  _kRoot,
                  [
                    'Element? _child',
                    'mount(null, null)',
                    'performRebuild()',
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kDivider),
            ),
            child: Text(
              '// Simplified: what runApp does\n'
              'final rootWidget = RootWidget(child: yourApp);\n'
              'final rootElement = rootWidget.createElement();\n'
              'rootElement.assignOwner(buildOwner);\n'
              'rootElement.mount(null, null);\n'
              '// → rootElement._child = yourApp element',
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _connectionCard(String title, Color color, List<String> items) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Text(item, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 9)),
          )),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('RootElement vs Normal Element'),
          SizedBox(height: 16),
          // Header
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Property', style: TextStyle(color: _kAccent, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text('RootElement', style: TextStyle(color: _kRoot, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 3,
                child: Text('Normal Element', style: TextStyle(color: _kTextSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Divider(color: _kDivider, height: 16),
          _compRow('Parent', 'Always null', 'Non-null parent'),
          _compRow('Depth', '0', '1 to N'),
          _compRow('Owner', 'Assigned directly', 'Inherited from parent'),
          _compRow('Children', 'Exactly 1', '0, 1, or many'),
          _compRow('Slot', 'null', 'Defined by parent'),
          _compRow('Lifetime', 'Entire app', 'Route/subtree lifetime'),
          _compRow('Count', 'Exactly 1 per app', 'Thousands per app'),
          _compRow('Rebuild', 'Extremely rare', 'Frequent (setState)'),
        ],
      ),
    );
  }

  Widget _compRow(String prop, String root, String normal) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(prop, style: TextStyle(color: _kAccent, fontSize: 10)),
          ),
          Expanded(
            flex: 3,
            child: Text(root, style: TextStyle(color: _kRoot, fontSize: 10)),
          ),
          Expanded(
            flex: 3,
            child: Text(normal, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

// =============================================================================
// TAB 2: TREE EXPLORER
// =============================================================================
class _TreeExplorerTab extends StatefulWidget {
  @override
  State<_TreeExplorerTab> createState() => _TreeExplorerTabState();
}

class _TreeExplorerTabState extends State<_TreeExplorerTab> {
  int _expandedLayer = -1;
  bool _showDetails = false;

  final List<_LayerInfo> _layers = [
    _LayerInfo(
      'RootElement',
      'Element with RootElementMixin',
      _kRoot,
      'The anchor. Has no parent, holds exactly one child. '
      'Created by RootWidget.createElement(). BuildOwner assigned here.',
      ['mount(null, null)', 'assignOwner(owner)', 'performRebuild()'],
    ),
    _LayerInfo(
      'RootWidget child element',
      'App widget element',
      _kWidget,
      'The element for the widget passed to runApp(). Usually a MaterialApp '
      'or CupertinoApp widget. This is where multi-child begins.',
      ['updateChild()', 'build()', 'didChangeDependencies()'],
    ),
    _LayerInfo(
      'WidgetsApp element',
      'Navigation + locale + media',
      _kBinding,
      'Provides Navigator, Localizations, and MediaQuery. These are the '
      'framework-level services every Flutter app needs.',
      ['Navigator.push()', 'Localizations.of()', 'MediaQuery.of()'],
    ),
    _LayerInfo(
      'Navigator element',
      'Route stack manager',
      _kChild,
      'Manages the Overlay that holds route entries. Each route is an '
      'OverlayEntry that sits in the Navigator\'s overlay stack.',
      ['push()', 'pop()', 'pushReplacement()'],
    ),
    _LayerInfo(
      'Overlay / Route elements',
      'Visual route entries',
      _kBuild,
      'Each route creates a sub-tree of elements. Transitions, heroes, '
      'and barriers are separate overlay entries.',
      ['ModalRoute.build()', 'TransitionRoute', 'PageRoute'],
    ),
    _LayerInfo(
      'Scaffold element',
      'App chrome: AppBar, Body, FAB',
      _kRender,
      'If using MaterialApp, the Scaffold provides the visual structure. '
      'AppBar, body, floatingActionButton, drawer, bottomSheet, etc.',
      ['Scaffold.of()', 'showSnackBar()', 'openDrawer()'],
    ),
    _LayerInfo(
      'Your widget elements',
      'User-authored widgets',
      _kAccent,
      'Finally, your custom StatelessWidget and StatefulWidget elements. '
      'These are at depths 30-50+ in a typical MaterialApp.',
      ['build()', 'setState()', 'initState()'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print('[TreeExplorer] Showing ${_layers.length} layers, expanded: $_expandedLayer');

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExplorerHeader(),
          SizedBox(height: 16),
          _buildToggle(),
          SizedBox(height: 12),
          ..._layers.asMap().entries.map((e) {
            final i = e.key;
            final layer = e.value;
            return Column(
              children: [
                _buildLayerCard(layer, i),
                if (i < _layers.length - 1)
                  _buildConnector(i),
              ],
            );
          }),
          SizedBox(height: 20),
          _buildTreeStats(),
          SizedBox(height: 20),
          _buildDepthImpactSection(),
        ],
      ),
    );
  }

  Widget _buildExplorerHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary.withOpacity(0.2), _kAccent.withOpacity(0.06)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Element Tree Layers',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Explore how elements are layered from the RootElement '
            'down to your custom widgets. Tap a layer to expand.',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return GestureDetector(
      onTap: () => setState(() => _showDetails = !_showDetails),
      child: Row(
        children: [
          Icon(
            _showDetails ? Icons.visibility : Icons.visibility_off,
            color: _kAccent,
            size: 16,
          ),
          SizedBox(width: 6),
          Text(
            _showDetails ? 'Hide methods' : 'Show methods',
            style: TextStyle(color: _kAccent, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildLayerCard(_LayerInfo layer, int index) {
    final expanded = _expandedLayer == index;
    return GestureDetector(
      onTap: () => setState(() => _expandedLayer = expanded ? -1 : index),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: expanded ? layer.color.withOpacity(0.12) : layer.color.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: expanded ? layer.color.withOpacity(0.5) : layer.color.withOpacity(0.15),
            width: expanded ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24, height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: layer.color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$index',
                    style: TextStyle(color: layer.color, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        layer.name,
                        style: TextStyle(color: layer.color, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(layer.subtitle, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
                    ],
                  ),
                ),
                Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: layer.color.withOpacity(0.5),
                  size: 20,
                ),
              ],
            ),
            if (expanded) ...[
              SizedBox(height: 10),
              Text(layer.description, style: TextStyle(color: _kTextPrimary, fontSize: 11, height: 1.4)),
            ],
            if (_showDetails || expanded) ...[
              SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: layer.methods.map((m) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: _kDivider),
                  ),
                  child: Text(m, style: TextStyle(color: layer.color, fontFamily: 'monospace', fontSize: 9)),
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConnector(int index) {
    return Padding(
      padding: EdgeInsets.only(left: 22),
      child: Container(width: 2, height: 6, color: _kDivider),
    );
  }

  Widget _buildTreeStats() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Typical App Element Statistics', style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          _statRow('RootElements', '1', _kRoot),
          _statRow('Framework elements', '25-40', _kBinding),
          _statRow('Route/Navigation elements', '10-20', _kChild),
          _statRow('Scaffold/Material elements', '15-30', _kRender),
          _statRow('User widget elements', '50-500+', _kAccent),
          _statRow('Total elements per route', '100-600+', _kBuild),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kRoot.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Only one of these is a RootElement. Every other element '
              'is a normal child element with a parent reference.',
              style: TextStyle(color: _kRoot, fontSize: 11, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statRow(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
          SizedBox(width: 8),
          Expanded(child: Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 11))),
          Text(value, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDepthImpactSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Depth Impact on Performance', style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(
            'Dirty elements are rebuilt in depth order (shallowest first). '
            'This means a dirty RootElement rebuilds before everything else, '
            'and child changes are coalesced naturally:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.3),
          ),
          SizedBox(height: 12),
          _depthImpact('Depth 0', 'RootElement — rebuilt first if dirty', _kRoot),
          _depthImpact('Depth 1-20', 'Framework — rarely dirty', _kBinding),
          _depthImpact('Depth 20+', 'User widgets — frequently dirty (setState)', _kAccent),
          SizedBox(height: 8),
          Text(
            'Sorting by depth prevents redundant rebuilds: if a parent '
            'rebuilds and changes its child, the child does not need a '
            'separate rebuild pass.',
            style: TextStyle(color: _kBuild, fontSize: 11, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _depthImpact(String depth, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(depth, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(desc, style: TextStyle(color: _kTextPrimary, fontSize: 10))),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: BUILD PIPELINE
// =============================================================================
class _BuildPipelineTab extends StatefulWidget {
  @override
  State<_BuildPipelineTab> createState() => _BuildPipelineTabState();
}

class _BuildPipelineTabState extends State<_BuildPipelineTab> {
  int _activeStage = 0;

  final List<_PipelineStage> _stages = [
    _PipelineStage(
      'Dirty Marking',
      Icons.flag,
      _kBuild,
      'When setState() is called, the element marks itself dirty.'
      '\n\nThe BuildOwner adds it to the dirty list and schedules '
      'a new frame via SchedulerBinding.scheduleFrame().',
      ['element.markNeedsBuild()', 'owner._dirtyElements.add(element)', 'scheduleFrame()'],
    ),
    _PipelineStage(
      'Frame Begins',
      Icons.play_arrow,
      _kBinding,
      'The engine signals a new frame. WidgetsBinding calls '
      'drawFrame(), which triggers the build phase.'
      '\n\nThis is where the BuildOwner processes all dirty elements.',
      ['onBeginFrame(timestamp)', 'handleDrawFrame()', 'WidgetsBinding.drawFrame()'],
    ),
    _PipelineStage(
      'Build Phase',
      Icons.build,
      _kChild,
      'BuildOwner.buildScope() sorts dirty elements by depth '
      '(shallowest first) and calls rebuild() on each.'
      '\n\nThe root element\'s scope encompasses the entire tree.',
      ['buildScope(rootElement)', 'sort by depth', 'element.rebuild()'],
    ),
    _PipelineStage(
      'Finalize Tree',
      Icons.check_box,
      _kWidget,
      'After all dirty elements have rebuilt, the framework '
      'finalizes the element tree. New elements are mounted, '
      'removed elements are deactivated.',
      ['finalizeTree()', 'unmount deactivated', 'clear inactive list'],
    ),
    _PipelineStage(
      'Layout Phase',
      Icons.straighten,
      _kRender,
      'The render tree computes sizes and positions. Starting '
      'from dirty render objects, constraints flow down and '
      'sizes flow up.',
      ['pipelineOwner.flushLayout()', 'performLayout()', 'parentUsesSize'],
    ),
    _PipelineStage(
      'Paint Phase',
      Icons.brush,
      _kRoot,
      'Dirty render objects repaint. The painting phase walks '
      'the render tree and records paint commands into layers.',
      ['pipelineOwner.flushPaint()', 'paint(context, offset)', 'Layer compositing'],
    ),
    _PipelineStage(
      'Compositing',
      Icons.layers,
      _kAccent,
      'The layer tree is sent to the engine for GPU compositing. '
      'The engine rasterizes the layers and presents the frame.',
      ['renderView.compositeFrame()', 'scene.build()', 'window.render(scene)'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print('[BuildPipeline] Active stage: $_activeStage');

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPipelineHeader(),
          SizedBox(height: 16),
          _buildStageSelector(),
          SizedBox(height: 16),
          _buildActiveStageDetail(),
          SizedBox(height: 20),
          _buildFullPipelineView(),
          SizedBox(height: 20),
          _buildRootElementRole(),
          SizedBox(height: 20),
          _buildPerformanceNotes(),
        ],
      ),
    );
  }

  Widget _buildPipelineHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kBuild.withOpacity(0.15), _kRoot.withOpacity(0.08)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBuild.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frame Build Pipeline',
            style: TextStyle(color: _kTextPrimary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Every frame that has dirty elements goes through this pipeline. '
            'The RootElement\'s BuildScope defines the boundary for the entire '
            'build phase. Select a stage to explore.',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildStageSelector() {
    return Container(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _stages.length,
        itemBuilder: (ctx, i) {
          final stage = _stages[i];
          final active = _activeStage == i;
          return GestureDetector(
            onTap: () => setState(() => _activeStage = i),
            child: Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: active ? stage.color.withOpacity(0.2) : _kSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: active ? stage.color : _kDivider,
                  width: active ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(stage.icon, color: stage.color, size: 16),
                  SizedBox(width: 6),
                  Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: active ? stage.color : _kTextSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActiveStageDetail() {
    final stage = _stages[_activeStage];
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: stage.color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36, height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: stage.color, shape: BoxShape.circle),
                child: Icon(stage.icon, color: Colors.white, size: 20),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stage ${_activeStage + 1}: ${stage.name}',
                      style: TextStyle(color: stage.color, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_activeStage + 1} of ${_stages.length}',
                      style: TextStyle(color: _kTextSecondary, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            stage.description,
            style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.5),
          ),
          SizedBox(height: 12),
          Text('Key operations:', style: TextStyle(color: _kTextSecondary, fontSize: 10)),
          SizedBox(height: 4),
          ...stage.operations.map((op) => Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Row(
              children: [
                Container(width: 4, height: 4, decoration: BoxDecoration(color: stage.color, shape: BoxShape.circle)),
                SizedBox(width: 8),
                Flexible(
                  child: Text(op, style: TextStyle(color: stage.color, fontFamily: 'monospace', fontSize: 10)),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFullPipelineView() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Complete Pipeline Overview', style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ..._stages.asMap().entries.map((e) {
            final i = e.key;
            final s = e.value;
            final active = _activeStage == i;
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: active ? s.color.withOpacity(0.15) : s.color.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: s.color.withOpacity(active ? 0.5 : 0.15)),
                  ),
                  child: Row(
                    children: [
                      Icon(s.icon, color: s.color, size: 14),
                      SizedBox(width: 8),
                      Text(
                        '${i + 1}. ${s.name}',
                        style: TextStyle(
                          color: s.color,
                          fontSize: 11,
                          fontWeight: active ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < _stages.length - 1)
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Container(width: 1, height: 4, color: _kDivider),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRootElementRole() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("RootElement's Role in the Pipeline", style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          _roleRow(
            'Scope provider',
            'The root\'s _parentBuildScope defines the boundary for buildScope(). '
            'All dirty elements resolve within this scope.',
            _kRoot,
          ),
          _roleRow(
            'Owner anchor',
            'The BuildOwner is rooted at RootElement. Without it, no element '
            'could be marked dirty or rebuilt.',
            _kBinding,
          ),
          _roleRow(
            'Tree root',
            'visitChildren() starts from here when the framework needs to walk '
            'the entire tree (for finalization, disposal, debugging).',
            _kChild,
          ),
          _roleRow(
            'Update receiver',
            'During hot reload, RootElement.update(newWidget) triggers the '
            'cascade that rebuilds with new code.',
            _kBuild,
          ),
        ],
      ),
    );
  }

  Widget _roleRow(String title, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6, height: 6,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceNotes() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.speed, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Text('Performance Notes', style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 12),
          _perfNote(
            'Depth-first sorting is O(n log n)',
            'Dirty list is sorted by depth before rebuilding. Shallow elements '
            'rebuild first, preventing redundant child rebuilds.',
            _kBuild,
          ),
          _perfNote(
            'BuildScope prevents cross-contamination',
            'Dirty elements from one scope do not leak into another. '
            'The root scope contains everything by default.',
            _kBinding,
          ),
          _perfNote(
            'RootElement rarely rebuilds',
            'The root element itself almost never needs to rebuild. '
            'Only runApp(newWidget) or hot reload triggers it.',
            _kRoot,
          ),
          _perfNote(
            'Tree finalization is batched',
            'Deactivated elements are cleaned up in one pass after '
            'the build phase, not during individual rebuilds.',
            _kChild,
          ),
        ],
      ),
    );
  }

  Widget _perfNote(String title, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
            SizedBox(height: 2),
            Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10, height: 1.3)),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// HELPERS
// =============================================================================
class _LayerInfo {
  final String name;
  final String subtitle;
  final Color color;
  final String description;
  final List<String> methods;
  _LayerInfo(this.name, this.subtitle, this.color, this.description, this.methods);
}

class _PipelineStage {
  final String name;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> operations;
  _PipelineStage(this.name, this.icon, this.color, this.description, this.operations);
}
