// ignore_for_file: avoid_print
// D4rt deep-demo: ImageRepeat — Sienna / Clay theme, prefix ir
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget irSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFFA0522D), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6B3A2A),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget irChip(String label, Color bg) {
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

Widget irInfoRow(String label, String value) {
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
                  color: Color(0xFF8B6914))),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12.0, color: Color(0xFF5D4037))),
        ),
      ],
    ),
  );
}

Widget irTilePreview(ImageRepeat mode, Color bg, String label) {
  // Simulates a tiling pattern with colored squares
  final patternColor = Color(0xFFA0522D);
  final tileX = mode == ImageRepeat.repeat || mode == ImageRepeat.repeatX;
  final tileY = mode == ImageRepeat.repeat || mode == ImageRepeat.repeatY;

  return Column(
    children: [
      Container(
        width: 120.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: Color(0xFF8B4513), width: 1.0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Stack(
          children: [
            // Center tile (always shown)
            Positioned(
              left: 45.0,
              top: 25.0,
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: patternColor.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Icon(Icons.image, size: 16.0, color: Colors.white),
              ),
            ),
            // Horizontal repeats
            if (tileX) ...[
              Positioned(
                left: 8.0,
                top: 25.0,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: patternColor.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              Positioned(
                left: 82.0,
                top: 25.0,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: patternColor.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ],
            // Vertical repeats
            if (tileY) ...[
              Positioned(
                left: 45.0,
                top: 2.0,
                child: Container(
                  width: 30.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: patternColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              Positioned(
                left: 45.0,
                top: 58.0,
                child: Container(
                  width: 30.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: patternColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      SizedBox(height: 4.0),
      Text(label,
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
              color: Color(0xFF6B3A2A))),
    ],
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('ImageRepeat Deep Demo executing');
  print('=' * 60);

  // ── Section 1: Title ─────────────────────────────────────────
  print('\n[1] ImageRepeat Overview');
  print('  Enum controlling how an image is tiled inside its container');
  print('  4 values: repeat, repeatX, repeatY, noRepeat');
  print('  Key use: DecorationImage.repeat parameter');

  final irTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFA0522D), Color(0xFF8B4513)],
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
            Icon(Icons.grid_on, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('ImageRepeat',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Controls how an image is tiled within its container bounds',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFFFE0C0))),
        SizedBox(height: 6.0),
        Row(
          children: [
            irChip('repeat', Color(0xFFCD853F)),
            irChip('repeatX', Color(0xFFD2691E)),
            irChip('repeatY', Color(0xFF8B6914)),
            irChip('noRepeat', Color(0xFF6B3A2A)),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: Four Values ───────────────────────────────────
  print('\n[2] The Four Tiling Modes');
  for (final v in ImageRepeat.values) {
    print('  ${v.name}: index=${v.index}');
  }

  final irFourValues = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: ImageRepeat.values.map((v) {
        final labels = {
          ImageRepeat.repeat: 'Both X + Y',
          ImageRepeat.repeatX: 'Horizontal only',
          ImageRepeat.repeatY: 'Vertical only',
          ImageRepeat.noRepeat: 'No tiling',
        };
        final icons = {
          ImageRepeat.repeat: Icons.grid_4x4,
          ImageRepeat.repeatX: Icons.view_column,
          ImageRepeat.repeatY: Icons.view_stream,
          ImageRepeat.noRepeat: Icons.crop_square,
        };
        return Container(
          width: 150.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFA0522D).withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Icon(icons[v] ?? Icons.help, color: Color(0xFFA0522D), size: 24.0),
              SizedBox(height: 6.0),
              Text(v.name,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6B3A2A),
                  )),
              SizedBox(height: 4.0),
              Text(labels[v] ?? '',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF8B6914))),
              SizedBox(height: 4.0),
              Text('index: ${v.index}',
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF999999))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 3: Tile Preview Gallery ──────────────────────────
  print('\n[3] Tiling Visualization');
  for (final v in ImageRepeat.values) {
    final ax = v == ImageRepeat.repeat || v == ImageRepeat.repeatX;
    final ay = v == ImageRepeat.repeat || v == ImageRepeat.repeatY;
    print('  ${v.name}: tilesX=$ax, tilesY=$ay');
  }

  final irTileGallery = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF0E6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Wrap(
      spacing: 16.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
      children: [
        irTilePreview(ImageRepeat.repeat, Color(0xFFFFEDD5), 'repeat'),
        irTilePreview(ImageRepeat.repeatX, Color(0xFFE8F5E9), 'repeatX'),
        irTilePreview(ImageRepeat.repeatY, Color(0xFFE3F2FD), 'repeatY'),
        irTilePreview(ImageRepeat.noRepeat, Color(0xFFFCE4EC), 'noRepeat'),
      ],
    ),
  );

  // ── Section 4: Axis Coverage ─────────────────────────────────
  print('\n[4] Axis Coverage Matrix');
  print('  Mode       | X-axis | Y-axis');
  print('  repeat     | YES    | YES');
  print('  repeatX    | YES    | NO');
  print('  repeatY    | NO     | YES');
  print('  noRepeat   | NO     | NO');

  final axisRows = <Map<String, dynamic>>[
    {'mode': 'repeat', 'x': true, 'y': true, 'color': Color(0xFFA0522D)},
    {'mode': 'repeatX', 'x': true, 'y': false, 'color': Color(0xFFD2691E)},
    {'mode': 'repeatY', 'x': false, 'y': true, 'color': Color(0xFF8B6914)},
    {'mode': 'noRepeat', 'x': false, 'y': false, 'color': Color(0xFF6B3A2A)},
  ];

  final irAxisSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      children: [
        // Header row
        Row(
          children: [
            SizedBox(width: 90.0,
                child: Text('Mode',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0,
                        color: Color(0xFF6B3A2A)))),
            SizedBox(width: 70.0,
                child: Text('X-axis',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0,
                        color: Color(0xFF6B3A2A)),
                    textAlign: TextAlign.center)),
            SizedBox(width: 70.0,
                child: Text('Y-axis',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0,
                        color: Color(0xFF6B3A2A)),
                    textAlign: TextAlign.center)),
          ],
        ),
        Divider(color: Color(0xFFD2B48C)),
        ...axisRows.map((r) {
          final modeColor = r['color'] as Color;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                SizedBox(width: 90.0,
                    child: Text(r['mode'] as String,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600,
                            color: modeColor))),
                SizedBox(width: 70.0,
                    child: Icon(
                      (r['x'] as bool) ? Icons.check_circle : Icons.cancel,
                      color: (r['x'] as bool)
                          ? Color(0xFF4CAF50) : Color(0xFFE57373),
                      size: 18.0,
                    )),
                SizedBox(width: 70.0,
                    child: Icon(
                      (r['y'] as bool) ? Icons.check_circle : Icons.cancel,
                      color: (r['y'] as bool)
                          ? Color(0xFF4CAF50) : Color(0xFFE57373),
                      size: 18.0,
                    )),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 5: DecorationImage Usage ─────────────────────────
  print('\n[5] DecorationImage Usage');
  print('  DecorationImage takes repeat as a parameter');
  print('  Default is ImageRepeat.noRepeat');
  print('  Works with BoxDecoration and ShapeDecoration');

  final irDecoCards = <Map<String, String>>[
    {'mode': 'repeat', 'desc': 'Fills entire box with tiled copies',
     'code': 'DecorationImage(\n  image: img,\n  repeat: ImageRepeat.repeat,\n)'},
    {'mode': 'repeatX', 'desc': 'One row of tiles left to right',
     'code': 'DecorationImage(\n  image: img,\n  repeat: ImageRepeat.repeatX,\n)'},
    {'mode': 'repeatY', 'desc': 'One column of tiles top to bottom',
     'code': 'DecorationImage(\n  image: img,\n  repeat: ImageRepeat.repeatY,\n)'},
    {'mode': 'noRepeat', 'desc': 'Single image placed by alignment',
     'code': 'DecorationImage(\n  image: img,\n  // default: noRepeat\n)'},
  ];

  final irDecoSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF0E6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      children: irDecoCards.map((c) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFD2B48C).withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c['mode']!,
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                      color: Color(0xFFA0522D))),
              SizedBox(height: 4.0),
              Text(c['desc']!,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF5D4037))),
              SizedBox(height: 6.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F0EB),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(c['code']!,
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                        color: Color(0xFF6B3A2A))),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 6: Container Size Effects ────────────────────────
  print('\n[6] Container Size Effects');
  print('  Small container: tiles may be clipped');
  print('  Large container: more repetitions visible');
  print('  Image larger than container: only partial tile shown');

  final containerSizes = <Map<String, dynamic>>[
    {'label': '80×60', 'w': 80.0, 'h': 60.0},
    {'label': '160×80', 'w': 160.0, 'h': 80.0},
    {'label': '240×100', 'w': 240.0, 'h': 100.0},
  ];

  final irContainerSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      children: containerSizes.map((cs) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Container ${cs['label']}',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600,
                      color: Color(0xFF6B3A2A))),
              SizedBox(height: 4.0),
              Container(
                width: (cs['w'] as double),
                height: (cs['h'] as double),
                decoration: BoxDecoration(
                  color: Color(0xFFFFEDD5),
                  border: Border.all(color: Color(0xFFA0522D), width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Text('repeat zone',
                      style: TextStyle(fontSize: 10.0, color: Color(0xFF8B4513))),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 7: paintImage Function ───────────────────────────
  print('\n[7] paintImage Function');
  print('  paintImage() uses ImageRepeat to control tiling');
  print('  Parameters: canvas, rect, image, repeat, ...');
  print('  Internal API, but conceptually important');

  final irPaintSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF0E6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('paintImage() Integration',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700,
                color: Color(0xFF6B3A2A))),
        SizedBox(height: 8.0),
        irInfoRow('Function:', 'paintImage()'),
        irInfoRow('Parameter:', 'repeat: ImageRepeat'),
        irInfoRow('Default:', 'ImageRepeat.noRepeat'),
        irInfoRow('Used by:', 'DecorationImagePainter'),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F0EB),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'paintImage(\n'
            '  canvas: canvas,\n'
            '  rect: Offset.zero & size,\n'
            '  image: myImage,\n'
            '  repeat: ImageRepeat.repeat,\n'
            '  scale: 1.0,\n'
            ')',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                color: Color(0xFF6B3A2A)),
          ),
        ),
      ],
    ),
  );

  // ── Section 8: Comparison Table ──────────────────────────────
  print('\n[8] Comparison Table');
  print('  Mode      | Tiles | Direction  | Use Case');
  print('  repeat    | Many  | X + Y      | Patterns');
  print('  repeatX   | Row   | X          | Borders');
  print('  repeatY   | Col   | Y          | Sidebars');
  print('  noRepeat  | One   | None       | Centered');

  final irCompRows = <Map<String, String>>[
    {'mode': 'repeat', 'tiles': 'Many', 'dir': 'X + Y', 'use': 'Wallpaper / Patterns'},
    {'mode': 'repeatX', 'tiles': 'Row', 'dir': 'Horizontal', 'use': 'Borders / Dividers'},
    {'mode': 'repeatY', 'tiles': 'Column', 'dir': 'Vertical', 'use': 'Sidebars / Edges'},
    {'mode': 'noRepeat', 'tiles': 'Single', 'dir': 'None', 'use': 'Centered / Logo'},
  ];

  final irCompTable = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 70.0,
                child: Text('Mode', style: TextStyle(fontWeight: FontWeight.w700,
                    fontSize: 11.0, color: Color(0xFF6B3A2A)))),
            SizedBox(width: 50.0,
                child: Text('Tiles', style: TextStyle(fontWeight: FontWeight.w700,
                    fontSize: 11.0, color: Color(0xFF6B3A2A)))),
            SizedBox(width: 70.0,
                child: Text('Direction', style: TextStyle(fontWeight: FontWeight.w700,
                    fontSize: 11.0, color: Color(0xFF6B3A2A)))),
            Expanded(
                child: Text('Use Case', style: TextStyle(fontWeight: FontWeight.w700,
                    fontSize: 11.0, color: Color(0xFF6B3A2A)))),
          ],
        ),
        Divider(color: Color(0xFFD2B48C)),
        ...irCompRows.map((r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              SizedBox(width: 70.0,
                  child: Text(r['mode']!,
                      style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                          color: Color(0xFFA0522D)))),
              SizedBox(width: 50.0,
                  child: Text(r['tiles']!,
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF5D4037)))),
              SizedBox(width: 70.0,
                  child: Text(r['dir']!,
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF5D4037)))),
              Expanded(
                  child: Text(r['use']!,
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF5D4037)))),
            ],
          ),
        )),
      ],
    ),
  );

  // ── Section 9: Practical Use Cases ───────────────────────────
  print('\n[9] Practical Use Cases');
  print('  Background wallpaper: repeat');
  print('  Top/bottom border: repeatX');
  print('  Side decoration: repeatY');
  print('  Hero image: noRepeat');
  print('  Watermark overlay: repeat + low opacity');
  print('  Texture fill: repeat');

  final irUseCases = <Map<String, dynamic>>[
    {'title': 'Wallpaper Background', 'icon': Icons.wallpaper,
     'mode': 'repeat', 'desc': 'Seamless tile pattern covers entire area'},
    {'title': 'Horizontal Border', 'icon': Icons.border_top,
     'mode': 'repeatX', 'desc': 'Decorative strip along top or bottom edge'},
    {'title': 'Sidebar Texture', 'icon': Icons.border_left,
     'mode': 'repeatY', 'desc': 'Vertical pattern along left/right edge'},
    {'title': 'Centered Logo', 'icon': Icons.center_focus_strong,
     'mode': 'noRepeat', 'desc': 'Single image placed by alignment rule'},
    {'title': 'Watermark Layer', 'icon': Icons.branding_watermark,
     'mode': 'repeat', 'desc': 'Semi-transparent overlay tiled everywhere'},
    {'title': 'Texture Fill', 'icon': Icons.texture,
     'mode': 'repeat', 'desc': 'Paper, fabric, or noise texture background'},
  ];

  final irUseCaseSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF0E6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: irUseCases.map((uc) {
        return Container(
          width: 155.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFD2B48C).withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(uc['icon'] as IconData, color: Color(0xFFA0522D), size: 16.0),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: Text(uc['title'] as String,
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                            color: Color(0xFF6B3A2A))),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              irChip(uc['mode'] as String, Color(0xFFA0522D)),
              SizedBox(height: 4.0),
              Text(uc['desc'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF5D4037))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 10: Alignment Interaction ────────────────────────
  print('\n[10] Alignment Interaction');
  print('  DecorationImage.alignment sets tile origin');
  print('  repeat + center: tiles outward from center');
  print('  repeat + topLeft: tiles from top-left corner');
  print('  noRepeat + alignment: positions single image');

  final alignments = <Map<String, dynamic>>[
    {'name': 'topLeft', 'align': Alignment.topLeft},
    {'name': 'center', 'align': Alignment.center},
    {'name': 'bottomRight', 'align': Alignment.bottomRight},
  ];

  final irAlignSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Alignment affects where tiling starts',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8B6914))),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: alignments.map((a) {
            return Container(
              width: 100.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: Color(0xFFFFEDD5),
                border: Border.all(color: Color(0xFFA0522D)),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: a['align'] as Alignment,
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFA0522D),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Icon(Icons.radio_button_checked,
                          size: 14.0, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    bottom: 2.0,
                    left: 0.0,
                    right: 0.0,
                    child: Text(a['name'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9.0, color: Color(0xFF6B3A2A))),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );

  // ── Section 11: Switch Pattern ───────────────────────────────
  print('\n[11] Switch Pattern');
  final testMode = ImageRepeat.repeatX;
  switch (testMode) {
    case ImageRepeat.repeat:
      print('  → Tiling in both X and Y');
    case ImageRepeat.repeatX:
      print('  → Tiling in X only');
    case ImageRepeat.repeatY:
      print('  → Tiling in Y only');
    case ImageRepeat.noRepeat:
      print('  → No tiling');
  }

  final irSwitchSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF0E6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dart 3 Switch Expression',
            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                color: Color(0xFF6B3A2A))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F0EB),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'final desc = switch (mode) {\n'
            '  ImageRepeat.repeat   => "X+Y",\n'
            '  ImageRepeat.repeatX  => "X only",\n'
            '  ImageRepeat.repeatY  => "Y only",\n'
            '  ImageRepeat.noRepeat => "none",\n'
            '};',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                color: Color(0xFF6B3A2A)),
          ),
        ),
        SizedBox(height: 8.0),
        ...ImageRepeat.values.map((v) {
          final desc = switch (v) {
            ImageRepeat.repeat => 'Tiles X+Y',
            ImageRepeat.repeatX => 'Tiles X only',
            ImageRepeat.repeatY => 'Tiles Y only',
            ImageRepeat.noRepeat => 'No tiling',
          };
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Icon(Icons.arrow_right, color: Color(0xFFA0522D), size: 16.0),
                Text('${v.name} → $desc',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF5D4037))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 12: Cross-Mode Grid ──────────────────────────────
  print('\n[12] Cross-Mode Grid');
  print('  Comparing all modes in a grid layout');

  final irGridSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(child: irTilePreview(ImageRepeat.repeat, Color(0xFFFFEDD5), 'repeat')),
            SizedBox(width: 8.0),
            Expanded(child: irTilePreview(ImageRepeat.repeatX, Color(0xFFE8F5E9), 'repeatX')),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(child: irTilePreview(ImageRepeat.repeatY, Color(0xFFE3F2FD), 'repeatY')),
            SizedBox(width: 8.0),
            Expanded(child: irTilePreview(ImageRepeat.noRepeat, Color(0xFFFCE4EC), 'noRepeat')),
          ],
        ),
      ],
    ),
  );

  // ── Section 13: Equality & Hashing ───────────────────────────
  print('\n[13] Equality & Hashing');
  print('  repeat == repeat: ${ImageRepeat.repeat == ImageRepeat.repeat}');
  print('  repeat == noRepeat: ${ImageRepeat.repeat == ImageRepeat.noRepeat}');
  print('  hashCode repeat: ${ImageRepeat.repeat.hashCode}');
  print('  hashCode noRepeat: ${ImageRepeat.noRepeat.hashCode}');

  final irEqualitySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF0E6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        irInfoRow('repeat == repeat:', '${ImageRepeat.repeat == ImageRepeat.repeat}'),
        irInfoRow('repeat == noRepeat:', '${ImageRepeat.repeat == ImageRepeat.noRepeat}'),
        irInfoRow('hashCode repeat:', '${ImageRepeat.repeat.hashCode}'),
        irInfoRow('hashCode noRepeat:', '${ImageRepeat.noRepeat.hashCode}'),
        SizedBox(height: 6.0),
        Divider(color: Color(0xFFD2B48C)),
        SizedBox(height: 4.0),
        Text('All ImageRepeat values in a Set:',
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                color: Color(0xFF6B3A2A))),
        SizedBox(height: 4.0),
        Wrap(
          spacing: 6.0,
          children: ImageRepeat.values
              .toSet()
              .map((v) => irChip(v.name, Color(0xFF8B4513)))
              .toList(),
        ),
      ],
    ),
  );

  // ── Section 14: Common Code Patterns ─────────────────────────
  print('\n[14] Common Code Patterns');
  print('  Pattern 1: Background tile');
  print('  Pattern 2: Conditional repeat');
  print('  Pattern 3: Repeat with opacity');

  final irPatterns = <Map<String, String>>[
    {'title': 'Background Tile Pattern',
     'code': 'Container(\n'
         '  decoration: BoxDecoration(\n'
         '    image: DecorationImage(\n'
         '      image: AssetImage("tile.png"),\n'
         '      repeat: ImageRepeat.repeat,\n'
         '    ),\n'
         '  ),\n'
         ')'},
    {'title': 'Conditional Mode Selection',
     'code': 'final mode = isFullTile\n'
         '    ? ImageRepeat.repeat\n'
         '    : isHorizontal\n'
         '        ? ImageRepeat.repeatX\n'
         '        : ImageRepeat.noRepeat;'},
    {'title': 'Opacity + Repeat Combo',
     'code': 'DecorationImage(\n'
         '  image: AssetImage("watermark.png"),\n'
         '  repeat: ImageRepeat.repeat,\n'
         '  opacity: 0.15,\n'
         ')'},
  ];

  final irPatternsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      children: irPatterns.map((p) {
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
                      color: Color(0xFFA0522D))),
              SizedBox(height: 6.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F0EB),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(p['code']!,
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                        color: Color(0xFF6B3A2A))),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 15: When to Use Each ─────────────────────────────
  print('\n[15] When to Use Each');
  print('  repeat: Wallpapers, textures, seamless patterns');
  print('  repeatX: Horizontal dividers, header/footer strips');
  print('  repeatY: Vertical sidebars, page edges');
  print('  noRepeat: Logos, hero images, single-placement');

  final irWhenData = <Map<String, dynamic>>[
    {'mode': 'repeat', 'icon': Icons.grid_4x4, 'color': Color(0xFFA0522D),
     'when': 'Wallpapers, textures, seamless patterns, watermarks'},
    {'mode': 'repeatX', 'icon': Icons.view_column, 'color': Color(0xFFD2691E),
     'when': 'Horizontal dividers, header/footer strips, top borders'},
    {'mode': 'repeatY', 'icon': Icons.view_stream, 'color': Color(0xFF8B6914),
     'when': 'Vertical sidebars, page edges, side decorations'},
    {'mode': 'noRepeat', 'icon': Icons.crop_square, 'color': Color(0xFF6B3A2A),
     'when': 'Logos, hero images, centered photos, single placement'},
  ];

  final irWhenSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAF0E6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFD2B48C)),
    ),
    child: Column(
      children: irWhenData.map((w) {
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
                        style: TextStyle(fontSize: 11.0, color: Color(0xFF5D4037))),
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
  print('  Total values: ${ImageRepeat.values.length}');
  print('  Default: noRepeat');
  print('  Most common: repeat (for patterns)');
  print('  Used in: DecorationImage, paintImage');

  final irSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF8B4513), Color(0xFFA0522D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('ImageRepeat Dashboard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('${ImageRepeat.values.length}',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,
                        color: Color(0xFFFFE0C0))),
                Text('Values', style: TextStyle(fontSize: 11.0, color: Color(0xFFD2B48C))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.crop_square, color: Color(0xFFFFE0C0), size: 28.0),
                Text('Default: noRepeat',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFFD2B48C))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.grid_4x4, color: Color(0xFFFFE0C0), size: 28.0),
                Text('Most Used: repeat',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFFD2B48C))),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 4.0,
          alignment: WrapAlignment.center,
          children: ImageRepeat.values
              .map((v) => irChip(v.name, Color(0xFFD2691E)))
              .toList(),
        ),
      ],
    ),
  );

  print('\nImageRepeat Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        irTitleSection,
        SizedBox(height: 16.0),
        // 2 Four Values
        irSectionHeader('The Four Tiling Modes', Icons.style),
        irFourValues,
        // 3 Tile Gallery
        irSectionHeader('Tiling Visualization', Icons.grid_on),
        irTileGallery,
        // 4 Axis Coverage
        irSectionHeader('Axis Coverage Matrix', Icons.table_chart),
        irAxisSection,
        // 5 DecorationImage
        irSectionHeader('DecorationImage Usage', Icons.image),
        irDecoSection,
        // 6 Container Size
        irSectionHeader('Container Size Effects', Icons.crop_free),
        irContainerSection,
        // 7 paintImage
        irSectionHeader('paintImage Function', Icons.brush),
        irPaintSection,
        // 8 Comparison
        irSectionHeader('Mode Comparison', Icons.compare),
        irCompTable,
        // 9 Use Cases
        irSectionHeader('Practical Use Cases', Icons.auto_awesome),
        irUseCaseSection,
        // 10 Alignment
        irSectionHeader('Alignment Interaction', Icons.align_horizontal_center),
        irAlignSection,
        // 11 Switch
        irSectionHeader('Switch Pattern', Icons.alt_route),
        irSwitchSection,
        // 12 Grid
        irSectionHeader('Cross-Mode Grid', Icons.grid_view),
        irGridSection,
        // 13 Equality
        irSectionHeader('Equality & Hashing', Icons.check_circle_outline),
        irEqualitySection,
        // 14 Patterns
        irSectionHeader('Common Code Patterns', Icons.code),
        irPatternsSection,
        // 15 When to Use
        irSectionHeader('When to Use Each', Icons.lightbulb_outline),
        irWhenSection,
        // 16 Summary
        SizedBox(height: 8.0),
        irSummarySection,
      ],
    ),
  );
}
