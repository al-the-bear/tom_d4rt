// ignore_for_file: avoid_print
// Deep demo: DevToolsDeepLinkProperty — diagnostics deep linking for DevTools
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Slate Blue / Ice Silver
// ─────────────────────────────────────────────────────────────
const Color _dpSlate = Color(0xFF455A64);
const Color _dpIce = Color(0xFFECEFF1);
const Color _dpDarkSlate = Color(0xFF1C313A);
const Color _dpMedSlate = Color(0xFF607D8B);
const Color _dpLightSlate = Color(0xFFB0BEC5);
const Color _dpWhite = Color(0xFFFFFFFF);
const Color _dpDarkText = Color(0xFF263238);
const Color _dpAccentCyan = Color(0xFF00838F);
const Color _dpAccentBlue = Color(0xFF1565C0);
const Color _dpAccentGreen = Color(0xFF2E7D32);
const Color _dpAccentOrange = Color(0xFFE65100);
const Color _dpAccentPurple = Color(0xFF6A1B9A);
const Color _dpAccentRed = Color(0xFFC62828);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _dpSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dpWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dpLightSlate, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x15455A64), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _dpSlate,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _dpWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _dpLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _dpDarkSlate,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _dpBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _dpDarkText, fontSize: 12.5, height: 1.5)),
  );
}

Widget _dpCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F7F8),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _dpLightSlate.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _dpDarkSlate,
            height: 1.45)),
  );
}

Widget _dpChip(String text, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(text,
        style:
            TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _dpDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _dpLightSlate.withValues(alpha: 0.4),
  );
}

Widget _dpInfoBox(String text, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text(text,
        style: TextStyle(
            color: color, fontSize: 11.5, fontWeight: FontWeight.w500)),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: DevToolsDeepLinkProperty');
  print('  Diagnostics deep linking for Flutter DevTools');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _dpIce,
      appBarTheme: const AppBarTheme(
        backgroundColor: _dpSlate,
        foregroundColor: _dpWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DevToolsDeepLinkProperty',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Banner
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_dpDarkSlate, _dpSlate, _dpMedSlate],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _dpWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.link,
                        color: _dpWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('DevToolsDeepLinkProperty',
                      style: TextStyle(
                          color: _dpWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(
                      'Diagnostics property for DevTools widget deep linking',
                      style: TextStyle(
                          color: _dpWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dpChip('DevTools', _dpWhite.withValues(alpha: 0.25), _dpWhite),
                      _dpChip('Deep Link', _dpWhite.withValues(alpha: 0.25), _dpWhite),
                      _dpChip('Diagnostics', _dpWhite.withValues(alpha: 0.25), _dpWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('1 · What Is DevToolsDeepLinkProperty?', [
              _dpBody(
                'DevToolsDeepLinkProperty is a specialized DiagnosticsProperty '
                'that embeds a URI enabling Flutter DevTools to navigate '
                'directly to a specific widget, element, or render object '
                'in the inspector tree.',
              ),
              _dpLabel('Class position'),
              _dpCodeBlock(
                'DiagnosticsNode (abstract)\n'
                '  └─ DiagnosticsProperty<T>\n'
                '       └─ DevToolsDeepLinkProperty\n'
                '            • description: String\n'
                '            • value: String (the deep link URI)\n'
                '            • Used by framework for DevTools integration',
              ),
              _dpDivider(),
              _dpInfoBox(
                'This property is automatically added by the Flutter framework '
                'to diagnostics — you rarely create it manually.',
                _dpAccentCyan,
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Diagnostics hierarchy
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('2 · Diagnostics Property Hierarchy', [
              _dpBody(
                'DevToolsDeepLinkProperty sits within the larger '
                'diagnostics system used by Flutter for debugging.',
              ),
              _buildDiagnosticsHierarchy(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: How DevTools uses deep links
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('3 · How DevTools Uses Deep Links', [
              _dpBody(
                'When a DevToolsDeepLinkProperty is present in a '
                'diagnostics node, DevTools renders it as a clickable '
                'link that navigates to a specific inspector tab or view.',
              ),
              _buildDeepLinkFlow(),
              _dpDivider(),
              _dpCodeBlock(
                '// Typical deep link URI format:\n'
                '// devtools://inspector?uri=...\n'
                '//   &inspectorRef=<element-id>\n'
                '//   &tab=widget-inspector\n'
                '\n'
                '// When clicked in DevTools:\n'
                '// 1. Opens the Inspector tab\n'
                '// 2. Navigates to the specific widget\n'
                '// 3. Highlights it in the render tree',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Creating deep link properties
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('4 · Creating Deep Link Properties', [
              _dpBody(
                'While the framework creates these automatically, here '
                'is how a DevToolsDeepLinkProperty is constructed:',
              ),
              _dpCodeBlock(
                'DevToolsDeepLinkProperty(\n'
                '  "Open in DevTools Inspector",\n'
                '  "devtools://inspector"\n'
                '      "?uri=package:my_app/main.dart"\n'
                '      "&inspectorRef=widget-42"\n'
                '      "&tab=widget-inspector",\n'
                ')',
              ),
              _dpDivider(),
              _dpLabel('Parameters'),
              _buildPropertyParams(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: URI structure
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('5 · Deep Link URI Structure', [
              _dpBody(
                'The URI encodes the necessary information for DevTools '
                'to navigate to the right place.',
              ),
              _buildUriBreakdown(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Property in widget tree
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('6 · Property in the Widget Tree', [
              _dpBody(
                'Each widget element can expose diagnostics properties. '
                'The deep link property appears alongside other debug info.',
              ),
              _buildWidgetTreeDiagnostics(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Where it appears in DevTools
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('7 · Where It Appears in DevTools', [
              _dpBody(
                'DevTools displays deep link properties in several places:',
              ),
              _buildDevToolsLocations(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Debugging workflow
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('8 · Debugging Workflow', [
              _dpBody(
                'A typical debugging workflow using deep link properties:',
              ),
              _buildDebuggingWorkflow(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Custom diagnostics with deep links
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('9 · Custom Diagnostics with Deep Links', [
              _dpBody(
                'You can add your own deep link properties to custom '
                'widgets for enhanced DevTools integration.',
              ),
              _dpCodeBlock(
                'class MyWidget extends StatelessWidget {\n'
                '  @override\n'
                '  void debugFillProperties(\n'
                '      DiagnosticPropertiesBuilder properties) {\n'
                '    super.debugFillProperties(properties);\n'
                '    properties.add(\n'
                '      DevToolsDeepLinkProperty(\n'
                '        "View in custom inspector",\n'
                '        buildDeepLinkUri(this),\n'
                '      ),\n'
                '    );\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  Widget build(BuildContext context) {\n'
                '    return const SizedBox();\n'
                '  }\n'
                '}',
              ),
              _dpDivider(),
              _dpInfoBox(
                'Custom deep links are useful for framework-level widgets '
                'that want to provide shortcut navigation in DevTools.',
                _dpAccentGreen,
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Comparison with other diagnostics
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('10 · Comparison with Other Diagnostics', [
              _dpBody(
                'DevToolsDeepLinkProperty compared to other diagnostics:',
              ),
              _buildDiagnosticsComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Practical scenario
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('11 · Practical Scenario: Error in Nested Widget', [
              _dpBody(
                'A deeply nested widget throws an error. The framework '
                'includes a DevToolsDeepLinkProperty in the error report '
                'so developers can jump directly to the failing widget.',
              ),
              _buildErrorScenario(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _dpSection('12 · Summary', [
              _dpBody(
                'DevToolsDeepLinkProperty bridges the gap between '
                'diagnostics data and interactive DevTools navigation.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_dpSlate, _dpMedSlate],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _dpSummaryRow(Icons.link, 'URI-based deep link to DevTools views'),
                    _dpSummaryRow(Icons.account_tree, 'Part of the DiagnosticsProperty hierarchy'),
                    _dpSummaryRow(Icons.search, 'Enables direct navigation to widgets'),
                    _dpSummaryRow(Icons.auto_fix_high, 'Auto-generated by framework in debug mode'),
                    _dpSummaryRow(Icons.bug_report, 'Appears in error reports for quick access'),
                    _dpSummaryRow(Icons.extension, 'Extensible — custom widgets can add their own'),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 2: Diagnostics hierarchy
// ─────────────────────────────────────────────────────────────
Widget _buildDiagnosticsHierarchy() {
  final nodes = <Map<String, dynamic>>[
    {'name': 'DiagnosticsNode', 'desc': 'Abstract base for all diagnostics', 'color': _dpAccentBlue, 'indent': 0},
    {'name': 'DiagnosticsProperty<T>', 'desc': 'Generic property with name + value', 'color': _dpAccentGreen, 'indent': 1},
    {'name': 'StringProperty', 'desc': 'String values', 'color': _dpMedSlate, 'indent': 2},
    {'name': 'IntProperty', 'desc': 'Integer values', 'color': _dpMedSlate, 'indent': 2},
    {'name': 'DoubleProperty', 'desc': 'Double values', 'color': _dpMedSlate, 'indent': 2},
    {'name': 'FlagProperty', 'desc': 'Boolean flags', 'color': _dpMedSlate, 'indent': 2},
    {'name': 'DevToolsDeepLinkProperty', 'desc': 'URI for DevTools navigation', 'color': _dpAccentCyan, 'indent': 2},
    {'name': 'DiagnosticsBlock', 'desc': 'Group of nested properties', 'color': _dpAccentPurple, 'indent': 1},
  ];

  return Column(
    children: nodes.map((n) {
      final indent = (n['indent'] as int) * 20.0;
      final isHighlight = n['name'] == 'DevToolsDeepLinkProperty';
      return Container(
        margin: EdgeInsets.only(left: indent, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isHighlight
              ? (n['color'] as Color).withValues(alpha: 0.12)
              : (n['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: (n['color'] as Color).withValues(alpha: isHighlight ? 0.5 : 0.3),
              width: isHighlight ? 2 : 1),
        ),
        child: Row(
          children: [
            if (isHighlight)
              Container(
                margin: const EdgeInsets.only(right: 6),
                child: const Icon(Icons.star, color: _dpAccentCyan, size: 14),
              ),
            Text(n['name'] as String,
                style: TextStyle(
                    color: n['color'] as Color,
                    fontSize: 11,
                    fontWeight: isHighlight ? FontWeight.w800 : FontWeight.w600,
                    fontFamily: 'monospace')),
            const SizedBox(width: 8),
            Expanded(
              child: Text(n['desc'] as String,
                  style: const TextStyle(color: _dpDarkText, fontSize: 10)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 3: Deep link flow
// ─────────────────────────────────────────────────────────────
Widget _buildDeepLinkFlow() {
  final steps = <Map<String, dynamic>>[
    {'icon': Icons.widgets, 'label': 'Widget produces diagnostics', 'color': _dpAccentBlue},
    {'icon': Icons.link, 'label': 'Deep link property attached', 'color': _dpAccentCyan},
    {'icon': Icons.computer, 'label': 'DevTools reads properties', 'color': _dpAccentGreen},
    {'icon': Icons.touch_app, 'label': 'User clicks deep link', 'color': _dpAccentOrange},
    {'icon': Icons.search, 'label': 'Inspector navigates to widget', 'color': _dpAccentPurple},
  ];

  return Column(
    children: steps.asMap().entries.map((entry) {
      final s = entry.value;
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (s['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: s['color'] as Color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(s['icon'] as IconData, color: _dpWhite, size: 16),
            ),
            const SizedBox(width: 10),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: _dpSlate.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('${entry.key + 1}',
                    style: const TextStyle(
                        color: _dpSlate, fontSize: 10, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(s['label'] as String,
                  style: TextStyle(
                      color: s['color'] as Color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 4: Property params
// ─────────────────────────────────────────────────────────────
Widget _buildPropertyParams() {
  final params = <Map<String, dynamic>>[
    {
      'name': 'description',
      'type': 'String',
      'desc': 'Human-readable label displayed in DevTools',
      'color': _dpAccentBlue,
    },
    {
      'name': 'value',
      'type': 'String',
      'desc': 'The deep link URI that DevTools navigates to',
      'color': _dpAccentCyan,
    },
  ];

  return Column(
    children: params.map((p) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (p['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: (p['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: p['color'] as Color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(p['name'] as String,
                  style: const TextStyle(
                      color: _dpWhite,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace')),
            ),
            const SizedBox(width: 8),
            _dpChip(p['type'] as String, _dpIce, _dpSlate),
            const SizedBox(width: 8),
            Expanded(
              child: Text(p['desc'] as String,
                  style: const TextStyle(color: _dpDarkText, fontSize: 10)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 5: URI breakdown
// ─────────────────────────────────────────────────────────────
Widget _buildUriBreakdown() {
  final parts = <Map<String, dynamic>>[
    {'part': 'devtools://', 'desc': 'Protocol scheme for DevTools', 'color': _dpAccentBlue},
    {'part': 'inspector', 'desc': 'Target DevTools tab', 'color': _dpAccentGreen},
    {'part': '?uri=pkg:...', 'desc': 'Source file location', 'color': _dpAccentOrange},
    {'part': '&inspectorRef=...', 'desc': 'Unique widget/element reference', 'color': _dpAccentCyan},
    {'part': '&tab=...', 'desc': 'Specific tab within inspector', 'color': _dpAccentPurple},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _dpIce,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dpLightSlate),
    ),
    child: Column(
      children: parts.map((p) {
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (p['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: (p['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _dpWhite,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: (p['color'] as Color).withValues(alpha: 0.3)),
                ),
                child: Text(p['part'] as String,
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: p['color'] as Color,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(p['desc'] as String,
                    style: const TextStyle(color: _dpDarkText, fontSize: 10)),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Widget tree diagnostics
// ─────────────────────────────────────────────────────────────
Widget _buildWidgetTreeDiagnostics() {
  final properties = <Map<String, dynamic>>[
    {'name': 'size', 'value': 'Size(360, 640)', 'type': 'normal', 'color': _dpMedSlate},
    {'name': 'constraints', 'value': 'BoxConstraints(w=360, h=640)', 'type': 'normal', 'color': _dpMedSlate},
    {'name': 'alignment', 'value': 'Alignment.center', 'type': 'normal', 'color': _dpMedSlate},
    {'name': 'Open in Inspector', 'value': 'devtools://inspector?ref=42', 'type': 'deeplink', 'color': _dpAccentCyan},
    {'name': 'renderObject', 'value': 'RenderPositionedBox#abc12', 'type': 'normal', 'color': _dpMedSlate},
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dpLightSlate),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: _dpSlate,
          child: const Row(
            children: [
              Icon(Icons.account_tree, color: _dpWhite, size: 14),
              SizedBox(width: 8),
              Text('Center Widget Properties',
                  style: TextStyle(
                      color: _dpWhite,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        ...properties.asMap().entries.map((entry) {
          final p = entry.value;
          final isLink = p['type'] == 'deeplink';
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: isLink
                ? (p['color'] as Color).withValues(alpha: 0.08)
                : entry.key.isEven
                    ? _dpIce
                    : _dpWhite,
            child: Row(
              children: [
                if (isLink)
                  const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(Icons.link, size: 12, color: _dpAccentCyan),
                  ),
                SizedBox(
                  width: 100,
                  child: Text(p['name'] as String,
                      style: TextStyle(
                          color: isLink ? _dpAccentCyan : _dpSlate,
                          fontSize: 10,
                          fontWeight: isLink ? FontWeight.w700 : FontWeight.w500)),
                ),
                Expanded(
                  child: Text(p['value'] as String,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: isLink ? _dpAccentCyan : _dpDarkText,
                          decoration:
                              isLink ? TextDecoration.underline : TextDecoration.none)),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 7: DevTools locations
// ─────────────────────────────────────────────────────────────
Widget _buildDevToolsLocations() {
  final locations = <Map<String, dynamic>>[
    {
      'location': 'Widget Inspector Panel',
      'desc': 'Deep link in the properties list of selected widget',
      'icon': Icons.account_tree,
      'color': _dpAccentBlue,
    },
    {
      'location': 'Error Messages',
      'desc': 'Clickable link in FlutterError details to jump to failing widget',
      'icon': Icons.error_outline,
      'color': _dpAccentRed,
    },
    {
      'location': 'Performance Overlay',
      'desc': 'Link to the widget causing jank in the timeline view',
      'icon': Icons.speed,
      'color': _dpAccentOrange,
    },
    {
      'location': 'Layout Explorer',
      'desc': 'Navigate directly to the flex widget being analyzed',
      'icon': Icons.grid_on,
      'color': _dpAccentGreen,
    },
    {
      'location': 'Console Output',
      'desc': 'Deep links in debug print output for quick navigation',
      'icon': Icons.terminal,
      'color': _dpAccentPurple,
    },
  ];

  return Column(
    children: locations.map((l) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (l['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (l['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: l['color'] as Color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(l['icon'] as IconData, color: _dpWhite, size: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l['location'] as String,
                      style: TextStyle(
                          color: l['color'] as Color,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700)),
                  Text(l['desc'] as String,
                      style: const TextStyle(color: _dpDarkText, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 8: Debugging workflow
// ─────────────────────────────────────────────────────────────
Widget _buildDebuggingWorkflow() {
  final steps = <Map<String, dynamic>>[
    {'step': 'App shows layout issue', 'detail': 'Overflow or misalignment detected', 'color': _dpAccentRed},
    {'step': 'Open DevTools Inspector', 'detail': 'In VS Code or browser', 'color': _dpAccentBlue},
    {'step': 'Select problematic widget', 'detail': 'Click or use select mode', 'color': _dpAccentGreen},
    {'step': 'Find deep link in properties', 'detail': 'DevToolsDeepLinkProperty listed', 'color': _dpAccentCyan},
    {'step': 'Click to navigate', 'detail': 'Jumps to source code location', 'color': _dpAccentOrange},
    {'step': 'Fix the issue', 'detail': 'Edit code and hot-reload', 'color': _dpAccentPurple},
  ];

  return Column(
    children: steps.asMap().entries.map((entry) {
      final s = entry.value;
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: (s['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: s['color'] as Color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('${entry.key + 1}',
                    style: const TextStyle(
                        color: _dpWhite, fontSize: 10, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['step'] as String,
                      style: TextStyle(
                          color: s['color'] as Color,
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                  Text(s['detail'] as String,
                      style: const TextStyle(color: _dpDarkText, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Comparison
// ─────────────────────────────────────────────────────────────
Widget _buildDiagnosticsComparison() {
  final rows = <List<String>>[
    ['Property', 'Purpose', 'Value Type'],
    ['StringProperty', 'Display text values', 'String'],
    ['IntProperty', 'Display numbers', 'int'],
    ['FlagProperty', 'Display boolean flags', 'bool'],
    ['ColorProperty', 'Display colors', 'Color'],
    ['DeepLinkProperty', 'Navigate to widget', 'URI String'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _dpLightSlate),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        final isHighlight = entry.key == rows.length - 1;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          color: isHeader
              ? _dpSlate
              : isHighlight
                  ? _dpAccentCyan.withValues(alpha: 0.08)
                  : entry.key.isEven
                      ? _dpIce
                      : _dpWhite,
          child: Row(
            children: entry.value.asMap().entries.map((col) {
              return Expanded(
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader
                            ? _dpWhite
                            : isHighlight
                                ? _dpAccentCyan
                                : _dpDarkText,
                        fontSize: 10.5,
                        fontWeight: isHeader || isHighlight
                            ? FontWeight.w700
                            : FontWeight.w400)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Error scenario
// ─────────────────────────────────────────────────────────────
Widget _buildErrorScenario() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dpAccentRed.withValues(alpha: 0.3)),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: _dpAccentRed,
          child: const Row(
            children: [
              Icon(Icons.error, color: _dpWhite, size: 14),
              SizedBox(width: 8),
              Expanded(
                child: Text('FlutterError: RenderBox was not laid out',
                    style: TextStyle(
                        color: _dpWhite,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          color: _dpAccentRed.withValues(alpha: 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'The following RenderObject was attempting to paint '
                'without a valid size:',
                style: TextStyle(
                    color: _dpDarkText, fontSize: 10.5, height: 1.4),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _dpWhite,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _dpLightSlate),
                ),
                child: const Text(
                  'RenderConstrainedBox#4f2a1\n'
                  '  parentData: offset=Offset(0, 0)\n'
                  '  constraints: MISSING',
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: _dpDarkText),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _dpAccentCyan.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _dpAccentCyan.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.link, size: 14, color: _dpAccentCyan),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Open in DevTools Inspector →',
                        style: TextStyle(
                            color: _dpAccentCyan,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            decorationColor: _dpAccentCyan.withValues(alpha: 0.5)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              _dpInfoBox(
                'The deep link property in the error lets developers jump '
                'directly to the failing widget in DevTools Inspector.',
                _dpAccentCyan,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _dpSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _dpWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _dpWhite.withValues(alpha: 0.95), fontSize: 12.5)),
        ),
      ],
    ),
  );
}
