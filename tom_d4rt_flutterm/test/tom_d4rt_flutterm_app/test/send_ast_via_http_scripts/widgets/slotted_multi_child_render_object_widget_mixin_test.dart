import 'package:flutter/material.dart';

const Color _p = Color(0xFF1A237E);
const Color _a = Color(0xFFFFF176);
const Color _bg = Color(0xFF0C1020);
const Color _panel = Color(0xFF1A2140);
const Color _panel2 = Color(0xFF25305A);
const Color _txt = Color(0xFFC0CAE8);
const Color _ok = Color(0xFF66BB6A);
const Color _warn = Color(0xFFFFB74D);
const Color _err = Color(0xFFEF5350);
const Color _info = Color(0xFF4FC3F7);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _p,
        secondary: _a,
        surface: _panel,
      ),
    ),
    home: const _SlottedMultiChildRenderObjectWidgetMixinDemo(),
  );
}

class _SlottedMultiChildRenderObjectWidgetMixinDemo extends StatefulWidget {
  const _SlottedMultiChildRenderObjectWidgetMixinDemo();

  @override
  State<_SlottedMultiChildRenderObjectWidgetMixinDemo> createState() =>
      _SlottedMultiChildRenderObjectWidgetMixinDemoState();
}

class _SlottedMultiChildRenderObjectWidgetMixinDemoState
    extends State<_SlottedMultiChildRenderObjectWidgetMixinDemo>
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
          'SlottedMultiChildRenderObjectWidgetMixin',
          style: TextStyle(color: _a, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _a,
          labelColor: _a,
          unselectedLabelColor: _txt,
          tabs: const [
            Tab(text: 'Deprecation'),
            Tab(text: 'Legacy Pattern'),
            Tab(text: 'Migration Guide'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _DeprecationTab(),
          _LegacyPatternTab(),
          _MigrationGuideTab(),
        ],
      ),
    );
  }
}

class _DeprecationTab extends StatefulWidget {
  const _DeprecationTab();

  @override
  State<_DeprecationTab> createState() => _DeprecationTabState();
}

class _DeprecationTabState extends State<_DeprecationTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final detail = _deprecationDetails[_selected];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Status Overview'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('This mixin is deprecated and retained for backward compatibility scenarios.'),
                _Bullet('Preferred replacement: SlottedMultiChildRenderObjectWidget class.'),
                _Bullet('Migration removes mixin-style composition and standardizes inheritance patterns.'),
                _Bullet('Slot-based architecture remains valid; only widget-side API shape changes.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Deprecation Facets'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_deprecationDetails.length, (index) {
                    final active = index == _selected;
                    return GestureDetector(
                      onTap: () => setState(() => _selected = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active
                              ? _deprecationDetails[index].color.withValues(alpha: 0.18)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: active ? _deprecationDetails[index].color : _panel2,
                          ),
                        ),
                        child: Text(
                          _deprecationDetails[index].title,
                          style: TextStyle(
                            color: active ? _deprecationDetails[index].color : _txt,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _detailCard(detail),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Legacy vs Replacement Structure'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: const [
                _CompareRow(
                  left: 'Legacy',
                  right: 'class MyWidget extends RenderObjectWidget with SlottedMultiChildRenderObjectWidgetMixin<Slot, RenderBox>',
                  color: _warn,
                ),
                _CompareRow(
                  left: 'Replacement',
                  right: 'class MyWidget extends SlottedMultiChildRenderObjectWidget<Slot, RenderBox>',
                  color: _ok,
                ),
                _CompareRow(
                  left: 'Benefit',
                  right: 'Clearer inheritance and fewer mixed responsibilities in widget definition.',
                  color: _info,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Deprecation Banner Preview'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _err.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _err.withValues(alpha: 0.8)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@Deprecated after v3.10.0-1.5.pre',
                    style: TextStyle(color: _err, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Use SlottedMultiChildRenderObjectWidget instead.',
                    style: TextStyle(color: _txt, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailCard(_Detail detail) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: detail.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: detail.color.withValues(alpha: 0.75)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.summary,
            style: const TextStyle(color: _txt, fontSize: 11),
          ),
          const SizedBox(height: 8),
          ...detail.points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.fiber_manual_record, size: 8, color: detail.color),
                  const SizedBox(width: 6),
                  Expanded(child: Text(p, style: const TextStyle(color: _txt, fontSize: 10))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegacyPatternTab extends StatefulWidget {
  const _LegacyPatternTab();

  @override
  State<_LegacyPatternTab> createState() => _LegacyPatternTabState();
}

class _LegacyPatternTabState extends State<_LegacyPatternTab>
    with AutomaticKeepAliveClientMixin {
  bool _showLeading = true;
  bool _showBody = true;
  bool _showTrailing = true;
  bool _showBanner = false;
  final List<String> _ops = <String>[];

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
          _title('Legacy Mixin Slot Model'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This playground mimics slot declarations from the deprecated mixin-based widget API.',
                  style: TextStyle(color: _txt, fontSize: 11),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _slotToggle('leading', _showLeading, _info,
                        () => _toggle(() => _showLeading = !_showLeading, 'leading')),
                    _slotToggle('body', _showBody, _a,
                        () => _toggle(() => _showBody = !_showBody, 'body')),
                    _slotToggle('trailing', _showTrailing, _warn,
                        () => _toggle(() => _showTrailing = !_showTrailing, 'trailing')),
                    _slotToggle('banner', _showBanner, _ok,
                        () => _toggle(() => _showBanner = !_showBanner, 'banner')),
                  ],
                ),
                const SizedBox(height: 10),
                _code(
                  'Iterable<Slot> get slots => Slot.values;\n'
                  'Widget? childForSlot(Slot slot) {\n'
                  '  switch(slot) { ... }\n'
                  '}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Slot Composition Canvas'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              height: 280,
              decoration: BoxDecoration(
                color: _panel2,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _p.withValues(alpha: 0.8)),
              ),
              child: Stack(
                children: [
                  if (_showBanner)
                    Positioned(
                      top: 10,
                      left: 10,
                      right: 10,
                      height: 32,
                      child: _slotBlock('banner', _ok),
                    ),
                  if (_showLeading)
                    Positioned(
                      left: 10,
                      top: _showBanner ? 48 : 10,
                      bottom: 10,
                      width: 56,
                      child: _slotBlock('leading', _info),
                    ),
                  if (_showTrailing)
                    Positioned(
                      right: 10,
                      top: _showBanner ? 48 : 10,
                      bottom: 10,
                      width: 56,
                      child: _slotBlock('trailing', _warn),
                    ),
                  if (_showBody)
                    Positioned(
                      top: _showBanner ? 48 : 10,
                      left: _showLeading ? 72 : 10,
                      right: _showTrailing ? 72 : 10,
                      bottom: 10,
                      child: _slotBlock('body', _a),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('createElement and updateRenderObject Hooks'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: const [
                _StepRow(
                  step: '1',
                  title: 'createElement()',
                  desc: 'Returns SlottedRenderObjectElement<SlotType, ChildType>.',
                ),
                _Arrow(),
                _StepRow(
                  step: '2',
                  title: 'createRenderObject(context)',
                  desc: 'Creates render object that mixes in SlottedContainerRenderObjectMixin.',
                ),
                _Arrow(),
                _StepRow(
                  step: '3',
                  title: 'updateRenderObject(context, renderObject)',
                  desc: 'Pushes widget configuration changes into render object fields.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Legacy Event Timeline'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _panel2),
              ),
              child: _ops.isEmpty
                  ? const Center(
                      child: Text('No slot updates yet.', style: TextStyle(color: _txt, fontSize: 11)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _ops.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: _panel,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _ops[index],
                            style: const TextStyle(color: _a, fontSize: 10, fontFamily: 'monospace'),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _slotToggle(String label, bool value, Color color, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: value ? color.withValues(alpha: 0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: value ? color : _panel2),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: value ? color : _txt,
            fontSize: 11,
            fontWeight: value ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _slotBlock(String name, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Text(name, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
    );
  }

  void _toggle(VoidCallback update, String slot) {
    setState(update);
    _push('slot toggled: $slot');
  }

  void _push(String msg) {
    final t = TimeOfDay.now().format(context);
    setState(() {
      _ops.insert(0, '$t | $msg');
      if (_ops.length > 24) {
        _ops.removeLast();
      }
    });
  }
}

class _MigrationGuideTab extends StatefulWidget {
  const _MigrationGuideTab();

  @override
  State<_MigrationGuideTab> createState() => _MigrationGuideTabState();
}

class _MigrationGuideTabState extends State<_MigrationGuideTab>
    with AutomaticKeepAliveClientMixin {
  int _step = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final guide = _migrationSteps[_step];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Migration Checklist'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_migrationSteps.length, (index) {
                    final active = index == _step;
                    return GestureDetector(
                      onTap: () => setState(() => _step = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active
                              ? _migrationSteps[index].color.withValues(alpha: 0.18)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: active ? _migrationSteps[index].color : _panel2,
                          ),
                        ),
                        child: Text(
                          'Step ${index + 1}',
                          style: TextStyle(
                            color: active ? _migrationSteps[index].color : _txt,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _guideCard(guide),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Before and After Code'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Before (deprecated mixin):', style: TextStyle(color: _warn, fontSize: 11, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _code(
                  'class LegacyWidget extends RenderObjectWidget\n'
                  '  with SlottedMultiChildRenderObjectWidgetMixin<MySlot, RenderBox> {\n'
                  '  @override Iterable<MySlot> get slots => MySlot.values;\n'
                  '  @override Widget? childForSlot(MySlot slot) => ...;\n'
                  '}',
                ),
                const SizedBox(height: 8),
                const Text('After (preferred class):', style: TextStyle(color: _ok, fontSize: 11, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _code(
                  'class ModernWidget extends SlottedMultiChildRenderObjectWidget<MySlot, RenderBox> {\n'
                  '  @override Iterable<MySlot> get slots => MySlot.values;\n'
                  '  @override Widget? childForSlot(MySlot slot) => ...;\n'
                  '}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Validation Recommendations'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('Verify all slots are still represented and named consistently in diagnostics.'),
                _Bullet('Check createElement/createRenderObject behavior remains equivalent.'),
                _Bullet('Run layout and hit-test scenarios with optional slot combinations.'),
                _Bullet('Keep child keys stable when slot children can swap widgets at runtime.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _guideCard(_MigrationStep step) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: step.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: step.color.withValues(alpha: 0.75)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step.title,
            style: TextStyle(color: step.color, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(step.description, style: const TextStyle(color: _txt, fontSize: 11)),
          const SizedBox(height: 8),
          ...step.notes.map(
            (n) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, size: 14, color: step.color),
                  const SizedBox(width: 6),
                  Expanded(child: Text(n, style: const TextStyle(color: _txt, fontSize: 10))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Detail {
  const _Detail({
    required this.title,
    required this.summary,
    required this.points,
    required this.color,
  });

  final String title;
  final String summary;
  final List<String> points;
  final Color color;
}

class _MigrationStep {
  const _MigrationStep({
    required this.title,
    required this.description,
    required this.notes,
    required this.color,
  });

  final String title;
  final String description;
  final List<String> notes;
  final Color color;
}

const List<_Detail> _deprecationDetails = [
  _Detail(
    title: 'Annotation intent',
    summary: 'Deprecation marks this API as transitional and discourages new usage.',
    points: [
      'Existing code may continue to compile for compatibility windows.',
      'New implementations should choose replacement APIs directly.',
    ],
    color: _err,
  ),
  _Detail(
    title: 'API shape',
    summary: 'Mixin-based composition on RenderObjectWidget is replaced by direct class inheritance.',
    points: [
      'Reduces surface ambiguity around responsibilities.',
      'Keeps slot-centric child model intact.',
    ],
    color: _info,
  ),
  _Detail(
    title: 'Tooling impact',
    summary: 'Migration improves consistency with modern widget/render object patterns.',
    points: [
      'Easier discoverability for new contributors.',
      'Cleaner diagnostics and maintenance over time.',
    ],
    color: _ok,
  ),
];

const List<_MigrationStep> _migrationSteps = [
  _MigrationStep(
    title: 'Replace base declaration',
    description: 'Switch from RenderObjectWidget + mixin to SlottedMultiChildRenderObjectWidget inheritance.',
    notes: [
      'Keep same SlotType and ChildType generic arguments.',
      'Keep slots getter and childForSlot logic intact initially.',
    ],
    color: _info,
  ),
  _MigrationStep(
    title: 'Move overrides unchanged',
    description: 'Port createRenderObject and updateRenderObject methods directly.',
    notes: [
      'Behavior should remain equivalent at first migration pass.',
      'Run widget tests or manual slot toggles to confirm parity.',
    ],
    color: _warn,
  ),
  _MigrationStep(
    title: 'Validate diagnostics and slots',
    description: 'Ensure debug names and slot wiring remain correct.',
    notes: [
      'Check inspector output for child slot names.',
      'Confirm optional/null slots remain supported.',
    ],
    color: _ok,
  ),
  _MigrationStep(
    title: 'Remove deprecated imports/usages',
    description: 'Finalize migration by deleting old mixin references from codebase.',
    notes: [
      'Prevents future breakage when deprecation window closes.',
      'Keeps code aligned with current Flutter architecture style.',
    ],
    color: _a,
  ),
];

class _CompareRow extends StatelessWidget {
  const _CompareRow({required this.left, required this.right, required this.color});

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
            width: 90,
            child: Text(
              left,
              style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: Text(right, style: const TextStyle(color: _txt, fontSize: 10))),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.step, required this.title, required this.desc});

  final String step;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _panel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.withValues(alpha: 0.7)),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _a.withValues(alpha: 0.2),
              border: Border.all(color: _a),
              shape: BoxShape.circle,
            ),
            child: Text(step, style: const TextStyle(color: _a, fontSize: 10, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: _a, fontSize: 11, fontWeight: FontWeight.w700)),
                Text(desc, style: const TextStyle(color: _txt, fontSize: 10)),
              ],
            ),
          ),
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
      child: Icon(Icons.arrow_downward_rounded, size: 14, color: _txt),
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
            decoration: const BoxDecoration(color: _a, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _txt, fontSize: 11))),
        ],
      ),
    );
  }
}

Widget _title(String text) {
  return Text(
    text,
    style: const TextStyle(color: _a, fontSize: 14, fontWeight: FontWeight.w700),
  );
}

Widget _panelBox({required Widget child}) {
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

Widget _code(String value) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _panel2),
    ),
    child: Text(
      value,
      style: const TextStyle(color: _a, fontFamily: 'monospace', fontSize: 10),
    ),
  );
}
