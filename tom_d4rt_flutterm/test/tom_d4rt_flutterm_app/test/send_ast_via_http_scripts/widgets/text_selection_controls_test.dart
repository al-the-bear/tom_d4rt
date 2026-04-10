import 'package:flutter/material.dart';

const Color _bg = Color(0xFF16121A);
const Color _panel = Color(0xFF271F2D);
const Color _panel2 = Color(0xFF382D42);
const Color _text = Color(0xFFEBDCF5);
const Color _purple = Color(0xFFC9A7FF);
const Color _teal = Color(0xFF7DE3D1);
const Color _amber = Color(0xFFFFCF82);
const Color _pink = Color(0xFFFF9FC0);
const Color _blue = Color(0xFF95C4FF);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _purple,
        secondary: _teal,
        surface: _panel,
      ),
    ),
    home: const _TextSelectionControlsDemo(),
  );
}

class _TextSelectionControlsDemo extends StatefulWidget {
  const _TextSelectionControlsDemo();

  @override
  State<_TextSelectionControlsDemo> createState() => _TextSelectionControlsDemoState();
}

class _TextSelectionControlsDemoState extends State<_TextSelectionControlsDemo>
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
      appBar: AppBar(
        backgroundColor: _panel,
        title: const Text(
          'TextSelectionControls Deep Demo',
          style: TextStyle(color: _amber, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _amber,
          labelColor: _amber,
          unselectedLabelColor: _text,
          tabs: const [
            Tab(text: 'Control API'),
            Tab(text: 'Handle/Toolbar Lab'),
            Tab(text: 'Adaptation Guide'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ControlApiTab(),
          _HandleToolbarLabTab(),
          _AdaptationGuideTab(),
        ],
      ),
    );
  }
}

class _ControlApiTab extends StatefulWidget {
  const _ControlApiTab();

  @override
  State<_ControlApiTab> createState() => _ControlApiTabState();
}

class _ControlApiTabState extends State<_ControlApiTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _ApiFacet facet = _facets[_selected];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('What TextSelectionControls Provides'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('Defines visual and behavioral hooks for text selection handles and toolbars.'),
                _Bullet('Controls how copy/cut/paste/select-all actions are presented and triggered.'),
                _Bullet('Supports platform-adaptive interaction styling and semantics.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('API Facets'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_facets.length, (int i) {
                    final bool active = i == _selected;
                    final _ApiFacet f = _facets[i];
                    return GestureDetector(
                      onTap: () => setState(() => _selected = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? f.color.withValues(alpha: 0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: active ? f.color : _panel2),
                        ),
                        child: Text(
                          f.name,
                          style: TextStyle(
                            color: active ? f.color : _text,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _facetCard(facet),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Control Method Sketch'),
          const SizedBox(height: 8),
          _box(
            child: _code(
              'abstract class TextSelectionControls {\n'
              '  Size getHandleSize(double textLineHeight);\n'
              '  Widget buildHandle(BuildContext context, TextSelectionHandleType type, double lineHeight, [VoidCallback? onTap]);\n'
              '  Offset getHandleAnchor(TextSelectionHandleType type, double lineHeight);\n'
              '  Widget buildToolbar(BuildContext context, Rect globalEditableRegion, double lineHeight, Offset position, List<TextSelectionPoint> endpoints, TextSelectionDelegate delegate, ValueListenable<ClipboardStatus>? clipboardStatus, Offset? lastSecondaryTapDownPosition);\n'
              '  bool canSelectAll(TextSelectionDelegate delegate);\n'
              '}',
            ),
          ),
          const SizedBox(height: 14),
          _title('Responsibilities Overview'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              children: [
                _MapRow('Handle visuals', 'Shape, size, color, orientation of drag handles.', _purple),
                _MapRow('Handle anchors', 'Precise anchor offsets for start/end/collapsed selection.', _teal),
                _MapRow('Toolbar build', 'Action layout and command dispatch controls.', _amber),
                _MapRow('Capability checks', 'Gate Select All / Paste availability by delegate state.', _pink),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _facetCard(_ApiFacet facet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: facet.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: facet.color.withValues(alpha: 0.85)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(facet.summary, style: const TextStyle(color: _text, fontSize: 11)),
          const SizedBox(height: 8),
          ...facet.notes.map(
            (String n) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.chevron_right_rounded, color: facet.color, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(n, style: const TextStyle(color: _text, fontSize: 10))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HandleToolbarLabTab extends StatefulWidget {
  const _HandleToolbarLabTab();

  @override
  State<_HandleToolbarLabTab> createState() => _HandleToolbarLabTabState();
}

class _HandleToolbarLabTabState extends State<_HandleToolbarLabTab>
    with AutomaticKeepAliveClientMixin {
  bool _showHandles = true;
  bool _showToolbar = true;
  bool _canCopy = true;
  bool _canPaste = false;
  bool _canSelectAll = true;
  int _selectionMode = 0;
  final List<String> _timeline = <String>['Selection control lab initialized.'];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final String modeLabel = ['collapsed', 'range', 'full line'][_selectionMode];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Interactive Handle + Toolbar Lab'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                _switch('Show handles', _showHandles, _purple, (bool v) {
                  setState(() => _showHandles = v);
                  _push('show handles -> $v');
                }),
                _switch('Show toolbar', _showToolbar, _amber, (bool v) {
                  setState(() => _showToolbar = v);
                  _push('show toolbar -> $v');
                }),
                _switch('Copy available', _canCopy, _teal, (bool v) {
                  setState(() => _canCopy = v);
                  _push('copy available -> $v');
                }),
                _switch('Paste available', _canPaste, _blue, (bool v) {
                  setState(() => _canPaste = v);
                  _push('paste available -> $v');
                }),
                _switch('Select All available', _canSelectAll, _pink, (bool v) {
                  setState(() => _canSelectAll = v);
                  _push('select all available -> $v');
                }),
                const SizedBox(height: 8),
                const Text('Selection mode', style: TextStyle(color: _text, fontSize: 11)),
                SegmentedButton<int>(
                  segments: const [
                    ButtonSegment<int>(value: 0, label: Text('collapsed')),
                    ButtonSegment<int>(value: 1, label: Text('range')),
                    ButtonSegment<int>(value: 2, label: Text('full line')),
                  ],
                  selected: <int>{_selectionMode},
                  onSelectionChanged: (Set<int> next) {
                    final int value = next.first;
                    setState(() => _selectionMode = value);
                    _push('selection mode -> $value');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Selection Surface Preview'),
          const SizedBox(height: 8),
          _box(
            child: Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: _panel2,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _purple.withValues(alpha: 0.85)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 14,
                    right: 14,
                    top: 14,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _bg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _panel2),
                      ),
                      child: Text(
                        'Static text preview with mode: $modeLabel',
                        style: const TextStyle(color: _text, fontSize: 12),
                      ),
                    ),
                  ),
                  if (_showHandles) ...[
                    Positioned(
                      left: 36,
                      top: _selectionMode == 0 ? 94 : 118,
                      child: _handle(_selectionMode == 0 ? TextSelectionHandleType.collapsed : TextSelectionHandleType.left),
                    ),
                    Positioned(
                      right: 36,
                      top: 118,
                      child: _handle(_selectionMode == 0 ? TextSelectionHandleType.collapsed : TextSelectionHandleType.right),
                    ),
                  ],
                  if (_showToolbar)
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 16,
                      child: _toolbar(),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Action Availability Matrix'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                _actionRow('Copy', _canCopy, _teal),
                _actionRow('Paste', _canPaste, _blue),
                _actionRow('Select All', _canSelectAll, _pink),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Timeline'),
          const SizedBox(height: 8),
          _box(
            child: Container(
              height: 190,
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _panel2),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _timeline.length,
                itemBuilder: (BuildContext context, int index) {
                  final String row = _timeline[_timeline.length - 1 - index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(6)),
                    child: Text(row, style: const TextStyle(color: _amber, fontFamily: 'monospace', fontSize: 10)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _switch(String title, bool value, Color color, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      value: value,
      activeThumbColor: color,
      title: Text(title, style: const TextStyle(color: _text, fontSize: 11)),
      onChanged: onChanged,
    );
  }

  Widget _handle(TextSelectionHandleType type) {
    final Color color = switch (type) {
      TextSelectionHandleType.left => _purple,
      TextSelectionHandleType.right => _teal,
      TextSelectionHandleType.collapsed => _amber,
    };
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
    );
  }

  Widget _toolbar() {
    final List<_ActionChipData> chips = [
      _ActionChipData('Copy', _canCopy, _teal),
      _ActionChipData('Paste', _canPaste, _blue),
      _ActionChipData('Select All', _canSelectAll, _pink),
    ];
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _panel,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _amber.withValues(alpha: 0.8)),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: chips
            .where((c) => c.enabled)
            .map(
              (c) => GestureDetector(
                onTap: () => _push('action tapped -> ${c.label}'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                  decoration: BoxDecoration(
                    color: c.color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: c.color.withValues(alpha: 0.85)),
                  ),
                  child: Text(c.label, style: TextStyle(color: c.color, fontSize: 10, fontWeight: FontWeight.w700)),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _actionRow(String name, bool enabled, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: enabled ? color.withValues(alpha: 0.14) : _panel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: enabled ? color.withValues(alpha: 0.85) : _panel2),
      ),
      child: Row(
        children: [
          Expanded(child: Text(name, style: TextStyle(color: enabled ? color : _text, fontSize: 11, fontWeight: FontWeight.w700))),
          Text(enabled ? 'enabled' : 'disabled', style: TextStyle(color: enabled ? color : _text, fontSize: 10)),
        ],
      ),
    );
  }

  void _push(String event) {
    final String t = TimeOfDay.now().format(context);
    setState(() {
      _timeline.add('$t | $event');
      if (_timeline.length > 45) {
        _timeline.removeAt(0);
      }
    });
  }
}

class _AdaptationGuideTab extends StatefulWidget {
  const _AdaptationGuideTab();

  @override
  State<_AdaptationGuideTab> createState() => _AdaptationGuideTabState();
}

class _AdaptationGuideTabState extends State<_AdaptationGuideTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _Scenario scenario = _scenarios[_selected];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Context Adaptation Guide'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('Selection controls should adapt by platform, form factor, and input modality.'),
                _Bullet('Handle size, toolbar density, and action availability can vary per context.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Scenario Selector'),
          const SizedBox(height: 8),
          _box(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_scenarios.length, (int i) {
                final bool active = i == _selected;
                final _Scenario s = _scenarios[i];
                return GestureDetector(
                  onTap: () => setState(() => _selected = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: active ? s.color.withValues(alpha: 0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: active ? s.color : _panel2),
                    ),
                    child: Text(
                      s.name,
                      style: TextStyle(
                        color: active ? s.color : _text,
                        fontSize: 11,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 14),
          _title('Recommended Controls Policy'),
          const SizedBox(height: 8),
          _box(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: scenario.color.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: scenario.color.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(scenario.policy, style: TextStyle(color: scenario.color, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(scenario.reason, style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 8),
                  ...scenario.tips.map(
                    (String tip) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_rounded, size: 14, color: scenario.color),
                          const SizedBox(width: 5),
                          Expanded(child: Text(tip, style: const TextStyle(color: _text, fontSize: 10))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Pattern Matrix'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              children: [
                _MapRow('Phone touch', 'Larger handles, compact floating toolbar', _purple),
                _MapRow('Tablet stylus', 'Precise handles, expanded action set', _teal),
                _MapRow('Desktop mouse', 'Optional handles, menu-driven actions', _blue),
                _MapRow('Accessibility mode', 'High-contrast controls, semantic labels prioritized', _pink),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiFacet {
  const _ApiFacet({
    required this.name,
    required this.summary,
    required this.notes,
    required this.color,
  });

  final String name;
  final String summary;
  final List<String> notes;
  final Color color;
}

class _Scenario {
  const _Scenario({
    required this.name,
    required this.policy,
    required this.reason,
    required this.tips,
    required this.color,
  });

  final String name;
  final String policy;
  final String reason;
  final List<String> tips;
  final Color color;
}

class _ActionChipData {
  const _ActionChipData(this.label, this.enabled, this.color);

  final String label;
  final bool enabled;
  final Color color;
}

const List<_ApiFacet> _facets = [
  _ApiFacet(
    name: 'handles',
    summary: 'Control handle look and geometry for start/end/collapsed selection states.',
    notes: [
      'Different handle types may need distinct visuals or anchors.',
      'Line height influences perceived and actual touch affordance.',
    ],
    color: _purple,
  ),
  _ApiFacet(
    name: 'toolbar',
    summary: 'Build the action toolbar with context-specific commands and layout.',
    notes: [
      'Toolbar can vary by clipboard status and delegate capabilities.',
      'Action ordering should reflect product and platform conventions.',
    ],
    color: _amber,
  ),
  _ApiFacet(
    name: 'capabilities',
    summary: 'Report availability of actions like Select All under current delegate state.',
    notes: [
      'Avoid exposing unsupported actions for cleaner UX.',
      'Capability checks reduce invalid operation pathways.',
    ],
    color: _teal,
  ),
  _ApiFacet(
    name: 'adaptation',
    summary: 'Tune controls for touch, mouse, stylus, and accessibility contexts.',
    notes: [
      'Input mode and screen density influence control dimensions.',
      'Accessibility modes may require stronger contrast and semantics.',
    ],
    color: _pink,
  ),
];

const List<_Scenario> _scenarios = [
  _Scenario(
    name: 'Phone touch editing',
    policy: 'Large touch handles + compact toolbar',
    reason: 'Finger input needs forgiving targets and concise action rows.',
    tips: [
      'Prioritize Copy/Paste and Select All actions.',
      'Keep toolbar near selection but not occluding text.',
    ],
    color: _purple,
  ),
  _Scenario(
    name: 'Tablet stylus workflow',
    policy: 'Precise handles + expanded context actions',
    reason: 'Stylus allows higher precision and richer contextual tools.',
    tips: [
      'Include advanced actions like share/search if relevant.',
      'Preserve clear visual anchor for drag handles.',
    ],
    color: _teal,
  ),
  _Scenario(
    name: 'Desktop mouse selection',
    policy: 'Minimal handles + command menu style controls',
    reason: 'Mouse interaction often prefers menu patterns over touch handles.',
    tips: [
      'Allow keyboard shortcuts to mirror toolbar actions.',
      'Reduce handle noise in cursor-centric workflows.',
    ],
    color: _blue,
  ),
  _Scenario(
    name: 'Accessibility emphasis mode',
    policy: 'High contrast controls + semantic-first labels',
    reason: 'Users relying on assistive tech need reliable visibility and narration cues.',
    tips: [
      'Increase contrast and hit target size.',
      'Ensure action labels are explicit and localizable.',
    ],
    color: _pink,
  ),
];

class _MapRow extends StatelessWidget {
  const _MapRow(this.left, this.right, this.color);

  final String left;
  final String right;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 128,
            child: Text(left, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
          ),
          Expanded(child: Text(right, style: const TextStyle(color: _text, fontSize: 10))),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(color: _amber, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _text, fontSize: 11))),
        ],
      ),
    );
  }
}

Widget _title(String text) {
  return Text(
    text,
    style: const TextStyle(color: _amber, fontSize: 14, fontWeight: FontWeight.w700),
  );
}

Widget _box({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _panel2),
    ),
    child: child,
  );
}

Widget _code(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _panel2),
    ),
    child: Text(
      code,
      style: const TextStyle(color: _teal, fontSize: 10, fontFamily: 'monospace'),
    ),
  );
}
