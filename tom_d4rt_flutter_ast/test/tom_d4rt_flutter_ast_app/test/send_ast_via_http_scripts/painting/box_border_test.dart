// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BoxBorder abstract class from painting.
// Deep Demo: Visual demonstration of BoxBorder, its subclasses (Border,
// BorderDirectional), the static lerp helper, BorderStyle, strokeAlign and
// real-world UI mocks built on top of borders.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxBorder Deep Demo executing');

  // Palette - slate / amber / teal.
  const slate900 = Color(0xFF0F172A);
  const slate700 = Color(0xFF334155);
  const slate500 = Color(0xFF64748B);
  const slate300 = Color(0xFFCBD5E1);
  const slate100 = Color(0xFFF1F5F9);
  const amber500 = Color(0xFFF59E0B);
  const amber700 = Color(0xFFB45309);
  const amber200 = Color(0xFFFDE68A);
  const teal500 = Color(0xFF14B8A6);
  const teal700 = Color(0xFF0F766E);
  const teal200 = Color(0xFF99F6E4);
  const rose500 = Color(0xFFE11D48);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate900, slate700, teal700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: amber500, width: 3.0),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: amber500.withValues(alpha: 0.25),
          blurRadius: 28.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.crop_square, color: amber500, size: 44.0),
            SizedBox(width: 12.0),
            Text(
              'BoxBorder',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Abstract base of Border and BorderDirectional',
          style: TextStyle(fontSize: 15.0, color: slate100),
        ),
        SizedBox(height: 4.0),
        Text(
          'package:flutter/painting.dart',
          style: TextStyle(
            fontSize: 12.0,
            color: amber200,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
  print('Title banner created');

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomyBox = Container(
    width: 240.0,
    height: 160.0,
    decoration: BoxDecoration(
      color: slate100,
      border: Border(
        top: BorderSide(color: amber500, width: 6.0),
        right: BorderSide(color: teal500, width: 6.0),
        bottom: BorderSide(color: rose500, width: 6.0),
        left: BorderSide(color: slate700, width: 6.0),
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      'sample box',
      style: TextStyle(
        color: slate700,
        fontFamily: 'monospace',
        fontSize: 13.0,
      ),
    ),
  );

  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate100, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: slate300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.08),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Anatomy of a Border',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: slate900,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                _legend('top', amber500),
                _legend('right', teal500),
                _legend('bottom', rose500),
                _legend('left', slate700),
              ],
            ),
            SizedBox(width: 24.0),
            Column(
              children: [
                Text('top',
                    style: TextStyle(
                        color: amber700, fontSize: 11.0, fontWeight: FontWeight.bold)),
                anatomyBox,
                Text('bottom',
                    style: TextStyle(
                        color: rose500, fontSize: 11.0, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Border(top: ..., right: ..., bottom: ..., left: ...)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: slate700,
          ),
        ),
      ],
    ),
  );
  print('Anatomy diagram created');

  // ============================================================
  // SECTION 3: Six Border.all width cards
  // ============================================================
  print('=== Section 3: Border.all widths ===');

  final widthValues = [0.5, 1.0, 2.0, 4.0, 8.0, 16.0];
  final widthCards = <Widget>[];
  for (final w in widthValues) {
    final b = Border.all(color: teal700, width: w);
    print('Border.all(width: $w) isUniform=${b.isUniform} top=${b.top.width}');
    widthCards.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: slate900.withValues(alpha: 0.06),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 80.0,
              height: 60.0,
              decoration: BoxDecoration(color: teal200, border: b),
            ),
            SizedBox(height: 8.0),
            Text('width: $w',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: teal700,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
  print('Created ${widthCards.length} width cards');

  // ============================================================
  // SECTION 4: BorderStyle and strokeAlign cards
  // ============================================================
  print('=== Section 4: BorderStyle and strokeAlign ===');

  final solidBorder = Border.all(color: amber700, width: 4.0);
  final noneBorder = Border.all(
      color: amber700, width: 4.0, style: BorderStyle.none);
  final insideBorder = Border.all(
      color: teal700, width: 6.0, strokeAlign: BorderSide.strokeAlignInside);
  final centerBorder = Border.all(
      color: teal700, width: 6.0, strokeAlign: BorderSide.strokeAlignCenter);
  final outsideBorder = Border.all(
      color: teal700, width: 6.0, strokeAlign: BorderSide.strokeAlignOutside);

  print('solid uniform=${solidBorder.isUniform}');
  print('none uniform=${noneBorder.isUniform} style=${noneBorder.top.style}');
  print('inside strokeAlign=${insideBorder.top.strokeAlign}');
  print('center strokeAlign=${centerBorder.top.strokeAlign}');
  print('outside strokeAlign=${outsideBorder.top.strokeAlign}');

  final styleCards = <Widget>[
    _styleCard('solid', solidBorder, amber200, 'BorderStyle.solid'),
    _styleCard('none', noneBorder, amber200, 'BorderStyle.none'),
    _styleCard('inside', insideBorder, teal200, 'strokeAlignInside (-1.0)'),
    _styleCard('center', centerBorder, teal200, 'strokeAlignCenter (0.0)'),
    _styleCard('outside', outsideBorder, teal200, 'strokeAlignOutside (1.0)'),
  ];

  // ============================================================
  // SECTION 5: Six Border color cards
  // ============================================================
  print('=== Section 5: Color cards ===');

  final colorBorders = <Map<String, Object>>[
    {'label': 'slate', 'border': Border.all(color: slate700, width: 3.0)},
    {'label': 'amber', 'border': Border.all(color: amber500, width: 3.0)},
    {'label': 'teal', 'border': Border.all(color: teal500, width: 3.0)},
    {
      'label': 'tri-mix',
      'border': Border(
        top: BorderSide(color: amber500, width: 3.0),
        bottom: BorderSide(color: amber500, width: 3.0),
        left: BorderSide(color: teal500, width: 3.0),
        right: BorderSide(color: teal500, width: 3.0),
      ),
    },
    {
      'label': 'gradient mock',
      'border': Border(
        top: BorderSide(color: amber500, width: 3.0),
        right: BorderSide(color: amber700, width: 3.0),
        bottom: BorderSide(color: rose500, width: 3.0),
        left: BorderSide(color: teal500, width: 3.0),
      ),
    },
    {
      'label': 'mono pair',
      'border': Border(
        top: BorderSide(color: slate900, width: 3.0),
        bottom: BorderSide(color: slate900, width: 3.0),
        left: BorderSide(color: slate300, width: 3.0),
        right: BorderSide(color: slate300, width: 3.0),
      ),
    },
  ];

  final colorCards = <Widget>[];
  for (final entry in colorBorders) {
    final label = entry['label'] as String;
    final b = entry['border'] as Border;
    print('color card "$label" isUniform=${b.isUniform}');
    colorCards.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, slate100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: slate900.withValues(alpha: 0.07),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 90.0,
              height: 64.0,
              decoration: BoxDecoration(color: Colors.white, border: b),
            ),
            SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: slate700,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              b.isUniform ? 'isUniform: true' : 'isUniform: false',
              style: TextStyle(
                fontSize: 10.0,
                color: b.isUniform ? teal700 : rose500,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${colorCards.length} color cards');

  // ============================================================
  // SECTION 6: Border.fromBorderSide and Border.symmetric
  // ============================================================
  print('=== Section 6: fromBorderSide and symmetric ===');

  final fromSide = Border.fromBorderSide(
    BorderSide(color: amber700, width: 4.0),
  );
  final symHoriz = Border.symmetric(
    horizontal: BorderSide(color: teal700, width: 5.0),
  );
  final symVert = Border.symmetric(
    vertical: BorderSide(color: rose500, width: 5.0),
  );
  final symBoth = Border.symmetric(
    horizontal: BorderSide(color: amber500, width: 4.0),
    vertical: BorderSide(color: teal500, width: 4.0),
  );

  print('fromBorderSide uniform=${fromSide.isUniform}');
  print('symmetric horizontal uniform=${symHoriz.isUniform}');
  print('symmetric vertical uniform=${symVert.isUniform}');
  print('symmetric both uniform=${symBoth.isUniform}');

  final factoryCards = <Widget>[
    _factoryCard('Border.fromBorderSide(side)', fromSide, slate100),
    _factoryCard('Border.symmetric(horizontal: side)', symHoriz, slate100),
    _factoryCard('Border.symmetric(vertical: side)', symVert, slate100),
    _factoryCard('Border.symmetric(h: a, v: b)', symBoth, slate100),
  ];

  // ============================================================
  // SECTION 7: BorderDirectional LTR vs RTL
  // ============================================================
  print('=== Section 7: BorderDirectional LTR vs RTL ===');

  final dirBorder = BorderDirectional(
    top: BorderSide(color: slate900, width: 2.0),
    bottom: BorderSide(color: slate900, width: 2.0),
    start: BorderSide(color: amber500, width: 6.0),
    end: BorderSide(color: teal500, width: 6.0),
  );
  print('BorderDirectional uniform=${dirBorder.isUniform}');
  print('  start=${dirBorder.start.color} end=${dirBorder.end.color}');

  final ltrBox = Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      width: 160.0,
      height: 90.0,
      decoration: BoxDecoration(color: slate100, border: dirBorder),
      alignment: Alignment.center,
      child: Text('LTR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: slate900,
            fontSize: 16.0,
          )),
    ),
  );
  final rtlBox = Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      width: 160.0,
      height: 90.0,
      decoration: BoxDecoration(color: slate100, border: dirBorder),
      alignment: Alignment.center,
      child: Text('RTL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: slate900,
            fontSize: 16.0,
          )),
    ),
  );

  final directionalShowcase = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [amber200.withValues(alpha: 0.4), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: amber500, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: amber500.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'BorderDirectional - shared instance, different Directionality',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: slate900,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Text('LTR',
                  style: TextStyle(fontSize: 11.0, color: slate500)),
              SizedBox(height: 4.0),
              ltrBox,
              SizedBox(height: 4.0),
              Text('start = left',
                  style: TextStyle(
                      fontSize: 10.0, color: amber700, fontFamily: 'monospace')),
            ]),
            Column(children: [
              Text('RTL',
                  style: TextStyle(fontSize: 11.0, color: slate500)),
              SizedBox(height: 4.0),
              rtlBox,
              SizedBox(height: 4.0),
              Text('start = right',
                  style: TextStyle(
                      fontSize: 10.0, color: amber700, fontFamily: 'monospace')),
            ]),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: BoxBorder.lerp showcase
  // ============================================================
  print('=== Section 8: BoxBorder.lerp ===');

  final lerpA = Border.all(color: amber500, width: 2.0);
  final lerpB = Border.all(color: teal700, width: 10.0);
  final lerpStops = [0.0, 0.25, 0.5, 0.75, 1.0];
  final lerpCards = <Widget>[];
  for (final t in lerpStops) {
    final blended = BoxBorder.lerp(lerpA, lerpB, t);
    final width = blended is Border ? blended.top.width : -1.0;
    print('BoxBorder.lerp(t=$t) -> width=${width.toStringAsFixed(2)}');
    lerpCards.add(
      Container(
        width: 110.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: slate300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: slate900.withValues(alpha: 0.05),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 70.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: slate100,
                border: blended,
              ),
            ),
            SizedBox(height: 8.0),
            Text('t = $t',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: slate900,
                )),
            Text('w=${width.toStringAsFixed(2)}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: slate500,
                )),
          ],
        ),
      ),
    );
  }

  final lerpShowcase = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [amber200.withValues(alpha: 0.3), teal200.withValues(alpha: 0.4)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: slate300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: teal500.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'BoxBorder.lerp(a, b, t) - amber 2px -> teal 10px',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: slate900,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: lerpCards,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Mixed-side widths card
  // ============================================================
  print('=== Section 9: Mixed-side widths ===');

  final mixedColorBorder = Border(
    top: BorderSide(color: amber500, width: 4.0),
    right: BorderSide(color: amber500, width: 4.0),
    bottom: BorderSide(color: amber500, width: 4.0),
    left: BorderSide(color: amber500, width: 4.0),
  );
  final mixedWidthBorder = Border(
    top: BorderSide(color: slate900, width: 8.0),
    right: BorderSide(color: slate900, width: 2.0),
    bottom: BorderSide(color: slate900, width: 8.0),
    left: BorderSide(color: slate900, width: 2.0),
  );
  print('mixedWidthBorder uniform=${mixedWidthBorder.isUniform}');

  final mixedSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: slate300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.05),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Mixed widths per side',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: slate900,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Container(
                width: 100.0,
                height: 70.0,
                decoration:
                    BoxDecoration(color: amber200, border: mixedColorBorder),
              ),
              SizedBox(height: 6.0),
              Text('uniform 4px',
                  style: TextStyle(
                      fontSize: 10.0,
                      color: slate500,
                      fontFamily: 'monospace')),
            ]),
            Column(children: [
              Container(
                width: 100.0,
                height: 70.0,
                decoration:
                    BoxDecoration(color: slate100, border: mixedWidthBorder),
              ),
              SizedBox(height: 6.0),
              Text('top/bot 8 - sides 2',
                  style: TextStyle(
                      fontSize: 10.0,
                      color: slate500,
                      fontFamily: 'monospace')),
            ]),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: rose500.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: rose500.withValues(alpha: 0.4), width: 1.0),
          ),
          child: Text(
            'Caveat: BorderRadius and shape:circle require a uniform border. '
            'Different per-side widths only paint correctly with rectangular '
            'shapes and no radius.',
            style: TextStyle(fontSize: 11.0, color: slate900),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Real-world mocks
  // ============================================================
  print('=== Section 10: Real-world mocks ===');

  // Input field idle vs focused
  final inputIdle = Container(
    width: 220.0,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: slate300, width: 1.0),
    ),
    child: Row(children: [
      Icon(Icons.search, color: slate500, size: 18.0),
      SizedBox(width: 8.0),
      Text('search',
          style: TextStyle(color: slate500, fontSize: 13.0)),
    ]),
  );
  final inputFocused = Container(
    width: 220.0,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: teal500, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: teal500.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Row(children: [
      Icon(Icons.search, color: teal700, size: 18.0),
      SizedBox(width: 8.0),
      Text('search',
          style: TextStyle(color: slate900, fontSize: 13.0)),
    ]),
  );

  // Card frame
  final cardFrame = Container(
    width: 240.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: slate300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.08),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: amber500,
              border: Border.all(color: amber700, width: 1.0),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.0),
          Text('Profile card',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: slate900,
                fontSize: 13.0,
              )),
        ]),
        SizedBox(height: 10.0),
        Text(
          'Border.all + boxShadow gives a soft elevated frame.',
          style: TextStyle(fontSize: 11.0, color: slate500),
        ),
      ],
    ),
  );

  // Divider strip - top + bottom only
  final dividerStrip = Container(
    width: 240.0,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
    decoration: BoxDecoration(
      color: slate100,
      border: Border(
        top: BorderSide(color: slate300, width: 1.0),
        bottom: BorderSide(color: slate300, width: 1.0),
      ),
    ),
    child: Text(
      'list section',
      style: TextStyle(
        color: slate700,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // Badge ring - circular border
  final badgeRing = Container(
    width: 64.0,
    height: 64.0,
    decoration: BoxDecoration(
      color: amber200,
      border: Border.all(color: amber700, width: 3.0),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: amber500.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text('99+',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: amber700,
            fontSize: 14.0)),
  );

  // Tab indicator - bottom border only
  final tabIndicator = Container(
    width: 240.0,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Row(
      children: [
        _tab('Inbox', true, teal500, slate500),
        _tab('Outbox', false, teal500, slate500),
        _tab('Drafts', false, teal500, slate500),
      ],
    ),
  );

  final mocksSection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, slate100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: slate300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Real-world UI mocks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: slate900,
          ),
        ),
        SizedBox(height: 14.0),
        Text('Input field - idle / focused',
            style: TextStyle(
                fontSize: 12.0, color: slate500, fontStyle: FontStyle.italic)),
        SizedBox(height: 6.0),
        Wrap(spacing: 12.0, runSpacing: 12.0, children: [
          inputIdle,
          inputFocused,
        ]),
        SizedBox(height: 16.0),
        Text('Card frame',
            style: TextStyle(
                fontSize: 12.0, color: slate500, fontStyle: FontStyle.italic)),
        SizedBox(height: 6.0),
        cardFrame,
        SizedBox(height: 16.0),
        Text('Divider strip (top + bottom only)',
            style: TextStyle(
                fontSize: 12.0, color: slate500, fontStyle: FontStyle.italic)),
        SizedBox(height: 6.0),
        dividerStrip,
        SizedBox(height: 16.0),
        Text('Badge ring (circular)',
            style: TextStyle(
                fontSize: 12.0, color: slate500, fontStyle: FontStyle.italic)),
        SizedBox(height: 6.0),
        badgeRing,
        SizedBox(height: 16.0),
        Text('Tab indicator (bottom side only)',
            style: TextStyle(
                fontSize: 12.0, color: slate500, fontStyle: FontStyle.italic)),
        SizedBox(height: 6.0),
        tabIndicator,
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Footgun cards
  // ============================================================
  print('=== Section 11: Footguns ===');

  final footguns = <Map<String, String>>[
    {
      'title': 'Mixed colours need uniform width',
      'body': 'Border with different colours per side requires equal widths. '
          'Mixing colours and widths can produce visual seams at the corners.',
    },
    {
      'title': 'BoxBorder.lerp restrictions',
      'body': 'BoxBorder.lerp only blends Border <-> Border or BorderDirectional '
          '<-> BorderDirectional. Crossing families snaps from a to b at t=0.5.',
    },
    {
      'title': 'isUniform is strict',
      'body': 'isUniform requires identical color, width, style and strokeAlign '
          'across all sides. Any difference flips it to false.',
    },
    {
      'title': 'BorderDirectional needs Directionality',
      'body': 'BorderDirectional resolves start/end via the inherited '
          'Directionality. Without one in the tree, painting will assert.',
    },
    {
      'title': 'strokeAlign affects layout',
      'body': 'strokeAlignOutside paints outside the box, ignoring layout space. '
          'Use it for emphasis but expect overflow over neighbouring widgets.',
    },
  ];

  final footgunCards = <Widget>[];
  for (final f in footguns) {
    print('Footgun: ${f['title']}');
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: rose500.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(color: rose500, width: 4.0),
            top: BorderSide(color: rose500.withValues(alpha: 0.3), width: 1.0),
            right: BorderSide(color: rose500.withValues(alpha: 0.3), width: 1.0),
            bottom: BorderSide(color: rose500.withValues(alpha: 0.3), width: 1.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.warning_amber_rounded, color: rose500, size: 18.0),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  f['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: slate900,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ]),
            SizedBox(height: 6.0),
            Text(
              f['body'] as String,
              style: TextStyle(
                fontSize: 12.0,
                color: slate700,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 12: Recap card
  // ============================================================
  print('=== Section 12: Recap ===');

  final allBorderCount = widthCards.length +
      colorCards.length +
      factoryCards.length +
      lerpCards.length +
      footgunCards.length;
  print('Total visible border cards: $allBorderCount');

  final recap = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate900, slate700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amber500, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.check_circle, color: amber500, size: 22.0),
          SizedBox(width: 8.0),
          Text('Recap',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ]),
        SizedBox(height: 10.0),
        _recapLine('BoxBorder is abstract; concrete: Border, BorderDirectional'),
        _recapLine('Properties: top, bottom, isUniform, dimensions'),
        _recapLine('Border.all / fromBorderSide / symmetric for ergonomics'),
        _recapLine('BoxBorder.lerp blends within the same family'),
        _recapLine('strokeAlign: inside (-1), center (0), outside (+1)'),
        _recapLine('BorderRadius and shape:circle require a uniform border'),
      ],
    ),
  );

  print('BoxBorder Deep Demo completed successfully');

  // ============================================================
  // Layout
  // ============================================================
  return Scaffold(
    backgroundColor: slate100,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          _sectionHeader('1. Anatomy of a BoxBorder', slate900),
          anatomy,
          SizedBox(height: 16.0),
          _sectionHeader('2. Border.all width sweep', slate900),
          Wrap(alignment: WrapAlignment.center, children: widthCards),
          SizedBox(height: 24.0),
          _sectionHeader('3. BorderStyle and strokeAlign', slate900),
          Wrap(alignment: WrapAlignment.center, children: styleCards),
          SizedBox(height: 24.0),
          _sectionHeader('4. Border colours', slate900),
          Wrap(alignment: WrapAlignment.center, children: colorCards),
          SizedBox(height: 24.0),
          _sectionHeader('5. Border factories', slate900),
          Wrap(alignment: WrapAlignment.center, children: factoryCards),
          SizedBox(height: 24.0),
          _sectionHeader('6. BorderDirectional - LTR vs RTL', slate900),
          directionalShowcase,
          SizedBox(height: 16.0),
          _sectionHeader('7. BoxBorder.lerp progression', slate900),
          lerpShowcase,
          SizedBox(height: 16.0),
          _sectionHeader('8. Mixed-side widths', slate900),
          mixedSection,
          SizedBox(height: 16.0),
          _sectionHeader('9. Real-world UI mocks', slate900),
          mocksSection,
          SizedBox(height: 16.0),
          _sectionHeader('10. Footguns', slate900),
          Column(children: footgunCards),
          SizedBox(height: 16.0),
          _sectionHeader('11. Recap', slate900),
          recap,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// Helper: legend swatch with label.
Widget _legend(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Color(0xFF0F172A), width: 1.0),
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 8.0),
        Text(label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFF0F172A),
            )),
      ],
    ),
  );
}

// Helper: card showing a Border style/strokeAlign variant.
Widget _styleCard(String label, Border border, Color fill, String descr) {
  return Container(
    width: 140.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCBD5E1), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF0F172A).withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 80.0,
          height: 60.0,
          decoration: BoxDecoration(color: fill, border: border),
        ),
        SizedBox(height: 8.0),
        Text(label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
              fontSize: 12.0,
            )),
        SizedBox(height: 2.0),
        Text(descr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.5,
              color: Color(0xFF64748B),
            )),
      ],
    ),
  );
}

// Helper: factory border card.
Widget _factoryCard(String label, Border border, Color fill) {
  return Container(
    width: 200.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Color(0xFFF1F5F9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF0F172A).withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 120.0,
          height: 70.0,
          decoration: BoxDecoration(color: fill, border: border),
        ),
        SizedBox(height: 8.0),
        Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF334155),
            )),
      ],
    ),
  );
}

// Helper: tab visualization with bottom border indicator.
Widget _tab(String label, bool active, Color accent, Color muted) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: active ? accent : muted.withValues(alpha: 0.3),
            width: active ? 3.0 : 1.0,
          ),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
          color: active ? accent : muted,
          fontSize: 13.0,
        ),
      ),
    ),
  );
}

// Helper: section header.
Widget _sectionHeader(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

// Helper: recap line.
Widget _recapLine(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: Color(0xFFF59E0B),
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13.0, color: Colors.white, height: 1.4),
          ),
        ),
      ],
    ),
  );
}
