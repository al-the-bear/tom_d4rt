// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: RenderDarwinPlatformView concepts visualization
// Demonstrates native macOS/iOS platform view embedding concepts
// including composition layers, hit testing, sizing modes, and lifecycle
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderDarwinPlatformView demo: building visualization');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(),
        _buildSectionTitle('1. Native macOS View Placeholders'),
        _buildNativeViewPlaceholders(),
        _buildSectionTitle('2. Platform View Composition Layers'),
        _buildCompositionLayers(),
        _buildSectionTitle('3. Hit Test Passthrough Behavior'),
        _buildHitTestPassthrough(),
        _buildSectionTitle('4. Platform View Sizing Modes'),
        _buildSizingModes(),
        _buildSectionTitle('5. Flutter Painting Pipeline Interaction'),
        _buildPaintingPipelineInteraction(),
        _buildSectionTitle('6. Gesture Disambiguation Areas'),
        _buildGestureDisambiguation(),
        _buildSectionTitle('7. Platform View Lifecycle Stages'),
        _buildLifecycleStages(),
        _buildSectionTitle('8. AppKitView vs UiKitView Rendering'),
        _buildAppKitVsUiKitComparison(),
        SizedBox(height: 32),
      ],
    ),
  );
}

Widget _buildHeader() {
  print('RenderDarwinPlatformView demo: rendering header');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF0D47A1), Color(0xFF01579B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RenderDarwinPlatformView',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Native macOS/iOS view embedding in Flutter render pipeline',
          style: TextStyle(fontSize: 14, color: Color(0xFFBBDEFB)),
        ),
        SizedBox(height: 4),
        Text(
          'Composition, hit testing, sizing, and lifecycle visualization',
          style: TextStyle(fontSize: 12, color: Color(0xFF90CAF9)),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  print('RenderDarwinPlatformView demo: section - $title');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 20),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF37474F)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF80CBC4),
      ),
    ),
  );
}

// Section 1: Native macOS view placeholders
Widget _buildNativeViewPlaceholders() {
  print('RenderDarwinPlatformView demo: native view placeholders');

  List<Map<String, dynamic>> nativeViews = [
    {
      'name': 'NSView',
      'desc': 'Base macOS view class',
      'color': Color(0xFF1565C0),
      'icon': Icons.crop_square,
      'width': 180.0,
      'height': 120.0,
    },
    {
      'name': 'NSTextField',
      'desc': 'Native text input field',
      'color': Color(0xFF2E7D32),
      'icon': Icons.text_fields,
      'width': 200.0,
      'height': 48.0,
    },
    {
      'name': 'NSButton',
      'desc': 'Native push button control',
      'color': Color(0xFF6A1B9A),
      'icon': Icons.smart_button,
      'width': 140.0,
      'height': 36.0,
    },
    {
      'name': 'NSSlider',
      'desc': 'Native slider control',
      'color': Color(0xFFE65100),
      'icon': Icons.tune,
      'width': 220.0,
      'height': 32.0,
    },
  ];

  print('RenderDarwinPlatformView demo: rendering ${nativeViews.length} native view types');

  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          'Placeholder containers representing native macOS views that would be rendered by the Darwin platform view layer',
          style: TextStyle(fontSize: 12, color: Color(0xFF90A4AE)),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: nativeViews.map((view) {
            return Container(
              width: view['width'],
              height: view['height'],
              decoration: BoxDecoration(
                color: view['color'],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Color(0xFFFFFFFF), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(view['icon'], color: Colors.white, size: 20),
                  SizedBox(height: 4),
                  Text(
                    view['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    view['desc'],
                    style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 9),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// Section 2: Platform view composition layers
Widget _buildCompositionLayers() {
  print('RenderDarwinPlatformView demo: composition layers');

  List<Map<String, dynamic>> layers = [
    {
      'label': 'Flutter Overlay (above native)',
      'color': Color(0x9900BCD4),
      'desc': 'Flutter widgets rendered above the native view',
      'zIndex': 3,
    },
    {
      'label': 'Native Platform View',
      'color': Color(0xCCFF6F00),
      'desc': 'macOS NSView rendered by Core Animation layer',
      'zIndex': 2,
    },
    {
      'label': 'Flutter Background (below native)',
      'color': Color(0x994CAF50),
      'desc': 'Flutter widgets rendered below the native view',
      'zIndex': 1,
    },
    {
      'label': 'Rasterizer Base Layer',
      'color': Color(0x66424242),
      'desc': 'Skia/Impeller rasterization surface',
      'zIndex': 0,
    },
  ];

  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          'Composition ordering: Flutter content is split around the native view layer',
          style: TextStyle(fontSize: 12, color: Color(0xFF90A4AE)),
        ),
        SizedBox(height: 12),
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: Color(0xFF212121),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF616161), width: 1),
          ),
          child: Stack(
            children: layers.map((layer) {
              double topOffset = (3 - layer['zIndex']) * 65.0 + 10;
              double leftOffset = (3 - layer['zIndex']) * 12.0 + 8;
              print('RenderDarwinPlatformView demo: layer z=${layer['zIndex']} -> ${layer['label']}');
              return Positioned(
                top: topOffset,
                left: leftOffset,
                right: leftOffset,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: layer['color'],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Color(0x66FFFFFF), width: 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'z=${layer['zIndex']}',
                            style: TextStyle(
                              color: Color(0xFFFFEB3B),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            layer['label'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        layer['desc'],
                        style: TextStyle(color: Color(0xBBFFFFFF), fontSize: 10),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

// Section 3: Hit test passthrough behavior
Widget _buildHitTestPassthrough() {
  print('RenderDarwinPlatformView demo: hit test passthrough');

  List<Map<String, dynamic>> regions = [
    {
      'label': 'Flutter-handled region',
      'color': Color(0xFF1B5E20),
      'accepts': true,
      'desc': 'Taps go to Flutter GestureDetector',
    },
    {
      'label': 'Native passthrough region',
      'color': Color(0xFFBF360C),
      'accepts': false,
      'desc': 'Taps forwarded to NSView responder chain',
    },
    {
      'label': 'Shared region (disambiguation)',
      'color': Color(0xFF4A148C),
      'accepts': true,
      'desc': 'Arena decides Flutter vs native',
    },
    {
      'label': 'Overlay intercept area',
      'color': Color(0xFF0D47A1),
      'accepts': true,
      'desc': 'Flutter overlay captures before native',
    },
  ];

  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          'Hit test passthrough determines whether touch events reach Flutter or the native view',
          style: TextStyle(fontSize: 12, color: Color(0xFF90A4AE)),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: regions.map((region) {
              print('RenderDarwinPlatformView demo: hit region - ${region['label']} accepts=${region['accepts']}');
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: region['color'],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(
                      region['accepts'] ? Icons.touch_app : Icons.block,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            region['label'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            region['desc'],
                            style: TextStyle(
                              color: Color(0xBBFFFFFF),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        region['accepts'] ? 'FLUTTER' : 'NATIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

// Section 4: Sizing modes for platform views
Widget _buildSizingModes() {
  print('RenderDarwinPlatformView demo: sizing modes');

  List<Map<String, dynamic>> modes = [
    {
      'mode': 'Fixed Size',
      'desc': 'Native view has explicit width/height constraints',
      'w': 160.0,
      'h': 80.0,
      'color': Color(0xFF00695C),
      'borderStyle': BorderStyle.solid,
    },
    {
      'mode': 'Expanded',
      'desc': 'Native view fills available parent space',
      'w': double.infinity,
      'h': 60.0,
      'color': Color(0xFF283593),
      'borderStyle': BorderStyle.solid,
    },
    {
      'mode': 'Intrinsic',
      'desc': 'Native view determines its own preferred size',
      'w': 200.0,
      'h': 50.0,
      'color': Color(0xFF4E342E),
      'borderStyle': BorderStyle.solid,
    },
    {
      'mode': 'Aspect Ratio',
      'desc': 'Width locked to aspect ratio of native content',
      'w': 180.0,
      'h': 101.0,
      'color': Color(0xFF880E4F),
      'borderStyle': BorderStyle.solid,
    },
  ];

  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          'Platform views support multiple sizing strategies controlled by the embedding layout',
          style: TextStyle(fontSize: 12, color: Color(0xFF90A4AE)),
        ),
        SizedBox(height: 12),
        Column(
          children: modes.map((mode) {
            print('RenderDarwinPlatformView demo: sizing mode - ${mode['mode']}');
            double displayW = mode['w'] == double.infinity ? double.infinity : mode['w'];
            return Container(
              width: displayW,
              height: mode['h'],
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: mode['color'],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Color(0xFFFFD54F),
                  width: 2,
                  style: mode['borderStyle'],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mode['mode'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      mode['desc'],
                      style: TextStyle(color: Color(0xBBFFFFFF), fontSize: 9),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      mode['w'] == double.infinity
                          ? 'w: fill, h: ${mode['h']}'
                          : 'w: ${mode['w']}, h: ${mode['h']}',
                      style: TextStyle(color: Color(0xFFFFD54F), fontSize: 9),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// Section 5: Flutter painting pipeline interaction
Widget _buildPaintingPipelineInteraction() {
  print('RenderDarwinPlatformView demo: painting pipeline interaction');

  List<Map<String, dynamic>> stages = [
    {
      'stage': 'Layout',
      'detail': 'RenderBox constraints passed to platform view sizer',
      'icon': Icons.straighten,
      'color': Color(0xFF1565C0),
    },
    {
      'stage': 'Compositing',
      'detail': 'PlatformViewLayer inserted into compositing tree',
      'icon': Icons.layers,
      'color': Color(0xFF2E7D32),
    },
    {
      'stage': 'Texture Upload',
      'detail': 'IOSurface/CALayer content shared with Flutter engine',
      'icon': Icons.upload,
      'color': Color(0xFF6A1B9A),
    },
    {
      'stage': 'Rasterization',
      'detail': 'Native texture composited into final frame buffer',
      'icon': Icons.image,
      'color': Color(0xFFE65100),
    },
    {
      'stage': 'Clipping',
      'detail': 'ClipRect/ClipRRect applied around platform view bounds',
      'icon': Icons.crop,
      'color': Color(0xFF00838F),
    },
    {
      'stage': 'Opacity',
      'detail': 'Platform view alpha blended with Flutter content',
      'icon': Icons.opacity,
      'color': Color(0xFFC62828),
    },
  ];

  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          'How platform views integrate into Flutter paint and compositing pipeline',
          style: TextStyle(fontSize: 12, color: Color(0xFF90A4AE)),
        ),
        SizedBox(height: 12),
        Column(
          children: [
            for (int i = 0; i < stages.length; i++)
              _buildPipelineStageRow(stages[i], i, stages.length),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPipelineStageRow(Map<String, dynamic> stage, int index, int total) {
  print('RenderDarwinPlatformView demo: pipeline stage $index - ${stage['stage']}');
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: stage['color'],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Color(0x33FFFFFF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Icon(stage['icon'], color: Colors.white, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stage['stage'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    stage['detail'],
                    style: TextStyle(color: Color(0xBBFFFFFF), fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      if (index < total - 1)
        Container(
          height: 20,
          width: 2,
          color: Color(0xFF616161),
        ),
    ],
  );
}

// Section 6: Gesture disambiguation areas
Widget _buildGestureDisambiguation() {
  print('RenderDarwinPlatformView demo: gesture disambiguation');

  List<Map<String, dynamic>> zones = [
    {
      'zone': 'Flutter Exclusive Zone',
      'gesture': 'Scroll, tap, long-press handled by Flutter',
      'color': Color(0xFF1B5E20),
      'icon': Icons.pan_tool,
    },
    {
      'zone': 'Native Exclusive Zone',
      'gesture': 'NSResponder chain handles all events',
      'color': Color(0xFFB71C1C),
      'icon': Icons.mouse,
    },
    {
      'zone': 'Shared Disambiguation Zone',
      'gesture': 'Gesture arena resolves Flutter vs native winner',
      'color': Color(0xFFFF6F00),
      'icon': Icons.compare_arrows,
    },
    {
      'zone': 'Transparent Passthrough',
      'gesture': 'Events ignored by both, fall through to parent',
      'color': Color(0xFF37474F),
      'icon': Icons.layers_clear,
    },
  ];

  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          'Gesture disambiguation determines which system handles user input in overlapping regions',
          style: TextStyle(fontSize: 12, color: Color(0xFF90A4AE)),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Visual grid showing zones
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: zones[0]['color'],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                        ),
                        border: Border.all(color: Color(0x44FFFFFF), width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(zones[0]['icon'], color: Colors.white, size: 18),
                            SizedBox(height: 4),
                            Text(
                              'Flutter',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: zones[2]['color'],
                        border: Border.all(color: Color(0x44FFFFFF), width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(zones[2]['icon'], color: Colors.white, size: 18),
                            SizedBox(height: 4),
                            Text(
                              'Shared',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: zones[1]['color'],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                        ),
                        border: Border.all(color: Color(0x44FFFFFF), width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(zones[1]['icon'], color: Colors.white, size: 18),
                            SizedBox(height: 4),
                            Text(
                              'Native',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              // Detail list
              Column(
                children: zones.map((zone) {
                  print('RenderDarwinPlatformView demo: gesture zone - ${zone['zone']}');
                  return Container(
                    margin: EdgeInsets.only(bottom: 6),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: zone['color'],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(zone['icon'], color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                zone['zone'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                zone['gesture'],
                                style: TextStyle(
                                  color: Color(0xBBFFFFFF),
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 7: Platform view lifecycle stages
Widget _buildLifecycleStages() {
  print('RenderDarwinPlatformView demo: lifecycle stages');

  List<Map<String, dynamic>> lifecycle = [
    {
      'stage': 'Create',
      'desc': 'PlatformViewFactory instantiates native NSView',
      'color': Color(0xFF1565C0),
      'status': 'init',
    },
    {
      'stage': 'Attach',
      'desc': 'Native view added to FlutterView hierarchy',
      'color': Color(0xFF2E7D32),
      'status': 'active',
    },
    {
      'stage': 'Layout',
      'desc': 'Size and position synced from Flutter constraints',
      'color': Color(0xFF6A1B9A),
      'status': 'active',
    },
    {
      'stage': 'Render',
      'desc': 'Native content composited into Flutter frame',
      'color': Color(0xFFE65100),
      'status': 'active',
    },
    {
      'stage': 'Focus',
      'desc': 'Keyboard focus transferred between Flutter and native',
      'color': Color(0xFF00838F),
      'status': 'interactive',
    },
    {
      'stage': 'Resize',
      'desc': 'Constraints change triggers native view resize',
      'color': Color(0xFF558B2F),
      'status': 'active',
    },
    {
      'stage': 'Detach',
      'desc': 'Native view removed from FlutterView hierarchy',
      'color': Color(0xFFC62828),
      'status': 'teardown',
    },
    {
      'stage': 'Dispose',
      'desc': 'Native resources freed, IOSurface released',
      'color': Color(0xFF424242),
      'status': 'dead',
    },
  ];

  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          'Platform view lifecycle from creation through disposal',
          style: TextStyle(fontSize: 12, color: Color(0xFF90A4AE)),
        ),
        SizedBox(height: 12),
        Column(
          children: [
            for (int i = 0; i < lifecycle.length; i++)
              _buildLifecycleRow(lifecycle[i], i, lifecycle.length),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLifecycleRow(Map<String, dynamic> item, int index, int total) {
  print('RenderDarwinPlatformView demo: lifecycle $index - ${item['stage']} (${item['status']})');

  Color statusColor;
  if (item['status'] == 'init') {
    statusColor = Color(0xFF64B5F6);
  } else if (item['status'] == 'active') {
    statusColor = Color(0xFF81C784);
  } else if (item['status'] == 'interactive') {
    statusColor = Color(0xFFFFD54F);
  } else if (item['status'] == 'teardown') {
    statusColor = Color(0xFFE57373);
  } else {
    statusColor = Color(0xFF757575);
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Timeline column
      SizedBox(
        width: 40,
        child: Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: item['color'],
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFFFFFFF), width: 2),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (index < total - 1)
              Container(
                width: 2,
                height: 36,
                color: Color(0xFF616161),
              ),
          ],
        ),
      ),
      // Content
      Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF2A2A3E),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: item['color'], width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['stage'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      item['desc'],
                      style: TextStyle(color: Color(0xBBFFFFFF), fontSize: 10),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item['status'],
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// Section 8: AppKitView vs UiKitView comparison
Widget _buildAppKitVsUiKitComparison() {
  print('RenderDarwinPlatformView demo: AppKitView vs UiKitView comparison');

  List<Map<String, dynamic>> features = [
    {
      'feature': 'Platform',
      'appkit': 'macOS (AppKit)',
      'uikit': 'iOS (UIKit)',
    },
    {
      'feature': 'Base View',
      'appkit': 'NSView',
      'uikit': 'UIView',
    },
    {
      'feature': 'Rendering',
      'appkit': 'CALayer compositing',
      'uikit': 'IOSurface sharing',
    },
    {
      'feature': 'Hit Testing',
      'appkit': 'NSResponder chain',
      'uikit': 'UIResponder chain',
    },
    {
      'feature': 'Keyboard',
      'appkit': 'NSTextInputClient',
      'uikit': 'UITextInput protocol',
    },
    {
      'feature': 'Gestures',
      'appkit': 'NSGestureRecognizer',
      'uikit': 'UIGestureRecognizer',
    },
    {
      'feature': 'Focus',
      'appkit': 'makeFirstResponder',
      'uikit': 'becomeFirstResponder',
    },
    {
      'feature': 'Accessibility',
      'appkit': 'NSAccessibility',
      'uikit': 'UIAccessibility',
    },
  ];

  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          'Comparison of macOS AppKitView and iOS UiKitView rendering approaches',
          style: TextStyle(fontSize: 12, color: Color(0xFF90A4AE)),
        ),
        SizedBox(height: 12),
        // Header row
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xFF1A237E),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Feature',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'AppKitView (macOS)',
                  style: TextStyle(
                    color: Color(0xFF64B5F6),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'UiKitView (iOS)',
                  style: TextStyle(
                    color: Color(0xFF81C784),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        // Data rows
        Column(
          children: [
            for (int i = 0; i < features.length; i++)
              _buildComparisonRow(features[i], i),
          ],
        ),
        SizedBox(height: 12),
        // Visual rendering area comparison
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF64B5F6), width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.desktop_mac, color: Colors.white, size: 28),
                    SizedBox(height: 6),
                    Text(
                      'AppKitView',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'macOS native rendering',
                      style: TextStyle(color: Color(0xBBFFFFFF), fontSize: 9),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                margin: EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF81C784), width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone_iphone, color: Colors.white, size: 28),
                    SizedBox(height: 6),
                    Text(
                      'UiKitView',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'iOS native rendering',
                      style: TextStyle(color: Color(0xBBFFFFFF), fontSize: 9),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        // Summary note
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFF546E7A), width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFF80CBC4), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'RenderDarwinPlatformView unifies both AppKit and UIKit rendering through a shared compositing interface in the Flutter engine',
                  style: TextStyle(color: Color(0xFF80CBC4), fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(Map<String, dynamic> feature, int index) {
  print('RenderDarwinPlatformView demo: comparing ${feature['feature']}: ${feature['appkit']} vs ${feature['uikit']}');

  Color rowBg = index % 2 == 0 ? Color(0xFF1E1E2E) : Color(0xFF252538);

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: rowBg,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            feature['feature'],
            style: TextStyle(
              color: Color(0xFFCFD8DC),
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Color(0x220D47A1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              feature['appkit'],
              style: TextStyle(color: Color(0xFF90CAF9), fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Color(0x221B5E20),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              feature['uikit'],
              style: TextStyle(color: Color(0xFFA5D6A7), fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}
