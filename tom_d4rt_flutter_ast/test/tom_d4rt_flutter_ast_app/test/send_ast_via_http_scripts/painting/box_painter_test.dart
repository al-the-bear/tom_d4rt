// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for BoxPainter from package:flutter/painting.dart
// Theme: slate-grey + plum "rendering internals"
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxPainter Deep Demo executing');

  // Theme palette ------------------------------------------------------------
  final Color slate900 = Color(0xFF1F2937);
  final Color slate800 = Color(0xFF263041);
  final Color slate700 = Color(0xFF334155);
  final Color slate500 = Color(0xFF64748B);
  final Color slate300 = Color(0xFFCBD5E1);
  final Color slate100 = Color(0xFFF1F5F9);
  final Color plum900 = Color(0xFF4A1942);
  final Color plum700 = Color(0xFF6B2C5F);
  final Color plum500 = Color(0xFF8E3A7E);
  final Color plum300 = Color(0xFFCFA5C7);
  final Color plum100 = Color(0xFFF3E5F0);
  final Color amber400 = Color(0xFFFFC107);
  final Color teal400 = Color(0xFF26C6DA);
  final Color rose400 = Color(0xFFE91E63);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final Widget titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate900, plum900, slate800],
        stops: [0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: plum900.withValues(alpha: 0.55),
          blurRadius: 24.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: slate900.withValues(alpha: 0.45),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
      border: Border.all(color: plum300.withValues(alpha: 0.35), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [plum300, plum700],
                  radius: 0.9,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: plum500.withValues(alpha: 0.6),
                    blurRadius: 14.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Icon(Icons.brush, color: Colors.white, size: 36.0),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BoxPainter',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Rendering Internals  --  package:flutter/painting.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: plum300,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: plum300.withValues(alpha: 0.3)),
          ),
          child: Text(
            'abstract class BoxPainter -- created by Decoration.createBoxPainter()',
            style: TextStyle(
              color: plum100,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy --- Decoration -> createBoxPainter -> paint
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate100, plum100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: plum300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: slate500.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('2. Anatomy of a paint cycle', plum900),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _anatomyNode('Decoration', Icons.layers, slate700, 'BoxDecoration\nShapeDecoration\nFlutterLogoDecoration'),
            _arrow(plum500),
            _anatomyNode('createBoxPainter', Icons.build, plum700, '([VoidCallback?\nonChanged])'),
            _arrow(plum500),
            _anatomyNode('BoxPainter', Icons.brush, plum900, 'paint(canvas,\noffset,\nconfig)'),
          ],
        ),
        SizedBox(height: 18.0),
        _captionRow(
          'paint(Canvas canvas, Offset offset, ImageConfiguration config)',
          slate800,
        ),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 3: onChanged callback
  // ============================================================
  print('=== Section 3: onChanged callback ===');

  final Widget onChangedSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate800, plum700, slate900],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: plum700.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('3. The onChanged callback', Colors.white),
        SizedBox(height: 12.0),
        Text(
          'When a decoration depends on async data (an image not yet loaded), '
          'the painter calls onChanged() once that data arrives so the host '
          'render object can mark itself dirty and repaint.',
          style: TextStyle(
            color: plum100,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
        SizedBox(height: 16.0),
        // Visual diagram for onChanged image-decoration flow
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: plum300.withValues(alpha: 0.4)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _flowChip('createBoxPainter\n(onChanged)', amber400),
                  _flowDash(plum300),
                  _flowChip('paint() #1\n(no image yet)', teal400),
                  _flowDash(plum300),
                  _flowChip('image\nresolves', plum300),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  _flowChip('onChanged()\nfires', rose400),
                  _flowDash(plum300),
                  _flowChip('markNeedsPaint', amber400),
                  _flowDash(plum300),
                  _flowChip('paint() #2\n(image drawn)', teal400),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          'final painter = decoration.createBoxPainter(() {\n'
          '  // Called from image-stream listener;\n'
          '  // ask the render object to repaint.\n'
          '  markNeedsPaint();\n'
          '});',
          teal400,
          slate900,
          plum300,
        ),
      ],
    ),
  );
  print('Created onChanged section');

  // ============================================================
  // SECTION 4: Lifecycle timeline
  // ============================================================
  print('=== Section 4: Lifecycle timeline ===');

  final List<Map<String, dynamic>> lifecycleSteps = [
    {
      'label': 'createBoxPainter',
      'subtitle': 'Decoration.createBoxPainter(onChanged)',
      'icon': Icons.add_circle_outline,
      'color': teal400,
    },
    {
      'label': 'paint #1',
      'subtitle': 'paint(canvas, offset, config)',
      'icon': Icons.brush,
      'color': amber400,
    },
    {
      'label': 'paint #2..N',
      'subtitle': 'reused on every frame',
      'icon': Icons.repeat,
      'color': plum300,
    },
    {
      'label': 'onChanged',
      'subtitle': 'optional async repaint trigger',
      'icon': Icons.notifications_active,
      'color': rose400,
    },
    {
      'label': 'dispose',
      'subtitle': 'painter.dispose()',
      'icon': Icons.delete_outline,
      'color': slate300,
    },
  ];

  final List<Widget> timelineWidgets = <Widget>[];
  int stepIndex = 0;
  for (final Map<String, dynamic> step in lifecycleSteps) {
    final Color stepColor = step['color'] as Color;
    timelineWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              slate800,
              stepColor.withValues(alpha: 0.18),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: stepColor.withValues(alpha: 0.55)),
          boxShadow: [
            BoxShadow(
              color: stepColor.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: stepColor.withValues(alpha: 0.25),
                shape: BoxShape.circle,
                border: Border.all(color: stepColor, width: 2.0),
              ),
              child: Text(
                '${stepIndex + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Icon(step['icon'] as IconData, color: stepColor, size: 24.0),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['label'] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    step['subtitle'] as String,
                    style: TextStyle(
                      color: plum100,
                      fontSize: 11.5,
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
    stepIndex = stepIndex + 1;
  }

  final Widget lifecycle = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: slate900,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: plum700, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.65),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('4. Lifecycle timeline', Colors.white),
        SizedBox(height: 12.0),
        Column(children: timelineWidgets),
      ],
    ),
  );
  print('Created lifecycle (steps=${timelineWidgets.length})');

  // ============================================================
  // SECTION 5: ImageConfiguration --- 4 fields
  // ============================================================
  print('=== Section 5: ImageConfiguration ===');

  final List<Map<String, dynamic>> configFields = [
    {
      'name': 'size',
      'type': 'Size?',
      'desc': 'Box dimensions. Used for stretching\nand fit-aware images.',
      'icon': Icons.aspect_ratio,
      'color': teal400,
    },
    {
      'name': 'textDirection',
      'type': 'TextDirection?',
      'desc': 'LTR/RTL. Drives directional\ngradients and borders.',
      'icon': Icons.swap_horiz,
      'color': plum300,
    },
    {
      'name': 'locale',
      'type': 'Locale?',
      'desc': 'Locale for locale-aware\nimage variants.',
      'icon': Icons.language,
      'color': amber400,
    },
    {
      'name': 'devicePixelRatio',
      'type': 'double?',
      'desc': 'For HiDPI image resolution\n(1x / 2x / 3x).',
      'icon': Icons.high_quality,
      'color': rose400,
    },
  ];

  final List<Widget> configCards = <Widget>[];
  for (final Map<String, dynamic> field in configFields) {
    final Color fc = field['color'] as Color;
    configCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              slate800,
              fc.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: fc.withValues(alpha: 0.6), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: fc.withValues(alpha: 0.3),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(field['icon'] as IconData, color: fc, size: 24.0),
                SizedBox(width: 8.0),
                Text(
                  field['name'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: fc.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                field['type'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: fc,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              field['desc'] as String,
              style: TextStyle(
                color: plum100,
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget imageConfigSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [plum100, slate100],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: plum300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: plum300.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('5. ImageConfiguration', plum900),
        SizedBox(height: 8.0),
        Text(
          'Passed into paint() on every frame; gives the painter context '
          'about the host environment.',
          style: TextStyle(color: slate800, fontSize: 12.5, height: 1.4),
        ),
        SizedBox(height: 12.0),
        Wrap(children: configCards),
      ],
    ),
  );
  print('Created ImageConfiguration cards (${configCards.length})');

  // ============================================================
  // SECTION 6: Implementation gallery
  // ============================================================
  print('=== Section 6: Implementation gallery ===');

  // 6a. BoxDecoration painter
  final BoxDecoration boxDecoSample = BoxDecoration(
    gradient: LinearGradient(
      colors: [plum700, slate800, plum500],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(14.0),
    border: Border.all(color: plum300, width: 2.0),
    boxShadow: [
      BoxShadow(
        color: plum700.withValues(alpha: 0.55),
        blurRadius: 12.0,
        offset: Offset(0.0, 6.0),
      ),
      BoxShadow(
        color: slate900.withValues(alpha: 0.4),
        blurRadius: 4.0,
        offset: Offset(0.0, 1.0),
      ),
    ],
  );
  // Real BoxPainter construction (informational; we still render via Container)
  final BoxPainter boxDecoPainter = boxDecoSample.createBoxPainter();
  print('boxDecoPainter runtimeType=${boxDecoPainter.runtimeType}');

  // 6b. ShapeDecoration painter
  final ShapeDecoration shapeDecoSample = ShapeDecoration(
    gradient: RadialGradient(
      colors: [amber400, plum500, slate900],
      stops: [0.0, 0.6, 1.0],
    ),
    shape: StadiumBorder(
      side: BorderSide(color: plum300, width: 2.0),
    ),
    shadows: [
      BoxShadow(
        color: plum500.withValues(alpha: 0.5),
        blurRadius: 14.0,
        offset: Offset(0.0, 6.0),
      ),
    ],
  );
  // Cluster C30: ShapeDecoration.createBoxPainter dereferences `onChanged!`
  // unconditionally in Flutter's SDK (shape_decoration.dart L286), so a
  // null callback throws "Null check operator used on a null value"
  // immediately when constructing _ShapeDecorationPainter. Pass an empty
  // callback to satisfy the SDK contract.
  final BoxPainter shapeDecoPainter = shapeDecoSample.createBoxPainter(() {});
  print('shapeDecoPainter runtimeType=${shapeDecoPainter.runtimeType}');

  // 6c. FlutterLogoDecoration painter
  final FlutterLogoDecoration logoDeco = FlutterLogoDecoration(
    style: FlutterLogoStyle.horizontal,
    textColor: plum900,
  );
  final BoxPainter logoPainter = logoDeco.createBoxPainter();
  print('logoPainter runtimeType=${logoPainter.runtimeType}');

  final Widget galleryCard1 = _galleryCard(
    'BoxDecoration',
    '_BoxDecorationPainter',
    boxDecoPainter.runtimeType.toString(),
    Container(
      width: 160.0,
      height: 90.0,
      decoration: boxDecoSample,
      alignment: Alignment.center,
      child: Text(
        'gradient + shadow',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    ),
    plum700,
    slate800,
    plum300,
    slate100,
  );

  final Widget galleryCard2 = _galleryCard(
    'ShapeDecoration',
    '_ShapeDecorationPainter',
    shapeDecoPainter.runtimeType.toString(),
    Container(
      width: 160.0,
      height: 90.0,
      decoration: shapeDecoSample,
      alignment: Alignment.center,
      child: Text(
        'StadiumBorder',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    ),
    amber400,
    slate800,
    plum300,
    slate100,
  );

  final Widget galleryCard3 = _galleryCard(
    'FlutterLogoDecoration',
    'FlutterLogoDecoration',
    logoPainter.runtimeType.toString(),
    Container(
      width: 160.0,
      height: 90.0,
      decoration: BoxDecoration(
        color: slate100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 120.0,
        height: 60.0,
        decoration: logoDeco,
      ),
    ),
    teal400,
    slate800,
    plum300,
    slate100,
  );

  final Widget gallerySection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate100, plum100, slate100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: plum300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: slate500.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('6. Implementation gallery', plum900),
        SizedBox(height: 8.0),
        Text(
          'Each Decoration vends its own concrete BoxPainter subclass.',
          style: TextStyle(color: slate800, fontSize: 12.5),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [galleryCard1, galleryCard2, galleryCard3],
        ),
      ],
    ),
  );
  // Dispose the demonstration painters now that we have read their runtime types.
  boxDecoPainter.dispose();
  shapeDecoPainter.dispose();
  logoPainter.dispose();
  print('Disposed gallery painters');

  // ============================================================
  // SECTION 7: Real construction (code block)
  // ============================================================
  print('=== Section 7: Real construction ===');

  final Widget realConstruction = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate900, slate800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: plum700, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: plum700.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('7. Real construction', Colors.white),
        SizedBox(height: 12.0),
        _codeBlock(
          '// Direct construction (the path frameworks rarely take)\n'
          'final BoxDecoration deco = BoxDecoration(\n'
          '  gradient: LinearGradient(\n'
          '    colors: [Color(0xFF6B2C5F), Color(0xFF263041)],\n'
          '  ),\n'
          '  borderRadius: BorderRadius.circular(14.0),\n'
          ');\n'
          '\n'
          'final BoxPainter painter = deco.createBoxPainter();\n'
          '\n'
          '// Later, in your render object:\n'
          'painter.paint(canvas, offset, configuration);\n'
          '\n'
          '// When done:\n'
          'painter.dispose();',
          teal400,
          Color(0xFF11161F),
          plum300,
        ),
        SizedBox(height: 8.0),
        Text(
          'In production code, RenderDecoratedBox owns the painter and '
          'recreates it whenever the decoration changes.',
          style: TextStyle(color: plum100, fontSize: 12.0),
        ),
      ],
    ),
  );
  print('Created real-construction code block');

  // ============================================================
  // SECTION 8: Custom Decoration tutorial skeleton
  // ============================================================
  print('=== Section 8: Custom Decoration tutorial ===');

  final Widget customDecoSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [plum900, slate900, plum700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: plum300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: plum900.withValues(alpha: 0.55),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('8. Authoring a custom Decoration', Colors.white),
        SizedBox(height: 8.0),
        Text(
          'A Decoration is just a factory for a BoxPainter. The painter '
          'holds whatever cached state the decoration needs (gradients, '
          'compiled Path objects, image stream listeners, etc.).',
          style: TextStyle(color: plum100, fontSize: 12.5, height: 1.4),
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          'class MyDeco extends Decoration {\n'
          '  const MyDeco({required this.color});\n'
          '  final Color color;\n'
          '\n'
          '  @override\n'
          '  BoxPainter createBoxPainter([VoidCallback? onChanged])\n'
          '      => _MyPainter(this, onChanged);\n'
          '}\n'
          '\n'
          'class _MyPainter extends BoxPainter {\n'
          '  _MyPainter(this.deco, VoidCallback? onChanged)\n'
          '      : super(onChanged);\n'
          '  final MyDeco deco;\n'
          '\n'
          '  @override\n'
          '  void paint(Canvas canvas, Offset offset,\n'
          '             ImageConfiguration cfg) {\n'
          '    final Paint p = Paint()..color = deco.color;\n'
          '    canvas.drawRect(offset & cfg.size!, p);\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  void dispose() {\n'
          '    // release listeners, image streams, etc.\n'
          '    super.dispose();\n'
          '  }\n'
          '}',
          amber400,
          Color(0xFF11161F),
          plum300,
        ),
      ],
    ),
  );
  print('Created custom-decoration tutorial');

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');

  final List<Map<String, dynamic>> footguns = [
    {
      'title': 'Painter is NOT thread-safe',
      'detail': 'Never share one BoxPainter instance across isolates or '
          'render trees. Caches inside the painter assume single-threaded '
          'access.',
      'icon': Icons.warning_amber_rounded,
      'color': rose400,
    },
    {
      'title': 'Forgetting onChanged on image decorations',
      'detail': 'Image-backed decorations resolve asynchronously. Without '
          'an onChanged callback, the decoration paints once with no image '
          'and never repaints when the image arrives.',
      'icon': Icons.image_not_supported,
      'color': amber400,
    },
    {
      'title': 'Skipping dispose()',
      'detail': 'BoxPainters may hold ImageStream listeners. Dropping a '
          'painter without dispose() leaks listeners and prevents image '
          'cache eviction.',
      'icon': Icons.delete_forever,
      'color': teal400,
    },
  ];

  final List<Widget> footgunWidgets = <Widget>[];
  for (final Map<String, dynamic> fg in footguns) {
    final Color fc = fg['color'] as Color;
    footgunWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              slate800,
              fc.withValues(alpha: 0.2),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: fc.withValues(alpha: 0.65), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: fc.withValues(alpha: 0.3),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(fg['icon'] as IconData, color: fc, size: 28.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    fg['detail'] as String,
                    style: TextStyle(
                      color: plum100,
                      fontSize: 11.5,
                      height: 1.4,
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

  final Widget footgunsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: slate900,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: rose400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: rose400.withValues(alpha: 0.3),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('9. Footguns', Colors.white),
        SizedBox(height: 8.0),
        Column(children: footgunWidgets),
      ],
    ),
  );
  print('Created footguns (${footgunWidgets.length})');

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: Recap ===');

  final List<List<String>> recapRows = [
    ['Type', 'abstract class BoxPainter'],
    ['Library', 'package:flutter/painting.dart'],
    ['Created by', 'Decoration.createBoxPainter([onChanged])'],
    ['Key method', 'paint(Canvas, Offset, ImageConfiguration)'],
    ['Lifecycle', 'create -> paint* -> dispose'],
    ['Implementations', '_BoxDecorationPainter, _ShapeDecorationPainter,\nFlutterLogoDecoration'],
    ['onChanged', 'fires when async image data resolves'],
    ['Thread-safety', 'single-threaded; never share'],
  ];

  final List<Widget> recapTableRows = <Widget>[];
  int recapIdx = 0;
  for (final List<String> row in recapRows) {
    final bool zebra = (recapIdx % 2) == 0;
    recapTableRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: zebra
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.white.withValues(alpha: 0.02),
          border: Border(
            bottom: BorderSide(color: plum300.withValues(alpha: 0.2)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130.0,
              child: Text(
                row[0],
                style: TextStyle(
                  color: plum300,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                row[1],
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    recapIdx = recapIdx + 1;
  }

  final Widget recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(0.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate900, plum900, slate800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: plum300.withValues(alpha: 0.45), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: plum900.withValues(alpha: 0.55),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: slate900.withValues(alpha: 0.35),
          blurRadius: 4.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [plum700, slate800],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.summarize, color: Colors.white, size: 26.0),
                SizedBox(width: 10.0),
                Text(
                  '10. Recap',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(children: recapTableRows),
          Container(
            padding: EdgeInsets.all(14.0),
            child: Text(
              'BoxPainter is the seam between immutable Decoration descriptions '
              'and mutable per-frame Canvas drawing. Treat it as a short-lived, '
              'single-threaded resource that must be disposed.',
              style: TextStyle(
                color: plum100,
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  print('Created recap (${recapTableRows.length} rows)');

  print('BoxPainter Deep Demo completed');

  return Scaffold(
    backgroundColor: slate100,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 8.0),
          anatomy,
          onChangedSection,
          lifecycle,
          imageConfigSection,
          gallerySection,
          realConstruction,
          customDecoSection,
          footgunsSection,
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper builders
// ---------------------------------------------------------------------------

Widget _sectionHeader(String text, Color color) {
  return Row(
    children: [
      Container(
        width: 6.0,
        height: 22.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
      SizedBox(width: 10.0),
      Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 0.4,
        ),
      ),
    ],
  );
}

Widget _anatomyNode(String title, IconData icon, Color color, String detail) {
  return Container(
    width: 130.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          detail,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 9.5,
            fontFamily: 'monospace',
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

Widget _arrow(Color color) {
  return Icon(Icons.chevron_right, color: color, size: 28.0);
}

Widget _captionRow(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: color,
      ),
    ),
  );
}

Widget _flowChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontSize: 10.0,
        height: 1.25,
      ),
    ),
  );
}

Widget _flowDash(Color color) {
  return Container(
    width: 14.0,
    height: 2.0,
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(1.0),
    ),
  );
}

Widget _codeBlock(String code, Color textColor, Color bgColor, Color borderColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: borderColor.withValues(alpha: 0.35)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.45,
      ),
    ),
  );
}

Widget _galleryCard(
  String title,
  String painterClass,
  String runtime,
  Widget preview,
  Color accent,
  Color slate800,
  Color plum300,
  Color slate100,
) {
  return Container(
    width: 200.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: slate100,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cluster H follow-up: the original Row [Icon(18) + SizedBox(6)
        // + Text(title, fontSize 13 bold)] overflowed the 176-px inner
        // width (200 - 24 padding) by 3.8 px on the right when the
        // longest title 'FlutterLogoDecoration' (21 chars at fontSize
        // 13 bold) is rendered. Wrapped the Text in Expanded so the
        // Row provides bounded width to Text and lets it wrap or
        // ellipsize (overflow: ellipsis with maxLines: 2 keeps the
        // visual close to the original).
        Row(
          children: [
            Icon(Icons.brush, color: accent, size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: slate800,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Center(child: preview),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'painter: $painterClass',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.5,
              color: slate800,
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'runtimeType: $runtime',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: plum300,
          ),
        ),
      ],
    ),
  );
}
