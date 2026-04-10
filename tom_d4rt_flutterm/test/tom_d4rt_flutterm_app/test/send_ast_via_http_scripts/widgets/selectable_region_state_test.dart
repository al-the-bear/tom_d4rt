// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for SelectableRegionState.
///
/// SelectableRegionState is the State for SelectableRegion. It manages text
/// selection overlay, gesture recognition, copy actions, and the registrar
/// system that tracks selectable children.
///
/// Demonstrates:
/// - Tab 1 (Selection): Live SelectableRegion with selectable text,
///   selection state tracking, overlay handles, copy action
/// - Tab 2 (Gestures): Gesture recognizer map, input device comparison
///   (mouse vs touch), context menu, drag and long-press handling
/// - Tab 3 (Architecture): Registrar pattern, delegate hierarchy,
///   focus management, orientation handling, actions system

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFFB71C1C); // Red 900
const Color _kAccent = Color(0xFF80D8FF); // LightBlue A100
const Color _kSurface = Color(0xFF1C1818);
const Color _kCard = Color(0xFF2C2828);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3C3838);
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
    home: const _SelectableRegionDemo(),
  );
}

class _SelectableRegionDemo extends StatefulWidget {
  const _SelectableRegionDemo();
  @override
  State<_SelectableRegionDemo> createState() => _SelectableRegionDemoState();
}

class _SelectableRegionDemoState extends State<_SelectableRegionDemo>
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
          'SelectableRegionState',
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
            Tab(text: 'Selection'),
            Tab(text: 'Gestures'),
            Tab(text: 'Architecture'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _SelectionTab(),
          _GesturesTab(),
          _ArchitectureTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Selection
// ═══════════════════════════════════════════════════════════════════════════════

class _SelectionTab extends StatefulWidget {
  const _SelectionTab();
  @override
  State<_SelectionTab> createState() => _SelectionTabState();
}

class _SelectionTabState extends State<_SelectionTab>
    with AutomaticKeepAliveClientMixin {
  bool _isSelecting = false;
  int _selectAllCount = 0;
  int _copyCount = 0;
  String _lastAction = 'No selection action yet';
  bool _showOverlayExplainer = false;

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
          // ── Live selectable region ──
          _buildSectionTitle('Live SelectableRegion'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SelectionArea(
                onSelectionChanged: (value) {
                  setState(() {
                    _isSelecting = value != null &&
                        value.plainText.isNotEmpty;
                    _lastAction = _isSelecting
                        ? 'Selected: "${_truncate(value!.plainText, 40)}"'
                        : 'Selection cleared';
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SelectableRegion & SelectableRegionState',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'SelectableRegionState manages text selection overlays, '
                        'gesture recognizers, and the registrar system. Try '
                        'selecting this text with mouse drag or long-press.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The state object maintains references to start/end '
                        'handle layer links, a toolbar layer link, and the '
                        'selection overlay that renders the blue highlight '
                        'and draggable handles.',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'It also implements TextSelectionDelegate and '
                        'SelectionRegistrar, receiving registration calls '
                        'from child Selectable widgets.',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Selection state ──
          _buildSectionTitle('Selection State'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _isSelecting
                    ? _kSelected.withValues(alpha: 0.4)
                    : _kSubtle,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      _isSelecting
                          ? Icons.text_fields
                          : Icons.text_fields,
                      size: 16,
                      color: _isSelecting ? _kSelected : _kDimText,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _lastAction,
                        style: TextStyle(
                          color: _isSelecting ? _kSelected : _kDimText,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _statBadge('hasSelection', _isSelecting,
                        _isSelecting ? _kSelected : _kDimText),
                    const SizedBox(width: 8),
                    _statBadge('selectAll',
                        '$_selectAllCount', _kHighlight),
                    const SizedBox(width: 8),
                    _statBadge('copy',
                        '$_copyCount', _kAccent),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Action buttons ──
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectAllCount++;
                      _lastAction = 'SelectAll #$_selectAllCount triggered';
                    });
                  },
                  icon: const Icon(Icons.select_all, size: 16),
                  label: const Text(
                    'Select All',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary.withValues(alpha: 0.3),
                    foregroundColor: _kAccent,
                    side: BorderSide(color: _kAccent.withValues(alpha: 0.4)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isSelecting
                      ? () {
                          setState(() {
                            _copyCount++;
                            _lastAction = 'Copy #$_copyCount performed';
                          });
                        }
                      : null,
                  icon: const Icon(Icons.copy, size: 16),
                  label: const Text(
                    'Copy',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kHighlight.withValues(alpha: 0.2),
                    foregroundColor: _kHighlight,
                    disabledBackgroundColor: _kSubtle,
                    disabledForegroundColor: _kDimText.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Selection overlay ──
          _buildSectionTitle('Selection Overlay'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () =>
                setState(() => _showOverlayExplainer = !_showOverlayExplainer),
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
                        'Overlay Components',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _showOverlayExplainer
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_showOverlayExplainer) ...[
                    const SizedBox(height: 8),
                    _overlayRow('selectionOverlay',
                        'TextSelectionOverlay — manages visible handles'),
                    _overlayRow('_startHandleLayerLink',
                        'LayerLink for start handle positioning'),
                    _overlayRow('_endHandleLayerLink',
                        'LayerLink for end handle positioning'),
                    _overlayRow('_toolbarLayerLink',
                        'LayerLink for toolbar/context menu'),
                    _overlayRow('_lastSelectedContent',
                        'Cached SelectedContent for copy'),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Properties ──
          _buildSectionTitle('Key Properties'),
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
                _propRow('selectionOverlay', 'TextSelectionOverlay?',
                    'Public overlay reference (test visible)'),
                _propRow('textEditingValue', 'TextEditingValue',
                    'From TextSelectionDelegate'),
                _propRow('copyEnabled', 'bool',
                    'Whether copy action is available'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'SelectableRegionState is typically not used directly. The '
            'SelectionArea widget wraps SelectableRegion with a default '
            'context menu and selection style.',
          ),
        ],
      ),
    );
  }

  String _truncate(String s, int max) {
    return s.length > max ? '${s.substring(0, max)}...' : s;
  }

  Widget _statBadge(String label, dynamic value, Color color) {
    final text = value is bool ? (value ? 'true' : 'false') : '$value';
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(color: _kDimText, fontSize: 8)),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _overlayRow(String name, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 4),
            decoration: const BoxDecoration(
              color: _kPrimary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                      color: _kAccent,
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    )),
                Text(desc,
                    style: const TextStyle(color: _kDimText, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Gestures
// ═══════════════════════════════════════════════════════════════════════════════

class _GesturesTab extends StatefulWidget {
  const _GesturesTab();
  @override
  State<_GesturesTab> createState() => _GesturesTabState();
}

class _GesturesTabState extends State<_GesturesTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedDevice = 'mouse';
  final List<String> _gestureLog = [];

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
          // ── Gesture recognizer map ──
          _buildSectionTitle('Gesture Recognizers'),
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
                _gestureRow('TapGestureRecognizer',
                    'Single tap — place cursor, dismiss selection',
                    Icons.touch_app),
                _gestureRow('LongPressGestureRecognizer',
                    'Long press — start selection at position',
                    Icons.back_hand),
                _gestureRow('HorizontalDragGestureRecognizer',
                    'Drag — extend/shrink selection (desktop)',
                    Icons.open_with),
                _gestureRow('TapAndDragGestureRecognizer',
                    'Tap + drag — word-level selection expansion',
                    Icons.swipe),
                _gestureRow('PanGestureRecognizer',
                    'Pan for secondary click (right-click context menu)',
                    Icons.mouse),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Device comparison ──
          _buildSectionTitle('Input Device Comparison'),
          const SizedBox(height: 8),
          Row(
            children: [
              _deviceChip('Mouse', 'mouse', Icons.mouse),
              const SizedBox(width: 8),
              _deviceChip('Touch', 'touch', Icons.touch_app),
              const SizedBox(width: 8),
              _deviceChip('Stylus', 'stylus', Icons.edit),
            ],
          ),
          const SizedBox(height: 12),
          _buildDeviceDetail(),
          const SizedBox(height: 16),

          // ── Interactive gesture area ──
          _buildSectionTitle('Gesture Test Area'),
          const SizedBox(height: 8),
          _buildGestureTestArea(),
          const SizedBox(height: 16),

          // ── Context menu ──
          _buildSectionTitle('Context Menu Handling'),
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
                  'Right-click / long-press triggers the context menu '
                  'via contextMenuBuilder:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _buildCodeBlock(
                  'SelectableRegion(\n'
                  '  contextMenuBuilder: (\n'
                  '    context, state,\n'
                  '  ) {\n'
                  '    return AdaptiveTextSelectionToolbar\n'
                  '      .editableText(\n'
                  '        clipboardStatus:\n'
                  '          ClipboardStatusNotifier(),\n'
                  '        anchors:\n'
                  '          state.contextMenuAnchors,\n'
                  '        ...,\n'
                  '      );\n'
                  '  },\n'
                  ')',
                ),
                const SizedBox(height: 8),
                _menuItemRow('Copy', 'Ctrl/Cmd+C', true),
                _menuItemRow('Select All', 'Ctrl/Cmd+A', true),
                _menuItemRow('Share', 'Platform-specific', false),
                _menuItemRow('Look Up', 'macOS only', false),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Gesture log ──
          if (_gestureLog.isNotEmpty) ...[
            _buildSectionTitle('Gesture Log'),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 100),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kSubtle),
              ),
              child: ListView.builder(
                itemCount: _gestureLog.length,
                itemBuilder: (_, i) {
                  return Text(
                    _gestureLog[i],
                    style: const TextStyle(
                      color: _kDimText,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: 12),

          _buildInfoBanner(
            'SelectableRegionState builds different gesture recognizer sets '
            'depending on the input device kind. Mouse input uses click+drag, '
            'while touch uses long-press to initiate selection.',
          ),
        ],
      ),
    );
  }

  Widget _gestureRow(String name, String desc, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: _kPrimary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                      color: _kAccent,
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    )),
                Text(desc,
                    style: const TextStyle(color: _kDimText, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _deviceChip(String label, String value, IconData icon) {
    final selected = _selectedDevice == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedDevice = value),
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14,
                color: selected ? _kAccent : _kDimText),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: selected ? _kAccent : _kDimText,
                fontSize: 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceDetail() {
    final data = _deviceData[_selectedDevice]!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: data['color'] as Color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['title'] as String,
            style: TextStyle(
              color: data['color'] as Color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          ...(data['gestures'] as List<String>).map(
            (g) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: data['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(g,
                        style:
                            const TextStyle(color: _kDimText, fontSize: 11)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, Map<String, dynamic>> get _deviceData => {
        'mouse': {
          'title': 'Mouse Input',
          'color': _kHighlight,
          'gestures': [
            'Click: Place cursor / dismiss selection',
            'Click + drag: Start selection at click, extend with drag',
            'Double-click: Select word',
            'Triple-click: Select paragraph',
            'Right-click: Open context menu',
            'Shift + click: Extend selection to click position',
          ],
        },
        'touch': {
          'title': 'Touch Input',
          'color': _kSelected,
          'gestures': [
            'Tap: Place cursor',
            'Long press: Start selection at position',
            'Long press + drag: Extend selection',
            'Double tap: Select word',
            'Drag handles: Adjust selection bounds',
            'Tap outside: Dismiss selection',
          ],
        },
        'stylus': {
          'title': 'Stylus / Pencil Input',
          'color': _kAccent,
          'gestures': [
            'Touch: Same as finger touch',
            'Barrel button: Context menu (platform)',
            'Hover: May show cursor preview',
            'Handwriting: StylusHandwriting cause for input',
          ],
        },
      };

  Widget _buildGestureTestArea() {
    return GestureDetector(
      onTap: () => _logGesture('tap'),
      onDoubleTap: () => _logGesture('doubleTap'),
      onLongPress: () => _logGesture('longPress'),
      onPanStart: (_) => _logGesture('panStart'),
      onPanUpdate: (_) {},
      onPanEnd: (_) => _logGesture('panEnd'),
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kPrimary.withValues(alpha: 0.3)),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.touch_app, size: 24, color: _kPrimary),
              SizedBox(height: 4),
              Text(
                'Tap, long-press, or drag here to see gesture events',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logGesture(String type) {
    setState(() {
      _gestureLog.insert(0, type);
      if (_gestureLog.length > 20) _gestureLog.removeLast();
    });
  }

  Widget _menuItemRow(String name, String shortcut, bool standard) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            standard ? Icons.check : Icons.remove,
            size: 12,
            color: standard ? _kSelected : _kDimText,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(name,
                style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ),
          Text(shortcut,
              style: const TextStyle(
                color: _kDimText,
                fontSize: 10,
                fontFamily: 'monospace',
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Architecture
// ═══════════════════════════════════════════════════════════════════════════════

class _ArchitectureTab extends StatefulWidget {
  const _ArchitectureTab();
  @override
  State<_ArchitectureTab> createState() => _ArchitectureTabState();
}

class _ArchitectureTabState extends State<_ArchitectureTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedArch = 'registrar';
  bool _expandActions = false;
  bool _expandFocus = false;

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
          // ── Architecture views ──
          _buildSectionTitle('Architecture Components'),
          const SizedBox(height: 8),
          Row(
            children: [
              _archChip('Registrar', 'registrar'),
              const SizedBox(width: 8),
              _archChip('Delegate', 'delegate'),
              const SizedBox(width: 8),
              _archChip('Lifecycle', 'lifecycle'),
            ],
          ),
          const SizedBox(height: 12),
          _buildArchDetail(),
          const SizedBox(height: 16),

          // ── Interface implementation ──
          _buildSectionTitle('Interface Implementation'),
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
                _interfaceRow(
                  'TextSelectionDelegate',
                  'Provides textEditingValue, copy/paste methods',
                  _kAccent,
                ),
                const Divider(color: _kSubtle, height: 16),
                _interfaceRow(
                  'SelectionRegistrar',
                  'add(Selectable) / remove(Selectable)',
                  _kHighlight,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Actions system ──
          _buildSectionTitle('Actions System'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() => _expandActions = !_expandActions),
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
                        'Registered Actions',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _expandActions
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandActions) ...[
                    const SizedBox(height: 8),
                    _actionRow('SelectAllTextIntent',
                        'Select all selectable content'),
                    _actionRow('CopySelectionTextIntent',
                        'Copy selection to clipboard'),
                    _actionRow('ExtendSelectionToDocumentBoundaryIntent',
                        'Extend to start/end of document'),
                    _actionRow('ExtendSelectionToNextWordBoundaryIntent',
                        'Extend by word'),
                    _actionRow('ExtendSelectionByCharacterIntent',
                        'Extend by character'),
                    _actionRow('ExtendSelectionToLineBreakIntent',
                        'Extend to line break'),
                    _actionRow('ExtendSelectionVerticallyToAdjacentLineIntent',
                        'Extend to adjacent line'),
                    _actionRow('GranularlyExtendSelectionTextIntent',
                        'Extend with granularity'),
                    _actionRow('DirectionalFocusIntent',
                        'Navigate focus directionally'),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Focus management ──
          _buildSectionTitle('Focus Management'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() => _expandFocus = !_expandFocus),
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
                        'Focus Behavior',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _expandFocus
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandFocus) ...[
                    const SizedBox(height: 8),
                    _focusRow('_focusNode',
                        'Owns a FocusNode for keyboard input'),
                    _focusRow('_handleFocusChanged',
                        'Shows/hides selection overlay on focus change'),
                    _focusRow('skipTraversal: false',
                        'Participates in tab traversal'),
                    _focusRow('canRequestFocus: true',
                        'Can be focused programmatically'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: _kSurface,
                      child: const Text(
                        'When focused: keyboard shortcuts active,\n'
                        'selection handles visible, toolbar available.\n'
                        'When unfocused: selection cleared, overlay hidden.',
                        style: TextStyle(
                          color: _kDimText,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Orientation handling ──
          _buildSectionTitle('Orientation Handling'),
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
                  'On device orientation change:',
                  style: TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _flowNode('didChangeMetrics() callback', _kDimText),
                _flowConnector(),
                _flowNode('Check _lastOrientation changed', _kHighlight),
                _flowConnector(),
                _flowNode('Hide toolbar (prevents overlap)', _kWarning),
                _flowConnector(),
                _flowNode('Keep selection (only toolbar hidden)', _kSelected),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'SelectableRegionState is a complex State class (~1500 LOC in '
            'the framework). It bridges gesture input, the registrar system '
            'for Selectable children, the selection overlay, and the keyboard '
            'shortcut/action system. SelectionArea provides a simpler API.',
          ),
        ],
      ),
    );
  }

  Widget _archChip(String label, String value) {
    final selected = _selectedArch == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedArch = value),
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

  Widget _buildArchDetail() {
    switch (_selectedArch) {
      case 'registrar':
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
                'SelectionRegistrar Pattern',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              _buildCodeBlock(
                '// SelectableRegionState implements:\n'
                'abstract interface class SelectionRegistrar {\n'
                '  void add(Selectable selectable);\n'
                '  void remove(Selectable selectable);\n'
                '}\n'
                '\n'
                '// Child widgets call:\n'
                'SelectionContainer.maybeOf(context)\n'
                '  ?.registrar\n'
                '  ?.add(this);',
              ),
              const SizedBox(height: 8),
              const Text(
                'Children register themselves during initState. The state '
                'tracks all Selectables to dispatch selection events.',
                style: TextStyle(color: _kDimText, fontSize: 10),
              ),
            ],
          ),
        );
      case 'delegate':
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
                'Selection Delegate Hierarchy',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              _hierarchyRow('SelectableRegionState', 'Top-level coordinator',
                  true),
              _hierarchyArrow(),
              _hierarchyRow('_selectionDelegate',
                  'StaticSelectionContainerDelegate', false),
              _hierarchyArrow(),
              _hierarchyRow('_selectable',
                  'Single child (SelectionContainer)', false),
              _hierarchyArrow(),
              _hierarchyRow('children',
                  'Individual Selectable widgets', false),
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
                'Lifecycle',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              _lifecycleRow('initState',
                  'Create focus node, gesture recognizers'),
              _lifecycleRow('didChangeDependencies',
                  'Read MediaQuery orientation'),
              _lifecycleRow('build',
                  'Wrap child with gesture detector, Actions, Focus'),
              _lifecycleRow('didChangeMetrics',
                  'Handle orientation change, hide toolbar'),
              _lifecycleRow('dispose',
                  'Dispose overlay, recognizers, focus, layer links'),
            ],
          ),
        );
    }
  }

  Widget _hierarchyRow(String name, String desc, bool current) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: current ? _kAccent : _kPrimary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                    color: current ? _kAccent : Colors.white70,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: current ? FontWeight.w700 : FontWeight.w500,
                  )),
              Text(desc,
                  style: const TextStyle(color: _kDimText, fontSize: 9)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _hierarchyArrow() {
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

  Widget _lifecycleRow(String phase, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              phase,
              style: const TextStyle(
                color: _kAccent,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(color: _kDimText, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _interfaceRow(String name, String desc, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  )),
              Text(desc,
                  style: const TextStyle(color: _kDimText, fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionRow(String name, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.play_arrow, size: 12, color: _kPrimary),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    )),
                Text(desc,
                    style: const TextStyle(color: _kDimText, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _focusRow(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.adjust, size: 12, color: _kHighlight),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                      color: _kAccent,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    )),
                Text(desc,
                    style: const TextStyle(color: _kDimText, fontSize: 9)),
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
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Widget _propRow(String name, String type, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            type,
            style: const TextStyle(
              color: _kHighlight,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(color: _kDimText, fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

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
