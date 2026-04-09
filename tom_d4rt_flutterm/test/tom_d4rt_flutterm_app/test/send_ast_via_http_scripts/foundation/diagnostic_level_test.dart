// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Deep demo of DiagnosticLevel from foundation
// DiagnosticLevel is an enum with 9 values (hidden, fine, debug, info,
// warning, hint, summary, error, off) that control diagnostic filtering and
// determine which diagnostics appear in toString, toStringDeep, etc.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticLevel deep demo executing');

  // Master data: all 9 levels with metadata
  final dlLevels = <Map<String, dynamic>>[
    {'level': DiagnosticLevel.hidden, 'color': Color(0xFF9E9E9E), 'icon': Icons.visibility_off, 'purpose': 'Never shown in output', 'usage': 'Filtered away at all levels'},
    {'level': DiagnosticLevel.fine, 'color': Color(0xFF78909C), 'icon': Icons.tune, 'purpose': 'Low-value that matches defaults', 'usage': 'Properties that equal their default value'},
    {'level': DiagnosticLevel.debug, 'color': Color(0xFF42A5F5), 'icon': Icons.bug_report, 'purpose': 'Fine-grained debug info', 'usage': 'Verbose details for investigating issues'},
    {'level': DiagnosticLevel.info, 'color': Color(0xFF66BB6A), 'icon': Icons.info, 'purpose': 'Important diagnostic to show', 'usage': 'Main informational properties of a widget'},
    {'level': DiagnosticLevel.warning, 'color': Color(0xFFFFA726), 'icon': Icons.warning, 'purpose': 'Potentially problematic values', 'usage': 'Properties with unexpected or risky values'},
    {'level': DiagnosticLevel.hint, 'color': Color(0xFF26C6DA), 'icon': Icons.lightbulb, 'purpose': 'Best-practice suggestion', 'usage': 'Suggestions to improve widget configuration'},
    {'level': DiagnosticLevel.summary, 'color': Color(0xFF7E57C2), 'icon': Icons.summarize, 'purpose': 'Summarizes other diagnostics', 'usage': 'Compact child that summarises sub-tree details'},
    {'level': DiagnosticLevel.error, 'color': Color(0xFFEF5350), 'icon': Icons.error, 'purpose': 'Error or unexpected condition', 'usage': 'Critical issues like constraint violations'},
    {'level': DiagnosticLevel.off, 'color': Color(0xFF424242), 'icon': Icons.block, 'purpose': 'Sentinel to show nothing', 'usage': 'Used as filter level to suppress all diagnostics'},
  ];

  // ============================================================
  // SECTION 1: Overview Banner
  // ============================================================
  print('=== Section 1: Overview ===');
  print('DiagnosticLevel has ${DiagnosticLevel.values.length} values');

  Widget dlBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF57F17), Color(0xFFFFA000), Color(0xFFFFCA28)],
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      children: [
        Icon(Icons.layers, color: Colors.white, size: 44.0),
        SizedBox(height: 8.0),
        Text('DiagnosticLevel', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text('9 severity levels for diagnostic filtering', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        SizedBox(height: 8.0),
        Text(
          'Controls which diagnostic properties are included when Flutter widgets render their debug descriptions via toString(), toStringDeep(), and debugFillProperties().',
          style: TextStyle(fontSize: 12.0, color: Colors.white.withValues(alpha: 0.9)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Complete Enum Table
  // ============================================================
  print('=== Section 2: Enum Table ===');
  for (final item in dlLevels) {
    final level = item['level'] as DiagnosticLevel;
    print('  ${level.name}: index=${level.index}');
  }

  Widget dlEnumRow(int index, DiagnosticLevel level, Color color, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.0),
        border: Border(left: BorderSide(color: color, width: 3.0)),
      ),
      child: Row(
        children: [
          Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6.0)),
            child: Center(child: Text('$index', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.white))),
          ),
          SizedBox(width: 10.0),
          Icon(icon, color: color, size: 18.0),
          SizedBox(width: 8.0),
          Text(level.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, fontFamily: 'monospace', color: color)),
          Spacer(),
          Text('${level.toString().split(".").last}', style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 3: Severity Spectrum
  // ============================================================
  print('=== Section 3: Severity Spectrum ===');

  Widget dlSpectrumBar = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFFFE082)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Severity Spectrum', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xFFF57F17))),
        SizedBox(height: 4.0),
        Text('Levels are ordered by severity index (0=lowest, 8=highest):', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        Container(
          height: 36.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: dlLevels.map((item) {
              return Expanded(
                child: Container(
                  color: item['color'] as Color,
                  child: Center(
                    child: Text(
                      (item['level'] as DiagnosticLevel).name.substring(0, 3),
                      style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('← Less severe', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
            Text('More severe →', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: hidden Level
  // ============================================================
  print('=== Section 4: hidden ===');
  print('hidden index: ${DiagnosticLevel.hidden.index}');

  Widget dlLevelCard(DiagnosticLevel level, String description, String example, Color color, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8.0)),
                child: Icon(icon, color: Colors.white, size: 18.0),
              ),
              SizedBox(width: 10.0),
              Text('DiagnosticLevel.${level.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, fontFamily: 'monospace', color: color)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4.0)),
                child: Text('index ${level.index}', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: color)),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(description, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: color.withValues(alpha: 0.12)),
            ),
            child: Row(
              children: [
                Icon(Icons.code, color: color.withValues(alpha: 0.5), size: 16.0),
                SizedBox(width: 8.0),
                Expanded(child: Text(example, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.grey.shade800))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 5: fine Level
  // ============================================================
  print('=== Section 5: fine ===');
  print('fine index: ${DiagnosticLevel.fine.index}');

  // ============================================================
  // SECTION 6: debug Level
  // ============================================================
  print('=== Section 6: debug ===');
  print('debug index: ${DiagnosticLevel.debug.index}');

  // ============================================================
  // SECTION 7: info Level
  // ============================================================
  print('=== Section 7: info ===');
  print('info index: ${DiagnosticLevel.info.index}');

  // ============================================================
  // SECTION 8: warning Level
  // ============================================================
  print('=== Section 8: warning ===');
  print('warning index: ${DiagnosticLevel.warning.index}');

  // ============================================================
  // SECTION 9: hint Level
  // ============================================================
  print('=== Section 9: hint ===');
  print('hint index: ${DiagnosticLevel.hint.index}');

  // ============================================================
  // SECTION 10: summary Level
  // ============================================================
  print('=== Section 10: summary ===');
  print('summary index: ${DiagnosticLevel.summary.index}');

  // ============================================================
  // SECTION 11: error Level
  // ============================================================
  print('=== Section 11: error ===');
  print('error index: ${DiagnosticLevel.error.index}');

  // ============================================================
  // SECTION 12: off Level
  // ============================================================
  print('=== Section 12: off ===');
  print('off index: ${DiagnosticLevel.off.index}');

  // ============================================================
  // SECTION 13: Filtering Demonstration
  // ============================================================
  print('=== Section 13: Filtering ===');

  // Demonstrate how minLevel filtering works
  Widget dlFilterDemo(DiagnosticLevel minLevel) {
    final shown = DiagnosticLevel.values.where((l) => l.index >= minLevel.index && l != DiagnosticLevel.off).toList();
    final hidden = DiagnosticLevel.values.where((l) => l.index < minLevel.index || l == DiagnosticLevel.off).toList();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('minLevel = ', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(color: Color(0xFFF57F17).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4.0)),
                child: Text(minLevel.name, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, fontWeight: FontWeight.bold, color: Color(0xFFF57F17))),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: [
              ...shown.map((l) {
                final data = dlLevels.firstWhere((m) => m['level'] == l);
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(color: (data['color'] as Color).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4.0)),
                  child: Text(l.name, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: data['color'] as Color)),
                );
              }),
              ...hidden.map((l) => Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4.0)),
                child: Text(l.name, style: TextStyle(fontSize: 10.0, color: Colors.grey, decoration: TextDecoration.lineThrough)),
              )),
            ],
          ),
          SizedBox(height: 4.0),
          Text('Showing ${shown.length} / ${DiagnosticLevel.values.length} levels', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 14: DiagnosticsNode Integration
  // ============================================================
  print('=== Section 14: DiagnosticsNode Integration ===');

  // Create real diagnostic properties with different levels
  final dlInfoProp = StringProperty('name', 'DiagnosticLevel Demo', level: DiagnosticLevel.info);
  final dlDebugProp = IntProperty('count', 42, level: DiagnosticLevel.debug);
  final dlWarningProp = StringProperty('status', 'deprecated widget used', level: DiagnosticLevel.warning);
  final dlHintProp = MessageProperty('tip', 'Consider using Container instead', level: DiagnosticLevel.hint);
  final dlErrorProp = StringProperty('error', 'Constraints violated', level: DiagnosticLevel.error);
  final dlHiddenProp = StringProperty('internal', 'not for display', level: DiagnosticLevel.hidden);
  final dlFineProp = StringProperty('alignment', 'Alignment.center', level: DiagnosticLevel.fine);

  final dlDiagProps = [dlInfoProp, dlDebugProp, dlWarningProp, dlHintProp, dlErrorProp, dlHiddenProp, dlFineProp];

  print('Created ${dlDiagProps.length} diagnostic properties');
  for (final prop in dlDiagProps) {
    print('  ${prop.name}: level=${prop.level.name}, value=${prop.toStringDeep().trim()}');
  }

  Widget dlDiagRow(DiagnosticsNode node, Color levelColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: levelColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.0),
        border: Border(left: BorderSide(color: levelColor, width: 3.0)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
            decoration: BoxDecoration(color: levelColor, borderRadius: BorderRadius.circular(3.0)),
            child: Text(node.level.name.toUpperCase(), style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          SizedBox(width: 8.0),
          Text('${node.name}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0)),
          SizedBox(width: 4.0),
          Expanded(child: Text('${node.toDescription()}', style: TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: Colors.grey.shade700))),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 15: Comparison and Ordering
  // ============================================================
  print('=== Section 15: Comparison ===');
  print('error > warning: ${DiagnosticLevel.error.index > DiagnosticLevel.warning.index}');
  print('info > debug: ${DiagnosticLevel.info.index > DiagnosticLevel.debug.index}');

  Widget dlComparisonRow(DiagnosticLevel left, DiagnosticLevel right, String op) {
    final result = op == '>' ? left.index > right.index : op == '<' ? left.index < right.index : left.index == right.index;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: (result ? Colors.green : Colors.red).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Text('${left.name}.index', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, fontWeight: FontWeight.w500)),
          Text(' $op ', style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, fontWeight: FontWeight.bold, color: Color(0xFFF57F17))),
          Text('${right.name}.index', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, fontWeight: FontWeight.w500)),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: result ? Colors.green.shade100 : Colors.red.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              '${left.index} $op ${right.index} = $result',
              style: TextStyle(fontFamily: 'monospace', fontSize: 10.0, fontWeight: FontWeight.bold, color: result ? Colors.green.shade700 : Colors.red.shade700),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 16: Summary Dashboard
  // ============================================================
  print('=== Section 16: Summary ===');

  Widget dlSummaryTile(String label, String value, Color bg, Color text) {
    return Container(
      width: 95.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: text)),
          SizedBox(height: 2.0),
          Text(label, style: TextStyle(fontSize: 9.5, color: text.withValues(alpha: 0.7)), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  print('DiagnosticLevel deep demo completed');

  // ============================================================
  // ASSEMBLE FULL UI
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DiagnosticLevel Deep Demo'),
        backgroundColor: Color(0xFFF57F17),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Banner
            dlBanner,

            // Section 2: Enum Table
            SizedBox(height: 20.0),
            Text('2. All 9 Values', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFF57F17))),
            SizedBox(height: 8.0),
            ...dlLevels.map((item) {
              final level = item['level'] as DiagnosticLevel;
              return dlEnumRow(level.index, level, item['color'] as Color, item['icon'] as IconData);
            }),

            // Section 3: Spectrum
            SizedBox(height: 20.0),
            Text('3. Severity Spectrum', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFF57F17))),
            SizedBox(height: 4.0),
            dlSpectrumBar,

            // Sections 4-12: Individual level cards
            SizedBox(height: 20.0),
            Text('4–12. Level Details', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFF57F17))),
            SizedBox(height: 4.0),
            Text('Each level serves a distinct role in the diagnostics pipeline:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            dlLevelCard(
              DiagnosticLevel.hidden,
              'Properties that should never appear in diagnostic output. Used internally to exclude data from all toString representations regardless of filter settings.',
              'DiagnosticsProperty<String>("_internal", val, level: DiagnosticLevel.hidden)',
              Color(0xFF9E9E9E), Icons.visibility_off,
            ),
            dlLevelCard(
              DiagnosticLevel.fine,
              'Properties whose current value equals the default. These are typically filtered at info level but visible when debugging at a finer granularity.',
              'IntProperty("flex", 1, defaultValue: 1)  // level auto-set to fine',
              Color(0xFF78909C), Icons.tune,
            ),
            dlLevelCard(
              DiagnosticLevel.debug,
              'Verbose details useful when investigating specific issues. More granular than info, less critical than warnings. Shown in toStringDeep() when minLevel allows.',
              'DiagnosticsProperty<BoxConstraints>("constraints", c, level: DiagnosticLevel.debug)',
              Color(0xFF42A5F5), Icons.bug_report,
            ),
            dlLevelCard(
              DiagnosticLevel.info,
              'The standard level for diagnostic properties. These are the most commonly shown properties in toString and debugFillProperties output.',
              'StringProperty("direction", "horizontal")  // default level is info',
              Color(0xFF66BB6A), Icons.info,
            ),
            dlLevelCard(
              DiagnosticLevel.warning,
              'Properties with potentially problematic values that developers should be aware of. Visible at all common filter settings.',
              'DiagnosticsProperty<double>("aspect", -1.0, level: DiagnosticLevel.warning)',
              Color(0xFFFFA726), Icons.warning,
            ),
            dlLevelCard(
              DiagnosticLevel.hint,
              'Best-practice suggestions. Similar to warnings but framed as positive recommendations rather than problems.',
              'MessageProperty("hint", "Use const constructors", level: DiagnosticLevel.hint)',
              Color(0xFF26C6DA), Icons.lightbulb,
            ),
            dlLevelCard(
              DiagnosticLevel.summary,
              'Compact nodes that summarize a subtree of diagnostics. Useful for showing rolled-up information without expanding all children.',
              'DiagnosticsNode.message("3 children", level: DiagnosticLevel.summary)',
              Color(0xFF7E57C2), Icons.summarize,
            ),
            dlLevelCard(
              DiagnosticLevel.error,
              'Critical issues like constraint violations or unexpected null values. Always shown unless explicitly filtered with DiagnosticLevel.off.',
              'ErrorDescription("RenderBox was given infinite size")',
              Color(0xFFEF5350), Icons.error,
            ),
            dlLevelCard(
              DiagnosticLevel.off,
              'Sentinel value used purely as a filter threshold — never assigned to actual properties. Setting minLevel to off suppresses all diagnostic output.',
              'node.toStringDeep(minLevel: DiagnosticLevel.off)  // shows nothing',
              Color(0xFF424242), Icons.block,
            ),

            // Section 13: Filtering
            SizedBox(height: 20.0),
            Text('13. Filtering by minLevel', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFF57F17))),
            SizedBox(height: 4.0),
            Text('When toStringDeep(minLevel: X) is called, only levels with index >= X are included:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            dlFilterDemo(DiagnosticLevel.hidden),
            dlFilterDemo(DiagnosticLevel.debug),
            dlFilterDemo(DiagnosticLevel.info),
            dlFilterDemo(DiagnosticLevel.warning),
            dlFilterDemo(DiagnosticLevel.error),

            // Section 14: DiagnosticsNode
            SizedBox(height: 20.0),
            Text('14. Live DiagnosticsNode Properties', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFF57F17))),
            SizedBox(height: 4.0),
            Text('Real DiagnosticsProperty instances with different levels:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            ...dlDiagProps.map((prop) {
              final data = dlLevels.firstWhere((m) => m['level'] == prop.level);
              return dlDiagRow(prop, data['color'] as Color);
            }),

            // Section 15: Comparison
            SizedBox(height: 20.0),
            Text('15. Index Ordering', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFF57F17))),
            SizedBox(height: 4.0),
            Text('Severity is determined by comparing index values:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            dlComparisonRow(DiagnosticLevel.error, DiagnosticLevel.warning, '>'),
            dlComparisonRow(DiagnosticLevel.warning, DiagnosticLevel.info, '>'),
            dlComparisonRow(DiagnosticLevel.info, DiagnosticLevel.debug, '>'),
            dlComparisonRow(DiagnosticLevel.debug, DiagnosticLevel.fine, '>'),
            dlComparisonRow(DiagnosticLevel.hidden, DiagnosticLevel.fine, '<'),
            dlComparisonRow(DiagnosticLevel.off, DiagnosticLevel.error, '>'),

            // Section 16: Summary
            SizedBox(height: 20.0),
            Text('16. Summary', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFFF57F17))),
            SizedBox(height: 8.0),
            Wrap(
              children: [
                dlSummaryTile('Values', '${DiagnosticLevel.values.length}', Color(0xFFFFF8E1), Color(0xFFF57F17)),
                dlSummaryTile('First', DiagnosticLevel.values.first.name, Color(0xFFECEFF1), Color(0xFF616161)),
                dlSummaryTile('Last', DiagnosticLevel.values.last.name, Color(0xFFFBE9E7), Color(0xFFBF360C)),
                dlSummaryTile('Properties', '${dlDiagProps.length}', Color(0xFFE3F2FD), Color(0xFF1565C0)),
                dlSummaryTile('Filters', '5', Color(0xFFE8F5E9), Color(0xFF2E7D32)),
                dlSummaryTile('Sections', '16', Color(0xFFF3E5F5), Color(0xFF6A1B9A)),
              ],
            ),

            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}
