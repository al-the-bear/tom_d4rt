// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for SelectionContainerDelegate.
///
/// SelectionContainerDelegate is an abstract class that handles SelectionEvents
/// for a SelectionContainer. Implements SelectionHandler + SelectionRegistrar.
///
/// Demonstrates:
/// - Tab 1 (Interfaces): SelectionHandler + SelectionRegistrar breakdown,
///   abstract method signatures, value/geometry, push handle layers
/// - Tab 2 (Coordinate Transforms): getTransformTo/getTransformFrom
///   visualization, RenderBox coordinate mapping, hasSize checks
/// - Tab 3 (Implementation): Custom delegate pattern, event dispatch,
///   StaticSelectionContainerDelegate, SelectionContainer widget

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFFFF8F00); // Amber 800
const Color _kAccent = Color(0xFFCCFF90); // LightGreen A100
const Color _kSurface = Color(0xFF1C1C18);
const Color _kCard = Color(0xFF2C2C28);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3C3C38);
const Color _kHighlight = Color(0xFF42A5F5);
const Color _kSelected = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFEF5350);

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
    home: const _DelegateDemo(),
  );
}

class _DelegateDemo extends StatefulWidget {
  const _DelegateDemo();
  @override
  State<_DelegateDemo> createState() => _DelegateDemoState();
}

class _DelegateDemoState extends State<_DelegateDemo>
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
          'SelectionContainerDelegate',
          style: TextStyle(
            color: _kAccent,
            fontSize: 14,
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
            Tab(text: 'Interfaces'),
            Tab(text: 'Transforms'),
            Tab(text: 'Implementation'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _InterfacesTab(),
          _TransformsTab(),
          _ImplementationTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Interfaces
// ═══════════════════════════════════════════════════════════════════════════════

class _InterfacesTab extends StatefulWidget {
  const _InterfacesTab();
  @override
  State<_InterfacesTab> createState() => _InterfacesTabState();
}

class _InterfacesTabState extends State<_InterfacesTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedInterface = 'handler';
  bool _expandMethods = false;

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
          // ── Class header ──
          _buildSectionTitle('SelectionContainerDelegate'),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'abstract class SelectionContainerDelegate\n'
            '    implements SelectionHandler,\n'
            '               SelectionRegistrar {\n'
            '  // ...\n'
            '}',
          ),
          const SizedBox(height: 16),

          // ── Inheritance ──
          _buildSectionTitle('Type Hierarchy'),
          const SizedBox(height: 8),
          _buildHierarchy(),
          const SizedBox(height: 16),

          // ── Interface selector ──
          _buildSectionTitle('Implemented Interfaces'),
          const SizedBox(height: 8),
          Row(
            children: [
              _ifaceChip('SelectionHandler', 'handler'),
              const SizedBox(width: 8),
              _ifaceChip('SelectionRegistrar', 'registrar'),
            ],
          ),
          const SizedBox(height: 12),
          _buildInterfaceDetail(),
          const SizedBox(height: 16),

          // ── Methods ──
          _buildSectionTitle('All Abstract Methods'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() => _expandMethods = !_expandMethods),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Method Signatures',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _expandMethods
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandMethods) ...[
                    const SizedBox(height: 8),
                    _methodRow(
                      'add(Selectable)',
                      'void',
                      'Register child selectable',
                      'registrar',
                    ),
                    _methodRow(
                      'remove(Selectable)',
                      'void',
                      'Unregister child selectable',
                      'registrar',
                    ),
                    _methodRow(
                      'dispatchSelectionEvent(event)',
                      'SelectionResult',
                      'Handle selection event, return result',
                      'handler',
                    ),
                    _methodRow(
                      'value',
                      'SelectionGeometry',
                      'Current selection geometry',
                      'handler',
                    ),
                    _methodRow(
                      'getTransformTo(ancestor)',
                      'Matrix4',
                      'Transform to ancestor coordinate space',
                      'handler',
                    ),
                    _methodRow(
                      'pushHandleLayers(start, end)',
                      'void',
                      'Push layer links for handles',
                      'handler',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── SelectionGeometry ──
          _buildSectionTitle('SelectionGeometry (value property)'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _geometryRow('status', 'SelectionStatus',
                    'none / uncollapsed / collapsed'),
                _geometryRow('hasContent', 'bool',
                    'Whether region has selectable content'),
                _geometryRow('startSelectionPoint',
                    'SelectionPoint?', 'Start handle position'),
                _geometryRow('endSelectionPoint',
                    'SelectionPoint?', 'End handle position'),
                _geometryRow('selectionRects',
                    'List<Rect>', 'Rectangles covering selected text'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'SelectionContainerDelegate bridges two role interfaces: '
            'SelectionHandler for processing events, and SelectionRegistrar '
            'for managing child Selectables. Concrete implementations must '
            'provide all six abstract methods.',
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchy() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _hierNode('Object', false, _kDimText),
          _hierArrow(),
          _hierNode('SelectionContainerDelegate (abstract)', true, _kAccent),
          _hierArrow(),
          Row(
            children: [
              Expanded(
                child: _hierLeaf(
                    'StaticSelectionContainerDelegate', _kHighlight),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _hierLeaf(
                    'Custom implementations', _kDimText),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _hierNode(String name, bool current, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: current ? color : Colors.transparent,
            border: Border.all(color: color, width: 1.5),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(name,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: current ? FontWeight.w700 : FontWeight.w500,
            )),
      ],
    );
  }

  Widget _hierArrow() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(width: 1, height: 10,
            color: _kDimText.withValues(alpha: 0.3)),
      ),
    );
  }

  Widget _hierLeaf(String name, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(name,
          style: TextStyle(
            color: color,
            fontSize: 9,
            fontFamily: 'monospace',
          ),
          textAlign: TextAlign.center),
    );
  }

  Widget _ifaceChip(String label, String value) {
    final selected = _selectedInterface == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedInterface = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? _kPrimary.withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _kAccent : _kDimText.withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? _kAccent : _kDimText,
            fontSize: 11,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }

  Widget _buildInterfaceDetail() {
    if (_selectedInterface == 'handler') {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kAccent.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.play_arrow, size: 16, color: _kAccent),
                const SizedBox(width: 6),
                const Text(
                  'SelectionHandler',
                  style: TextStyle(
                    color: _kAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Handles incoming SelectionEvents and maintains the current '
              'SelectionGeometry (selected rects, handle positions, status).',
              style: TextStyle(color: _kDimText, fontSize: 11),
            ),
            const SizedBox(height: 8),
            _buildCodeBlock(
              'abstract interface class SelectionHandler\n'
              '    implements ValueListenable<SelectionGeometry> {\n'
              '  SelectionResult dispatchSelectionEvent(\n'
              '    SelectionEvent event,\n'
              '  );\n'
              '  Matrix4 getTransformTo(RenderObject? ancestor);\n'
              '  void pushHandleLayers(\n'
              '    LayerLink? startHandle,\n'
              '    LayerLink? endHandle,\n'
              '  );\n'
              '}',
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kHighlight.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.app_registration, size: 16,
                    color: _kHighlight),
                const SizedBox(width: 6),
                const Text(
                  'SelectionRegistrar',
                  style: TextStyle(
                    color: _kHighlight,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Manages registration of child Selectable widgets. Children '
              'call add() in initState and remove() in dispose.',
              style: TextStyle(color: _kDimText, fontSize: 11),
            ),
            const SizedBox(height: 8),
            _buildCodeBlock(
              'abstract interface class SelectionRegistrar {\n'
              '  void add(Selectable selectable);\n'
              '  void remove(Selectable selectable);\n'
              '}',
            ),
            const SizedBox(height: 8),
            const Text(
              'Children find the registrar via:\n'
              'SelectionContainer.maybeOf(context)?.registrar',
              style: TextStyle(
                color: _kDimText,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _methodRow(
      String sig, String ret, String desc, String source) {
    final color = source == 'handler' ? _kAccent : _kHighlight;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(sig,
                          style: TextStyle(
                            color: color,
                            fontSize: 10,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Text('→ $ret',
                        style: const TextStyle(
                          color: _kDimText,
                          fontSize: 9,
                          fontFamily: 'monospace',
                        )),
                  ],
                ),
                Text(desc,
                    style: const TextStyle(color: _kDimText, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _geometryRow(String name, String type, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(name,
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                )),
          ),
          SizedBox(
            width: 90,
            child: Text(type,
                style: const TextStyle(
                  color: _kHighlight,
                  fontSize: 10,
                  fontFamily: 'monospace',
                )),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(color: _kDimText, fontSize: 9)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Transforms
// ═══════════════════════════════════════════════════════════════════════════════

class _TransformsTab extends StatefulWidget {
  const _TransformsTab();
  @override
  State<_TransformsTab> createState() => _TransformsTabState();
}

class _TransformsTabState extends State<_TransformsTab>
    with AutomaticKeepAliveClientMixin {
  double _childX = 40;
  double _childY = 30;
  bool _showHasSize = true;

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
          // ── Transform explanation ──
          _buildSectionTitle('Coordinate Transform Methods'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _transformRow(
                  'getTransformTo',
                  'Container → Ancestor',
                  'Maps local coordinates to an ancestor RenderObject. '
                      'If ancestor is null, maps to the root.',
                  _kAccent,
                ),
                const Divider(color: _kSubtle, height: 16),
                _transformRow(
                  'getTransformFrom',
                  'Child → Container',
                  'Maps a child Selectable\'s coordinates into the '
                      'container\'s local coordinate system.',
                  _kHighlight,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Interactive visualization ──
          _buildSectionTitle('Transform Visualization'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Drag sliders to move child position within container:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 12),
                _buildCoordinateCanvas(),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                      child: Text('X:',
                          style: TextStyle(color: _kAccent, fontSize: 11)),
                    ),
                    Expanded(
                      child: Slider(
                        value: _childX,
                        min: 0,
                        max: 160,
                        onChanged: (v) => setState(() => _childX = v),
                        activeColor: _kPrimary,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(
                        '${_childX.toStringAsFixed(0)}px',
                        style: const TextStyle(
                          color: _kDimText,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                      child: Text('Y:',
                          style: TextStyle(color: _kAccent, fontSize: 11)),
                    ),
                    Expanded(
                      child: Slider(
                        value: _childY,
                        min: 0,
                        max: 80,
                        onChanged: (v) => setState(() => _childY = v),
                        activeColor: _kPrimary,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(
                        '${_childY.toStringAsFixed(0)}px',
                        style: const TextStyle(
                          color: _kDimText,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: _kSurface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'getTransformFrom(child):',
                        style: TextStyle(
                          color: _kHighlight,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        '  translate(${_childX.toStringAsFixed(0)}, '
                        '${_childY.toStringAsFixed(0)})',
                        style: const TextStyle(
                          color: _kDimText,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'getTransformTo(null):',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const Text(
                        '  identity (container = root in this example)',
                        style: TextStyle(
                          color: _kDimText,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── hasSize ──
          _buildSectionTitle('hasSize Property'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Simulate layout state:',
                      style: TextStyle(color: _kDimText, fontSize: 11),
                    ),
                    const Spacer(),
                    Switch(
                      value: _showHasSize,
                      onChanged: (v) => setState(() => _showHasSize = v),
                      activeTrackColor: _kSelected,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: _showHasSize
                      ? _kSelected.withValues(alpha: 0.1)
                      : _kWarning.withValues(alpha: 0.1),
                  child: Row(
                    children: [
                      Icon(
                        _showHasSize ? Icons.check_circle : Icons.warning,
                        size: 14,
                        color: _showHasSize ? _kSelected : _kWarning,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _showHasSize
                              ? 'hasSize = true → transforms available'
                              : 'hasSize = false → transforms will assert!',
                          style: TextStyle(
                            color: _showHasSize ? _kSelected : _kWarning,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _buildCodeBlock(
                  'bool get hasSize {\n'
                  '  return _selectionContainerContext\n'
                  '    ?.findRenderObject()\n'
                  '    ?.hasSize ?? false;\n'
                  '}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Code signatures ──
          _buildSectionTitle('Method Signatures'),
          const SizedBox(height: 8),
          _buildCodeBlock(
            '// Maps child ➔ container coordinates\n'
            'Matrix4 getTransformFrom(\n'
            '  Selectable child,\n'
            ') {\n'
            '  final childBox = child.context\n'
            '    ?.findRenderObject() as RenderBox;\n'
            '  final containerBox = context\n'
            '    .findRenderObject() as RenderBox;\n'
            '  return childBox.getTransformTo(containerBox);\n'
            '}\n'
            '\n'
            '// Maps container ➔ ancestor coordinates\n'
            'Matrix4 getTransformTo(\n'
            '  RenderObject? ancestor,\n'
            ') {\n'
            '  final box = context\n'
            '    .findRenderObject() as RenderBox;\n'
            '  return box.getTransformTo(ancestor);\n'
            '}',
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'Always check hasSize before calling transform methods. '
            'Calling them before layout completes will trigger assertion '
            'errors. The delegate receives its BuildContext from the '
            'SelectionContainer widget.',
          ),
        ],
      ),
    );
  }

  Widget _transformRow(
      String name, String direction, String desc, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.transform, size: 16, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _kSurface,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(direction,
                        style: TextStyle(
                          color: color.withValues(alpha: 0.8),
                          fontSize: 9,
                          fontFamily: 'monospace',
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(desc,
                  style: const TextStyle(color: _kDimText, fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCoordinateCanvas() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: _kSurface,
        border: Border.all(color: _kAccent.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          // Container label
          const Positioned(
            left: 4,
            top: 2,
            child: Text('Container (0,0)',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 8,
                  fontFamily: 'monospace',
                )),
          ),
          // Grid lines
          ...List.generate(4, (i) {
            final x = (i + 1) * 50.0;
            return Positioned(
              left: x,
              top: 0,
              bottom: 0,
              child: Container(
                width: 1,
                color: _kSubtle.withValues(alpha: 0.3),
              ),
            );
          }),
          ...List.generate(2, (i) {
            final y = (i + 1) * 40.0;
            return Positioned(
              left: 0,
              right: 0,
              top: y,
              child: Container(
                height: 1,
                color: _kSubtle.withValues(alpha: 0.3),
              ),
            );
          }),
          // Child box
          Positioned(
            left: _childX,
            top: _childY,
            child: Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                color: _kPrimary.withValues(alpha: 0.3),
                border: Border.all(color: _kPrimary),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Text('Child',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 8,
                      fontFamily: 'monospace',
                    )),
              ),
            ),
          ),
          // Arrow from origin to child
          Positioned(
            left: 0,
            top: 0,
            child: CustomPaint(
              size: Size(_childX + 25, _childY + 15),
              painter: _ArrowPainter(
                end: Offset(_childX + 25, _childY + 15),
                color: _kHighlight.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final Offset end;
  final Color color;
  _ArrowPainter({required this.end, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, end, paint);
    // Arrowhead
    final headPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(end.dx, end.dy);
    path.lineTo(end.dx - 4, end.dy - 4);
    path.lineTo(end.dx - 4, end.dy + 4);
    path.close();
    canvas.drawPath(path, headPaint);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) =>
      oldDelegate.end != end || oldDelegate.color != color;
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Implementation
// ═══════════════════════════════════════════════════════════════════════════════

class _ImplementationTab extends StatefulWidget {
  const _ImplementationTab();
  @override
  State<_ImplementationTab> createState() => _ImplementationTabState();
}

class _ImplementationTabState extends State<_ImplementationTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedImpl = 'static';
  final List<String> _registeredChildren = [];
  int _eventCount = 0;
  String _lastEvent = 'No events dispatched';

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
          // ── Implementation selector ──
          _buildSectionTitle('Implementations'),
          const SizedBox(height: 8),
          Row(
            children: [
              _implChip('Static', 'static'),
              const SizedBox(width: 8),
              _implChip('Custom', 'custom'),
              const SizedBox(width: 8),
              _implChip('Container', 'container'),
            ],
          ),
          const SizedBox(height: 12),
          _buildImplDetail(),
          const SizedBox(height: 16),

          // ── Registrar simulation ──
          _buildSectionTitle('Registrar Simulation'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Simulate child Selectable registration:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            final name =
                                'Selectable_${_registeredChildren.length + 1}';
                            _registeredChildren.add(name);
                          });
                        },
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('add()',
                            style: TextStyle(fontSize: 11)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kPrimary.withValues(alpha: 0.3),
                          foregroundColor: _kAccent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _registeredChildren.isNotEmpty
                            ? () {
                                setState(
                                    () => _registeredChildren.removeLast());
                              }
                            : null,
                        icon: const Icon(Icons.remove, size: 16),
                        label: const Text('remove()',
                            style: TextStyle(fontSize: 11)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kWarning.withValues(alpha: 0.15),
                          foregroundColor: _kWarning,
                          disabledBackgroundColor: _kSubtle,
                          disabledForegroundColor:
                              _kDimText.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: const BoxConstraints(maxHeight: 80),
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: _kSurface,
                  child: _registeredChildren.isEmpty
                      ? const Text(
                          'No selectables registered',
                          style: TextStyle(
                              color: _kDimText,
                              fontSize: 10,
                              fontFamily: 'monospace'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _registeredChildren.length,
                          itemBuilder: (_, i) => Text(
                            '  [$i] ${_registeredChildren[i]}',
                            style: const TextStyle(
                              color: _kSelected,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Registered: ${_registeredChildren.length}',
                  style: const TextStyle(
                    color: _kDimText,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Event dispatch demo ──
          _buildSectionTitle('Event Dispatch Simulation'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Simulate dispatchSelectionEvent:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _eventButton('SelectWord', _kHighlight),
                    _eventButton('SelectAll', _kSelected),
                    _eventButton('Extend', _kPrimary),
                    _eventButton('Clear', _kWarning),
                    _eventButton('Granular', _kDimText),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: _kSurface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _lastEvent,
                        style: TextStyle(
                          color: _eventCount > 0 ? _kAccent : _kDimText,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        'Total events: $_eventCount | '
                        'Children: ${_registeredChildren.length}',
                        style: const TextStyle(
                          color: _kDimText,
                          fontSize: 9,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── SelectionContainer widget ──
          _buildSectionTitle('SelectionContainer Widget'),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'SelectionContainer(\n'
            '  delegate: myDelegate,\n'
            '  registrar: parentRegistrar,\n'
            '  child: Column(\n'
            '    children: [\n'
            '      Text(\'Selectable text 1\'),\n'
            '      Text(\'Selectable text 2\'),\n'
            '    ],\n'
            '  ),\n'
            ')',
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            color: _kSurface,
            child: const Text(
              'SelectionContainer:\n'
              '  1. Creates with delegate\n'
              '  2. Sets delegate\'s context in build\n'
              '  3. Passes registrar to descendants\n'
              '  4. Children auto-register via InheritedWidget',
              style: TextStyle(
                color: _kDimText,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'StaticSelectionContainerDelegate is the framework\'s built-in '
            'implementation. It handles multi-child selection by iterating '
            'selectables in order and dispatching events to each one. '
            'Custom delegates can implement different selection strategies.',
          ),
        ],
      ),
    );
  }

  Widget _implChip(String label, String value) {
    final selected = _selectedImpl == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedImpl = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? _kPrimary.withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _kAccent : _kDimText.withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? _kAccent : _kDimText,
            fontSize: 11,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildImplDetail() {
    switch (_selectedImpl) {
      case 'static':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'StaticSelectionContainerDelegate',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'The default framework implementation. Manages a flat list '
                'of Selectables and dispatches events in document order.',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
              const SizedBox(height: 8),
              _featureRow('Ordering', 'Selectables sorted by position'),
              _featureRow('Multi-selection',
                  'Spans across multiple Selectable children'),
              _featureRow('Event routing',
                  'Forwards to affected Selectables only'),
              _featureRow('Geometry merge',
                  'Combines children\'s selection geometry'),
            ],
          ),
        );
      case 'custom':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Custom Delegate Pattern',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              _buildCodeBlock(
                'class MyDelegate\n'
                '    extends SelectionContainerDelegate {\n'
                '  final List<Selectable> _selectables = [];\n'
                '\n'
                '  @override\n'
                '  void add(Selectable s) =>\n'
                '    _selectables.add(s);\n'
                '\n'
                '  @override\n'
                '  void remove(Selectable s) =>\n'
                '    _selectables.remove(s);\n'
                '\n'
                '  @override\n'
                '  SelectionResult dispatchSelectionEvent(\n'
                '    SelectionEvent event,\n'
                '  ) {\n'
                '    for (final s in _selectables) {\n'
                '      s.dispatchSelectionEvent(event);\n'
                '    }\n'
                '    return SelectionResult.end;\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  SelectionGeometry get value => ...;\n'
                '}',
              ),
            ],
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SelectionContainer Widget',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'SelectionContainer connects the delegate to the widget tree:',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
              const SizedBox(height: 8),
              _flowNode('SelectionContainer.build()', _kDimText),
              _flowConnector(),
              _flowNode('Set delegate.context = this.context', _kPrimary),
              _flowConnector(),
              _flowNode('Provide registrar via InheritedWidget', _kHighlight),
              _flowConnector(),
              _flowNode('Children call registrar.add(this)', _kAccent),
              _flowConnector(),
              _flowNode('Delegate handles events for all children',
                  _kSelected),
            ],
          ),
        );
    }
  }

  Widget _featureRow(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 12, color: _kSelected),
          const SizedBox(width: 6),
          SizedBox(
            width: 90,
            child: Text(label,
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(color: _kDimText, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _eventButton(String name, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _eventCount++;
          _lastEvent =
              '#$_eventCount dispatchSelectionEvent($name)';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _flowNode(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              )),
        ),
      ],
    );
  }

  Widget _flowConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 10,
          color: _kDimText.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildInfoBanner(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    color: _kPrimary.withValues(alpha: 0.08),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline, size: 14, color: _kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _kDimText, fontSize: 11),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: _kAccent,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
}
