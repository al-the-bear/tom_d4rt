// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for SingleChildRenderObjectWidget.
///
/// SingleChildRenderObjectWidget is the abstract base class for
/// widgets that have exactly one child and create a RenderObject.
/// Nearly all layout wrappers (Padding, Align, Opacity, etc.)
/// extend this class.
///
/// Demonstrates:
/// - Tab 1 (Contract): Class hierarchy, const constructor, child
///   property, createElement/createRenderObject contract
/// - Tab 2 (Subclasses): Interactive gallery of 8 concrete
///   subclasses with live renders
/// - Tab 3 (Custom Widget): Step-by-step creating a custom
///   SingleChildRenderObjectWidget with live demo

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF2E7D32); // Green 800
const Color _kAccent = Color(0xFFFF6E40); // DeepOrange A100
const Color _kSurface = Color(0xFF0D140E);
const Color _kCard = Color(0xFF1A241C);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF2A3A2C);
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
    home: const _SCROWDemo(),
  );
}

class _SCROWDemo extends StatefulWidget {
  const _SCROWDemo();
  @override
  State<_SCROWDemo> createState() => _SCROWDemoState();
}

class _SCROWDemoState extends State<_SCROWDemo>
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
          'SingleChildRenderObjectWidget',
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
            Tab(text: 'Contract'),
            Tab(text: 'Subclasses'),
            Tab(text: 'Custom Widget'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _ContractTab(),
          _SubclassesTab(),
          _CustomWidgetTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Contract
// ═══════════════════════════════════════════════════════════════════════════════

class _ContractTab extends StatefulWidget {
  const _ContractTab();
  @override
  State<_ContractTab> createState() => _ContractTabState();
}

class _ContractTabState extends State<_ContractTab>
    with AutomaticKeepAliveClientMixin {
  bool _expandHierarchy = true;
  bool _expandConstructor = false;
  bool _expandMethods = false;
  bool _expandComparison = false;

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
          // Class hierarchy
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
                  _expandHeader('Widget inheritance chain',
                      _expandHierarchy),
                  if (_expandHierarchy) ...[
                    const SizedBox(height: 10),
                    _hierarchyNode(
                        'Widget', _kDimText,
                        'Immutable configuration', 0),
                    _hierarchyArrow(),
                    _hierarchyNode(
                        'RenderObjectWidget', _kHighlight,
                        'Creates/updates a RenderObject', 0),
                    _hierarchyArrow(),
                    _hierarchyNode(
                        'SingleChildRenderObjectWidget',
                        _kAccent,
                        'Has optional single child', 0),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _badge('abstract', _kAmber),
                        const SizedBox(width: 6),
                        _badge('const', _kCyan),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'Cannot be instantiated directly; '
                            'but subclasses can be const',
                            style: TextStyle(
                              color: _kDimText, fontSize: 9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Constructor & child
          _sectionTitle('Constructor & Child'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() =>
                _expandConstructor = !_expandConstructor),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader(
                      'const SingleChildRenderObject'
                      'Widget({key, child})',
                      _expandConstructor),
                  if (_expandConstructor) ...[
                    const SizedBox(height: 10),
                    _codeBlock(
                      'abstract class\n'
                      '    SingleChildRenderObjectWidget\n'
                      '    extends RenderObjectWidget {\n'
                      '  const SingleChildRender\n'
                      '      ObjectWidget({\n'
                      '    super.key,\n'
                      '    this.child,\n'
                      '  });\n'
                      '\n'
                      '  final Widget? child;\n'
                      '}',
                    ),
                    const SizedBox(height: 8),
                    _paramRow('key', 'Key?',
                        'Widget identity for reconciliation',
                        _kAmber),
                    _paramRow('child', 'Widget?',
                        'The optional single child widget',
                        _kAccent),
                    const SizedBox(height: 8),
                    const Text(
                      'The child is optional: an Opacity can '
                      'wrap a child, but a SizedBox.shrink() '
                      'has no child at all.',
                      style: TextStyle(
                        color: _kDimText, fontSize: 10),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Required overrides
          _sectionTitle('Required Overrides'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
                () => _expandMethods = !_expandMethods),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader(
                      'Methods subclasses must implement',
                      _expandMethods),
                  if (_expandMethods) ...[
                    const SizedBox(height: 10),
                    _methodCard(
                      'createRenderObject',
                      'RenderObject createRenderObject(\n'
                      '    BuildContext context)',
                      'Called once when widget is first mounted. '
                      'Returns a new render object that will be '
                      'managed by the element.',
                      _kGreen,
                      true,
                    ),
                    const SizedBox(height: 6),
                    _methodCard(
                      'updateRenderObject',
                      'void updateRenderObject(\n'
                      '    BuildContext context,\n'
                      '    covariant RenderObject\n'
                      '        renderObject)',
                      'Called when widget rebuilds. Updates the '
                      'existing render object with new property '
                      'values from the widget.',
                      _kHighlight,
                      true,
                    ),
                    const SizedBox(height: 6),
                    _methodCard(
                      'createElement',
                      'SingleChildRenderObject\n'
                      '    Element createElement()',
                      'Automatically returns a new '
                      'SingleChildRenderObjectElement. '
                      'Rarely overridden.',
                      _kDimText,
                      false,
                    ),
                    const SizedBox(height: 6),
                    _methodCard(
                      'didUnmountRenderObject',
                      'void didUnmountRenderObject(\n'
                      '    covariant RenderObject\n'
                      '        renderObject)',
                      'Cleanup callback when render object '
                      'is removed. Release resources here.',
                      _kPurple,
                      false,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Comparison with siblings
          _sectionTitle('Widget Family'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() =>
                _expandComparison = !_expandComparison),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader(
                      'RenderObjectWidget subclasses',
                      _expandComparison),
                  if (_expandComparison) ...[
                    const SizedBox(height: 8),
                    _familyRow(
                      'LeafRenderObjectWidget',
                      '0 children',
                      'ErrorWidget, RawImage, Texture',
                      _kGreen,
                    ),
                    const SizedBox(height: 4),
                    _familyRow(
                      'SingleChildRenderObjectWidget',
                      '0 or 1 child',
                      'Padding, Align, Opacity, Transform',
                      _kAccent,
                    ),
                    const SizedBox(height: 4),
                    _familyRow(
                      'MultiChildRenderObjectWidget',
                      '0+ children',
                      'Row, Column, Stack, Wrap, Flow',
                      _kHighlight,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.arrow_right,
                            size: 14, color: _kAccent),
                        const SizedBox(width: 4),
                        const Expanded(
                          child: Text(
                            'SingleChild is highlighted — '
                            'this is the most commonly used '
                            'variant, backing nearly all layout '
                            'wrappers in Flutter.',
                            style: TextStyle(
                              color: _kDimText, fontSize: 9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'SingleChildRenderObjectWidget is the bridge between '
            'your widget configuration and the render tree. It '
            'turns declarative widget properties into imperative '
            'render object mutations.',
          ),
        ],
      ),
    );
  }

  Widget _methodCard(String name, String sig, String desc,
      Color color, bool required) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  )),
              const Spacer(),
              if (required)
                _badge('required', _kWarning)
              else
                _badge('optional', _kDimText),
            ],
          ),
          const SizedBox(height: 4),
          Text(sig,
              style: TextStyle(
                color: color.withValues(alpha: 0.7),
                fontSize: 8,
                fontFamily: 'monospace',
              )),
          const SizedBox(height: 4),
          Text(desc,
              style: const TextStyle(
                color: _kDimText, fontSize: 9)),
        ],
      ),
    );
  }

  Widget _familyRow(
      String name, String children, String examples,
      Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: color.withValues(alpha: 0.2)),
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
                Row(
                  children: [
                    Text(name,
                        style: TextStyle(
                          color: color,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        )),
                    const Spacer(),
                    Text(children,
                        style: TextStyle(
                          color: color.withValues(alpha: 0.7),
                          fontSize: 8,
                        )),
                  ],
                ),
                Text(examples,
                    style: const TextStyle(
                      color: _kDimText, fontSize: 8)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paramRow(
      String name, String type, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(name,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                )),
          ),
          SizedBox(
            width: 60,
            child: Text(type,
                style: const TextStyle(
                  color: _kHighlight,
                  fontSize: 9,
                  fontFamily: 'monospace',
                )),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                  color: _kDimText, fontSize: 9)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Subclasses
// ═══════════════════════════════════════════════════════════════════════════════

class _SubclassesTab extends StatefulWidget {
  const _SubclassesTab();
  @override
  State<_SubclassesTab> createState() =>
      _SubclassesTabState();
}

class _SubclassesTabState extends State<_SubclassesTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  static const _entries = [
    _SubclassEntry(
      'Padding',
      'Adds empty space around the child',
      'RenderPadding',
      'Padding(\n'
      '  padding:\n'
      '      EdgeInsets.all(16),\n'
      '  child: child,\n'
      ')',
    ),
    _SubclassEntry(
      'Align',
      'Positions child within available space',
      'RenderPositionedBox',
      'Align(\n'
      '  alignment:\n'
      '      Alignment.topRight,\n'
      '  child: child,\n'
      ')',
    ),
    _SubclassEntry(
      'Opacity',
      'Makes child semi-transparent',
      'RenderOpacity',
      'Opacity(\n'
      '  opacity: 0.5,\n'
      '  child: child,\n'
      ')',
    ),
    _SubclassEntry(
      'Transform',
      'Applies a matrix transformation',
      'RenderTransform',
      'Transform.rotate(\n'
      '  angle: 0.3,\n'
      '  child: child,\n'
      ')',
    ),
    _SubclassEntry(
      'ClipRRect',
      'Clips child with rounded rectangle',
      'RenderClipRRect',
      'ClipRRect(\n'
      '  borderRadius:\n'
      '    BorderRadius.circular(20),\n'
      '  child: child,\n'
      ')',
    ),
    _SubclassEntry(
      'SizedBox',
      'Imposes tight size constraints',
      'RenderConstrainedBox',
      'SizedBox(\n'
      '  width: 100,\n'
      '  height: 50,\n'
      '  child: child,\n'
      ')',
    ),
    _SubclassEntry(
      'DecoratedBox',
      'Paints decoration behind/in front',
      'RenderDecoratedBox',
      'DecoratedBox(\n'
      '  decoration: BoxDecoration(\n'
      '    gradient: gradient,\n'
      '  ),\n'
      '  child: child,\n'
      ')',
    ),
    _SubclassEntry(
      'ColoredBox',
      'Fills background with solid color',
      'RenderColoredBox',
      'ColoredBox(\n'
      '  color: Colors.blue,\n'
      '  child: child,\n'
      ')',
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
          _sectionTitle('Concrete Subclasses'),
          const SizedBox(height: 4),
          const Text(
            'Select a subclass to see its live rendering, '
            'constructor code, and render object type.',
            style: TextStyle(color: _kDimText, fontSize: 10),
          ),
          const SizedBox(height: 10),

          // Selector
          Container(
            padding: const EdgeInsets.all(10),
            decoration: _cardDecor(),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: List.generate(
                  _entries.length, (i) {
                final sel = _selected == i;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selected = i),
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
                    child: Text(_entries[i].name,
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

          // Live preview
          Container(
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
                Row(
                  children: [
                    Text(
                      _entries[_selected].name,
                      style: const TextStyle(
                        color: _kAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    _badge(
                        _entries[_selected].renderType,
                        _kCyan),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _entries[_selected].description,
                  style: const TextStyle(
                    color: _kDimText, fontSize: 10),
                ),
                const SizedBox(height: 10),

                // Visual
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _kSubtle),
                  ),
                  child: _buildPreview(_selected),
                ),
                const SizedBox(height: 8),

                // Code
                _codeBlock(_entries[_selected].code),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // All subclasses reference table
          _sectionTitle('Quick Reference'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _cardDecor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text('Widget',
                          style: TextStyle(
                            color: _kAccent.withValues(
                                alpha: 0.7),
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    SizedBox(
                      width: 85,
                      child: Text('RenderObject',
                          style: TextStyle(
                            color: _kCyan.withValues(
                                alpha: 0.7),
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    const Expanded(
                      child: Text('Purpose',
                          style: TextStyle(
                            color: _kDimText,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ],
                ),
                const Divider(
                    color: _kSubtle, height: 12),
                ...List.generate(_entries.length, (i) {
                  final e = _entries[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: Text(e.name,
                              style: const TextStyle(
                                color: _kAccent,
                                fontSize: 9,
                                fontFamily: 'monospace',
                              )),
                        ),
                        SizedBox(
                          width: 85,
                          child: Text(e.renderType,
                              style: const TextStyle(
                                color: _kCyan,
                                fontSize: 8,
                                fontFamily: 'monospace',
                              )),
                        ),
                        Expanded(
                          child: Text(e.description,
                              style: const TextStyle(
                                color: _kDimText,
                                fontSize: 8,
                              )),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'All these widgets share the same element type: '
            'SingleChildRenderObjectElement. The element is '
            'generic — the specialization lives in the render '
            'object.',
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(int index) {
    final childBox = Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kAccent],
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text('child',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            )),
      ),
    );

    switch (index) {
      case 0: // Padding
        return Center(
          child: Container(
            color: _kPrimary.withValues(alpha: 0.15),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: childBox,
            ),
          ),
        );
      case 1: // Align
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: childBox,
          ),
        );
      case 2: // Opacity
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Opacity(opacity: 1.0, child: childBox),
              const SizedBox(width: 8),
              Opacity(opacity: 0.6, child: childBox),
              const SizedBox(width: 8),
              Opacity(opacity: 0.2, child: childBox),
            ],
          ),
        );
      case 3: // Transform
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.rotate(
                  angle: 0, child: childBox),
              const SizedBox(width: 16),
              Transform.rotate(
                  angle: 0.3, child: childBox),
              const SizedBox(width: 16),
              Transform.rotate(
                  angle: 0.8, child: childBox),
            ],
          ),
        );
      case 4: // ClipRRect
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Container(width: 50, height: 50,
                    color: _kAccent),
              ),
              const SizedBox(width: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(width: 50, height: 50,
                    color: _kAccent),
              ),
              const SizedBox(width: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(width: 50, height: 50,
                    color: _kAccent),
              ),
            ],
          ),
        );
      case 5: // SizedBox
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Container(color: _kAccent),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 60,
                height: 40,
                child: Container(color: _kAccent),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                height: 60,
                child: Container(color: _kAccent),
              ),
            ],
          ),
        );
      case 6: // DecoratedBox
        return Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _kPrimary,
                  _kAccent,
                  _kPurple,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const SizedBox(
              width: 120,
              height: 60,
              child: Center(
                child: Text('decorated',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
          ),
        );
      case 7: // ColoredBox
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ColoredBox(
                color: _kAccent,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text('A',
                        style: TextStyle(
                          color: _kSurface,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ColoredBox(
                color: _kGreen,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text('B',
                        style: TextStyle(
                          color: _kSurface,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ColoredBox(
                color: _kHighlight,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text('C',
                        style: TextStyle(
                          color: _kSurface,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return childBox;
    }
  }
}

class _SubclassEntry {
  final String name;
  final String description;
  final String renderType;
  final String code;
  const _SubclassEntry(
      this.name, this.description, this.renderType, this.code);
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Custom Widget
// ═══════════════════════════════════════════════════════════════════════════════

class _CustomWidgetTab extends StatefulWidget {
  const _CustomWidgetTab();
  @override
  State<_CustomWidgetTab> createState() =>
      _CustomWidgetTabState();
}

class _CustomWidgetTabState extends State<_CustomWidgetTab>
    with AutomaticKeepAliveClientMixin {
  bool _expandSteps = true;
  double _tintOpacity = 0.3;
  int _tintColorIdx = 0;

  static const _tintColors = [
    _kAccent,
    _kHighlight,
    _kGreen,
    _kAmber,
    _kPurple,
  ];
  static const _tintLabels = [
    'Orange',
    'Blue',
    'Green',
    'Amber',
    'Purple',
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
          _sectionTitle('Building a Custom Widget'),
          const SizedBox(height: 4),
          const Text(
            'Step-by-step: creating TintOverlay, a custom '
            'SingleChildRenderObjectWidget that paints a '
            'colored overlay on top of its child.',
            style: TextStyle(color: _kDimText, fontSize: 10),
          ),
          const SizedBox(height: 12),

          // Steps
          GestureDetector(
            onTap: () => setState(
                () => _expandSteps = !_expandSteps),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _cardDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _expandHeader(
                      'Implementation Steps', _expandSteps),
                  if (_expandSteps) ...[
                    const SizedBox(height: 10),
                    _stepCard(
                      1,
                      'Extend '
                      'SingleChildRenderObjectWidget',
                      'class TintOverlay extends\n'
                      '    SingleChildRenderObject\n'
                      '    Widget {\n'
                      '  const TintOverlay({\n'
                      '    super.key,\n'
                      '    super.child,\n'
                      '    required this.color,\n'
                      '    this.opacity = 0.3,\n'
                      '  });\n'
                      '  final Color color;\n'
                      '  final double opacity;\n'
                      '}',
                      _kGreen,
                    ),
                    const SizedBox(height: 8),
                    _stepCard(
                      2,
                      'Create the RenderObject',
                      '@override\n'
                      'RenderObject\n'
                      '    createRenderObject(\n'
                      '    BuildContext context) =>\n'
                      '  _RenderTintOverlay(\n'
                      '    color: color,\n'
                      '    tintOpacity: opacity,\n'
                      '  );',
                      _kHighlight,
                    ),
                    const SizedBox(height: 8),
                    _stepCard(
                      3,
                      'Update the RenderObject',
                      '@override\n'
                      'void updateRenderObject(\n'
                      '    BuildContext context,\n'
                      '    _RenderTintOverlay ro) {\n'
                      '  ro\n'
                      '    ..color = color\n'
                      '    ..tintOpacity = opacity;\n'
                      '}',
                      _kAmber,
                    ),
                    const SizedBox(height: 8),
                    _stepCard(
                      4,
                      'Implement the '
                      'RenderProxyBox',
                      'class _RenderTintOverlay\n'
                      '    extends RenderProxyBox {\n'
                      '  Color _color;\n'
                      '  double _opacity;\n'
                      '  // Setters call\n'
                      '  // markNeedsPaint()\n'
                      '  @override\n'
                      '  void paint(context, offset){\n'
                      '    // Paint child first\n'
                      '    // Then paint tint\n'
                      '  }\n'
                      '}',
                      _kPurple,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Live custom widget demo
          _sectionTitle('Live TintOverlay Demo'),
          const SizedBox(height: 8),
          Container(
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
                // Tint color selector
                const Text('Tint Color:',
                    style: TextStyle(
                      color: _kDimText, fontSize: 10)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: List.generate(
                      _tintColors.length, (i) {
                    final sel = _tintColorIdx == i;
                    return GestureDetector(
                      onTap: () => setState(
                          () => _tintColorIdx = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: sel
                              ? _tintColors[i]
                                  .withValues(alpha: 0.2)
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(12),
                          border: Border.all(
                            color: sel
                                ? _tintColors[i]
                                : _kSubtle,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _tintColors[i],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(_tintLabels[i],
                                style: TextStyle(
                                  color: sel
                                      ? _tintColors[i]
                                      : _kDimText,
                                  fontSize: 10,
                                )),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),

                // Opacity slider
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                      child: Text('Opacity:',
                          style: TextStyle(
                            color: _kDimText, fontSize: 10)),
                    ),
                    Expanded(
                      child: Slider(
                        value: _tintOpacity,
                        min: 0,
                        max: 1,
                        activeColor: _kAccent,
                        onChanged: (v) => setState(
                            () => _tintOpacity = v),
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      child: Text(
                        _tintOpacity.toStringAsFixed(2),
                        style: const TextStyle(
                          color: _kAccent,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Preview (simulated tint overlay)
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _kSubtle),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Stack(
                      children: [
                        // "Child" content
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _kPrimary,
                                _kHighlight,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Icon(Icons.image,
                                    size: 30,
                                    color: Colors.white70),
                                Text('Child Content',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        // Tint overlay
                        Container(
                          color: _tintColors[_tintColorIdx]
                              .withValues(
                                  alpha: _tintOpacity),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'TintOverlay(\n'
                  '  color: ${_tintLabels[_tintColorIdx]},\n'
                  '  opacity: ${_tintOpacity.toStringAsFixed(2)},\n'
                  '  child: content,\n'
                  ')',
                  style: const TextStyle(
                    color: _kAccent,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Key design points
          _sectionTitle('Key Design Points'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _cardDecor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _designPoint(
                  'RenderObjectWithChildMixin',
                  'Your render object MUST mix in '
                  'RenderObjectWithChildMixin to expose '
                  'the .child property for the element.',
                  _kHighlight,
                ),
                const SizedBox(height: 6),
                _designPoint(
                  'RenderProxyBox',
                  'For typical single-child wrappers, extend '
                  'RenderProxyBox — it already mixes in '
                  'the child mixin and forwards layout.',
                  _kGreen,
                ),
                const SizedBox(height: 6),
                _designPoint(
                  'markNeedsPaint / markNeedsLayout',
                  'Setters that change visual properties must '
                  'call markNeedsPaint(). Setters changing '
                  'layout must call markNeedsLayout().',
                  _kAmber,
                ),
                const SizedBox(height: 6),
                _designPoint(
                  'Const constructor',
                  'If all fields are final and parameters '
                  'allow it, make the constructor const for '
                  'widget identity optimization.',
                  _kCyan,
                ),
                const SizedBox(height: 6),
                _designPoint(
                  'updateRenderObject',
                  'Must update ALL properties — the framework '
                  'reuses the same render object when the '
                  'widget type matches.',
                  _kWarning,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _infoBanner(
            'Custom SingleChildRenderObjectWidgets are ideal for '
            'effects (tints, shadows, clips), layout modifications '
            '(custom padding, fractional sizing), and painting '
            'overlays that need direct render-tree access.',
          ),
        ],
      ),
    );
  }

  Widget _stepCard(
      int num, String title, String code, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(alpha: 0.5)),
                ),
                child: Center(
                  child: Text('$num',
                      style: TextStyle(
                        color: color,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(title,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _codeBlock(code),
        ],
      ),
    );
  }

  Widget _designPoint(
      String title, String desc, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 5,
          height: 5,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
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
                    fontWeight: FontWeight.w600,
                  )),
              Text(desc,
                  style: const TextStyle(
                    color: _kDimText, fontSize: 9)),
            ],
          ),
        ),
      ],
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


