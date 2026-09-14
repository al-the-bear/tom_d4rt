// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for SingleChildRenderObjectElement.
///
/// SingleChildRenderObjectElement is the Element subclass created by
/// SingleChildRenderObjectWidget.createElement(). It manages exactly
/// one child element and bridges the widget tree to the render tree
/// via RenderObjectWithChildMixin.
///
/// Demonstrates:
/// - Tab 1 (Architecture): Class hierarchy, createElement path,
///   relationship to RenderObjectWithChildMixin, element vs widget
///   vs render object triad
/// - Tab 2 (Lifecycle): mount/update/unmount, updateChild logic,
///   slot management, visitChildren, forgetChild, insert/remove
/// - Tab 3 (Examples): Live SingleChildRenderObjectWidget subclasses
///   (Padding, Align, Opacity, ClipRRect, Transform) with element
///   tree visualization

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF00838F); // Cyan 800
const Color _kAccent = Color(0xFFFF8A80); // Red A100
const Color _kSurface = Color(0xFF0D1214);
const Color _kCard = Color(0xFF1A2024);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF2A3034);
const Color _kHighlight = Color(0xFF42A5F5);
const Color _kGreen = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFEF5350);
const Color _kAmber = Color(0xFFFFD54F);
const Color _kPurple = Color(0xFFAB47BC);
const Color _kCyan = Color(0xFF4DD0E1);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _SCROEDemo(),
  );
}

class _SCROEDemo extends StatefulWidget {
  const _SCROEDemo();
  @override
  State<_SCROEDemo> createState() => _SCROEDemoState();
}

class _SCROEDemoState extends State<_SCROEDemo>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SingleChildRenderObjectElement',
          style: TextStyle(
            color: _kAccent,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kPrimary,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(text: 'Architecture'),
            Tab(text: 'Lifecycle'),
            Tab(text: 'Examples'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _ArchitectureTab(),
          _LifecycleTab(),
          _ExamplesTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Architecture
// ═══════════════════════════════════════════════════════════════════════════════

class _ArchitectureTab extends StatefulWidget {
  const _ArchitectureTab();
  @override
  State<_ArchitectureTab> createState() =>
      _ArchitectureTabState();
}

class _ArchitectureTabState extends State<_ArchitectureTab>
    with AutomaticKeepAliveClientMixin {
  bool _expandHierarchy = true;
  bool _expandTriad = false;
  bool _expandCreateElement = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Class Hierarchy'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandHierarchy = !_expandHierarchy),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader('Element Type Chain',
                      _expandHierarchy),
                  if (_expandHierarchy) ...[
                    const SizedBox(height: 10),
                    _hierarchyNode('Element', _kDimText,
                        'Base class for all elements', 0),
                    _hierarchyArrow(),
                    _hierarchyNode(
                        'ComponentElement',
                        _kDimText,
                        'For widgets that compose other '
                        'widgets (skipped path)',
                        0),
                    const SizedBox(height: 8),
                    _hierarchyNode('Element', _kDimText,
                        'Base class for all elements', 0),
                    _hierarchyArrow(),
                    _hierarchyNode(
                        'RenderObjectElement',
                        _kHighlight,
                        'Creates and manages a '
                        'RenderObject',
                        0),
                    _hierarchyArrow(),
                    _hierarchyNode(
                        'SingleChildRenderObject\nElement',
                        _kAccent,
                        'Manages exactly ONE child element',
                        0),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _badge('final', _kAmber),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'Cannot be subclassed by '
                            'application code',
                            style: TextStyle(
                              color: _kDimText,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _codeBlock(
                      'class SingleChildRenderObjectElement\n'
                      '    extends RenderObjectElement {\n'
                      '  SingleChildRenderObjectElement(\n'
                      '    SingleChildRenderObjectWidget\n'
                      '        super.widget,\n'
                      '  );\n'
                      '  Element? _child;\n'
                      '}',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Siblings comparison
          _sectionTitle('Element Family'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _cardDecor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _siblingRow(
                  'SingleChildRender'
                  'ObjectElement',
                  'Exactly 0 or 1 child',
                  _kAccent,
                  true,
                ),
                const SizedBox(height: 6),
                _siblingRow(
                  'MultiChildRender'
                  'ObjectElement',
                  'Zero or more children (list)',
                  _kHighlight,
                  false,
                ),
                const SizedBox(height: 6),
                _siblingRow(
                  'LeafRenderObject'
                  'Element',
                  'No children at all',
                  _kGreen,
                  false,
                ),
                const SizedBox(height: 10),
                const Text(
                  'All three extend RenderObjectElement. '
                  'The choice depends on how many children '
                  'the widget manages.',
                  style: TextStyle(
                    color: _kDimText, fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Widget-Element-RenderObject triad
          _sectionTitle('The Three Trees'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandTriad = !_expandTriad),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader(
                      'Widget → Element → '
                      'RenderObject',
                      _expandTriad),
                  if (_expandTriad) ...[
                    const SizedBox(height: 10),
                    _triadRow(
                      'Widget Tree',
                      'SingleChildRenderObjectWidget',
                      'Immutable description',
                      _kAmber,
                      Icons.description,
                    ),
                    _triadArrow('createElement()'),
                    _triadRow(
                      'Element Tree',
                      'SingleChildRenderObjectElement',
                      'Mutable manager; holds state, '
                      'child reference, render object',
                      _kAccent,
                      Icons.account_tree,
                    ),
                    _triadArrow('createRenderObject()'),
                    _triadRow(
                      'Render Tree',
                      'RenderBox + '
                      'RenderObjectWithChildMixin',
                      'Paints pixels, computes layout',
                      _kGreen,
                      Icons.brush,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'The element is the long-lived glue — '
                      'widgets are rebuilt frequently, but '
                      'the element persists and reconciles '
                      'old vs new widgets.',
                      style: TextStyle(
                        color: _kDimText, fontSize: 10),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // createElement path
          _sectionTitle('Creation Path'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() =>
                _expandCreateElement = !_expandCreateElement),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader(
                      'How it gets created', _expandCreateElement),
                  if (_expandCreateElement) ...[
                    const SizedBox(height: 10),
                    _flowStep(1, 'Framework inflates widget',
                        'Parent element calls '
                        'inflateWidget(widget, slot)',
                        _kHighlight),
                    _flowArrow(),
                    _flowStep(2, 'widget.createElement()',
                        'SingleChildRenderObjectWidget '
                        'returns new '
                        'SingleChildRenderObjectElement(this)',
                        _kAccent),
                    _flowArrow(),
                    _flowStep(3, 'element.mount()',
                        'Element creates render object and '
                        'inflates widget.child',
                        _kGreen),
                    _flowArrow(),
                    _flowStep(4, 'Child inserted',
                        'insertRenderObjectChild sets '
                        'renderObject.child = childRO',
                        _kAmber),
                    const SizedBox(height: 8),
                    _codeBlock(
                      '// In SingleChildRenderObjectWidget:\n'
                      '@override\n'
                      'SingleChildRenderObjectElement\n'
                      '    createElement() =>\n'
                      '  SingleChildRenderObjectElement(\n'
                      '      this);',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // RenderObjectWithChildMixin
          _sectionTitle('RenderObjectWithChildMixin'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _cardDecor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'The render object MUST use this mixin:',
                  style: TextStyle(
                    color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _codeBlock(
                  'class RenderPadding\n'
                  '    extends RenderShiftedBox {\n'
                  '  // RenderShiftedBox mixes in\n'
                  '  // RenderObjectWithChildMixin<\n'
                  '  //     RenderBox>\n'
                  '  // Provides:\n'
                  '  //   RenderBox? get child\n'
                  '  //   set child(RenderBox? value)\n'
                  '}',
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _badge('required', _kWarning),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'insertRenderObjectChild casts to '
                        'RenderObjectWithChildMixin and '
                        'sets .child',
                        style: TextStyle(
                          color: _kDimText, fontSize: 9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'SingleChildRenderObjectElement is the most common '
            'element type — it backs Padding, Align, Center, '
            'SizedBox, Transform, Opacity, ClipRRect, and many '
            'more single-child layout widgets.',
          ),
        ],
      ),
    );
  }

  Widget _siblingRow(
      String name, String desc, Color color, bool active) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active
            ? color.withValues(alpha: 0.10)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: active
              ? color.withValues(alpha: 0.5)
              : _kSubtle,
        ),
      ),
      child: Row(
        children: [
          if (active)
            const Icon(Icons.arrow_right,
                size: 14, color: _kAccent)
          else
            const SizedBox(width: 14),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    )),
                Text(desc,
                    style: const TextStyle(
                      color: _kDimText, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _triadRow(String layer, String cls, String desc,
      Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(layer,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    )),
                Text(cls,
                    style: TextStyle(
                      color: color.withValues(alpha: 0.8),
                      fontSize: 9,
                      fontFamily: 'monospace',
                    )),
                Text(desc,
                    style: const TextStyle(
                      color: _kDimText, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _triadArrow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const SizedBox(width: 7),
          const Icon(Icons.arrow_downward,
              size: 10, color: _kDimText),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                color: _kDimText,
                fontSize: 8,
                fontFamily: 'monospace',
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Lifecycle
// ═══════════════════════════════════════════════════════════════════════════════

class _LifecycleTab extends StatefulWidget {
  const _LifecycleTab();
  @override
  State<_LifecycleTab> createState() => _LifecycleTabState();
}

class _LifecycleTabState extends State<_LifecycleTab>
    with AutomaticKeepAliveClientMixin {
  bool _expandMount = true;
  bool _expandUpdate = false;
  bool _expandUnmount = false;
  bool _expandSlots = false;
  int _selectedMethod = 0;

  static const _methods = [
    _MethodInfo(
      'visitChildren',
      'void visitChildren(ElementVisitor visitor)',
      'Calls visitor on _child if present. Used by '
      'the framework to walk the element tree.',
      'if (_child != null)\n'
      '  visitor(_child!);',
    ),
    _MethodInfo(
      'forgetChild',
      'void forgetChild(Element child)',
      'Nulls out _child reference. Called when child '
      'is being deactivated during a global key move.',
      'assert(child == _child);\n'
      '_child = null;\n'
      'super.forgetChild(child);',
    ),
    _MethodInfo(
      'insertRenderObjectChild',
      'void insertRenderObjectChild(\n'
      '    RenderObject child, Object? slot)',
      'Casts renderObject to '
      'RenderObjectWithChildMixin and sets its child.',
      'final ro = renderObject\n'
      '    as RenderObjectWith\n'
      '    ChildMixin;\n'
      'assert(slot == null);\n'
      'ro.child = child;',
    ),
    _MethodInfo(
      'moveRenderObjectChild',
      'void moveRenderObjectChild(\n'
      '    RO child, Object? old, Object? new)',
      'Always asserts false — a single child cannot '
      'move between slots because only one slot exists.',
      'assert(false);\n'
      '// Single child has\n'
      '// no concept of\n'
      '// slot ordering',
    ),
    _MethodInfo(
      'removeRenderObjectChild',
      'void removeRenderObjectChild(\n'
      '    RenderObject child, Object? slot)',
      'Sets renderObject.child = null to detach child '
      'render object from the render tree.',
      'final ro = renderObject\n'
      '    as RenderObjectWith\n'
      '    ChildMixin;\n'
      'assert(ro.child == child);\n'
      'ro.child = null;',
    ),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // mount
          _sectionTitle('mount()'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandMount = !_expandMount),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader(
                      'Element enters the tree', _expandMount),
                  if (_expandMount) ...[
                    const SizedBox(height: 10),
                    _flowStep(1, 'super.mount()',
                        'Calls RenderObjectElement.mount — '
                        'creates the render object via '
                        'widget.createRenderObject()',
                        _kHighlight),
                    _flowArrow(),
                    _flowStep(2, 'Inflate child',
                        '_child = updateChild(\n'
                        '  _child, widget.child, null)',
                        _kAccent),
                    _flowArrow(),
                    _flowStep(3, 'Render object linked',
                        'insertRenderObjectChild sets '
                        'renderObject.child to the child\'s '
                        'render object',
                        _kGreen),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _kAmber.withValues(alpha: 0.06),
                        borderRadius:
                            BorderRadius.circular(4),
                        border: Border.all(
                          color:
                              _kAmber.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              size: 12, color: _kAmber),
                          const SizedBox(width: 6),
                          const Expanded(
                            child: Text(
                              'The slot argument is always '
                              'null for single-child elements '
                              '— there is no ordering concept.',
                              style: TextStyle(
                                color: _kDimText,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // update
          _sectionTitle('update()'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandUpdate = !_expandUpdate),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader(
                      'Widget configuration changes',
                      _expandUpdate),
                  if (_expandUpdate) ...[
                    const SizedBox(height: 10),
                    _flowStep(1, 'super.update(newWidget)',
                        'Stores new widget, calls '
                        'updateRenderObject to push '
                        'config changes to render obj',
                        _kHighlight),
                    _flowArrow(),
                    _flowStep(2, 'Reconcile child',
                        '_child = updateChild(\n'
                        '  _child, widget.child, null)\n'
                        'Framework decides: reuse, replace, '
                        'or remove',
                        _kAccent),
                    const SizedBox(height: 10),
                    const Text(
                      'updateChild outcomes:',
                      style: TextStyle(
                        color: _kCyan,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _updateChildRow(
                      'Same type + same key',
                      'Reuse element, call update()',
                      _kGreen,
                    ),
                    _updateChildRow(
                      'Different type or key',
                      'Deactivate old, inflate new',
                      _kAmber,
                    ),
                    _updateChildRow(
                      'New child is null',
                      'Deactivate + remove old child',
                      _kWarning,
                    ),
                    _updateChildRow(
                      'Old child was null',
                      'Inflate brand new child',
                      _kHighlight,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // unmount
          _sectionTitle('unmount()'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandUnmount = !_expandUnmount),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader('Element leaves tree',
                      _expandUnmount),
                  if (_expandUnmount) ...[
                    const SizedBox(height: 10),
                    _flowStep(1, 'Deactivate',
                        'Element marked inactive; child '
                        'deactivated recursively',
                        _kWarning),
                    _flowArrow(),
                    _flowStep(2, 'Unmount',
                        'Render object detached from tree '
                        'via removeRenderObjectChild',
                        _kAccent),
                    _flowArrow(),
                    _flowStep(3, 'Dispose',
                        'super.unmount() releases render '
                        'object; _child already null',
                        _kDimText),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Key methods
          _sectionTitle('Key Methods'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _cardDecor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: List.generate(
                      _methods.length, (i) {
                    final m = _methods[i];
                    final sel = _selectedMethod == i;
                    return GestureDetector(
                      onTap: () => setState(
                          () => _selectedMethod = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: sel
                              ? _kPrimary
                                  .withValues(alpha: 0.3)
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(12),
                          border: Border.all(
                            color: sel
                                ? _kAccent
                                : _kSubtle,
                          ),
                        ),
                        child: Text(m.name,
                            style: TextStyle(
                              color: sel
                                  ? _kAccent
                                  : _kDimText,
                              fontSize: 9,
                              fontWeight: sel
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              fontFamily: 'monospace',
                            )),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _methods[_selectedMethod].signature,
                    style: const TextStyle(
                      color: _kCyan,
                      fontSize: 9,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _methods[_selectedMethod].description,
                  style: const TextStyle(
                    color: _kDimText, fontSize: 10),
                ),
                const SizedBox(height: 6),
                _codeBlock(
                    _methods[_selectedMethod].code),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Slot semantics
          _sectionTitle('Slot Semantics'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandSlots = !_expandSlots),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader(
                      'Why slot is always null',
                      _expandSlots),
                  if (_expandSlots) ...[
                    const SizedBox(height: 8),
                    const Text(
                      'Slots identify a child\'s position '
                      'within a parent. Multi-child elements '
                      'use slots to position each child. '
                      'But a single-child element has only '
                      'one position — so the slot is always '
                      'null.',
                      style: TextStyle(
                        color: _kDimText, fontSize: 10),
                    ),
                    const SizedBox(height: 8),
                    _compRow(
                      'SingleChild',
                      'slot = null (always)',
                      _kAccent,
                    ),
                    const SizedBox(height: 4),
                    _compRow(
                      'MultiChild',
                      'slot = IndexedSlot(index, previous)',
                      _kHighlight,
                    ),
                    const SizedBox(height: 4),
                    _compRow(
                      'Leaf',
                      'No children, no slots',
                      _kGreen,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'The lifecycle methods (mount, update, unmount) '
            'are identical in structure to other element types, '
            'but simplified: only one child to reconcile, only '
            'one render object child to insert or remove.',
          ),
        ],
      ),
    );
  }

  Widget _updateChildRow(
      String condition, String outcome, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$condition → ',
                    style: TextStyle(
                      color: color,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: outcome,
                    style: const TextStyle(
                      color: _kDimText, fontSize: 9),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _compRow(String label, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(label,
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 9,
                  fontFamily: 'monospace',
                )),
          ),
        ],
      ),
    );
  }
}

class _MethodInfo {
  final String name;
  final String signature;
  final String description;
  final String code;
  const _MethodInfo(
      this.name, this.signature, this.description, this.code);
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Examples
// ═══════════════════════════════════════════════════════════════════════════════

class _ExamplesTab extends StatefulWidget {
  const _ExamplesTab();
  @override
  State<_ExamplesTab> createState() => _ExamplesTabState();
}

class _ExamplesTabState extends State<_ExamplesTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedWidget = 0;
  double _paddingVal = 16;
  double _opacityVal = 1.0;
  double _rotation = 0;
  double _alignX = 0;
  double _alignY = 0;
  double _borderRadius = 12;

  @override
  bool get wantKeepAlive => true;

  static const _widgets = [
    'Padding',
    'Align',
    'Opacity',
    'Transform',
    'ClipRRect',
    'SizedBox',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Live Subclass Gallery'),
          const SizedBox(height: 4),
          const Text(
            'Each widget below is a '
            'SingleChildRenderObjectWidget. Select one to '
            'see it in action with interactive controls.',
            style: TextStyle(color: _kDimText, fontSize: 10),
          ),
          const SizedBox(height: 10),

          // Widget selector
          Container(
            padding: const EdgeInsets.all(10),
            decoration: _cardDecor(),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: List.generate(
                  _widgets.length, (i) {
                final sel = _selectedWidget == i;
                return GestureDetector(
                  onTap: () => setState(
                      () => _selectedWidget = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: sel
                          ? _kPrimary
                              .withValues(alpha: 0.3)
                          : Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(14),
                      border: Border.all(
                        color: sel
                            ? _kAccent
                            : _kSubtle,
                      ),
                    ),
                    child: Text(_widgets[i],
                        style: TextStyle(
                          color: sel
                              ? _kAccent
                              : _kDimText,
                          fontSize: 11,
                          fontWeight: sel
                              ? FontWeight.w700
                              : FontWeight.w400,
                        )),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),

          // Preview + controls
          _buildPreview(),
          const SizedBox(height: 12),

          // Element tree visualization
          _sectionTitle('Element Tree View'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _cardDecor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _treeNode('Scaffold', _kDimText, 0),
                _treeNode('Column', _kDimText, 1),
                _treeNode(_widgets[_selectedWidget],
                    _kAccent, 2),
                _treeNode(
                    'SingleChildRender'
                    'ObjectElement',
                    _kAccent,
                    3),
                _treeNode('child → Container',
                    _kHighlight, 4),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '// The widget creates the element:\n'
                    'Padding.createElement()\n'
                    '  → SingleChildRenderObjectElement\n'
                    '\n'
                    '// The element creates the render:\n'
                    'Padding.createRenderObject()\n'
                    '  → RenderPadding',
                    style: TextStyle(
                      color: _kCyan,
                      fontSize: 9,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Common subclasses table
          _sectionTitle('Common Subclasses'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _cardDecor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _subclassRow('Padding', 'RenderPadding',
                    'Insets around child', _kAccent),
                _subclassRow('Align / Center',
                    'RenderPositionedBox',
                    'Positions child within parent',
                    _kHighlight),
                _subclassRow('SizedBox',
                    'RenderConstrainedBox',
                    'Imposes size constraints',
                    _kGreen),
                _subclassRow('Transform',
                    'RenderTransform',
                    'Matrix4 transformation',
                    _kAmber),
                _subclassRow('Opacity',
                    'RenderOpacity',
                    'Alpha transparency',
                    _kPurple),
                _subclassRow('ClipRRect',
                    'RenderClipRRect',
                    'Rounded rectangle clip',
                    _kCyan),
                _subclassRow('DecoratedBox',
                    'RenderDecoratedBox',
                    'Paints decoration behind/in front',
                    _kWarning),
                _subclassRow(
                    'FractionallySizedBox',
                    'RenderFractionallySizedOverflowBox',
                    'Sizes child as fraction of parent',
                    _kDimText),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'Every widget listed above creates a '
            'SingleChildRenderObjectElement when '
            'inflated. The element manages one child: '
            'your content widget. Different render objects '
            'implement different layout/painting behaviors.',
          ),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _kAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_widgets[_selectedWidget]} — Live Preview',
            style: const TextStyle(
              color: _kAccent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          // Render area
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _kSubtle),
            ),
            child: _buildSelectedWidget(),
          ),
          const SizedBox(height: 10),
          // Controls
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildSelectedWidget() {
    final child = Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kAccent],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Text('child',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            )),
      ),
    );

    switch (_selectedWidget) {
      case 0: // Padding
        return Center(
          child: Container(
            color: _kPrimary.withValues(alpha: 0.15),
            child: Padding(
              padding: EdgeInsets.all(_paddingVal),
              child: child,
            ),
          ),
        );
      case 1: // Align
        return Align(
          alignment: Alignment(_alignX, _alignY),
          child: child,
        );
      case 2: // Opacity
        return Center(
          child: Opacity(
            opacity: _opacityVal,
            child: child,
          ),
        );
      case 3: // Transform
        return Center(
          child: Transform.rotate(
            angle: _rotation * 3.14159 / 180,
            child: child,
          ),
        );
      case 4: // ClipRRect
        return Center(
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(_borderRadius),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_kPrimary, _kAccent],
                ),
              ),
              child: const Center(
                child: Text('clipped',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
          ),
        );
      case 5: // SizedBox
        return Center(
          child: SizedBox(
            width: 40 + _paddingVal * 2,
            height: 40 + _paddingVal * 2,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_kPrimary, _kAccent],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text('sized',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
          ),
        );
      default:
        return child;
    }
  }

  Widget _buildControls() {
    switch (_selectedWidget) {
      case 0: // Padding
        return _sliderRow('Padding', _paddingVal, 0, 40,
            (v) => setState(() => _paddingVal = v));
      case 1: // Align
        return Column(
          children: [
            _sliderRow('alignX', _alignX, -1, 1,
                (v) => setState(() => _alignX = v)),
            _sliderRow('alignY', _alignY, -1, 1,
                (v) => setState(() => _alignY = v)),
          ],
        );
      case 2: // Opacity
        return _sliderRow('Opacity', _opacityVal, 0, 1,
            (v) => setState(() => _opacityVal = v));
      case 3: // Transform
        return _sliderRow('Rotation°', _rotation, 0, 360,
            (v) => setState(() => _rotation = v));
      case 4: // ClipRRect
        return _sliderRow('Radius', _borderRadius, 0, 40,
            (v) => setState(() => _borderRadius = v));
      case 5: // SizedBox
        return _sliderRow('Size', _paddingVal, 0, 40,
            (v) => setState(() => _paddingVal = v));
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _sliderRow(String label, double value,
      double min, double max, ValueChanged<double> cb) {
    return Row(
      children: [
        SizedBox(
          width: 65,
          child: Text('$label:',
              style: const TextStyle(
                color: _kDimText, fontSize: 10)),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            activeColor: _kAccent,
            onChanged: cb,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            value.toStringAsFixed(1),
            style: const TextStyle(
              color: _kAccent,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }

  Widget _treeNode(String name, Color color, int depth) {
    return Padding(
      padding: EdgeInsets.only(
          left: depth * 16.0, top: 2, bottom: 2),
      child: Row(
        children: [
          if (depth > 0)
            Text(
              '└ ',
              style: TextStyle(
                color: color.withValues(alpha: 0.4),
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(name,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontFamily: 'monospace',
              )),
        ],
      ),
    );
  }

  Widget _subclassRow(
      String widget, String render, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 90,
            child: Text(widget,
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                )),
          ),
          SizedBox(
            width: 100,
            child: Text(render,
                style: const TextStyle(
                  color: _kCyan,
                  fontSize: 8,
                  fontFamily: 'monospace',
                )),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                  color: _kDimText, fontSize: 8)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

BoxDecoration _cardDecor() {
  return BoxDecoration(
    color: _kCard,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: _kSubtle),
  );
}

Widget _sectionTitle(String title) {
  return Text(title,
      style: const TextStyle(
        color: _kAccent,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ));
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(code,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 10,
          fontFamily: 'monospace',
        )),
  );
}

Widget _infoBanner(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    color: _kPrimary.withValues(alpha: 0.12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline,
            size: 14, color: _kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                color: _kDimText, fontSize: 11)),
        ),
      ],
    ),
  );
}

Widget _badge(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
          color: color.withValues(alpha: 0.4)),
    ),
    child: Text(label,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.w600,
        )),
  );
}

Widget _expandHeader(String text, bool expanded) {
  return Row(
    children: [
      Expanded(
        child: Text(text,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            )),
      ),
      Icon(
        expanded ? Icons.expand_less : Icons.expand_more,
        size: 18,
        color: _kDimText,
      ),
    ],
  );
}

Widget _flowStep(
    int step, String title, String desc, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
          color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(
                color: color.withValues(alpha: 0.5)),
          ),
          child: Center(
            child: Text('$step',
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  )),
              Text(desc,
                  style: const TextStyle(
                    color: _kDimText, fontSize: 9)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flowArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 8),
    child: Icon(Icons.arrow_downward,
        size: 12, color: _kDimText),
  );
}

Widget _hierarchyNode(
    String name, Color color, String desc, int depth) {
  return Container(
    margin: EdgeInsets.only(left: depth * 12.0),
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
          color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  )),
              Text(desc,
                  style: const TextStyle(
                    color: _kDimText, fontSize: 8)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _hierarchyArrow() {
  return const Padding(
    padding: EdgeInsets.only(left: 2),
    child: Icon(Icons.arrow_downward,
        size: 10, color: _kDimText),
  );
}
