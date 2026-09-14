// ignore_for_file: avoid_print
// D4rt test script: Deep demo for FlutterLogoStyle enum from painting
// Demonstrates all 3 logo display modes with live FlutterLogo widgets,
// sizing behavior, background contrast, and practical usage patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterLogoStyle Deep Demo executing');

  // ── palette ──────────────────────────────────────────────────
  final Color flPrimary = Color(0xFF00838F); // cyan 800
  final Color flAccent = Color(0xFF26C6DA); // cyan 400
  final Color flSurface = Color(0xFFE0F7FA); // cyan 50
  final Color flDark = Color(0xFF004D40); // teal 900
  final Color flMark = Color(0xFF1565C0); // blue 800
  final Color flHorz = Color(0xFF6A1B9A); // purple 800
  final Color flStack = Color(0xFFE65100); // orange 900

  Widget flBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 11.0, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Widget flSectionHeader(String title, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [flPrimary, flAccent]),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(children: [
        Icon(icon, color: Colors.white, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }

  Widget flCard(Widget child) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: flPrimary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
              color: flPrimary.withValues(alpha: 0.08),
              blurRadius: 6.0,
              offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }

  Widget flInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Row(children: [
        SizedBox(
          width: 140.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: flDark)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 12.0,
                  color: valueColor ?? flPrimary,
                  fontWeight: FontWeight.w500)),
        ),
      ]),
    );
  }

  // ============================================================
  // SECTION 1: Title & Overview
  // ============================================================
  print('=== Section 1: Title & Overview ===');

  final flTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [flDark, flPrimary, flAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
            color: flDark.withValues(alpha: 0.35),
            blurRadius: 14.0,
            offset: Offset(0, 6)),
      ],
    ),
    child: Column(children: [
      FlutterLogo(size: 48.0),
      SizedBox(height: 10.0),
      Text('FlutterLogoStyle',
          style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 4.0),
      Text('painting library — enum',
          style: TextStyle(
              color: Colors.white70,
              fontSize: 13.0,
              fontStyle: FontStyle.italic)),
      SizedBox(height: 12.0),
      Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'Controls how the Flutter logo is rendered — as the mark '
          'alone (the "F" bird), the mark with "Flutter" text beside it '
          '(horizontal), or the mark with text below (stacked). Used '
          'by FlutterLogo widget and FlutterLogoDecoration.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 12.0, height: 1.4),
        ),
      ),
    ]),
  );

  // ============================================================
  // SECTION 2: Three Values — Live FlutterLogo Widgets
  // ============================================================
  print('=== Section 2: Three Values ===');

  for (final style in FlutterLogoStyle.values) {
    print('  FlutterLogoStyle.${style.name}: index=${style.index}');
  }

  Widget flStyleCard(FlutterLogoStyle style, String desc, Color accent) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: accent.withValues(alpha: 0.3)),
        ),
        child: Column(children: [
          Container(
            height: 70.0,
            width: double.infinity,
            alignment: Alignment.center,
            child: FlutterLogo(
              size: 50.0,
              style: style,
            ),
          ),
          SizedBox(height: 8.0),
          Text(style.name,
              style: TextStyle(
                  fontSize: 14.0, fontWeight: FontWeight.bold, color: accent)),
          SizedBox(height: 2.0),
          Text('index: ${style.index}',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          SizedBox(height: 6.0),
          Text(desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10.0, color: Colors.grey.shade700, height: 1.3)),
        ]),
      ),
    );
  }

  final flThreeValues = flCard(Column(children: [
    Text('The Three Styles',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 4.0),
    Text('Live FlutterLogo widgets with each style',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        flStyleCard(FlutterLogoStyle.markOnly,
            'Just the bird mark.\nSquare aspect ratio.\nDefault style.', flMark),
        SizedBox(width: 8.0),
        flStyleCard(FlutterLogoStyle.horizontal,
            'Mark + "Flutter" text\nside by side.\nWide aspect ratio.', flHorz),
        SizedBox(width: 8.0),
        flStyleCard(FlutterLogoStyle.stacked,
            'Mark above\n"Flutter" text.\nTall aspect ratio.', flStack),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 3: Size Gallery
  // ============================================================
  print('=== Section 3: Size Gallery ===');

  Widget flSizeItem(double size, FlutterLogoStyle style) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: flSurface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: flPrimary.withValues(alpha: 0.2)),
      ),
      child: Column(children: [
        FlutterLogo(size: size, style: style),
        SizedBox(height: 4.0),
        Text('${size.toInt()}px',
            style: TextStyle(
                fontSize: 9.0, fontWeight: FontWeight.bold, color: flDark)),
      ]),
    );
  }

  final flSizeGallery = flCard(Column(children: [
    Text('Size Gallery — markOnly',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 4.0),
    Text('FlutterLogo.size controls the rendered size',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [16.0, 24.0, 32.0, 48.0, 64.0, 80.0, 100.0]
          .map((s) => flSizeItem(s, FlutterLogoStyle.markOnly))
          .toList(),
    ),
    SizedBox(height: 16.0),
    Text('Size Gallery — horizontal',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 8.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [24.0, 40.0, 60.0, 80.0]
          .map((s) => flSizeItem(s, FlutterLogoStyle.horizontal))
          .toList(),
    ),
    SizedBox(height: 16.0),
    Text('Size Gallery — stacked',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 8.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [24.0, 40.0, 60.0, 80.0]
          .map((s) => flSizeItem(s, FlutterLogoStyle.stacked))
          .toList(),
    ),
  ]));

  // ============================================================
  // SECTION 4: Aspect Ratio Behavior
  // ============================================================
  print('=== Section 4: Aspect Ratio ===');

  final flAspectSection = flCard(Column(children: [
    Text('Aspect Ratio Differences',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 4.0),
    Text('Each style has its own natural aspect ratio within the size box',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                border: Border.all(color: flMark, width: 1.5),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: FlutterLogo(
                  size: 70.0, style: FlutterLogoStyle.markOnly),
            ),
            SizedBox(height: 4.0),
            Text('markOnly',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: flMark)),
            Text('~1:1 square',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          ]),
        ),
        Expanded(
          child: Column(children: [
            Container(
              width: 140.0,
              height: 60.0,
              decoration: BoxDecoration(
                border: Border.all(color: flHorz, width: 1.5),
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: FlutterLogo(
                  size: 50.0, style: FlutterLogoStyle.horizontal),
            ),
            SizedBox(height: 4.0),
            Text('horizontal',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: flHorz)),
            Text('~2.5:1 wide',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          ]),
        ),
        Expanded(
          child: Column(children: [
            Container(
              width: 80.0,
              height: 90.0,
              decoration: BoxDecoration(
                border: Border.all(color: flStack, width: 1.5),
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: FlutterLogo(
                  size: 70.0, style: FlutterLogoStyle.stacked),
            ),
            SizedBox(height: 4.0),
            Text('stacked',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: flStack)),
            Text('~1:1.3 tall',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          ]),
        ),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 5: Dark vs Light Backgrounds
  // ============================================================
  print('=== Section 5: Background Contrast ===');

  Widget flBgSample(Color bgColor, String label, FlutterLogoStyle style) {
    return Container(
      width: 100.0,
      height: 80.0,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4.0,
              offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterLogo(size: 40.0, style: style),
          SizedBox(height: 4.0),
          Text(label,
              style: TextStyle(
                  fontSize: 9.0,
                  color: bgColor.computeLuminance() > 0.5
                      ? Colors.black54
                      : Colors.white70)),
        ],
      ),
    );
  }

  final flBgSection = flCard(Column(children: [
    Text('Background Contrast',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 4.0),
    Text('FlutterLogo on various background colors and shades',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Text('markOnly:',
        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: flDark)),
    SizedBox(height: 4.0),
    Wrap(
      alignment: WrapAlignment.center,
      children: [
        flBgSample(Colors.white, 'White', FlutterLogoStyle.markOnly),
        flBgSample(Color(0xFFF5F5F5), 'Grey 100', FlutterLogoStyle.markOnly),
        flBgSample(Color(0xFF37474F), 'Blue-Grey', FlutterLogoStyle.markOnly),
        flBgSample(Color(0xFF212121), 'Dark', FlutterLogoStyle.markOnly),
        flBgSample(Color(0xFF0D47A1), 'Blue 900', FlutterLogoStyle.markOnly),
      ],
    ),
    SizedBox(height: 12.0),
    Text('horizontal:',
        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: flDark)),
    SizedBox(height: 4.0),
    Wrap(
      alignment: WrapAlignment.center,
      children: [
        flBgSample(Colors.white, 'White', FlutterLogoStyle.horizontal),
        flBgSample(Color(0xFFF5F5F5), 'Grey 100', FlutterLogoStyle.horizontal),
        flBgSample(Color(0xFF37474F), 'Blue-Grey', FlutterLogoStyle.horizontal),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 6: FlutterLogoDecoration Pattern
  // ============================================================
  print('=== Section 6: FlutterLogoDecoration ===');

  final flDecoSection = flCard(Column(children: [
    Text('FlutterLogoDecoration',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 4.0),
    Text('FlutterLogoDecoration uses FlutterLogoStyle to paint the logo '
        'as a Decoration (useful in Container.decoration, etc.)',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Container(
          height: 80.0,
          decoration: FlutterLogoDecoration(
            style: FlutterLogoStyle.markOnly,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 80.0,
          decoration: FlutterLogoDecoration(
            style: FlutterLogoStyle.horizontal,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 80.0,
          decoration: FlutterLogoDecoration(
            style: FlutterLogoStyle.stacked,
          ),
        ),
      ),
    ]),
    SizedBox(height: 8.0),
    Row(children: [
      Expanded(child: Center(child: Text('markOnly',
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: flMark)))),
      Expanded(child: Center(child: Text('horizontal',
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: flHorz)))),
      Expanded(child: Center(child: Text('stacked',
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: flStack)))),
    ]),
    SizedBox(height: 12.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: flSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
          'Container(\n'
          '  decoration: FlutterLogoDecoration(\n'
          '    style: FlutterLogoStyle.horizontal,\n'
          '    textColor: Colors.black87,\n'
          '  ),\n'
          ')',
          style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: flDark, height: 1.4)),
    ),
  ]));

  // ============================================================
  // SECTION 7: textColor Interaction
  // ============================================================
  print('=== Section 7: textColor ===');

  Widget flTextColorSample(Color textColor, String label) {
    return Container(
      margin: EdgeInsets.all(4.0),
      width: 100.0,
      child: Column(children: [
        Container(
          height: 60.0,
          width: 100.0,
          decoration: FlutterLogoDecoration(
            style: FlutterLogoStyle.horizontal,
            textColor: textColor,
          ),
        ),
        SizedBox(height: 4.0),
        Text(label,
            style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600, color: textColor)),
      ]),
    );
  }

  final flTextColorSection = flCard(Column(children: [
    Text('textColor Property',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 4.0),
    Text('FlutterLogoDecoration.textColor only affects horizontal and '
        'stacked styles (the "Flutter" text). markOnly has no text.',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      children: [
        flTextColorSample(Colors.black87, 'black87'),
        flTextColorSample(Color(0xFF1565C0), 'blue'),
        flTextColorSample(Color(0xFFE53935), 'red'),
        flTextColorSample(Color(0xFF43A047), 'green'),
        flTextColorSample(Color(0xFF6A1B9A), 'purple'),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 8: Comparison Table
  // ============================================================
  print('=== Section 8: Comparison Table ===');

  final flCompData = [
    {'feature': 'Shows mark', 'mark': 'Yes', 'horz': 'Yes', 'stack': 'Yes'},
    {'feature': 'Shows text', 'mark': 'No', 'horz': 'Yes', 'stack': 'Yes'},
    {'feature': 'textColor used', 'mark': 'No', 'horz': 'Yes', 'stack': 'Yes'},
    {'feature': 'Aspect ratio', 'mark': '~1:1', 'horz': '~2.5:1', 'stack': '~1:1.3'},
    {'feature': 'Best for', 'mark': 'Icons, small', 'horz': 'Headers', 'stack': 'Splash'},
    {'feature': 'Min good size', 'mark': '24px', 'horz': '40px', 'stack': '40px'},
  ];

  final flCompRows = <TableRow>[
    TableRow(
      decoration: BoxDecoration(color: flPrimary.withValues(alpha: 0.1)),
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text('Feature',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: flDark))),
        Padding(padding: EdgeInsets.all(8.0), child: Text('markOnly',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: flMark))),
        Padding(padding: EdgeInsets.all(8.0), child: Text('horizontal',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: flHorz))),
        Padding(padding: EdgeInsets.all(8.0), child: Text('stacked',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: flStack))),
      ],
    ),
  ];
  for (var i = 0; i < flCompData.length; i++) {
    final d = flCompData[i];
    flCompRows.add(TableRow(
      decoration: BoxDecoration(
        color: i.isEven ? Colors.white : flSurface.withValues(alpha: 0.5),
      ),
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text(d['feature']!,
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: flDark))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(d['mark']!,
            style: TextStyle(fontSize: 10.0, color: flMark))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(d['horz']!,
            style: TextStyle(fontSize: 10.0, color: flHorz))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(d['stack']!,
            style: TextStyle(fontSize: 10.0, color: flStack))),
      ],
    ));
  }

  final flCompTable = flCard(Column(children: [
    Text('Style Comparison',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 10.0),
    Table(
      border: TableBorder.all(color: flPrimary.withValues(alpha: 0.15)),
      columnWidths: {
        0: FixedColumnWidth(90.0),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
      },
      children: flCompRows,
    ),
  ]));

  // ============================================================
  // SECTION 9: Practical Use Cases
  // ============================================================
  print('=== Section 9: Use Cases ===');

  Widget flUseCaseCard(String name, FlutterLogoStyle style,
      IconData icon, Color color, String desc) {
    return Container(
      width: 130.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(height: 4.0),
        Text(name,
            style: TextStyle(
                fontSize: 11.0, fontWeight: FontWeight.bold, color: color)),
        SizedBox(height: 4.0),
        FlutterLogo(size: 30.0, style: style),
        SizedBox(height: 4.0),
        flBadge(style.name, color),
        SizedBox(height: 6.0),
        Text(desc,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9.0, color: Colors.grey.shade700, height: 1.3)),
      ]),
    );
  }

  final flUseCases = flCard(Column(children: [
    Text('Practical Use Cases',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        flUseCaseCard('App Bar', FlutterLogoStyle.markOnly,
            Icons.web_asset, Color(0xFF1565C0),
            'Small icon in\nleading position'),
        flUseCaseCard('Splash Screen', FlutterLogoStyle.stacked,
            Icons.phone_android, Color(0xFF6A1B9A),
            'Centered branding\non launch'),
        flUseCaseCard('About Dialog', FlutterLogoStyle.horizontal,
            Icons.info_outline, Color(0xFFE65100),
            'App info section\nwith name visible'),
        flUseCaseCard('Footer', FlutterLogoStyle.horizontal,
            Icons.view_stream, Color(0xFF00695C),
            '"Powered by Flutter"\nbranding row'),
        flUseCaseCard('Favicon', FlutterLogoStyle.markOnly,
            Icons.bookmark, Color(0xFFC62828),
            'Tiny icon where\ntext won\'t fit'),
        flUseCaseCard('Loading', FlutterLogoStyle.markOnly,
            Icons.hourglass_empty, Color(0xFF546E7A),
            'Placeholder while\ncontent loads'),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 10: Container Sizing Behavior
  // ============================================================
  print('=== Section 10: Container Sizing ===');

  final flContainerSection = flCard(Column(children: [
    Text('Container Sizing Behavior',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 4.0),
    Text('FlutterLogo respects its size parameter but also responds '
        'to parent constraints. The logo paints within the given area.',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(children: [
            Text('Constrained to 60×40',
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: flDark)),
            SizedBox(height: 4.0),
            Container(
              width: 60.0,
              height: 40.0,
              decoration: BoxDecoration(
                border: Border.all(color: flPrimary),
              ),
              child: FlutterLogo(
                  size: 100.0, style: FlutterLogoStyle.markOnly),
            ),
            Text('size: 100 but\ncontainer limits it',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
          ]),
        ),
        Expanded(
          child: Column(children: [
            Text('Unconstrained 100',
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: flDark)),
            SizedBox(height: 4.0),
            FlutterLogo(size: 100.0, style: FlutterLogoStyle.markOnly),
            Text('size: 100 renders\nat full size',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
          ]),
        ),
        Expanded(
          child: Column(children: [
            Text('In Expanded',
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: flDark)),
            SizedBox(height: 4.0),
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                border: Border.all(color: flPrimary),
              ),
              child: Center(
                child: FlutterLogo(
                    size: 60.0, style: FlutterLogoStyle.horizontal),
              ),
            ),
            Text('Respects best\naspect for style',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
          ]),
        ),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 11: Switch Pattern
  // ============================================================
  print('=== Section 11: Switch Pattern ===');

  final flSwitchSection = flCard(Column(children: [
    Text('Switch Pattern',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 4.0),
    Text('Conditional logic based on FlutterLogoStyle value',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: flSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
          'String describe(FlutterLogoStyle s) =>\n'
          '  switch (s) {\n'
          '    FlutterLogoStyle.markOnly  =>\n'
          '        "Logo mark only",\n'
          '    FlutterLogoStyle.horizontal =>\n'
          '        "Mark + text side-by-side",\n'
          '    FlutterLogoStyle.stacked   =>\n'
          '        "Mark above text",\n'
          '  };',
          style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: flDark, height: 1.4)),
    ),
    SizedBox(height: 12.0),
    ...FlutterLogoStyle.values.map((s) {
      final desc = switch (s) {
        FlutterLogoStyle.markOnly => 'Logo mark only — the "F" bird',
        FlutterLogoStyle.horizontal => 'Mark + "Flutter" text side by side',
        FlutterLogoStyle.stacked => 'Mark above "Flutter" text',
      };
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0),
        child: flInfoRow(s.name, desc),
      );
    }),
  ]));

  // ============================================================
  // SECTION 12: Cross-Style Comparison Grid
  // ============================================================
  print('=== Section 12: Comparison Grid ===');

  final flGridSection = flCard(Column(children: [
    Text('Cross-Style Comparison',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 4.0),
    Text('Same size (60px) across all 3 styles — see the proportional differences',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: FlutterLogoStyle.values.map((style) {
        final accent = style == FlutterLogoStyle.markOnly
            ? flMark
            : style == FlutterLogoStyle.horizontal
                ? flHorz
                : flStack;
        return Container(
          width: 110.0,
          height: 100.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: accent.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(size: 60.0, style: style),
              SizedBox(height: 4.0),
              Text(style.name,
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: accent)),
            ],
          ),
        );
      }).toList(),
    ),
  ]));

  // ============================================================
  // SECTION 13: Equality & Properties
  // ============================================================
  print('=== Section 13: Equality ===');

  final flEq1 = FlutterLogoStyle.markOnly == FlutterLogoStyle.markOnly;
  final flEq2 = FlutterLogoStyle.markOnly == FlutterLogoStyle.horizontal;
  print('  markOnly == markOnly: $flEq1');
  print('  markOnly == horizontal: $flEq2');

  final flEqualitySection = flCard(Column(children: [
    Text('Enum Equality & Properties',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 10.0),
    flInfoRow('markOnly == markOnly', '$flEq1',
        valueColor: Colors.teal.shade700),
    flInfoRow('markOnly == horizontal', '$flEq2',
        valueColor: Colors.red.shade700),
    Divider(color: flPrimary.withValues(alpha: 0.15)),
    flInfoRow('values.length', '${FlutterLogoStyle.values.length}'),
    ...FlutterLogoStyle.values.map((s) =>
        flInfoRow('${s.name}.index', '${s.index}')),
    flInfoRow('first', FlutterLogoStyle.values.first.name),
    flInfoRow('last', FlutterLogoStyle.values.last.name),
  ]));

  // ============================================================
  // SECTION 14: Common Patterns
  // ============================================================
  print('=== Section 14: Common Patterns ===');

  final flPatternsSection = flCard(Column(children: [
    Text('Common Code Patterns',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 12.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: flMark.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: flMark.withValues(alpha: 0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('App Bar Leading:',
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: flMark)),
        SizedBox(height: 4.0),
        Text('AppBar(\n'
            '  leading: Padding(\n'
            '    padding: EdgeInsets.all(8),\n'
            '    child: FlutterLogo(\n'
            '      style: FlutterLogoStyle.markOnly,\n'
            '    ),\n'
            '  ),\n'
            ')',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: flDark, height: 1.3)),
      ]),
    ),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: flHorz.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: flHorz.withValues(alpha: 0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('About Dialog:',
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: flHorz)),
        SizedBox(height: 4.0),
        Text('showAboutDialog(\n'
            '  applicationIcon: FlutterLogo(\n'
            '    size: 64,\n'
            '    style: FlutterLogoStyle.horizontal,\n'
            '  ),\n'
            ')',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: flDark, height: 1.3)),
      ]),
    ),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: flStack.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: flStack.withValues(alpha: 0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Splash Screen:',
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: flStack)),
        SizedBox(height: 4.0),
        Text('Center(\n'
            '  child: FlutterLogo(\n'
            '    size: 100,\n'
            '    style: FlutterLogoStyle.stacked,\n'
            '  ),\n'
            ')',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: flDark, height: 1.3)),
      ]),
    ),
  ]));

  // ============================================================
  // SECTION 15: When to Use Each
  // ============================================================
  print('=== Section 15: When to Use ===');

  final flWhenSection = flCard(Column(children: [
    Text('When to Use Each Style',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: flDark)),
    SizedBox(height: 12.0),
    ...[
      {'style': 'markOnly', 'color': flMark, 'items': [
        'Small spaces where text won\'t fit (< 32px)',
        'App bar leading icons or tab bar icons',
        'Favicons and notification badges',
        'When the audience knows the Flutter brand',
      ]},
      {'style': 'horizontal', 'color': flHorz, 'items': [
        'Header bars and navigation',
        'About dialogs and info pages',
        'Footer branding ("Built with Flutter")',
        'Wide layouts where vertical space is limited',
      ]},
      {'style': 'stacked', 'color': flStack, 'items': [
        'Splash screens and loading pages',
        'Centered branding moments',
        'Marketing materials and landing pages',
        'When vertical space is available',
      ]},
    ].map((entry) {
      final color = entry['color'] as Color;
      final items = entry['items'] as List<String>;
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${entry['style']}:',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: color)),
            SizedBox(height: 4.0),
            ...items.map((item) => Text('• $item',
                style: TextStyle(fontSize: 11.0, color: flDark, height: 1.5))),
          ],
        ),
      );
    }),
  ]));

  // ============================================================
  // SECTION 16: Summary Dashboard
  // ============================================================
  print('=== Section 16: Summary ===');

  final flSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [flDark, flPrimary]),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(children: [
      Text('FlutterLogoStyle — Summary',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 12.0),
      Row(children: [
        Expanded(child: Column(children: [
          Text('3', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('styles', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('2', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('show text', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('2', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('consumers', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
      ]),
      SizedBox(height: 12.0),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'FlutterLogoStyle configures the visual layout of the Flutter '
          'logo. markOnly for compact icon use, horizontal for header '
          'branding, stacked for splash displays. Used by both the '
          'FlutterLogo widget and FlutterLogoDecoration painter.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 11.0, height: 1.4),
        ),
      ),
    ]),
  );

  print('FlutterLogoStyle Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        flTitleSection,
        SizedBox(height: 16.0),
        // 2 Three Values
        flSectionHeader('The Three Styles', Icons.style),
        flThreeValues,
        // 3 Size Gallery
        flSectionHeader('Size Gallery', Icons.photo_size_select_large),
        flSizeGallery,
        // 4 Aspect Ratio
        flSectionHeader('Aspect Ratio', Icons.aspect_ratio),
        flAspectSection,
        // 5 Backgrounds
        flSectionHeader('Background Contrast', Icons.contrast),
        flBgSection,
        // 6 Decoration
        flSectionHeader('FlutterLogoDecoration', Icons.format_paint),
        flDecoSection,
        // 7 textColor
        flSectionHeader('textColor Property', Icons.format_color_text),
        flTextColorSection,
        // 8 Comparison
        flSectionHeader('Style Comparison', Icons.table_chart),
        flCompTable,
        // 9 Use Cases
        flSectionHeader('Practical Use Cases', Icons.auto_awesome),
        flUseCases,
        // 10 Container
        flSectionHeader('Container Sizing', Icons.crop_free),
        flContainerSection,
        // 11 Switch
        flSectionHeader('Switch Pattern', Icons.alt_route),
        flSwitchSection,
        // 12 Grid
        flSectionHeader('Cross-Style Grid', Icons.grid_view),
        flGridSection,
        // 13 Equality
        flSectionHeader('Equality & Properties', Icons.check_circle_outline),
        flEqualitySection,
        // 14 Patterns
        flSectionHeader('Common Patterns', Icons.code),
        flPatternsSection,
        // 15 When to Use
        flSectionHeader('When to Use Each', Icons.lightbulb_outline),
        flWhenSection,
        // 16 Summary
        SizedBox(height: 8.0),
        flSummarySection,
      ],
    ),
  );
}
