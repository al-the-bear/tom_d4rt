import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetStateOutlinedBorderDeepDemo();
}

const Color _kBorderBar = Color(0xFF312E81);
const Color _kBorderCanvas = Color(0xFFF8FAFC);

class _WidgetStateOutlinedBorderDeepDemo extends StatefulWidget {
  const _WidgetStateOutlinedBorderDeepDemo();

  @override
  State<_WidgetStateOutlinedBorderDeepDemo> createState() =>
      _WidgetStateOutlinedBorderDeepDemoState();
}

class _WidgetStateOutlinedBorderDeepDemoState
    extends State<_WidgetStateOutlinedBorderDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBorderCanvas,
      appBar: AppBar(
        backgroundColor: _kBorderBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetStateOutlinedBorder Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Concept'),
            Tab(text: 'Shape Resolver'),
            Tab(text: 'Border Families'),
            Tab(text: 'Component Gallery'),
            Tab(text: 'Design Notes'),
            Tab(text: 'Trace Lab'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _BorderConceptPanel(),
          _ShapeResolverPanel(),
          _BorderFamiliesPanel(),
          _ComponentGalleryPanel(),
          _DesignNotesPanel(),
          _TraceLabPanel(),
        ],
      ),
    );
  }
}

class _BorderConceptPanel extends StatelessWidget {
  const _BorderConceptPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _BorderCard(
          title: 'Purpose',
          tone: Color(0xFF1D4ED8),
          body:
              'WidgetStateOutlinedBorder resolves to different OutlinedBorder '
              'instances depending on widget states. This enables shape and '
              'stroke transitions without scattering conditional geometry logic.',
        ),
        SizedBox(height: 12),
        _BorderCard(
          title: 'Visual semantics',
          tone: Color(0xFF047857),
          body:
              'Changing a border can communicate state as strongly as changing '
              'color. Rounded corners suggest friendliness, stadium shapes show '
              'action focus, circles imply badges and avatar interactions.',
        ),
        SizedBox(height: 12),
        _BorderBulletCard(
          title: 'Where this is valuable',
          tone: Color(0xFF7C3AED),
          points: [
            'Buttons and chips with elevated interaction hierarchy.',
            'Cards that need selected vs default geometry differences.',
            'Form outlines requiring focused or error-specific structure.',
            'Composable themes shared across many design surfaces.',
          ],
        ),
        SizedBox(height: 12),
        _BorderBulletCard(
          title: 'Implementation pitfalls',
          tone: Color(0xFFB91C1C),
          points: [
            'Shapes that change too drastically and break layout rhythm.',
            'Missing disabled branch causing ambiguous inactive visuals.',
            'Inconsistent side widths between default and focused state.',
            'No fallback branch for uncommon state combinations.',
          ],
        ),
      ],
    );
  }
}

class _ShapeResolverPanel extends StatefulWidget {
  const _ShapeResolverPanel();

  @override
  State<_ShapeResolverPanel> createState() => _ShapeResolverPanelState();
}

class _ShapeResolverPanelState extends State<_ShapeResolverPanel> {
  final Set<WidgetState> _states = <WidgetState>{};
  final List<String> _events = <String>['Shape resolver initialized.'];

  final WidgetStateOutlinedBorder _mapper = WidgetStateOutlinedBorder.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: Color(0xFF94A3B8), width: 1),
      );
    }
    if (states.contains(WidgetState.error)) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFB91C1C), width: 2.4),
      );
    }
    if (states.contains(WidgetState.pressed)) {
      return const StadiumBorder(
        side: BorderSide(color: Color(0xFF1D4ED8), width: 2.6),
      );
    }
    if (states.contains(WidgetState.selected)) {
      return const CircleBorder(
        side: BorderSide(color: Color(0xFF16A34A), width: 2.2),
      );
    }
    if (states.contains(WidgetState.hovered)) {
      return BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF0EA5E9), width: 2),
      );
    }
    if (states.contains(WidgetState.focused)) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFF7C3AED), width: 2.2),
      );
    }
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: Color(0xFF334155), width: 1.4),
    );
  });

  void _toggle(WidgetState state, bool value) {
    setState(() {
      if (value) {
        _states.add(state);
      } else {
        _states.remove(state);
      }
      _events.add('${DateTime.now().toIso8601String()} :: ${state.name} -> $value');
      if (_events.length > 22) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final resolved = _mapper.resolve(_states) ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF334155), width: 1.4),
        );

    return Row(
      children: [
        Expanded(
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'State controls',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      for (final state in const [
                        WidgetState.hovered,
                        WidgetState.focused,
                        WidgetState.pressed,
                        WidgetState.selected,
                        WidgetState.error,
                        WidgetState.disabled,
                      ])
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(state.name),
                          subtitle: Text('Toggle ${state.name} for border resolution.'),
                          value: _states.contains(state),
                          onChanged: (value) => _toggle(state, value),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Resolved border preview',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 180,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: WidgetStatePropertyAll(resolved.side),
                            shape: WidgetStatePropertyAll(resolved),
                            backgroundColor: const WidgetStatePropertyAll(
                              Color(0xFFF8FAFC),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            resolved.runtimeType.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _ShapeMetric(
                            label: 'Type',
                            value: resolved.runtimeType.toString(),
                          ),
                          _ShapeMetric(
                            label: 'Side Width',
                            value: resolved.side.width.toStringAsFixed(2),
                          ),
                          _ShapeMetric(
                            label: 'State Count',
                            value: _states.length.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final line = _events[_events.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: Color(0xFFC4B5FD),
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _BorderFamiliesPanel extends StatelessWidget {
  const _BorderFamiliesPanel();

  @override
  Widget build(BuildContext context) {
    final families = <({String name, OutlinedBorder shape, String details, Color color})>[
      (
        name: 'RoundedRectangleBorder',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF2563EB), width: 2),
        ),
        details: 'Great default for cards and actions with subtle corners.',
        color: const Color(0xFF2563EB),
      ),
      (
        name: 'StadiumBorder',
        shape: const StadiumBorder(
          side: BorderSide(color: Color(0xFF16A34A), width: 2.2),
        ),
        details: 'Excellent for pill actions and compact toggle controls.',
        color: const Color(0xFF16A34A),
      ),
      (
        name: 'CircleBorder',
        shape: const CircleBorder(
          side: BorderSide(color: Color(0xFF7C3AED), width: 2.2),
        ),
        details: 'Useful for avatar actions and circular status indicators.',
        color: const Color(0xFF7C3AED),
      ),
      (
        name: 'BeveledRectangleBorder',
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFCA8A04), width: 2),
        ),
        details: 'Adds technical edge style for tooling dashboards.',
        color: const Color(0xFFCA8A04),
      ),
      (
        name: 'ContinuousRectangleBorder',
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: const BorderSide(color: Color(0xFF0F766E), width: 2),
        ),
        details: 'Smooth transitions for modern fluid brand systems.',
        color: const Color(0xFF0F766E),
      ),
      (
        name: 'LinearBorder',
        shape: const LinearBorder(
          side: BorderSide(color: Color(0xFFDC2626), width: 2),
        ),
        details: 'Minimal line emphasis for compact data UIs.',
        color: const Color(0xFFDC2626),
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.35,
      children: [
        for (final family in families)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    family.name,
                    style: TextStyle(
                      color: family.color,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(family.shape),
                        side: WidgetStatePropertyAll(family.shape.side),
                      ),
                      onPressed: () {},
                      child: const Text('Preview'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(family.details, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ComponentGalleryPanel extends StatelessWidget {
  const _ComponentGalleryPanel();

  OutlinedBorder _resolvedShape(
    WidgetStateOutlinedBorder mapper,
    Set<WidgetState> states,
  ) {
    return mapper.resolve(states) ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFF64748B), width: 1.4),
        );
  }

  WidgetStateOutlinedBorder _chipShape() {
    return WidgetStateOutlinedBorder.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const StadiumBorder(
          side: BorderSide(color: Color(0xFF16A34A), width: 2),
        );
      }
      if (states.contains(WidgetState.pressed)) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFF1D4ED8), width: 2.2),
        );
      }
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFF64748B), width: 1.4),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapper = _chipShape();

    final demos = <({String title, Set<WidgetState> states, String note})>[
      (
        title: 'Idle chip',
        states: <WidgetState>{},
        note: 'Default rounded geometry.',
      ),
      (
        title: 'Pressed chip',
        states: {WidgetState.pressed},
        note: 'More pronounced border for action feedback.',
      ),
      (
        title: 'Selected chip',
        states: {WidgetState.selected},
        note: 'Pill shape indicates persistent selection.',
      ),
      (
        title: 'Selected + Pressed',
        states: {WidgetState.selected, WidgetState.pressed},
        note: 'State intersection still resolves deterministically.',
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        const _BorderCard(
          title: 'Component recipe',
          tone: Color(0xFF1D4ED8),
          body:
              'This gallery shows a single border mapper reused across multiple '
              'chip states to maintain consistency while still providing clear '
              'interaction differentiation.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final demo in demos)
              SizedBox(
                width: 280,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          demo.title,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              _resolvedShape(mapper, demo.states),
                            ),
                            side: WidgetStatePropertyAll(
                              _resolvedShape(mapper, demo.states).side,
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            demo.states.map((e) => e.name).join(', ').ifEmpty('none'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(demo.note, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _DesignNotesPanel extends StatelessWidget {
  const _DesignNotesPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: const [
        _BorderCard(
          title: 'Design principle 1: Geometry hierarchy',
          tone: Color(0xFF047857),
          body:
              'Use shape transitions to guide attention levels. Small changes '
              'indicate subtle states; major geometry shifts should signal clear '
              'mode changes like selected or error.',
        ),
        SizedBox(height: 10),
        _BorderCard(
          title: 'Design principle 2: Stroke consistency',
          tone: Color(0xFF7C2D12),
          body:
              'Border side widths should scale predictably across state sets. '
              'Abrupt thickness jumps can make adjacent controls appear misaligned.',
        ),
        SizedBox(height: 10),
        _BorderCard(
          title: 'Design principle 3: Shared mapper tokens',
          tone: Color(0xFF4338CA),
          body:
              'Store mappers in style token layers to avoid one-off component '
              'logic. This improves consistency and speeds design reviews.',
        ),
        SizedBox(height: 10),
        _BorderBulletCard(
          title: 'Verification checklist',
          tone: Color(0xFF9333EA),
          points: [
            'Snapshot all major state combinations.',
            'Validate shape transitions with reduced-motion users.',
            'Confirm border hit areas still match interaction targets.',
            'Test keyboard focus and pointer hover together.',
          ],
        ),
      ],
    );
  }
}

class _TraceLabPanel extends StatefulWidget {
  const _TraceLabPanel();

  @override
  State<_TraceLabPanel> createState() => _TraceLabPanelState();
}

class _TraceLabPanelState extends State<_TraceLabPanel> {
  final List<String> _trace = <String>['Trace lab ready.'];

  final WidgetStateOutlinedBorder _resolver = WidgetStateOutlinedBorder.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: Color(0xFF94A3B8), width: 1),
      );
    }
    if (states.contains(WidgetState.pressed)) {
      return const StadiumBorder(
        side: BorderSide(color: Color(0xFF1D4ED8), width: 2.4),
      );
    }
    if (states.contains(WidgetState.hovered)) {
      return BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF0EA5E9), width: 2),
      );
    }
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: Color(0xFF334155), width: 1.4),
    );
  });

  void _simulate(Set<WidgetState> states) {
    final resolved = _resolver.resolve(states) ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFF334155), width: 1.4),
        );
    setState(() {
      _trace.add(
        '${DateTime.now().toIso8601String()} -> ${states.map((e) => e.name).join(', ').ifEmpty('none')} => ${resolved.runtimeType} (side ${resolved.side.width.toStringAsFixed(2)})',
      );
      if (_trace.length > 18) {
        _trace.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => _simulate(<WidgetState>{}),
              child: const Text('Simulate default'),
            ),
            ElevatedButton(
              onPressed: () => _simulate({WidgetState.hovered}),
              child: const Text('Simulate hovered'),
            ),
            ElevatedButton(
              onPressed: () => _simulate({WidgetState.pressed}),
              child: const Text('Simulate pressed'),
            ),
            ElevatedButton(
              onPressed: () => _simulate({WidgetState.disabled}),
              child: const Text('Simulate disabled'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: _trace.length,
              itemBuilder: (context, index) {
                final line = _trace[_trace.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: Color(0xFFFDE68A),
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _BorderCard extends StatelessWidget {
  const _BorderCard({
    required this.title,
    required this.tone,
    required this.body,
  });

  final String title;
  final Color tone;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: tone,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(body, style: const TextStyle(height: 1.4)),
          ],
        ),
      ),
    );
  }
}

class _BorderBulletCard extends StatelessWidget {
  const _BorderBulletCard({
    required this.title,
    required this.tone,
    required this.points,
  });

  final String title;
  final Color tone;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: tone, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            for (final point in points)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: tone)),
                    Expanded(child: Text(point)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ShapeMetric extends StatelessWidget {
  const _ShapeMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

extension on String {
  String ifEmpty(String fallback) {
    return isEmpty ? fallback : this;
  }
}
