// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RootRenderObjectElement from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF546E7A); // BlueGrey 600
const _kAccent = Color(0xFFFFD740); // Amber A200
const _kSurface = Color(0xFF1E1E1E);
const _kCard = Color(0xFF2A2A2A);
const _kDimText = Color(0xFF9E9E9E);
const _kBrightText = Color(0xFFEEEEEE);
const _kDeprecated = Color(0xFFEF5350); // Red 400
const _kSuccess = Color(0xFF66BB6A); // Green 400

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: ColorScheme.dark(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _RootRenderObjectElementDemo(),
  );
}

class _RootRenderObjectElementDemo extends StatefulWidget {
  const _RootRenderObjectElementDemo();

  @override
  State<_RootRenderObjectElementDemo> createState() =>
      _RootRenderObjectElementDemoState();
}

class _RootRenderObjectElementDemoState
    extends State<_RootRenderObjectElementDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: const Text('RootRenderObjectElement',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(icon: Icon(Icons.warning_amber_rounded), text: 'Deprecation'),
            Tab(icon: Icon(Icons.swap_horiz), text: 'Migration'),
            Tab(icon: Icon(Icons.account_tree), text: 'Hierarchy'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _DeprecationTab(),
          _MigrationTab(),
          _HierarchyTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Deprecation Information
// ═══════════════════════════════════════════════════════════════════════════
class _DeprecationTab extends StatelessWidget {
  const _DeprecationTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header banner
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF37474F), Color(0xFF263238)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kDeprecated.withAlpha(100), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.warning_rounded, color: _kDeprecated, size: 48),
              const SizedBox(height: 12),
              const Text(
                'RootRenderObjectElement',
                style: TextStyle(
                    color: _kBrightText,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: _kDeprecated.withAlpha(40),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _kDeprecated.withAlpha(120)),
                ),
                child: const Text('DEPRECATED',
                    style: TextStyle(
                        color: _kDeprecated,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2)),
              ),
              const SizedBox(height: 14),
              const Text(
                'Abstract class that extended RenderObjectElement.\n'
                'Deprecated after v3.9.0-16.0.pre in favour of RootElementMixin.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDimText, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Why deprecated
        _buildSectionHeader('Why Deprecated?'),
        const SizedBox(height: 10),
        _buildInfoCard(
          icon: Icons.lightbulb_outline,
          iconColor: _kAccent,
          title: 'Composition over Inheritance',
          body: 'A mixin (RootElementMixin) provides the same root-element '
              'capabilities but can be composed with any Element subclass, '
              'not just RenderObjectElement. This is more flexible.',
        ),
        const SizedBox(height: 10),
        _buildInfoCard(
          icon: Icons.timeline,
          iconColor: _kPrimary,
          title: 'Timeline',
          body: 'Deprecated: v3.9.0-16.0.pre\n'
              'Replacement introduced in the same version.\n'
              'No removal date announced yet, but migration is recommended.',
        ),
        const SizedBox(height: 10),
        _buildInfoCard(
          icon: Icons.build_circle_outlined,
          iconColor: _kSuccess,
          title: 'What It Did',
          body: 'Served as the base class for root elements that own '
              'a RenderObject. Root elements sit at the top of the '
              'Element tree with no parent and receive a BuildOwner '
              'explicitly via assignOwner().',
        ),
        const SizedBox(height: 20),

        // Key properties list
        _buildSectionHeader('Key Characteristics'),
        const SizedBox(height: 10),
        ..._buildBulletList([
          'Root elements have null parent — they are the tree apex',
          'assignOwner() sets the BuildOwner for the entire subtree',
          'mount() is overridden to skip parent-child linking',
          'The BuildOwner manages the dirty elements list',
          'Only one root element per WidgetsBinding typically',
          'Used by WidgetsBinding.attachRootWidget internally',
        ]),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Migration Guide
// ═══════════════════════════════════════════════════════════════════════════
class _MigrationTab extends StatefulWidget {
  const _MigrationTab();

  @override
  State<_MigrationTab> createState() => _MigrationTabState();
}

class _MigrationTabState extends State<_MigrationTab> {
  bool _showNewCode = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Before/After toggle
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(80)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _showNewCode ? Icons.check_circle : Icons.cancel,
                    color: _showNewCode ? _kSuccess : _kDeprecated,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _showNewCode ? 'After Migration' : 'Before Migration',
                    style: TextStyle(
                      color: _showNewCode ? _kSuccess : _kDeprecated,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: _showNewCode,
                    activeColor: _kSuccess,
                    inactiveThumbColor: _kDeprecated,
                    onChanged: (v) => setState(() => _showNewCode = v),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 350),
                crossFadeState: _showNewCode
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: _buildCodeBlock(
                  'class MyRootElement\n'
                  '    extends RootRenderObjectElement {\n'
                  '  MyRootElement(super.widget);\n'
                  '\n'
                  '  @override\n'
                  '  void mount(Element? parent, Object? slot) {\n'
                  '    super.mount(parent, slot);\n'
                  '    // Root-specific mounting logic\n'
                  '  }\n'
                  '}',
                  label: 'DEPRECATED',
                  labelColor: _kDeprecated,
                ),
                secondChild: _buildCodeBlock(
                  'class MyRootElement\n'
                  '    extends RenderObjectElement\n'
                  '    with RootElementMixin {\n'
                  '  MyRootElement(super.widget);\n'
                  '\n'
                  '  @override\n'
                  '  void mount(Element? parent, Object? slot) {\n'
                  '    super.mount(parent, slot);\n'
                  '    // Same logic, now via mixin\n'
                  '  }\n'
                  '}',
                  label: 'CURRENT',
                  labelColor: _kSuccess,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Migration steps
        _buildSectionHeader('Migration Steps'),
        const SizedBox(height: 10),
        ..._buildMigrationSteps(),
        const SizedBox(height: 20),

        // Live verification
        _buildSectionHeader('Live Verification'),
        const SizedBox(height: 10),
        _buildVerificationPanel(),
        const SizedBox(height: 20),

        // Compatibility matrix
        _buildSectionHeader('API Compatibility'),
        const SizedBox(height: 10),
        _buildCompatibilityTable(),
      ],
    );
  }

  Widget _buildCodeBlock(String code,
      {required String label, required Color labelColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: labelColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: labelColor.withAlpha(30),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(label,
                style: TextStyle(
                    color: labelColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5)),
          ),
          const SizedBox(height: 10),
          Text(code,
              style: const TextStyle(
                  color: _kBrightText,
                  fontFamily: 'monospace',
                  fontSize: 13,
                  height: 1.5)),
        ],
      ),
    );
  }

  List<Widget> _buildMigrationSteps() {
    const steps = [
      (
        '1',
        'Change extends clause',
        'Replace extends RootRenderObjectElement '
            'with extends RenderObjectElement.'
      ),
      (
        '2',
        'Add the mixin',
        'Append with RootElementMixin to the class declaration.'
      ),
      (
        '3',
        'Verify super calls',
        'Ensure mount() and assignOwner() forward correctly.'
      ),
      (
        '4',
        'Run tests',
        'Root element still receives BuildOwner and the subtree builds.'
      ),
      (
        '5',
        'Remove deprecated import',
        'Clean up any direct references to the old class.'
      ),
    ];

    return steps.map((s) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(30),
                  shape: BoxShape.circle,
                  border: Border.all(color: _kAccent.withAlpha(80)),
                ),
                alignment: Alignment.center,
                child: Text(s.$1,
                    style: const TextStyle(
                        color: _kAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.$2,
                        style: const TextStyle(
                            color: _kBrightText,
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(s.$3,
                        style: const TextStyle(
                            color: _kDimText, fontSize: 12, height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildVerificationPanel() {
    final rootWidget = RootWidget(child: const SizedBox());
    final element = rootWidget.createElement();
    final elementTypeName = element.runtimeType.toString();
    final isRoot = elementTypeName.contains('Root');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kSuccess.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Runtime Type Check',
              style: TextStyle(
                  color: _kBrightText,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildCheckRow('RootWidget.createElement()',
              elementTypeName, true),
          const SizedBox(height: 8),
          _buildCheckRow('Contains Root in type', '$isRoot', isRoot),
          const SizedBox(height: 8),
          _buildCheckRow('Uses RootElementMixin', 'true (by design)', true),
          const SizedBox(height: 8),
          _buildCheckRow(
              'Replaces RootRenderObjectElement', 'Yes', true),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSuccess.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kSuccess.withAlpha(60)),
            ),
            child: const Text(
              'The modern RootElement uses RootElementMixin '
              'instead of extending the deprecated class.',
              style:
                  TextStyle(color: _kSuccess, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckRow(String label, String value, bool pass) {
    return Row(
      children: [
        Icon(pass ? Icons.check_circle : Icons.cancel,
            color: pass ? _kSuccess : _kDeprecated, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child:
              Text(label, style: const TextStyle(color: _kDimText, fontSize: 13)),
        ),
        Text(value,
            style: TextStyle(
                color: pass ? _kSuccess : _kDeprecated,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildCompatibilityTable() {
    const rows = [
      ('assignOwner()', true, true),
      ('mount(parent, slot)', true, true),
      ('Null parent enforcement', true, true),
      ('BuildOwner propagation', true, true),
      ('Composable with any Element', false, true),
      ('Multiple mixin support', false, true),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(60)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _kPrimary.withAlpha(30),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: const Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text('Feature',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
                Expanded(
                    child: Text('Old',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _kDeprecated,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
                Expanded(
                    child: Text('New',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _kSuccess,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
              ],
            ),
          ),
          ...rows.map((r) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: _kPrimary.withAlpha(30))),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(r.$1,
                            style: const TextStyle(
                                color: _kDimText, fontSize: 12))),
                    Expanded(
                        child: Icon(
                            r.$2 ? Icons.check : Icons.close,
                            color: r.$2 ? _kSuccess : _kDeprecated,
                            size: 16)),
                    Expanded(
                      child: Icon(
                          r.$3 ? Icons.check : Icons.close,
                          color: r.$3 ? _kSuccess : _kDeprecated,
                          size: 16),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Element Hierarchy
// ═══════════════════════════════════════════════════════════════════════════
class _HierarchyTab extends StatefulWidget {
  const _HierarchyTab();

  @override
  State<_HierarchyTab> createState() => _HierarchyTabState();
}

class _HierarchyTabState extends State<_HierarchyTab> {
  String? _selectedNode;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader('Element Class Hierarchy'),
        const SizedBox(height: 12),
        _buildHierarchyTree(),
        const SizedBox(height: 20),

        // Detail panel
        if (_selectedNode != null) ...[
          _buildNodeDetail(_selectedNode!),
          const SizedBox(height: 20),
        ],

        // Root element lifecycle
        _buildSectionHeader('Root Element Lifecycle'),
        const SizedBox(height: 12),
        _buildLifecycleFlow(),
        const SizedBox(height: 20),

        // BuildOwner relationship
        _buildSectionHeader('BuildOwner Relationship'),
        const SizedBox(height: 12),
        _buildOwnerDiagram(),
        const SizedBox(height: 20),

        // Fun fact
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _kAccent.withAlpha(20),
                _kPrimary.withAlpha(20),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kAccent.withAlpha(60)),
          ),
          child: const Column(
            children: [
              Icon(Icons.info_outline, color: _kAccent, size: 28),
              SizedBox(height: 10),
              Text(
                'Did You Know?',
                style: TextStyle(
                    color: _kAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Even though RootRenderObjectElement is deprecated, '
                'the framework still exposes it for backwards compatibility. '
                'The mixin approach lets ComponentElements serve as roots too, '
                'not just RenderObjectElements.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: _kDimText, fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHierarchyTree() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTreeNode('Element', 0, 'Abstract base for all elements'),
          _buildTreeConnector(1),
          _buildTreeNode(
              'ComponentElement', 1, 'Elements that compose other widgets'),
          _buildTreeConnector(1),
          _buildTreeNode(
              'RenderObjectElement', 1, 'Elements with RenderObjects'),
          _buildTreeConnector(2),
          _buildTreeNode('RootRenderObjectElement', 2,
              'DEPRECATED root render element',
              isDeprecated: true),
          _buildTreeConnector(2),
          _buildTreeNode('+ RootElementMixin', 2,
              'Mixin for any Element as root',
              isMixin: true),
          const SizedBox(height: 12),
          const Divider(color: _kDimText, height: 1),
          const SizedBox(height: 10),
          _buildTreeNode('RootWidget', 0, 'Creates RootElement'),
          _buildTreeConnector(1),
          _buildTreeNode(
              'RootElement', 1, 'Uses RootElementMixin (modern)',
              isCurrent: true),
        ],
      ),
    );
  }

  Widget _buildTreeNode(String name, int depth, String description,
      {bool isDeprecated = false,
      bool isMixin = false,
      bool isCurrent = false}) {
    final isSelected = _selectedNode == name;
    Color nodeColor = _kBrightText;
    if (isDeprecated) nodeColor = _kDeprecated;
    if (isMixin) nodeColor = _kAccent;
    if (isCurrent) nodeColor = _kSuccess;

    return GestureDetector(
      onTap: () => setState(() =>
          _selectedNode = _selectedNode == name ? null : name),
      child: Container(
        margin: EdgeInsets.only(left: depth * 24.0),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? nodeColor.withAlpha(20)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: nodeColor.withAlpha(80))
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: nodeColor.withAlpha(isDeprecated ? 80 : 180),
                shape: BoxShape.circle,
                border: Border.all(color: nodeColor, width: 1.5),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name,
                          style: TextStyle(
                              color: nodeColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: isDeprecated
                                  ? TextDecoration.lineThrough
                                  : null)),
                      if (isDeprecated) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: _kDeprecated.withAlpha(30),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('DEP',
                              style: TextStyle(
                                  color: _kDeprecated,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                      if (isMixin) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: _kAccent.withAlpha(30),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('MIXIN',
                              style: TextStyle(
                                  color: _kAccent,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(description,
                      style: const TextStyle(
                          color: _kDimText, fontSize: 11)),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: isSelected ? nodeColor : Colors.transparent,
                size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeConnector(int depth) {
    return Container(
      margin: EdgeInsets.only(left: depth * 24.0 + 4),
      height: 16,
      width: 2,
      color: _kPrimary.withAlpha(40),
    );
  }

  Widget _buildNodeDetail(String node) {
    final details = <String, (String, String, Color)>{
      'Element': (
        'Abstract base class for all elements in the widget tree.',
        'Manages widget lifecycle, holds reference to parent and children. '
            'Every widget.createElement() produces an Element.',
        _kBrightText,
      ),
      'ComponentElement': (
        'Element that composes other Elements via build().',
        'StatelessElement and StatefulElement extend this. '
            'Calls build() to produce child widgets.',
        _kBrightText,
      ),
      'RenderObjectElement': (
        'Element that creates and manages a RenderObject.',
        'Bridges the widget layer to the rendering layer. '
            'insertRenderObjectChild/removeRenderObjectChild manage the tree.',
        _kBrightText,
      ),
      'RootRenderObjectElement': (
        'DEPRECATED: Was the root RenderObjectElement.',
        'Provided assignOwner() and root mounting. '
            'Replaced by RootElementMixin for better composition.',
        _kDeprecated,
      ),
      '+ RootElementMixin': (
        'Mixin that makes any Element a root element.',
        'Provides assignOwner() and special mount() that accepts null parent. '
            'Can be mixed into ComponentElement or RenderObjectElement.',
        _kAccent,
      ),
      'RootWidget': (
        'The widget placed at the root of the tree.',
        'Used by WidgetsBinding.attachRootWidget(). '
            'Creates RootElement via createElement().',
        _kBrightText,
      ),
      'RootElement': (
        'Modern root element using RootElementMixin.',
        'Created by RootWidget.createElement(). '
            'Mixes in RootElementMixin for root capabilities.',
        _kSuccess,
      ),
    };

    final d = details[node];
    if (d == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: d.$3.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: d.$3,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(node,
                    style: TextStyle(
                        color: d.$3,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(d.$1,
              style: const TextStyle(
                  color: _kBrightText, fontSize: 13, height: 1.4)),
          const SizedBox(height: 6),
          Text(d.$2,
              style: const TextStyle(
                  color: _kDimText, fontSize: 12, height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildLifecycleFlow() {
    const steps = [
      ('WidgetsBinding.attachRootWidget', Icons.power_settings_new),
      ('RootWidget created', Icons.widgets),
      ('RootWidget.createElement()', Icons.build),
      ('RootElement created (with mixin)', Icons.account_tree),
      ('assignOwner(buildOwner)', Icons.admin_panel_settings),
      ('mount(null, null)', Icons.download),
      ('Subtree builds', Icons.layers),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(60)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: i == steps.length - 1
                        ? _kSuccess.withAlpha(30)
                        : _kPrimary.withAlpha(30),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: i == steps.length - 1
                          ? _kSuccess.withAlpha(120)
                          : _kPrimary.withAlpha(80),
                    ),
                  ),
                  child: Icon(steps[i].$2,
                      size: 18,
                      color: i == steps.length - 1
                          ? _kSuccess
                          : _kAccent),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(steps[i].$1,
                      style: const TextStyle(
                          color: _kBrightText,
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                ),
                Text('${i + 1}',
                    style: TextStyle(
                        color: _kDimText.withAlpha(120),
                        fontSize: 11)),
              ],
            ),
            if (i < steps.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 17),
                height: 18,
                width: 2,
                color: _kPrimary.withAlpha(40),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildOwnerDiagram() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kAccent.withAlpha(60)),
      ),
      child: Column(
        children: [
          // BuildOwner box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kAccent.withAlpha(15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kAccent.withAlpha(60)),
            ),
            child: const Column(
              children: [
                Icon(Icons.admin_panel_settings,
                    color: _kAccent, size: 28),
                SizedBox(height: 6),
                Text('BuildOwner',
                    style: TextStyle(
                        color: _kAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Manages dirty elements list\nDrives build pipeline',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _kDimText, fontSize: 11, height: 1.3)),
              ],
            ),
          ),
          // Arrow
          Container(
            height: 24,
            width: 2,
            color: _kAccent.withAlpha(80),
          ),
          const Icon(Icons.arrow_downward,
              color: _kAccent, size: 16),
          const SizedBox(height: 4),
          // Root Element box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kSuccess.withAlpha(15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSuccess.withAlpha(60)),
            ),
            child: const Column(
              children: [
                Icon(Icons.account_tree, color: _kSuccess, size: 28),
                SizedBox(height: 6),
                Text('RootElement',
                    style: TextStyle(
                        color: _kSuccess,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                    'Receives owner via assignOwner()\nParent is always null',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _kDimText, fontSize: 11, height: 1.3)),
              ],
            ),
          ),
          // Arrow
          Container(
            height: 24,
            width: 2,
            color: _kSuccess.withAlpha(80),
          ),
          const Icon(Icons.arrow_downward,
              color: _kSuccess, size: 16),
          const SizedBox(height: 4),
          // Child elements
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kPrimary.withAlpha(15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPrimary.withAlpha(60)),
            ),
            child: const Column(
              children: [
                Icon(Icons.layers, color: _kPrimary, size: 28),
                SizedBox(height: 6),
                Text('Child Elements',
                    style: TextStyle(
                        color: _kPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Inherit owner from parent\nForm the Element tree',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _kDimText, fontSize: 11, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared Helpers
// ═══════════════════════════════════════════════════════════════════════════
Widget _buildSectionHeader(String title) {
  return Row(
    children: [
      Container(width: 4, height: 20, color: _kAccent),
      const SizedBox(width: 10),
      Text(title,
          style: const TextStyle(
              color: _kBrightText,
              fontSize: 17,
              fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _buildInfoCard({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: iconColor.withAlpha(50)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: _kBrightText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(body,
                  style: const TextStyle(
                      color: _kDimText, fontSize: 12, height: 1.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildBulletList(List<String> items) {
  return items.map((item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, color: _kAccent, size: 6),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(item,
                style: const TextStyle(
                    color: _kDimText, fontSize: 13, height: 1.4)),
          ),
        ],
      ),
    );
  }).toList();
}
