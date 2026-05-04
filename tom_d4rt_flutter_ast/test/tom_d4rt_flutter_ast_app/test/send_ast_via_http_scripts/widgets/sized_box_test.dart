// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SizedBox from widgets
// Deep Demo: Visual demonstration of SizedBox constructors and use cases.
// SizedBox is the simplest layout primitive in Flutter — it forces a child
// (or empty space) to a specific width/height. This demo walks through its
// five constructors, common use cases, and known footguns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SizedBox Deep Demo executing');

  // ============================================================
  // Theme palette: purple/indigo to signal "layout/structure"
  // ============================================================
  final purple50 = Colors.purple.shade50;
  final purple100 = Colors.purple.shade100;
  final purple200 = Colors.purple.shade200;
  final purple300 = Colors.purple.shade300;
  final purple400 = Colors.purple.shade400;
  final purple600 = Colors.purple.shade600;
  final purple700 = Colors.purple.shade700;
  final purple800 = Colors.purple.shade800;
  final purple900 = Colors.purple.shade900;
  final indigo50 = Colors.indigo.shade50;
  final indigo100 = Colors.indigo.shade100;
  final indigo200 = Colors.indigo.shade200;
  final indigo400 = Colors.indigo.shade400;
  final indigo600 = Colors.indigo.shade600;
  final indigo700 = Colors.indigo.shade700;
  final indigo900 = Colors.indigo.shade900;

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [purple700, indigo700, purple900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: purple900.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: indigo900.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                Icons.crop_din,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SizedBox',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'The simplest layout primitive in Flutter',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.85),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Text(
            'SizedBox({width, height, child})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [purple50, indigo50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: purple200, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: purple200.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: purple600,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION 2',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Anatomy of a SizedBox',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: purple900,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'A SizedBox forces its child (or empty space) to a specific size. '
          'Unlike Container it has no decoration, no padding, no margin — just '
          'tight constraints applied to its sole child.',
          style: TextStyle(
            fontSize: 13.0,
            color: indigo900,
            height: 1.5,
          ),
        ),
        SizedBox(height: 20.0),
        // Anatomy visual: width arrow on top, height arrow on left,
        // SizedBox child in the middle
        Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: purple300, width: 1.0),
            ),
            child: Column(
              children: [
                // Width label arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 14.0, color: purple700),
                    Container(
                      width: 200.0,
                      height: 2.0,
                      color: purple700,
                    ),
                    Icon(Icons.arrow_forward, size: 14.0, color: purple700),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  'width: 200.0',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: purple700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Height label arrow
                    Column(
                      children: [
                        Icon(Icons.arrow_drop_up, size: 14.0, color: indigo700),
                        Container(
                          width: 2.0,
                          height: 80.0,
                          color: indigo700,
                        ),
                        Icon(Icons.arrow_drop_down, size: 14.0, color: indigo700),
                      ],
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'height:\n100.0',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: indigo700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 12.0),
                    // The actual SizedBox visualization
                    SizedBox(
                      width: 200.0,
                      height: 100.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [purple300, indigo400],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: purple400.withValues(alpha: 0.5),
                              blurRadius: 8.0,
                              offset: Offset(0.0, 4.0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'SizedBox\n(child)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: purple50,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'SizedBox vs Container:\n'
                    '• SizedBox: only sizes — null width/height defers to child\n'
                    '• Container: sizes + decoration + padding + margin + alignment',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: purple900,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 3: Constructors catalogue
  // ============================================================
  print('=== Section 3: Constructors Catalogue ===');

  // Default constructor
  final ctorDefault = SizedBox(
    width: 80.0,
    height: 50.0,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [purple300, purple600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
    ),
  );

  // Shrink constructor (renders 0x0 — visualised inside a placeholder)
  final ctorShrink = Container(
    width: 80.0,
    height: 50.0,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: Colors.grey.shade400,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    child: Center(
      child: SizedBox.shrink(
        child: Container(
          decoration: BoxDecoration(color: purple600),
        ),
      ),
    ),
  );

  // Expand constructor (fills parent)
  final ctorExpand = Container(
    width: 80.0,
    height: 50.0,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [indigo400, purple600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    ),
  );

  // FromSize constructor
  final ctorFromSize = SizedBox.fromSize(
    size: Size(80.0, 50.0),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [purple400, indigo600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
    ),
  );

  // Square constructor
  final ctorSquare = SizedBox.square(
    dimension: 50.0,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [indigo400, indigo700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
    ),
  );

  Widget buildCtorCard(String name, String code, String desc, Widget visual) {
    return Container(
      width: 240.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, purple50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: purple200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: purple200.withValues(alpha: 0.45),
            blurRadius: 10.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: purple600,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.greenAccent,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            desc,
            style: TextStyle(fontSize: 11.0, color: indigo900, height: 1.4),
          ),
          SizedBox(height: 10.0),
          Center(child: visual),
        ],
      ),
    );
  }

  final ctorRow1 = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildCtorCard(
        'DEFAULT',
        'SizedBox(\n  width: 80,\n  height: 50,\n  child: ...,\n)',
        'Set both width and height explicitly. The most common use.',
        ctorDefault,
      ),
      buildCtorCard(
        '.shrink()',
        'SizedBox.shrink(\n  child: ...,\n)',
        'Forces a 0x0 size. Useful as a no-op placeholder.',
        ctorShrink,
      ),
      buildCtorCard(
        '.expand()',
        'SizedBox.expand(\n  child: ...,\n)',
        'Forces infinity x infinity — fills parent constraints.',
        ctorExpand,
      ),
    ],
  );

  final ctorRow2 = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildCtorCard(
        '.fromSize()',
        'SizedBox.fromSize(\n  size: Size(80, 50),\n  child: ...,\n)',
        'Build from a Size object. Convenient when sizes come from layout.',
        ctorFromSize,
      ),
      buildCtorCard(
        '.square()',
        'SizedBox.square(\n  dimension: 50,\n  child: ...,\n)',
        'Width = height = dimension. Perfect for icons and avatars.',
        ctorSquare,
      ),
    ],
  );

  final ctorCatalogue = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [indigo50, purple50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigo200, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: indigo600,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION 3',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Five Constructors',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: indigo900,
          ),
        ),
        SizedBox(height: 16.0),
        ctorRow1,
        SizedBox(height: 8.0),
        ctorRow2,
      ],
    ),
  );
  print('Created constructors catalogue');

  // ============================================================
  // SECTION 4: Width-only sizing
  // ============================================================
  print('=== Section 4: Width-only sizing ===');

  final widthSamples = <Widget>[];
  final widthValues = [50.0, 100.0, 200.0, 400.0];
  for (final w in widthValues) {
    widthSamples.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            SizedBox(
              width: 60.0,
              child: Text(
                '${w.toInt()}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: purple700,
                ),
              ),
            ),
            SizedBox(
              width: w,
              height: 26.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [purple300, purple600],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                  boxShadow: [
                    BoxShadow(
                      color: purple400.withValues(alpha: 0.4),
                      blurRadius: 4.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final widthSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, purple50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: purple200, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: purple200.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: purple600,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION 4',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Width-only sizing',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: purple900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Each row is a SizedBox with a different width but identical height. '
          'When you only set width, the height collapses to whatever the child '
          'demands (or zero if no child).',
          style: TextStyle(fontSize: 12.0, color: indigo900, height: 1.5),
        ),
        SizedBox(height: 16.0),
        Column(children: widthSamples),
      ],
    ),
  );
  print('Created width samples (${widthSamples.length})');

  // ============================================================
  // SECTION 5: Height-only sizing
  // ============================================================
  print('=== Section 5: Height-only sizing ===');

  final heightSamples = <Widget>[];
  final heightValues = [30.0, 60.0, 120.0, 240.0];
  for (final h in heightValues) {
    heightSamples.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(
          children: [
            SizedBox(
              width: 40.0,
              height: h,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [indigo400, indigo700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                  boxShadow: [
                    BoxShadow(
                      color: indigo400.withValues(alpha: 0.5),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              '${h.toInt()}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: indigo700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final heightSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, indigo50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigo200, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: indigo600,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION 5',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Height-only sizing',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: indigo900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Four bars side-by-side, each a SizedBox with a different height. '
          'Setting only height lets width collapse to the child demand.',
          style: TextStyle(fontSize: 12.0, color: purple900, height: 1.5),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: heightSamples,
          ),
        ),
      ],
    ),
  );
  print('Created height samples (${heightSamples.length})');

  // ============================================================
  // SECTION 6: SizedBox as spacer
  // ============================================================
  print('=== Section 6: SizedBox as spacer ===');

  Widget bullet(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.7), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  final withoutSpacers = Container(
    width: 160.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'No spacers',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        bullet('Item A', purple600),
        bullet('Item B', purple600),
        bullet('Item C', purple600),
        bullet('Item D', purple600),
      ],
    ),
  );

  final withSpacers = Container(
    width: 160.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.green.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'With SizedBox',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade700,
          ),
        ),
        SizedBox(height: 12.0),
        bullet('Item A', indigo600),
        SizedBox(height: 8.0),
        bullet('Item B', indigo600),
        SizedBox(height: 16.0),
        bullet('Item C', indigo600),
        SizedBox(height: 32.0),
        bullet('Item D', indigo600),
      ],
    ),
  );

  // Row spacer demo
  final rowSpacers = Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        bullet('A', purple600),
        SizedBox(width: 8.0),
        bullet('B', purple600),
        SizedBox(width: 16.0),
        bullet('C', purple600),
        SizedBox(width: 32.0),
        bullet('D', purple600),
      ],
    ),
  );

  final spacerSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [purple50, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: purple200, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: purple200.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: purple700,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION 6',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Spacer in Column / Row',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: purple900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'The most common idiomatic use: SizedBox(height: 8/16/32) inside a '
          'Column for vertical rhythm, SizedBox(width: ...) inside a Row.',
          style: TextStyle(fontSize: 12.0, color: indigo900, height: 1.5),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [withoutSpacers, withSpacers],
        ),
        SizedBox(height: 16.0),
        Text(
          'Row with SizedBox(width: 8/16/32)',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: purple700,
          ),
        ),
        SizedBox(height: 8.0),
        rowSpacers,
      ],
    ),
  );
  print('Created spacer section');

  // ============================================================
  // SECTION 7: .shrink() use case
  // ============================================================
  print('=== Section 7: .shrink() use case ===');

  // "Before": child is rendered (expanded button)
  final shrinkBefore = Container(
    width: 220.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: purple200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'showBadge = true',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: purple700,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade400, Colors.red.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            '3 NEW MESSAGES',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Inbox content here…',
          style: TextStyle(fontSize: 11.0, color: indigo900),
        ),
      ],
    ),
  );

  // "After": SizedBox.shrink collapses the badge to 0x0
  final shrinkAfter = Container(
    width: 220.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: indigo200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'showBadge = false',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: indigo700,
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox.shrink(),
        Text(
          'Inbox content here…',
          style: TextStyle(fontSize: 11.0, color: indigo900),
        ),
      ],
    ),
  );

  final shrinkSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, indigo50, purple50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigo200, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: indigo700,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION 7',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'SizedBox.shrink() — collapse to zero',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: indigo900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A common conditional-render idiom. Returning SizedBox.shrink() instead '
          'of null avoids nullable-widget plumbing and renders nothing.',
          style: TextStyle(fontSize: 12.0, color: purple900, height: 1.5),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'showBadge ? Badge() : SizedBox.shrink()',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.greenAccent,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [shrinkBefore, shrinkAfter],
        ),
      ],
    ),
  );
  print('Created shrink section');

  // ============================================================
  // SECTION 8: .expand() use case
  // ============================================================
  print('=== Section 8: .expand() use case ===');

  final expandDemo = Container(
    width: 280.0,
    height: 140.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade500, width: 1.0),
    ),
    child: SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [purple400, indigo600, purple700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: purple700.withValues(alpha: 0.5),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'SizedBox.expand()\nfills its parent',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    ),
  );

  final expandSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [purple100, indigo100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: purple300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: purple400.withValues(alpha: 0.35),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: purple800,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION 8',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'SizedBox.expand() — fill parent',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: purple900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Expands to width=infinity, height=infinity. The parent must impose '
          'bounded constraints, otherwise it asserts. Useful inside Stack, '
          'AspectRatio, fixed-size containers.',
          style: TextStyle(fontSize: 12.0, color: indigo900, height: 1.5),
        ),
        SizedBox(height: 16.0),
        Center(child: expandDemo),
      ],
    ),
  );
  print('Created expand section');

  // ============================================================
  // SECTION 9: .square(double) use case
  // ============================================================
  print('=== Section 9: .square use case ===');

  Widget squareAvatar(double dim, Color color, IconData icon) {
    return SizedBox.square(
      dimension: dim,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.45),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: dim * 0.5),
      ),
    );
  }

  final squareDemo = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      squareAvatar(28.0, purple400, Icons.person),
      squareAvatar(40.0, purple600, Icons.person),
      squareAvatar(56.0, indigo600, Icons.person),
      squareAvatar(72.0, indigo700, Icons.person),
      squareAvatar(96.0, purple700, Icons.person),
    ],
  );

  // Spacing units made of squares
  final squareSpacingUnits = Row(
    children: [
      Container(
        width: 4.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: purple300,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      SizedBox.square(dimension: 4.0),
      Container(
        width: 8.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: purple400,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      SizedBox.square(dimension: 8.0),
      Container(
        width: 16.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: purple600,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      SizedBox.square(dimension: 16.0),
      Container(
        width: 32.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: purple700,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    ],
  );

  final squareSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, purple50, indigo50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: purple200, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: purple600,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION 9',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'SizedBox.square(dimension: …)',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: purple900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Single dimension applied to width & height — perfect for avatars, '
          'icon containers and design-token spacing units.',
          style: TextStyle(fontSize: 12.0, color: indigo900, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Text(
          'Avatars at 28 / 40 / 56 / 72 / 96 px',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: purple700,
          ),
        ),
        SizedBox(height: 8.0),
        squareDemo,
        SizedBox(height: 16.0),
        Text(
          'Spacing units (SizedBox.square 4 / 8 / 16) between bars',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: purple700,
          ),
        ),
        SizedBox(height: 8.0),
        squareSpacingUnits,
      ],
    ),
  );
  print('Created square section');

  // ============================================================
  // SECTION 10: Decision matrix — SizedBox vs Container vs ConstrainedBox
  // ============================================================
  print('=== Section 10: Decision matrix ===');

  Widget matrixHeader(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget matrixCell(String text, double width, Color color) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 10.0, color: color, height: 1.4),
      ),
    );
  }

  final matrixRows = <Widget>[];
  final matrixData = [
    {
      'feature': 'Set exact size',
      'sized': 'YES',
      'container': 'yes',
      'constrained': 'no (only ranges)',
    },
    {
      'feature': 'Decoration',
      'sized': 'no',
      'container': 'YES',
      'constrained': 'no',
    },
    {
      'feature': 'Padding / margin',
      'sized': 'no',
      'container': 'YES',
      'constrained': 'no',
    },
    {
      'feature': 'Min/max range',
      'sized': 'no',
      'container': 'partial',
      'constrained': 'YES',
    },
    {
      'feature': 'No-child spacer',
      'sized': 'YES (idiomatic)',
      'container': 'allowed',
      'constrained': 'no',
    },
    {
      'feature': 'Force child to fill',
      'sized': 'YES (.expand)',
      'container': 'no',
      'constrained': 'no',
    },
  ];

  for (final row in matrixData) {
    matrixRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: purple100, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 130.0,
              child: Text(
                row['feature'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: indigo900,
                ),
              ),
            ),
            matrixCell(row['sized'] as String, 100.0, purple700),
            matrixCell(row['container'] as String, 100.0, indigo700),
            matrixCell(row['constrained'] as String, 110.0, purple800),
          ],
        ),
      ),
    );
  }

  final decisionMatrix = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, purple50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: purple300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: purple300.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: purple700,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION 10',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'SizedBox vs Container vs ConstrainedBox',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: purple900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [purple700, indigo700],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              matrixHeader('Feature', 130.0),
              matrixHeader('SizedBox', 100.0),
              matrixHeader('Container', 100.0),
              matrixHeader('ConstrainedBox', 110.0),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Column(children: matrixRows),
      ],
    ),
  );
  print('Created decision matrix (${matrixRows.length} rows)');

  // ============================================================
  // SECTION 11: Footguns
  // ============================================================
  print('=== Section 11: Footguns ===');

  Widget footgun(String title, String desc, IconData icon) {
    return Container(
      width: 240.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade50, Colors.orange.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.red.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade200.withValues(alpha: 0.5),
            blurRadius: 8.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Icon(icon, color: Colors.white, size: 18.0),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            desc,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.red.shade900,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  final footgunRow = Wrap(
    alignment: WrapAlignment.center,
    children: [
      footgun(
        'Unbounded constraints',
        'A SizedBox(width: double.infinity) inside an unbounded parent (e.g. '
            'a Column inside another Column) asserts. Wrap with Expanded or '
            'use a fixed width.',
        Icons.warning_amber,
      ),
      footgun(
        '.expand() in free axis',
        'Calling SizedBox.expand inside a Row/Column without Expanded explodes '
            'the constraints. Use SizedBox.expand only inside a bounded box.',
        Icons.error_outline,
      ),
      footgun(
        'No child renders nothing',
        'SizedBox(width: 100, height: 100) with no child paints nothing — it '
            'reserves space only. Add a Container/coloured child if you want '
            'a visible block.',
        Icons.visibility_off,
      ),
      footgun(
        'Spacer in scroll views',
        'Inside a SingleChildScrollView a SizedBox with infinite size in the '
            'scroll axis loops forever. Use a finite size.',
        Icons.swap_vert,
      ),
    ],
  );

  final footgunSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.red.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'SECTION 11',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Footguns',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Common ways to misuse SizedBox and how to spot them.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.red.shade900,
            height: 1.5,
          ),
        ),
        SizedBox(height: 12.0),
        footgunRow,
      ],
    ),
  );
  print('Created footgun section');

  // ============================================================
  // SECTION 12: Recap card
  // ============================================================
  print('=== Section 12: Recap ===');

  Widget recapBullet(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.0, color: Colors.white),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final recapCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [purple800, indigo700, purple900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: purple900.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: indigo900.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: Colors.amberAccent,
              size: 28.0,
            ),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        recapBullet(
          Icons.check_circle_outline,
          'SizedBox is the lightest sizing primitive — no decoration, just '
              'tight constraints applied to its child or empty space.',
        ),
        recapBullet(
          Icons.check_circle_outline,
          'Five constructors: default, .shrink(), .expand(), .fromSize(), '
              '.square().',
        ),
        recapBullet(
          Icons.check_circle_outline,
          'Idiomatic for vertical/horizontal rhythm in Column / Row '
              '(SizedBox(height: 8) / SizedBox(width: 8)).',
        ),
        recapBullet(
          Icons.check_circle_outline,
          'Prefer SizedBox.shrink() to nullable widgets in conditional render.',
        ),
        recapBullet(
          Icons.check_circle_outline,
          'Use SizedBox.expand() only inside bounded parents (Stack, '
              'AspectRatio, fixed-size Container).',
        ),
        recapBullet(
          Icons.check_circle_outline,
          'Reach for Container when you also need decoration / padding / '
              'margin; ConstrainedBox when you need ranges instead of exact '
              'sizes.',
        ),
      ],
    ),
  );
  print('Created recap card');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  print('=== Final Assembly ===');

  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          anatomyDiagram,
          ctorCatalogue,
          widthSection,
          heightSection,
          spacerSection,
          shrinkSection,
          expandSection,
          squareSection,
          decisionMatrix,
          footgunSection,
          recapCard,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}
