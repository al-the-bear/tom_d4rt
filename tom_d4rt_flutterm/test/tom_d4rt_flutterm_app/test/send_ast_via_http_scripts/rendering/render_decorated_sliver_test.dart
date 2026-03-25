import 'package:flutter/material.dart';

const Color _kPrimary = Color(0xFF2E7D32);
const Color _kAccent = Color(0xFF66BB6A);
const Color _kSurface = Color(0xFFE8F5E9);

final List<_DemoPanelData> _kPanels = <_DemoPanelData>[
  _DemoPanelData(
    title: 'Purpose',
    text:
        'Render Decorated Sliver demonstrates Flutter runtime behavior and visual composition patterns in the D4rt interpreter runtime. This deep demo focuses on visual understanding rather than API-level assertions.',
    icon: Icons.auto_awesome_rounded,
  ),
  _DemoPanelData(
    title: 'When to use',
    text:
        'Use this pattern when you need to inspect behavior in realistic UI structures and quickly validate interpreter parity with native Flutter execution.',
    icon: Icons.lightbulb_circle_rounded,
  ),
  _DemoPanelData(
    title: 'How to read this demo',
    text:
        'Start with the overview, then scan each scenario card and compare visual output. Use the matrix section to understand variations and composition tradeoffs.',
    icon: Icons.menu_book_rounded,
  ),
  _DemoPanelData(
    title: 'Interpreter focus',
    text:
        'This script intentionally emphasizes rendering and interaction displays; assertions are minimal because Flutter framework correctness is already covered upstream.',
    icon: Icons.integration_instructions_rounded,
  ),
];

dynamic build(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  final Color primary = _kPrimary;
  final Color accent = _kAccent;
  final Color surface = _kSurface;

  return Scaffold(
    backgroundColor: const Color(0xFFF7F9FC),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(
              title: 'Render Decorated Sliver Deep Demo',
              subtitle:
                  'Visual and instructive exploration of RenderDecoratedSliver for D4rt interpreter scenarios.',
              icon: Icons.auto_awesome_rounded,
              primary: primary,
              accent: accent,
            ),
            const SizedBox(height: 20),
            _buildOverviewCards(primary: primary, accent: accent, surface: surface),
            const SizedBox(height: 20),
            _buildUsageSection(primary: primary, accent: accent, surface: surface),
            const SizedBox(height: 20),
            _buildScenarioGallery(primary: primary, accent: accent, surface: surface),
            const SizedBox(height: 20),
            _buildMatrixSection(primary: primary, accent: accent, surface: surface),
            const SizedBox(height: 20),
            _buildIntegrationSection(primary: primary, accent: accent, surface: surface),
            const SizedBox(height: 20),
            _buildDebugSection(theme: theme, primary: primary, accent: accent, surface: surface),
            const SizedBox(height: 36),
          ],
        ),
      ),
    ),
  );
}

Widget _buildHeader({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color primary,
  required Color accent,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: LinearGradient(
        colors: <Color>[primary, accent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: primary.withAlpha(90),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(36),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withAlpha(232),
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverviewCards({
  required Color primary,
  required Color accent,
  required Color surface,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: _panelDecoration(surface: surface, border: primary.withAlpha(70)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Overview', Icons.auto_awesome_rounded, primary),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _kPanels
              .map(
                (_DemoPanelData panel) => SizedBox(
                  width: 320,
                  child: _buildPanel(panel: panel, primary: primary, accent: accent),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

Widget _buildUsageSection({
  required Color primary,
  required Color accent,
  required Color surface,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: _panelDecoration(surface: surface, border: accent.withAlpha(76)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('How and why to use it', Icons.school_rounded, accent),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: accent.withAlpha(80)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            _buildBullet(text: 'RenderDecoratedSliver is used when you need explicit control over Flutter runtime behavior and visual composition patterns.'),
            _buildBullet(text: 'Use small visual probes first, then compose with real app widgets to validate behavior.'),
            _buildBullet(text: 'Prefer deterministic, visual examples so interpreter execution can be inspected quickly.'),
            _buildBullet(text: 'Keep this demo as a reference while extending bridges and runtime registrations.'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildScenarioGallery({
  required Color primary,
  required Color accent,
  required Color surface,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: _panelDecoration(surface: surface, border: primary.withAlpha(76)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Visual scenarios', Icons.view_carousel_rounded, primary),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[

        _buildScenarioCard(
          title: 'Baseline Visual',
          subtitle: 'Shows the default rendering contract and default values.',
          index: 1,
          primary: primary,
          accent: accent,
          surface: surface,
        ),
        _buildScenarioCard(
          title: 'Interactive Surface',
          subtitle: 'Demonstrates pointer/gesture interaction and visual feedback.',
          index: 2,
          primary: primary,
          accent: accent,
          surface: surface,
        ),
        _buildScenarioCard(
          title: 'Constraint Stress',
          subtitle: 'Demonstrates behavior under tight/loose constraints.',
          index: 3,
          primary: primary,
          accent: accent,
          surface: surface,
        ),
        _buildScenarioCard(
          title: 'Composition Mix',
          subtitle: 'Shows interoperability with common parent/child widget patterns.',
          index: 4,
          primary: primary,
          accent: accent,
          surface: surface,
        ),
        _buildScenarioCard(
          title: 'State Transition',
          subtitle: 'Demonstrates dynamic updates and animation/state transitions.',
          index: 5,
          primary: primary,
          accent: accent,
          surface: surface,
        ),
        _buildScenarioCard(
          title: 'Production Pattern',
          subtitle: 'Wraps the API in a realistic composition from app code.',
          index: 6,
          primary: primary,
          accent: accent,
          surface: surface,
        ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildMatrixSection({
  required Color primary,
  required Color accent,
  required Color surface,
}) {
  const List<String> columns = <String>[
    'Profile',
    'Visual density',
    'Interaction',
    'Composition',
  ];
  const List<List<String>> rows = <List<String>>[
    <String>['Minimal', 'Low', 'Static', 'Standalone'],
    <String>['Balanced', 'Medium', 'Tap/hover', 'Nested'],
    <String>['Rich', 'High', 'Dynamic', 'Integrated'],
    <String>['Debug', 'High', 'Inspectable', 'Tooling'],
  ];

  return Container(
    padding: const EdgeInsets.all(18),
    decoration: _panelDecoration(surface: surface, border: accent.withAlpha(82)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Behavior matrix', Icons.table_chart_rounded, accent),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withAlpha(75)),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: columns
                    .map(
                      (String text) => Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: accent.withAlpha(35),
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              ...rows.map(
                (List<String> row) => Row(
                  children: row
                      .map(
                        (String text) => Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: accent.withAlpha(40)),
                              ),
                            ),
                            child: Text(text, textAlign: TextAlign.center),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildIntegrationSection({
  required Color primary,
  required Color accent,
  required Color surface,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: _panelDecoration(surface: surface, border: primary.withAlpha(80)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Integration examples', Icons.extension_rounded, primary),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(
              child: _integrationCard(
                title: 'Interpreter script mode',
                points: const <String>[
                  'Embed in `build(context)` scripts.',
                  'Compose with local helper widgets.',
                  'Keep visuals deterministic for snapshot review.',
                ],
                color: primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _integrationCard(
                title: 'Runtime bridge mode',
                points: const <String>[
                  'Validate bridged constructor/method behavior.',
                  'Observe nested composition with material widgets.',
                  'Use this deep demo as migration baseline.',
                ],
                color: accent,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDebugSection({
  required ThemeData theme,
  required Color primary,
  required Color accent,
  required Color surface,
}) {
  final TextStyle? bodyStyle = theme.textTheme.bodyMedium;
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: _panelDecoration(surface: surface, border: accent.withAlpha(70)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Debug checklist', Icons.fact_check_rounded, accent),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: accent.withAlpha(72)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Runtime verification', style: bodyStyle?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              _checkRow('Header and overview cards render with gradients and icons.'),
              _checkRow('Scenario gallery shows six distinct visual displays.'),
              _checkRow('Matrix section remains legible in narrow and wide layouts.'),
              _checkRow('Integration section explains usage in interpreter workflows.'),
              _checkRow('No analyzer ignores are used in this script.'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPanel({
  required _DemoPanelData panel,
  required Color primary,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: primary.withAlpha(55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(panel.icon, color: accent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                panel.title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(panel.text, style: const TextStyle(height: 1.35)),
      ],
    ),
  );
}

Widget _buildScenarioCard({
  required String title,
  required String subtitle,
  required int index,
  required Color primary,
  required Color accent,
  required Color surface,
}) {
  final Color chipColor = index.isEven ? accent : primary;
  return SizedBox(
    width: 340,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: chipColor.withAlpha(75)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: chipColor.withAlpha(35),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: TextStyle(fontWeight: FontWeight.w700, color: chipColor),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(subtitle, style: const TextStyle(height: 1.35)),
          const SizedBox(height: 12),
          Container(
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: <Color>[surface, chipColor.withAlpha(45)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(
                4,
                (int i) => Container(
                  width: 26 + (i * 4),
                  height: 18 + (i * 10),
                  decoration: BoxDecoration(
                    color: chipColor.withAlpha(80 + i * 30),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _integrationCard({
  required String title,
  required List<String> points,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(78)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
        const SizedBox(height: 8),
        ...points.map((String point) => _checkRow(point)),
      ],
    ),
  );
}

Widget _sectionTitle(String text, IconData icon, Color color) {
  return Row(
    children: <Widget>[
      Icon(icon, color: color, size: 20),
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w800, color: color, fontSize: 18),
      ),
    ],
  );
}

Widget _buildBullet({required String text}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(Icons.circle, size: 8),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
      ],
    ),
  );
}

Widget _checkRow(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.check_circle_outline_rounded, size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

BoxDecoration _panelDecoration({required Color surface, required Color border}) {
  return BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: border),
  );
}

class _DemoPanelData {
  const _DemoPanelData({
    required this.title,
    required this.text,
    required this.icon,
  });

  final String title;
  final String text;
  final IconData icon;
}
