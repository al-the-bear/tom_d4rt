import 'package:flutter/material.dart';

const Color _p = Color(0xFF004D40);
const Color _a = Color(0xFFFFAB91);
const Color _bg = Color(0xFF0A1211);
const Color _panel = Color(0xFF122321);
const Color _panel2 = Color(0xFF1C3431);
const Color _txt = Color(0xFFB9CEC8);
const Color _ok = Color(0xFF81C784);
const Color _warn = Color(0xFFFFCA28);
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
    home: const _SlottedContainerRenderObjectMixinDemo(),
  );
}

class _SlottedContainerRenderObjectMixinDemo extends StatefulWidget {
  const _SlottedContainerRenderObjectMixinDemo();

  @override
  State<_SlottedContainerRenderObjectMixinDemo> createState() =>
      _SlottedContainerRenderObjectMixinDemoState();
}

class _SlottedContainerRenderObjectMixinDemoState
    extends State<_SlottedContainerRenderObjectMixinDemo>
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
          'SlottedContainerRenderObjectMixin',
          style: TextStyle(color: _a, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _a,
          labelColor: _a,
          unselectedLabelColor: _txt,
          tabs: const [
            Tab(text: 'Mixin Contract'),
            Tab(text: 'Slot Engine'),
            Tab(text: 'Layout Example'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _MixinContractTab(),
          _SlotEngineTab(),
          _LayoutExampleTab(),
        ],
      ),
    );
  }
}

class _MixinContractTab extends StatefulWidget {
  const _MixinContractTab();

  @override
  State<_MixinContractTab> createState() => _MixinContractTabState();
}

class _MixinContractTabState extends State<_MixinContractTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final api = _contract[_selected];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('What This Mixin Solves'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('Provides named slot child management for custom RenderObject containers.'),
                _Bullet('Replaces positional child assumptions with semantic slots (for example leading, body, trailing).'),
                _Bullet('Supplies attach, detach, redepth, visitChildren and debugDescribeChildren over slotted children.'),
                _Bullet('Pairs with SlottedRenderObjectElement and SlottedMultiChildRenderObjectWidget patterns.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('API Surface'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_contract.length, (index) {
                    final active = index == _selected;
                    return GestureDetector(
                      onTap: () => setState(() => _selected = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active
                              ? _contract[index].color.withValues(alpha: 0.18)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: active ? _contract[index].color : _panel2,
                          ),
                        ),
                        child: Text(
                          _contract[index].name,
                          style: TextStyle(
                            color: active ? _contract[index].color : _txt,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _apiCard(api),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Child Lifecycle Flow'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: const [
                _StepRow(
                  step: '1',
                  title: '_setChild(newChild, slot)',
                  desc: 'Resolve old child in slot, drop it if replaced, then adopt new child.',
                ),
                _Arrow(),
                _StepRow(
                  step: '2',
                  title: 'attach / detach',
                  desc: 'Iterate children getter and attach or detach pipeline owner recursively.',
                ),
                _Arrow(),
                _StepRow(
                  step: '3',
                  title: 'redepthChildren / visitChildren',
                  desc: 'Maintain render tree depth and traversal semantics across all slots.',
                ),
                _Arrow(),
                _StepRow(
                  step: '4',
                  title: 'debugDescribeChildren',
                  desc: 'Expose per-slot diagnostics with debugNameForSlot labels.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Generic Signature'),
          const SizedBox(height: 8),
          _panelBox(
            child: _code(
              'mixin SlottedContainerRenderObjectMixin<SlotType, ChildType extends RenderObject>\n'
              '    on RenderObject {\n'
              '  ChildType? childForSlot(SlotType slot);\n'
              '  Iterable<ChildType> get children;\n'
              '  String debugNameForSlot(SlotType slot);\n'
              '  // plus attach, detach, visit, debug helpers\n'
              '}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _apiCard(_ContractSpec spec) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: spec.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: spec.color.withValues(alpha: 0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            spec.signature,
            style: TextStyle(
              color: spec.color,
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(spec.description, style: const TextStyle(color: _txt, fontSize: 11)),
          const SizedBox(height: 8),
          ...spec.notes.map(
            (n) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.fiber_manual_record, size: 8, color: spec.color),
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

class _SlotEngineTab extends StatefulWidget {
  const _SlotEngineTab();

  @override
  State<_SlotEngineTab> createState() => _SlotEngineTabState();
}

class _SlotEngineTabState extends State<_SlotEngineTab>
    with AutomaticKeepAliveClientMixin {
  final Map<_SlotName, _SlotChild?> _slotMap = <_SlotName, _SlotChild?>{
    _SlotName.leading: const _SlotChild('Avatar', _info),
    _SlotName.header: const _SlotChild('Header', _ok),
    _SlotName.body: const _SlotChild('Body', _a),
    _SlotName.footer: const _SlotChild('Footer', _warn),
    _SlotName.trailing: const _SlotChild('Actions', _err),
  };

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
          _title('Slot to Child Map Playground'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _SlotName.values.map((slot) {
                    final child = _slotMap[slot];
                    final occupied = child != null;
                    final color = occupied ? child.color : _txt;
                    return Container(
                      width: 160,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: occupied
                            ? color.withValues(alpha: 0.16)
                            : _panel2,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: occupied ? color.withValues(alpha: 0.85) : _p,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(slot.name,
                              style: TextStyle(
                                color: occupied ? color : _txt,
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                              )),
                          const SizedBox(height: 4),
                          Text(
                            occupied ? child.label : 'empty',
                            style: const TextStyle(color: _txt, fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  }).toList(growable: false),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _action('setChild(header)', _ok, () {
                      _setChild(_SlotName.header, const _SlotChild('Updated Header', _ok));
                    }),
                    _action('setChild(body)', _a, () {
                      _setChild(_SlotName.body, const _SlotChild('Main Content', _a));
                    }),
                    _action('dropChild(trailing)', _err, () {
                      _setChild(_SlotName.trailing, null);
                    }),
                    _action('restore all', _info, () {
                      setState(() {
                        _slotMap[_SlotName.leading] = const _SlotChild('Avatar', _info);
                        _slotMap[_SlotName.header] = const _SlotChild('Header', _ok);
                        _slotMap[_SlotName.body] = const _SlotChild('Body', _a);
                        _slotMap[_SlotName.footer] = const _SlotChild('Footer', _warn);
                        _slotMap[_SlotName.trailing] = const _SlotChild('Actions', _err);
                      });
                      _push('slot map restored to defaults');
                    }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Core Operation Trace'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _code(
                  'void _setChild(ChildType? child, SlotType slot) {\n'
                  '  final oldChild = _slotToChild[slot];\n'
                  '  if (oldChild != null) dropChild(oldChild);\n'
                  '  if (child != null) adoptChild(child);\n'
                  '  _slotToChild[slot] = child;\n'
                  '}',
                ),
                const SizedBox(height: 8),
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: _bg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _panel2),
                  ),
                  child: _ops.isEmpty
                      ? const Center(
                          child: Text('No operations yet.', style: TextStyle(color: _txt, fontSize: 11)),
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
                                style: const TextStyle(
                                  color: _a,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('children Getter Semantics'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'children should return non-null child objects in desired traversal order. For rendering, paint, hit-test, and diagnostics, this order can matter.',
                  style: TextStyle(color: _txt, fontSize: 11),
                ),
                const SizedBox(height: 8),
                _code(
                  'Iterable<RenderBox> get children =>\n'
                  '  _slotToChild.values.whereType<RenderBox>();',
                ),
                const SizedBox(height: 8),
                const Text(
                  'Override when you need custom order, e.g. paint header behind body even if slot enum order differs.',
                  style: TextStyle(color: _txt, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setChild(_SlotName slot, _SlotChild? child) {
    final old = _slotMap[slot];
    setState(() {
      _slotMap[slot] = child;
    });
    _push(
      '_setChild(slot: ${slot.name}, old: ${old?.label ?? 'null'}, new: ${child?.label ?? 'null'})',
    );
  }

  void _push(String msg) {
    final t = TimeOfDay.now().format(context);
    setState(() {
      _ops.insert(0, '$t | $msg');
      if (_ops.length > 28) {
        _ops.removeLast();
      }
    });
  }
}

class _LayoutExampleTab extends StatefulWidget {
  const _LayoutExampleTab();

  @override
  State<_LayoutExampleTab> createState() => _LayoutExampleTabState();
}

class _LayoutExampleTabState extends State<_LayoutExampleTab>
    with AutomaticKeepAliveClientMixin {
  bool _showLeading = true;
  bool _showTrailing = true;
  bool _denseBody = false;
  bool _showFooter = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final headerHeight = 56.0;
    final footerHeight = _showFooter ? 44.0 : 0.0;
    final bodyHeight = _denseBody ? 90.0 : 150.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Practical Slotted Layout Demonstration'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This preview emulates a slotted render object with semantic slots: leading, header, body, footer, trailing. Toggle each slot to observe layout adaptation.',
                  style: TextStyle(color: _txt, fontSize: 11),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _toggleButton('leading', _showLeading, _info,
                        () => setState(() => _showLeading = !_showLeading)),
                    _toggleButton('trailing', _showTrailing, _err,
                        () => setState(() => _showTrailing = !_showTrailing)),
                    _toggleButton('dense body', _denseBody, _warn,
                        () => setState(() => _denseBody = !_denseBody)),
                    _toggleButton('footer', _showFooter, _ok,
                        () => setState(() => _showFooter = !_showFooter)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Live Slot Frame'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              height: 320,
              decoration: BoxDecoration(
                color: _panel2,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _p.withValues(alpha: 0.8)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: _showLeading ? 68 : 12,
                    right: _showTrailing ? 68 : 12,
                    top: 12,
                    height: headerHeight,
                    child: _slotBlock('header', _ok, headerHeight),
                  ),
                  Positioned(
                    left: _showLeading ? 68 : 12,
                    right: _showTrailing ? 68 : 12,
                    top: 12 + headerHeight + 8,
                    height: bodyHeight,
                    child: _slotBlock('body', _a, bodyHeight),
                  ),
                  if (_showFooter)
                    Positioned(
                      left: _showLeading ? 68 : 12,
                      right: _showTrailing ? 68 : 12,
                      bottom: 12,
                      height: footerHeight,
                      child: _slotBlock('footer', _warn, footerHeight),
                    ),
                  if (_showLeading)
                    Positioned(
                      left: 12,
                      top: 12,
                      bottom: 12,
                      width: 48,
                      child: _slotBlock('leading', _info, null),
                    ),
                  if (_showTrailing)
                    Positioned(
                      right: 12,
                      top: 12,
                      bottom: 12,
                      width: 48,
                      child: _slotBlock('trailing', _err, null),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('debugDescribeChildren Preview'),
          const SizedBox(height: 8),
          _panelBox(
            child: _code(_debugDump(
              showLeading: _showLeading,
              showTrailing: _showTrailing,
              showFooter: _showFooter,
              denseBody: _denseBody,
            )),
          ),
          const SizedBox(height: 14),
          _title('When to Prefer Slots'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('Widget has semantic regions where children are optional and non-positional.'),
                _Bullet('You need stable identity per region across updates (header remains header regardless of child list order).'),
                _Bullet('Render object layout logic references named roles, not indexes.'),
                _Bullet('Diagnostics should report meaningful slot names for inspection tooling.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _slotBlock(String name, Color color, double? forcedHeight) {
    return Container(
      height: forcedHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.85)),
      ),
      child: Text(
        name,
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _toggleButton(String text, bool on, Color color, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: on ? color.withValues(alpha: 0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: on ? color : _panel2),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: on ? color : _txt,
            fontSize: 11,
            fontWeight: on ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String _debugDump({
    required bool showLeading,
    required bool showTrailing,
    required bool showFooter,
    required bool denseBody,
  }) {
    final rows = <String>[
      'SlottedContainerRenderObjectMixin diagnostics:',
      '  leading: ${showLeading ? 'RenderBox#leading' : 'null'}',
      '  header: RenderBox#header',
      '  body: RenderBox#body(height=${denseBody ? 90 : 150})',
      '  footer: ${showFooter ? 'RenderBox#footer' : 'null'}',
      '  trailing: ${showTrailing ? 'RenderBox#trailing' : 'null'}',
    ];
    return rows.join('\n');
  }
}

class _ContractSpec {
  const _ContractSpec({
    required this.name,
    required this.signature,
    required this.description,
    required this.notes,
    required this.color,
  });

  final String name;
  final String signature;
  final String description;
  final List<String> notes;
  final Color color;
}

enum _SlotName {
  leading,
  header,
  body,
  footer,
  trailing,
}

class _SlotChild {
  const _SlotChild(this.label, this.color);

  final String label;
  final Color color;
}

const List<_ContractSpec> _contract = [
  _ContractSpec(
    name: 'childForSlot',
    signature: 'ChildType? childForSlot(SlotType slot)',
    description: 'Returns child currently assigned to slot, or null if empty.',
    notes: [
      'Direct slot lookup used by layout and update logic.',
      'Can be O(1) with map-backed storage.',
    ],
    color: _info,
  ),
  _ContractSpec(
    name: 'children',
    signature: 'Iterable<ChildType> get children',
    description: 'Enumerates non-null children for traversal and attachment operations.',
    notes: [
      'Default often uses _slotToChild.values.whereType<ChildType>().',
      'Order may be overridden for special paint/hit-test behavior.',
    ],
    color: _ok,
  ),
  _ContractSpec(
    name: 'debugNameForSlot',
    signature: 'String debugNameForSlot(SlotType slot)',
    description: 'Provides human-readable slot names in diagnostics output.',
    notes: [
      'Enum slots commonly use slot.name.',
      'Improves inspector readability for complex render trees.',
    ],
    color: _warn,
  ),
  _ContractSpec(
    name: 'attach / detach',
    signature: 'void attach(PipelineOwner owner) / void detach()',
    description: 'Ensures slotted children are attached/detached with their parent.',
    notes: [
      'Call super first then propagate to each child.',
      'Critical for pipeline phases and rendering stability.',
    ],
    color: _a,
  ),
  _ContractSpec(
    name: '_setChild',
    signature: 'void _setChild(ChildType? child, SlotType slot)',
    description: 'Internal slot mutation helper that drops old child and adopts new child safely.',
    notes: [
      'Mirrors multi-child render object adopt/drop discipline.',
      'Keeps slot map coherent with render tree ownership.',
    ],
    color: _err,
  ),
];

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
        border: Border.all(color: _p.withValues(alpha: 0.75)),
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
            child: Text(step,
                style: const TextStyle(color: _a, fontSize: 10, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(color: _a, fontSize: 11, fontWeight: FontWeight.w700)),
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

Widget _action(String label, Color color, VoidCallback onTap) {
  return FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: color.withValues(alpha: 0.18),
      foregroundColor: color,
      side: BorderSide(color: color.withValues(alpha: 0.8)),
    ),
    onPressed: onTap,
    child: Text(label, style: const TextStyle(fontSize: 11)),
  );
}
