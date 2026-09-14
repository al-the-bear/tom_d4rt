// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawMagnifier
// Demonstrates the RawMagnifier widget — a low-level magnification overlay
// that enlarges the content behind it. Used for text selection loupe,
// image inspection, and any scenario needing magnified content views.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawMagnifier Deep Demo executing');

  // ============================================================
  // SECTION 1: What RawMagnifier Is — Concept
  // ============================================================
  print('=== Section 1: RawMagnifier Concept ===');

  // RawMagnifier is a widget that clips its child to a given shape
  // and applies a magnification transform to the underlying content.
  // It uses BackdropFilter-like compositing to magnify what is
  // rendered behind it in the layer tree.
  //
  // Key parameters:
  //   - size: the dimensions of the magnifier lens
  //   - magnificationScale: the zoom factor (1.0 = no zoom)
  //   - focalPointOffset: shifts the magnified area
  //   - decoration: MagnifierDecoration for shape/shadow/border
  //   - child: optional content rendered on top of the magnified view
  //
  // RawMagnifier is the building block for the higher-level
  // Magnifier widget and for CupertinoTextMagnifier.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.search, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RawMagnifier',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'extends SingleChildRenderObjectWidget',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'A low-level widget that displays a magnified view of '
            'the content behind it. The magnifier clips to a shape '
            'defined by MagnifierDecoration and applies a scale '
            'transform to enlarge the underlying layer content. '
            'Used by the framework for text selection loupes and '
            'available for custom magnification UIs.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildConceptChip('Magnification', Icons.zoom_in, Color(0xFF42A5F5)),
            _buildConceptChip('Clipping', Icons.crop, Color(0xFF66BB6A)),
            _buildConceptChip('Compositing', Icons.layers, Color(0xFFFFA726)),
          ],
        ),
      ],
    ),
  );

  print('  Concept card built');

  // ============================================================
  // SECTION 2: Basic RawMagnifier Instances
  // ============================================================
  print('=== Section 2: Basic RawMagnifier ===');

  // A basic RawMagnifier with different sizes
  // Note: RawMagnifier works through compositing layers, so it
  // magnifies the content rendered BEHIND it in the layer tree.
  // Here we show the widget structure with placeholder content.

  final smallMagnifier = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF42A5F5)),
    ),
    child: Column(
      children: [
        Text(
          'Small Magnifier',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
          ),
        ),
        SizedBox(height: 8.0),
        RawMagnifier(
          decoration: MagnifierDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
          magnificationScale: 1.5,
          size: Size(80.0, 80.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Size: 80x80, Scale: 1.5x',
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Color(0xFF616161),
          ),
        ),
      ],
    ),
  );

  final mediumMagnifier = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF66BB6A)),
    ),
    child: Column(
      children: [
        Text(
          'Medium Magnifier',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        SizedBox(height: 8.0),
        RawMagnifier(
          decoration: MagnifierDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0),
            ),
          ),
          magnificationScale: 2.0,
          size: Size(120.0, 120.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Size: 120x120, Scale: 2.0x',
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Color(0xFF616161),
          ),
        ),
      ],
    ),
  );

  final largeMagnifier = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFA726)),
    ),
    child: Column(
      children: [
        Text(
          'Large Magnifier',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        SizedBox(height: 8.0),
        RawMagnifier(
          decoration: MagnifierDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ),
          ),
          magnificationScale: 2.5,
          size: Size(160.0, 160.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Size: 160x160, Scale: 2.5x',
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Color(0xFF616161),
          ),
        ),
      ],
    ),
  );

  final basicSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader('Basic RawMagnifier Instances', Icons.search),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'RawMagnifier creates a magnifying lens that enlarges '
            'content behind it. The size parameter controls the '
            'lens dimensions, and magnificationScale controls the '
            'zoom factor. The lens shape comes from MagnifierDecoration.',
            style: TextStyle(fontSize: 12.5, color: Color(0xFF424242), height: 1.5),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: smallMagnifier),
            SizedBox(width: 8.0),
            Expanded(child: mediumMagnifier),
          ],
        ),
        SizedBox(height: 8.0),
        largeMagnifier,
      ],
    ),
  );

  print('  Basic magnifier section built with 3 sizes');

  // ============================================================
  // SECTION 3: Magnification Scale
  // ============================================================
  print('=== Section 3: Magnification Scale ===');

  // The magnificationScale determines how much the content is
  // enlarged. 1.0 means no magnification (same size as original).
  // Values > 1.0 zoom in, making content appear larger.

  final scales = <Map<String, dynamic>>[
    {'scale': 1.0, 'label': '1.0x', 'desc': 'No zoom', 'color': Color(0xFF9E9E9E)},
    {'scale': 1.25, 'label': '1.25x', 'desc': 'Slight zoom', 'color': Color(0xFF42A5F5)},
    {'scale': 1.5, 'label': '1.5x', 'desc': 'Moderate zoom', 'color': Color(0xFF66BB6A)},
    {'scale': 2.0, 'label': '2.0x', 'desc': 'Double zoom', 'color': Color(0xFFFFA726)},
    {'scale': 3.0, 'label': '3.0x', 'desc': 'Triple zoom', 'color': Color(0xFFEF5350)},
  ];

  final scaleCards = Column(
    children: scales.map((entry) {
      final color = entry['color'] as Color;
      final scale = entry['scale'] as double;
      return Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            RawMagnifier(
              decoration: MagnifierDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              magnificationScale: scale,
              size: Size(60.0, 60.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          entry['label'] as String,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            color: color,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        entry['desc'] as String,
                        style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  // Visual zoom bar
                  Container(
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (scale / 3.0).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );

  final scaleSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader('Magnification Scale', Icons.zoom_in),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'magnificationScale controls the zoom factor. A value '
            'of 1.0 means no magnification. Values greater than 1.0 '
            'zoom into the content, making it appear larger. The '
            'scale is applied as a transform on the underlying '
            'compositing layer.',
            style: TextStyle(fontSize: 12.5, color: Color(0xFF424242), height: 1.5),
          ),
        ),
        SizedBox(height: 12.0),
        scaleCards,
      ],
    ),
  );

  print('  Scale section built with ${scales.length} examples');

  // ============================================================
  // SECTION 4: Focal Point Offset
  // ============================================================
  print('=== Section 4: Focal Point Offset ===');

  // focalPointOffset shifts the center of magnification relative
  // to the magnifier's position. By default (Offset.zero), the
  // magnifier shows content directly behind it.
  //
  // A positive dx shifts the focal point to the right (magnifier
  // shows content from further right), and a positive dy shifts
  // it downward.

  final offsets = <Map<String, dynamic>>[
    {'offset': Offset.zero, 'label': 'Offset.zero', 'desc': 'Center (default)'},
    {'offset': Offset(20.0, 0.0), 'label': 'Offset(20, 0)', 'desc': 'Right shift'},
    {'offset': Offset(-20.0, 0.0), 'label': 'Offset(-20, 0)', 'desc': 'Left shift'},
    {'offset': Offset(0.0, 20.0), 'label': 'Offset(0, 20)', 'desc': 'Down shift'},
    {'offset': Offset(0.0, -20.0), 'label': 'Offset(0, -20)', 'desc': 'Up shift'},
    {'offset': Offset(15.0, 15.0), 'label': 'Offset(15, 15)', 'desc': 'Diagonal'},
  ];

  final offsetCards = Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    children: offsets.map((entry) {
      final offset = entry['offset'] as Offset;
      return Container(
        width: 150.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFFCE93D8)),
        ),
        child: Column(
          children: [
            RawMagnifier(
              decoration: MagnifierDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              focalPointOffset: offset,
              magnificationScale: 1.5,
              size: Size(50.0, 50.0),
            ),
            SizedBox(height: 8.0),
            Text(
              entry['label'] as String,
              style: TextStyle(
                fontSize: 9.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
            Text(
              entry['desc'] as String,
              style: TextStyle(fontSize: 10.0, color: Color(0xFF757575)),
            ),
          ],
        ),
      );
    }).toList(),
  );

  // Focal point diagram
  final focalDiagram = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF9C27B0)),
    ),
    child: Column(
      children: [
        Text(
          'How Focal Point Offset Works',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFE1BEE7),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF7B1FA2), width: 2.0),
                    ),
                    child: Center(
                      child: Icon(Icons.my_location, color: Color(0xFF7B1FA2)),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Magnifier position',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF6A1B9A)),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward, color: Color(0xFF9C27B0), size: 24.0),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFCE93D8),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF4A148C), width: 2.0),
                    ),
                    child: Center(
                      child: Icon(Icons.center_focus_strong, color: Color(0xFF4A148C)),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Focal point\n(shifted by offset)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF6A1B9A)),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'The offset moves WHAT the magnifier shows, not WHERE '
          'the magnifier is. A positive dx=20 means the magnified '
          'content comes from 20 pixels to the right of the '
          'magnifier center.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11.0, color: Color(0xFF4A148C), height: 1.4),
        ),
      ],
    ),
  );

  final focalSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader('Focal Point Offset', Icons.my_location),
        SizedBox(height: 12.0),
        offsetCards,
        SizedBox(height: 14.0),
        focalDiagram,
      ],
    ),
  );

  print('  Focal point section built with ${offsets.length} offsets');

  // ============================================================
  // SECTION 5: MagnifierDecoration
  // ============================================================
  print('=== Section 5: MagnifierDecoration ===');

  // MagnifierDecoration controls the visual appearance of the
  // magnifier lens: its shape, shadow, and opacity.
  //
  // Properties:
  //   - shape: ShapeBorder (default is RoundedRectangleBorder)
  //   - shadows: List<BoxShadow> for drop shadows
  //   - opacity: double (0.0 to 1.0)

  // Circular decoration
  final circularMag = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        RawMagnifier(
          decoration: MagnifierDecoration(
            shape: CircleBorder(
              side: BorderSide(color: Color(0xFF1565C0), width: 3.0),
            ),
            shadows: <BoxShadow>[
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.4),
                blurRadius: 8.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          magnificationScale: 1.5,
          size: Size(90.0, 90.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Circle shape',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
          ),
        ),
        Text(
          'CircleBorder + shadow',
          style: TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
        ),
      ],
    ),
  );

  // Rounded rectangle decoration
  final roundedMag = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        RawMagnifier(
          decoration: MagnifierDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(color: Color(0xFF2E7D32), width: 2.0),
            ),
            shadows: <BoxShadow>[
              BoxShadow(
                color: Colors.green.withValues(alpha: 0.3),
                blurRadius: 10.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          magnificationScale: 2.0,
          size: Size(120.0, 80.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Rounded Rectangle',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        Text(
          'RoundedRectangleBorder(16)',
          style: TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
        ),
      ],
    ),
  );

  // Stadium (pill) decoration
  final stadiumMag = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        RawMagnifier(
          decoration: MagnifierDecoration(
            shape: StadiumBorder(
              side: BorderSide(color: Color(0xFFE65100), width: 2.0),
            ),
            shadows: <BoxShadow>[
              BoxShadow(
                color: Colors.orange.withValues(alpha: 0.3),
                blurRadius: 6.0,
              ),
            ],
          ),
          magnificationScale: 1.8,
          size: Size(140.0, 60.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Stadium (Pill)',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        Text(
          'StadiumBorder + shadow',
          style: TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
        ),
      ],
    ),
  );

  // No border, heavy shadow
  final shadowMag = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        RawMagnifier(
          decoration: MagnifierDecoration(
            shape: CircleBorder(),
            shadows: <BoxShadow>[
              BoxShadow(
                color: Colors.purple.withValues(alpha: 0.5),
                blurRadius: 16.0,
                spreadRadius: 4.0,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          magnificationScale: 2.5,
          size: Size(100.0, 100.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Heavy Shadows',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
        Text(
          'Multiple BoxShadows',
          style: TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
        ),
      ],
    ),
  );

  final decorationSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader('MagnifierDecoration', Icons.brush),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'MagnifierDecoration controls the visual appearance of '
            'the magnifier lens. It defines the shape (via ShapeBorder), '
            'drop shadows (via BoxShadow list), and opacity. The shape '
            'clips the magnified content to the specified boundary.',
            style: TextStyle(fontSize: 12.5, color: Color(0xFF424242), height: 1.5),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: circularMag),
            SizedBox(width: 8.0),
            Expanded(child: roundedMag),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: stadiumMag),
            SizedBox(width: 8.0),
            Expanded(child: shadowMag),
          ],
        ),
      ],
    ),
  );

  print('  Decoration section built with 4 variations');

  // ============================================================
  // SECTION 6: Size Configurations
  // ============================================================
  print('=== Section 6: Size Configurations ===');

  // The size parameter determines the magnifier lens dimensions.
  // Different aspect ratios create different visual effects:
  //   - Square: equal width/height, classic loupe
  //   - Wide: horizontal strip, good for text lines
  //   - Tall: vertical strip, good for column inspection

  final sizeConfigs = <Map<String, dynamic>>[
    {
      'size': Size(60.0, 60.0),
      'label': '60x60 (Square)',
      'useCase': 'Icon/detail inspection',
      'color': Color(0xFF42A5F5),
    },
    {
      'size': Size(160.0, 50.0),
      'label': '160x50 (Wide)',
      'useCase': 'Text line magnification',
      'color': Color(0xFF66BB6A),
    },
    {
      'size': Size(50.0, 120.0),
      'label': '50x120 (Tall)',
      'useCase': 'Column/list inspection',
      'color': Color(0xFFFFA726),
    },
    {
      'size': Size(200.0, 100.0),
      'label': '200x100 (Landscape)',
      'useCase': 'Image preview/cropping',
      'color': Color(0xFFAB47BC),
    },
  ];

  final sizeCards = Column(
    children: sizeConfigs.map((cfg) {
      final size = cfg['size'] as Size;
      final color = cfg['color'] as Color;
      return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            RawMagnifier(
              decoration: MagnifierDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: color, width: 1.5),
                ),
              ),
              magnificationScale: 1.5,
              size: size,
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cfg['label'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    cfg['useCase'] as String,
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF757575)),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Width: ${size.width}, Height: ${size.height}',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );

  final sizeSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader('Size Configurations', Icons.aspect_ratio),
        SizedBox(height: 12.0),
        sizeCards,
      ],
    ),
  );

  print('  Size section built with ${sizeConfigs.length} configurations');

  // ============================================================
  // SECTION 7: Text Selection Use Case
  // ============================================================
  print('=== Section 7: Text Selection Use Case ===');

  // The primary framework use case for RawMagnifier is text
  // selection on mobile devices. When the user long-presses
  // on text, a magnifier appears to help position the cursor
  // precisely. The framework implementations are:
  //
  //   - CupertinoTextMagnifier (iOS style)
  //   - Material Magnifier (Material/Android style)
  //
  // Both are built on top of RawMagnifier with specific
  // decorations and behaviors for their platforms.

  final textSelectionDiagram = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Text Selection Magnifier',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Simulated text area with magnifier indicator
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The quick brown fox jumps over the lazy dog.',
                style: TextStyle(fontSize: 14.0, color: Color(0xFF212121)),
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Text(
                    'Selection ca',
                    style: TextStyle(fontSize: 14.0, color: Color(0xFF212121)),
                  ),
                  Container(
                    width: 2.0,
                    height: 18.0,
                    color: Color(0xFF1565C0),
                  ),
                  Text(
                    'ret here.',
                    style: TextStyle(fontSize: 14.0, color: Color(0xFF212121)),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Icon(Icons.arrow_upward, color: Colors.white54, size: 20.0),
        SizedBox(height: 4.0),
        RawMagnifier(
          decoration: MagnifierDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(color: Colors.white, width: 2.0),
            ),
            shadows: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          magnificationScale: 1.5,
          size: Size(80.0, 80.0),
          focalPointOffset: Offset(0.0, -60.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Magnifier appears above the cursor during text selection, '
          'with focalPointOffset pointing down to the cursor position.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11.0, color: Colors.white70, height: 1.4),
        ),
      ],
    ),
  );

  // Platform implementations
  final platformRow = Row(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFF616161)),
          ),
          child: Column(
            children: [
              Icon(Icons.android, color: Color(0xFF4CAF50), size: 28.0),
              SizedBox(height: 6.0),
              Text(
                'Material Magnifier',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Rounded rectangle shape, subtle shadow',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0, color: Color(0xFF757575)),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFF616161)),
          ),
          child: Column(
            children: [
              Icon(Icons.apple, color: Color(0xFF424242), size: 28.0),
              SizedBox(height: 6.0),
              Text(
                'Cupertino Magnifier',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Circle shape, heavier border, iOS styling',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0, color: Color(0xFF757575)),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  final textSelectionSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader('Text Selection Use Case', Icons.text_fields),
        SizedBox(height: 12.0),
        textSelectionDiagram,
        SizedBox(height: 12.0),
        platformRow,
      ],
    ),
  );

  print('  Text selection section built');

  // ============================================================
  // SECTION 8: API Property Reference
  // ============================================================
  print('=== Section 8: API Property Reference ===');

  final apiProps = <Map<String, String>>[
    {
      'name': 'size',
      'type': 'Size',
      'required': 'Yes',
      'desc': 'The width and height of the magnifier lens viewport.',
    },
    {
      'name': 'magnificationScale',
      'type': 'double',
      'required': 'No (1.0)',
      'desc': 'The zoom factor applied to the magnified content.',
    },
    {
      'name': 'focalPointOffset',
      'type': 'Offset',
      'required': 'No (Offset.zero)',
      'desc': 'Shifts the center of magnification relative to the magnifier position.',
    },
    {
      'name': 'decoration',
      'type': 'MagnifierDecoration',
      'required': 'No',
      'desc': 'Defines the shape, shadows, and opacity of the magnifier lens.',
    },
    {
      'name': 'child',
      'type': 'Widget?',
      'required': 'No',
      'desc': 'Optional content rendered on top of the magnified view.',
    },
  ];

  final apiCards = Column(
    children: apiProps.map((prop) {
      return Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildApiTag(prop['name']!, Color(0xFF1565C0), Color(0xFFE3F2FD)),
                SizedBox(width: 8.0),
                _buildApiTag(prop['type']!, Color(0xFFC62828), Color(0xFFFCE4EC)),
                Spacer(),
                _buildApiTag(
                  prop['required']!,
                  prop['required']!.startsWith('Yes')
                      ? Color(0xFF2E7D32)
                      : Color(0xFFF57F17),
                  prop['required']!.startsWith('Yes')
                      ? Color(0xFFE8F5E9)
                      : Color(0xFFFFF8E1),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              prop['desc']!,
              style: TextStyle(fontSize: 11.0, color: Color(0xFF616161), height: 1.4),
            ),
          ],
        ),
      );
    }).toList(),
  );

  // MagnifierDecoration sub-properties
  final decorationProps = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MagnifierDecoration Properties',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
        SizedBox(height: 10.0),
        _buildDecorationProp('shape', 'ShapeBorder', 'Defines the clip shape of the magnifier'),
        SizedBox(height: 6.0),
        _buildDecorationProp('shadows', 'List<BoxShadow>', 'Drop shadow effects around the lens'),
        SizedBox(height: 6.0),
        _buildDecorationProp('opacity', 'double', 'Overall opacity of the magnifier (0.0 to 1.0)'),
      ],
    ),
  );

  final apiSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader('API Property Reference', Icons.menu_book),
        SizedBox(height: 12.0),
        apiCards,
        SizedBox(height: 12.0),
        decorationProps,
      ],
    ),
  );

  print('  API section built with ${apiProps.length} properties');

  // ============================================================
  // SECTION 9: RawMagnifier vs Magnifier Comparison
  // ============================================================
  print('=== Section 9: RawMagnifier vs Magnifier ===');

  final comparisonRows = <Map<String, String>>[
    {
      'aspect': 'Level',
      'raw': 'Low-level / Raw',
      'magnifier': 'High-level / Styled',
    },
    {
      'aspect': 'Decoration',
      'raw': 'Fully custom',
      'magnifier': 'Pre-configured Material',
    },
    {
      'aspect': 'Defaults',
      'raw': 'No defaults (explicit)',
      'magnifier': 'Material Design defaults',
    },
    {
      'aspect': 'Use Case',
      'raw': 'Custom magnification UIs',
      'magnifier': 'Material text selection',
    },
    {
      'aspect': 'Shadows',
      'raw': 'Via MagnifierDecoration',
      'magnifier': 'Built-in Material shadow',
    },
    {
      'aspect': 'Shape',
      'raw': 'Any ShapeBorder',
      'magnifier': 'RoundedRectangle (fixed)',
    },
  ];

  final comparisonTable = Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Color(0xFF37474F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Aspect',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'RawMagnifier',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF90CAF9),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'Magnifier',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA5D6A7),
                ),
              ),
            ),
          ],
        ),
      ),
      ...comparisonRows.map((row) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(0xFFEEEEEE), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                row['aspect']!,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                row['raw']!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0, color: Color(0xFF1565C0)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                row['magnifier']!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0, color: Color(0xFF2E7D32)),
              ),
            ),
          ],
        ),
      )),
    ],
  );

  final comparisonSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader('RawMagnifier vs Magnifier', Icons.compare_arrows),
        SizedBox(height: 12.0),
        comparisonTable,
      ],
    ),
  );

  print('  Comparison section built with ${comparisonRows.length} rows');

  // ============================================================
  // Build final scrollable layout
  // ============================================================
  print('Building final layout with all 9 sections');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          color: Color(0xFF0D47A1),
          child: Column(
            children: [
              Text(
                'RawMagnifier',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Deep Demo — Low-Level Magnification Widget',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        conceptCard,
        basicSection,
        scaleSection,
        focalSection,
        decorationSection,
        sizeSection,
        textSelectionSection,
        apiSection,
        comparisonSection,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ============================================================
// Helper Functions
// ============================================================

Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Color(0xFF0D47A1),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildConceptChip(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14.0),
        SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildApiTag(String text, Color textColor, Color bgColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
        color: textColor,
      ),
    ),
  );
}

Widget _buildDecorationProp(String name, String type, String desc) {
  return Row(
    children: [
      Container(
        width: 60.0,
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: Color(0xFFE1BEE7),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: Color(0xFF4A148C),
          ),
        ),
      ),
      SizedBox(width: 8.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: Color(0xFFF3E5F5),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 9.0,
            fontFamily: 'monospace',
            color: Color(0xFF7B1FA2),
          ),
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Text(
          desc,
          style: TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
        ),
      ),
    ],
  );
}
