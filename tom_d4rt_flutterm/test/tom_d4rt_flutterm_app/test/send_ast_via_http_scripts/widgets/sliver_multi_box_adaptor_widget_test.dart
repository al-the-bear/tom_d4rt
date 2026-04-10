import 'package:flutter/material.dart';

const Color _p = Color(0xFF3E2723);
const Color _a = Color(0xFFFFE082);
const Color _bg = Color(0xFF120F0D);
const Color _panel = Color(0xFF231C17);
const Color _panel2 = Color(0xFF332920);
const Color _txt = Color(0xFFD0C2B5);
const Color _ok = Color(0xFF81C784);
const Color _warn = Color(0xFFFFB74D);
const Color _info = Color(0xFF4FC3F7);
const Color _err = Color(0xFFE57373);

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
    home: const _SliverMultiBoxAdaptorWidgetDemo(),
  );
}

class _SliverMultiBoxAdaptorWidgetDemo extends StatefulWidget {
  const _SliverMultiBoxAdaptorWidgetDemo();

  @override
  State<_SliverMultiBoxAdaptorWidgetDemo> createState() =>
      _SliverMultiBoxAdaptorWidgetDemoState();
}

class _SliverMultiBoxAdaptorWidgetDemoState
    extends State<_SliverMultiBoxAdaptorWidgetDemo>
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
          'SliverMultiBoxAdaptorWidget',
          style: TextStyle(color: _a, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _a,
          labelColor: _a,
          unselectedLabelColor: _txt,
          tabs: const [
            Tab(text: 'Base Contract'),
            Tab(text: 'Delegate Studio'),
            Tab(text: 'Sliver Gallery'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _BaseContractTab(),
          _DelegateStudioTab(),
          _SliverGalleryTab(),
        ],
      ),
    );
  }
}

class _BaseContractTab extends StatefulWidget {
  const _BaseContractTab();

  @override
  State<_BaseContractTab> createState() => _BaseContractTabState();
}

class _BaseContractTabState extends State<_BaseContractTab>
    with AutomaticKeepAliveClientMixin {
  int _selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final card = _contractCards[_selected];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Why This Base Class Exists'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('Defines shared mechanics for slivers that lazily supply multiple box children.'),
                _Bullet('Holds a SliverChildDelegate which encapsulates child production strategy.'),
                _Bullet('Creates SliverMultiBoxAdaptorElement automatically to manage child lifecycles.'),
                _Bullet('Subclasses provide createRenderObject to choose concrete render behavior.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Core Members'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List<Widget>.generate(_contractCards.length, (index) {
                    final active = index == _selected;
                    return GestureDetector(
                      onTap: () => setState(() => _selected = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: active
                              ? _contractCards[index].color.withValues(alpha: 0.18)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: active ? _contractCards[index].color : _panel2,
                          ),
                        ),
                        child: Text(
                          _contractCards[index].name,
                          style: TextStyle(
                            color: active ? _contractCards[index].color : _txt,
                            fontSize: 11,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                _contractCard(card),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Lifecycle Pipeline'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: const [
                _StepRow(
                  step: '1',
                  title: 'Widget config arrives',
                  desc: 'SliverMultiBoxAdaptorWidget stores delegate and subclass options.',
                ),
                _Arrow(),
                _StepRow(
                  step: '2',
                  title: 'createElement()',
                  desc: 'Base implementation creates SliverMultiBoxAdaptorElement.',
                ),
                _Arrow(),
                _StepRow(
                  step: '3',
                  title: 'createRenderObject()',
                  desc: 'Subclass returns specific RenderSliverMultiBoxAdaptor variant.',
                ),
                _Arrow(),
                _StepRow(
                  step: '4',
                  title: 'Lazy child requests',
                  desc: 'Render object asks element/manager to materialize children by index.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Subclass Matrix'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: const [
                _MatrixRow(left: 'SliverList', right: 'Linear layout with intrinsic item extents.'),
                _MatrixRow(left: 'SliverFixedExtentList', right: 'Constant item extent for faster scroll metrics.'),
                _MatrixRow(left: 'SliverPrototypeExtentList', right: 'Extent derived from a prototype child.'),
                _MatrixRow(left: 'SliverGrid', right: 'Grid layout through SliverGridDelegate.'),
                _MatrixRow(left: 'SliverAnimatedList/Grid', right: 'Adds animated insertion/removal on top of adaptor model.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contractCard(_ContractCard c) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: c.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.color.withValues(alpha: 0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            c.signature,
            style: TextStyle(
              color: c.color,
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(c.description, style: const TextStyle(color: _txt, fontSize: 11)),
          const SizedBox(height: 8),
          ...c.points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.fiber_manual_record, size: 8, color: c.color),
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

class _DelegateStudioTab extends StatefulWidget {
  const _DelegateStudioTab();

  @override
  State<_DelegateStudioTab> createState() => _DelegateStudioTabState();
}

class _DelegateStudioTabState extends State<_DelegateStudioTab>
    with AutomaticKeepAliveClientMixin {
  bool _builderMode = true;
  bool _addKeepAlive = true;
  bool _addRepaintBoundary = true;
  bool _addSemanticIndexes = true;
  int _count = 18;
  final List<String> _log = <String>[];

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
          _title('Delegate Strategy Playground'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _toggleCard(
                        title: _builderMode
                            ? 'SliverChildBuilderDelegate'
                            : 'SliverChildListDelegate',
                        subtitle: _builderMode
                            ? 'Lazy build by index callback'
                            : 'Eager list of predefined widgets',
                        value: _builderMode,
                        color: _info,
                        onChanged: (v) {
                          setState(() => _builderMode = v);
                          _push('delegate switched: ${v ? 'builder' : 'list'}');
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _counterCard(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _action('Toggle keepAlive', _ok, () {
                      setState(() => _addKeepAlive = !_addKeepAlive);
                      _push('addAutomaticKeepAlives=$_addKeepAlive');
                    }),
                    _action('Toggle repaintBoundary', _info, () {
                      setState(() => _addRepaintBoundary = !_addRepaintBoundary);
                      _push('addRepaintBoundaries=$_addRepaintBoundary');
                    }),
                    _action('Toggle semanticIndexes', _warn, () {
                      setState(() => _addSemanticIndexes = !_addSemanticIndexes);
                      _push('addSemanticIndexes=$_addSemanticIndexes');
                    }),
                    _action('Increase childCount', _ok, () {
                      setState(() => _count += 4);
                      _push('childCount=$_count');
                    }),
                    _action('Decrease childCount', _err, () {
                      setState(() => _count = (_count - 4).clamp(4, 60));
                      _push('childCount=$_count');
                    }),
                  ],
                ),
                const SizedBox(height: 10),
                _code(_delegateSource()),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _title('Visual Child Output (Simulated)'),
          const SizedBox(height: 8),
          _panelBox(
            child: SizedBox(
              height: 240,
              child: ListView.builder(
                itemCount: _count,
                itemBuilder: (context, index) {
                  final color = _samplePalette[index % _samplePalette.length];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: color.withValues(alpha: 0.8)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('$index',
                              style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _builderMode
                                ? 'builder(context, $index) -> Widget'
                                : 'children[$index] -> Widget',
                            style: const TextStyle(color: _txt, fontSize: 10, fontFamily: 'monospace'),
                          ),
                        ),
                        if (_addKeepAlive)
                          _miniBadge('keepAlive', _ok),
                        if (_addRepaintBoundary)
                          _miniBadge('repaint', _info),
                        if (_addSemanticIndexes)
                          _miniBadge('semantics', _warn),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 14),
          _title('Delegate Event Trace'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _panel2),
              ),
              child: _log.isEmpty
                  ? const Center(
                      child: Text('No changes yet.', style: TextStyle(color: _txt, fontSize: 11)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _log.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: _panel,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _log[index],
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

  Widget _counterCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _panel2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _a.withValues(alpha: 0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Estimated childCount', style: TextStyle(color: _a, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('$_count', style: const TextStyle(color: _a, fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          const Text(
            'Used by viewport to estimate max scroll extent.',
            style: TextStyle(color: _txt, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _miniBadge(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.8)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.w700)),
    );
  }

  String _delegateSource() {
    if (_builderMode) {
      return 'SliverChildBuilderDelegate(\n'
          '  (context, index) => buildRow(index),\n'
          '  childCount: $_count,\n'
          '  addAutomaticKeepAlives: $_addKeepAlive,\n'
          '  addRepaintBoundaries: $_addRepaintBoundary,\n'
          '  addSemanticIndexes: $_addSemanticIndexes,\n'
          ')';
    }
    return 'SliverChildListDelegate(\n'
        '  children, // length: $_count\n'
        '  addAutomaticKeepAlives: $_addKeepAlive,\n'
        '  addRepaintBoundaries: $_addRepaintBoundary,\n'
        '  addSemanticIndexes: $_addSemanticIndexes,\n'
        ')';
  }

  void _push(String message) {
    final t = TimeOfDay.now().format(context);
    setState(() {
      _log.insert(0, '$t | $message');
      if (_log.length > 24) {
        _log.removeLast();
      }
    });
  }
}

class _SliverGalleryTab extends StatefulWidget {
  const _SliverGalleryTab();

  @override
  State<_SliverGalleryTab> createState() => _SliverGalleryTabState();
}

class _SliverGalleryTabState extends State<_SliverGalleryTab>
    with AutomaticKeepAliveClientMixin {
  int _mode = 0;
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _panel,
            border: Border(bottom: BorderSide(color: _panel2)),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _modeButton(0, 'SliverList'),
              _modeButton(1, 'FixedExtentList'),
              _modeButton(2, 'PrototypeExtentList'),
              _modeButton(3, 'SliverGrid'),
              _action('Scroll top', _info, () {
                _controller.animateTo(0, duration: const Duration(milliseconds: 260), curve: Curves.easeOutCubic);
              }),
            ],
          ),
        ),
        Expanded(
          child: CustomScrollView(
            controller: _controller,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: _panelBox(
                    child: Text(
                      _modeDescriptions[_mode],
                      style: const TextStyle(color: _txt, fontSize: 11),
                    ),
                  ),
                ),
              ),
              if (_mode == 0) _buildSliverList(),
              if (_mode == 1) _buildFixedExtentList(),
              if (_mode == 2) _buildPrototypeExtentList(),
              if (_mode == 3) _buildSliverGrid(),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _modeButton(int index, String label) {
    final active = _mode == index;
    return GestureDetector(
      onTap: () => setState(() => _mode = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: active ? _a.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: active ? _a : _panel2),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? _a : _txt,
            fontSize: 11,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverList _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _row(index, 72),
        childCount: 28,
      ),
    );
  }

  SliverFixedExtentList _buildFixedExtentList() {
    return SliverFixedExtentList(
      itemExtent: 64,
      delegate: SliverChildBuilderDelegate(
        (context, index) => _row(index, 64),
        childCount: 30,
      ),
    );
  }

  SliverPrototypeExtentList _buildPrototypeExtentList() {
    return SliverPrototypeExtentList(
      prototypeItem: _row(0, 88),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _row(index, 88),
        childCount: 24,
      ),
    );
  }

  SliverGrid _buildSliverGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final color = _samplePalette[index % _samplePalette.length];
          return Container(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.8)),
            ),
            child: Center(
              child: Text(
                'Grid $index',
                style: TextStyle(color: color, fontWeight: FontWeight.w700),
              ),
            ),
          );
        },
        childCount: 28,
      ),
    );
  }

  Widget _row(int index, double height) {
    final color = _samplePalette[index % _samplePalette.length];
    return Container(
      height: height,
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.8)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: color.withValues(alpha: 0.26),
            foregroundColor: color,
            child: Text('$index', style: const TextStyle(fontSize: 10)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Child generated by SliverMultiBoxAdaptorWidget subclass',
              style: const TextStyle(color: _txt, fontSize: 11),
            ),
          ),
          Text('h=${height.toStringAsFixed(0)}', style: const TextStyle(color: _txt, fontSize: 10)),
        ],
      ),
    );
  }
}

class _ContractCard {
  const _ContractCard({
    required this.name,
    required this.signature,
    required this.description,
    required this.points,
    required this.color,
  });

  final String name;
  final String signature;
  final String description;
  final List<String> points;
  final Color color;
}

const List<_ContractCard> _contractCards = [
  _ContractCard(
    name: 'delegate',
    signature: 'final SliverChildDelegate delegate;',
    description: 'Defines child production strategy for this sliver family.',
    points: [
      'Can be builder-based, list-based, or custom delegate.',
      'Used by element/manager during lazy child inflation.',
    ],
    color: _info,
  ),
  _ContractCard(
    name: 'createElement',
    signature: 'RenderObjectElement createElement() => SliverMultiBoxAdaptorElement(this);',
    description: 'Base implementation centralizes element behavior across subclasses.',
    points: [
      'Subclasses usually do not override this.',
      'Ensures consistent child manager semantics.',
    ],
    color: _ok,
  ),
  _ContractCard(
    name: 'createRenderObject',
    signature: 'RenderSliverMultiBoxAdaptor createRenderObject(BuildContext context);',
    description: 'Abstract method each concrete sliver implements with its layout algorithm.',
    points: [
      'SliverList returns RenderSliverList.',
      'SliverGrid returns RenderSliverGrid.',
    ],
    color: _warn,
  ),
  _ContractCard(
    name: 'estimateMaxScrollOffset',
    signature: 'double? estimateMaxScrollOffset(...)',
    description: 'Delegates extent estimation to SliverChildDelegate by default.',
    points: [
      'Important for scrollbar range and viewport planning.',
      'May be customized by subclasses if they have more info.',
    ],
    color: _a,
  ),
];

const List<String> _modeDescriptions = [
  'SliverList uses adaptor delegate to create linear children with variable extents.',
  'SliverFixedExtentList still uses adaptor delegate but with constant itemExtent for faster math.',
  'SliverPrototypeExtentList measures a prototype item and applies that extent to all generated children.',
  'SliverGrid combines adaptor child delegation with a grid layout delegate for 2D placement.',
];

const List<Color> _samplePalette = [
  Color(0xFF8D6E63),
  Color(0xFF4FC3F7),
  Color(0xFFAED581),
  Color(0xFFFFB74D),
  Color(0xFFCE93D8),
  Color(0xFF81D4FA),
];

class _MatrixRow extends StatelessWidget {
  const _MatrixRow({required this.left, required this.right});

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 170,
            child: Text(
              left,
              style: const TextStyle(color: _a, fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: Text(right, style: const TextStyle(color: _txt, fontSize: 10))),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.step,
    required this.title,
    required this.desc,
  });

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

Widget _code(String src) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _panel2),
    ),
    child: Text(
      src,
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

Widget _toggleCard({
  required String title,
  required String subtitle,
  required bool value,
  required Color color,
  required ValueChanged<bool> onChanged,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _panel2,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
            ),
            Switch(value: value, activeTrackColor: color, onChanged: onChanged),
          ],
        ),
        Text(subtitle, style: const TextStyle(color: _txt, fontSize: 10)),
      ],
    ),
  );
}
