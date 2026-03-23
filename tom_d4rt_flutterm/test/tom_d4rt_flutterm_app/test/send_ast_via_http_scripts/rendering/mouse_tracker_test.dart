// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt Flutter demo: MouseTracker – pointer/hover effect management
// Demonstrates SystemMouseCursors, MouseRegion widget, hover regions,
// enter/exit detection, cursor changes, and practical hover UI patterns.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color theme constants
// ---------------------------------------------------------------------------
const _kBlue500 = Color(0xFF3B82F6);
const _kPink500 = Color(0xFFEC4899);
const _kBlue700 = Color(0xFF1D4ED8);
const _kPink700 = Color(0xFFBE185D);
const _kBlue50 = Color(0xFFEFF6FF);
const _kPink50 = Color(0xFFFDF2F8);
const _kGray100 = Color(0xFFF3F4F6);
const _kGray200 = Color(0xFFE5E7EB);
const _kGray700 = Color(0xFF374151);
const _kGray500 = Color(0xFF6B7280);
const _kWhite = Color(0xFFFFFFFF);

// ---------------------------------------------------------------------------
// Section header helper
// ---------------------------------------------------------------------------
Widget _buildSectionHeader(String number, String title, String subtitle) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 24, bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kBlue500, _kPink500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number  $title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kWhite,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: _kWhite.withAlpha(204)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Info card
// ---------------------------------------------------------------------------
Widget _buildInfoCard(String label, String value, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kWhite,
      border: Border(left: BorderSide(color: accent, width: 4)),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: accent.withAlpha(30),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _kGray700,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: accent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Cursor card – displays a cursor type
// ---------------------------------------------------------------------------
Widget _buildCursorCard(
  String name,
  String description,
  IconData icon,
  Color accent,
  MouseCursor cursor,
) {
  return MouseRegion(
    cursor: cursor,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withAlpha(40)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _kGray700,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: _kGray500, height: 1.4),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accent.withAlpha(15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'hover me',
              style: TextStyle(
                fontSize: 10,
                color: accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Hover region demo tile
// ---------------------------------------------------------------------------
Widget _buildHoverTile(
  String label,
  Color normalColor,
  Color hoverColor,
  IconData icon,
) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: normalColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: hoverColor.withAlpha(60)),
      ),
      child: Row(
        children: [
          Icon(icon, color: hoverColor, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _kGray700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Hover to change cursor to pointer',
                  style: TextStyle(fontSize: 11, color: _kGray500),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: _kGray500, size: 14),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Mouse event row – shows an event type
// ---------------------------------------------------------------------------
Widget _buildEventRow(
  String event,
  String description,
  IconData icon,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withAlpha(10),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent.withAlpha(30)),
    ),
    child: Row(
      children: [
        Icon(icon, color: accent, size: 18),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: _kGray500),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Interactive hover card – simulates hover state
// ---------------------------------------------------------------------------
Widget _buildInteractiveCard(
  String title,
  String subtitle,
  Color accent,
  IconData icon,
  bool isHovered,
) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHovered ? accent.withAlpha(20) : _kWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHovered ? accent : _kGray200,
          width: isHovered ? 2 : 1,
        ),
        boxShadow: isHovered
            ? [
                BoxShadow(
                  color: accent.withAlpha(30),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: _kGray200.withAlpha(80),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accent.withAlpha(isHovered ? 40 : 20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accent, size: 24),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: _kGray700,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: _kGray500, height: 1.3),
                ),
              ],
            ),
          ),
          Text(
            isHovered ? 'HOVERED' : 'normal',
            style: TextStyle(
              fontSize: 11,
              color: isHovered ? accent : _kGray500,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Region diagram box
// ---------------------------------------------------------------------------
Widget _buildRegionBox(String label, Color color, {double size = 80}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Practical nav item
// ---------------------------------------------------------------------------
Widget _buildNavItem(String label, IconData icon, Color accent, bool active) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: active ? accent : _kWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withAlpha(active ? 255 : 80)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: active ? _kWhite : accent, size: 16),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: active ? _kWhite : accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Best practice tip card
// ---------------------------------------------------------------------------
Widget _buildTipCard(String title, String tip, IconData icon, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: accent.withAlpha(10),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accent, size: 20),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kGray700,
                ),
              ),
              SizedBox(height: 3),
              Text(
                tip,
                style: TextStyle(fontSize: 12, color: _kGray500, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// build() entry point
// ===========================================================================
dynamic build(BuildContext context) {
  print('--- MouseTracker Demo ---');
  print('MouseTracker manages hover state and cursor changes');
  print('MouseRegion widget provides enter/exit/hover callbacks');
  print('SystemMouseCursors defines platform cursor shapes');

  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Title ──────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kBlue500, _kPink500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MouseTracker',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _kWhite,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Tracks mouse pointer positions, manages hover regions, '
                'cursor changes, and enter/exit detection for desktop '
                'and web Flutter applications.',
                style: TextStyle(fontSize: 14, color: _kWhite.withAlpha(220)),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _kWhite.withAlpha(40),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Hover',
                      style: TextStyle(
                        color: _kWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _kWhite.withAlpha(40),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Cursors',
                      style: TextStyle(
                        color: _kWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _kWhite.withAlpha(40),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Regions',
                      style: TextStyle(
                        color: _kWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Section 1: Core concepts ──────────────────────────
        _buildSectionHeader(
          '01',
          'Core Concepts',
          'How MouseTracker works in the rendering layer',
        ),
        _buildInfoCard('Class', 'MouseTracker', _kBlue500),
        _buildInfoCard('Layer', 'Rendering (RendererBinding)', _kPink500),
        _buildInfoCard('Widget', 'MouseRegion', _kBlue700),
        _buildInfoCard('Cursors', 'SystemMouseCursors', _kPink700),
        _buildInfoCard('Events', 'Enter / Exit / Hover', _kBlue500),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kBlue50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'MouseTracker lives in the rendering layer and coordinates '
            'with RendererBinding. It maintains a map of mouse pointers '
            'to their current hit-test targets, dispatching enter and '
            'exit events as the pointer moves across widgets.',
            style: TextStyle(fontSize: 12, color: _kGray700, height: 1.5),
          ),
        ),

        // ── Section 2: SystemMouseCursors ─────────────────────
        _buildSectionHeader(
          '02',
          'System Mouse Cursors',
          'Platform-native cursor shapes available in Flutter',
        ),
        _buildCursorCard(
          'SystemMouseCursors.basic',
          'Default arrow cursor – the standard pointer',
          Icons.mouse,
          _kBlue500,
          SystemMouseCursors.basic,
        ),
        _buildCursorCard(
          'SystemMouseCursors.click',
          'Hand/pointer cursor – indicates a clickable element',
          Icons.touch_app,
          _kPink500,
          SystemMouseCursors.click,
        ),
        _buildCursorCard(
          'SystemMouseCursors.text',
          'I-beam cursor – for text selection areas',
          Icons.text_fields,
          _kBlue700,
          SystemMouseCursors.text,
        ),
        _buildCursorCard(
          'SystemMouseCursors.grab',
          'Open-hand cursor – for draggable surfaces',
          Icons.pan_tool,
          _kPink700,
          SystemMouseCursors.grab,
        ),
        _buildCursorCard(
          'SystemMouseCursors.move',
          'Four-way arrow – for moveable elements',
          Icons.open_with,
          _kBlue500,
          SystemMouseCursors.move,
        ),
        _buildCursorCard(
          'SystemMouseCursors.forbidden',
          'Circle with slash – for disabled/blocked areas',
          Icons.block,
          _kPink500,
          SystemMouseCursors.forbidden,
        ),

        // ── Section 3: Mouse events ───────────────────────────
        _buildSectionHeader(
          '03',
          'Mouse Events',
          'Enter, exit and hover callbacks on MouseRegion',
        ),
        _buildEventRow(
          'onEnter',
          'Fires when the pointer enters the region. Receives a '
              'PointerEnterEvent with position and device info.',
          Icons.login,
          _kBlue500,
        ),
        _buildEventRow(
          'onExit',
          'Fires when the pointer leaves the region. Receives a '
              'PointerExitEvent. Use for cleanup or state reset.',
          Icons.logout,
          _kPink500,
        ),
        _buildEventRow(
          'onHover',
          'Fires on every pointer move while inside the region. '
              'Receives a PointerHoverEvent with delta and position.',
          Icons.near_me,
          _kBlue700,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPink50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Note: MouseRegion does not track touch events. For touch '
            'plus mouse, combine with GestureDetector or use Listener '
            'for raw pointer events.',
            style: TextStyle(
              fontSize: 12,
              color: _kGray700,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),

        // ── Section 4: Hover regions diagram ──────────────────
        _buildSectionHeader(
          '04',
          'Hover Regions',
          'MouseRegion creates hit-test targets for the tracker',
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kGray100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Overlapping regions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kGray700,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRegionBox('Region\nA', _kBlue500),
                  _buildRegionBox('Region\nB', _kPink500),
                  _buildRegionBox('Region\nC', _kBlue700),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'When regions overlap, MouseTracker dispatches events '
                'to all hit-tested regions. The topmost paints last but '
                'receives events first.',
                style: TextStyle(fontSize: 12, color: _kGray500, height: 1.4),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBlue500.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nested regions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kBlue700,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _kBlue500.withAlpha(15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kBlue500.withAlpha(60)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Outer MouseRegion',
                      style: TextStyle(fontSize: 11, color: _kBlue500),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 200,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kPink500.withAlpha(15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _kPink500.withAlpha(60)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Inner MouseRegion',
                            style: TextStyle(fontSize: 11, color: _kPink500),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Both receive events',
                            style: TextStyle(fontSize: 10, color: _kGray500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Nested MouseRegions both receive enter/exit events. '
                'The inner region can set a different cursor that '
                'overrides the outer region cursor.',
                style: TextStyle(fontSize: 12, color: _kGray500, height: 1.4),
              ),
            ],
          ),
        ),

        // ── Section 5: Hover effect examples ──────────────────
        _buildSectionHeader(
          '05',
          'Hover Effect Examples',
          'Practical hover patterns for desktop/web UIs',
        ),
        _buildInteractiveCard(
          'Inbox',
          '4 unread messages',
          _kBlue500,
          Icons.mail_outline,
          false,
        ),
        _buildInteractiveCard(
          'Inbox (hovered)',
          '4 unread messages',
          _kBlue500,
          Icons.mail,
          true,
        ),
        _buildInteractiveCard(
          'Notifications',
          '12 new alerts',
          _kPink500,
          Icons.notifications_none,
          false,
        ),
        _buildInteractiveCard(
          'Notifications (hovered)',
          '12 new alerts',
          _kPink500,
          Icons.notifications_active,
          true,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kBlue50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'In a real app, use StatefulWidget with MouseRegion callbacks '
            'to toggle the isHovered flag. The demo shows both states '
            'statically for illustration.',
            style: TextStyle(fontSize: 12, color: _kGray700, height: 1.5),
          ),
        ),

        // ── Section 6: Navigation hover tiles ─────────────────
        _buildSectionHeader(
          '06',
          'Navigation Hover Tiles',
          'MouseRegion in list items and navigation menus',
        ),
        _buildHoverTile('Dashboard', _kBlue50, _kBlue500, Icons.dashboard),
        _buildHoverTile('Analytics', _kPink50, _kPink500, Icons.analytics),
        _buildHoverTile('Settings', _kBlue50, _kBlue700, Icons.settings),
        _buildHoverTile('Profile', _kPink50, _kPink700, Icons.person),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kGray100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              _buildNavItem('Home', Icons.home, _kBlue500, true),
              _buildNavItem('Search', Icons.search, _kBlue500, false),
              _buildNavItem('Saved', Icons.bookmark_border, _kPink500, false),
              _buildNavItem('More', Icons.more_horiz, _kPink500, false),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Each nav item uses MouseRegion(cursor: SystemMouseCursors.click) '
          'to show a pointer hand on hover.',
          style: TextStyle(fontSize: 11, color: _kGray500),
        ),

        // ── Section 7: Cursor management ──────────────────────
        _buildSectionHeader(
          '07',
          'Cursor Management',
          'How MouseTracker resolves cursor from the widget tree',
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kGray200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cursor resolution order',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kBlue700,
                ),
              ),
              SizedBox(height: 8),
              _buildEventRow(
                '1. Topmost MouseRegion',
                'The cursor of the frontmost region in the hit-test wins',
                Icons.layers,
                _kBlue500,
              ),
              _buildEventRow(
                '2. MouseCursor.defer',
                'If cursor is set to defer, falls through to the next region',
                Icons.arrow_downward,
                _kPink500,
              ),
              _buildEventRow(
                '3. SystemMouseCursors.basic',
                'Default fallback if no region claims the cursor',
                Icons.mouse,
                _kBlue700,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kPink50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kPink500.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Code pattern',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kPink700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'MouseRegion(\n'
                '  cursor: SystemMouseCursors.click,\n'
                '  onEnter: (_) => setState(() => hovered = true),\n'
                '  onExit: (_) => setState(() => hovered = false),\n'
                '  child: AnimatedContainer(\n'
                '    duration: Duration(milliseconds: 200),\n'
                '    color: hovered ? accent : Colors.white,\n'
                '    child: content,\n'
                '  ),\n'
                ')',
                style: TextStyle(
                  fontSize: 12,
                  color: _kGray700,
                  fontFamily: 'monospace',
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        // ── Section 8: Best practices ─────────────────────────
        _buildSectionHeader(
          '08',
          'Best Practices',
          'Tips for effective mouse tracking in Flutter',
        ),
        _buildTipCard(
          'Use MouseRegion for hover only',
          'MouseRegion is lighter than GestureDetector. Use it purely '
              'for hover/cursor, not for taps or drags.',
          Icons.lightbulb_outline,
          _kBlue500,
        ),
        _buildTipCard(
          'Set cursor on interactive widgets',
          'Always set SystemMouseCursors.click on buttons, links, and '
              'clickable cards for accessibility on desktop/web.',
          Icons.accessibility_new,
          _kPink500,
        ),
        _buildTipCard(
          'Avoid excessive onHover callbacks',
          'onHover fires on every pixel movement. Debounce expensive '
              'operations or use it only for lightweight visual feedback.',
          Icons.speed,
          _kBlue700,
        ),
        _buildTipCard(
          'Test with mouse and trackpad',
          'Mouse and trackpad may behave differently. Test hover states '
              'on both input devices, especially on macOS.',
          Icons.devices,
          _kPink700,
        ),
        _buildTipCard(
          'Handle onExit for cleanup',
          'Always reset hover state in onExit. If the widget is removed '
              'while hovered, onExit may not fire – use dispose() as backup.',
          Icons.cleaning_services,
          _kBlue500,
        ),
        _buildTipCard(
          'Combine with AnimatedContainer',
          'For smooth hover transitions, wrap content in '
              'AnimatedContainer and toggle properties in onEnter/onExit.',
          Icons.animation,
          _kPink500,
        ),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 4),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kBlue50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kBlue500.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kBlue700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• MouseTracker lives in the rendering layer.\n'
                '• MouseRegion is the widget-level API for hover.\n'
                '• SystemMouseCursors provides platform-native cursors.\n'
                '• Events: onEnter, onExit, onHover.\n'
                '• Cursor resolution: topmost region wins.\n'
                '• Essential for desktop and web Flutter apps.',
                style: TextStyle(fontSize: 12, color: _kGray700, height: 1.6),
              ),
            ],
          ),
        ),

        // ── Footer ────────────────────────────────────────────
        SizedBox(height: 20),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kBlue500.withAlpha(60), _kPink500.withAlpha(60)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'MouseTracker Demo • Blue / Pink',
              style: TextStyle(
                fontSize: 12,
                color: _kGray700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
