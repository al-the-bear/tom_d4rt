// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of RenderErrorBox from
// package:flutter/rendering.dart. RenderErrorBox is the render object that
// paints the infamous magenta-fill / white-text error screen when a widget's
// build, layout, or paint phase throws. This script does NOT trigger real
// framework errors; it is purely descriptive and visual.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderErrorBox Deep Demo executing');

  // ============================================================
  // PALETTE & SHARED CONSTANTS
  // ============================================================
  final Color magenta = Color(0xFFFF00FF);
  final Color magentaSoft = Color(0xFFFF66FF);
  final Color magentaDeep = Color(0xFFB300B3);
  final Color violetA = Color(0xFF6A1B9A);
  final Color violetB = Color(0xFF4527A0);
  final Color crimson = Color(0xFFB71C1C);
  final Color textWhite = Colors.white;
  final Color paperDark = Color(0xFF1A0A1A);

  print('Classic backgroundColor: 0xFFFF00FF (magenta)');
  print('Classic textStyle: white, fontSize 16, fontWeight bold');
  print('Static fields: backgroundColor, textStyle, paragraphStyle');

  // ============================================================
  // SECTION 1: TITLE BANNER
  // ============================================================
  print('=== Section 1: Title Banner ===');
  final Widget section1 = Container(
    width: double.infinity,
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [magenta, violetA, violetB],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: magenta.withValues(alpha: 0.55),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: violetB.withValues(alpha: 0.40),
          blurRadius: 40.0,
          offset: Offset(0.0, 20.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: textWhite.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: textWhite, width: 2.0),
              ),
              child: Icon(Icons.bug_report, color: textWhite, size: 32.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RenderErrorBox',
                    style: TextStyle(
                      color: textWhite,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/rendering.dart',
                    style: TextStyle(
                      color: textWhite.withValues(alpha: 0.85),
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: paperDark.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: textWhite.withValues(alpha: 0.30),
              width: 1.0,
            ),
          ),
          child: Text(
            'The classic magenta error screen. Painted by the framework when '
            'a build/layout/paint phase throws and ErrorWidget kicks in.',
            style: TextStyle(
              color: textWhite,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: ANATOMY DIAGRAM
  // ============================================================
  print('=== Section 2: Anatomy ===');
  final Widget section2 = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: magenta, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: magenta.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 2 - Anatomy of a RenderErrorBox',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: magentaDeep,
          ),
        ),
        SizedBox(height: 12.0),
        // Labelled diagram: a faux RenderErrorBox with arrows + labels
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            color: magenta,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: magentaDeep.withValues(alpha: 0.50),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'A RenderObject error occurred:',
                style: TextStyle(
                  color: textWhite,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'RenderFlex overflowed by 42 pixels on the right.',
                style: TextStyle(color: textWhite, fontSize: 14.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'See https://flutter.dev/docs/...',
                style: TextStyle(
                  color: textWhite.withValues(alpha: 0.85),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _label(
                'Background',
                'RenderErrorBox.backgroundColor — defaults to magenta '
                    '(0xFFFF00FF). Painted edge-to-edge.',
                magenta,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _label(
                'Text',
                'RenderErrorBox.textStyle / paragraphStyle — defaults to '
                    'white bold sans-serif.',
                violetA,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _label(
                'Sizing',
                'Expands to constraints.biggest. Has no children. '
                    'No intrinsic dimensions.',
                violetB,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _label(
                'Owner',
                'Mounted by ErrorWidget when Flutter catches a build error.',
                crimson,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: DEFAULT APPEARANCE - 3 SIZES
  // ============================================================
  print('=== Section 3: Default appearance (small/medium/large) ===');
  final List<Map<String, dynamic>> sizeMocks = [
    {
      'label': 'Small (compact tile)',
      'height': 70.0,
      'msg': 'Build error',
      'fontSize': 11.0,
    },
    {
      'label': 'Medium (panel)',
      'height': 130.0,
      'msg': 'A RenderFlex overflowed by 24 pixels on the bottom.',
      'fontSize': 14.0,
    },
    {
      'label': 'Large (full screen)',
      'height': 220.0,
      'msg':
          'The following assertion was thrown building MyWidget(dirty):\n'
          '  setState() or markNeedsBuild() called during build.',
      'fontSize': 16.0,
    },
  ];

  final List<Widget> sizeCards = <Widget>[];
  for (int i = 0; i < sizeMocks.length; i = i + 1) {
    final Map<String, dynamic> m = sizeMocks[i];
    sizeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: magenta.withValues(alpha: 0.35),
              blurRadius: 14.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: magentaDeep,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Text(
                m['label'] as String,
                style: TextStyle(
                  color: textWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: m['height'] as double,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: magenta,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              alignment: Alignment.topLeft,
              child: Text(
                m['msg'] as String,
                style: TextStyle(
                  color: textWhite,
                  fontSize: m['fontSize'] as double,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section3 = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          magentaSoft.withValues(alpha: 0.15),
          violetA.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: magenta.withValues(alpha: 0.50), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 3 - Default appearance at three sizes',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: magentaDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'RenderErrorBox expands to fill its constraints. The text wraps '
          'and is painted in the configured paragraphStyle.',
          style: TextStyle(fontSize: 12.0, color: paperDark),
        ),
        SizedBox(height: 8.0),
        Column(children: sizeCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: CUSTOMIZATION VARIANTS
  // ============================================================
  print('=== Section 4: Customization variants ===');
  final List<Map<String, dynamic>> variants = [
    {
      'name': 'Dark Mode',
      'bg': Color(0xFF121212),
      'fg': Color(0xFFFF80AB),
      'accent': Color(0xFFE040FB),
      'note': 'RenderErrorBox.backgroundColor = Color(0xFF121212)',
      'msg': 'Build failure detected. Tap for details.',
    },
    {
      'name': 'Branded',
      'bg': Color(0xFF0D47A1),
      'fg': Color(0xFFFFFFFF),
      'accent': Color(0xFF82B1FF),
      'note': 'Wrap with corporate gradient + textStyle override.',
      'msg': 'Acme Corp encountered an unexpected error.',
    },
    {
      'name': 'Minimal',
      'bg': Color(0xFFF5F5F5),
      'fg': Color(0xFF424242),
      'accent': Color(0xFF9E9E9E),
      'note': 'paragraphStyle: thin grey, no shadows.',
      'msg': 'Something went wrong.',
    },
    {
      'name': 'Warning Yellow',
      'bg': Color(0xFFFFF59D),
      'fg': Color(0xFF6D4C00),
      'accent': Color(0xFFFFB300),
      'note': 'backgroundColor + textStyle for caution palette.',
      'msg': 'Caution: widget tree degraded.',
    },
  ];

  final List<Widget> variantCards = <Widget>[];
  for (int i = 0; i < variants.length; i = i + 1) {
    final Map<String, dynamic> v = variants[i];
    variantCards.add(
      Container(
        width: 230.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              (v['bg'] as Color).withValues(alpha: 0.95),
              (v['accent'] as Color).withValues(alpha: 0.65),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: (v['accent'] as Color).withValues(alpha: 0.40),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              v['name'] as String,
              style: TextStyle(
                color: v['fg'] as Color,
                fontWeight: FontWeight.w900,
                fontSize: 14.0,
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: v['bg'] as Color,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: v['accent'] as Color, width: 1.0),
              ),
              child: Text(
                v['msg'] as String,
                style: TextStyle(
                  color: v['fg'] as Color,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              v['note'] as String,
              style: TextStyle(
                color: v['fg'] as Color,
                fontSize: 10.0,
                fontFamily: 'monospace',
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section4 = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: violetA, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: violetA.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4 - Customization (backgroundColor / textStyle / paragraphStyle)',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: violetA,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Override RenderErrorBox.backgroundColor, .textStyle, and '
          '.paragraphStyle once at app startup. All future error screens '
          'inherit the new look.',
          style: TextStyle(fontSize: 12.0, color: paperDark),
        ),
        SizedBox(height: 8.0),
        Wrap(children: variantCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: ERRORWIDGET INTEGRATION
  // ============================================================
  print('=== Section 5: ErrorWidget integration ===');
  final Widget section5 = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [violetB, violetA],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: violetB.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5 - ErrorWidget wraps RenderErrorBox',
          style: TextStyle(
            color: textWhite,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        _flow('1. Framework catches exception during build()'),
        _flow('2. Calls ErrorWidget.builder(FlutterErrorDetails)'),
        _flow('3. Default builder returns ErrorWidget(error)'),
        _flow('4. ErrorWidget creates a LeafRenderObjectElement'),
        _flow('5. createRenderObject() returns RenderErrorBox(message)'),
        _flow('6. RenderErrorBox paints magenta + message text'),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: paperDark.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: textWhite.withValues(alpha: 0.30),
              width: 1.0,
            ),
          ),
          child: Text(
            "ErrorWidget.builder = (FlutterErrorDetails d) => MyError(d);",
            style: TextStyle(
              color: textWhite,
              fontSize: 12.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: PRODUCTION STRATEGY
  // ============================================================
  print('=== Section 6: Production strategy ===');
  final Widget section6 = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFF8E1),
          Color(0xFFFFE0B2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFFFA000), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFFFA000).withValues(alpha: 0.30),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6 - Production: replace the magenta box',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6D4C00),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Override ErrorWidget.builder in main() so users never see the '
          'developer-facing magenta screen.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF6D4C00)),
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF0D47A1).withValues(alpha: 0.40),
                blurRadius: 14.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.sentiment_dissatisfied,
                color: textWhite,
                size: 48.0,
              ),
              SizedBox(height: 8.0),
              Text(
                'Something went wrong',
                style: TextStyle(
                  color: textWhite,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                "We're already on it. Please try again in a moment.",
                style: TextStyle(
                  color: textWhite.withValues(alpha: 0.90),
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: textWhite.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: textWhite, width: 1.0),
                ),
                child: Text(
                  'Reload',
                  style: TextStyle(
                    color: textWhite,
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
  // SECTION 7: COMMON ERROR MESSAGES
  // ============================================================
  print('=== Section 7: Common error messages ===');
  final List<Map<String, dynamic>> commons = [
    {
      'icon': Icons.compare_arrows,
      'title': 'RenderFlex overflow',
      'msg': 'A RenderFlex overflowed by N pixels on the right.',
      'color': Color(0xFFE53935),
    },
    {
      'icon': Icons.crop_square,
      'title': 'Bounds mismatch',
      'msg': 'BoxConstraints has a negative minimum width.',
      'color': Color(0xFFD81B60),
    },
    {
      'icon': Icons.help_outline,
      'title': 'Null dereference',
      'msg': 'Null check operator used on a null value.',
      'color': Color(0xFF8E24AA),
    },
    {
      'icon': Icons.widgets_outlined,
      'title': 'Missing widget',
      'msg': 'No MaterialLocalizations found. Wrap with MaterialApp.',
      'color': Color(0xFF5E35B1),
    },
    {
      'icon': Icons.sync_problem,
      'title': 'Async during build',
      'msg': 'setState() or markNeedsBuild() called during build.',
      'color': Color(0xFF3949AB),
    },
  ];

  final List<Widget> commonCards = <Widget>[];
  for (int i = 0; i < commons.length; i = i + 1) {
    final Map<String, dynamic> c = commons[i];
    commonCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              (c['color'] as Color).withValues(alpha: 0.10),
              (c['color'] as Color).withValues(alpha: 0.25),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: c['color'] as Color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: (c['color'] as Color).withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: (c['color'] as Color).withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                c['icon'] as IconData,
                color: c['color'] as Color,
                size: 24.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c['title'] as String,
                    style: TextStyle(
                      color: c['color'] as Color,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    c['msg'] as String,
                    style: TextStyle(
                      color: paperDark.withValues(alpha: 0.85),
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section7 = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: crimson, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 7 - Errors most often surfaced by RenderErrorBox',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: crimson,
          ),
        ),
        SizedBox(height: 6.0),
        Column(children: commonCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: LIFECYCLE
  // ============================================================
  print('=== Section 8: Lifecycle ===');
  final Widget section8 = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF263238),
          Color(0xFF37474F),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 8 - When does RenderErrorBox appear?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _lifecyclePanel(
                'Appears',
                Color(0xFF66BB6A),
                Icons.check_circle,
                [
                  'Exception thrown during build()',
                  'Exception during layout / paint',
                  'Assertion in RenderObject API',
                  'Caught by FlutterError.onError',
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _lifecyclePanel(
                'Silent / different',
                Color(0xFFEF5350),
                Icons.cancel,
                [
                  'Engine crash (process exits)',
                  'Async errors w/o zone capture',
                  'Errors before runApp()',
                  'Errors in platform channels',
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: FOOTGUNS
  // ============================================================
  print('=== Section 9: Footguns ===');
  final List<Map<String, String>> footguns = [
    {
      'title': 'Mutating backgroundColor at runtime',
      'body':
          'Setting RenderErrorBox.backgroundColor after a RenderErrorBox '
              'has already painted does not repaint existing instances. '
              'Set it before runApp().',
    },
    {
      'title': 'ErrorWidget.builder is global',
      'body':
          'Overriding ErrorWidget.builder affects every error screen in '
              'the app. Keep it as the last resort, not as a normal path.',
    },
    {
      'title': 'Hides the real stack trace',
      'body':
          'A pretty replacement widget can hide diagnostic info. Always '
              'forward FlutterErrorDetails to your crash reporter first.',
    },
    {
      'title': 'Custom widget can throw too',
      'body':
          'If your replacement ErrorWidget itself throws, the framework '
              'falls back to the original RenderErrorBox.',
    },
  ];

  final List<Widget> footgunCards = <Widget>[];
  for (int i = 0; i < footguns.length; i = i + 1) {
    final Map<String, String> f = footguns[i];
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFEBEE),
              Color(0xFFFFCDD2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: crimson, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: crimson.withValues(alpha: 0.20),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber, color: crimson, size: 26.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f['title']!,
                    style: TextStyle(
                      color: crimson,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    f['body']!,
                    style: TextStyle(
                      color: paperDark,
                      fontSize: 12.0,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section9 = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: crimson, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 9 - Footguns',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: crimson,
          ),
        ),
        SizedBox(height: 4.0),
        Column(children: footgunCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: RECAP
  // ============================================================
  print('=== Section 10: Recap ===');
  final Widget section10 = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [magentaDeep, violetA, violetB],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: violetA.withValues(alpha: 0.55),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: textWhite, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Section 10 - Recap',
              style: TextStyle(
                color: textWhite,
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recap('RenderErrorBox is a leaf RenderBox painting magenta + text.'),
        _recap('Constructed with a single message string.'),
        _recap('Static fields: backgroundColor, textStyle, paragraphStyle.'),
        _recap('Mounted by ErrorWidget when build() throws.'),
        _recap('Override ErrorWidget.builder for production UX.'),
        _recap('Set static fields BEFORE runApp() — no live repaint.'),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: paperDark.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'final box = RenderErrorBox("layout failed");',
            style: TextStyle(
              color: textWhite,
              fontSize: 12.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );

  // Touch the actual symbol so the import is meaningful (no real error).
  final RenderErrorBox demoBox = RenderErrorBox('Demo only — not mounted');
  print('Constructed sample RenderErrorBox: $demoBox');

  print('RenderErrorBox Deep Demo completed');

  return Scaffold(
    backgroundColor: Color(0xFFF6EAF8),
    appBar: AppBar(
      backgroundColor: magenta,
      foregroundColor: Colors.white,
      title: Text('RenderErrorBox Deep Demo'),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          section1,
          section2,
          section3,
          section4,
          section5,
          section6,
          section7,
          section8,
          section9,
          section10,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

Widget _label(String title, String body, Color color) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(
            color: Color(0xFF1A0A1A),
            fontSize: 11.0,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _flow(String text) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.30),
        width: 1.0,
      ),
    ),
    child: Row(
      children: [
        Icon(Icons.arrow_right, color: Colors.white, size: 18.0),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _lifecyclePanel(
  String title,
  Color color,
  IconData icon,
  List<String> items,
) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < items.length; i = i + 1) {
    rows.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.circle, color: color, size: 8.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                items[i],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.30),
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
            Icon(icon, color: color, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Column(children: rows),
      ],
    ),
  );
}

Widget _recap(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Colors.white, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}
