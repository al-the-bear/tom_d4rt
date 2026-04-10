// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for SemanticsGestureDelegate.
///
/// SemanticsGestureDelegate is an abstract class that configures what
/// semantics actions a RawGestureDetector adds to its render object.
///
/// Demonstrates:
/// - Tab 1 (Anatomy): Class definition, assignSemantics method,
///   RenderSemanticsGestureHandler properties, inheritance
/// - Tab 2 (Accessibility): Gesture→semantic mapping, screen reader
///   behaviors, TalkBack/VoiceOver comparison, action cards
/// - Tab 3 (Custom Delegate): Implementation pattern, RawGestureDetector
///   integration, live gesture area with semantic feedback

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFFBF360C); // DeepOrange 900
const Color _kAccent = Color(0xFF84FFFF); // Cyan A100
const Color _kSurface = Color(0xFF1A1816);
const Color _kCard = Color(0xFF2A2826);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3A3836);
const Color _kHighlight = Color(0xFF42A5F5);
const Color _kSelected = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFEF5350);
const Color _kMuted = Color(0xFFAB47BC);

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
          'SemanticsGestureDelegate',
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
            Tab(text: 'Anatomy'),
            Tab(text: 'Accessibility'),
            Tab(text: 'Custom'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _AnatomyTab(),
          _AccessibilityTab(),
          _CustomTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Anatomy
// ═══════════════════════════════════════════════════════════════════════════════

class _AnatomyTab extends StatefulWidget {
  const _AnatomyTab();
  @override
  State<_AnatomyTab> createState() => _AnatomyTabState();
}

class _AnatomyTabState extends State<_AnatomyTab>
    with AutomaticKeepAliveClientMixin {
  bool _expandMethod = false;
  bool _expandRender = false;

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
          // ── Class definition ──
          _buildSectionTitle('Class Definition'),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'abstract class SemanticsGestureDelegate {\n'
            '  const SemanticsGestureDelegate();\n'
            '\n'
            '  void assignSemantics(\n'
            '    RenderSemanticsGestureHandler renderObject,\n'
            '  );\n'
            '}',
          ),
          const SizedBox(height: 16),

          // ── Purpose ──
          _buildSectionTitle('Purpose'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: const Text(
              'SemanticsGestureDelegate bridges gesture recognizers and '
              'accessibility services. It tells the framework what semantic '
              'actions (tap, long press, scroll) should be announced to '
              'screen readers for a given gesture detector.',
              style: TextStyle(color: _kDimText, fontSize: 11),
            ),
          ),
          const SizedBox(height: 16),

          // ── Hierarchy ──
          _buildSectionTitle('Type Hierarchy'),
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
                _hierNode('Object', false, _kDimText),
                _hierArrow(),
                _hierNode(
                    'SemanticsGestureDelegate (abstract)', true, _kAccent),
                _hierArrow(),
                Row(
                  children: [
                    Expanded(
                      child: _hierLeaf(
                          '_DefaultSemanticsGestureDelegate', _kHighlight),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _hierLeaf('Custom implementations', _kDimText),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── assignSemantics ──
          GestureDetector(
            onTap: () => setState(() => _expandMethod = !_expandMethod),
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
                      const Icon(Icons.functions, size: 16,
                          color: _kAccent),
                      const SizedBox(width: 8),
                      const Text(
                        'assignSemantics()',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _expandMethod
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandMethod) ...[
                    const SizedBox(height: 8),
                    const Text(
                      'Called by RawGestureDetector when:',
                      style: TextStyle(color: _kDimText, fontSize: 11),
                    ),
                    const SizedBox(height: 6),
                    _callPoint('Widget is first built', _kSelected),
                    _callPoint('Widget is updated', _kHighlight),
                    _callPoint(
                        'replaceGestureRecognizers is called', _kMuted),
                    const SizedBox(height: 8),
                    _buildCodeBlock(
                      'void assignSemantics(\n'
                      '  RenderSemanticsGestureHandler renderObject,\n'
                      ') {\n'
                      '  // Configure semantic actions\n'
                      '  renderObject.onTap = _handleTap;\n'
                      '  renderObject.onLongPress = _handleLong;\n'
                      '}',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── RenderSemanticsGestureHandler ──
          GestureDetector(
            onTap: () => setState(() => _expandRender = !_expandRender),
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
                      const Icon(Icons.settings_applications, size: 16,
                          color: _kHighlight),
                      const SizedBox(width: 8),
                      const Text(
                        'RenderSemanticsGestureHandler',
                        style: TextStyle(
                          color: _kHighlight,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _expandRender
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandRender) ...[
                    const SizedBox(height: 8),
                    _renderProp('onTap', 'GestureTapCallback?',
                        'Semantic tap action', _kSelected),
                    _renderProp('onLongPress',
                        'GestureLongPressCallback?',
                        'Semantic long press action', _kMuted),
                    _renderProp('onHorizontalDragUpdate',
                        'GestureDragUpdateCallback?',
                        'Horizontal scroll/drag', _kHighlight),
                    _renderProp('onVerticalDragUpdate',
                        'GestureDragUpdateCallback?',
                        'Vertical scroll/drag', _kWarning),
                    const SizedBox(height: 6),
                    const Text(
                      'These callbacks are set by the delegate to define '
                      'what semantic actions are available for accessibility.',
                      style: TextStyle(color: _kDimText, fontSize: 10),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Default delegate ──
          _buildSectionTitle('_DefaultSemanticsGestureDelegate'),
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
                  'The framework-provided default implementation:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _defaultBehavior('TapGestureRecognizer',
                    '→ onTap semantic', _kSelected),
                _defaultBehavior('LongPressGestureRecognizer',
                    '→ onLongPress semantic', _kMuted),
                _defaultBehavior('HorizontalDragGestureRecognizer',
                    '→ onHorizontalDragUpdate', _kHighlight),
                _defaultBehavior('VerticalDragGestureRecognizer',
                    '→ onVerticalDragUpdate', _kWarning),
                const SizedBox(height: 6),
                const Text(
                  'Used automatically by RawGestureDetector when no '
                  'custom delegate is specified.',
                  style: TextStyle(color: _kDimText, fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'SemanticsGestureDelegate is the extensibility point for '
            'RawGestureDetector\'s accessibility. Without it, gesture '
            'detectors would have no semantic meaning for screen readers.',
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
        Flexible(
          child: Text(name,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: current ? FontWeight.w700 : FontWeight.w500,
              )),
        ),
      ],
    );
  }

  Widget _hierArrow() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
            width: 1, height: 10,
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

  Widget _callPoint(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(text,
              style: TextStyle(color: color, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _renderProp(
      String name, String type, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(name,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                )),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type,
                    style: const TextStyle(
                      color: _kDimText,
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

  Widget _defaultBehavior(String recognizer, String maps, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text('$recognizer $maps',
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontFamily: 'monospace',
                )),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Accessibility
// ═══════════════════════════════════════════════════════════════════════════════

class _AccessibilityTab extends StatefulWidget {
  const _AccessibilityTab();
  @override
  State<_AccessibilityTab> createState() => _AccessibilityTabState();
}

class _AccessibilityTabState extends State<_AccessibilityTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedGesture = 'tap';
  String _selectedPlatform = 'android';

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
          // ── Gesture mapping ──
          _buildSectionTitle('Gesture → Semantic Mapping'),
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
                _mappingRow('Tap', 'onTap', 'Activate',
                    Icons.touch_app, _kSelected),
                _mappingDivider(),
                _mappingRow('Long Press', 'onLongPress',
                    'Long press action', Icons.pan_tool, _kMuted),
                _mappingDivider(),
                _mappingRow('Horizontal Drag',
                    'onHorizontalDragUpdate', 'Scroll horizontally',
                    Icons.swap_horiz, _kHighlight),
                _mappingDivider(),
                _mappingRow('Vertical Drag',
                    'onVerticalDragUpdate', 'Scroll vertically',
                    Icons.swap_vert, _kWarning),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Gesture selector ──
          _buildSectionTitle('Screen Reader Behavior'),
          const SizedBox(height: 8),
          Row(
            children: [
              _gestureChip('Tap', 'tap'),
              const SizedBox(width: 6),
              _gestureChip('Long Press', 'longpress'),
              const SizedBox(width: 6),
              _gestureChip('Drag', 'drag'),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: _buildGestureDetail(),
          ),
          const SizedBox(height: 16),

          // ── Platform comparison ──
          _buildSectionTitle('Platform Comparison'),
          const SizedBox(height: 8),
          Row(
            children: [
              _platformChip('Android (TalkBack)', 'android'),
              const SizedBox(width: 8),
              _platformChip('iOS (VoiceOver)', 'ios'),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: _buildPlatformDetail(),
          ),
          const SizedBox(height: 16),

          // ── Accessibility tree ──
          _buildSectionTitle('Semantics Tree Impact'),
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
                _treeNode('SemanticsNode', _kDimText, 0),
                _treeNode('├─ actions: [tap, longPress]', _kAccent, 1),
                _treeNode('├─ label: "Button text"', _kHighlight, 1),
                _treeNode('├─ hint: "Double tap to activate"', _kSelected, 1),
                _treeNode('└─ scrollable: horizontal', _kMuted, 1),
                const SizedBox(height: 8),
                const Text(
                  'The delegate controls which actions appear in the '
                  'semantics node. Without proper delegation, gesture '
                  'interactions become invisible to assistive technology.',
                  style: TextStyle(color: _kDimText, fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'Proper semantic gesture delegation is essential for WCAG '
            'compliance. Every touchable element should announce its '
            'available actions to screen readers.',
          ),
        ],
      ),
    );
  }

  Widget _buildGestureDetail() {
    switch (_selectedGesture) {
      case 'tap':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.touch_app, size: 16, color: _kSelected),
                const SizedBox(width: 8),
                const Text('Tap → onTap Semantic',
                    style: TextStyle(
                      color: _kSelected,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'When a TapGestureRecognizer is present, the delegate sets '
              'onTap on the render object. Screen readers announce '
              '"Double tap to activate" or equivalent.',
              style: TextStyle(color: _kDimText, fontSize: 11),
            ),
            const SizedBox(height: 8),
            _buildCodeBlock(
              'renderObject.onTap = () {\n'
              '  recognizer.onTap?.call();\n'
              '};',
            ),
          ],
        );
      case 'longpress':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.pan_tool, size: 16, color: _kMuted),
                const SizedBox(width: 8),
                const Text('Long Press → onLongPress',
                    style: TextStyle(
                      color: _kMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'LongPressGestureRecognizer maps to onLongPress semantic. '
              'Screen readers announce "Double tap and hold to long press" '
              'or show it in the actions menu.',
              style: TextStyle(color: _kDimText, fontSize: 11),
            ),
            const SizedBox(height: 8),
            _buildCodeBlock(
              'renderObject.onLongPress = () {\n'
              '  recognizer.onLongPress?.call();\n'
              '};',
            ),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.swap_horiz, size: 16,
                    color: _kHighlight),
                const SizedBox(width: 8),
                const Text('Drag → Scroll Semantic',
                    style: TextStyle(
                      color: _kHighlight,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Drag recognizers map to scroll semantics. Horizontal and '
              'vertical drags are handled separately, enabling directional '
              'scroll announcements for screen readers.',
              style: TextStyle(color: _kDimText, fontSize: 11),
            ),
            const SizedBox(height: 8),
            _buildCodeBlock(
              'renderObject.onHorizontalDragUpdate =\n'
              '  (DragUpdateDetails d) {\n'
              '    recognizer.onUpdate?.call(d);\n'
              '  };',
            ),
          ],
        );
    }
  }

  Widget _buildPlatformDetail() {
    if (_selectedPlatform == 'android') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.android, size: 16, color: _kSelected),
              const SizedBox(width: 8),
              const Text('TalkBack (Android)',
                  style: TextStyle(
                    color: _kSelected,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
          const SizedBox(height: 8),
          _platformAction('Double tap', 'Activate (onTap)', _kSelected),
          _platformAction(
              'Double tap and hold', 'Long press', _kMuted),
          _platformAction(
              'Two-finger swipe', 'Scroll', _kHighlight),
          _platformAction(
              'Explore by touch', 'Focus element', _kDimText),
          const SizedBox(height: 6),
          const Text(
            'TalkBack uses the AccessibilityNodeInfo from the '
            'semantics tree. Actions set by the delegate appear '
            'in the node\'s available actions list.',
            style: TextStyle(color: _kDimText, fontSize: 10),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.apple, size: 16, color: _kHighlight),
              const SizedBox(width: 8),
              const Text('VoiceOver (iOS)',
                  style: TextStyle(
                    color: _kHighlight,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
          const SizedBox(height: 8),
          _platformAction(
              'Double tap', 'Activate (onTap)', _kSelected),
          _platformAction(
              'Triple tap', 'Long press alternative', _kMuted),
          _platformAction(
              'Three-finger swipe', 'Scroll', _kHighlight),
          _platformAction(
              'Rotor actions', 'Custom actions menu', _kWarning),
          const SizedBox(height: 6),
          const Text(
            'VoiceOver uses UIAccessibilityElement on iOS. '
            'Flutter translates semantic actions to native '
            'accessibility traits and custom actions.',
            style: TextStyle(color: _kDimText, fontSize: 10),
          ),
        ],
      );
    }
  }

  Widget _mappingRow(String gesture, String semantic, String desc,
      IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 10),
        SizedBox(
          width: 80,
          child: Text(gesture,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              )),
        ),
        const Icon(Icons.arrow_forward, size: 12, color: _kDimText),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(semantic,
                  style: const TextStyle(
                    color: _kAccent,
                    fontSize: 10,
                    fontFamily: 'monospace',
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

  Widget _mappingDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(height: 1, color: _kSubtle),
    );
  }

  Widget _gestureChip(String label, String value) {
    final selected = _selectedGesture == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedGesture = value),
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

  Widget _platformChip(String label, String value) {
    final selected = _selectedPlatform == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedPlatform = value),
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

  Widget _platformAction(String gesture, String action, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 110,
            child: Text(gesture,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 10,
                )),
          ),
          Expanded(
            child: Text(action,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    );
  }

  Widget _treeNode(String text, Color color, int indent) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 12),
      child: Text(text,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontFamily: 'monospace',
          )),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Custom Delegate
// ═══════════════════════════════════════════════════════════════════════════════

class _CustomTab extends StatefulWidget {
  const _CustomTab();
  @override
  State<_CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<_CustomTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedView = 'pattern';
  int _tapCount = 0;
  int _longPressCount = 0;
  final List<String> _eventLog = [];

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
          // ── View selector ──
          Row(
            children: [
              _viewChip('Pattern', 'pattern'),
              const SizedBox(width: 8),
              _viewChip('Live Demo', 'live'),
              const SizedBox(width: 8),
              _viewChip('Integration', 'integration'),
            ],
          ),
          const SizedBox(height: 16),

          if (_selectedView == 'pattern') _buildPatternView(),
          if (_selectedView == 'live') _buildLiveView(),
          if (_selectedView == 'integration') _buildIntegrationView(),
        ],
      ),
    );
  }

  Widget _buildPatternView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Custom Delegate Pattern'),
        const SizedBox(height: 8),
        _buildCodeBlock(
          'class MySemanticDelegate\n'
          '    extends SemanticsGestureDelegate {\n'
          '  final VoidCallback? onTap;\n'
          '  final VoidCallback? onLongPress;\n'
          '\n'
          '  const MySemanticDelegate({\n'
          '    this.onTap,\n'
          '    this.onLongPress,\n'
          '  });\n'
          '\n'
          '  @override\n'
          '  void assignSemantics(\n'
          '    RenderSemanticsGestureHandler renderObject,\n'
          '  ) {\n'
          '    renderObject.onTap = onTap;\n'
          '    renderObject.onLongPress = onLongPress;\n'
          '  }\n'
          '}',
        ),
        const SizedBox(height: 12),

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
                'When to Create a Custom Delegate:',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _reasonRow(Icons.settings, 'Custom mapping',
                  'Different semantic action than default', _kSelected),
              _reasonRow(Icons.accessibility_new, 'Extra semantics',
                  'Add semantics not tied to recognizers', _kHighlight),
              _reasonRow(Icons.tune, 'Conditional actions',
                  'Enable/disable semantics dynamically', _kMuted),
              _reasonRow(Icons.filter_alt, 'Filtered actions',
                  'Only expose subset of gestures', _kWarning),
            ],
          ),
        ),
        const SizedBox(height: 12),

        _buildSectionTitle('Usage with RawGestureDetector'),
        const SizedBox(height: 8),
        _buildCodeBlock(
          'RawGestureDetector(\n'
          '  gestures: {\n'
          '    TapGestureRecognizer:\n'
          '      GestureRecognizerFactoryWithHandlers<\n'
          '        TapGestureRecognizer>(\n'
          '      () => TapGestureRecognizer(),\n'
          '      (r) => r.onTap = handleTap,\n'
          '    ),\n'
          '  },\n'
          '  semantics: MySemanticDelegate(\n'
          '    onTap: handleTap,\n'
          '  ),\n'
          '  child: myChild,\n'
          ')',
        ),
      ],
    );
  }

  Widget _buildLiveView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Interactive Gesture Area'),
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
                'Tap or long-press the areas below:',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _tapCount++;
                          _eventLog.insert(0,
                              'Tap #$_tapCount → onTap semantic');
                          if (_eventLog.length > 8) _eventLog.removeLast();
                        });
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: _kSelected.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: _kSelected.withValues(alpha: 0.4)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.touch_app, size: 20,
                                color: _kSelected),
                            const SizedBox(height: 4),
                            Text('Tap ($_tapCount)',
                                style: const TextStyle(
                                  color: _kSelected,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          _longPressCount++;
                          _eventLog.insert(0,
                              'LongPress #$_longPressCount → onLongPress');
                          if (_eventLog.length > 8) _eventLog.removeLast();
                        });
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: _kMuted.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: _kMuted.withValues(alpha: 0.4)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.pan_tool, size: 20,
                                color: _kMuted),
                            const SizedBox(height: 4),
                            Text('Long Press ($_longPressCount)',
                                style: const TextStyle(
                                  color: _kMuted,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Event log ──
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
                  const Text('Semantic Action Log',
                      style: TextStyle(
                        color: _kAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _eventLog.clear();
                        _tapCount = 0;
                        _longPressCount = 0;
                      });
                    },
                    child: const Text('Clear',
                        style: TextStyle(
                          color: _kDimText,
                          fontSize: 10,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                constraints: const BoxConstraints(maxHeight: 120),
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: _kSurface,
                child: _eventLog.isEmpty
                    ? const Text('No events yet — tap or long-press above',
                        style: TextStyle(
                          color: _kDimText,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _eventLog.length,
                        itemBuilder: (_, i) {
                          final isTap = _eventLog[i].startsWith('Tap');
                          return Text(
                            _eventLog[i],
                            style: TextStyle(
                              color: isTap ? _kSelected : _kMuted,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Semantic equivalence ──
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
                'Semantic Equivalence',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _equivRow('Visual user taps',
                  'onTap callback fires', _kSelected),
              _equivRow('Screen reader double-taps',
                  'Same onTap callback fires', _kSelected),
              _equivRow('Visual user long-presses',
                  'onLongPress fires', _kMuted),
              _equivRow('Screen reader double-tap-hold',
                  'Same onLongPress fires', _kMuted),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIntegrationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Integration Flow'),
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
              _flowNode('RawGestureDetector.build()',
                  _kDimText),
              _flowConnector(),
              _flowNode('Creates RenderSemanticsGestureHandler',
                  _kHighlight),
              _flowConnector(),
              _flowNode('Calls delegate.assignSemantics(handler)',
                  _kAccent),
              _flowConnector(),
              _flowNode('Handler exposes onTap/onLongPress/etc.',
                  _kSelected),
              _flowConnector(),
              _flowNode('Semantics tree picks up actions',
                  _kMuted),
              _flowConnector(),
              _flowNode('Screen reader announces capabilities',
                  _kWarning),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── GestureDetector vs RawGestureDetector ──
        _buildSectionTitle('GestureDetector vs RawGestureDetector'),
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
              _compRow('Feature', 'GestureDetector', 'Raw', _kAccent),
              _compDivider(),
              _compRow('Delegate', 'Auto (default)',
                  'Custom or default', _kDimText),
              _compRow('Recognizers', 'Pre-built',
                  'User-provided factory', _kDimText),
              _compRow('Semantics', 'Automatic',
                  'Configurable', _kDimText),
              _compRow('Flexibility', 'Convenience',
                  'Full control', _kDimText),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Related classes ──
        _buildSectionTitle('Related Classes'),
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
              _relatedRow('SemanticsGestureDelegate',
                  'This demo — abstract base', _kAccent),
              _relatedRow('RawGestureDetector',
                  'Widget that uses delegate', _kHighlight),
              _relatedRow('GestureDetector',
                  'High-level convenience wrapper', _kSelected),
              _relatedRow('RenderSemanticsGestureHandler',
                  'Render object with semantic props', _kMuted),
              _relatedRow('Semantics',
                  'Direct semantics annotation widget', _kWarning),
            ],
          ),
        ),
        const SizedBox(height: 12),

        _buildInfoBanner(
          'Most apps use GestureDetector which handles semantics '
          'automatically. Custom SemanticsGestureDelegate is only '
          'needed when building custom gesture handling with '
          'RawGestureDetector and you need specific semantic behavior.',
        ),
      ],
    );
  }

  Widget _viewChip(String label, String value) {
    final selected = _selectedView == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedView = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

  Widget _reasonRow(IconData icon, String title, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
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

  Widget _equivRow(String visual, String semantic, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(visual,
                      style: const TextStyle(
                        color: _kDimText,
                        fontSize: 10,
                      )),
                ),
                const Icon(Icons.compare_arrows, size: 12,
                    color: _kDimText),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(semantic,
                      style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
          ),
        ],
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

  Widget _compRow(String feat, String gd, String raw, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(feat,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Expanded(
            child: Text(gd,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 10,
                )),
          ),
          Expanded(
            child: Text(raw,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 10,
                )),
          ),
        ],
      ),
    );
  }

  Widget _compDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(height: 1, color: _kSubtle),
    );
  }

  Widget _relatedRow(String name, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 140,
            child: Text(name,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
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
