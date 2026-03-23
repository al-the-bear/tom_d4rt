// ignore_for_file: avoid_print
// D4rt test script: Tests DialogRoute concepts from package:flutter/material.dart
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== DialogRoute Visual Demo ===');
  debugPrint('Demonstrating dialog routes, barrier colors, sizes, transitions, and shapes');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DialogRoute Demo'),
        backgroundColor: Color(0xFF4E342E),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Basic Dialog Representations'),
            SizedBox(height: 8),
            _buildBasicDialogs(),
            SizedBox(height: 24),
            _buildSectionHeader('Barrier Color Variations'),
            SizedBox(height: 8),
            _buildBarrierColors(),
            SizedBox(height: 24),
            _buildSectionHeader('Dialog Sizes'),
            SizedBox(height: 8),
            _buildDialogSizes(),
            SizedBox(height: 24),
            _buildSectionHeader('Dialog Content Types'),
            SizedBox(height: 8),
            _buildContentTypes(),
            SizedBox(height: 24),
            _buildSectionHeader('Transition Styles'),
            SizedBox(height: 8),
            _buildTransitionStyles(),
            SizedBox(height: 24),
            _buildSectionHeader('Modal vs Non-Modal'),
            SizedBox(height: 8),
            _buildModalComparison(),
            SizedBox(height: 24),
            _buildSectionHeader('Dialog Shapes'),
            SizedBox(height: 8),
            _buildDialogShapes(),
            SizedBox(height: 24),
            _buildSectionHeader('Action Button Layouts'),
            SizedBox(height: 8),
            _buildActionLayouts(),
            SizedBox(height: 24),
            _buildSectionHeader('DialogRoute Properties'),
            SizedBox(height: 8),
            _buildRouteProperties(),
            SizedBox(height: 24),
            _buildSectionHeader('Nested Dialogs'),
            SizedBox(height: 8),
            _buildNestedDialogs(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  debugPrint('Building section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(color: Color(0xFF4E342E), borderRadius: BorderRadius.circular(8)),
    child: Text(title, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18, fontWeight: FontWeight.bold)),
  );
}

Widget _buildBasicDialogs() {
  debugPrint('Building basic dialogs');
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: _buildDialogPreview('Alert Dialog', Color(0xFFF44336), [
        Container(padding: EdgeInsets.all(16), child: Column(children: [
          Icon(Icons.warning_amber, color: Color(0xFFF44336), size: 36),
          SizedBox(height: 8),
          Text('Alert Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 4),
          Text('Are you sure you want to delete this item?', style: TextStyle(fontSize: 12, color: Color(0xFF757575)), textAlign: TextAlign.center),
        ])),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          _buildDialogAction('Cancel', Color(0xFF757575)),
          SizedBox(width: 8),
          _buildDialogAction('Delete', Color(0xFFF44336)),
          SizedBox(width: 12),
        ]),
      ])),
      SizedBox(width: 8),
      Expanded(child: _buildDialogPreview('Confirm Dialog', Color(0xFF4CAF50), [
        Container(padding: EdgeInsets.all(16), child: Column(children: [
          Icon(Icons.check_circle_outline, color: Color(0xFF4CAF50), size: 36),
          SizedBox(height: 8),
          Text('Confirm Action', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 4),
          Text('Save your changes before exiting?', style: TextStyle(fontSize: 12, color: Color(0xFF757575)), textAlign: TextAlign.center),
        ])),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          _buildDialogAction('Discard', Color(0xFF757575)),
          SizedBox(width: 8),
          _buildDialogAction('Save', Color(0xFF4CAF50)),
          SizedBox(width: 12),
        ]),
      ])),
      SizedBox(width: 8),
      Expanded(child: _buildDialogPreview('Full Dialog', Color(0xFF2196F3), [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Color(0xFF2196F3),
          child: Row(children: [
            Icon(Icons.close, color: Color(0xFFFFFFFF), size: 18),
            SizedBox(width: 8),
            Expanded(child: Text('New Event', style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold, fontSize: 13))),
            Text('SAVE', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11, fontWeight: FontWeight.bold)),
          ]),
        ),
        Container(padding: EdgeInsets.all(12), child: Column(children: [
          Container(height: 32, decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))), child: Row(children: [Text('Title', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 12))])),
          SizedBox(height: 8),
          Container(height: 32, decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))), child: Row(children: [Text('Date', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 12))])),
        ])),
      ])),
    ],
  );
}

Widget _buildDialogPreview(String label, Color color, List<Widget> children) {
  return Column(children: [
    Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: color)),
    SizedBox(height: 6),
    Container(
      decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(12), border: Border.all(color: color), boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 4))]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
      ),
    ),
  ]);
}

Widget _buildDialogAction(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
  );
}

Widget _buildBarrierColors() {
  debugPrint('Building barrier colors');
  List<Map<String, dynamic>> barriers = [
    {'label': 'Default (54% black)', 'color': Color(0x8A000000)},
    {'label': 'Light (20% black)', 'color': Color(0x33000000)},
    {'label': 'Dark (80% black)', 'color': Color(0xCC000000)},
    {'label': 'Blue Tint', 'color': Color(0x661565C0)},
    {'label': 'Red Tint', 'color': Color(0x66F44336)},
    {'label': 'Transparent', 'color': Color(0x05000000)},
  ];
  return Wrap(
    spacing: 8, runSpacing: 8,
    children: barriers.map((b) {
      return Container(
        width: 170, height: 120,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFE0E0E0))),
        child: Stack(children: [
          Positioned.fill(child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Column(children: [
              Container(color: Color(0xFF2196F3), height: 25, width: double.infinity),
              Expanded(child: Container(color: Color(0xFFFFFFFF), padding: EdgeInsets.all(6), child: Text('Background content shown here with some text', style: TextStyle(fontSize: 8, color: Color(0xFF757575))))),
            ]),
          )),
          Positioned.fill(child: Container(
            decoration: BoxDecoration(color: b['color'] as Color, borderRadius: BorderRadius.circular(9)),
          )),
          Center(child: Container(
            width: 100, padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 4)]),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('Dialog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              SizedBox(height: 2),
              Text(b['label'] as String, style: TextStyle(fontSize: 8, color: Color(0xFF757575)), textAlign: TextAlign.center),
            ]),
          )),
        ]),
      );
    }).toList(),
  );
}

Widget _buildDialogSizes() {
  debugPrint('Building dialog sizes');
  List<Map<String, dynamic>> sizes = [
    {'label': 'Small', 'width': 200.0, 'height': 120.0, 'color': Color(0xFF4CAF50)},
    {'label': 'Medium', 'width': 280.0, 'height': 180.0, 'color': Color(0xFF2196F3)},
    {'label': 'Large', 'width': 360.0, 'height': 240.0, 'color': Color(0xFFFF9800)},
  ];
  return Column(
    children: sizes.map((s) {
      return Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Center(child: Container(
          width: s['width'] as double,
          height: s['height'] as double,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(12),
            border: Border.all(color: s['color'] as Color, width: 2),
            boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 4))],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(s['label'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: s['color'] as Color)),
              SizedBox(height: 4),
              Text('${(s['width'] as double).toInt()} x ${(s['height'] as double).toInt()}', style: TextStyle(fontSize: 12, color: Color(0xFF757575), fontFamily: 'monospace')),
            ],
          ),
        )),
      );
    }).toList(),
  );
}

Widget _buildContentTypes() {
  debugPrint('Building content types');
  List<Map<String, dynamic>> types = [
    {'label': 'Text Content', 'icon': Icons.text_fields, 'color': Color(0xFF4E342E)},
    {'label': 'List Content', 'icon': Icons.list, 'color': Color(0xFF1565C0)},
    {'label': 'Form Content', 'icon': Icons.edit_note, 'color': Color(0xFF2E7D32)},
    {'label': 'Image Content', 'icon': Icons.image, 'color': Color(0xFF6A1B9A)},
  ];
  return Wrap(
    spacing: 8, runSpacing: 8,
    children: types.map((t) {
      return Container(
        width: 170,
        decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(12), border: Border.all(color: t['color'] as Color), boxShadow: [BoxShadow(color: Color(0x11000000), blurRadius: 4)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: (t['color'] as Color).withValues(alpha: 0.08), borderRadius: BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11))),
            child: Column(children: [
              Icon(t['icon'] as IconData, color: t['color'] as Color, size: 32),
              SizedBox(height: 6),
              Text(t['label'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: t['color'] as Color)),
            ]),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Container(height: 8, color: Color(0xFFE0E0E0), margin: EdgeInsets.only(bottom: 4)),
              Container(height: 8, color: Color(0xFFEEEEEE), margin: EdgeInsets.only(bottom: 4)),
              Container(height: 8, width: 100, color: Color(0xFFF5F5F5)),
            ]),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text('Cancel', style: TextStyle(color: Color(0xFF757575), fontSize: 11)),
              SizedBox(width: 12),
              Text('OK', style: TextStyle(color: t['color'] as Color, fontWeight: FontWeight.bold, fontSize: 11)),
            ]),
          ),
        ]),
      );
    }).toList(),
  );
}

Widget _buildTransitionStyles() {
  debugPrint('Building transition styles');
  List<Map<String, dynamic>> transitions = [
    {'label': 'Fade In', 'icon': Icons.gradient, 'color': Color(0xFF4CAF50), 'desc': 'Opacity animates from 0 to 1'},
    {'label': 'Scale Up', 'icon': Icons.zoom_in, 'color': Color(0xFF2196F3), 'desc': 'Dialog scales from small to full size'},
    {'label': 'Slide Up', 'icon': Icons.arrow_upward, 'color': Color(0xFFFF9800), 'desc': 'Dialog slides from bottom of screen'},
    {'label': 'None', 'icon': Icons.block, 'color': Color(0xFF9E9E9E), 'desc': 'Dialog appears instantly with no animation'},
  ];
  return Column(
    children: transitions.map((t) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(10), border: Border.all(color: t['color'] as Color)),
        child: Row(children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: (t['color'] as Color).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(t['icon'] as IconData, color: t['color'] as Color, size: 24),
          ),
          SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t['label'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              SizedBox(height: 2),
              Text(t['desc'] as String, style: TextStyle(fontSize: 12, color: Color(0xFF757575))),
            ],
          )),
          Row(children: List.generate(4, (i) {
            double opacity = (i + 1) / 4.0;
            return Container(
              margin: EdgeInsets.only(left: 3),
              width: 16, height: 20,
              decoration: BoxDecoration(
                color: (t['color'] as Color).withValues(alpha: opacity),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          })),
        ]),
      );
    }).toList(),
  );
}

Widget _buildModalComparison() {
  debugPrint('Building modal comparison');
  return Row(children: [
    Expanded(child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFF4CAF50), width: 2)),
      child: Column(children: [
        Icon(Icons.lock, color: Color(0xFF4CAF50), size: 36),
        SizedBox(height: 8),
        Text('Modal Dialog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2E7D32))),
        SizedBox(height: 12),
        _buildModalFeatureRow('Blocks background', true),
        _buildModalFeatureRow('Has barrier', true),
        _buildModalFeatureRow('Barrier dismissible', true),
        _buildModalFeatureRow('Trap focus', true),
        _buildModalFeatureRow('Background interaction', false),
      ]),
    )),
    SizedBox(width: 12),
    Expanded(child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFFF9800), width: 2)),
      child: Column(children: [
        Icon(Icons.lock_open, color: Color(0xFFFF9800), size: 36),
        SizedBox(height: 8),
        Text('Non-Modal Dialog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFE65100))),
        SizedBox(height: 12),
        _buildModalFeatureRow('Blocks background', false),
        _buildModalFeatureRow('Has barrier', false),
        _buildModalFeatureRow('Barrier dismissible', false),
        _buildModalFeatureRow('Trap focus', false),
        _buildModalFeatureRow('Background interaction', true),
      ]),
    )),
  ]);
}

Widget _buildModalFeatureRow(String label, bool yes) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(children: [
      Icon(yes ? Icons.check_circle : Icons.cancel, color: yes ? Color(0xFF4CAF50) : Color(0xFFE0E0E0), size: 16),
      SizedBox(width: 6),
      Text(label, style: TextStyle(fontSize: 12)),
    ]),
  );
}

Widget _buildDialogShapes() {
  debugPrint('Building dialog shapes');
  List<Map<String, dynamic>> shapes = [
    {'label': 'Sharp', 'radius': 0.0},
    {'label': 'Slight (4)', 'radius': 4.0},
    {'label': 'Default (12)', 'radius': 12.0},
    {'label': 'Large (24)', 'radius': 24.0},
    {'label': 'Extra (32)', 'radius': 32.0},
  ];
  return Row(
    children: shapes.map((s) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(s['radius'] as double),
            border: Border.all(color: Color(0xFF4E342E), width: 2),
            boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 6, offset: Offset(0, 3))],
          ),
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(s['label'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
              Text('${(s['radius'] as double).toInt()}dp', style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
            ],
          )),
        ),
      );
    }).toList(),
  );
}

Widget _buildActionLayouts() {
  debugPrint('Building action layouts');
  return Column(children: [
    _buildActionLayoutRow('End-Aligned', MainAxisAlignment.end, ['Cancel', 'OK']),
    SizedBox(height: 8),
    _buildActionLayoutRow('Space-Between', MainAxisAlignment.spaceBetween, ['Cancel', 'OK']),
    SizedBox(height: 8),
    _buildActionLayoutRow('Three Actions', MainAxisAlignment.end, ['Learn More', 'Cancel', 'Accept']),
    SizedBox(height: 8),
    _buildActionLayoutStacked('Stacked Actions', ['Accept and Continue', 'Cancel']),
  ]);
}

Widget _buildActionLayoutRow(String label, MainAxisAlignment alignment, List<String> actions) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFE0E0E0))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF757575))),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: alignment,
            children: actions.asMap().entries.map((entry) {
              bool isPrimary = entry.key == actions.length - 1;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(color: isPrimary ? Color(0xFF4E342E) : Color(0x00000000), borderRadius: BorderRadius.circular(6)),
                child: Text(entry.value, style: TextStyle(color: isPrimary ? Color(0xFFFFFFFF) : Color(0xFF4E342E), fontWeight: FontWeight.bold, fontSize: 12)),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildActionLayoutStacked(String label, List<String> actions) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFE0E0E0))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF757575))),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: actions.asMap().entries.map((entry) {
              bool isPrimary = entry.key == 0;
              return Container(
                margin: EdgeInsets.only(bottom: entry.key < actions.length - 1 ? 6 : 0),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(color: isPrimary ? Color(0xFF4E342E) : Color(0x00000000), borderRadius: BorderRadius.circular(6), border: isPrimary ? null : Border.all(color: Color(0xFF4E342E))),
                child: Text(entry.value, style: TextStyle(color: isPrimary ? Color(0xFFFFFFFF) : Color(0xFF4E342E), fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRouteProperties() {
  debugPrint('Building route properties');
  List<Map<String, dynamic>> props = [
    {'prop': 'barrierDismissible', 'type': 'bool', 'default': 'true', 'desc': 'Whether tapping the barrier closes the dialog'},
    {'prop': 'barrierColor', 'type': 'Color', 'default': 'Colors.black54', 'desc': 'Color of the scrim behind the dialog'},
    {'prop': 'barrierLabel', 'type': 'String?', 'default': 'null', 'desc': 'Semantic label for the barrier'},
    {'prop': 'transitionDuration', 'type': 'Duration', 'default': '150ms', 'desc': 'How long the open/close animation takes'},
    {'prop': 'transitionBuilder', 'type': 'RouteTransitionsBuilder?', 'default': 'null', 'desc': 'Custom animation builder'},
    {'prop': 'useSafeArea', 'type': 'bool', 'default': 'true', 'desc': 'Whether to respect device safe areas'},
    {'prop': 'settings', 'type': 'RouteSettings?', 'default': 'null', 'desc': 'Route settings for navigation'},
    {'prop': 'anchorPoint', 'type': 'Offset?', 'default': 'null', 'desc': 'Anchor point for dialog positioning'},
  ];
  return Column(
    children: props.map((p) {
      return Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(8), border: Border.all(color: Color(0xFFE0E0E0))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['prop'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)),
                SizedBox(height: 2),
                Row(children: [
                  Container(padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1), decoration: BoxDecoration(color: Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(3)), child: Text(p['type'] as String, style: TextStyle(fontSize: 9, color: Color(0xFF1565C0), fontFamily: 'monospace'))),
                  SizedBox(width: 4),
                  Container(padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1), decoration: BoxDecoration(color: Color(0xFFF3E5F5), borderRadius: BorderRadius.circular(3)), child: Text(p['default'] as String, style: TextStyle(fontSize: 9, color: Color(0xFF6A1B9A), fontFamily: 'monospace'))),
                ]),
              ],
            )),
            Expanded(flex: 4, child: Text(p['desc'] as String, style: TextStyle(fontSize: 12, color: Color(0xFF757575)))),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildNestedDialogs() {
  debugPrint('Building nested dialogs illustration');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
    child: Center(child: Stack(children: [
      Container(
        width: 340, height: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFF4E342E), width: 2), boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 4))]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Parent Dialog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF4E342E))),
            SizedBox(height: 8),
            Text('This dialog contains content that may trigger a child dialog.', style: TextStyle(fontSize: 12, color: Color(0xFF757575))),
            Expanded(child: SizedBox()),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text('Cancel', style: TextStyle(color: Color(0xFF757575), fontSize: 12)),
              SizedBox(width: 16),
              Text('Open Child', style: TextStyle(color: Color(0xFF4E342E), fontWeight: FontWeight.bold, fontSize: 12)),
            ]),
          ],
        ),
      ),
      Positioned(
        left: 40, top: 50,
        child: Container(
          width: 250, height: 130,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFF1565C0), width: 2), boxShadow: [BoxShadow(color: Color(0x44000000), blurRadius: 12, offset: Offset(0, 6))]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Child Dialog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1565C0))),
              SizedBox(height: 6),
              Text('Nested dialog on top of parent', style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
              Expanded(child: SizedBox()),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text('Close', style: TextStyle(color: Color(0xFF1565C0), fontWeight: FontWeight.bold, fontSize: 11)),
              ]),
            ],
          ),
        ),
      ),
    ])),
  );
}
