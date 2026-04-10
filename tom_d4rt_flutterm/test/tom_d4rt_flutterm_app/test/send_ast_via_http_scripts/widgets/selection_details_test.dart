// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for SelectionDetails.
///
/// SelectionDetails is an abstract final class providing selection range
/// and status information. Accessed via SelectionListenerNotifier.selection.
///
/// Demonstrates:
/// - Tab 1 (Anatomy): Abstract final class concept, properties, hierarchy
/// - Tab 2 (Status): SelectionStatus enum states, transition flow, detail cards
/// - Tab 3 (Integration): SelectionListenerNotifier, SelectionListener widget,
///   live SelectionArea with real-time details tracking

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF1A237E); // Indigo 900
const Color _kAccent = Color(0xFFF4FF81); // Lime A100
const Color _kSurface = Color(0xFF18181C);
const Color _kCard = Color(0xFF28282C);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF38383C);
const Color _kHighlight = Color(0xFF42A5F5);
const Color _kSelected = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFEF5350);
const Color _kMuted = Color(0xFF7E57C2);

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
    home: const _DetailsDemo(),
  );
}

class _DetailsDemo extends StatefulWidget {
  const _DetailsDemo();
  @override
  State<_DetailsDemo> createState() => _DetailsDemoState();
}

class _DetailsDemoState extends State<_DetailsDemo>
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
          'SelectionDetails',
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
            Tab(text: 'Status'),
            Tab(text: 'Integration'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _AnatomyTab(),
          _StatusTab(),
          _IntegrationTab(),
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
  bool _expandProperties = false;
  bool _expandAbstractFinal = false;

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
            'abstract final class SelectionDetails {\n'
            '  SelectedContentRange? get range;\n'
            '  SelectionStatus get status;\n'
            '}',
          ),
          const SizedBox(height: 16),

          // ── Abstract final concept ──
          GestureDetector(
            onTap: () =>
                setState(() => _expandAbstractFinal = !_expandAbstractFinal),
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
                      const Icon(Icons.lock_outline, size: 16,
                          color: _kWarning),
                      const SizedBox(width: 8),
                      const Text(
                        'Abstract Final Class (Dart 3.0)',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _expandAbstractFinal
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandAbstractFinal) ...[
                    const SizedBox(height: 10),
                    _restrictionRow(
                      Icons.block,
                      'Cannot extend',
                      'No subclasses allowed outside library',
                      _kWarning,
                    ),
                    _restrictionRow(
                      Icons.do_not_disturb,
                      'Cannot implement',
                      'No external implementations',
                      _kWarning,
                    ),
                    _restrictionRow(
                      Icons.check_circle_outline,
                      'Private implementations',
                      'Framework provides internal concrete classes',
                      _kSelected,
                    ),
                    _restrictionRow(
                      Icons.visibility,
                      'Read-only contract',
                      'Only expose getters, no mutability',
                      _kHighlight,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Abstract final classes define a contract that only '
                      'the declaring library can fulfill. This ensures the '
                      'framework controls all implementations.',
                      style: TextStyle(color: _kDimText, fontSize: 10),
                    ),
                  ],
                ],
              ),
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
                _hierNode('SelectionDetails (abstract final)', true, _kAccent),
                _hierArrow(),
                _hierNode('_SelectionDetailsImpl (private)', false, _kMuted),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  color: _kSurface,
                  child: const Text(
                    'Concrete implementation is private to the framework.\n'
                    'Users only interact via the abstract interface.',
                    style: TextStyle(
                      color: _kDimText,
                      fontSize: 9,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Properties ──
          GestureDetector(
            onTap: () =>
                setState(() => _expandProperties = !_expandProperties),
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
                        'Properties',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _expandProperties
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_expandProperties) ...[
                    const SizedBox(height: 10),
                    _propertyCard(
                      'range',
                      'SelectedContentRange?',
                      'Contains start and end offsets of the selected content '
                          'relative to the SelectionListener. Returns null when '
                          'nothing is selected.',
                      _kHighlight,
                    ),
                    const SizedBox(height: 8),
                    _propertyCard(
                      'status',
                      'SelectionStatus',
                      'Indicates the current selection state: none (no selection), '
                          'collapsed (caret position only), or uncollapsed (range '
                          'of text selected).',
                      _kSelected,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── SelectedContentRange ──
          _buildSectionTitle('SelectedContentRange'),
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
                _buildCodeBlock(
                  'class SelectedContentRange {\n'
                  '  final int startOffset;\n'
                  '  final int endOffset;\n'
                  '  \n'
                  '  const SelectedContentRange({\n'
                  '    required this.startOffset,\n'
                  '    required this.endOffset,\n'
                  '  });\n'
                  '}',
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _rangeField('startOffset', '0', _kHighlight),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 12,
                        color: _kDimText),
                    const SizedBox(width: 8),
                    _rangeField('endOffset', '42', _kSelected),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Offsets are local to the SelectionListener, not global.',
                  style: TextStyle(color: _kDimText, fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'SelectionDetails is the read-only interface for selection '
            'information. You never create it directly — it\'s provided '
            'by the framework through SelectionListenerNotifier.selection.',
          ),
        ],
      ),
    );
  }

  Widget _restrictionRow(
      IconData icon, String label, String desc, Color color) {
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
                Text(label,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
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
        child: Container(
            width: 1, height: 10,
            color: _kDimText.withValues(alpha: 0.3)),
      ),
    );
  }

  Widget _propertyCard(
      String name, String type, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  )),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kCard,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(type,
                    style: TextStyle(
                      color: color.withValues(alpha: 0.7),
                      fontSize: 9,
                      fontFamily: 'monospace',
                    )),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(desc,
              style: const TextStyle(color: _kDimText, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _rangeField(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(label,
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                )),
            Text(value,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Status
// ═══════════════════════════════════════════════════════════════════════════════

class _StatusTab extends StatefulWidget {
  const _StatusTab();
  @override
  State<_StatusTab> createState() => _StatusTabState();
}

class _StatusTabState extends State<_StatusTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedStatus = 0; // 0=none, 1=collapsed, 2=uncollapsed
  bool _showTransitions = false;

  static const _statusNames = ['none', 'collapsed', 'uncollapsed'];
  static const _statusDescriptions = [
    'No text is currently selected. The SelectionArea or '
        'SelectableRegion has no active selection.',
    'A caret is placed in the text without a range. The selection '
        'start and end are at the same position (like a blinking cursor).',
    'A range of text is actively selected. The selection has '
        'distinct start and end positions covering one or more characters.',
  ];
  static const _statusIcons = [
    Icons.deselect,
    Icons.text_fields,
    Icons.select_all,
  ];
  static const _statusColors = [_kDimText, _kHighlight, _kSelected];

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
          // ── Enum definition ──
          _buildSectionTitle('SelectionStatus Enum'),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'enum SelectionStatus {\n'
            '  none,       // No selection\n'
            '  collapsed,  // Caret position only\n'
            '  uncollapsed // Range selected\n'
            '}',
          ),
          const SizedBox(height: 16),

          // ── Status cards ──
          _buildSectionTitle('Select a Status'),
          const SizedBox(height: 8),
          Row(
            children: List.generate(3, (i) {
              final selected = _selectedStatus == i;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: i > 0 ? 6 : 0, right: i < 2 ? 0 : 0),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedStatus = i),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selected
                            ? _statusColors[i].withValues(alpha: 0.15)
                            : _kCard,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selected
                              ? _statusColors[i]
                              : _kSubtle,
                          width: selected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(_statusIcons[i],
                              size: 20, color: _statusColors[i]),
                          const SizedBox(height: 4),
                          Text(
                            _statusNames[i],
                            style: TextStyle(
                              color: _statusColors[i],
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),

          // ── Selected status detail ──
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: _statusColors[_selectedStatus]
                      .withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(_statusIcons[_selectedStatus],
                        size: 16,
                        color: _statusColors[_selectedStatus]),
                    const SizedBox(width: 8),
                    Text(
                      'SelectionStatus.${_statusNames[_selectedStatus]}',
                      style: TextStyle(
                        color: _statusColors[_selectedStatus],
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _statusDescriptions[_selectedStatus],
                  style: const TextStyle(color: _kDimText, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _buildStatusVisual(_selectedStatus),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Visual representation ──
          _buildSectionTitle('Visual Text Selection States'),
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
                _textStateRow('Hello World', -1, -1, 'none', _kDimText),
                const SizedBox(height: 8),
                _textStateRow('Hello World', 5, 5, 'collapsed', _kHighlight),
                const SizedBox(height: 8),
                _textStateRow(
                    'Hello World', 0, 5, 'uncollapsed', _kSelected),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Transition flow ──
          GestureDetector(
            onTap: () =>
                setState(() => _showTransitions = !_showTransitions),
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
                        'Status Transitions',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _showTransitions
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 18,
                        color: _kDimText,
                      ),
                    ],
                  ),
                  if (_showTransitions) ...[
                    const SizedBox(height: 10),
                    _transitionRow('none', 'collapsed',
                        'User taps to place caret', _kHighlight),
                    _transitionRow('collapsed', 'uncollapsed',
                        'User drags to select text', _kSelected),
                    _transitionRow('uncollapsed', 'collapsed',
                        'User taps to collapse selection', _kHighlight),
                    _transitionRow('uncollapsed', 'none',
                        'User taps outside selection area', _kDimText),
                    _transitionRow('collapsed', 'none',
                        'User removes caret (programmatic)', _kDimText),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'SelectionStatus drives conditional rendering logic. '
            'Check status before accessing range — range is null when '
            'status is none, and has startOffset == endOffset when collapsed.',
          ),
        ],
      ),
    );
  }

  Widget _buildStatusVisual(int idx) {
    switch (idx) {
      case 0:
        return Container(
          padding: const EdgeInsets.all(8),
          color: _kSurface,
          child: const Row(
            children: [
              Text('The quick brown fox',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
              SizedBox(width: 8),
              Text('← no selection markers',
                  style: TextStyle(color: _kDimText, fontSize: 9)),
            ],
          ),
        );
      case 1:
        return Container(
          padding: const EdgeInsets.all(8),
          color: _kSurface,
          child: Row(
            children: [
              const Text('The q',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
              Container(width: 1, height: 16, color: _kHighlight),
              const Text('uick brown fox',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(width: 8),
              const Text('← caret at offset 5',
                  style: TextStyle(color: _kDimText, fontSize: 9)),
            ],
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.all(8),
          color: _kSurface,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                color: _kSelected.withValues(alpha: 0.3),
                child: const Text('The q',
                    style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
              const Text('uick brown fox',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(width: 8),
              const Text('← range [0..5]',
                  style: TextStyle(color: _kDimText, fontSize: 9)),
            ],
          ),
        );
    }
  }

  Widget _textStateRow(
      String text, int start, int end, String label, Color color) {
    final chars = text.split('');
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              )),
        ),
        Expanded(
          child: Row(
            children: List.generate(chars.length, (i) {
              final isSelected =
                  start >= 0 && end >= 0 && start != end &&
                  i >= start && i < end;
              final isCaret = start == end && i == start;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isCaret)
                    Container(
                        width: 1, height: 14, color: _kHighlight),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1),
                    color: isSelected
                        ? color.withValues(alpha: 0.3)
                        : Colors.transparent,
                    child: Text(
                      chars[i],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white54,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _transitionRow(
      String from, String to, String reason, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(from,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 10,
                  fontFamily: 'monospace',
                )),
          ),
          Icon(Icons.arrow_forward, size: 12, color: color),
          const SizedBox(width: 4),
          SizedBox(
            width: 70,
            child: Text(to,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                )),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(reason,
                style: const TextStyle(color: _kDimText, fontSize: 9)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Integration
// ═══════════════════════════════════════════════════════════════════════════════

class _IntegrationTab extends StatefulWidget {
  const _IntegrationTab();
  @override
  State<_IntegrationTab> createState() => _IntegrationTabState();
}

class _IntegrationTabState extends State<_IntegrationTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedView = 'pattern';
  bool _showCode = false;

  // Live selection tracking
  String _selectionStatus = 'none';
  String _selectionText = '';
  int _changeCount = 0;

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
              _viewChip('Usage Pattern', 'pattern'),
              const SizedBox(width: 8),
              _viewChip('Live Demo', 'live'),
              const SizedBox(width: 8),
              _viewChip('Notifier', 'notifier'),
            ],
          ),
          const SizedBox(height: 16),

          if (_selectedView == 'pattern') _buildPatternView(),
          if (_selectedView == 'live') _buildLiveView(),
          if (_selectedView == 'notifier') _buildNotifierView(),
        ],
      ),
    );
  }

  Widget _buildPatternView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Widget Wiring Pattern'),
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
              _flowNode('1. Create SelectionListenerNotifier',
                  _kHighlight, 'In initState'),
              _flowConnector(),
              _flowNode('2. Wrap with SelectionListener',
                  _kAccent, 'Provide notifier and child'),
              _flowConnector(),
              _flowNode('3. Place SelectionArea inside',
                  _kSelected, 'Enables text selection'),
              _flowConnector(),
              _flowNode('4. Access notifier.selection',
                  _kMuted, 'Get SelectionDetails'),
              _flowConnector(),
              _flowNode('5. Read status and range',
                  _kWarning, 'React to selection changes'),
            ],
          ),
        ),
        const SizedBox(height: 12),

        GestureDetector(
          onTap: () => setState(() => _showCode = !_showCode),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Full Code Pattern',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        )),
                    const Spacer(),
                    Icon(
                      _showCode ? Icons.expand_less : Icons.expand_more,
                      size: 16,
                      color: _kDimText,
                    ),
                  ],
                ),
                if (_showCode) ...[
                  const SizedBox(height: 8),
                  _buildCodeBlock(
                    'class MyWidget extends StatefulWidget {\n'
                    '  @override\n'
                    '  State<MyWidget> createState() =>\n'
                    '    _MyWidgetState();\n'
                    '}\n'
                    '\n'
                    'class _MyWidgetState extends State<MyWidget> {\n'
                    '  final _notifier =\n'
                    '    SelectionListenerNotifier();\n'
                    '\n'
                    '  @override\n'
                    '  void initState() {\n'
                    '    super.initState();\n'
                    '    _notifier.addListener(_onChange);\n'
                    '  }\n'
                    '\n'
                    '  void _onChange() {\n'
                    '    final details = _notifier.selection;\n'
                    '    print(details.status);\n'
                    '    print(details.range?.startOffset);\n'
                    '  }\n'
                    '\n'
                    '  @override\n'
                    '  Widget build(BuildContext context) {\n'
                    '    return SelectionListener(\n'
                    '      notifier: _notifier,\n'
                    '      child: SelectionArea(\n'
                    '        child: Text(\'Selectable\'),\n'
                    '      ),\n'
                    '    );\n'
                    '  }\n'
                    '\n'
                    '  @override\n'
                    '  void dispose() {\n'
                    '    _notifier.removeListener(_onChange);\n'
                    '    _notifier.dispose();\n'
                    '    super.dispose();\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        _buildInfoBanner(
          'The SelectionListener + SelectionListenerNotifier pattern '
          'is the recommended way to observe selection state changes '
          'reactively, rather than polling or rebuilding the entire tree.',
        ),
      ],
    );
  }

  Widget _buildLiveView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Live Selection Tracking'),
        const SizedBox(height: 8),

        // ── Selectable text area ──
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
                'Select text below to see details update:',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
              const SizedBox(height: 8),
              SelectionArea(
                onSelectionChanged: (value) {
                  setState(() {
                    _changeCount++;
                    if (value == null) {
                      _selectionStatus = 'none';
                      _selectionText = '';
                    } else {
                      final plain = value.plainText;
                      if (plain.isEmpty) {
                        _selectionStatus = 'collapsed';
                        _selectionText = '';
                      } else {
                        _selectionStatus = 'uncollapsed';
                        _selectionText = plain;
                      }
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: _kSurface,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flutter is Google\'s UI toolkit for building '
                        'beautiful, natively compiled applications for '
                        'mobile, web, and desktop from a single codebase.',
                        style: TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'SelectionDetails provides read-only access to '
                        'the current selection state, including the range '
                        'of selected text and the status of the selection.',
                        style: TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Status display ──
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
                'Current SelectionDetails:',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _detailRow('status', _selectionStatus, _statusColor),
              _detailRow('hasRange',
                  _selectionStatus != 'none' ? 'true' : 'false',
                  _kDimText),
              if (_selectionText.isNotEmpty)
                _detailRow('selectedText',
                    _selectionText.length > 30
                        ? '${_selectionText.substring(0, 30)}...'
                        : _selectionText,
                    _kHighlight),
              _detailRow(
                  'changeCount', '$_changeCount', _kMuted),
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
                    _selectionStatus = 'none';
                    _selectionText = '';
                    _changeCount = 0;
                  });
                },
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Reset',
                    style: TextStyle(fontSize: 11)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPrimary.withValues(alpha: 0.3),
                  foregroundColor: _kAccent,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color get _statusColor {
    switch (_selectionStatus) {
      case 'collapsed':
        return _kHighlight;
      case 'uncollapsed':
        return _kSelected;
      default:
        return _kDimText;
    }
  }

  Widget _buildNotifierView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('SelectionListenerNotifier'),
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
                'SelectionListenerNotifier',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'A ChangeNotifier that provides access to SelectionDetails. '
                'It must be connected to a SelectionListener widget to '
                'receive updates.',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
              const SizedBox(height: 12),
              _notifierPropRow('registered', 'bool',
                  'Whether connected to a SelectionListener', _kSelected),
              _notifierPropRow('selection', 'SelectionDetails',
                  'Current selection details (throws if not registered)',
                  _kHighlight),
              _notifierPropRow('addListener', 'void Function()',
                  'Subscribe to selection changes', _kMuted),
              _notifierPropRow('removeListener', 'void Function()',
                  'Unsubscribe from changes', _kDimText),
              _notifierPropRow('dispose', 'void',
                  'Clean up resources', _kWarning),
            ],
          ),
        ),
        const SizedBox(height: 16),

        _buildSectionTitle('SelectionListener Widget'),
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
              _buildCodeBlock(
                'SelectionListener(\n'
                '  notifier: myNotifier,\n'
                '  child: SelectionArea(\n'
                '    child: Text(\'Select me\'),\n'
                '  ),\n'
                ')',
              ),
              const SizedBox(height: 8),
              const Text(
                'SelectionListener wraps a subtree and feeds selection '
                'events to the notifier. It must be placed above the '
                'SelectionArea (or SelectableRegion) in the widget tree.',
                style: TextStyle(color: _kDimText, fontSize: 11),
              ),
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
              _relatedRow('SelectionDetails',
                  'Selection range + status (this demo)', _kAccent),
              _relatedRow('SelectionListenerNotifier',
                  'ChangeNotifier providing details', _kHighlight),
              _relatedRow('SelectionListener',
                  'Widget connecting notifier to tree', _kSelected),
              _relatedRow('SelectedContentRange',
                  'Start/end content offsets', _kMuted),
              _relatedRow('SelectionStatus',
                  'none / collapsed / uncollapsed', _kWarning),
              _relatedRow('SelectionArea',
                  'High-level selection host widget', _kDimText),
            ],
          ),
        ),
        const SizedBox(height: 12),

        _buildInfoBanner(
          'SelectionDetails is intentionally restrictive — as an abstract '
          'final class, it prevents external extension or mock implementations. '
          'This design ensures the framework remains the single source of '
          'truth for selection state.',
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

  Widget _flowNode(String text, Color color, String subtitle) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  )),
              Text(subtitle,
                  style: const TextStyle(color: _kDimText, fontSize: 9)),
            ],
          ),
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

  Widget _detailRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 10,
                  fontFamily: 'monospace',
                )),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                )),
          ),
        ],
      ),
    );
  }

  Widget _notifierPropRow(
      String name, String type, String desc, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: TextStyle(
                          color: color,
                          fontSize: 10,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(width: 6),
                    Text('→ $type',
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
            width: 130,
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
                style: const TextStyle(color: _kDimText, fontSize: 9)),
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
