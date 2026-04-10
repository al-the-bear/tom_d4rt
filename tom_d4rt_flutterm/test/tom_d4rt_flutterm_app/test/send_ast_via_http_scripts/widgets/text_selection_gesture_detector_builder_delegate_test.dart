import 'package:flutter/material.dart';

const Color _bg = Color(0xFF0F1A1A);
const Color _panel = Color(0xFF1A2B2B);
const Color _panel2 = Color(0xFF274040);
const Color _text = Color(0xFFD7EEEE);
const Color _teal = Color(0xFF6FE0D0);
const Color _lime = Color(0xFFB8E986);
const Color _orange = Color(0xFFFFBE7A);
const Color _rose = Color(0xFFFF9FAE);
const Color _sky = Color(0xFF90D3FF);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _teal,
        secondary: _orange,
        surface: _panel,
      ),
    ),
    home: const _GestureDelegateDeepDemo(),
  );
}

class _GestureDelegateDeepDemo extends StatefulWidget {
  const _GestureDelegateDeepDemo();

  @override
  State<_GestureDelegateDeepDemo> createState() => _GestureDelegateDeepDemoState();
}

class _GestureDelegateDeepDemoState extends State<_GestureDelegateDeepDemo>
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
          'TextSelectionGestureDetectorBuilderDelegate Deep Demo',
          style: TextStyle(color: _orange, fontWeight: FontWeight.w700, fontSize: 14),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _orange,
          labelColor: _orange,
          unselectedLabelColor: _text,
          tabs: const [
            Tab(text: 'Contract'),
            Tab(text: 'Gesture Timeline'),
            Tab(text: 'Patterns'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ContractTab(),
          _TimelineTab(),
          _PatternsTab(),
        ],
      ),
    );
  }
}

class _ContractTab extends StatefulWidget {
  const _ContractTab();

  @override
  State<_ContractTab> createState() => _ContractTabState();
}

class _ContractTabState extends State<_ContractTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _ContractItem item = _items[_selected];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Delegate Role'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('This delegate bridges raw gestures into text selection behavior for a text widget.'),
                _Bullet('It decides what a tap, long-press, drag, and force-press should do in context.'),
                _Bullet('It collaborates with selection controls and selection state machines.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Hook Families'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_items.length, (int index) {
                    final bool active = index == _selected;
                    final _ContractItem it = _items[index];
                    return GestureDetector(
                      onTap: () => setState(() => _selected = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active ? it.color.withValues(alpha: 0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: active ? it.color : _panel2),
                        ),
                        child: Text(
                          it.name,
                          style: TextStyle(
                            color: active ? it.color : _text,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _itemCard(item),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Delegate Method Sketch'),
          const SizedBox(height: 8),
          _box(
            child: _code(
              'abstract class TextSelectionGestureDetectorBuilderDelegate {\n'
              '  bool get selectionEnabled;\n'
              '  void hideToolbar([bool hideHandles = true]);\n'
              '  void selectPosition(SelectionChangedCause cause);\n'
              '  void selectWord(SelectionChangedCause cause);\n'
              '  void selectWordsInRange(Offset from, Offset to, SelectionChangedCause cause);\n'
              '  void bringIntoView(TextPosition position);\n'
              '}',
            ),
          ),
          const SizedBox(height: 14),
          _title('Interaction Pipeline'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              children: [
                _FlowRow('Gesture Recognizer', 'Normalizes pointer events into semantic gesture signals.', _teal),
                _FlowRow('Delegate', 'Interprets signal into selection intent.', _lime),
                _FlowRow('Selection State', 'Updates range/position and visibility state.', _orange),
                _FlowRow('Controls Layer', 'Shows handles/toolbar based on new state.', _rose),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemCard(_ContractItem item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: item.color.withValues(alpha: 0.85)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.summary, style: const TextStyle(color: _text, fontSize: 11)),
          const SizedBox(height: 8),
          ...item.notes.map(
            (String n) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.chevron_right_rounded, size: 16, color: item.color),
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

class _TimelineTab extends StatefulWidget {
  const _TimelineTab();

  @override
  State<_TimelineTab> createState() => _TimelineTabState();
}

class _TimelineTabState extends State<_TimelineTab>
    with AutomaticKeepAliveClientMixin {
  int _phase = 0;
  bool _doubleTapEnabled = true;
  bool _dragSelectionEnabled = true;
  bool _longPressEnabled = true;
  bool _forcePressEnabled = false;
  final List<String> _events = <String>['Gesture timeline initialized.'];

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
          _title('Gesture Arbitration Lab'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() => _phase = (_phase + 1) % 5);
                          _push('phase -> $_phase');
                        },
                        icon: const Icon(Icons.skip_next_rounded, size: 16),
                        label: const Text('Advance'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _phase = 0;
                            _events.clear();
                            _events.add('Gesture timeline reset.');
                          });
                        },
                        icon: const Icon(Icons.restart_alt_rounded, size: 16),
                        label: const Text('Reset'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _switch('Double tap selection', _doubleTapEnabled, _teal, (bool v) {
                  setState(() => _doubleTapEnabled = v);
                  _push('double tap -> $v');
                }),
                _switch('Drag selection', _dragSelectionEnabled, _lime, (bool v) {
                  setState(() => _dragSelectionEnabled = v);
                  _push('drag selection -> $v');
                }),
                _switch('Long press selection', _longPressEnabled, _orange, (bool v) {
                  setState(() => _longPressEnabled = v);
                  _push('long press -> $v');
                }),
                _switch('Force press selection', _forcePressEnabled, _rose, (bool v) {
                  setState(() => _forcePressEnabled = v);
                  _push('force press -> $v');
                }),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Timeline Pipeline'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              children: [
                _stage(0, 'Pointer Down', 'Gesture arena starts tracking potential text selection intent.', _teal),
                const _Arrow(),
                _stage(1, 'Gesture Classification', 'Tap/double-tap/long-press/drag candidate resolution.', _lime),
                const _Arrow(),
                _stage(2, 'Delegate Action', 'Delegate executes selectPosition/word/range behavior.', _orange),
                const _Arrow(),
                _stage(3, 'Selection State Update', 'Range and caret movement committed to model.', _rose),
                const _Arrow(),
                _stage(4, 'Controls Visibility', 'Toolbar and handles shown/hidden accordingly.', _sky),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Conflict Resolution Preview'),
          const SizedBox(height: 8),
          _box(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _decision(
                  'Double tap vs drag',
                  _doubleTapEnabled && _dragSelectionEnabled
                      ? 'double-tap timeout window determines whether drag can claim sequence.'
                      : 'only one path is active; no arbitration conflict.',
                  _teal,
                ),
                _decision(
                  'Long press precedence',
                  _longPressEnabled
                      ? 'long press can switch mode from caret placement to word/range selection.'
                      : 'long press path disabled; fallback to tap and drag paths.',
                  _orange,
                ),
                _decision(
                  'Force press behavior',
                  _forcePressEnabled
                      ? 'force press path enabled for pressure-capable devices.'
                      : 'force press disabled (common on many platforms).',
                  _rose,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Event Log'),
          const SizedBox(height: 8),
          _box(
            child: Container(
              height: 210,
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _panel2),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _events.length,
                itemBuilder: (BuildContext context, int index) {
                  final String row = _events[_events.length - 1 - index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(6)),
                    child: Text(row, style: const TextStyle(color: _orange, fontFamily: 'monospace', fontSize: 10)),
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
      title: Text(title, style: const TextStyle(color: _text, fontSize: 11)),
      value: value,
      activeThumbColor: color,
      onChanged: onChanged,
    );
  }

  Widget _stage(int index, String name, String desc, Color color) {
    final bool active = index <= _phase;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.16) : _panel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: active ? color.withValues(alpha: 0.85) : _panel2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(color: active ? color : _text, fontWeight: FontWeight.w700, fontSize: 11)),
          const SizedBox(height: 3),
          Text(desc, style: const TextStyle(color: _text, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _decision(String title, String body, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(color: _text, fontSize: 10)),
        ],
      ),
    );
  }

  void _push(String event) {
    final String t = TimeOfDay.now().format(context);
    setState(() {
      _events.add('$t | $event');
      if (_events.length > 45) {
        _events.removeAt(0);
      }
    });
  }
}

class _PatternsTab extends StatefulWidget {
  const _PatternsTab();

  @override
  State<_PatternsTab> createState() => _PatternsTabState();
}

class _PatternsTabState extends State<_PatternsTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedPattern = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _Pattern p = _patterns[_selectedPattern];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Delegate Composition Patterns'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('Most products should layer custom behavior on top of proven platform interaction defaults.'),
                _Bullet('Pattern choice depends on text domain: article reading, code editing, form fields, etc.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Pattern Picker'),
          const SizedBox(height: 8),
          _box(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_patterns.length, (int i) {
                final bool active = i == _selectedPattern;
                final _Pattern item = _patterns[i];
                return GestureDetector(
                  onTap: () => setState(() => _selectedPattern = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: active ? item.color.withValues(alpha: 0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: active ? item.color : _panel2),
                    ),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        color: active ? item.color : _text,
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
          _title('Pattern Detail'),
          const SizedBox(height: 8),
          _box(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: p.color.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: p.color.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.summary, style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 8),
                  ...p.points.map(
                    (String point) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_rounded, color: p.color, size: 14),
                          const SizedBox(width: 5),
                          Expanded(child: Text(point, style: const TextStyle(color: _text, fontSize: 10))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Template Snippet'),
          const SizedBox(height: 8),
          _box(child: _code(p.snippet)),
          const SizedBox(height: 14),
          _title('Risk Checklist'),
          const SizedBox(height: 8),
          _box(
            child: const Column(
              children: [
                _FlowRow('Gesture starvation', 'Ensure custom recognizers do not block text selection defaults.', _rose),
                _FlowRow('Over-selection', 'Avoid overly aggressive word-range extension on tap.', _orange),
                _FlowRow('Accessibility mismatch', 'Keep semantic actions aligned with visual behavior.', _sky),
                _FlowRow('Platform divergence', 'Avoid breaking familiar interaction patterns per platform.', _teal),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContractItem {
  const _ContractItem({
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

class _Pattern {
  const _Pattern({
    required this.name,
    required this.summary,
    required this.points,
    required this.snippet,
    required this.color,
  });

  final String name;
  final String summary;
  final List<String> points;
  final String snippet;
  final Color color;
}

const List<_ContractItem> _items = [
  _ContractItem(
    name: 'tap',
    summary: 'Tap paths typically place caret or adjust collapsed selection.',
    notes: [
      'Single tap often places caret.',
      'Double tap commonly selects word.',
    ],
    color: _teal,
  ),
  _ContractItem(
    name: 'long press',
    summary: 'Long press usually enters explicit selection mode with handles.',
    notes: [
      'Can select word and show toolbar on release.',
      'Useful fallback where double-tap is unreliable.',
    ],
    color: _orange,
  ),
  _ContractItem(
    name: 'drag',
    summary: 'Drag extends selection range while maintaining anchor semantics.',
    notes: [
      'Should preserve logical ordering and bounds clamping.',
      'Can auto-scroll in long documents.',
    ],
    color: _lime,
  ),
  _ContractItem(
    name: 'toolbar visibility',
    summary: 'Delegate may show/hide toolbar based on interaction phase and intent.',
    notes: [
      'Hide on scroll or external tap to reduce clutter.',
      'Show on stable range selection completion.',
    ],
    color: _rose,
  ),
  _ContractItem(
    name: 'bringIntoView',
    summary: 'Ensure selected position remains visible in scrollable contexts.',
    notes: [
      'Critical for keyboard navigation and accessibility.',
      'Helps preserve context after gesture updates.',
    ],
    color: _sky,
  ),
];

const List<_Pattern> _patterns = [
  _Pattern(
    name: 'Base-forwarding delegate',
    summary: 'Forward most behavior to default logic and override only specific hooks.',
    points: [
      'Lowest risk for platform consistency.',
      'Good first step for product customization.',
    ],
    snippet: 'class MyDelegate extends BaseDelegate {\n'
        '  @override\n'
        '  void onDoubleTap() {\n'
        '    super.onDoubleTap();\n'
        '    // custom telemetry\n'
        '  }\n'
        '}',
    color: _teal,
  ),
  _Pattern(
    name: 'Policy-driven delegate',
    summary: 'Delegate behavior gated by runtime policy flags and content type.',
    points: [
      'Useful for feature flags and role-specific editors.',
      'Keeps one implementation adaptable to many contexts.',
    ],
    snippet: 'if (policy.enableDragSelection) {\n'
        '  selectWordsInRange(...);\n'
        '} else {\n'
        '  selectWord(...);\n'
        '}',
    color: _lime,
  ),
  _Pattern(
    name: 'Accessibility-prioritized delegate',
    summary: 'Emphasize deterministic and semantic-friendly selection transitions.',
    points: [
      'Avoid hidden gesture-only paths for critical actions.',
      'Provide explicit toolbar and focus announcements.',
    ],
    snippet: 'if (isScreenReaderActive) {\n'
        '  showToolbarImmediately();\n'
        '  announceSelection();\n'
        '}',
    color: _rose,
  ),
  _Pattern(
    name: 'Domain-specific text delegate',
    summary: 'Specialize selection boundaries for code, tokens, or structured text.',
    points: [
      'Can snap ranges to token boundaries.',
      'Useful for IDE/editor experiences.',
    ],
    snippet: 'final range = tokenBoundaryResolver.resolve(position);\n'
        'applySelection(range.start, range.end);',
    color: _sky,
  ),
];

class _FlowRow extends StatelessWidget {
  const _FlowRow(this.left, this.right, this.color);

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
            width: 140,
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
            decoration: const BoxDecoration(color: _orange, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _text, fontSize: 11))),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Icon(Icons.south_rounded, size: 14, color: _text),
    );
  }
}

Widget _title(String text) {
  return Text(
    text,
    style: const TextStyle(color: _orange, fontSize: 14, fontWeight: FontWeight.w700),
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
