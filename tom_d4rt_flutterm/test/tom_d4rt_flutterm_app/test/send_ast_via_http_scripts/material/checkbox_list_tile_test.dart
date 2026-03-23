// ignore_for_file: avoid_print
// D4rt test script: Tests CheckboxListTile from material
import 'package:flutter/material.dart';

// Helper for section header
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

// Helper for a visual checkbox tile representation
Widget buildCheckboxTileVisual(String title, String subtitle, bool checked, Color activeColor,
    Color checkColor, bool enabled, bool dense, bool tristate, IconData secondaryIcon, Color tileColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    decoration: BoxDecoration(
      color: tileColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: enabled ? Colors.grey.shade300 : Colors.grey.shade200),
    ),
    child: ListTile(
      dense: dense,
      enabled: enabled,
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: checked ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: enabled ? (checked ? activeColor : Colors.grey.shade400) : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: checked ? Icon(tristate ? Icons.remove : Icons.check, size: 16, color: checkColor) : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: dense ? 13 : 15,
          color: enabled ? Colors.black87 : Colors.grey.shade400,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: dense ? 11 : 12,
          color: enabled ? Colors.grey.shade600 : Colors.grey.shade400,
        ),
      ),
      trailing: Icon(secondaryIcon, color: enabled ? Colors.grey.shade500 : Colors.grey.shade300),
    ),
  );
}

// Helper for control position demo
Widget buildControlPositionCard(String label, bool isLeading, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: isLeading
          ? [
              Container(
                width: 22, height: 22,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.check, size: 14, color: Colors.white),
              ),
              SizedBox(width: 12),
              Expanded(child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
              Icon(Icons.info_outline, color: Colors.grey, size: 18),
            ]
          : [
              Icon(Icons.info_outline, color: Colors.grey, size: 18),
              SizedBox(width: 12),
              Expanded(child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
              Container(
                width: 22, height: 22,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ],
    ),
  );
}

// Helper for shape showcase
Widget buildShapeShowcaseRow(String label, double radius, Color color, bool checked) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 24, height: 24,
          decoration: BoxDecoration(
            color: checked ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: color, width: 2),
          ),
          child: checked ? Icon(Icons.check, size: 14, color: Colors.white) : null,
        ),
        SizedBox(width: 12),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Spacer(),
        Text('radius: ${radius.toInt()}', style: TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    ),
  );
}

// Helper for color comparison tile
Widget buildColorComparisonTile(String label, Color active, Color check, Color tile) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: tile,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: active.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 24, height: 24,
          decoration: BoxDecoration(
            color: active,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(Icons.check, size: 14, color: check),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text('active: $active / check: $check', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: active.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('ON', style: TextStyle(fontSize: 10, color: active, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

// Helper for state badge
Widget buildStateBadge(String label, Color color, bool active) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    margin: EdgeInsets.only(right: 6, bottom: 4),
    decoration: BoxDecoration(
      color: active ? color : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10,
        color: active ? Colors.white : Colors.grey.shade600,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== CheckboxListTile Visual Test ===');
  debugPrint('Demonstrating all checkbox list tile configurations');

  debugPrint('Testing checked / unchecked / tristate');
  debugPrint('Testing control positions');
  debugPrint('Testing colors, shapes, dense mode');
  debugPrint('Testing enabled / disabled states');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('CheckboxListTile Demo'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Basic States
            buildSectionHeader('Basic States', Icons.check_box, Colors.green),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'CheckboxListTile combines a checkbox with a list tile for settings-style controls',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildCheckboxTileVisual('Checked Item', 'This item is currently checked', true,
                Colors.blue, Colors.white, true, false, false, Icons.settings, Colors.white),
            buildCheckboxTileVisual('Unchecked Item', 'This item is not checked', false,
                Colors.blue, Colors.white, true, false, false, Icons.settings, Colors.white),
            buildCheckboxTileVisual('Tristate (null)', 'Indeterminate/partial state with dash', true,
                Colors.orange, Colors.white, true, false, true, Icons.settings, Colors.white),
            buildCheckboxTileVisual('Disabled Checked', 'Cannot interact with this item', true,
                Colors.grey, Colors.white, false, false, false, Icons.settings, Colors.white),
            buildCheckboxTileVisual('Disabled Unchecked', 'Cannot interact - unchecked', false,
                Colors.grey, Colors.white, false, false, false, Icons.settings, Colors.white),

            // Section 2: State Badges Overview
            buildSectionHeader('State Overview', Icons.info, Colors.blue),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                children: [
                  buildStateBadge('checked: true', Colors.green, true),
                  buildStateBadge('checked: false', Colors.red, true),
                  buildStateBadge('checked: null', Colors.orange, true),
                  buildStateBadge('enabled', Colors.blue, true),
                  buildStateBadge('disabled', Colors.grey, true),
                  buildStateBadge('tristate', Colors.purple, true),
                  buildStateBadge('dense', Colors.teal, true),
                  buildStateBadge('leading', Colors.indigo, true),
                  buildStateBadge('trailing', Colors.brown, true),
                ],
              ),
            ),

            // Section 3: Control Position
            buildSectionHeader('Control Position', Icons.swap_horiz, Colors.indigo),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Checkbox can appear at leading or trailing position',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildControlPositionCard('Leading position (checkbox at start)', true, Colors.green),
            buildControlPositionCard('Leading with blue accent', true, Colors.blue),
            buildControlPositionCard('Leading with purple accent', true, Colors.purple),
            SizedBox(height: 8),
            buildControlPositionCard('Trailing position (checkbox at end)', false, Colors.green),
            buildControlPositionCard('Trailing with orange accent', false, Colors.orange),
            buildControlPositionCard('Trailing with red accent', false, Colors.red),

            // Section 4: Active Colors
            buildSectionHeader('Active Colors', Icons.palette, Colors.purple),
            buildColorComparisonTile('Blue Active / White Check', Colors.blue, Colors.white, Colors.blue.shade50),
            buildColorComparisonTile('Green Active / White Check', Colors.green, Colors.white, Colors.green.shade50),
            buildColorComparisonTile('Red Active / White Check', Colors.red, Colors.white, Colors.red.shade50),
            buildColorComparisonTile('Purple Active / Yellow Check', Colors.purple, Colors.yellow, Colors.purple.shade50),
            buildColorComparisonTile('Orange Active / Black Check', Colors.orange, Colors.black, Colors.orange.shade50),
            buildColorComparisonTile('Teal Active / White Check', Colors.teal, Colors.white, Colors.teal.shade50),
            buildColorComparisonTile('Pink Active / White Check', Colors.pink, Colors.white, Colors.pink.shade50),
            buildColorComparisonTile('Indigo Active / Amber Check', Colors.indigo, Colors.amber, Colors.indigo.shade50),

            // Section 5: Shape Variations
            buildSectionHeader('Checkbox Shapes', Icons.crop_square, Colors.teal),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Different border radius values for checkbox shape', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
            ),
            buildShapeShowcaseRow('Sharp Square', 0, Colors.blue, true),
            buildShapeShowcaseRow('Slightly Rounded', 2, Colors.green, true),
            buildShapeShowcaseRow('Rounded', 4, Colors.orange, true),
            buildShapeShowcaseRow('More Rounded', 8, Colors.purple, true),
            buildShapeShowcaseRow('Circle', 12, Colors.red, true),
            buildShapeShowcaseRow('Sharp Unchecked', 0, Colors.blue, false),
            buildShapeShowcaseRow('Rounded Unchecked', 4, Colors.green, false),
            buildShapeShowcaseRow('Circle Unchecked', 12, Colors.red, false),

            // Section 6: Dense Mode
            buildSectionHeader('Dense Mode', Icons.density_small, Colors.orange),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Dense mode reduces vertical padding for compact lists', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
            ),
            buildCheckboxTileVisual('Normal Density', 'Standard padding and sizing', true,
                Colors.blue, Colors.white, true, false, false, Icons.fullscreen, Colors.white),
            buildCheckboxTileVisual('Dense Tile 1', 'Compact padding for space efficiency', true,
                Colors.blue, Colors.white, true, true, false, Icons.fullscreen_exit, Colors.white),
            buildCheckboxTileVisual('Dense Tile 2', 'Good for settings lists', true,
                Colors.green, Colors.white, true, true, false, Icons.tune, Colors.white),
            buildCheckboxTileVisual('Dense Tile 3', 'Maximizes vertical space', false,
                Colors.green, Colors.white, true, true, false, Icons.compress, Colors.white),
            buildCheckboxTileVisual('Dense Disabled', 'Compact but not interactive', true,
                Colors.grey, Colors.white, false, true, false, Icons.block, Colors.grey.shade50),

            // Section 7: Secondary Widget
            buildSectionHeader('Secondary Widgets', Icons.widgets, Colors.deepPurple),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Different trailing/secondary widget options', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
            ),
            buildCheckboxTileVisual('With Info Icon', 'Shows info icon as secondary', true,
                Colors.blue, Colors.white, true, false, false, Icons.info, Colors.white),
            buildCheckboxTileVisual('With Arrow Icon', 'Shows forward arrow as secondary', true,
                Colors.green, Colors.white, true, false, false, Icons.arrow_forward_ios, Colors.white),
            buildCheckboxTileVisual('With Delete Icon', 'Shows delete icon as secondary', false,
                Colors.blue, Colors.white, true, false, false, Icons.delete, Colors.white),
            buildCheckboxTileVisual('With Edit Icon', 'Shows edit icon as secondary', true,
                Colors.orange, Colors.white, true, false, false, Icons.edit, Colors.white),
            buildCheckboxTileVisual('With Star Icon', 'Shows star icon as secondary', true,
                Colors.amber, Colors.white, true, false, false, Icons.star, Colors.white),
            buildCheckboxTileVisual('With Link Icon', 'Shows link icon as secondary', false,
                Colors.blue, Colors.white, true, false, false, Icons.link, Colors.white),

            // Section 8: Tile Color Backgrounds
            buildSectionHeader('Tile Colors', Icons.format_paint, Colors.brown),
            buildCheckboxTileVisual('Blue Background', 'Tile with blue tint', true,
                Colors.blue.shade800, Colors.white, true, false, false, Icons.color_lens, Colors.blue.shade50),
            buildCheckboxTileVisual('Green Background', 'Tile with green tint', true,
                Colors.green.shade800, Colors.white, true, false, false, Icons.color_lens, Colors.green.shade50),
            buildCheckboxTileVisual('Orange Background', 'Tile with orange tint', false,
                Colors.orange, Colors.white, true, false, false, Icons.color_lens, Colors.orange.shade50),
            buildCheckboxTileVisual('Purple Background', 'Tile with purple tint', true,
                Colors.purple, Colors.white, true, false, false, Icons.color_lens, Colors.purple.shade50),
            buildCheckboxTileVisual('Grey Background', 'Tile with grey tint', true,
                Colors.grey.shade700, Colors.white, true, false, false, Icons.color_lens, Colors.grey.shade100),

            // Section 9: Settings Page Simulation
            buildSectionHeader('Settings Page Example', Icons.settings, Colors.blueGrey),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('App Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Divider(),
                  buildCheckboxTileVisual('Dark Mode', 'Use dark theme throughout the app', true,
                      Colors.blue, Colors.white, true, true, false, Icons.dark_mode, Colors.transparent),
                  buildCheckboxTileVisual('Notifications', 'Enable push notifications', true,
                      Colors.blue, Colors.white, true, true, false, Icons.notifications, Colors.transparent),
                  buildCheckboxTileVisual('Sound Effects', 'Play sounds for actions', false,
                      Colors.blue, Colors.white, true, true, false, Icons.volume_up, Colors.transparent),
                  buildCheckboxTileVisual('Auto-Update', 'Automatically check for updates', true,
                      Colors.blue, Colors.white, true, true, false, Icons.update, Colors.transparent),
                  buildCheckboxTileVisual('Analytics', 'Share usage data', false,
                      Colors.blue, Colors.white, true, true, false, Icons.analytics, Colors.transparent),
                  buildCheckboxTileVisual('Location Access', 'Allow location services', true,
                      Colors.blue, Colors.white, true, true, false, Icons.location_on, Colors.transparent),
                  buildCheckboxTileVisual('Biometric Login', 'Use fingerprint to unlock', false,
                      Colors.blue, Colors.white, false, true, false, Icons.fingerprint, Colors.grey.shade50),
                ],
              ),
            ),

            // Summary
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade50, Colors.teal.shade50],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Properties Demonstrated:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      Chip(label: Text('value', style: TextStyle(fontSize: 10)), backgroundColor: Colors.green.shade100),
                      Chip(label: Text('tristate', style: TextStyle(fontSize: 10)), backgroundColor: Colors.orange.shade100),
                      Chip(label: Text('controlAffinity', style: TextStyle(fontSize: 10)), backgroundColor: Colors.indigo.shade100),
                      Chip(label: Text('activeColor', style: TextStyle(fontSize: 10)), backgroundColor: Colors.purple.shade100),
                      Chip(label: Text('checkColor', style: TextStyle(fontSize: 10)), backgroundColor: Colors.blue.shade100),
                      Chip(label: Text('dense', style: TextStyle(fontSize: 10)), backgroundColor: Colors.teal.shade100),
                      Chip(label: Text('secondary', style: TextStyle(fontSize: 10)), backgroundColor: Colors.deepPurple.shade100),
                      Chip(label: Text('tileColor', style: TextStyle(fontSize: 10)), backgroundColor: Colors.brown.shade100),
                      Chip(label: Text('shape', style: TextStyle(fontSize: 10)), backgroundColor: Colors.cyan.shade100),
                      Chip(label: Text('enabled', style: TextStyle(fontSize: 10)), backgroundColor: Colors.red.shade100),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
