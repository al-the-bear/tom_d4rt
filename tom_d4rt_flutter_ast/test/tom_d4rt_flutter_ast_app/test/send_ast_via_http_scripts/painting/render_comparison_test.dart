// ignore_for_file: avoid_print
// D4rt deep-demo: RenderComparison — Cobalt / Slate theme, prefix rc
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget rcSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF3949AB), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF283593),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget rcChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget rcInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF455A64))),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12.0, color: Color(0xFF546E7A))),
        ),
      ],
    ),
  );
}

Widget rcSeverityBar(RenderComparison level) {
  final severityMap = {
    RenderComparison.identical: 0,
    RenderComparison.metadata: 1,
    RenderComparison.paint: 2,
    RenderComparison.layout: 3,
  };
  final severity = severityMap[level] ?? 0;
  final colors = [
    Color(0xFF4CAF50), // identical = green
    Color(0xFFFFC107), // metadata = amber
    Color(0xFFFF9800), // paint = orange
    Color(0xFFF44336), // layout = red
  ];

  return Row(
    children: List.generate(4, (i) {
      return Container(
        width: 30.0,
        height: 8.0,
        margin: EdgeInsets.only(right: 3.0),
        decoration: BoxDecoration(
          color: i <= severity ? colors[severity] : Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(4.0),
        ),
      );
    }),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('RenderComparison Deep Demo executing');
  print('=' * 60);

  // ── Section 1: Title ─────────────────────────────────────────
  print('\n[1] RenderComparison Overview');
  print('  Enum describing severity of difference between two objects');
  print('  4 values ordered by severity: identical → metadata → paint → layout');
  print('  Key use: TextPainter.compareTo, ShapeBorder.compareTo');

  final rcTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3949AB), Color(0xFF1A237E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('RenderComparison',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Describes the severity of the difference between two rendering objects',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFBBDEFB))),
        SizedBox(height: 6.0),
        Row(
          children: [
            rcChip('identical', Color(0xFF4CAF50)),
            rcChip('metadata', Color(0xFFFFC107)),
            rcChip('paint', Color(0xFFFF9800)),
            rcChip('layout', Color(0xFFF44336)),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: Four Values ───────────────────────────────────
  print('\n[2] The Four Severity Levels');
  for (final v in RenderComparison.values) {
    print('  ${v.name}: index=${v.index}');
  }

  final rcValueData = <Map<String, dynamic>>[
    {'value': RenderComparison.identical, 'label': 'identical',
     'icon': Icons.check_circle, 'color': Color(0xFF4CAF50),
     'desc': 'No difference at all', 'action': 'None'},
    {'value': RenderComparison.metadata, 'label': 'metadata',
     'icon': Icons.info_outline, 'color': Color(0xFFFFC107),
     'desc': 'Different metadata, no visual change', 'action': 'Check semantics'},
    {'value': RenderComparison.paint, 'label': 'paint',
     'icon': Icons.format_paint, 'color': Color(0xFFFF9800),
     'desc': 'Visual appearance changed', 'action': 'markNeedsPaint()'},
    {'value': RenderComparison.layout, 'label': 'layout',
     'icon': Icons.space_dashboard, 'color': Color(0xFFF44336),
     'desc': 'Size and position changed', 'action': 'markNeedsLayout()'},
  ];

  final rcFourValues = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5FF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      children: rcValueData.map((d) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: (d['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(d['icon'] as IconData, color: d['color'] as Color, size: 24.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(d['label'] as String,
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                            color: Color(0xFF283593))),
                    SizedBox(height: 2.0),
                    Text(d['desc'] as String,
                        style: TextStyle(fontSize: 11.0, color: Color(0xFF546E7A))),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text('Action: ', style: TextStyle(fontSize: 10.0,
                            fontWeight: FontWeight.w600, color: Color(0xFF455A64))),
                        Text(d['action'] as String,
                            style: TextStyle(fontSize: 10.0, color: d['color'] as Color,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    rcSeverityBar(d['value'] as RenderComparison),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 3: Severity Hierarchy ────────────────────────────
  print('\n[3] Severity Hierarchy');
  print('  identical < metadata < paint < layout');
  print('  Higher severity implies all lower levels too');
  print('  layout means paint also needs update');

  final rcHierarchy = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      children: [
        Text('Severity increases left to right',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF455A64))),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Column(
                  children: [
                    Text('identical', style: TextStyle(fontSize: 11.0,
                        fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('0', style: TextStyle(fontSize: 18.0,
                        fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Icon(Icons.arrow_forward, size: 14.0, color: Color(0xFF9E9E9E)),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFC107),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Column(
                  children: [
                    Text('metadata', style: TextStyle(fontSize: 11.0,
                        fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('1', style: TextStyle(fontSize: 18.0,
                        fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Icon(Icons.arrow_forward, size: 14.0, color: Color(0xFF9E9E9E)),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFF9800),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Column(
                  children: [
                    Text('paint', style: TextStyle(fontSize: 11.0,
                        fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('2', style: TextStyle(fontSize: 18.0,
                        fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Icon(Icons.arrow_forward, size: 14.0, color: Color(0xFF9E9E9E)),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF44336),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Column(
                  children: [
                    Text('layout', style: TextStyle(fontSize: 11.0,
                        fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('3', style: TextStyle(fontSize: 18.0,
                        fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('← Low impact', style: TextStyle(fontSize: 10.0,
                color: Color(0xFF4CAF50), fontWeight: FontWeight.w600)),
            Text('High impact →', style: TextStyle(fontSize: 10.0,
                color: Color(0xFFF44336), fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    ),
  );

  // ── Section 4: Index Comparison ──────────────────────────────
  print('\n[4] Index-Based Comparison');
  print('  Can compare severity using index values');
  for (final a in RenderComparison.values) {
    for (final b in RenderComparison.values) {
      if (a.index < b.index) {
        print('  ${a.name}.index (${a.index}) < ${b.name}.index (${b.index})');
      }
    }
  }

  final rcIndexSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5FF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Index values enable severity comparison',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF455A64))),
        SizedBox(height: 8.0),
        ...RenderComparison.values.map((v) {
          final severityColors = [
            Color(0xFF4CAF50), Color(0xFFFFC107),
            Color(0xFFFF9800), Color(0xFFF44336),
          ];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              children: [
                Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: severityColors[v.index],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${v.index}',
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10.0),
                Text(v.name,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600,
                        color: Color(0xFF283593))),
                SizedBox(width: 8.0),
                Expanded(child: rcSeverityBar(v)),
              ],
            ),
          );
        }),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'if (result.index >= RenderComparison.paint.index) {\n'
            '  markNeedsPaint();\n'
            '}',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                color: Color(0xFF283593)),
          ),
        ),
      ],
    ),
  );

  // ── Section 5: Rebuild Decision Tree ─────────────────────────
  print('\n[5] Rebuild Decision Tree');
  print('  identical → do nothing');
  print('  metadata  → update semantics only');
  print('  paint     → markNeedsPaint (repaint)');
  print('  layout    → markNeedsLayout (resize + repaint)');

  final decisionData = <Map<String, dynamic>>[
    {'level': 'identical', 'decision': 'Do nothing',
     'icon': Icons.check, 'color': Color(0xFF4CAF50),
     'detail': 'Objects are indistinguishable, no work needed'},
    {'level': 'metadata', 'decision': 'Update semantics',
     'icon': Icons.description, 'color': Color(0xFFFFC107),
     'detail': 'Accessibility labels or debug info changed, not visible'},
    {'level': 'paint', 'decision': 'Repaint only',
     'icon': Icons.format_paint, 'color': Color(0xFFFF9800),
     'detail': 'Visual change (color, style) but same dimensions'},
    {'level': 'layout', 'decision': 'Full relayout',
     'icon': Icons.space_dashboard, 'color': Color(0xFFF44336),
     'detail': 'Size or position changed, triggers paint cascade'},
  ];

  final rcDecisionSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      children: decisionData.map((d) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 6.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border(
              left: BorderSide(color: d['color'] as Color, width: 4.0),
            ),
          ),
          child: Row(
            children: [
              Icon(d['icon'] as IconData, color: d['color'] as Color, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(d['level'] as String,
                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                                color: Color(0xFF283593))),
                        Text('  →  ', style: TextStyle(fontSize: 12.0,
                            color: Color(0xFF9E9E9E))),
                        Text(d['decision'] as String,
                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600,
                                color: d['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 2.0),
                    Text(d['detail'] as String,
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF78909C))),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 6: TextPainter Usage ─────────────────────────────
  print('\n[6] TextPainter.compareTo Usage');
  print('  TextStyle changes produce different RenderComparison levels');
  print('  Color change → paint');
  print('  FontSize change → layout');
  print('  Semantics label change → metadata');

  final textStyleChanges = <Map<String, dynamic>>[
    {'change': 'Same style', 'result': 'identical', 'color': Color(0xFF4CAF50)},
    {'change': 'Semantics label', 'result': 'metadata', 'color': Color(0xFFFFC107)},
    {'change': 'Color / decoration', 'result': 'paint', 'color': Color(0xFFFF9800)},
    {'change': 'Font size / weight', 'result': 'layout', 'color': Color(0xFFF44336)},
    {'change': 'Font family', 'result': 'layout', 'color': Color(0xFFF44336)},
    {'change': 'Letter spacing', 'result': 'layout', 'color': Color(0xFFF44336)},
  ];

  final rcTextPainterSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5FF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('TextStyle property changes mapped to comparison levels',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF455A64))),
        SizedBox(height: 8.0),
        Row(
          children: [
            SizedBox(width: 130.0,
                child: Text('Property Change', style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF283593)))),
            Expanded(child: Text('Result', style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 11.0,
                color: Color(0xFF283593)))),
          ],
        ),
        Divider(color: Color(0xFF9FA8DA)),
        ...textStyleChanges.map((c) => Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              SizedBox(width: 130.0,
                  child: Text(c['change'] as String,
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF546E7A)))),
              rcChip(c['result'] as String, c['color'] as Color),
            ],
          ),
        )),
      ],
    ),
  );

  // ── Section 7: Performance Implications ──────────────────────
  print('\n[7] Performance Implications');
  print('  identical: O(0) — zero work');
  print('  metadata: O(1) — semantics update');
  print('  paint: O(n) — repaint subtree');
  print('  layout: O(n²) — relayout + repaint cascade');

  final perfData = <Map<String, dynamic>>[
    {'level': 'identical', 'cost': 'Zero', 'perf': '0%', 'color': Color(0xFF4CAF50),
     'detail': 'No render work, fastest possible outcome'},
    {'level': 'metadata', 'cost': 'Minimal', 'perf': '5%', 'color': Color(0xFFFFC107),
     'detail': 'Only semantics tree updated, no visual work'},
    {'level': 'paint', 'cost': 'Moderate', 'perf': '40%', 'color': Color(0xFFFF9800),
     'detail': 'Repaint affected render objects, skip layout'},
    {'level': 'layout', 'cost': 'High', 'perf': '100%', 'color': Color(0xFFF44336),
     'detail': 'Full layout pass, then paint pass, most expensive'},
  ];

  final rcPerfSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      children: perfData.map((p) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  rcChip(p['level'] as String, p['color'] as Color),
                  SizedBox(width: 6.0),
                  Text('Cost: ${p['cost']}',
                      style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                          color: Color(0xFF455A64))),
                ],
              ),
              SizedBox(height: 6.0),
              // Cost bar
              Container(
                width: double.infinity,
                height: 10.0,
                decoration: BoxDecoration(
                  color: Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: FractionallySizedBox(
                  widthFactor: double.parse((p['perf'] as String)
                      .replaceAll('%', '')) / 100.0,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: p['color'] as Color,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              Text(p['detail'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF78909C))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 8: Comparison Table ──────────────────────────────
  print('\n[8] Comparison Table');
  print('  Level     | Repaint | Relayout | Semantics | Cost');
  print('  identical | No      | No       | No        | None');
  print('  metadata  | No      | No       | Yes       | Low');
  print('  paint     | Yes     | No       | Yes       | Medium');
  print('  layout    | Yes     | Yes      | Yes       | High');

  final rcCompData = <Map<String, dynamic>>[
    {'level': 'identical', 'repaint': false, 'relayout': false,
     'semantics': false, 'cost': 'None'},
    {'level': 'metadata', 'repaint': false, 'relayout': false,
     'semantics': true, 'cost': 'Low'},
    {'level': 'paint', 'repaint': true, 'relayout': false,
     'semantics': true, 'cost': 'Medium'},
    {'level': 'layout', 'repaint': true, 'relayout': true,
     'semantics': true, 'cost': 'High'},
  ];

  final rcCompTable = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5FF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 65.0, child: Text('Level',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0,
                    color: Color(0xFF283593)))),
            SizedBox(width: 55.0, child: Text('Repaint',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0,
                    color: Color(0xFF283593)), textAlign: TextAlign.center)),
            SizedBox(width: 55.0, child: Text('Relayout',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0,
                    color: Color(0xFF283593)), textAlign: TextAlign.center)),
            SizedBox(width: 60.0, child: Text('Semantics',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0,
                    color: Color(0xFF283593)), textAlign: TextAlign.center)),
            Expanded(child: Text('Cost',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0,
                    color: Color(0xFF283593)))),
          ],
        ),
        Divider(color: Color(0xFF9FA8DA)),
        ...rcCompData.map((r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              SizedBox(width: 65.0, child: Text(r['level'] as String,
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
                      color: Color(0xFF3949AB)))),
              SizedBox(width: 55.0, child: Icon(
                (r['repaint'] as bool) ? Icons.check_circle : Icons.cancel,
                color: (r['repaint'] as bool) ? Color(0xFFFF9800) : Color(0xFFBDBDBD),
                size: 16.0)),
              SizedBox(width: 55.0, child: Icon(
                (r['relayout'] as bool) ? Icons.check_circle : Icons.cancel,
                color: (r['relayout'] as bool) ? Color(0xFFF44336) : Color(0xFFBDBDBD),
                size: 16.0)),
              SizedBox(width: 60.0, child: Icon(
                (r['semantics'] as bool) ? Icons.check_circle : Icons.cancel,
                color: (r['semantics'] as bool) ? Color(0xFFFFC107) : Color(0xFFBDBDBD),
                size: 16.0)),
              Expanded(child: Text(r['cost'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A)))),
            ],
          ),
        )),
      ],
    ),
  );

  // ── Section 9: Practical Use Cases ───────────────────────────
  print('\n[9] Practical Use Cases');
  print('  Theme switching: often paint-level changes');
  print('  Font size: layout-level change');
  print('  Tooltip changes: metadata-level');
  print('  No change: identical');

  final rcUseCases = <Map<String, dynamic>>[
    {'title': 'Theme Color Switch', 'icon': Icons.palette,
     'level': 'paint', 'color': Color(0xFFFF9800),
     'desc': 'Changing text color or decoration color triggers repaint'},
    {'title': 'Font Size Change', 'icon': Icons.format_size,
     'level': 'layout', 'color': Color(0xFFF44336),
     'desc': 'Larger/smaller text changes layout constraints'},
    {'title': 'Tooltip Update', 'icon': Icons.chat_bubble_outline,
     'level': 'metadata', 'color': Color(0xFFFFC107),
     'desc': 'Accessibility text changed, no visual impact'},
    {'title': 'AnimationController', 'icon': Icons.animation,
     'level': 'paint', 'color': Color(0xFFFF9800),
     'desc': 'Opacity or transform animation only needs repaint'},
    {'title': 'Widget Rebuild', 'icon': Icons.refresh,
     'level': 'identical', 'color': Color(0xFF4CAF50),
     'desc': 'Const widget rebuild detects no change at all'},
    {'title': 'Text Direction', 'icon': Icons.swap_horiz,
     'level': 'layout', 'color': Color(0xFFF44336),
     'desc': 'RTL → LTR changes entire text layout flow'},
  ];

  final rcUseCaseSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: rcUseCases.map((uc) {
        return Container(
          width: 155.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF9FA8DA).withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(uc['icon'] as IconData, color: Color(0xFF3949AB), size: 16.0),
                  SizedBox(width: 4.0),
                  Expanded(child: Text(uc['title'] as String,
                      style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                          color: Color(0xFF283593)))),
                ],
              ),
              SizedBox(height: 4.0),
              rcChip(uc['level'] as String, uc['color'] as Color),
              SizedBox(height: 4.0),
              Text(uc['desc'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 10: ShapeBorder Usage ────────────────────────────
  print('\n[10] ShapeBorder Comparison');
  print('  ShapeBorderSide.compareTo returns RenderComparison');
  print('  Width change → layout');
  print('  Color change → paint');
  print('  Style change → paint');

  final borderChanges = <Map<String, dynamic>>[
    {'prop': 'Same border', 'result': 'identical', 'color': Color(0xFF4CAF50)},
    {'prop': 'Color change', 'result': 'paint', 'color': Color(0xFFFF9800)},
    {'prop': 'Style change', 'result': 'paint', 'color': Color(0xFFFF9800)},
    {'prop': 'Width change', 'result': 'layout', 'color': Color(0xFFF44336)},
    {'prop': 'StrokeAlign change', 'result': 'layout', 'color': Color(0xFFF44336)},
  ];

  final rcBorderSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5FF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BorderSide property changes and their comparison level',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF455A64))),
        SizedBox(height: 8.0),
        ...borderChanges.map((c) => Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              SizedBox(width: 120.0, child: Text(c['prop'] as String,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF546E7A)))),
              rcChip(c['result'] as String, c['color'] as Color),
            ],
          ),
        )),
      ],
    ),
  );

  // ── Section 11: Switch Pattern ───────────────────────────────
  print('\n[11] Switch Pattern');
  final testResult = RenderComparison.paint;
  switch (testResult) {
    case RenderComparison.identical:
      print('  → No rebuild needed');
    case RenderComparison.metadata:
      print('  → Update semantics only');
    case RenderComparison.paint:
      print('  → Call markNeedsPaint()');
    case RenderComparison.layout:
      print('  → Call markNeedsLayout()');
  }

  final rcSwitchSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dart 3 Switch Expression',
            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                color: Color(0xFF283593))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'switch (comparison) {\n'
            '  RenderComparison.identical => null,\n'
            '  RenderComparison.metadata  =>\n'
            '    markNeedsSemanticsUpdate(),\n'
            '  RenderComparison.paint     =>\n'
            '    markNeedsPaint(),\n'
            '  RenderComparison.layout    =>\n'
            '    markNeedsLayout(),\n'
            '}',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                color: Color(0xFF283593)),
          ),
        ),
        SizedBox(height: 8.0),
        ...RenderComparison.values.map((v) {
          final desc = switch (v) {
            RenderComparison.identical => 'No work',
            RenderComparison.metadata => 'Semantics only',
            RenderComparison.paint => 'Repaint',
            RenderComparison.layout => 'Relayout + repaint',
          };
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Icon(Icons.arrow_right, color: Color(0xFF3949AB), size: 16.0),
                Text('${v.name} → $desc',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF546E7A))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 12: Max Severity Pattern ─────────────────────────
  print('\n[12] Max Severity Pattern');
  print('  When comparing multiple properties, take the max');
  final a = RenderComparison.paint;
  final b = RenderComparison.metadata;
  final maxSeverity = a.index >= b.index ? a : b;
  print('  max(${a.name}, ${b.name}) = ${maxSeverity.name}');

  final rcMaxSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5FF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Taking the maximum severity across multiple comparisons',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF455A64))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'RenderComparison result = identical;\n'
            'result = _maxComparison(result,\n'
            '    style.compareTo(other.style));\n'
            'result = _maxComparison(result,\n'
            '    border.compareTo(other.border));\n'
            '// result is the worst-case severity',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                color: Color(0xFF283593)),
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: [
            _rcMaxExample('identical', 'metadata', 'metadata'),
            _rcMaxExample('paint', 'metadata', 'paint'),
            _rcMaxExample('layout', 'paint', 'layout'),
            _rcMaxExample('identical', 'layout', 'layout'),
          ],
        ),
      ],
    ),
  );

  // ── Section 13: Equality & Hashing ───────────────────────────
  print('\n[13] Equality & Hashing');
  print('  identical == identical: ${RenderComparison.identical == RenderComparison.identical}');
  print('  identical == layout: ${RenderComparison.identical == RenderComparison.layout}');

  final rcEqualitySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rcInfoRow('identical == identical:',
            '${RenderComparison.identical == RenderComparison.identical}'),
        rcInfoRow('identical == layout:',
            '${RenderComparison.identical == RenderComparison.layout}'),
        rcInfoRow('paint == paint:',
            '${RenderComparison.paint == RenderComparison.paint}'),
        rcInfoRow('hashCode identical:',
            '${RenderComparison.identical.hashCode}'),
        rcInfoRow('hashCode layout:',
            '${RenderComparison.layout.hashCode}'),
        SizedBox(height: 6.0),
        Divider(color: Color(0xFF9FA8DA)),
        SizedBox(height: 4.0),
        Wrap(
          spacing: 6.0,
          children: RenderComparison.values
              .toSet()
              .map((v) => rcChip(v.name, Color(0xFF3949AB)))
              .toList(),
        ),
      ],
    ),
  );

  // ── Section 14: Common Code Patterns ─────────────────────────
  print('\n[14] Common Code Patterns');
  print('  Pattern 1: compareTo in RenderObject.update');
  print('  Pattern 2: Max severity accumulation');
  print('  Pattern 3: Conditional rebuild');

  final rcPatterns = <Map<String, String>>[
    {'title': 'RenderObject Update Pattern',
     'code': 'void update(TextStyle newStyle) {\n'
         '  final cmp = _style.compareTo(newStyle);\n'
         '  _style = newStyle;\n'
         '  if (cmp.index >= RenderComparison\n'
         '      .layout.index)\n'
         '    markNeedsLayout();\n'
         '  else if (cmp.index >= RenderComparison\n'
         '      .paint.index)\n'
         '    markNeedsPaint();\n'
         '}'},
    {'title': 'Severity Accumulator',
     'code': 'var worst = RenderComparison.identical;\n'
         'for (final prop in properties) {\n'
         '  final cmp = prop.compare(other);\n'
         '  if (cmp.index > worst.index)\n'
         '    worst = cmp;\n'
         '}'},
    {'title': 'Guard Clause',
     'code': 'final cmp = oldText.compareTo(newText);\n'
         'if (cmp == RenderComparison.identical)\n'
         '  return; // nothing to do'},
  ];

  final rcPatternsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5FF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      children: rcPatterns.map((p) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p['title']!,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                      color: Color(0xFF3949AB))),
              SizedBox(height: 6.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(p['code']!,
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                        color: Color(0xFF283593))),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 15: When to Use Each ─────────────────────────────
  print('\n[15] When to Use Each');
  print('  identical: No-op early return');
  print('  metadata: Accessibility / semantics updates');
  print('  paint: Visual-only changes (color, opacity)');
  print('  layout: Structural changes (size, spacing, alignment)');

  final rcWhenData = <Map<String, dynamic>>[
    {'level': 'identical', 'icon': Icons.check_circle, 'color': Color(0xFF4CAF50),
     'when': 'Early return optimization, no-op detection, const widget rebuilds'},
    {'level': 'metadata', 'icon': Icons.info_outline, 'color': Color(0xFFFFC107),
     'when': 'Accessibility label changes, debug info, tooltip text updates'},
    {'level': 'paint', 'icon': Icons.format_paint, 'color': Color(0xFFFF9800),
     'when': 'Color changes, opacity animation, decoration style, text decoration'},
    {'level': 'layout', 'icon': Icons.space_dashboard, 'color': Color(0xFFF44336),
     'when': 'Font size, padding, alignment, constraints, text direction changes'},
  ];

  final rcWhenSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F0FA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      children: rcWhenData.map((w) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(w['icon'] as IconData, color: w['color'] as Color, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(w['level'] as String,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                            color: w['color'] as Color)),
                    Text(w['when'] as String,
                        style: TextStyle(fontSize: 11.0, color: Color(0xFF546E7A))),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  Total values: ${RenderComparison.values.length}');
  print('  Ordered by severity: identical → layout');
  print('  Primary API: TextStyle.compareTo');
  print('  Key pattern: max-severity accumulation');

  final rcSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('RenderComparison Dashboard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('${RenderComparison.values.length}',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,
                        color: Color(0xFFBBDEFB))),
                Text('Levels', style: TextStyle(fontSize: 11.0, color: Color(0xFF9FA8DA))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.trending_up, color: Color(0xFFBBDEFB), size: 28.0),
                Text('Ordered severity',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF9FA8DA))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.speed, color: Color(0xFFBBDEFB), size: 28.0),
                Text('Performance tool',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF9FA8DA))),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            rcChip('identical', Color(0xFF4CAF50)),
            rcChip('metadata', Color(0xFFFFC107)),
            rcChip('paint', Color(0xFFFF9800)),
            rcChip('layout', Color(0xFFF44336)),
          ],
        ),
      ],
    ),
  );

  print('\nRenderComparison Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        rcTitleSection,
        SizedBox(height: 16.0),
        // 2 Four Values
        rcSectionHeader('The Four Severity Levels', Icons.bar_chart),
        rcFourValues,
        // 3 Hierarchy
        rcSectionHeader('Severity Hierarchy', Icons.trending_up),
        rcHierarchy,
        // 4 Index
        rcSectionHeader('Index-Based Comparison', Icons.numbers),
        rcIndexSection,
        // 5 Decision Tree
        rcSectionHeader('Rebuild Decision Tree', Icons.account_tree),
        rcDecisionSection,
        // 6 TextPainter
        rcSectionHeader('TextPainter Usage', Icons.text_fields),
        rcTextPainterSection,
        // 7 Performance
        rcSectionHeader('Performance Implications', Icons.speed),
        rcPerfSection,
        // 8 Comparison
        rcSectionHeader('Feature Comparison', Icons.table_chart),
        rcCompTable,
        // 9 Use Cases
        rcSectionHeader('Practical Use Cases', Icons.auto_awesome),
        rcUseCaseSection,
        // 10 Border
        rcSectionHeader('ShapeBorder Comparison', Icons.border_all),
        rcBorderSection,
        // 11 Switch
        rcSectionHeader('Switch Pattern', Icons.alt_route),
        rcSwitchSection,
        // 12 Max Severity
        rcSectionHeader('Max Severity Pattern', Icons.arrow_upward),
        rcMaxSection,
        // 13 Equality
        rcSectionHeader('Equality & Hashing', Icons.check_circle_outline),
        rcEqualitySection,
        // 14 Patterns
        rcSectionHeader('Common Code Patterns', Icons.code),
        rcPatternsSection,
        // 15 When to Use
        rcSectionHeader('When to Use Each', Icons.lightbulb_outline),
        rcWhenSection,
        // 16 Summary
        SizedBox(height: 8.0),
        rcSummarySection,
      ],
    ),
  );
}

// ── Top-level helper for max-severity examples ──────────────────
Widget _rcMaxExample(String aName, String bName, String result) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text('max($aName, $bName) = $result',
        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
            color: Color(0xFF283593))),
  );
}
