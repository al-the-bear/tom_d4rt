// ignore_for_file: avoid_print
// D4rt test script: Tests ExpandIcon from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ExpandIcon Visual Demo ===');
  print('Demonstrating ExpandIcon widget in various states and configurations');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('ExpandIcon Demo'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Expand/Collapse States'),
            SizedBox(height: 8),
            _buildExpandCollapseStates(),
            SizedBox(height: 24),
            buildSectionHeader('Size Variations'),
            SizedBox(height: 8),
            _buildSizeVariations(),
            SizedBox(height: 24),
            buildSectionHeader('Color Configurations'),
            SizedBox(height: 8),
            _buildColorConfigurations(),
            SizedBox(height: 24),
            buildSectionHeader('Padding Variations'),
            SizedBox(height: 8),
            _buildPaddingVariations(),
            SizedBox(height: 24),
            buildSectionHeader('ExpandIcon in List Context'),
            SizedBox(height: 8),
            _buildListContext(),
            SizedBox(height: 24),
            buildSectionHeader('ExpansionTile-Like Layouts'),
            SizedBox(height: 8),
            _buildExpansionTileLayouts(),
            SizedBox(height: 24),
            buildSectionHeader('Icon Arrow Direction Visual'),
            SizedBox(height: 8),
            _buildArrowDirectionVisual(),
            SizedBox(height: 24),
            buildSectionHeader('Disabled vs Enabled States'),
            SizedBox(height: 8),
            _buildDisabledEnabledStates(),
            SizedBox(height: 24),
            buildSectionHeader('ExpandIcon Properties Reference'),
            SizedBox(height: 8),
            _buildPropertiesReference(),
            SizedBox(height: 24),
            buildSectionHeader('Use Cases Gallery'),
            SizedBox(height: 8),
            _buildUseCasesGallery(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      SizedBox(width: 8),
      Expanded(child: Text(value, style: TextStyle(fontSize: 14, color: Colors.grey.shade700))),
    ]),
  );
}

Widget _buildExpandCollapseStates() {
  print('Building expand/collapse states');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80CBC4)),
    ),
    child: Column(
      children: [
        Text('ExpandIcon rotates arrow between collapsed and expanded',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF00897B), width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFF00897B).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.expand_more, size: 48, color: Color(0xFF00897B)),
                    ),
                    SizedBox(height: 12),
                    Text('COLLAPSED', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF00897B))),
                    SizedBox(height: 4),
                    Text('isExpanded: false', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF757575))),
                    SizedBox(height: 4),
                    Text('Arrow points DOWN', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Column(
              children: [
                Icon(Icons.arrow_forward, color: Color(0xFF00897B), size: 28),
                Text('tap', style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE65100), width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFE65100).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.expand_less, size: 48, color: Color(0xFFE65100)),
                    ),
                    SizedBox(height: 12),
                    Text('EXPANDED', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFFE65100))),
                    SizedBox(height: 4),
                    Text('isExpanded: true', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF757575))),
                    SizedBox(height: 4),
                    Text('Arrow points UP', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Animation:', '180 degree rotation between states'),
      ],
    ),
  );
}

Widget _buildSizeVariations() {
  print('Building size variations');
  List<Widget> rows = [];

  rows.add(_buildSizeRow('Extra Small', 16.0, Color(0xFF4CAF50)));
  rows.add(SizedBox(height: 8));
  rows.add(_buildSizeRow('Small', 20.0, Color(0xFF2196F3)));
  rows.add(SizedBox(height: 8));
  rows.add(_buildSizeRow('Default (24)', 24.0, Color(0xFF00897B)));
  rows.add(SizedBox(height: 8));
  rows.add(_buildSizeRow('Medium', 32.0, Color(0xFFFF9800)));
  rows.add(SizedBox(height: 8));
  rows.add(_buildSizeRow('Large', 40.0, Color(0xFFF44336)));
  rows.add(SizedBox(height: 8));
  rows.add(_buildSizeRow('Extra Large', 48.0, Color(0xFF6A1B9A)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ExpandIcon size property controls icon size',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildSizeRow(String label, double size, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Row(
      children: [
        Container(
          width: 60, height: 60,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Icon(Icons.expand_more, size: size, color: color)),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color)),
              Text('size: ${size.toInt()} logical pixels', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF757575))),
            ],
          ),
        ),
        Container(
          width: size + 16, height: size + 16,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(child: Icon(Icons.expand_more, size: size, color: color)),
        ),
      ],
    ),
  );
}

Widget _buildColorConfigurations() {
  print('Building color configurations');
  List<Widget> items = [];

  items.add(_buildColorRow('Default (grey)', Color(0xFF757575), Color(0xFF424242)));
  items.add(SizedBox(height: 6));
  items.add(_buildColorRow('Primary Blue', Color(0xFF1565C0), Color(0xFF0D47A1)));
  items.add(SizedBox(height: 6));
  items.add(_buildColorRow('Success Green', Color(0xFF2E7D32), Color(0xFF1B5E20)));
  items.add(SizedBox(height: 6));
  items.add(_buildColorRow('Warning Orange', Color(0xFFE65100), Color(0xFFBF360C)));
  items.add(SizedBox(height: 6));
  items.add(_buildColorRow('Error Red', Color(0xFFC62828), Color(0xFFB71C1C)));
  items.add(SizedBox(height: 6));
  items.add(_buildColorRow('Purple Accent', Color(0xFF6A1B9A), Color(0xFF4A148C)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ExpandIcon color and expandedColor properties',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('color:', 'Icon color when collapsed'),
        buildInfoCard('expandedColor:', 'Icon color when expanded'),
      ],
    ),
  );
}

Widget _buildColorRow(String label, Color collapsed, Color expanded) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Expanded(child: SizedBox()),
        Column(
          children: [
            Icon(Icons.expand_more, size: 28, color: collapsed),
            Text('collapsed', style: TextStyle(fontSize: 9, color: Color(0xFF9E9E9E))),
          ],
        ),
        SizedBox(width: 20),
        Column(
          children: [
            Icon(Icons.expand_less, size: 28, color: expanded),
            Text('expanded', style: TextStyle(fontSize: 9, color: Color(0xFF9E9E9E))),
          ],
        ),
        SizedBox(width: 12),
        Container(
          width: 20, height: 20,
          decoration: BoxDecoration(
            color: collapsed, shape: BoxShape.circle,
            border: Border.all(color: Color(0xFFFFFFFF), width: 2),
          ),
        ),
        SizedBox(width: 4),
        Container(
          width: 20, height: 20,
          decoration: BoxDecoration(
            color: expanded, shape: BoxShape.circle,
            border: Border.all(color: Color(0xFFFFFFFF), width: 2),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPaddingVariations() {
  print('Building padding variations');
  List<Widget> pads = [];

  pads.add(_buildPaddingRow('No padding', 0.0, Color(0xFFF44336)));
  pads.add(SizedBox(height: 8));
  pads.add(_buildPaddingRow('4px padding', 4.0, Color(0xFFFF9800)));
  pads.add(SizedBox(height: 8));
  pads.add(_buildPaddingRow('Default (8px)', 8.0, Color(0xFF00897B)));
  pads.add(SizedBox(height: 8));
  pads.add(_buildPaddingRow('12px padding', 12.0, Color(0xFF2196F3)));
  pads.add(SizedBox(height: 8));
  pads.add(_buildPaddingRow('16px padding', 16.0, Color(0xFF6A1B9A)));
  pads.add(SizedBox(height: 8));
  pads.add(_buildPaddingRow('24px padding', 24.0, Color(0xFF424242)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Padding controls the ExpandIcon touch target area',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: pads),
      ],
    ),
  );
}

Widget _buildPaddingRow(String label, double pad, Color color) {
  double totalSize = 24.0 + (pad * 2);
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Container(
          width: totalSize, height: totalSize,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Container(
              width: 24, height: 24,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(child: Icon(Icons.expand_more, size: 20, color: color)),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
              Text('Total touch target: ${totalSize.toInt()}x${totalSize.toInt()} px',
                  style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildListContext() {
  print('Building list context');
  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < 5; i = i + 1) {
    String title = '';
    String subtitle = '';
    IconData icon = Icons.folder;
    if (i == 0) { title = 'Documents'; subtitle = '14 files'; icon = Icons.folder; }
    if (i == 1) { title = 'Photos'; subtitle = '238 items'; icon = Icons.photo_library; }
    if (i == 2) { title = 'Music'; subtitle = '56 tracks'; icon = Icons.music_note; }
    if (i == 3) { title = 'Downloads'; subtitle = '7 files'; icon = Icons.download; }
    if (i == 4) { title = 'Settings'; subtitle = '12 options'; icon = Icons.settings; }

    bool expanded = (i == 1);
    items.add(Container(
      margin: EdgeInsets.only(bottom: 2),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: expanded ? Color(0xFFE0F2F1) : Color(0xFFFFFFFF),
        border: Border.all(color: expanded ? Color(0xFF00897B) : Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, color: expanded ? Color(0xFF00897B) : Color(0xFF757575), size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
              ],
            ),
          ),
          Icon(
            expanded ? Icons.expand_less : Icons.expand_more,
            color: expanded ? Color(0xFF00897B) : Color(0xFF757575),
            size: 24,
          ),
        ],
      ),
    ));
    if (expanded) {
      items.add(Container(
        margin: EdgeInsets.only(bottom: 2, left: 40),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text('Expanded content for $title would appear here',
            style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
      ));
    }
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ExpandIcon in a file browser list',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget _buildExpansionTileLayouts() {
  print('Building ExpansionTile-like layouts');
  List<Widget> tiles = [];

  tiles.add(_buildMockExpansionTile('General Settings', Icons.settings, Color(0xFF1565C0), false));
  tiles.add(SizedBox(height: 8));
  tiles.add(_buildMockExpansionTile('Privacy & Security', Icons.security, Color(0xFF00897B), true));
  tiles.add(SizedBox(height: 8));
  tiles.add(_buildMockExpansionTile('Notifications', Icons.notifications, Color(0xFFE65100), false));
  tiles.add(SizedBox(height: 8));
  tiles.add(_buildMockExpansionTile('About', Icons.info, Color(0xFF6A1B9A), false));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFD1C4E9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ExpandIcon in ExpansionTile-like layouts',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: tiles),
      ],
    ),
  );
}

Widget _buildMockExpansionTile(String title, IconData icon, Color color, bool expanded) {
  List<Widget> children = [];
  children.add(Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: expanded ? color.withValues(alpha: 0.08) : Color(0xFFFFFFFF),
      borderRadius: expanded
          ? BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
          : BorderRadius.circular(8),
      border: Border.all(color: expanded ? color : Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(width: 12),
        Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
        Icon(expanded ? Icons.expand_less : Icons.expand_more, color: color, size: 24),
      ],
    ),
  ));

  if (expanded) {
    children.add(Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Privacy options expanded', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          SizedBox(height: 8),
          Text('Two-Factor Authentication: Enabled', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
          SizedBox(height: 4),
          Text('Location Access: Restricted', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
          SizedBox(height: 4),
          Text('Data Sharing: Disabled', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
        ],
      ),
    ));
  }

  return Column(children: children);
}

Widget _buildArrowDirectionVisual() {
  print('Building arrow direction visual');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFE082)),
    ),
    child: Column(
      children: [
        Text('Arrow Rotation Animation (0 to 180 degrees)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAngleStep('0', Icons.expand_more, Color(0xFF2E7D32)),
            _buildAngleStep('45', Icons.south_east, Color(0xFF558B2F)),
            _buildAngleStep('90', Icons.chevron_right, Color(0xFF9E9D24)),
            _buildAngleStep('135', Icons.north_east, Color(0xFFF57F17)),
            _buildAngleStep('180', Icons.expand_less, Color(0xFFE65100)),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E7D32), Color(0xFF9E9D24), Color(0xFFE65100)],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Collapsed', style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32))),
            Text('Expanded', style: TextStyle(fontSize: 10, color: Color(0xFFE65100))),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAngleStep(String degrees, IconData icon, Color color) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
        ),
        child: Icon(icon, color: color, size: 28),
      ),
      SizedBox(height: 4),
      Text('$degrees deg', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}

Widget _buildDisabledEnabledStates() {
  print('Building disabled/enabled states');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF4CAF50), width: 2),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.expand_more, size: 36, color: Color(0xFF4CAF50)),
                ),
                SizedBox(height: 12),
                Text('ENABLED', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF4CAF50))),
                SizedBox(height: 4),
                Text('onPressed != null', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF757575))),
                SizedBox(height: 8),
                Text('Responds to taps', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
                Text('Shows splash effect', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
                Text('Full color icon', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFFBDBDBD), width: 2),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.expand_more, size: 36, color: Color(0xFFBDBDBD)),
                ),
                SizedBox(height: 12),
                Text('DISABLED', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFFBDBDBD))),
                SizedBox(height: 4),
                Text('onPressed == null', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF757575))),
                SizedBox(height: 8),
                Text('No tap response', style: TextStyle(fontSize: 12, color: Color(0xFFBDBDBD))),
                Text('No splash effect', style: TextStyle(fontSize: 12, color: Color(0xFFBDBDBD))),
                Text('Greyed out icon', style: TextStyle(fontSize: 12, color: Color(0xFFBDBDBD))),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertiesReference() {
  print('Building properties reference');
  List<Widget> rows = [];
  rows.add(_buildPropRow('isExpanded', 'bool', 'Whether the icon shows expanded state', Color(0xFF1565C0)));
  rows.add(_buildPropRow('size', 'double', 'Size of the icon (default 24.0)', Color(0xFF00897B)));
  rows.add(_buildPropRow('color', 'Color', 'Color of the icon when collapsed', Color(0xFFE65100)));
  rows.add(_buildPropRow('expandedColor', 'Color', 'Color of the icon when expanded', Color(0xFF6A1B9A)));
  rows.add(_buildPropRow('disabledColor', 'Color', 'Color when onPressed is null', Color(0xFFC62828)));
  rows.add(_buildPropRow('onPressed', 'Function(bool)', 'Callback when icon is tapped', Color(0xFF283593)));
  rows.add(_buildPropRow('padding', 'EdgeInsetsGeometry', 'Padding around the icon', Color(0xFF00695C)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(flex: 2, child: Text('Property', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(flex: 2, child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(flex: 3, child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          ],
        ),
        Divider(color: Color(0xFFBDBDBD)),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildPropRow(String name, String type, String desc, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
    ),
    child: Row(
      children: [
        Expanded(flex: 2, child: Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: color, fontWeight: FontWeight.bold))),
        Expanded(flex: 2, child: Text(type, style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF616161)))),
        Expanded(flex: 3, child: Text(desc, style: TextStyle(fontSize: 11, color: Color(0xFF757575)))),
      ],
    ),
  );
}

Widget _buildUseCasesGallery() {
  print('Building use cases gallery');
  List<Widget> useCases = [];

  useCases.add(_buildUseCaseCard('Accordion Menu', 'Expandable navigation menu items', Icons.menu, Color(0xFF1565C0)));
  useCases.add(SizedBox(height: 8));
  useCases.add(_buildUseCaseCard('FAQ Section', 'Question/answer expandable list', Icons.help_outline, Color(0xFF00897B)));
  useCases.add(SizedBox(height: 8));
  useCases.add(_buildUseCaseCard('Settings Panel', 'Collapsible settings groups', Icons.settings, Color(0xFFE65100)));
  useCases.add(SizedBox(height: 8));
  useCases.add(_buildUseCaseCard('Data Table', 'Row detail expansion', Icons.table_chart, Color(0xFF6A1B9A)));
  useCases.add(SizedBox(height: 8));
  useCases.add(_buildUseCaseCard('Comment Thread', 'Expand reply chains', Icons.comment, Color(0xFFC62828)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Common ExpandIcon Use Cases',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: useCases),
      ],
    ),
  );
}

Widget _buildUseCaseCard(String title, String desc, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
              Text(desc, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
            ],
          ),
        ),
        Icon(Icons.expand_more, color: color.withValues(alpha: 0.5), size: 20),
      ],
    ),
  );
}
