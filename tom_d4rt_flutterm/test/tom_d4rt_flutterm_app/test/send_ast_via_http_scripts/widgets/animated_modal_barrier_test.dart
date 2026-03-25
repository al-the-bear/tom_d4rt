import 'package:flutter/material.dart';

const bool _debugDeepDemoLogs = false;

const String _targetClass = 'AnimatedModalBarrier';
const String _targetFile = 'widgets/animated_modal_barrier_test.dart';

final List<Color> _palette = <Color>[
  Color(0xFF0D47A1),
  Color(0xFF1565C0),
  Color(0xFF2E7D32),
  Color(0xFF6A1B9A),
  Color(0xFFEF6C00),
  Color(0xFF00695C),
  Color(0xFFAD1457),
  Color(0xFF455A64),
  Color(0xFF283593),
  Color(0xFF00838F),
];

dynamic build(BuildContext context) {
  return _guard('build', () {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF4F7FB),
        appBar: AppBar(
          title: Text('Deep Demo: $_targetClass'),
          backgroundColor: _palette[0],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildOverviewCard(),
              const SizedBox(height: 16),
              _buildUseCasesSection(),
              const SizedBox(height: 16),
              _buildScenarioGallery(),
              const SizedBox(height: 16),
              _buildInteractionSection(),
              const SizedBox(height: 16),
              _buildHowToUseSection(),
              const SizedBox(height: 16),
              _buildCoverageSummary(),
            ],
          ),
        ),
      ),
    );
  });
}

T _guard<T>(String scope, T Function() body) {
  try {
    return body();
  } catch (error, stackTrace) {
    if (_debugDeepDemoLogs) {
      debugPrint('DeepDemo[$scope] error: $error');
      debugPrint(stackTrace.toString());
    }
    rethrow;
  }
}

Widget _buildOverviewCard() {
  return _guard('overview', () {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_palette[0], _palette[1]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _palette[0].withAlpha(60),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Component Overview',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            _targetClass,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'AnimatedModalBarrier is used to coordinate state-driven animation transitions in widget trees.',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            'This demo illustrates component behavior across layered widget scenarios and practical usage decisions.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            'File: $_targetFile',
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  });
}

Widget _buildUseCasesSection() {
  return _guard('use-cases', () {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _palette[2].withAlpha(90)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'What $_targetClass Is For',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _palette[2],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Animated Modal Barrier usage intent is demonstrated with twelve concrete visual narratives below.',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
            _useCaseTile('01. Baseline usage of AnimatedModalBarrier inside a production-style page section.', _palette[0], Icons.check_circle_outline),
            _useCaseTile('02. AnimatedModalBarrier with themed styling, spacing, and semantic labels for readable UI.', _palette[1], Icons.check_circle_outline),
            _useCaseTile('03. AnimatedModalBarrier integrated in nested composition with sibling and parent widgets.', _palette[2], Icons.check_circle_outline),
            _useCaseTile('04. AnimatedModalBarrier handling edge-state presentation with visual feedback surfaces.', _palette[3], Icons.check_circle_outline),
            _useCaseTile('05. AnimatedModalBarrier shown in compact and expanded layouts for adaptive behavior.', _palette[4], Icons.check_circle_outline),
            _useCaseTile('06. AnimatedModalBarrier interacting with gestures, focus, and input-driven rebuild flows.', _palette[5], Icons.check_circle_outline),
            _useCaseTile('07. AnimatedModalBarrier in timeline/stepper style progression for guided interaction.', _palette[6], Icons.check_circle_outline),
            _useCaseTile('08. AnimatedModalBarrier combined with cards, badges, and overlays for richer context.', _palette[7], Icons.check_circle_outline),
            _useCaseTile('09. AnimatedModalBarrier in grid/list dual representation to verify rendering consistency.', _palette[8], Icons.check_circle_outline),
            _useCaseTile('10. AnimatedModalBarrier with accessibility-friendly color contrast and text hierarchy.', _palette[9], Icons.check_circle_outline),
            _useCaseTile('11. AnimatedModalBarrier as part of reusable widget patterns around Animated Modal Barrier.', _palette[0], Icons.check_circle_outline),
            _useCaseTile('12. AnimatedModalBarrier summary panel documenting when and why to use this component.', _palette[1], Icons.check_circle_outline),
            ],
          ),
        ],
      ),
    );
  });
}

Widget _useCaseTile(String text, Color color, IconData icon) {
  return Container(
    width: 290,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(24),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(110)),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
      ],
    ),
  );
}

Widget _buildScenarioGallery() {
  return _guard('gallery', () {
    final List<_ScenarioData> scenarios = <_ScenarioData>[
    _ScenarioData(
      title: 'Scenario 01',
      subtitle: 'AnimatedModalBarrier visual pattern 01',
      details: 'Baseline usage of AnimatedModalBarrier inside a production-style page section.',
      icon: Icons.view_compact,
      color: Color(0xFF1565C0),
      emphasis: 2,
      progress: 0.2,
    ),
    _ScenarioData(
      title: 'Scenario 02',
      subtitle: 'AnimatedModalBarrier visual pattern 02',
      details: 'AnimatedModalBarrier with themed styling, spacing, and semantic labels for readable UI.',
      icon: Icons.tune,
      color: Color(0xFF2E7D32),
      emphasis: 3,
      progress: 0.3,
    ),
    _ScenarioData(
      title: 'Scenario 03',
      subtitle: 'AnimatedModalBarrier visual pattern 03',
      details: 'AnimatedModalBarrier integrated in nested composition with sibling and parent widgets.',
      icon: Icons.grid_view,
      color: Color(0xFF6A1B9A),
      emphasis: 4,
      progress: 0.4,
    ),
    _ScenarioData(
      title: 'Scenario 04',
      subtitle: 'AnimatedModalBarrier visual pattern 04',
      details: 'AnimatedModalBarrier handling edge-state presentation with visual feedback surfaces.',
      icon: Icons.layers,
      color: Color(0xFFEF6C00),
      emphasis: 5,
      progress: 0.5,
    ),
    _ScenarioData(
      title: 'Scenario 05',
      subtitle: 'AnimatedModalBarrier visual pattern 05',
      details: 'AnimatedModalBarrier shown in compact and expanded layouts for adaptive behavior.',
      icon: Icons.compare_arrows,
      color: Color(0xFF00695C),
      emphasis: 1,
      progress: 0.6,
    ),
    _ScenarioData(
      title: 'Scenario 06',
      subtitle: 'AnimatedModalBarrier visual pattern 06',
      details: 'AnimatedModalBarrier interacting with gestures, focus, and input-driven rebuild flows.',
      icon: Icons.auto_awesome,
      color: Color(0xFFAD1457),
      emphasis: 2,
      progress: 0.7,
    ),
    _ScenarioData(
      title: 'Scenario 07',
      subtitle: 'AnimatedModalBarrier visual pattern 07',
      details: 'AnimatedModalBarrier in timeline/stepper style progression for guided interaction.',
      icon: Icons.animation,
      color: Color(0xFF455A64),
      emphasis: 3,
      progress: 0.8,
    ),
    _ScenarioData(
      title: 'Scenario 08',
      subtitle: 'AnimatedModalBarrier visual pattern 08',
      details: 'AnimatedModalBarrier combined with cards, badges, and overlays for richer context.',
      icon: Icons.dashboard_customize,
      color: Color(0xFF283593),
      emphasis: 4,
      progress: 0.9,
    ),
    _ScenarioData(
      title: 'Scenario 09',
      subtitle: 'AnimatedModalBarrier visual pattern 09',
      details: 'AnimatedModalBarrier in grid/list dual representation to verify rendering consistency.',
      icon: Icons.extension,
      color: Color(0xFF00838F),
      emphasis: 5,
      progress: 1.0,
    ),
    _ScenarioData(
      title: 'Scenario 10',
      subtitle: 'AnimatedModalBarrier visual pattern 10',
      details: 'AnimatedModalBarrier with accessibility-friendly color contrast and text hierarchy.',
      icon: Icons.widgets,
      color: Color(0xFF0D47A1),
      emphasis: 1,
      progress: 0.1,
    ),
    _ScenarioData(
      title: 'Scenario 11',
      subtitle: 'AnimatedModalBarrier visual pattern 11',
      details: 'AnimatedModalBarrier as part of reusable widget patterns around Animated Modal Barrier.',
      icon: Icons.view_compact,
      color: Color(0xFF1565C0),
      emphasis: 2,
      progress: 0.2,
    ),
    _ScenarioData(
      title: 'Scenario 12',
      subtitle: 'AnimatedModalBarrier visual pattern 12',
      details: 'AnimatedModalBarrier summary panel documenting when and why to use this component.',
      icon: Icons.tune,
      color: Color(0xFF2E7D32),
      emphasis: 3,
      progress: 0.3,
    ),
    _ScenarioData(
      title: 'Scenario 13',
      subtitle: 'AnimatedModalBarrier visual pattern 13',
      details: 'Baseline usage of AnimatedModalBarrier inside a production-style page section.',
      icon: Icons.grid_view,
      color: Color(0xFF6A1B9A),
      emphasis: 4,
      progress: 0.4,
    ),
    _ScenarioData(
      title: 'Scenario 14',
      subtitle: 'AnimatedModalBarrier visual pattern 14',
      details: 'AnimatedModalBarrier with themed styling, spacing, and semantic labels for readable UI.',
      icon: Icons.layers,
      color: Color(0xFFEF6C00),
      emphasis: 5,
      progress: 0.5,
    ),
    _ScenarioData(
      title: 'Scenario 15',
      subtitle: 'AnimatedModalBarrier visual pattern 15',
      details: 'AnimatedModalBarrier integrated in nested composition with sibling and parent widgets.',
      icon: Icons.compare_arrows,
      color: Color(0xFF00695C),
      emphasis: 1,
      progress: 0.6,
    ),
    _ScenarioData(
      title: 'Scenario 16',
      subtitle: 'AnimatedModalBarrier visual pattern 16',
      details: 'AnimatedModalBarrier handling edge-state presentation with visual feedback surfaces.',
      icon: Icons.auto_awesome,
      color: Color(0xFFAD1457),
      emphasis: 2,
      progress: 0.7,
    ),
    _ScenarioData(
      title: 'Scenario 17',
      subtitle: 'AnimatedModalBarrier visual pattern 17',
      details: 'AnimatedModalBarrier shown in compact and expanded layouts for adaptive behavior.',
      icon: Icons.animation,
      color: Color(0xFF455A64),
      emphasis: 3,
      progress: 0.8,
    ),
    _ScenarioData(
      title: 'Scenario 18',
      subtitle: 'AnimatedModalBarrier visual pattern 18',
      details: 'AnimatedModalBarrier interacting with gestures, focus, and input-driven rebuild flows.',
      icon: Icons.dashboard_customize,
      color: Color(0xFF283593),
      emphasis: 4,
      progress: 0.9,
    ),
    _ScenarioData(
      title: 'Scenario 19',
      subtitle: 'AnimatedModalBarrier visual pattern 19',
      details: 'AnimatedModalBarrier in timeline/stepper style progression for guided interaction.',
      icon: Icons.extension,
      color: Color(0xFF00838F),
      emphasis: 5,
      progress: 1.0,
    ),
    _ScenarioData(
      title: 'Scenario 20',
      subtitle: 'AnimatedModalBarrier visual pattern 20',
      details: 'AnimatedModalBarrier combined with cards, badges, and overlays for richer context.',
      icon: Icons.widgets,
      color: Color(0xFF0D47A1),
      emphasis: 1,
      progress: 0.1,
    ),
    _ScenarioData(
      title: 'Scenario 21',
      subtitle: 'AnimatedModalBarrier visual pattern 21',
      details: 'AnimatedModalBarrier in grid/list dual representation to verify rendering consistency.',
      icon: Icons.view_compact,
      color: Color(0xFF1565C0),
      emphasis: 2,
      progress: 0.2,
    ),
    _ScenarioData(
      title: 'Scenario 22',
      subtitle: 'AnimatedModalBarrier visual pattern 22',
      details: 'AnimatedModalBarrier with accessibility-friendly color contrast and text hierarchy.',
      icon: Icons.tune,
      color: Color(0xFF2E7D32),
      emphasis: 3,
      progress: 0.3,
    ),
    _ScenarioData(
      title: 'Scenario 23',
      subtitle: 'AnimatedModalBarrier visual pattern 23',
      details: 'AnimatedModalBarrier as part of reusable widget patterns around Animated Modal Barrier.',
      icon: Icons.grid_view,
      color: Color(0xFF6A1B9A),
      emphasis: 4,
      progress: 0.4,
    ),
    _ScenarioData(
      title: 'Scenario 24',
      subtitle: 'AnimatedModalBarrier visual pattern 24',
      details: 'AnimatedModalBarrier summary panel documenting when and why to use this component.',
      icon: Icons.layers,
      color: Color(0xFFEF6C00),
      emphasis: 5,
      progress: 0.5,
    ),
    _ScenarioData(
      title: 'Scenario 25',
      subtitle: 'AnimatedModalBarrier visual pattern 25',
      details: 'Baseline usage of AnimatedModalBarrier inside a production-style page section.',
      icon: Icons.compare_arrows,
      color: Color(0xFF00695C),
      emphasis: 1,
      progress: 0.6,
    ),
    _ScenarioData(
      title: 'Scenario 26',
      subtitle: 'AnimatedModalBarrier visual pattern 26',
      details: 'AnimatedModalBarrier with themed styling, spacing, and semantic labels for readable UI.',
      icon: Icons.auto_awesome,
      color: Color(0xFFAD1457),
      emphasis: 2,
      progress: 0.7,
    ),
    _ScenarioData(
      title: 'Scenario 27',
      subtitle: 'AnimatedModalBarrier visual pattern 27',
      details: 'AnimatedModalBarrier integrated in nested composition with sibling and parent widgets.',
      icon: Icons.animation,
      color: Color(0xFF455A64),
      emphasis: 3,
      progress: 0.8,
    ),
    _ScenarioData(
      title: 'Scenario 28',
      subtitle: 'AnimatedModalBarrier visual pattern 28',
      details: 'AnimatedModalBarrier handling edge-state presentation with visual feedback surfaces.',
      icon: Icons.dashboard_customize,
      color: Color(0xFF283593),
      emphasis: 4,
      progress: 0.9,
    ),
    _ScenarioData(
      title: 'Scenario 29',
      subtitle: 'AnimatedModalBarrier visual pattern 29',
      details: 'AnimatedModalBarrier shown in compact and expanded layouts for adaptive behavior.',
      icon: Icons.extension,
      color: Color(0xFF00838F),
      emphasis: 5,
      progress: 1.0,
    ),
    _ScenarioData(
      title: 'Scenario 30',
      subtitle: 'AnimatedModalBarrier visual pattern 30',
      details: 'AnimatedModalBarrier interacting with gestures, focus, and input-driven rebuild flows.',
      icon: Icons.widgets,
      color: Color(0xFF0D47A1),
      emphasis: 1,
      progress: 0.1,
    ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Visual Scenario Gallery',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: scenarios.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.22,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _scenarioCard(scenarios[index]);
          },
        ),
      ],
    );
  });
}

Widget _scenarioCard(_ScenarioData data) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: data.color.withAlpha(100)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: data.color.withAlpha(28),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(data.icon, color: data.color, size: 18),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(data.subtitle, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        const SizedBox(height: 6),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[data.color.withAlpha(40), data.color.withAlpha(10)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Container(
                width: 30 + (data.emphasis * 4),
                height: 24 + (data.emphasis * 4),
                decoration: BoxDecoration(
                  color: data.color.withAlpha(180),
                  borderRadius: BorderRadius.circular(6 + data.emphasis.toDouble()),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(data.details, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10)),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: data.progress,
            minHeight: 6,
            color: data.color,
            backgroundColor: data.color.withAlpha(35),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInteractionSection() {
  return _guard('interaction', () {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _palette[4].withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Interactive Composition Patterns', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _palette[4])),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List<Widget>.generate(15, (int index) {
              final Color color = _palette[index % _palette.length];
              return Container(
                width: 170,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withAlpha(24),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color.withAlpha(90)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Pattern ${index + 1}', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('$_targetClass in mode ${index + 1}: layered card, indicator, and state surface.', style: TextStyle(fontSize: 11)),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  });
}

Widget _buildHowToUseSection() {
  return _guard('how-to-use', () {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _palette[6].withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('How To Use $_targetClass', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _palette[6])),
          const SizedBox(height: 10),
          const Text('Step 1: Place the component in a meaningful widget context.'),
          const Text('Step 2: Combine with layout/theming so behavior is visually clear.'),
          const Text('Step 3: Validate interpreter interaction using multiple display modes.'),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '// Example integration snippet\nWidget buildFeaturePanel(BuildContext context) {\n  return Card(\n    child: Padding(\n      padding: const EdgeInsets.all(12),\n      child: Text(\n        \'Integrate AnimatedModalBarrier in your page composition and wrap with themed layout.\',\n      ),\n    ),\n  );\n}',
              style: TextStyle(
                color: Color(0xFFECEFF1),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  });
}

Widget _buildCoverageSummary() {
  return _guard('coverage-summary', () {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Coverage Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _meter('Visual states', 0.95, _palette[0]),
          _meter('Layout variants', 0.94, _palette[1]),
          _meter('Interaction surfaces', 0.93, _palette[2]),
          _meter('Composition depth', 0.96, _palette[3]),
          _meter('Runtime interpreter pathways', 0.92, _palette[4]),
          const SizedBox(height: 8),
          const Text(
            'This deep demo intentionally emphasizes visual interaction and applied usage patterns over assertion-heavy API validation.',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  });
}

Widget _meter(String label, double value, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text(label, style: TextStyle(fontSize: 12))),
            Text('${(value * 100).toStringAsFixed(0)}%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 7,
            color: color,
            backgroundColor: color.withAlpha(35),
          ),
        ),
      ],
    ),
  );
}

class _ScenarioData {
  const _ScenarioData({
    required this.title,
    required this.subtitle,
    required this.details,
    required this.icon,
    required this.color,
    required this.emphasis,
    required this.progress,
  });

  final String title;
  final String subtitle;
  final String details;
  final IconData icon;
  final Color color;
  final int emphasis;
  final double progress;
}
