// ignore_for_file: avoid_print
// D4rt deep-demo: TextOverflow — Brick / Rust theme, prefix ov
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget ovSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFFB54A32), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8B3A2A),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget ovChip(String label, Color bg) {
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

Widget ovInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8B3A2A))),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12.0, color: Color(0xFF6D3B2E))),
        ),
      ],
    ),
  );
}

Widget ovOverflowDemo(TextOverflow mode, String label, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ovChip(label, accent),
            Expanded(
              child: Text('index: ${mode.index}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF999999))),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        SizedBox(
          width: 200.0,
          child: Text(
            'This is a very long text that will definitely overflow the available space in this container widget',
            overflow: mode,
            maxLines: 1,
            style: TextStyle(fontSize: 12.0, color: Color(0xFF6D3B2E)),
          ),
        ),
      ],
    ),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('TextOverflow Deep Demo executing');
  print('=' * 60);

  // ── Section 1: Title ─────────────────────────────────────────
  print('\n[1] TextOverflow Overview');
  print('  Enum controlling how overflowed text is handled');
  print('  4 values: clip, fade, ellipsis, visible');
  print('  Key use: Text widget overflow property');

  final ovTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFB54A32), Color(0xFF8B3A2A)],
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
            Icon(Icons.text_fields, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('TextOverflow',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Controls how visual overflow of text is handled in constrained containers',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFFFCCBC))),
        SizedBox(height: 6.0),
        Row(
          children: [
            ovChip('clip', Color(0xFFCD6B50)),
            ovChip('fade', Color(0xFFD4825E)),
            ovChip('ellipsis', Color(0xFFA0522D)),
            ovChip('visible', Color(0xFF6D3B2E)),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: Four Values ───────────────────────────────────
  print('\n[2] The Four Overflow Modes');
  for (final v in TextOverflow.values) {
    print('  ${v.name}: index=${v.index}');
  }

  final ovValueData = <Map<String, dynamic>>[
    {'value': TextOverflow.clip, 'label': 'clip',
     'color': Color(0xFFCD6B50), 'icon': Icons.content_cut,
     'desc': 'Text is hard-clipped at container boundary',
     'visual': 'Abruptly cut off mid-character'},
    {'value': TextOverflow.fade, 'label': 'fade',
     'color': Color(0xFFD4825E), 'icon': Icons.gradient,
     'desc': 'Text fades to transparent at the edge',
     'visual': 'Smooth gradient disappearance'},
    {'value': TextOverflow.ellipsis, 'label': 'ellipsis',
     'color': Color(0xFFA0522D), 'icon': Icons.more_horiz,
     'desc': 'Truncated text ends with "..." indicator',
     'visual': 'Clean truncation with hint of more'},
    {'value': TextOverflow.visible, 'label': 'visible',
     'color': Color(0xFF6D3B2E), 'icon': Icons.open_in_full,
     'desc': 'Text renders beyond container bounds',
     'visual': 'Text paints outside its box'},
  ];

  final ovFourValues = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF5F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      children: ovValueData.map((d) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border(
              left: BorderSide(color: d['color'] as Color, width: 4.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(d['icon'] as IconData, color: d['color'] as Color, size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(d['label'] as String,
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                            color: Color(0xFF8B3A2A))),
                    SizedBox(height: 2.0),
                    Text(d['desc'] as String,
                        style: TextStyle(fontSize: 11.0, color: Color(0xFF6D3B2E))),
                    SizedBox(height: 2.0),
                    Text(d['visual'] as String,
                        style: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic,
                            color: Color(0xFFB54A32))),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 3: Live Overflow Gallery ─────────────────────────
  print('\n[3] Live Overflow Gallery');
  print('  Showing each mode with constrained text');

  final ovLiveGallery = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE8),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Each mode applied to the same long text (maxLines: 1, width: 200px)',
            style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8B3A2A))),
        SizedBox(height: 8.0),
        ovOverflowDemo(TextOverflow.clip, 'clip', Color(0xFFCD6B50)),
        ovOverflowDemo(TextOverflow.fade, 'fade', Color(0xFFD4825E)),
        ovOverflowDemo(TextOverflow.ellipsis, 'ellipsis', Color(0xFFA0522D)),
        ovOverflowDemo(TextOverflow.visible, 'visible', Color(0xFF6D3B2E)),
      ],
    ),
  );

  // ── Section 4: Multi-Line Behavior ───────────────────────────
  print('\n[4] Multi-Line Behavior');
  print('  clip/fade/ellipsis: controlled by maxLines');
  print('  visible: ignores maxLines, shows all text');
  print('  Overflow occurs on the LAST allowed line');

  final multiLineData = <Map<String, dynamic>>[
    {'mode': 'clip', 'maxLines': '2', 'behavior': 'Clips at end of line 2'},
    {'mode': 'fade', 'maxLines': '2', 'behavior': 'Fades at end of line 2'},
    {'mode': 'ellipsis', 'maxLines': '2', 'behavior': '"..." at end of line 2'},
    {'mode': 'visible', 'maxLines': '2', 'behavior': 'Shows all text beyond line 2'},
  ];

  final ovMultiLineSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF5F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      children: [
        Text('Multi-line overflow behavior with maxLines: 2',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8B3A2A))),
        SizedBox(height: 8.0),
        ...multiLineData.map((m) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ovChip(m['mode'] as String, Color(0xFFB54A32)),
                    Text('maxLines: ${m['maxLines']}',
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF999999))),
                  ],
                ),
                SizedBox(height: 4.0),
                Container(
                  width: 250.0,
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFE0A090)),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'This is a long sample text that wraps to multiple lines demonstrating overflow with maxLines set to two lines',
                    maxLines: 2,
                    overflow: TextOverflow.values.firstWhere(
                        (v) => v.name == m['mode']),
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF6D3B2E)),
                  ),
                ),
                SizedBox(height: 2.0),
                Text(m['behavior'] as String,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFFB54A32))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 5: Text Widget Integration ───────────────────────
  print('\n[5] Text Widget Integration');
  print('  Text widget uses overflow property');
  print('  Must set maxLines or softWrap: false for overflow');
  print('  Default overflow: TextOverflow.clip');

  final ovTextWidgetSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE8),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Text Widget Overflow Configuration',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700,
                color: Color(0xFF8B3A2A))),
        SizedBox(height: 8.0),
        ovInfoRow('Property:', 'Text.overflow'),
        ovInfoRow('Type:', 'TextOverflow?'),
        ovInfoRow('Default:', 'TextOverflow.clip'),
        ovInfoRow('Requires:', 'maxLines or softWrap: false'),
        ovInfoRow('Also in:', 'RichText, TextPainter'),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF0EB),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Text(\n'
            '  "Long text here...",\n'
            '  overflow: TextOverflow.ellipsis,\n'
            '  maxLines: 1,\n'
            ')',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                color: Color(0xFF8B3A2A)),
          ),
        ),
      ],
    ),
  );

  // ── Section 6: Width Constraint Effects ──────────────────────
  print('\n[6] Width Constraint Effects');
  print('  Overflow only occurs within constrained width');
  print('  Narrow = more overflow, wide = less overflow');

  final widths = <double>[100.0, 180.0, 260.0];

  final ovWidthSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF5F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Same text at different container widths (ellipsis mode)',
            style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8B3A2A))),
        SizedBox(height: 8.0),
        ...widths.map((w) => Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Width: ${w.toInt()}px',
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
                      color: Color(0xFFB54A32))),
              SizedBox(height: 4.0),
              Container(
                width: w,
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFB54A32)),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'Learning Flutter text overflow handling techniques',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF6D3B2E)),
                ),
              ),
            ],
          ),
        )),
      ],
    ),
  );

  // ── Section 7: softWrap Interaction ──────────────────────────
  print('\n[7] softWrap Interaction');
  print('  softWrap: true (default) — text wraps to next line');
  print('  softWrap: false — single line, needs overflow handling');
  print('  maxLines: N — wraps up to N lines, then overflows');

  final wrapData = <Map<String, String>>[
    {'config': 'softWrap: true (default)', 'behavior': 'Text wraps normally',
     'overflow': 'Only on last line if maxLines set'},
    {'config': 'softWrap: false', 'behavior': 'Single line always',
     'overflow': 'Overflow mode applies at end'},
    {'config': 'maxLines: 1', 'behavior': 'One line max',
     'overflow': 'Overflow on first line'},
    {'config': 'maxLines: 3', 'behavior': 'Wraps to 3 lines',
     'overflow': 'Overflow on line 3'},
  ];

  final ovWrapSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE8),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      children: wrapData.map((w) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 6.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(w['config']!,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                      fontFamily: 'monospace', color: Color(0xFF8B3A2A))),
              SizedBox(height: 4.0),
              ovInfoRow('Behavior:', w['behavior']!),
              ovInfoRow('Overflow:', w['overflow']!),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 8: Comparison Table ──────────────────────────────
  print('\n[8] Comparison Table');
  print('  Mode     | Visual    | Indicator | Extends');
  print('  clip     | Hard cut  | None      | No');
  print('  fade     | Gradient  | Fade      | No');
  print('  ellipsis | Truncate  | "..."     | No');
  print('  visible  | Full text | None      | Yes');

  final ovCompData = <Map<String, String>>[
    {'mode': 'clip', 'visual': 'Hard cut', 'indicator': 'None', 'extends': 'No'},
    {'mode': 'fade', 'visual': 'Gradient', 'indicator': 'Fade effect', 'extends': 'No'},
    {'mode': 'ellipsis', 'visual': 'Truncate', 'indicator': '"..."', 'extends': 'No'},
    {'mode': 'visible', 'visual': 'Full text', 'indicator': 'None', 'extends': 'Yes'},
  ];

  final ovCompTable = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF5F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 60.0, child: Text('Mode',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF8B3A2A)))),
            SizedBox(width: 65.0, child: Text('Visual',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF8B3A2A)))),
            SizedBox(width: 70.0, child: Text('Indicator',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF8B3A2A)))),
            Expanded(child: Text('Extends?',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.0,
                    color: Color(0xFF8B3A2A)))),
          ],
        ),
        Divider(color: Color(0xFFE0A090)),
        ...ovCompData.map((r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              SizedBox(width: 60.0, child: Text(r['mode']!,
                  style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                      color: Color(0xFFB54A32)))),
              SizedBox(width: 65.0, child: Text(r['visual']!,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF6D3B2E)))),
              SizedBox(width: 70.0, child: Text(r['indicator']!,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF6D3B2E)))),
              Expanded(child: Text(r['extends']!,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF6D3B2E)))),
            ],
          ),
        )),
      ],
    ),
  );

  // ── Section 9: Practical Use Cases ───────────────────────────
  print('\n[9] Practical Use Cases');
  print('  List items: ellipsis');
  print('  Headlines: fade');
  print('  Debug/dev: visible');
  print('  Chat bubbles: clip');
  print('  Search results: ellipsis');
  print('  Tooltips: visible');

  final ovUseCases = <Map<String, dynamic>>[
    {'title': 'List Item Title', 'icon': Icons.list,
     'mode': 'ellipsis', 'color': Color(0xFFA0522D),
     'desc': 'Clean "..." truncation for consistent list layout'},
    {'title': 'Banner Headline', 'icon': Icons.title,
     'mode': 'fade', 'color': Color(0xFFD4825E),
     'desc': 'Smooth gradient fade for decorative text clipping'},
    {'title': 'Debug Overlay', 'icon': Icons.bug_report,
     'mode': 'visible', 'color': Color(0xFF6D3B2E),
     'desc': 'Show full text regardless of container bounds'},
    {'title': 'Chat Message', 'icon': Icons.chat_bubble,
     'mode': 'clip', 'color': Color(0xFFCD6B50),
     'desc': 'Hard clip for fixed-height message previews'},
    {'title': 'Search Result', 'icon': Icons.search,
     'mode': 'ellipsis', 'color': Color(0xFFA0522D),
     'desc': 'Truncated results with indication of more content'},
    {'title': 'Chip Label', 'icon': Icons.label,
     'mode': 'fade', 'color': Color(0xFFD4825E),
     'desc': 'Small containers where "..." would be too visible'},
  ];

  final ovUseCaseSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE8),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: ovUseCases.map((uc) {
        return Container(
          width: 155.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFE0A090).withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(uc['icon'] as IconData, color: Color(0xFFB54A32), size: 16.0),
                  SizedBox(width: 4.0),
                  Expanded(child: Text(uc['title'] as String,
                      style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                          color: Color(0xFF8B3A2A)))),
                ],
              ),
              SizedBox(height: 4.0),
              ovChip(uc['mode'] as String, uc['color'] as Color),
              SizedBox(height: 4.0),
              Text(uc['desc'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF6D3B2E))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 10: RichText & TextPainter ───────────────────────
  print('\n[10] RichText & TextPainter');
  print('  RichText also uses overflow property');
  print('  TextPainter uses ellipsis string directly');
  print('  TextPainter.ellipsis = "..." for ellipsis mode');

  final ovRichTextSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF5F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Usage in RichText & TextPainter',
            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                color: Color(0xFF8B3A2A))),
        SizedBox(height: 8.0),
        Container(
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
              Text('RichText',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                      color: Color(0xFFB54A32))),
              SizedBox(height: 4.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF0EB),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'RichText(\n'
                  '  text: TextSpan(text: "..."),\n'
                  '  overflow: TextOverflow.ellipsis,\n'
                  '  maxLines: 2,\n'
                  ')',
                  style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                      color: Color(0xFF8B3A2A)),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TextPainter',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                      color: Color(0xFFB54A32))),
              SizedBox(height: 4.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF0EB),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'TextPainter(\n'
                  '  text: span,\n'
                  '  maxLines: 1,\n'
                  '  ellipsis: "...",\n'
                  '  // maps to TextOverflow.ellipsis\n'
                  ')',
                  style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                      color: Color(0xFF8B3A2A)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 11: Switch Pattern ───────────────────────────────
  print('\n[11] Switch Pattern');
  final testMode = TextOverflow.ellipsis;
  switch (testMode) {
    case TextOverflow.clip:
      print('  → Hard clip at boundary');
    case TextOverflow.fade:
      print('  → Gradient fade at edge');
    case TextOverflow.ellipsis:
      print('  → Truncate with "..."');
    case TextOverflow.visible:
      print('  → Render beyond bounds');
  }

  final ovSwitchSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE8),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dart 3 Switch Expression',
            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                color: Color(0xFF8B3A2A))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF0EB),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'final desc = switch (overflow) {\n'
            '  TextOverflow.clip     => "Hard clip",\n'
            '  TextOverflow.fade     => "Gradient fade",\n'
            '  TextOverflow.ellipsis => "Truncate ...",\n'
            '  TextOverflow.visible  => "Beyond bounds",\n'
            '};',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                color: Color(0xFF8B3A2A)),
          ),
        ),
        SizedBox(height: 8.0),
        ...TextOverflow.values.map((v) {
          final desc = switch (v) {
            TextOverflow.clip => 'Hard clip',
            TextOverflow.fade => 'Gradient fade',
            TextOverflow.ellipsis => 'Truncate with "..."',
            TextOverflow.visible => 'Render beyond bounds',
          };
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Icon(Icons.arrow_right, color: Color(0xFFB54A32), size: 16.0),
                Text('${v.name} → $desc',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF6D3B2E))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 12: Cross-Mode Grid ──────────────────────────────
  print('\n[12] Cross-Mode Grid');
  print('  Side-by-side display of all four modes');

  final ovGridSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF5F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(child: _ovGridCell('clip', TextOverflow.clip, Color(0xFFCD6B50))),
            SizedBox(width: 8.0),
            Expanded(child: _ovGridCell('fade', TextOverflow.fade, Color(0xFFD4825E))),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(child: _ovGridCell('ellipsis', TextOverflow.ellipsis, Color(0xFFA0522D))),
            SizedBox(width: 8.0),
            Expanded(child: _ovGridCell('visible', TextOverflow.visible, Color(0xFF6D3B2E))),
          ],
        ),
      ],
    ),
  );

  // ── Section 13: Equality & Hashing ───────────────────────────
  print('\n[13] Equality & Hashing');
  print('  clip == clip: ${TextOverflow.clip == TextOverflow.clip}');
  print('  clip == ellipsis: ${TextOverflow.clip == TextOverflow.ellipsis}');
  print('  hashCode clip: ${TextOverflow.clip.hashCode}');
  print('  hashCode ellipsis: ${TextOverflow.ellipsis.hashCode}');

  final ovEqualitySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE8),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ovInfoRow('clip == clip:', '${TextOverflow.clip == TextOverflow.clip}'),
        ovInfoRow('clip == ellipsis:', '${TextOverflow.clip == TextOverflow.ellipsis}'),
        ovInfoRow('hashCode clip:', '${TextOverflow.clip.hashCode}'),
        ovInfoRow('hashCode ellipsis:', '${TextOverflow.ellipsis.hashCode}'),
        SizedBox(height: 6.0),
        Divider(color: Color(0xFFE0A090)),
        SizedBox(height: 4.0),
        Wrap(
          spacing: 6.0,
          children: TextOverflow.values
              .toSet()
              .map((v) => ovChip(v.name, Color(0xFFB54A32)))
              .toList(),
        ),
      ],
    ),
  );

  // ── Section 14: Common Code Patterns ─────────────────────────
  print('\n[14] Common Code Patterns');
  print('  Pattern 1: Single-line list tile');
  print('  Pattern 2: Expandable text');
  print('  Pattern 3: Responsive overflow');

  final ovPatterns = <Map<String, String>>[
    {'title': 'Single-Line List Tile',
     'code': 'ListTile(\n'
         '  title: Text(\n'
         '    title,\n'
         '    overflow: TextOverflow.ellipsis,\n'
         '    maxLines: 1,\n'
         '  ),\n'
         ')'},
    {'title': 'Expandable Text Widget',
     'code': 'Text(\n'
         '  content,\n'
         '  overflow: isExpanded\n'
         '      ? TextOverflow.visible\n'
         '      : TextOverflow.ellipsis,\n'
         '  maxLines: isExpanded ? null : 3,\n'
         ')'},
    {'title': 'Responsive Overflow Choice',
     'code': 'Text(\n'
         '  text,\n'
         '  overflow: isCompact\n'
         '      ? TextOverflow.ellipsis\n'
         '      : TextOverflow.fade,\n'
         '  maxLines: isCompact ? 1 : 2,\n'
         ')'},
  ];

  final ovPatternsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF5F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      children: ovPatterns.map((p) {
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
                      color: Color(0xFFB54A32))),
              SizedBox(height: 6.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF0EB),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(p['code']!,
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                        color: Color(0xFF8B3A2A))),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 15: When to Use Each ─────────────────────────────
  print('\n[15] When to Use Each');
  print('  clip: Basic containers, no visual indicator needed');
  print('  fade: Decorative headers, banners, artistic layouts');
  print('  ellipsis: Lists, tables, data-heavy UIs, search results');
  print('  visible: Debug, tooltips, overlays, measured text');

  final ovWhenData = <Map<String, dynamic>>[
    {'mode': 'clip', 'icon': Icons.content_cut, 'color': Color(0xFFCD6B50),
     'when': 'Basic containers, no visual indicator needed, default fallback'},
    {'mode': 'fade', 'icon': Icons.gradient, 'color': Color(0xFFD4825E),
     'when': 'Decorative headers, banners, artistic layouts, chips'},
    {'mode': 'ellipsis', 'icon': Icons.more_horiz, 'color': Color(0xFFA0522D),
     'when': 'Lists, tables, search results, data-heavy UIs, titles'},
    {'mode': 'visible', 'icon': Icons.open_in_full, 'color': Color(0xFF6D3B2E),
     'when': 'Debug overlays, tooltips, expandable content, measured text'},
  ];

  final ovWhenSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE8),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0A090)),
    ),
    child: Column(
      children: ovWhenData.map((w) {
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
                    Text(w['mode'] as String,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                            color: w['color'] as Color)),
                    Text(w['when'] as String,
                        style: TextStyle(fontSize: 11.0, color: Color(0xFF6D3B2E))),
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
  print('  Total values: ${TextOverflow.values.length}');
  print('  Default: clip');
  print('  Most common: ellipsis');
  print('  Used in: Text, RichText, TextPainter');

  final ovSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF8B3A2A), Color(0xFFB54A32)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('TextOverflow Dashboard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('${TextOverflow.values.length}',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,
                        color: Color(0xFFFFCCBC))),
                Text('Modes', style: TextStyle(fontSize: 11.0,
                    color: Color(0xFFE0A090))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.content_cut, color: Color(0xFFFFCCBC), size: 28.0),
                Text('Default: clip',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFFE0A090))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.more_horiz, color: Color(0xFFFFCCBC), size: 28.0),
                Text('Most used: ellipsis',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFFE0A090))),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 4.0,
          alignment: WrapAlignment.center,
          children: TextOverflow.values
              .map((v) => ovChip(v.name, Color(0xFFCD6B50)))
              .toList(),
        ),
      ],
    ),
  );

  print('\nTextOverflow Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        ovTitleSection,
        SizedBox(height: 16.0),
        // 2 Four Values
        ovSectionHeader('The Four Overflow Modes', Icons.format_list_numbered),
        ovFourValues,
        // 3 Live Gallery
        ovSectionHeader('Live Overflow Gallery', Icons.play_circle_outline),
        ovLiveGallery,
        // 4 Multi-Line
        ovSectionHeader('Multi-Line Behavior', Icons.wrap_text),
        ovMultiLineSection,
        // 5 Text Widget
        ovSectionHeader('Text Widget Integration', Icons.text_snippet),
        ovTextWidgetSection,
        // 6 Width
        ovSectionHeader('Width Constraint Effects', Icons.straighten),
        ovWidthSection,
        // 7 softWrap
        ovSectionHeader('softWrap Interaction', Icons.sync_alt),
        ovWrapSection,
        // 8 Comparison
        ovSectionHeader('Mode Comparison', Icons.table_chart),
        ovCompTable,
        // 9 Use Cases
        ovSectionHeader('Practical Use Cases', Icons.auto_awesome),
        ovUseCaseSection,
        // 10 RichText
        ovSectionHeader('RichText & TextPainter', Icons.text_format),
        ovRichTextSection,
        // 11 Switch
        ovSectionHeader('Switch Pattern', Icons.alt_route),
        ovSwitchSection,
        // 12 Grid
        ovSectionHeader('Cross-Mode Grid', Icons.grid_view),
        ovGridSection,
        // 13 Equality
        ovSectionHeader('Equality & Hashing', Icons.check_circle_outline),
        ovEqualitySection,
        // 14 Patterns
        ovSectionHeader('Common Code Patterns', Icons.code),
        ovPatternsSection,
        // 15 When to Use
        ovSectionHeader('When to Use Each', Icons.lightbulb_outline),
        ovWhenSection,
        // 16 Summary
        SizedBox(height: 8.0),
        ovSummarySection,
      ],
    ),
  );
}

// ── Top-level helper for grid cells ─────────────────────────────
Widget _ovGridCell(String label, TextOverflow mode, Color accent) {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                color: accent)),
        SizedBox(height: 4.0),
        SizedBox(
          width: double.infinity,
          child: Text(
            'This is a demonstration of text overflow behavior in Flutter widgets',
            overflow: mode,
            maxLines: 1,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF6D3B2E)),
          ),
        ),
      ],
    ),
  );
}
