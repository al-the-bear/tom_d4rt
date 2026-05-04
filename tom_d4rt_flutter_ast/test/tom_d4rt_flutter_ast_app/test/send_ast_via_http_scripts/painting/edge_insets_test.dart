// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of EdgeInsets (painting/edge_insets)
// Covers: all constructors, operators, copyWith/inflate/deflate/clamp,
// lerp ramp, flipped/vertical/horizontal/collapsedSize, anatomy diagram,
// real-world card/list/AppBar/dialog patterns, EdgeInsetsDirectional comparison,
// and footguns (RTL, clamp, lerp).
import 'package:flutter/material.dart';

class _Palette {
  static const Color bg = Color(0xFFF6F4FB);
  static const Color ink = Color(0xFF1A1B30);
  static const Color subInk = Color(0xFF555770);
  static const Color accent = Color(0xFF6750A4);
  static const Color accent2 = Color(0xFF03A9F4);
  static const Color warn = Color(0xFFF57C00);
  static const Color danger = Color(0xFFD32F2F);
  static const Color ok = Color(0xFF2E7D32);
  static const Color paper = Color(0xFFFFFFFF);
  static const Color stripe = Color(0xFFEDE7F6);
  static const Color cardA = Color(0xFFFFE0B2);
  static const Color cardB = Color(0xFFB3E5FC);
  static const Color cardC = Color(0xFFC8E6C9);
  static const Color cardD = Color(0xFFF8BBD0);
}

dynamic build(BuildContext context) {
  print('EdgeInsets Deep Demo executing');

  // ============================================================
  // SECTION 1: HEADER & INTRO
  // ============================================================
  print('=== Section 1: Header ===');

  final header = Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _Palette.accent,
          _Palette.accent2,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: _Palette.accent.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EdgeInsets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Offsets from each of the four sides of a rectangle.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 15.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Used by padding, margin, contentPadding, and any inset.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: CONSTRUCTORS — all() / symmetric() / only() / fromLTRB() / zero
  // ============================================================
  print('=== Section 2: Constructors ===');

  final eAll = EdgeInsets.all(20.0);
  final eSym = EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0);
  final eOnly = EdgeInsets.only(left: 4.0, top: 8.0, right: 24.0, bottom: 32.0);
  final eLtrb = EdgeInsets.fromLTRB(8.0, 16.0, 24.0, 4.0);
  final eZero = EdgeInsets.zero;

  print('all=$eAll');
  print('symmetric=$eSym');
  print('only=$eOnly');
  print('fromLTRB=$eLtrb');
  print('zero=$eZero');

  Widget ctorTile(String title, EdgeInsets insets, Color tone, String code) {
    return Container(
      width: 260.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: tone.withValues(alpha: 0.25),
            blurRadius: 10.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tone, tone.withValues(alpha: 0.6)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          // Visual padding effect
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.18),
              border: Border.all(color: tone, width: 1.5),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Padding(
              padding: insets,
              child: Container(
                height: 36.0,
                decoration: BoxDecoration(
                  color: tone,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Text(
                    'inner',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 6.0),
            child: Text(
              code,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: _Palette.subInk,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 12.0),
            child: Text(
              'L=${insets.left}  T=${insets.top}  R=${insets.right}  B=${insets.bottom}',
              style: TextStyle(fontSize: 11.0, color: _Palette.ink),
            ),
          ),
        ],
      ),
    );
  }

  final constructorRow = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Row(
      children: [
        ctorTile('EdgeInsets.all(20)', eAll, _Palette.accent,
            'EdgeInsets.all(20.0)'),
        ctorTile('symmetric(h:28, v:10)', eSym, _Palette.accent2,
            'EdgeInsets.symmetric(horizontal: 28, vertical: 10)'),
        ctorTile('only(l:4 t:8 r:24 b:32)', eOnly, _Palette.warn,
            'EdgeInsets.only(left: 4, top: 8, right: 24, bottom: 32)'),
        ctorTile('fromLTRB(8,16,24,4)', eLtrb, _Palette.ok,
            'EdgeInsets.fromLTRB(8, 16, 24, 4)'),
        ctorTile('zero', eZero, _Palette.subInk, 'EdgeInsets.zero'),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: ANATOMY DIAGRAM
  // ============================================================
  print('=== Section 3: Anatomy ===');

  final anatomy = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: _Palette.paper,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _Palette.accent.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of EdgeInsets',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Text(
          'Each side has its own value. The total inflation is left+right horizontally and top+bottom vertically.',
          style: TextStyle(fontSize: 13.0, color: _Palette.subInk),
        ),
        SizedBox(height: 16.0),
        Center(
          child: Container(
            width: 320.0,
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _Palette.stripe,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(color: _Palette.accent, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(36.0, 24.0, 48.0, 28.0),
              child: Container(
                decoration: BoxDecoration(
                  color: _Palette.accent.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                      color: _Palette.accent.withValues(alpha: 0.4),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'child',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 6.0,
          children: [
            _label('left = 36', _Palette.accent2),
            _label('top = 24', _Palette.warn),
            _label('right = 48', _Palette.danger),
            _label('bottom = 28', _Palette.ok),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: OPERATORS  +  -  *  /  ~/  %
  // ============================================================
  print('=== Section 4: Operators ===');

  final opA = EdgeInsets.all(10.0);
  final opB = EdgeInsets.only(left: 5.0, top: 0.0, right: 15.0, bottom: 5.0);
  final opPlus = opA + opB;
  final opMinus = opA - EdgeInsets.all(3.0);
  final opMul = opA * 2.0;
  final opDiv = EdgeInsets.all(20.0) / 4.0;
  final opTrunc = EdgeInsets.all(25.0) ~/ 4.0;
  final opMod = EdgeInsets.all(13.0) % 5.0;

  print('opA + opB = $opPlus');
  print('opA - all(3) = $opMinus');
  print('opA * 2 = $opMul');
  print('all(20) / 4 = $opDiv');
  print('all(25) ~/ 4 = $opTrunc');
  print('all(13) % 5 = $opMod');

  Widget opRow(String label, EdgeInsets insets, Color tone) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 130.0,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: _Palette.ink,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Padding(
                padding: insets,
                child: Container(
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: tone,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          SizedBox(
            width: 110.0,
            child: Text(
              'L${insets.left} T${insets.top}\nR${insets.right} B${insets.bottom}',
              style: TextStyle(fontSize: 10.0, color: _Palette.subInk),
            ),
          ),
        ],
      ),
    );
  }

  final operatorsBlock = Container(
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          _Palette.stripe,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.07),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 4.0),
          child: Text(
            'Operators',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
          child: Text(
            'EdgeInsets supports per-side arithmetic: + − × ÷ ~/ %',
            style: TextStyle(fontSize: 12.0, color: _Palette.subInk),
          ),
        ),
        opRow('all(10)', opA, _Palette.accent),
        opRow('opA + opB', opPlus, _Palette.accent2),
        opRow('opA - all(3)', opMinus, _Palette.warn),
        opRow('opA * 2', opMul, _Palette.danger),
        opRow('all(20) / 4', opDiv, _Palette.ok),
        opRow('all(25) ~/ 4', opTrunc, Color(0xFF7B1FA2)),
        opRow('all(13) % 5', opMod, Color(0xFF00838F)),
        SizedBox(height: 10.0),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: copyWith / inflate (via +) / deflate (via -) / clamp
  // ============================================================
  print('=== Section 5: copyWith/inflate/deflate/clamp ===');

  final base = EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);
  final copied = base.copyWith(left: 30.0, bottom: 4.0);
  // "inflate" semantics: grow each side by adding insets.
  final inflated = base + EdgeInsets.all(8.0);
  // "deflate" semantics: shrink each side by subtracting insets.
  final deflated = EdgeInsets.all(20.0) - EdgeInsets.all(6.0);
  // EdgeInsets.clamp returns EdgeInsetsGeometry; resolve back to EdgeInsets.
  final clampedGeom = EdgeInsets.fromLTRB(2.0, 50.0, 100.0, 0.0)
      .clamp(EdgeInsets.all(5.0), EdgeInsets.all(40.0));
  final clamped = clampedGeom.resolve(TextDirection.ltr);

  print('base=$base  copied=$copied');
  print('inflated=$inflated  deflated=$deflated');
  print('clamped=$clamped');

  Widget transformCard(String name, String desc, EdgeInsets insets, Color tone) {
    return Container(
      width: 230.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tone.withValues(alpha: 0.12),
            tone.withValues(alpha: 0.28),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tone, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: tone.withValues(alpha: 0.3),
            blurRadius: 8.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: tone,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            desc,
            style: TextStyle(fontSize: 11.0, color: _Palette.subInk),
          ),
          SizedBox(height: 8.0),
          Container(
            color: Colors.white,
            child: Padding(
              padding: insets,
              child: Container(
                height: 30.0,
                decoration: BoxDecoration(
                  color: tone,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'L=${insets.left} T=${insets.top}\nR=${insets.right} B=${insets.bottom}',
            style: TextStyle(fontSize: 10.0, color: _Palette.ink),
          ),
        ],
      ),
    );
  }

  final transformsRow = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        transformCard('base = all(10)', 'starting point', base, _Palette.accent),
        transformCard('copyWith(left:30, bottom:4)',
            'replace selected sides only', copied, _Palette.accent2),
        transformCard('base + all(8) // inflate', 'grow each side per inset',
            inflated, _Palette.warn),
        transformCard('all(20) - all(6) // deflate',
            'shrink each side per inset', deflated, _Palette.ok),
        transformCard('clamp(all(5), all(40))', 'min/max clamp per side',
            clamped, _Palette.danger),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: EdgeInsets.lerp(a, b, t) — animation ramp
  // ============================================================
  print('=== Section 6: lerp ramp ===');

  final lerpA = EdgeInsets.zero;
  final lerpB = EdgeInsets.all(40.0);
  final lerpStops = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final lerpCells = <Widget>[];
  for (int i = 0; i < lerpStops.length; i++) {
    final t = lerpStops[i];
    final lerped = EdgeInsets.lerp(lerpA, lerpB, t)!;
    print('lerp t=$t -> $lerped');
    lerpCells.add(
      Container(
        width: 110.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: _Palette.paper,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: _Palette.accent.withValues(alpha: 0.18),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              't = $t',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: _Palette.accent,
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              width: 90.0,
              height: 90.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _Palette.accent2.withValues(alpha: 0.25),
                    _Palette.accent.withValues(alpha: 0.25),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Padding(
                padding: lerped,
                child: Container(
                  decoration: BoxDecoration(
                    color: _Palette.accent,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'pad = ${lerped.left.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 10.0, color: _Palette.subInk),
            ),
          ],
        ),
      ),
    );
  }

  final lerpRamp = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _Palette.stripe,
          Colors.white,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: _Palette.accent.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'EdgeInsets.lerp(zero, all(40), t)',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 10.0),
          child: Text(
            'Linear interpolation per side. Use this in implicit animations.',
            style: TextStyle(fontSize: 12.0, color: _Palette.subInk),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: lerpCells),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: flipped / vertical / horizontal / collapsedSize
  // ============================================================
  print('=== Section 7: derived properties ===');

  final source = EdgeInsets.fromLTRB(8.0, 16.0, 24.0, 4.0);
  final flipped = source.flipped;
  final hSum = source.horizontal;
  final vSum = source.vertical;
  final collapsed = source.collapsedSize;

  print('source=$source');
  print('flipped=$flipped (left<->right, top<->bottom)');
  print('horizontal=$hSum  vertical=$vSum');
  print('collapsedSize=$collapsed');

  final derivedBlock = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _Palette.paper,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _Palette.accent2.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: _Palette.accent2.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Derived properties',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'source = EdgeInsets.fromLTRB(8, 16, 24, 4)',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: _Palette.subInk,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'source',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    color: _Palette.accent.withValues(alpha: 0.2),
                    child: Padding(
                      padding: source,
                      child: Container(height: 30.0, color: _Palette.accent),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'flipped',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    color: _Palette.warn.withValues(alpha: 0.2),
                    child: Padding(
                      padding: flipped,
                      child: Container(height: 30.0, color: _Palette.warn),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _kv('horizontal (left+right)', '$hSum'),
        _kv('vertical (top+bottom)', '$vSum'),
        _kv('collapsedSize', '$collapsed'),
        SizedBox(height: 8.0),
        Text(
          'collapsedSize is a Size where width = horizontal sum and height = vertical sum.',
          style: TextStyle(fontSize: 11.0, color: _Palette.subInk),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: REAL-WORLD CARD UI
  // ============================================================
  print('=== Section 8: card UI ===');

  final cardDemo = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _Palette.paper,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_Palette.cardA, _Palette.cardB],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.style, color: _Palette.ink, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                'Card UI — symmetric(horizontal: 16, vertical: 12)',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: _Palette.ink,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Article title',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6.0),
              Text(
                'Standard cards in Material use horizontal: 16 and vertical: 12 for content padding. The header area uses the same insets to keep optical alignment consistent.',
                style: TextStyle(fontSize: 13.0, color: _Palette.subInk),
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: _Palette.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        color: _Palette.accent,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: _Palette.accent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: LIST TILE / APP BAR / DIALOG patterns
  // ============================================================
  print('=== Section 9: patterns ===');

  final listTileMock = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: _Palette.paper,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    // ListTile.contentPadding default: EdgeInsets.symmetric(horizontal: 16)
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_Palette.cardC, _Palette.cardD],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ListTile.contentPadding',
                  style:
                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'EdgeInsets.symmetric(horizontal: 16) by default',
                  style: TextStyle(fontSize: 11.0, color: _Palette.subInk),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: _Palette.subInk),
        ],
      ),
    ),
  );

  final appBarMock = Container(
    margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
    height: 56.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_Palette.accent, _Palette.accent2],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: _Palette.accent.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Padding(
      // AppBar uses EdgeInsetsDirectional.only(start: NavigationToolbar.kMiddleSpacing)
      padding: EdgeInsets.only(left: 16.0, right: 8.0),
      child: Row(
        children: [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              'AppBar — leading inset',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 16.0),
          Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
    ),
  );

  final dialogMock = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _Palette.paper,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AlertDialog title padding: fromLTRB(24,24,24,0)
        Padding(
          padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
          child: Text(
            'Discard changes?',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        // contentPadding: fromLTRB(24,20,24,24)
        Padding(
          padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
          child: Text(
            'AlertDialog.contentPadding defaults to EdgeInsets.fromLTRB(24, 20, 24, 24). The asymmetric top/bottom is intentional: it accounts for the title baseline above.',
            style: TextStyle(fontSize: 13.0, color: _Palette.subInk),
          ),
        ),
        // actionsPadding: only(left: 8, right: 8, bottom: 8)
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: _Palette.subInk,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(
                  'DISCARD',
                  style: TextStyle(
                    color: _Palette.danger,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: EdgeInsets vs EdgeInsetsDirectional
  // ============================================================
  print('=== Section 10: directional comparison ===');

  final ltrChild = Container(
    height: 30.0,
    decoration: BoxDecoration(
      color: _Palette.accent,
      borderRadius: BorderRadius.circular(3.0),
    ),
  );

  final directionalBlock = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          _Palette.cardB.withValues(alpha: 0.4),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _Palette.accent2),
      boxShadow: [
        BoxShadow(
          color: _Palette.accent2.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EdgeInsets vs EdgeInsetsDirectional',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'EdgeInsets is absolute (left/right). EdgeInsetsDirectional is reading-direction aware (start/end) and resolves against TextDirection.',
          style: TextStyle(fontSize: 13.0, color: _Palette.subInk),
        ),
        SizedBox(height: 14.0),
        // Same insets, different semantics
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EdgeInsets.only(left: 32)',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    color: _Palette.accent.withValues(alpha: 0.15),
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: ltrChild,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'always pads on the left side',
                    style: TextStyle(fontSize: 10.0, color: _Palette.subInk),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EdgeInsetsDirectional.only(start: 32)',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      color: _Palette.accent2.withValues(alpha: 0.18),
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 32.0),
                        child: Container(
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: _Palette.accent2,
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'pads on left in LTR, right in RTL',
                    style: TextStyle(fontSize: 10.0, color: _Palette.subInk),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _Palette.warn.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _Palette.warn.withValues(alpha: 0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: _Palette.warn, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Rule of thumb: prefer EdgeInsetsDirectional in app UI to support RTL '
                  'languages. Use EdgeInsets only when the layout is intentionally fixed '
                  '(e.g. icons in a toolbar where left/right is geometric, not semantic).',
                  style: TextStyle(fontSize: 12.0, color: _Palette.ink),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: FOOTGUNS
  // ============================================================
  print('=== Section 11: footguns ===');

  // Demonstrate clamp clamping a "negative-ish" wide value into bounds
  final clampDemoSource = EdgeInsets.fromLTRB(0.0, 100.0, 5.0, 200.0);
  final clampDemoOut = clampDemoSource
      .clamp(EdgeInsets.all(10.0), EdgeInsets.all(50.0))
      .resolve(TextDirection.ltr);
  print('clamp source=$clampDemoSource out=$clampDemoOut');

  Widget footgun(IconData icon, String title, String body, Color tone) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: tone, size: 20.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tone,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  body,
                  style: TextStyle(fontSize: 12.0, color: _Palette.ink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final footgunsBlock = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _Palette.paper,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _Palette.danger.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: _Palette.danger.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Footguns',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        footgun(
          Icons.swap_horiz,
          'Directional confusion in RTL',
          'Using EdgeInsets.only(left:) in widgets that flip in RTL produces broken '
              'layouts. Use EdgeInsetsDirectional.only(start:) for RTL-correct UI.',
          _Palette.danger,
        ),
        footgun(
          Icons.compress,
          'clamp uses min/max per side',
          'EdgeInsets.clamp(min, max) clamps each side independently against the '
              'matching side of min and max. It does NOT take a numeric range.',
          _Palette.warn,
        ),
        footgun(
          Icons.timeline,
          'lerp is linear per side',
          'EdgeInsets.lerp interpolates each side independently with linear t. '
              'For non-linear motion, drive t through a Curve first (Curves.easeOut.transform(t)).',
          _Palette.accent,
        ),
        footgun(
          Icons.warning_amber,
          'Negative insets are allowed',
          'EdgeInsets accepts negative values. They are valid math but produce '
              'no visible inset; deflate(...) past zero will yield negatives.',
          _Palette.accent2,
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _Palette.stripe,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'clamp demo: source=$clampDemoSource\n -> $clampDemoOut',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: _Palette.ink,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: CHEAT SHEET / FOOTER
  // ============================================================
  print('=== Section 12: cheat sheet ===');

  final cheatSheet = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _Palette.accent.withValues(alpha: 0.92),
          _Palette.accent2.withValues(alpha: 0.92),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _Palette.accent.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cheat sheet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.0),
        _cheat('all(v)', 'every side = v'),
        _cheat('symmetric(h, v)', 'left=right=h, top=bottom=v'),
        _cheat('only(...)', 'pick the sides you need'),
        _cheat('fromLTRB(l,t,r,b)', 'positional, all four sides'),
        _cheat('zero', 'shared singleton — no allocation'),
        _cheat('+ - * / ~/ %', 'per-side arithmetic'),
        _cheat('copyWith / + / - / clamp',
            'derive new insets (grow/shrink/copy/clamp)'),
        _cheat('lerp(a,b,t)', 'linear per side, returns nullable'),
        _cheat('flipped', 'swap left<->right and top<->bottom'),
        _cheat('horizontal / vertical', 'sums per axis'),
        _cheat('collapsedSize', 'Size(horizontal, vertical)'),
        SizedBox(height: 8.0),
        Text(
          'Prefer EdgeInsetsDirectional in user-facing UI for RTL safety.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.95),
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  print('EdgeInsets Deep Demo build tree assembled');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  return Scaffold(
    backgroundColor: _Palette.bg,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
            child: Text(
              '1. Constructors',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          constructorRow,
          anatomy,
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Text(
              '2. Operators',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          operatorsBlock,
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Text(
              '3. copyWith / inflate / deflate / clamp',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          transformsRow,
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Text(
              '4. EdgeInsets.lerp',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          lerpRamp,
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Text(
              '5. flipped / horizontal / vertical / collapsedSize',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          derivedBlock,
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Text(
              '6. Real-world use cases',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          cardDemo,
          listTileMock,
          appBarMock,
          dialogMock,
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Text(
              '7. EdgeInsets vs EdgeInsetsDirectional',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          directionalBlock,
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Text(
              '8. Footguns',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          footgunsBlock,
          cheatSheet,
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
            child: Text(
              'EdgeInsets Deep Demo — end',
              style: TextStyle(
                fontSize: 12.0,
                color: _Palette.subInk,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _label(String text, Color tone) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: tone.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: tone.withValues(alpha: 0.5)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: tone,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _kv(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        SizedBox(
          width: 200.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 12.0,
              color: _Palette.subInk,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: _Palette.ink,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _cheat(String name, String desc) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180.0,
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}
