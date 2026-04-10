// Deep visual test for RootElementMixin
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

/// Deep visual exploration of RootElementMixin
/// The mixin that marks an element as the root of the element tree.
/// Only root elements can have a BuildOwner assigned directly —
/// all other elements inherit their owner from their parent.
///
/// RootElementMixin provides:
/// - assignOwner(BuildOwner) — sets the tree's build coordinator
/// - mount(null, null) assertion — root has no parent
/// - _parentBuildScope creation — scope for the entire tree
///
/// Used by RootRenderObjectElement → RenderObjectToWidgetElement,
/// which is the element created when you call runApp().
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF0A1A1A),
    ),
    home: _RootElementMixinDemo(),
  );
}

// =============================================================================
// PALETTE: Teal 600 / Pink A100
// =============================================================================
const Color _kPrimary = Color(0xFF00897B); // Teal 600
const Color _kAccent = Color(0xFFFF80AB); // Pink A100
const Color _kSurface = Color(0xFF102828);
const Color _kCardBg = Color(0xFF163838);
const Color _kTextPrimary = Color(0xFFE0F2F1);
const Color _kTextSecondary = Color(0xFF8FB8B3);
const Color _kDivider = Color(0xFF2A5050);
const Color _kTree = Color(0xFF4DB6AC); // Teal 300
const Color _kOwner = Color(0xFFFFA726); // Orange 400
const Color _kScope = Color(0xFF42A5F5); // Blue 400
const Color _kMount = Color(0xFFAB47BC); // Purple 400
const Color _kBuild = Color(0xFFEF5350); // Red 400
const Color _kMixin = Color(0xFFFFCA28); // Amber 400

// =============================================================================
// MAIN DEMO
// =============================================================================
class _RootElementMixinDemo extends StatefulWidget {
  @override
  State<_RootElementMixinDemo> createState() => _RootElementMixinDemoState();
}

class _RootElementMixinDemoState extends State<_RootElementMixinDemo>
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
        title: Text('RootElementMixin Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.account_tree), text: 'Tree Anatomy'),
            Tab(icon: Icon(Icons.timeline), text: 'Lifecycle'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _TreeAnatomyTab(),
          _LifecycleTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: THEORY
// =============================================================================
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderCard(),
          SizedBox(height: 20),
          _buildWhatIsMixin(),
          SizedBox(height: 20),
          _buildAssignOwnerSection(),
          SizedBox(height: 20),
          _buildMountAssertionSection(),
          SizedBox(height: 20),
          _buildBuildScopeSection(),
          SizedBox(height: 20),
          _buildWhyMixinPattern(),
          SizedBox(height: 20),
          _buildConcreteUsers(),
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
              Icon(Icons.merge_type, color: _kMixin, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RootElementMixin',
                      style: TextStyle(
                        color: _kTextPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _kMixin.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'MIXIN on Element',
                        style: TextStyle(color: _kMixin, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'The mixin that grants root-element status. In every Flutter app '
            'there is exactly one element at the top of the tree — and it '
            'uses RootElementMixin to manage the BuildOwner and the root '
            'build scope. Without this mixin, the element tree has no '
            'coordinator and cannot rebuild.',
            style: TextStyle(color: _kTextSecondary, fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _kMixin.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'mixin RootElementMixin on Element { ... }',
              style: TextStyle(color: _kScope, fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatIsMixin() {
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
          _sectionTitle('What Does Root-Element Status Mean?'),
          SizedBox(height: 12),
          Text(
            'Normal elements inherit their BuildOwner from their parent. '
            'The root element has no parent, so it needs a special way to '
            'receive a BuildOwner. RootElementMixin provides exactly that.',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _comparisonBox(
                  'Normal Element',
                  _kTextSecondary,
                  [
                    'Has a parent element',
                    'Inherits BuildOwner from parent',
                    'Mounted with parent reference',
                    'Slot position in parent',
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _comparisonBox(
                  'Root Element',
                  _kMixin,
                  [
                    'No parent (null)',
                    'Receives BuildOwner directly',
                    'Mounted with parent = null',
                    'No slot (null)',
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _comparisonBox(String title, Color color, List<String> items) {
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
          Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          ...items.map((i) => Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 4, height: 4, margin: EdgeInsets.only(top: 5), decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                SizedBox(width: 6),
                Flexible(child: Text(i, style: TextStyle(color: _kTextPrimary, fontSize: 10))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAssignOwnerSection() {
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
          _sectionTitle('assignOwner(BuildOwner owner)'),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kOwner.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'The single most important method in RootElementMixin. '
              'Called once during app startup to wire the BuildOwner — '
              'the coordinator that manages the entire dirty-rebuild pipeline.',
              style: TextStyle(color: _kOwner, fontSize: 12, height: 1.4),
            ),
          ),
          SizedBox(height: 16),
          // What it does
          _actionStep('1. Stores the BuildOwner reference', _kOwner),
          _actionStep('2. Creates the root _parentBuildScope', _kScope),
          _actionStep('3. BuildOwner can now schedule rebuilds', _kBuild),
          _actionStep('4. Tree is ready for the build pipeline', _kTree),
          SizedBox(height: 16),
          // Code
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kDivider),
            ),
            child: Text(
              'void assignOwner(BuildOwner owner) {\n'
              '  _owner = owner;\n'
              '  _parentBuildScope = BuildOwner.BuildScope();\n'
              '}',
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11, height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kBuild.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber, color: _kBuild, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'assignOwner is called exactly once per app lifecycle. '
                    'Calling it again would break the tree. The assertion '
                    'in the framework prevents double-assignment.',
                    style: TextStyle(color: _kBuild, fontSize: 11, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionStep(String text, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(Icons.arrow_right, color: color, size: 18),
          SizedBox(width: 6),
          Expanded(child: Text(text, style: TextStyle(color: _kTextPrimary, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildMountAssertionSection() {
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
          _sectionTitle('mount() Override — The Root Contract'),
          SizedBox(height: 12),
          Text(
            'RootElementMixin overrides mount() to enforce the root contract:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kDivider),
            ),
            child: Text(
              '@override\n'
              'void mount(Element? parent, Object? newSlot) {\n'
              '  assert(parent == null);\n'
              '  assert(newSlot == null);\n'
              '  super.mount(parent, newSlot);\n'
              '}',
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11, height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _assertionCard('parent == null', 'Root has no parent element', _kMount),
              SizedBox(width: 8),
              _assertionCard('newSlot == null', 'Root occupies no slot', _kMount),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'If either assertion fails, something is fundamentally wrong — '
            'the framework tried to mount a root element as a child.',
            style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _assertionCard(String assertion, String desc, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              assertion,
              style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildBuildScopeSection() {
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
          _sectionTitle('BuildScope — The Coordination Layer'),
          SizedBox(height: 12),
          Text(
            'When assignOwner creates the root BuildScope, it establishes '
            'the boundary for build phase scheduling:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 16),
          // Pipeline visualization
          _pipelineStep('BuildOwner', 'Coordinates all builds', _kOwner, Icons.business),
          _pipelineArrow(),
          _pipelineStep('BuildScope', 'Groups dirty elements', _kScope, Icons.layers),
          _pipelineArrow(),
          _pipelineStep('Root Element', 'Top of element tree', _kTree, Icons.account_tree),
          _pipelineArrow(),
          _pipelineStep('Child Elements', 'All elements below root', _kTextSecondary, Icons.grid_view),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kScope.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'A BuildScope groups elements that should be rebuilt together. '
              'The root scope contains all elements in the tree. '
              'BuildOwner.buildScope() walks dirty elements within a scope '
              'and calls their build() methods.',
              style: TextStyle(color: _kScope, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pipelineStep(String name, String desc, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pipelineArrow() {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Container(width: 2, height: 8, color: _kDivider),
          Icon(Icons.arrow_drop_down, color: _kDivider, size: 14),
        ],
      ),
    );
  }

  Widget _buildWhyMixinPattern() {
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
          _sectionTitle('Why a Mixin Instead of a Subclass?'),
          SizedBox(height: 12),
          Text(
            'Dart uses single inheritance, so making a RootElement base class '
            'would force all root elements into one inheritance chain. '
            'A mixin can be applied to any Element subclass.',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 16),
          // Mixin flexibility
          _mixinUsageRow('ComponentElement', 'Could use if needed for composite root', _kTree),
          _mixinUsageRow('RenderObjectElement', 'Actual usage — RootRenderObjectElement', _kOwner),
          _mixinUsageRow('Any Element subclass', 'Mixin is applicable to all', _kMixin),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kMixin.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'mixin on Element',
                  style: TextStyle(color: _kMixin, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'The "on Element" constraint ensures the mixin can only '
                  'be applied to classes that extend Element. This gives '
                  'the mixin access to _owner, mount(), and other Element APIs.',
                  style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mixinUsageRow(String element, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 6, height: 6, margin: EdgeInsets.only(top: 6), decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConcreteUsers() {
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
          _sectionTitle('Concrete Classes Using This Mixin'),
          SizedBox(height: 12),
          _concreteCard(
            'RootRenderObjectElement',
            'Abstract class that combines RenderObjectElement with RootElementMixin. '
            'Provides a foundation for root elements that manage RenderObjects.',
            _kTree,
          ),
          SizedBox(height: 8),
          _concreteCard(
            'RenderObjectToWidgetElement',
            'The actual class instantiated by runApp(). Extends RootRenderObjectElement '
            'and connects the widget tree to the render tree\'s root.',
            _kOwner,
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'In practice, every Flutter app has exactly one instance of '
              'RenderObjectToWidgetElement as its root element, which '
              'gets RootElementMixin from RootRenderObjectElement.',
              style: TextStyle(color: _kAccent, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _concreteCard(String name, String desc, Color color) {
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
          Icon(Icons.widgets, color: color, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.3)),
              ],
            ),
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
// TAB 2: TREE ANATOMY
// =============================================================================
class _TreeAnatomyTab extends StatefulWidget {
  @override
  State<_TreeAnatomyTab> createState() => _TreeAnatomyTabState();
}

class _TreeAnatomyTabState extends State<_TreeAnatomyTab> {
  int _selectedDepth = -1;

  @override
  Widget build(BuildContext context) {
    print('[TreeAnatomy] Selected depth: $_selectedDepth');

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTreeVisualization(),
          SizedBox(height: 20),
          _buildOwnerInheritanceSection(),
          SizedBox(height: 20),
          _buildDepthComparisonSection(),
          SizedBox(height: 20),
          _buildRunAppSequence(),
          SizedBox(height: 20),
          _buildElementInspector(),
        ],
      ),
    );
  }

  Widget _buildTreeVisualization() {
    final nodes = <_TreeNode>[
      _TreeNode(0, 'RootElement', 'RootElementMixin applied', _kMixin, true),
      _TreeNode(1, 'WidgetsApp', 'Second element in tree', _kTree, false),
      _TreeNode(2, 'Navigator', 'Route management', _kScope, false),
      _TreeNode(3, 'Route Overlay', 'Stack of route entries', _kOwner, false),
      _TreeNode(4, 'MaterialApp shell', 'Theme, media query', _kBuild, false),
      _TreeNode(5, 'Scaffold', 'App chrome, body, etc.', _kAccent, false),
      _TreeNode(6, 'Your Widgets', 'User-authored content', _kTextPrimary, false),
    ];

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
          Text('Element Tree Visualization', style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('Tap a node to see details', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
          SizedBox(height: 16),
          ...nodes.asMap().entries.map((e) {
            final i = e.key;
            final n = e.value;
            return Column(
              children: [
                _treeNodeWidget(n, i),
                if (i < nodes.length - 1)
                  Padding(
                    padding: EdgeInsets.only(left: n.depth * 14.0 + 16),
                    child: Container(width: 2, height: 10, color: _kDivider),
                  ),
              ],
            );
          }),
          SizedBox(height: 16),
          if (_selectedDepth >= 0)
            _buildNodeDetail(nodes[_selectedDepth]),
        ],
      ),
    );
  }

  Widget _treeNodeWidget(_TreeNode node, int index) {
    final selected = _selectedDepth == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedDepth = _selectedDepth == index ? -1 : index),
      child: Padding(
        padding: EdgeInsets.only(left: node.depth * 14.0),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? node.color.withOpacity(0.15) : node.color.withOpacity(0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? node.color.withOpacity(0.6) : node.color.withOpacity(0.2),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              if (node.isRoot)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: _kMixin.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text('ROOT', style: TextStyle(color: _kMixin, fontSize: 8, fontWeight: FontWeight.bold)),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      node.name,
                      style: TextStyle(color: node.color, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    Text(node.desc, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                  ],
                ),
              ),
              Text('depth ${node.depth}', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNodeDetail(_TreeNode node) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: node.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: node.color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(node.name, style: TextStyle(color: node.color, fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          _detailRow('Depth', '${node.depth}', node.color),
          _detailRow('Has parent', '${!node.isRoot}', node.color),
          _detailRow('BuildOwner', node.isRoot ? 'Assigned directly' : 'Inherited', node.color),
          _detailRow('Mixin', node.isRoot ? 'RootElementMixin' : 'None', node.color),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(width: 80, child: Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 10))),
          Text(value, style: TextStyle(color: _kTextPrimary, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildOwnerInheritanceSection() {
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
          Text('BuildOwner Inheritance Path', style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(
            'The BuildOwner flows from the root down through the tree. '
            'Every child element reads its owner from the parent.',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 16),
          // Inheritance flow
          _inheritanceRow('WidgetsBinding', 'Creates BuildOwner', _kOwner, true),
          _inheritArrow(),
          _inheritanceRow('assignOwner(owner)', 'Root element gets owner', _kMixin, false),
          _inheritArrow(),
          _inheritanceRow('child._owner = this._owner', 'Each child inherits', _kTree, false),
          _inheritArrow(),
          _inheritanceRow('...all descendants', 'Same owner across tree', _kTextSecondary, false),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kOwner.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Result: The entire element tree shares one BuildOwner. '
              'When any element marks itself dirty, the BuildOwner knows '
              'about it and schedules a frame to rebuild it.',
              style: TextStyle(color: _kOwner, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inheritanceRow(String title, String desc, Color color, bool highlight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(highlight ? 0.12 : 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(highlight ? Icons.person : Icons.subdirectory_arrow_right, color: color, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inheritArrow() {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Container(width: 2, height: 8, color: _kDivider),
    );
  }

  Widget _buildDepthComparisonSection() {
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
          Text('Depth Comparison: Real App', style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(
            'A typical MaterialApp creates ~30-50 elements between the root '
            'and your first custom widget. Heres what the depth looks like:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.3),
          ),
          SizedBox(height: 12),
          _depthBar('Root + Mixin', 0, 1, _kMixin),
          _depthBar('Framework chrome', 1, 30, _kTree),
          _depthBar('Your app structure', 30, 42, _kOwner),
          _depthBar('User widgets', 42, 50, _kAccent),
          SizedBox(height: 12),
          Text(
            'The root element (depth 0) is the only element with '
            'RootElementMixin. Everything else is a normal child element.',
            style: TextStyle(color: _kTextSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _depthBar(String label, int start, int end, Color color) {
    final barStart = start / 50.0;
    final barWidth = (end - start) / 50.0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 90,
                child: Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ),
              Expanded(
                child: Container(
                  height: 18,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: _kSurface,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: barStart + barWidth,
                        child: Row(
                          children: [
                            SizedBox(width: barStart > 0 ? barStart * 200 : 0),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '$start-$end',
                                  style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRunAppSequence() {
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
          Text('runApp() Sequence', style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(
            'How RootElementMixin fits into runApp:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 16),
          _sequenceStep(1, 'User calls runApp(widget)', _kAccent),
          _sequenceStep(2, 'WidgetsBinding.attachRootWidget()', _kTree),
          _sequenceStep(3, 'Creates RenderObjectToWidgetAdapter (root widget)', _kOwner),
          _sequenceStep(4, 'attachToRenderTree(buildOwner, renderView)', _kScope),
          _sequenceStep(5, 'root widget.createElement() → root element', _kMixin),
          _sequenceStep(6, 'element.assignOwner(buildOwner)', _kBuild),
          _sequenceStep(7, 'element.mount(null, null)', _kMount),
          _sequenceStep(8, 'element.build() → your widget tree', _kAccent),
        ],
      ),
    );
  }

  Widget _sequenceStep(int num, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22, height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
            child: Text('$num', style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(desc, style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.3)),
          ),
        ],
      ),
    );
  }

  Widget _buildElementInspector() {
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
          Text('Live Element Inspector', style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Builder(
            builder: (ctx) {
              final elem = ctx as Element;
              print('[Inspector] Current element type: ${elem.runtimeType}');
              print('[Inspector] Widget: ${elem.widget.runtimeType}');

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _inspectorRow('Context type', '${elem.runtimeType}', _kTree),
                  _inspectorRow('Widget type', '${elem.widget.runtimeType}', _kOwner),
                  _inspectorRow('Mounted', '${elem.mounted}', _kMixin),
                  _inspectorRow('Is root?', 'No (child of Scaffold)', _kBuild),
                  _inspectorRow('Owner inherited', 'Yes, from parent chain', _kScope),
                  SizedBox(height: 8),
                  _inspectorRow('Creator chain', elem.debugGetCreatorChain(5), _kTextSecondary),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _kAccent.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'This element is a normal child element. '
                      'The RootElementMixin is on the element at depth 0, '
                      'far above us in the tree. We inherited our BuildOwner '
                      'from our parent, who inherited it from theirs, all the '
                      'way up to the root.',
                      style: TextStyle(color: _kAccent, fontSize: 11, height: 1.3),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _inspectorRow(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 10)),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: LIFECYCLE
// =============================================================================
class _LifecycleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLifecycleOverview(),
          SizedBox(height: 20),
          _buildPhase1(),
          SizedBox(height: 16),
          _buildPhase2(),
          SizedBox(height: 16),
          _buildPhase3(),
          SizedBox(height: 16),
          _buildPhase4(),
          SizedBox(height: 20),
          _buildBuildPipelineSection(),
          SizedBox(height: 20),
          _buildHotReloadSection(),
          SizedBox(height: 20),
          _buildDisposalSection(),
        ],
      ),
    );
  }

  Widget _buildLifecycleOverview() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kBuild.withOpacity(0.15), _kMixin.withOpacity(0.08)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBuild.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Root Element Lifecycle',
            style: TextStyle(color: _kTextPrimary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'The root element has the longest lifecycle of any element. '
            'Created during runApp, it survives hot-reloads and only dies '
            'when the process terminates. Its lifecycle has four phases:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _phaseChip('1. Create', _kTree),
              _phaseChip('2. Assign', _kOwner),
              _phaseChip('3. Mount', _kMount),
              _phaseChip('4. Build', _kBuild),
            ],
          ),
        ],
      ),
    );
  }

  Widget _phaseChip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPhase1() {
    return _phaseCard(
      '1',
      'Creation',
      _kTree,
      'The root widget (RenderObjectToWidgetAdapter) creates its element. '
      'At this point, the element exists but has no owner and no place in the tree.',
      [
        'widget.createElement() → RenderObjectToWidgetElement',
        'Element is in "initial" state',
        'No BuildOwner yet, no parent',
        'Cannot build — not yet mounted',
      ],
    );
  }

  Widget _buildPhase2() {
    return _phaseCard(
      '2',
      'Owner Assignment',
      _kOwner,
      'The framework calls assignOwner() from RootElementMixin. '
      'This wires the BuildOwner and creates the root BuildScope.',
      [
        'assignOwner(buildOwner) from WidgetsBinding',
        '_owner set to the shared BuildOwner',
        '_parentBuildScope created as root scope',
        'BuildOwner can now track dirty elements',
      ],
    );
  }

  Widget _buildPhase3() {
    return _phaseCard(
      '3',
      'Mounting',
      _kMount,
      'mount(null, null) is called. The assertions verify this is truly a root element, '
      'then the lifecycle continues to make the element active.',
      [
        'assert(parent == null) — root has no parent',
        'assert(newSlot == null) — root has no slot',
        'super.mount() runs Element lifecycle',
        'Element state → "active"',
      ],
    );
  }

  Widget _buildPhase4() {
    return _phaseCard(
      '4',
      'First Build',
      _kBuild,
      'The root element builds its child widget tree for the first time. '
      'This triggers the entire widget/element/render tree creation.',
      [
        'build() creates child elements recursively',
        'Each child gets owner from parent chain',
        'RenderObjects created for visual elements',
        'Layout, paint, compositing scheduled',
      ],
    );
  }

  Widget _phaseCard(String num, String title, Color color, String desc, List<String> details) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30, height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Text(num, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              SizedBox(width: 10),
              Text(title, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8),
          Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.3)),
          SizedBox(height: 10),
          ...details.map((d) => Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_outline, color: color.withOpacity(0.6), size: 14),
                SizedBox(width: 6),
                Expanded(child: Text(d, style: TextStyle(color: _kTextPrimary, fontSize: 11, height: 1.3))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildBuildPipelineSection() {
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
          Text('Build Pipeline via BuildOwner', style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(
            'After mounting, the root element participates in the build '
            'pipeline on every frame that has dirty elements:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 16),
          _pipeRow(1, 'setState() marks element dirty', _kBuild),
          _pipeRow(2, 'BuildOwner adds to dirty list', _kOwner),
          _pipeRow(3, 'Next frame: buildScope() called', _kScope),
          _pipeRow(4, 'Dirty elements sorted by depth', _kTree),
          _pipeRow(5, 'Each dirty element rebuilds', _kMount),
          _pipeRow(6, 'Element tree updated', _kAccent),
          _pipeRow(7, 'Render tree updated', _kMixin),
          _pipeRow(8, 'Layout → Paint → Composite', _kBuild),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kScope.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'The root element is rarely dirty itself — it almost never '
              'rebuilds. Child elements rebuild frequently, and the root '
              'element\'s BuildOwner coordinates all of it.',
              style: TextStyle(color: _kScope, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pipeRow(int num, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 20, height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Text('$num', style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(desc, style: TextStyle(color: _kTextPrimary, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildHotReloadSection() {
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
              Icon(Icons.bolt, color: _kMixin, size: 20),
              SizedBox(width: 8),
              Text('Hot Reload and the Root Element', style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'During hot reload, the root element survives. The framework:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13),
          ),
          SizedBox(height: 10),
          _reloadStep('Keeps the root element instance', _kTree, Icons.check),
          _reloadStep('Keeps the BuildOwner assignment', _kOwner, Icons.check),
          _reloadStep('Updates the root widget to the new version', _kBuild, Icons.refresh),
          _reloadStep('Root element.update(newWidget) called', _kMount, Icons.refresh),
          _reloadStep('Children rebuilt with new code', _kAccent, Icons.refresh),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kMixin.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Hot restart is different — it destroys the root element and '
              'calls runApp again. This triggers the full lifecycle from '
              'Phase 1 (Creation) again.',
              style: TextStyle(color: _kMixin, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reloadStep(String text, Color color, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _kTextPrimary, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildDisposalSection() {
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
              Icon(Icons.delete_outline, color: _kBuild, size: 20),
              SizedBox(width: 8),
              Text('Disposal', style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'The root element is never formally disposed during normal '
            'operation. When the process terminates:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 10),
          _disposalRow('Process exit', 'All memory freed by OS', _kTextSecondary),
          _disposalRow('Hot restart', 'Root deactivated → new root created', _kMixin),
          _disposalRow('detachRootWidget()', 'Root unmounted (test/teardown)', _kBuild),
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
              '// In tests:\n'
              'tester.binding.detachRootWidget();\n'
              '// → root element unmounted\n'
              '// → children deactivated and disposed\n'
              '// → BuildOwner cleared',
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _disposalRow(String scenario, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 6, height: 6, margin: EdgeInsets.only(top: 5), decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(scenario, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// HELPERS
// =============================================================================
class _TreeNode {
  final int depth;
  final String name;
  final String desc;
  final Color color;
  final bool isRoot;
  _TreeNode(this.depth, this.name, this.desc, this.color, this.isRoot);
}
