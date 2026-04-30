// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — RawMenuOverlayInfo
// Demonstrates RawMenuOverlayInfo — a data class that provides
// menu positioning information: anchor rectangle, overlay size,
// optional offset, and tap region grouping. Covers overlay
// positioning, anchor geometry, tap-outside behavior, equality,
// and practical menu layout patterns.
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('RawMenuOverlayInfo Deep Demo executing');

  // ============================================================
  // SECTION 1: What is RawMenuOverlayInfo?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.menu_open,
      'title': 'Menu Positioning Data',
      'body': 'RawMenuOverlayInfo is a data class passed to the '
          'overlayBuilder callback of RawMenuAnchor. It carries all '
          'the geometric information needed to position and size a '
          'menu overlay relative to its anchor widget.',
      'accent': Colors.blueGrey[700]!,
    },
    {
      'icon': Icons.crop_square,
      'title': 'Anchor Rect',
      'body': 'The anchorRect property provides the bounding rectangle '
          'of the anchor widget in overlay coordinates. Use this to '
          'position the menu below, above, or beside the trigger '
          'button that opened it.',
      'accent': Colors.blue[700]!,
    },
    {
      'icon': Icons.aspect_ratio,
      'title': 'Overlay Size',
      'body': 'The overlaySize property gives the full dimensions of '
          'the overlay (typically the screen or a route\'s overlay). '
          'Use this to constrain the menu so it doesn\'t overflow '
          'the available space.',
      'accent': Colors.blueGrey[600]!,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Tap Region Grouping',
      'body': 'The tapRegionGroupId groups the anchor and menu into '
          'a single tap region. Taps outside this region dismiss '
          'the menu, while taps inside (on menu items or anchor) '
          'are treated as intentional interactions.',
      'accent': Colors.blue[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'anchorRect',
      'type': 'ui.Rect',
      'icon': Icons.crop_square,
      'color': Colors.blueGrey[700]!,
      'description': 'The bounding rectangle of the anchor widget in '
          'overlay coordinates. The rect\'s left/top gives the anchor\'s '
          'position; width/height give its size. Use this to align the '
          'menu edge to the anchor edge.',
    },
    {
      'name': 'overlaySize',
      'type': 'ui.Size',
      'icon': Icons.fullscreen,
      'color': Colors.blue[700]!,
      'description': 'The size of the overlay surface — typically the '
          'full screen dimensions. Use this as the constraint boundary '
          'when computing menu position to prevent off-screen overflow.',
    },
    {
      'name': 'position',
      'type': 'Offset?',
      'icon': Icons.control_camera,
      'color': Colors.blueGrey[600]!,
      'description': 'An optional offset that shifts the menu from the '
          'default anchor-aligned position. When non-null, this is '
          'typically the pointer location for context menus opened '
          'at the cursor position.',
    },
    {
      'name': 'tapRegionGroupId',
      'type': 'Object',
      'icon': Icons.group_work,
      'color': Colors.blue[600]!,
      'description': 'An opaque identifier that groups the anchor and '
          'menu overlay into the same TapRegion group. Taps outside '
          'this group trigger menu dismissal. The ID is shared between '
          'the RawMenuAnchor and the overlay it spawns.',
    },
  ];

  print('  Properties: ${properties.length}');

  // ============================================================
  // SECTION 3: Live Instance Exploration
  // ============================================================
  print('=== Section 3: Live Instance ===');

  final groupId = Object();
  final overlayInfo = RawMenuOverlayInfo(
    anchorRect: ui.Rect.fromLTWH(120.0, 200.0, 150.0, 48.0),
    overlaySize: ui.Size(400.0, 800.0),
    tapRegionGroupId: groupId,
  );

  final overlayInfoWithPos = RawMenuOverlayInfo(
    anchorRect: ui.Rect.fromLTWH(120.0, 200.0, 150.0, 48.0),
    overlaySize: ui.Size(400.0, 800.0),
    tapRegionGroupId: groupId,
    position: Offset(180.0, 220.0),
  );

  print('  anchorRect: ${overlayInfo.anchorRect}');
  print('  overlaySize: ${overlayInfo.overlaySize}');
  print('  position (default): ${overlayInfo.position}');
  print('  position (with offset): ${overlayInfoWithPos.position}');
  print('  tapRegionGroupId: ${overlayInfo.tapRegionGroupId}');

  // Equality check
  final sameInfo = RawMenuOverlayInfo(
    anchorRect: ui.Rect.fromLTWH(120.0, 200.0, 150.0, 48.0),
    overlaySize: ui.Size(400.0, 800.0),
    tapRegionGroupId: groupId,
  );
  final areEqual = overlayInfo == sameInfo;
  print('  equality (same values, same group): $areEqual');

  // ============================================================
  // SECTION 4: Anchor Positioning Strategies
  // ============================================================
  print('=== Section 4: Positioning Strategies ===');

  final strategies = <Map<String, dynamic>>[
    {
      'name': 'Below Anchor (Default)',
      'description': 'Position the menu below the anchor, aligned by '
          'left edge. Most common for dropdown menus and toolbar buttons.',
      'diagram': '┌─────────┐\n'
          '│  Anchor  │\n'
          '└─────────┘\n'
          '┌───────────────┐\n'
          '│  Menu Item 1  │\n'
          '│  Menu Item 2  │\n'
          '│  Menu Item 3  │\n'
          '└───────────────┘',
      'icon': Icons.arrow_downward,
      'color': Colors.blueGrey[700]!,
    },
    {
      'name': 'Above Anchor',
      'description': 'Position the menu above when there isn\'t enough '
          'space below. Computed by checking if anchorRect.bottom + '
          'menuHeight > overlaySize.height.',
      'diagram': '┌───────────────┐\n'
          '│  Menu Item 1  │\n'
          '│  Menu Item 2  │\n'
          '│  Menu Item 3  │\n'
          '└───────────────┘\n'
          '┌─────────┐\n'
          '│  Anchor  │\n'
          '└─────────┘',
      'icon': Icons.arrow_upward,
      'color': Colors.blue[700]!,
    },
    {
      'name': 'Beside Anchor (Cascade)',
      'description': 'Position the menu to the right of the anchor. '
          'Used for nested/cascade menus. Falls back to left side '
          'if right overflow detected.',
      'diagram': '┌─────────┐┌───────────────┐\n'
          '│  Anchor  ││  Sub Menu 1   │\n'
          '└─────────┘│  Sub Menu 2   │\n'
          '           │  Sub Menu 3   │\n'
          '           └───────────────┘',
      'icon': Icons.arrow_forward,
      'color': Colors.blueGrey[600]!,
    },
    {
      'name': 'At Pointer (Context Menu)',
      'description': 'Use the position offset to place the menu at the '
          'cursor/finger location. The anchorRect is still available '
          'for fallback positioning.',
      'diagram': '     ↖ pointer\n'
          '  ┌───────────────┐\n'
          '  │  Cut           │\n'
          '  │  Copy          │\n'
          '  │  Paste         │\n'
          '  └───────────────┘',
      'icon': Icons.mouse,
      'color': Colors.blue[600]!,
    },
  ];

  print('  Strategies: ${strategies.length}');

  // ============================================================
  // SECTION 5: Overflow Detection
  // ============================================================
  print('=== Section 5: Overflow Detection ===');

  final overflowRules = <Map<String, dynamic>>[
    {
      'rule': 'Bottom Overflow',
      'condition': 'anchorRect.bottom + menuH > overlaySize.height',
      'action': 'Place above: anchorRect.top - menuH',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.red[600]!,
    },
    {
      'rule': 'Top Overflow',
      'condition': 'anchorRect.top - menuH < 0',
      'action': 'Clamp to top: position = 0',
      'icon': Icons.vertical_align_top,
      'color': Colors.orange[600]!,
    },
    {
      'rule': 'Right Overflow',
      'condition': 'anchorRect.left + menuW > overlaySize.width',
      'action': 'Align right edge: overlaySize.width - menuW',
      'icon': Icons.align_horizontal_right,
      'color': Colors.red[600]!,
    },
    {
      'rule': 'Left Overflow',
      'condition': 'menuX < 0',
      'action': 'Clamp to left: position.dx = 0',
      'icon': Icons.align_horizontal_left,
      'color': Colors.orange[600]!,
    },
  ];

  print('  Overflow rules: ${overflowRules.length}');

  // ============================================================
  // SECTION 6: Tap Region Behavior
  // ============================================================
  print('=== Section 6: Tap Region ===');

  final tapBehaviors = <Map<String, dynamic>>[
    {
      'title': 'Inside Group → No Dismiss',
      'detail': 'Taps on menu items or the anchor widget are within '
          'the tap region group. These are recognized as intentional '
          'interactions and do not dismiss the menu.',
      'icon': Icons.check_circle,
      'color': Colors.green[700]!,
    },
    {
      'title': 'Outside Group → Dismiss',
      'detail': 'Taps on any widget outside the tap region group '
          'trigger the outside-tap callback, which typically closes '
          'the menu via the menu controller.',
      'icon': Icons.cancel,
      'color': Colors.red[600]!,
    },
    {
      'title': 'Nested Menus → Shared Group',
      'detail': 'Cascading sub-menus inherit the parent\'s '
          'tapRegionGroupId. This keeps the entire menu hierarchy '
          'open when navigating between levels.',
      'icon': Icons.account_tree,
      'color': Colors.blueGrey[700]!,
    },
    {
      'title': 'Multiple Independent Menus',
      'detail': 'Different menu anchors get different group IDs. '
          'Opening a new menu with a different ID automatically '
          'triggers outside-tap on the first menu, closing it.',
      'icon': Icons.view_column,
      'color': Colors.blue[700]!,
    },
  ];

  print('  Tap behaviors: ${tapBehaviors.length}');

  // ============================================================
  // SECTION 7: Equality & Hashing
  // ============================================================
  print('=== Section 7: Equality & Hashing ===');

  final equalityNotes = <Map<String, dynamic>>[
    {
      'aspect': 'operator ==',
      'detail': 'Compares anchorRect, overlaySize, position, and '
          'tapRegionGroupId. Two instances with identical values '
          'and the same group ID object are equal.',
      'icon': Icons.compare,
      'color': Colors.blueGrey[700]!,
    },
    {
      'aspect': 'hashCode',
      'detail': 'Computed via Object.hash(anchorRect, overlaySize, '
          'position, tapRegionGroupId). Consistent with equality.',
      'icon': Icons.tag,
      'color': Colors.blue[700]!,
    },
    {
      'aspect': 'Identity vs Value',
      'detail': 'tapRegionGroupId is compared by identity (same '
          'Object instance), not by value. Two different Object() '
          'instances are never equal even if created identically.',
      'icon': Icons.fingerprint,
      'color': Colors.blueGrey[600]!,
    },
  ];

  print('  Equality notes: ${equalityNotes.length}');

  // ============================================================
  // SECTION 8: Usage in RawMenuAnchor
  // ============================================================
  print('=== Section 8: RawMenuAnchor Usage ===');

  final usageSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Define a MenuController',
      'code': 'final menuController = MenuController();',
      'color': Colors.blueGrey[700]!,
    },
    {
      'step': 2,
      'title': 'Build the Anchor',
      'code': 'RawMenuAnchor(\n'
          '  controller: menuController,\n'
          '  builder: (ctx, controller, child) {\n'
          '    return ElevatedButton(\n'
          '      onPressed: () => controller.isOpen\n'
          '          ? controller.close()\n'
          '          : controller.open(),\n'
          '      child: Text("Menu"),\n'
          '    );\n'
          '  },\n'
          '  ...\n'
          ')',
      'color': Colors.blue[700]!,
    },
    {
      'step': 3,
      'title': 'Implement overlayBuilder',
      'code': 'overlayBuilder: (ctx, info) {\n'
          '  // info is RawMenuOverlayInfo\n'
          '  final top = info.anchorRect.bottom;\n'
          '  final left = info.anchorRect.left;\n'
          '  return Positioned(\n'
          '    top: top,\n'
          '    left: left,\n'
          '    child: MenuPanel(items: [...]),\n'
          '  );\n'
          '}',
      'color': Colors.blueGrey[600]!,
    },
    {
      'step': 4,
      'title': 'Handle Overflow',
      'code': 'final top = info.anchorRect.bottom;\n'
          'final fitsBelow = top + menuH\n'
          '    <= info.overlaySize.height;\n'
          'final finalTop = fitsBelow\n'
          '    ? top\n'
          '    : info.anchorRect.top - menuH;',
      'color': Colors.blue[600]!,
    },
  ];

  print('  Usage steps: ${usageSteps.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey[800]!, Colors.blue[700]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.menu_open, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'RawMenuOverlayInfo',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Menu positioning data class — anchor rect, overlay size, '
                'optional pointer offset, and tap region grouping for '
                'RawMenuAnchor overlays.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: Properties ----
        _sectionHeader('2. Properties', Icons.list_alt, Colors.blue[700]!),
        SizedBox(height: 10),
        ...properties.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(p['icon'] as IconData, color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(p['name'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace', color: p['color'] as Color)),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(p['type'] as String,
                              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.grey[800])),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(p['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Live Instance ----
        _sectionHeader('3. Live Instance', Icons.science, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoRow('anchorRect', '${overlayInfo.anchorRect}', Colors.blueGrey[700]!),
              _infoRow('overlaySize', '${overlayInfo.overlaySize}', Colors.blue[700]!),
              _infoRow('position (null)', '${overlayInfo.position}', Colors.blueGrey[600]!),
              _infoRow('position (offset)', '${overlayInfoWithPos.position}', Colors.blue[600]!),
              _infoRow('tapRegionGroupId', '${overlayInfo.tapRegionGroupId.runtimeType}', Colors.blueGrey[700]!),
              Divider(height: 16),
              _infoRow('equality (same values)', '$areEqual', Colors.green[700]!),
              _infoRow('hashCode', '${overlayInfo.hashCode}', Colors.grey[600]!),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 4: Positioning Strategies ----
        _sectionHeader('4. Positioning Strategies', Icons.control_camera, Colors.blue[700]!),
        SizedBox(height: 10),
        ...strategies.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: (s['color'] as Color).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: s['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(s['icon'] as IconData, color: s['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Text(s['name'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: s['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(s['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(s['diagram'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.lightBlueAccent[100])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 5: Overflow Detection ----
        _sectionHeader('5. Overflow Detection', Icons.warning_amber, Colors.red[600]!),
        SizedBox(height: 10),
        ...overflowRules.map((o) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (o['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(o['icon'] as IconData, color: o['color'] as Color, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(o['rule'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: o['color'] as Color)),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(o['condition'] as String,
                                style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                          ),
                          SizedBox(height: 4),
                          Text(o['action'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 6: Tap Region ----
        _sectionHeader('6. Tap Region Behavior', Icons.touch_app, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        ...tapBehaviors.map((t) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (t['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: t['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(t['icon'] as IconData, color: t['color'] as Color, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: t['color'] as Color)),
                          SizedBox(height: 4),
                          Text(t['detail'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 7: Equality ----
        _sectionHeader('7. Equality & Hashing', Icons.balance, Colors.blue[700]!),
        SizedBox(height: 10),
        ...equalityNotes.map((e) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(e['icon'] as IconData, color: e['color'] as Color, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e['aspect'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace', color: e['color'] as Color)),
                          SizedBox(height: 4),
                          Text(e['detail'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Usage Steps ----
        _sectionHeader('8. RawMenuAnchor Pattern', Icons.code, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        ...usageSteps.map((u) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: u['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('${u['step']}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(u['title'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(u['code'] as String,
                              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.menu_open, color: Colors.blueGrey[600], size: 28),
              SizedBox(height: 6),
              Text(
                'RawMenuOverlayInfo: the bridge between anchor geometry '
                'and menu layout — providing everything an overlay builder '
                'needs to position, constrain, and dismiss menus correctly.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}

Widget _infoRow(String label, String value, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(label,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: color)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12, fontFamily: 'monospace', color: Colors.grey[800])),
        ),
      ],
    ),
  );
}
