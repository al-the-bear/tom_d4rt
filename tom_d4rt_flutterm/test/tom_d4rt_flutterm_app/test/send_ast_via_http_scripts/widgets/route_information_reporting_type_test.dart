// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RouteInformationReportingType from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFFE65100); // Orange 700
const _kAccent = Color(0xFF40C4FF); // LightBlue A200
const _kSurface = Color(0xFF191919);
const _kCard = Color(0xFF272727);
const _kDimText = Color(0xFF9E9E9E);
const _kBrightText = Color(0xFFEEEEEE);
const _kNone = Color(0xFFBDBDBD); // Grey 400
const _kNeglect = Color(0xFFFF8A65); // DeepOrange 300
const _kNavigate = Color(0xFF4FC3F7); // LightBlue 300

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: ColorScheme.dark(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _RouteInfoReportingTypeDemo(),
  );
}

class _RouteInfoReportingTypeDemo extends StatefulWidget {
  const _RouteInfoReportingTypeDemo();

  @override
  State<_RouteInfoReportingTypeDemo> createState() =>
      _RouteInfoReportingTypeDemoState();
}

class _RouteInfoReportingTypeDemoState
    extends State<_RouteInfoReportingTypeDemo>
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
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: const Text('RouteInformationReportingType',
            style: TextStyle(
                color: _kAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(icon: Icon(Icons.info_outline), text: 'Overview'),
            Tab(icon: Icon(Icons.science), text: 'Values Lab'),
            Tab(icon: Icon(Icons.router), text: 'Router'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _OverviewTab(),
          _ValuesLabTab(),
          _RouterTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Enum Overview
// ═══════════════════════════════════════════════════════════════════════════
class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Hero
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFBF360C), Color(0xFF4E342E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.route, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text(
                'RouteInformationReportingType',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: _kBrightText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _kAccent.withAlpha(80)),
                ),
                child: Text(
                  '${RouteInformationReportingType.values.length} enum values',
                  style: const TextStyle(
                      color: _kAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Indicates the intent behind route information reporting '
                'from the Router to the engine\'s navigation channel.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDimText, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Purpose
        _sect('Purpose'),
        const SizedBox(height: 10),
        _infoCard(
          icon: Icons.question_mark,
          iconColor: _kAccent,
          title: 'What Does It Signal?',
          body: 'When the Router reports RouteInformation to the engine '
              '(e.g. for browser URL updates), this enum tells the engine '
              'whether the report was triggered by a navigation action, '
              'should be neglected, or has no specific intent.',
        ),
        const SizedBox(height: 10),
        _infoCard(
          icon: Icons.history,
          iconColor: _kPrimary,
          title: 'History Stack Impact',
          body: 'The reporting type determines whether the reported route '
              'information creates a new history entry (navigate), replaces '
              'the current one (neglect), or follows default behavior (none).',
        ),
        const SizedBox(height: 20),

        // Quick reference
        _sect('Quick Reference'),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Column(
            children: [
              _refRow('none', _kNone,
                  'Default — no explicit intent', true),
              _refRow('neglect', _kNeglect,
                  'Do not push to history stack', false),
              _refRow('navigate', _kNavigate,
                  'Push new entry to history', false),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Enum metadata
        _sect('Enum Metadata'),
        const SizedBox(height: 10),
        ..._buildMetadataRows(),
      ],
    );
  }

  Widget _refRow(String name, Color color, String desc, bool first) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: first
            ? null
            : Border(
                top: BorderSide(color: _kPrimary.withAlpha(30))),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 70,
            child: Text(name,
                style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child:
                Text(desc, style: const TextStyle(color: _kDimText, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMetadataRows() {
    final values = RouteInformationReportingType.values;
    return [
      _metaRow('Value count', '${values.length}'),
      _metaRow('First value', values.first.name),
      _metaRow('Last value', values.last.name),
      _metaRow('Type', 'enum'),
      _metaRow('Library', 'widgets'),
    ];
  }

  Widget _metaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kPrimary.withAlpha(30)),
        ),
        child: Row(
          children: [
            Text(label,
                style: const TextStyle(color: _kDimText, fontSize: 13)),
            const Spacer(),
            Text(value,
                style: const TextStyle(
                    color: _kAccent,
                    fontSize: 13,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Values Lab (Interactive)
// ═══════════════════════════════════════════════════════════════════════════
class _ValuesLabTab extends StatefulWidget {
  const _ValuesLabTab();

  @override
  State<_ValuesLabTab> createState() => _ValuesLabTabState();
}

class _ValuesLabTabState extends State<_ValuesLabTab> {
  RouteInformationReportingType _selected =
      RouteInformationReportingType.none;

  Color _colorFor(RouteInformationReportingType v) {
    switch (v) {
      case RouteInformationReportingType.none:
        return _kNone;
      case RouteInformationReportingType.neglect:
        return _kNeglect;
      case RouteInformationReportingType.navigate:
        return _kNavigate;
    }
  }

  IconData _iconFor(RouteInformationReportingType v) {
    switch (v) {
      case RouteInformationReportingType.none:
        return Icons.radio_button_unchecked;
      case RouteInformationReportingType.neglect:
        return Icons.skip_next;
      case RouteInformationReportingType.navigate:
        return Icons.open_in_browser;
    }
  }

  String _descriptionFor(RouteInformationReportingType v) {
    switch (v) {
      case RouteInformationReportingType.none:
        return 'No specific reporting intent. The engine uses its default '
            'behavior for handling the reported route information. This is '
            'the initial state when no Router.navigate() or Router.neglect() '
            'scope is active.';
      case RouteInformationReportingType.neglect:
        return 'Generated inside a Router.neglect() scope. Signals that the '
            'route information should NOT create a new browser history entry. '
            'Useful for programmatic route changes that shouldn\'t affect the '
            'back button behavior.';
      case RouteInformationReportingType.navigate:
        return 'Generated inside a Router.navigate() scope. Signals that the '
            'route information SHOULD create a new browser history entry. '
            'This is the typical intent for user-initiated navigation.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(_selected);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sect('Select a Value'),
        const SizedBox(height: 12),

        // Value selector cards
        ...RouteInformationReportingType.values.map((v) {
          final isActive = v == _selected;
          final c = _colorFor(v);
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => setState(() => _selected = v),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isActive ? c.withAlpha(15) : _kCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isActive ? c.withAlpha(120) : _kCard,
                    width: isActive ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: c.withAlpha(isActive ? 40 : 20),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: c.withAlpha(isActive ? 80 : 40)),
                      ),
                      child: Icon(_iconFor(v),
                          color: c, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(v.name,
                              style: TextStyle(
                                  color: c,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace')),
                          const SizedBox(height: 2),
                          Text('index: ${v.index}',
                              style: const TextStyle(
                                  color: _kDimText,
                                  fontSize: 11,
                                  fontFamily: 'monospace')),
                        ],
                      ),
                    ),
                    if (isActive)
                      Icon(Icons.check_circle, color: c, size: 22),
                  ],
                ),
              ),
            ),
          );
        }),

        const SizedBox(height: 10),

        // Detail panel
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withAlpha(60)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(_iconFor(_selected), color: color, size: 22),
                  const SizedBox(width: 10),
                  Text('${_selected.name} Details',
                      style: TextStyle(
                          color: color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              Text(_descriptionFor(_selected),
                  style: const TextStyle(
                      color: _kDimText, fontSize: 13, height: 1.5)),
              const SizedBox(height: 14),
              _propertyRow('name', _selected.name, color),
              _propertyRow('index', '${_selected.index}', color),
              _propertyRow('hashCode', '${_selected.hashCode}', color),
              _propertyRow('toString()',
                  _selected.toString(), color),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Equality matrix
        _sect('Equality Matrix'),
        const SizedBox(height: 10),
        _buildEqualityMatrix(),
        const SizedBox(height: 20),

        // Browser behavior
        _sect('Browser History Effect'),
        const SizedBox(height: 10),
        _buildBrowserDiagram(),
      ],
    );
  }

  Widget _propertyRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label,
                style: const TextStyle(
                    color: _kDimText,
                    fontSize: 12,
                    fontFamily: 'monospace')),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withAlpha(10),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color.withAlpha(30)),
              ),
              child: Text(value,
                  style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontFamily: 'monospace')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEqualityMatrix() {
    final values = RouteInformationReportingType.values;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FixedColumnWidth(70),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
        },
        children: [
          // Header
          TableRow(
            children: [
              const SizedBox(height: 30),
              ...values.map((v) => Center(
                    child: Text(v.name,
                        style: TextStyle(
                            color: _colorFor(v),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace')),
                  )),
            ],
          ),
          // Data rows
          ...values.map((row) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(row.name,
                      style: TextStyle(
                          color: _colorFor(row),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace')),
                ),
                ...values.map((col) {
                  final eq = row == col;
                  return Center(
                    child: Container(
                      width: 28,
                      height: 28,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: eq
                            ? const Color(0xFF66BB6A).withAlpha(20)
                            : const Color(0xFFEF5350).withAlpha(10),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: eq
                              ? const Color(0xFF66BB6A).withAlpha(60)
                              : const Color(0xFFEF5350).withAlpha(30),
                        ),
                      ),
                      child: Icon(
                        eq ? Icons.check : Icons.close,
                        size: 14,
                        color: eq
                            ? const Color(0xFF66BB6A)
                            : const Color(0xFFEF5350),
                      ),
                    ),
                  );
                }),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBrowserDiagram() {
    final items = [
      (
        RouteInformationReportingType.navigate,
        'Pushes new entry',
        'URL bar updates, back button works',
        Icons.add_circle_outline,
      ),
      (
        RouteInformationReportingType.neglect,
        'Replaces current',
        'URL bar updates, back button unchanged',
        Icons.swap_horiz,
      ),
      (
        RouteInformationReportingType.none,
        'Engine default',
        'Platform-specific behavior applies',
        Icons.help_outline,
      ),
    ];

    return Column(
      children: items.map((item) {
        final c = _colorFor(item.$1);
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: c.withAlpha(50)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: c.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: c.withAlpha(60)),
                  ),
                  child: Icon(item.$4, color: c, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(item.$1.name,
                              style: TextStyle(
                                  color: c,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace')),
                          const SizedBox(width: 8),
                          Text('→ ${item.$2}',
                              style: const TextStyle(
                                  color: _kBrightText, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(item.$3,
                          style: const TextStyle(
                              color: _kDimText,
                              fontSize: 11,
                              height: 1.3)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Router Integration
// ═══════════════════════════════════════════════════════════════════════════
class _RouterTab extends StatefulWidget {
  const _RouterTab();

  @override
  State<_RouterTab> createState() => _RouterTabState();
}

class _RouterTabState extends State<_RouterTab> {
  bool _navigateActive = false;
  bool _neglectActive = false;

  RouteInformationReportingType get _computedType {
    if (_navigateActive) return RouteInformationReportingType.navigate;
    if (_neglectActive) return RouteInformationReportingType.neglect;
    return RouteInformationReportingType.none;
  }

  @override
  Widget build(BuildContext context) {
    final type = _computedType;
    final typeColor = _colorForType(type);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sect('Router Scope Simulator'),
        const SizedBox(height: 12),

        // Scope toggles
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Column(
            children: [
              const Text(
                'Toggle scopes to see how they affect the reporting type:',
                style: TextStyle(
                    color: _kDimText, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 16),
              _scopeToggle(
                'Router.navigate()',
                'Wraps callback in a navigate scope',
                _kNavigate,
                _navigateActive,
                (v) => setState(() {
                  _navigateActive = v;
                  if (v) _neglectActive = false;
                }),
              ),
              const SizedBox(height: 10),
              _scopeToggle(
                'Router.neglect()',
                'Wraps callback in a neglect scope',
                _kNeglect,
                _neglectActive,
                (v) => setState(() {
                  _neglectActive = v;
                  if (v) _navigateActive = false;
                }),
              ),
              const SizedBox(height: 16),

              // Result display
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: typeColor.withAlpha(80)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Reporting Type: ',
                        style: TextStyle(
                            color: _kDimText, fontSize: 14)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: typeColor.withAlpha(80)),
                      ),
                      child: Text(type.name,
                          style: TextStyle(
                              color: typeColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // How Router uses the type
        _sect('How Router Reports'),
        const SizedBox(height: 10),
        _buildRouterFlowDiagram(),
        const SizedBox(height: 20),

        // Code examples
        _sect('Code Patterns'),
        const SizedBox(height: 10),
        _buildCodeExample(
          'Navigation with history',
          'Router.navigate(context, () {\n'
              '  // Change route config here\n'
              '  myNotifier.value = newRoute;\n'
              '});\n'
              '// Reports with: navigate',
          _kNavigate,
        ),
        const SizedBox(height: 10),
        _buildCodeExample(
          'Silent route change',
          'Router.neglect(context, () {\n'
              '  // Change route config silently\n'
              '  myNotifier.value = newRoute;\n'
              '});\n'
              '// Reports with: neglect',
          _kNeglect,
        ),
        const SizedBox(height: 10),
        _buildCodeExample(
          'Default reporting',
          '// Outside any scope:\n'
              'myNotifier.value = newRoute;\n'
              '// Reports with: none',
          _kNone,
        ),
        const SizedBox(height: 20),

        // Platform differences
        _sect('Platform Behavior'),
        const SizedBox(height: 10),
        _buildPlatformTable(),
      ],
    );
  }

  Color _colorForType(RouteInformationReportingType t) {
    switch (t) {
      case RouteInformationReportingType.none:
        return _kNone;
      case RouteInformationReportingType.neglect:
        return _kNeglect;
      case RouteInformationReportingType.navigate:
        return _kNavigate;
    }
  }

  Widget _scopeToggle(String label, String desc, Color color,
      bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: value ? color.withAlpha(10) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: value ? color.withAlpha(60) : _kDimText.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(value ? Icons.check_box : Icons.check_box_outline_blank,
              color: value ? color : _kDimText, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: value ? color : _kBrightText,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace')),
                Text(desc,
                    style: const TextStyle(
                        color: _kDimText, fontSize: 11)),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: color,
            inactiveThumbColor: _kDimText,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildRouterFlowDiagram() {
    const steps = [
      ('RouteInformationProvider', 'Platform route info source',
          Icons.input),
      ('Router widget', 'Parses route, builds delegate',
          Icons.router),
      ('RouterDelegate.build()', 'Returns widget tree for route',
          Icons.widgets),
      ('Report back to provider', 'With ReportingType flag',
          Icons.output),
      ('Engine / Browser', 'Updates URL / history accordingly',
          Icons.language),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _kPrimary.withAlpha(30 + i * 12),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: _kAccent.withAlpha(40 + i * 10)),
                  ),
                  child: Icon(steps[i].$3,
                      size: 18, color: _kAccent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(steps[i].$1,
                          style: const TextStyle(
                              color: _kBrightText,
                              fontSize: 13,
                              fontWeight: FontWeight.w500)),
                      Text(steps[i].$2,
                          style: const TextStyle(
                              color: _kDimText, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
            if (i < steps.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 17),
                height: 14,
                width: 2,
                color: _kPrimary.withAlpha(40),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildCodeExample(String title, String code, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      color: _kBrightText,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withAlpha(30)),
            ),
            child: Text(code,
                style: const TextStyle(
                    color: _kBrightText,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    height: 1.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformTable() {
    const rows = [
      ('Web (Browser)', 'Full history API', 'All types functional'),
      ('Android', 'System back button', 'navigate → system nav'),
      ('iOS', 'Edge swipe', 'navigate → system nav'),
      ('Desktop', 'No browser', 'Minimal impact'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _kPrimary.withAlpha(20),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: const Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text('Platform',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
                Expanded(
                    flex: 2,
                    child: Text('Navigation',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
                Expanded(
                    flex: 3,
                    child: Text('Effect',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
              ],
            ),
          ),
          ...rows.map((r) => Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _kPrimary.withAlpha(25))),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(r.$1,
                            style: const TextStyle(
                                color: _kBrightText,
                                fontSize: 12))),
                    Expanded(
                        flex: 2,
                        child: Text(r.$2,
                            style: const TextStyle(
                                color: _kDimText,
                                fontSize: 11))),
                    Expanded(
                        flex: 3,
                        child: Text(r.$3,
                            style: const TextStyle(
                                color: _kDimText,
                                fontSize: 11))),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared Helpers
// ═══════════════════════════════════════════════════════════════════════════
Widget _sect(String title) {
  return Row(
    children: [
      Container(width: 4, height: 20, color: _kAccent),
      const SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: const TextStyle(
                color: _kBrightText,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
    ],
  );
}

Widget _infoCard({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: iconColor.withAlpha(50)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: _kBrightText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(body,
                  style: const TextStyle(
                      color: _kDimText, fontSize: 12, height: 1.5)),
            ],
          ),
        ),
      ],
    ),
  );
}
