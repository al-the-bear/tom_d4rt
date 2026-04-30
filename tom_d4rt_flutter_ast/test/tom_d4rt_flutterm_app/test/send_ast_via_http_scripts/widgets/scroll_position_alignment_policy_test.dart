// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  ScrollPositionAlignmentPolicy  –  Deep Visual Demo
//
//  Palette: Purple 700 / Amber 600
//  Tabs  : Theory · Policy Switcher · Side-by-Side
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('ScrollPositionAlignmentPolicy demo building');
  return _ScrollPositionAlignmentPolicyDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF7B1FA2); // Purple 700
const _kAccent = Color(0xFFFFB300); // Amber 600
const _kSurface = Color(0xFFF3E5F5); // Purple 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF311B92); // DeepPurple 900
const _kMuted = Color(0xFF7E57C2); // DeepPurple 400
const _kCodeBg = Color(0xFFEDE7F6); // DeepPurple 50
const _kHighlight = Color(0xFFFFF8E1); // Amber 50
const _kTargetBg = Color(0xFFFFD54F); // Amber 300
const _kSuccess = Color(0xFF2E7D32);
const _kExplicit = Color(0xFF1565C0); // Blue 800
const _kKeepEnd = Color(0xFFE65100); // Orange 900
const _kKeepStart = Color(0xFF2E7D32); // Green 800

class _ScrollPositionAlignmentPolicyDemo extends StatefulWidget {
  @override
  State<_ScrollPositionAlignmentPolicyDemo> createState() =>
      _ScrollPositionAlignmentPolicyDemoState();
}

class _ScrollPositionAlignmentPolicyDemoState
    extends State<_ScrollPositionAlignmentPolicyDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

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
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: Text('ScrollPositionAlignmentPolicy',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kAccent,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Theory'),
            Tab(text: 'Policy Switcher'),
            Tab(text: 'Side-by-Side'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _PolicySwitcherTab(),
          _SideBySideTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 1  –  Theory
// ═══════════════════════════════════════════════════════════
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Overview ────────────────────────────────────
        _sectionCard(
          'What is ScrollPositionAlignmentPolicy?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ScrollPositionAlignmentPolicy is an enum that controls how '
                'ScrollPosition.ensureVisible() aligns an object within the '
                'viewport. When you call Scrollable.ensureVisible(context), '
                'this policy determines the final scroll offset.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                'enum ScrollPositionAlignmentPolicy {\n'
                '  explicit,\n'
                '  keepVisibleAtEnd,\n'
                '  keepVisibleAtStart,\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Three policies ──────────────────────────────
        _buildPolicyCard(
          name: 'explicit',
          color: _kExplicit,
          icon: Icons.gps_fixed,
          description:
              'Uses the alignment parameter directly. An alignment of 0.0 '
              'places the object at the leading edge (top for vertical). '
              '0.5 centers it. 1.0 places it at the trailing edge (bottom).',
          code:
              'Scrollable.ensureVisible(\n'
              '  context,\n'
              '  alignment: 0.5, // center\n'
              '  alignmentPolicy:\n'
              '      ScrollPositionAlignmentPolicy.explicit,\n'
              ');',
          useCases: [
            'Scroll-to-top / scroll-to-center behaviors',
            'Page-based navigation with fixed alignment',
            'Centering a search result in view',
          ],
        ),
        SizedBox(height: 14),

        _buildPolicyCard(
          name: 'keepVisibleAtEnd',
          color: _kKeepEnd,
          icon: Icons.vertical_align_bottom,
          description:
              'If the object extends below the viewport bottom, scrolls just '
              'enough to bring its bottom edge into view. If it is already '
              'fully visible, does nothing. Ignores the alignment parameter.',
          code:
              'Scrollable.ensureVisible(\n'
              '  context,\n'
              '  alignmentPolicy:\n'
              '      ScrollPositionAlignmentPolicy\n'
              '          .keepVisibleAtEnd,\n'
              ');',
          useCases: [
            'Chat scroll — new messages appear at bottom',
            'Form validation — scroll to first error',
            'Log viewers — keep latest entry visible',
          ],
        ),
        SizedBox(height: 14),

        _buildPolicyCard(
          name: 'keepVisibleAtStart',
          color: _kKeepStart,
          icon: Icons.vertical_align_top,
          description:
              'If the object extends above the viewport top, scrolls just '
              'enough to bring its top edge into view. If already visible, '
              'does nothing. Ignores the alignment parameter.',
          code:
              'Scrollable.ensureVisible(\n'
              '  context,\n'
              '  alignmentPolicy:\n'
              '      ScrollPositionAlignmentPolicy\n'
              '          .keepVisibleAtStart,\n'
              ');',
          useCases: [
            'Table of contents — reveal headers at top',
            'Accordion expansion — show expanded section top',
            'List reorder — track moved item from start',
          ],
        ),
        SizedBox(height: 14),

        // ── Comparison table ────────────────────────────
        _sectionCard(
          'Policy Comparison',
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            children: [
              _tableRow(
                ['Policy', 'Uses alignment?', 'Scrolls if...', 'Typical use'],
                isHeader: true,
              ),
              _tableRow([
                'explicit',
                'Yes',
                'Always (to reach alignment)',
                'Precise positioning',
              ]),
              _tableRow([
                'keepVisibleAtEnd',
                'No',
                'Object below viewport',
                'Bottom-anchored content',
              ]),
              _tableRow([
                'keepVisibleAtStart',
                'No',
                'Object above viewport',
                'Top-anchored content',
              ]),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── How ensureVisible works ─────────────────────
        _sectionCard(
          'ensureVisible() Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stepRow('1', 'Find the target RenderObject',
                  'The framework walks up from the context to find the nearest Scrollable.'),
              _stepRow('2', 'Compute current visibility',
                  'Determines whether the object is above, below, or within the viewport.'),
              _stepRow('3', 'Apply policy',
                  'explicit: compute offset from alignment. keepVisibleAtEnd/Start: compute minimum scroll.'),
              _stepRow('4', 'Animate or jump',
                  'If a duration is given, animates to the offset. Otherwise jumps immediately.'),
              SizedBox(height: 8),
              _codeBlock(
                '// Full signature\n'
                'static Future<void> ensureVisible(\n'
                '  BuildContext context, {\n'
                '  double alignment = 0.0,\n'
                '  Duration duration = Duration.zero,\n'
                '  Curve curve = Curves.ease,\n'
                '  ScrollPositionAlignmentPolicy\n'
                '      alignmentPolicy =\n'
                '          ScrollPositionAlignmentPolicy.explicit,\n'
                '});',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Best practices ──────────────────────────────
        _sectionCard(
          'Best Practices',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bp(true,
                  'Use keepVisibleAtEnd for chat-like UIs where new content appears at the bottom.'),
              _bp(true,
                  'Use keepVisibleAtStart for expanding sections that push content down.'),
              _bp(true,
                  'Use explicit with alignment: 0.5 to center focused items (e.g., search results).'),
              _bp(false,
                  'Do NOT mix keepVisible policies with a non-zero alignment — the alignment is ignored.'),
              _bp(false,
                  'Avoid calling ensureVisible every frame — batch calls or debounce for performance.'),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPolicyCard({
    required String name,
    required Color color,
    required IconData icon,
    required String description,
    required String code,
    required List<String> useCases,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              SizedBox(width: 10),
              Text(name,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: color,
                      fontFamily: 'monospace')),
            ],
          ),
          SizedBox(height: 10),
          Text(description,
              style: TextStyle(
                  color: _kDarkText, fontSize: 13, height: 1.5)),
          SizedBox(height: 10),
          _codeBlock(code),
          SizedBox(height: 10),
          Text('Use cases:',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: _kMuted)),
          SizedBox(height: 4),
          ...useCases.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ',
                        style: TextStyle(color: color, fontSize: 12)),
                    Expanded(
                      child: Text(uc,
                          style: TextStyle(
                              fontSize: 12,
                              color: _kDarkText,
                              height: 1.3)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Policy Switcher
// ═══════════════════════════════════════════════════════════
class _PolicySwitcherTab extends StatefulWidget {
  @override
  State<_PolicySwitcherTab> createState() => _PolicySwitcherTabState();
}

class _PolicySwitcherTabState extends State<_PolicySwitcherTab> {
  static const _itemCount = 50;
  int _targetIndex = 25;
  double _alignment = 0.0;
  ScrollPositionAlignmentPolicy _policy =
      ScrollPositionAlignmentPolicy.explicit;
  final ScrollController _scrollCtrl = ScrollController();

  // Keys for ensureVisible
  final Map<int, GlobalKey> _keys = {};

  int _scrollCount = 0;
  final List<String> _log = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _itemCount; i++) {
      _keys[i] = GlobalKey();
    }
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToTarget() {
    final key = _keys[_targetIndex];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        alignment: _alignment,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignmentPolicy: _policy,
      );
      setState(() {
        _scrollCount++;
        _log.insert(
          0,
          '#$_scrollCount  ${_policy.name}  target=$_targetIndex  '
          'align=${_alignment.toStringAsFixed(1)}',
        );
        if (_log.length > 20) _log.removeLast();
      });
      print(
          'ensureVisible: policy=${_policy.name}, target=$_targetIndex, alignment=$_alignment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Controls ────────────────────────────────────
        Container(
          padding: EdgeInsets.all(12),
          color: _kPrimary.withOpacity(0.06),
          child: Column(
            children: [
              // Policy selector
              Row(
                children: [
                  Text('Policy:',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: _kDarkText)),
                  SizedBox(width: 8),
                  ..._buildPolicyButtons(),
                ],
              ),
              SizedBox(height: 8),
              // Target and alignment
              Row(
                children: [
                  Text('Target:',
                      style: TextStyle(
                          fontSize: 12, color: _kDarkText)),
                  SizedBox(width: 6),
                  SizedBox(
                    width: 60,
                    height: 34,
                    child: TextField(
                      controller: TextEditingController(
                          text: '$_targetIndex'),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 12),
                      onSubmitted: (v) {
                        final idx = int.tryParse(v);
                        if (idx != null && idx >= 0 && idx < _itemCount) {
                          setState(() => _targetIndex = idx);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Text('Alignment:',
                      style: TextStyle(
                          fontSize: 12, color: _kDarkText)),
                  SizedBox(width: 6),
                  SizedBox(
                    width: 140,
                    child: Slider(
                      value: _alignment,
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      label: _alignment.toStringAsFixed(1),
                      activeColor: _kAccent,
                      onChanged: (v) =>
                          setState(() => _alignment = v),
                    ),
                  ),
                  Text(_alignment.toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _kPrimary)),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: _scrollToTarget,
                    icon: Icon(Icons.my_location, size: 16),
                    label: Text('Scroll',
                        style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kPrimary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Main area ───────────────────────────────────
        Expanded(
          child: Row(
            children: [
              // Scroll list
              Expanded(
                flex: 3,
                child: ListView.builder(
                  controller: _scrollCtrl,
                  padding: EdgeInsets.all(12),
                  itemCount: _itemCount,
                  itemBuilder: (_, i) {
                    final isTarget = i == _targetIndex;
                    return Container(
                      key: _keys[i],
                      margin: EdgeInsets.only(bottom: 6),
                      padding: EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: isTarget ? _kTargetBg : _kCardBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isTarget
                              ? _kAccent
                              : Colors.grey.shade200,
                          width: isTarget ? 2 : 1,
                        ),
                        boxShadow: isTarget
                            ? [
                                BoxShadow(
                                  color:
                                      _kAccent.withOpacity(0.3),
                                  blurRadius: 8,
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isTarget
                                  ? _kPrimary
                                  : _kPrimary.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '$i',
                              style: TextStyle(
                                color: isTarget
                                    ? Colors.white
                                    : _kPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isTarget
                                      ? 'TARGET ITEM #$i'
                                      : 'Item #$i',
                                  style: TextStyle(
                                    fontWeight: isTarget
                                        ? FontWeight.w800
                                        : FontWeight.w500,
                                    fontSize: 13,
                                    color: isTarget
                                        ? _kPrimary
                                        : _kDarkText,
                                  ),
                                ),
                                Text(
                                  isTarget
                                      ? 'ensureVisible() targets this item'
                                      : 'Scroll content item',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: _kMuted),
                                ),
                              ],
                            ),
                          ),
                          if (isTarget)
                            Icon(Icons.star,
                                color: _kPrimary, size: 20),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Log panel
              Container(
                width: 260,
                decoration: BoxDecoration(
                  color: _kCardBg,
                  border: Border(
                      left: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: _kAccent.withOpacity(0.1),
                      child: Row(
                        children: [
                          Icon(Icons.receipt_long,
                              size: 16, color: _kAccent),
                          SizedBox(width: 6),
                          Text('Scroll Log',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: _kDarkText)),
                          Spacer(),
                          GestureDetector(
                            onTap: () => setState(() {
                              _log.clear();
                              _scrollCount = 0;
                            }),
                            child: Icon(Icons.delete_sweep,
                                size: 16, color: _kMuted),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _log.isEmpty
                          ? Center(
                              child: Text(
                                'Press "Scroll" to see\npolicy effects',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: _kMuted, fontSize: 12),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(6),
                              itemCount: _log.length,
                              itemBuilder: (_, i) {
                                final entry = _log[i];
                                Color rowColor = _kExplicit;
                                if (entry.contains('keepVisibleAtEnd')) {
                                  rowColor = _kKeepEnd;
                                } else if (entry
                                    .contains('keepVisibleAtStart')) {
                                  rowColor = _kKeepStart;
                                }
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 3),
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: rowColor
                                          .withOpacity(0.06),
                                      borderRadius:
                                          BorderRadius.circular(4),
                                      border: Border.all(
                                          color: rowColor
                                              .withOpacity(0.2)),
                                    ),
                                    child: Text(entry,
                                        style: TextStyle(
                                            fontFamily:
                                                'monospace',
                                            fontSize: 10,
                                            color: _kDarkText)),
                                  ),
                                );
                              },
                            ),
                    ),
                    // Quick-scroll presets
                    Container(
                      padding: EdgeInsets.all(8),
                      color: _kPrimary.withOpacity(0.04),
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [
                          _presetButton('Top (0)', 0),
                          _presetButton('#10', 10),
                          _presetButton('#25', 25),
                          _presetButton('#40', 40),
                          _presetButton('End (49)', 49),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPolicyButtons() {
    return ScrollPositionAlignmentPolicy.values.map((p) {
      final isActive = _policy == p;
      Color btnColor = _kExplicit;
      if (p == ScrollPositionAlignmentPolicy.keepVisibleAtEnd) {
        btnColor = _kKeepEnd;
      } else if (p == ScrollPositionAlignmentPolicy.keepVisibleAtStart) {
        btnColor = _kKeepStart;
      }
      return Padding(
        padding: EdgeInsets.only(right: 6),
        child: SizedBox(
          height: 30,
          child: ElevatedButton(
            onPressed: () => setState(() => _policy = p),
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive ? btnColor : Colors.white,
              foregroundColor: isActive ? Colors.white : btnColor,
              side: BorderSide(color: btnColor),
              padding: EdgeInsets.symmetric(horizontal: 10),
              elevation: isActive ? 2 : 0,
            ),
            child: Text(p.name, style: TextStyle(fontSize: 11)),
          ),
        ),
      );
    }).toList();
  }

  Widget _presetButton(String label, int idx) {
    return SizedBox(
      height: 26,
      child: OutlinedButton(
        onPressed: () {
          setState(() => _targetIndex = idx);
          Future.delayed(Duration(milliseconds: 50), _scrollToTarget);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: _kPrimary,
          side: BorderSide(color: _kPrimary.withOpacity(0.3)),
          padding: EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Text(label, style: TextStyle(fontSize: 10)),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Side-by-Side
// ═══════════════════════════════════════════════════════════
class _SideBySideTab extends StatefulWidget {
  @override
  State<_SideBySideTab> createState() => _SideBySideTabState();
}

class _SideBySideTabState extends State<_SideBySideTab> {
  static const _itemCount = 40;
  int _targetIndex = 20;
  double _alignment = 0.0;

  // Each column gets its own keys and scroll controller
  final Map<int, GlobalKey> _keysExplicit = {};
  final Map<int, GlobalKey> _keysEnd = {};
  final Map<int, GlobalKey> _keysStart = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _itemCount; i++) {
      _keysExplicit[i] = GlobalKey();
      _keysEnd[i] = GlobalKey();
      _keysStart[i] = GlobalKey();
    }
  }

  void _scrollAll() {
    // Explicit
    final ek = _keysExplicit[_targetIndex];
    if (ek?.currentContext != null) {
      Scrollable.ensureVisible(
        ek!.currentContext!,
        alignment: _alignment,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      );
    }
    // KeepVisibleAtEnd
    final enk = _keysEnd[_targetIndex];
    if (enk?.currentContext != null) {
      Scrollable.ensureVisible(
        enk!.currentContext!,
        alignment: _alignment,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
      );
    }
    // KeepVisibleAtStart
    final sk = _keysStart[_targetIndex];
    if (sk?.currentContext != null) {
      Scrollable.ensureVisible(
        sk!.currentContext!,
        alignment: _alignment,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      );
    }
    print('Side-by-side scroll: target=$_targetIndex, alignment=$_alignment');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Controls ────────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: _kPrimary.withOpacity(0.06),
          child: Row(
            children: [
              Text('Target item:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _kDarkText)),
              SizedBox(width: 6),
              _targetButton(5),
              _targetButton(10),
              _targetButton(20),
              _targetButton(30),
              _targetButton(38),
              SizedBox(width: 16),
              Text('Align:',
                  style: TextStyle(fontSize: 12, color: _kDarkText)),
              SizedBox(
                width: 100,
                child: Slider(
                  value: _alignment,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  activeColor: _kAccent,
                  onChanged: (v) => setState(() => _alignment = v),
                ),
              ),
              Text(_alignment.toStringAsFixed(1),
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: _kPrimary,
                      fontWeight: FontWeight.w600)),
              Spacer(),
              ElevatedButton.icon(
                onPressed: _scrollAll,
                icon: Icon(Icons.compare_arrows, size: 16),
                label: Text('Scroll All',
                    style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPrimary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),

        // ── Info card ───────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kAccent.withOpacity(0.3)),
            ),
            child: Text(
              'All three columns scroll to item #$_targetIndex '
              'simultaneously. Compare how each policy positions the target. '
              'The alignment slider only affects "explicit".',
              style: TextStyle(
                  fontSize: 11, color: _kDarkText, height: 1.3),
            ),
          ),
        ),

        // ── Three columns ───────────────────────────────
        Expanded(
          child: Row(
            children: [
              _buildColumn(
                title: 'explicit',
                color: _kExplicit,
                keys: _keysExplicit,
              ),
              Container(width: 1, color: Colors.grey.shade300),
              _buildColumn(
                title: 'keepVisibleAtEnd',
                color: _kKeepEnd,
                keys: _keysEnd,
              ),
              Container(width: 1, color: Colors.grey.shade300),
              _buildColumn(
                title: 'keepVisibleAtStart',
                color: _kKeepStart,
                keys: _keysStart,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColumn({
    required String title,
    required Color color,
    required Map<int, GlobalKey> keys,
  }) {
    return Expanded(
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            color: color.withOpacity(0.08),
            alignment: Alignment.center,
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    color: color,
                    fontFamily: 'monospace')),
          ),
          // List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(6),
              itemCount: _itemCount,
              itemBuilder: (_, i) {
                final isTarget = i == _targetIndex;
                return Container(
                  key: keys[i],
                  margin: EdgeInsets.only(bottom: 4),
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: isTarget
                        ? _kTargetBg
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isTarget
                          ? color
                          : Colors.grey.shade200,
                      width: isTarget ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: isTarget
                              ? color
                              : color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text('$i',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isTarget
                                    ? Colors.white
                                    : color)),
                      ),
                      SizedBox(width: 6),
                      Text(
                        isTarget ? 'TARGET' : 'Item $i',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isTarget
                              ? FontWeight.w800
                              : FontWeight.w400,
                          color: isTarget ? color : _kMuted,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _targetButton(int idx) {
    final isActive = _targetIndex == idx;
    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: SizedBox(
        height: 28,
        child: ElevatedButton(
          onPressed: () => setState(() => _targetIndex = idx),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isActive ? _kAccent : Colors.white,
            foregroundColor:
                isActive ? Colors.white : _kPrimary,
            side: BorderSide(
                color: isActive ? _kAccent : _kPrimary.withOpacity(0.3)),
            padding: EdgeInsets.symmetric(horizontal: 8),
            elevation: isActive ? 2 : 0,
          ),
          child: Text('#$idx', style: TextStyle(fontSize: 10)),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  Shared helpers
// ═══════════════════════════════════════════════════════════

Widget _sectionCard(String title, Widget child) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: _kPrimary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: _kDarkText)),
            ),
          ],
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kPrimary.withOpacity(0.15)),
    ),
    child: Text(code,
        style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: _kDarkText,
            height: 1.5)),
  );
}

Widget _stepRow(String num, String title, String detail) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: _kPrimary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(num,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: _kDarkText)),
              Text(detail,
                  style: TextStyle(
                      fontSize: 12, color: _kMuted, height: 1.3)),
            ],
          ),
        ),
      ],
    ),
  );
}

TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
  return TableRow(
    decoration: isHeader
        ? BoxDecoration(color: _kPrimary.withOpacity(0.08))
        : null,
    children: cells.map((c) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Text(c,
            style: TextStyle(
              fontSize: 11,
              fontWeight:
                  isHeader ? FontWeight.w700 : FontWeight.w400,
              color: isHeader ? _kPrimary : _kDarkText,
            )),
      );
    }).toList(),
  );
}

Widget _bp(bool isGood, String text) {
  final color = isGood ? _kSuccess : Color(0xFFC62828);
  final icon =
      isGood ? Icons.check_circle_outline : Icons.cancel_outlined;
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  fontSize: 12, color: _kDarkText, height: 1.4)),
        ),
      ],
    ),
  );
}
