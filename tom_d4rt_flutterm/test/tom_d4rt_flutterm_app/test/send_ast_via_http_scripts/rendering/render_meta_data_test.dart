// Deep demo: RenderMetaData / MetaData widget
// MetaData stores opaque data accessible during hit testing.
// Demonstrates metadata tagging, HitTestBehavior modes,
// nesting, practical analytics patterns, and visual diagrams.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget _buildHeader(String title, String subtitle) {
  print('Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF00897B), Color(0xFF26A69A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x4000695C),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xCCFFFFFF),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(IconData icon, String title) {
  print('Building section: $title');
  return Padding(
    padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0x1A00695C),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Color(0xFF00695C), size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF004D40),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String label, String description) {
  print('Info card: $label');
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF81C784), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: Color(0xFF388E3C), size: 18),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B5E20),
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Color(0xFF33691E)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Builds a color-coded tagged region carrying metadata
Widget _buildTaggedRegion(
  String tag,
  Color regionColor,
  Color textColor,
  String description,
  Widget child,
) {
  print('Building tagged region: $tag');
  return MetaData(
    metaData: tag,
    behavior: HitTestBehavior.opaque,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: regionColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: textColor.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: regionColor.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Tag: $tag',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  description,
                  style: TextStyle(fontSize: 11, color: textColor.withOpacity(0.7)),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          child,
        ],
      ),
    ),
  );
}

// Builds a HitTestBehavior comparison card
Widget _buildBehaviorCard(
  String behaviorName,
  HitTestBehavior behavior,
  Color color,
  String explanation,
) {
  print('Building behavior card: $behaviorName');
  return MetaData(
    metaData: 'behavior-$behaviorName',
    behavior: behavior,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.08), color.withOpacity(0.18)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.touch_app, color: color, size: 20),
              SizedBox(width: 8),
              Text(
                behaviorName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            explanation,
            style: TextStyle(fontSize: 12, color: color.withOpacity(0.8)),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Center(
              child: Text(
                'Hit test area ($behaviorName)',
                style: TextStyle(fontSize: 12, color: color),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Builds the visual pipeline diagram for metadata flow
Widget _buildPipelineDiagram() {
  print('Building metadata pipeline diagram');
  List<Map<String, String>> stages = [
    {'label': 'Pointer Event', 'detail': 'User taps screen'},
    {'label': 'HitTest Start', 'detail': 'RenderView.hitTest()'},
    {'label': 'RenderMetaData', 'detail': 'Checks behavior mode'},
    {'label': 'metaData attached', 'detail': 'Object stored in entry'},
    {'label': 'HitTestEntry', 'detail': 'Carries metadata forward'},
    {'label': 'HitTestResult', 'detail': 'List of entries with data'},
    {'label': 'GestureBinding', 'detail': 'Dispatches to detectors'},
  ];

  List<Color> stageColors = [
    Color(0xFF1565C0),
    Color(0xFF0277BD),
    Color(0xFF00838F),
    Color(0xFF00695C),
    Color(0xFF2E7D32),
    Color(0xFF558B2F),
    Color(0xFF9E9D24),
  ];

  List<Widget> pipelineWidgets = [];
  for (int i = 0; i < stages.length; i++) {
    print('Pipeline stage $i: ${stages[i]['label']}');
    pipelineWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              stageColors[i].withOpacity(0.12),
              stageColors[i].withOpacity(0.22),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: stageColors[i].withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: stageColors[i],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stages[i]['label']!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: stageColors[i],
                    ),
                  ),
                  Text(
                    stages[i]['detail']!,
                    style: TextStyle(
                      fontSize: 11,
                      color: stageColors[i].withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_downward, color: stageColors[i], size: 18),
          ],
        ),
      ),
    );
  }

  return Column(children: pipelineWidgets);
}

// Nested metadata demonstration
Widget _buildNestedMetaData() {
  print('Building nested MetaData sections');
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Color(0xFF5C6BC0), width: 2),
    ),
    child: MetaData(
      metaData: 'outer-region-A',
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.layers_outlined, color: Color(0xFF3949AB), size: 18),
                SizedBox(width: 8),
                Text(
                  'Outer MetaData: "outer-region-A"',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF283593),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Behavior: translucent - events pass through',
              style: TextStyle(fontSize: 11, color: Color(0xFF3949AB)),
            ),
            SizedBox(height: 12),
            MetaData(
              metaData: 'inner-region-B',
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFFC5CAE9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF7986CB), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.layers, color: Color(0xFF3949AB), size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Inner MetaData: "inner-region-B"',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Behavior: opaque - absorbs hit test',
                      style: TextStyle(fontSize: 11, color: Color(0xFF303F9F)),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF9FA8DA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Tap here: inner metadata takes precedence',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            MetaData(
              metaData: 'inner-region-C',
              behavior: HitTestBehavior.deferToChild,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFFD1C4E9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF9575CD), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.layers, color: Color(0xFF7E57C2), size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Inner MetaData: "inner-region-C"',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4527A0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Behavior: deferToChild - only if child is hit',
                      style: TextStyle(fontSize: 11, color: Color(0xFF512DA8)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// GestureDetector comparison with hit test behaviors
Widget _buildGestureComparison() {
  print('Building GestureDetector comparison');
  List<Map<String, dynamic>> items = [
    {
      'label': 'GestureDetector + deferToChild',
      'behavior': HitTestBehavior.deferToChild,
      'color': Color(0xFFE65100),
      'desc': 'Only detects tap if child widget is hit',
    },
    {
      'label': 'GestureDetector + opaque',
      'behavior': HitTestBehavior.opaque,
      'color': Color(0xFFC62828),
      'desc': 'Always detects tap, prevents pass-through',
    },
    {
      'label': 'GestureDetector + translucent',
      'behavior': HitTestBehavior.translucent,
      'color': Color(0xFF6A1B9A),
      'desc': 'Always detects tap, allows pass-through to below',
    },
  ];

  List<Widget> cards = [];
  for (int i = 0; i < items.length; i++) {
    Map<String, dynamic> item = items[i];
    Color c = item['color'] as Color;
    print('GestureDetector comparison: ${item['label']}');
    cards.add(
      GestureDetector(
        behavior: item['behavior'] as HitTestBehavior,
        onTap: () {
          print('Tapped: ${item['label']}');
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [c.withOpacity(0.06), c.withOpacity(0.16)],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: c.withOpacity(0.35), width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.ads_click, color: c, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: c,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      item['desc'] as String,
                      style: TextStyle(fontSize: 11, color: c.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Column(children: cards);
}

// Analytics-tagged region practical pattern
Widget _buildAnalyticsPattern() {
  print('Building analytics pattern demo');
  List<Map<String, dynamic>> zones = [
    {
      'tag': 'hero-banner',
      'label': 'Hero Banner',
      'icon': Icons.image,
      'color': Color(0xFF1565C0),
      'desc': 'Main promotional area tracked for impressions',
    },
    {
      'tag': 'product-grid',
      'label': 'Product Grid',
      'icon': Icons.grid_view,
      'color': Color(0xFF2E7D32),
      'desc': 'Product listing zone for scroll-depth analytics',
    },
    {
      'tag': 'cta-button',
      'label': 'CTA Button',
      'icon': Icons.smart_button,
      'color': Color(0xFFC62828),
      'desc': 'Call-to-action button with tap tracking metadata',
    },
    {
      'tag': 'footer-nav',
      'label': 'Footer Navigation',
      'icon': Icons.menu,
      'color': Color(0xFF4527A0),
      'desc': 'Bottom navigation zone for engagement metrics',
    },
  ];

  List<Widget> zoneWidgets = [];
  for (int i = 0; i < zones.length; i++) {
    Map<String, dynamic> zone = zones[i];
    Color c = zone['color'] as Color;
    print('Analytics zone: ${zone['tag']}');
    zoneWidgets.add(
      MetaData(
        metaData: {'zone': zone['tag'], 'index': i, 'tracked': true},
        behavior: HitTestBehavior.translucent,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: c.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: c.withOpacity(0.3), width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: c.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(zone['icon'] as IconData, color: c, size: 20),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          zone['label'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: c,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: c.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            zone['tag'] as String,
                            style: TextStyle(fontSize: 9, color: c),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      zone['desc'] as String,
                      style: TextStyle(fontSize: 11, color: c.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              Icon(Icons.analytics_outlined, color: c.withOpacity(0.4), size: 18),
            ],
          ),
        ),
      ),
    );
  }

  return Column(children: zoneWidgets);
}

// Labeled interactive areas
Widget _buildLabeledInteractiveAreas() {
  print('Building labeled interactive areas');
  List<Map<String, dynamic>> areas = [
    {
      'label': 'Search Input',
      'metadata': 'input-search-bar',
      'icon': Icons.search,
      'bg': Color(0xFFE3F2FD),
      'fg': Color(0xFF1565C0),
    },
    {
      'label': 'Settings Toggle',
      'metadata': 'toggle-settings',
      'icon': Icons.settings,
      'bg': Color(0xFFFCE4EC),
      'fg': Color(0xFFC62828),
    },
    {
      'label': 'Profile Avatar',
      'metadata': 'avatar-profile',
      'icon': Icons.account_circle,
      'bg': Color(0xFFE8F5E9),
      'fg': Color(0xFF2E7D32),
    },
    {
      'label': 'Notification Bell',
      'metadata': 'bell-notifications',
      'icon': Icons.notifications,
      'bg': Color(0xFFFFF3E0),
      'fg': Color(0xFFE65100),
    },
  ];

  List<Widget> areaWidgets = [];
  for (int i = 0; i < areas.length; i++) {
    Map<String, dynamic> area = areas[i];
    Color fg = area['fg'] as Color;
    Color bg = area['bg'] as Color;
    print('Interactive area: ${area['metadata']}');
    areaWidgets.add(
      MetaData(
        metaData: area['metadata'],
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: fg.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              Icon(area['icon'] as IconData, color: fg, size: 22),
              SizedBox(width: 12),
              Text(
                area['label'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: fg.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  area['metadata'] as String,
                  style: TextStyle(fontSize: 10, color: fg),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Column(children: areaWidgets);
}

dynamic build(BuildContext context) {
  print('=== RenderMetaData / MetaData Deep Demo ===');
  print('MetaData widget wraps content with opaque metadata');
  print('RenderMetaData is the render object behind MetaData widget');
  print('Metadata is carried through HitTestEntry during hit testing');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(
          'RenderMetaData Deep Demo',
          'Opaque metadata for hit testing, tagging, and analytics',
        ),

        // Section 1: Basic MetaData with different content
        _buildSectionTitle(Icons.label, '1. MetaData Wrapping Different Content'),
        _buildInfoCard(
          'MetaData Widget',
          'Wraps a child with arbitrary metadata accessible during hit testing. '
          'The metaData property accepts any Object.',
        ),
        _buildTaggedRegion(
          'text-content',
          Color(0xFFE8F5E9),
          Color(0xFF2E7D32),
          'String metadata on text widget',
          Text(
            'This text carries metadata: "text-content"',
            style: TextStyle(fontSize: 13, color: Color(0xFF1B5E20)),
          ),
        ),
        _buildTaggedRegion(
          'icon-content',
          Color(0xFFE3F2FD),
          Color(0xFF1565C0),
          'String metadata on icon row',
          Row(
            children: [
              Icon(Icons.star, color: Color(0xFF1565C0), size: 24),
              SizedBox(width: 8),
              Icon(Icons.star, color: Color(0xFF42A5F5), size: 24),
              SizedBox(width: 8),
              Icon(Icons.star_border, color: Color(0xFF90CAF9), size: 24),
              SizedBox(width: 12),
              Text(
                'Icons with metadata "icon-content"',
                style: TextStyle(fontSize: 12, color: Color(0xFF1565C0)),
              ),
            ],
          ),
        ),
        _buildTaggedRegion(
          'container-content',
          Color(0xFFFFF3E0),
          Color(0xFFE65100),
          'Map metadata on complex widget',
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFFE0B2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  'Complex container widget',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Metadata can be any Object (Map, String, int...)',
                  style: TextStyle(fontSize: 11, color: Color(0xFFBF360C)),
                ),
              ],
            ),
          ),
        ),

        // Section 2: Color-coded tagged regions
        _buildSectionTitle(Icons.palette, '2. Color-Coded Metadata Regions'),
        _buildInfoCard(
          'Visual Regions',
          'Each colored region carries different metadata values. '
          'During hit testing, the framework reads metadata from the hit region.',
        ),
        _buildTaggedRegion(
          'region-alpha',
          Color(0xFFEDE7F6),
          Color(0xFF4527A0),
          'Purple zone: navigation header',
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu, color: Color(0xFF4527A0)),
              Text('Navigation', style: TextStyle(color: Color(0xFF4527A0), fontWeight: FontWeight.w600)),
              Icon(Icons.more_vert, color: Color(0xFF4527A0)),
            ],
          ),
        ),
        _buildTaggedRegion(
          'region-beta',
          Color(0xFFFCE4EC),
          Color(0xFFC62828),
          'Red zone: alert panel',
          Row(
            children: [
              Icon(Icons.warning_amber, color: Color(0xFFC62828)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Alert: System update required',
                  style: TextStyle(fontSize: 12, color: Color(0xFFC62828)),
                ),
              ),
            ],
          ),
        ),
        _buildTaggedRegion(
          'region-gamma',
          Color(0xFFE0F7FA),
          Color(0xFF00695C),
          'Teal zone: content area',
          Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB2DFDB), Color(0xFF80CBC4)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'Main content area with teal metadata',
                style: TextStyle(fontSize: 12, color: Color(0xFF004D40)),
              ),
            ),
          ),
        ),

        // Section 3: Hit test pipeline diagram
        _buildSectionTitle(Icons.account_tree, '3. Metadata Hit Test Pipeline'),
        _buildInfoCard(
          'Pipeline Flow',
          'When a pointer event occurs, the framework walks the render tree. '
          'RenderMetaData attaches its metaData to HitTestEntry objects. '
          'The final HitTestResult carries all entries with metadata.',
        ),
        _buildPipelineDiagram(),

        // Section 4: HitTestBehavior modes
        _buildSectionTitle(Icons.touch_app, '4. HitTestBehavior Modes'),
        _buildInfoCard(
          'Three Behavior Modes',
          'MetaData accepts a behavior parameter controlling hit test participation: '
          'deferToChild (default), opaque, and translucent.',
        ),
        _buildBehaviorCard(
          'deferToChild',
          HitTestBehavior.deferToChild,
          Color(0xFF1565C0),
          'Default. Only participates in hit test if a child is hit. '
          'If no child at the tap point, this MetaData is not added to the result.',
        ),
        _buildBehaviorCard(
          'opaque',
          HitTestBehavior.opaque,
          Color(0xFFC62828),
          'Always participates in hit test and prevents targets below from being hit. '
          'The MetaData entry is added and blocks further hit testing downward.',
        ),
        _buildBehaviorCard(
          'translucent',
          HitTestBehavior.translucent,
          Color(0xFF6A1B9A),
          'Always participates in hit test but allows targets below to also be hit. '
          'Both this MetaData and targets below appear in HitTestResult.',
        ),

        // Section 5: Nested MetaData
        _buildSectionTitle(Icons.layers, '5. Nested MetaData Widgets'),
        _buildInfoCard(
          'Inner vs Outer',
          'When MetaData widgets are nested, the hit test collects metadata '
          'from all intersecting MetaData ancestors. Inner metadata appears '
          'first in the HitTestResult path.',
        ),
        _buildNestedMetaData(),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFCE93D8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nesting result:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Tap inner-B: entries = [inner-region-B, outer-region-A]',
                style: TextStyle(fontSize: 11, color: Color(0xFF7B1FA2)),
              ),
              Text(
                'Tap inner-C: entries = [inner-region-C, outer-region-A]',
                style: TextStyle(fontSize: 11, color: Color(0xFF7B1FA2)),
              ),
              Text(
                'Tap outer only: entries = [outer-region-A]',
                style: TextStyle(fontSize: 11, color: Color(0xFF7B1FA2)),
              ),
            ],
          ),
        ),

        // Section 6: GestureDetector comparison
        _buildSectionTitle(Icons.compare_arrows, '6. GestureDetector HitTestBehavior'),
        _buildInfoCard(
          'Comparison',
          'GestureDetector also accepts HitTestBehavior. This shows how '
          'the same behavior values affect gesture detection vs metadata tagging.',
        ),
        _buildGestureComparison(),

        // Section 7: Analytics patterns
        _buildSectionTitle(Icons.analytics, '7. Analytics Tagging Pattern'),
        _buildInfoCard(
          'Practical Use',
          'MetaData can carry structured objects (Maps) for analytics tracking. '
          'Hit test handlers can read zone metadata to log impressions and taps.',
        ),
        _buildAnalyticsPattern(),

        // Section 8: Labeled interactive areas
        _buildSectionTitle(Icons.touch_app, '8. Labeled Interactive Areas'),
        _buildInfoCard(
          'UI Region Labels',
          'Each interactive element carries a metadata label identifying its purpose. '
          'Useful for accessibility audits and automated testing frameworks.',
        ),
        _buildLabeledInteractiveAreas(),

        // Summary
        _buildSectionTitle(Icons.summarize, 'Summary'),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00695C), Color(0xFF00897B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RenderMetaData Key Points',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '- MetaData widget stores arbitrary Object in render tree\n'
                '- RenderMetaData is the underlying RenderObject\n'
                '- metaData is attached to HitTestEntry during hit tests\n'
                '- behavior controls hit test participation mode\n'
                '- Nested MetaData collects all ancestors in result path\n'
                '- Practical for analytics zones and accessibility labels\n'
                '- deferToChild / opaque / translucent control event flow',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xDDFFFFFF),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
      ],
    ),
  );
}
