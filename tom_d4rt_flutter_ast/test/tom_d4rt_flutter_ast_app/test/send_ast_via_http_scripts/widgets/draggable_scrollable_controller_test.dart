// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — DraggableScrollableController
// Demonstrates DraggableScrollableController, the programmatic controller
// for DraggableScrollableSheet. Covers animating extent, reading size,
// snap points, modal usage, and notification patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DraggableScrollableController Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.drag_handle,
      'title': 'What is DraggableScrollableController?',
      'body': 'DraggableScrollableController provides programmatic '
          'control over a DraggableScrollableSheet. It can animate '
          'the sheet to a specific extent, read the current size, '
          'reset to initial position, and listen to size changes.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.open_in_full,
      'title': 'Extent-Based Sizing',
      'body': 'The sheet\u0027s size is expressed as a fraction of the '
          'parent height (0.0 to 1.0). initialChildSize sets the '
          'starting extent, minChildSize the minimum (collapsed), '
          'and maxChildSize the maximum (expanded).',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.animation,
      'title': 'Animated Transitions',
      'body': 'The controller\u0027s animateTo method smoothly animates '
          'the sheet between extents. It accepts a target size, '
          'duration, and curve, enabling polished expand/collapse '
          'animations triggered by buttons or gestures.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.adjust,
      'title': 'Snap Points',
      'body': 'When snap is true, the sheet snaps to predefined '
          'positions after a drag ends. snapSizes defines the '
          'intermediate snap points between min and max. The '
          'controller can animate to any snap point.',
      'accent': Colors.orange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final c = conceptItems[i];
    final accent = c['accent'] as Color;
    print('Concept ${i + 1}: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
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

  // ============================================================
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'size',
      'type': 'double',
      'desc': 'The current extent of the sheet as a fraction of the '
          'parent height (0.0 to 1.0). Reading this requires the '
          'controller to be attached to a sheet.',
    },
    {
      'name': 'isAttached',
      'type': 'bool',
      'desc': 'Whether the controller is currently attached to a '
          'DraggableScrollableSheet. Must be true before calling '
          'animateTo, jumpTo, reset, or reading size.',
    },
    {
      'name': 'pixels',
      'type': 'double',
      'desc': 'The current extent in pixels rather than as a fraction. '
          'Useful for computing absolute positions or offsets.',
    },
    {
      'name': 'animateTo()',
      'type': 'Future<void>',
      'desc': 'Animates the sheet to the given size (fraction). '
          'Accepts duration and curve parameters. Returns a '
          'Future that completes when the animation finishes.',
    },
    {
      'name': 'jumpTo()',
      'type': 'void',
      'desc': 'Instantly moves the sheet to the given size without '
          'animation. Faster than animateTo but visually abrupt.',
    },
    {
      'name': 'reset()',
      'type': 'void',
      'desc': 'Returns the sheet to its initial child size. Equivalent '
          'to animateTo(initialChildSize) but without animation.',
    },
    {
      'name': 'pixelsToSize()',
      'type': 'double',
      'desc': 'Converts a pixel value to a size fraction relative to '
          'the parent. Useful when computing target sizes from '
          'layout measurements.',
    },
    {
      'name': 'sizeToPixels()',
      'type': 'double',
      'desc': 'Converts a size fraction to pixels. The inverse of '
          'pixelsToSize. Useful for calculating absolute '
          'positions from size fractions.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.indigo.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Sheet Setup
  // ============================================================
  print('=== Section 3: Setup ===');

  final setupSteps = <Map<String, dynamic>>[
    {
      'step': '1. Create Controller',
      'desc': 'Instantiate DraggableScrollableController in initState '
          'or as a field. Dispose it in dispose() to prevent leaks.',
      'diagram': 'final controller =\n'
          '    DraggableScrollableController();',
      'color': Colors.indigo,
    },
    {
      'step': '2. Attach to Sheet',
      'desc': 'Pass the controller to the sheet\u0027s controller param. '
          'The sheet attaches in its initState.',
      'diagram': 'DraggableScrollableSheet(\n'
          '  controller: controller,\n'
          '  initialChildSize: 0.3,\n'
          '  minChildSize: 0.1,\n'
          '  maxChildSize: 0.9,\n'
          '  builder: (ctx, scrollCtrl) {\n'
          '    return ListView.builder(\n'
          '      controller: scrollCtrl,\n'
          '      itemBuilder: ...,\n'
          '    );\n'
          '  },\n'
          ')',
      'color': Colors.blue,
    },
    {
      'step': '3. Programmatic Control',
      'desc': 'Use the controller to animate or jump to extents. '
          'Check isAttached before calling methods.',
      'diagram': 'if (controller.isAttached) {\n'
          '  await controller.animateTo(\n'
          '    0.8,\n'
          '    duration: Duration(ms: 300),\n'
          '    curve: Curves.easeInOut,\n'
          '  );\n'
          '}',
      'color': Colors.green,
    },
    {
      'step': '4. Read Size',
      'desc': 'Access controller.size to read the current extent. '
          'Use in animations, badges, or conditional UI.',
      'diagram': 'final currentSize = controller.size;\n'
          'print("Sheet is at \$currentSize");\n'
          '// 0.3 = 30% of parent height',
      'color': Colors.orange,
    },
  ];

  final setupWidgets = <Widget>[];
  for (var i = 0; i < setupSteps.length; i++) {
    final ss = setupSteps[i];
    final ssColor = ss['color'] as Color;
    print('Setup ${i + 1}: ${ss['step']}');
    setupWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ssColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ssColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ss['step'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ssColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                ss['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ss['diagram'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Snap Points
  // ============================================================
  print('=== Section 4: Snap Points ===');

  final snapTopics = <Map<String, dynamic>>[
    {
      'title': 'Enabling Snap',
      'desc': 'Set snap: true on DraggableScrollableSheet. After a '
          'drag ends, the sheet animates to the nearest snap point '
          'instead of resting at the drag-release position.',
      'color': Colors.indigo,
    },
    {
      'title': 'snapSizes',
      'desc': 'A list of fractional extents between minChildSize and '
          'maxChildSize. These are additional snap targets. The '
          'min and max are always implicit snap points.',
      'color': Colors.blue,
    },
    {
      'title': 'Snap Behavior',
      'desc': 'The sheet snaps to the closest target. If the user '
          'flings with velocity, it snaps in the fling direction '
          'to the next snap point, not necessarily the closest.',
      'color': Colors.green,
    },
    {
      'title': 'Controller + Snap',
      'desc': 'animateTo respects snap points. If you animate to 0.45 '
          'and snap sizes include [0.3, 0.6], the sheet honors '
          'the target you specify, not the nearest snap.',
      'color': Colors.orange,
    },
    {
      'title': 'Dynamic Snap',
      'desc': 'snapSizes can be changed dynamically. Rebuilding the '
          'sheet with different snapSizes updates the targets. '
          'The current position may snap to a new target.',
      'color': Colors.purple,
    },
  ];

  final snapWidgets = <Widget>[];
  for (var i = 0; i < snapTopics.length; i++) {
    final st = snapTopics[i];
    final stColor = st['color'] as Color;
    print('Snap ${i + 1}: ${st['title']}');
    snapWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: stColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: stColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: stColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: stColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    st['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: stColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    st['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
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

  // ============================================================
  // SECTION 5: Modal Usage
  // ============================================================
  print('=== Section 5: Modal ===');

  final modalPatterns = <Map<String, dynamic>>[
    {
      'title': 'showModalBottomSheet',
      'desc': 'Wrap DraggableScrollableSheet inside '
          'showModalBottomSheet for a draggable modal that can '
          'be dismissed by dragging down past minChildSize.',
      'diagram': 'showModalBottomSheet(\n'
          '  context: context,\n'
          '  isScrollControlled: true,\n'
          '  builder: (_) {\n'
          '    return DraggableScrollableSheet(\n'
          '      expand: false,\n'
          '      controller: controller,\n'
          '      builder: (ctx, scrollCtrl) {\n'
          '        return ListView(...);\n'
          '      },\n'
          '    );\n'
          '  },\n'
          ')',
      'color': Colors.indigo,
    },
    {
      'title': 'expand: false',
      'desc': 'Set expand to false when inside a modal. This tells '
          'the sheet not to expand to fill its parent. Instead, '
          'it sizes itself to initialChildSize of the screen.',
      'diagram': 'DraggableScrollableSheet(\n'
          '  expand: false,  // for modals\n'
          '  initialChildSize: 0.5,\n'
          '  maxChildSize: 0.9,\n'
          '  minChildSize: 0.25,\n'
          '  ...\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'isScrollControlled: true',
      'desc': 'Required when using DraggableScrollableSheet inside a '
          'modal. Without it, the modal is constrained to half '
          'the screen and cannot be resized.',
      'diagram': 'showModalBottomSheet(\n'
          '  isScrollControlled: true,\n'
          '  // Allows the sheet to control\n'
          '  // its own height\n'
          '  ...\n'
          ')',
      'color': Colors.green,
    },
    {
      'title': 'Dismiss on Drag Down',
      'desc': 'When the user drags below minChildSize, the modal '
          'dismisses automatically. This is default behavior. '
          'The controller can detect this via size approaching 0.',
      'diagram': '// Sheet auto-dismisses when\n'
          '// dragged below minChildSize.\n'
          '// No extra code needed.',
      'color': Colors.orange,
    },
  ];

  final modalWidgets = <Widget>[];
  for (var i = 0; i < modalPatterns.length; i++) {
    final mp = modalPatterns[i];
    final mpColor = mp['color'] as Color;
    print('Modal ${i + 1}: ${mp['title']}');
    modalWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: mpColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: mpColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mp['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: mpColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                mp['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  mp['diagram'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Notifications
  // ============================================================
  print('=== Section 6: Notifications ===');

  final notifTopics = <Map<String, dynamic>>[
    {
      'title': 'DraggableScrollableNotification',
      'desc': 'The sheet dispatches notifications as its extent changes. '
          'Wrap the sheet in NotificationListener to react to '
          'size changes without polling the controller.',
      'icon': Icons.notifications,
      'color': Colors.indigo,
    },
    {
      'title': 'Notification Properties',
      'desc': 'The notification provides: extent (current fraction), '
          'minExtent, maxExtent, initialExtent, and context. '
          'Use these to drive dependent UI.',
      'icon': Icons.list_alt,
      'color': Colors.blue,
    },
    {
      'title': 'Listening Pattern',
      'desc': 'NotificationListener<DraggableScrollableNotification>( '
          'onNotification: (n) { setState(...); return true; }, '
          'child: sheet). Return true to stop propagation.',
      'icon': Icons.hearing,
      'color': Colors.green,
    },
    {
      'title': 'Controller Listener',
      'desc': 'DraggableScrollableController extends ChangeNotifier. '
          'Use addListener to get notified of size changes. '
          'More efficient than notification bubbling.',
      'icon': Icons.track_changes,
      'color': Colors.orange,
    },
    {
      'title': 'Use Cases',
      'desc': 'Fade a backdrop as the sheet expands. Show/hide a FAB '
          'based on extent. Update a map visible area. Animate '
          'header opacity based on sheet position.',
      'icon': Icons.lightbulb_outline,
      'color': Colors.purple,
    },
  ];

  final notifWidgets = <Widget>[];
  for (var i = 0; i < notifTopics.length; i++) {
    final nt = notifTopics[i];
    final ntColor = nt['color'] as Color;
    print('Notif ${i + 1}: ${nt['title']}');
    notifWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ntColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ntColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ntColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(nt['icon'] as IconData, color: ntColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nt['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ntColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    nt['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
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

  // ============================================================
  // SECTION 7: Use Cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Map Bottom Sheet',
      'desc': 'Google Maps-style draggable sheet over a map. The '
          'controller expands the sheet when a location is tapped, '
          'collapses it when the map is tapped.',
      'icon': Icons.map,
      'color': Colors.indigo,
    },
    {
      'title': 'Music Player',
      'desc': 'A mini-player bar that expands into a full player. '
          'The controller animates between collapsed (showing '
          'track info) and expanded (showing controls + artwork).',
      'icon': Icons.music_note,
      'color': Colors.blue,
    },
    {
      'title': 'Filter Panel',
      'desc': 'A filter sheet that slides up over product listings. '
          'The controller expands it on "Filter" button tap and '
          'collapses it on "Apply" with snap points at 0.3, 0.6.',
      'icon': Icons.filter_list,
      'color': Colors.green,
    },
    {
      'title': 'Chat Input',
      'desc': 'A chat input area that expands as the user types more. '
          'The controller tracks the text field height and adjusts '
          'the sheet extent to accommodate multiple lines.',
      'icon': Icons.chat,
      'color': Colors.orange,
    },
    {
      'title': 'Detail Preview',
      'desc': 'A file/item detail preview that starts as a small strip '
          'showing the title. Drag up reveals full details. '
          'Programmatic expansion on list item long-press.',
      'icon': Icons.preview,
      'color': Colors.purple,
    },
    {
      'title': 'Onboarding Steps',
      'desc': 'A bottom sheet that walks through onboarding steps. '
          'The controller animates to progressively larger '
          'extents as the user advances through steps.',
      'icon': Icons.school,
      'color': Colors.red,
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    final ucColor = uc['color'] as Color;
    print('UseCase ${i + 1}: ${uc['title']}');
    useCaseWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ucColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ucColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ucColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(uc['icon'] as IconData, color: ucColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uc['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ucColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    uc['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
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

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.drag_handle,
      'text': 'DraggableScrollableController provides programmatic '
          'control: animateTo, jumpTo, reset, and size reading.',
    },
    {
      'icon': Icons.straighten,
      'text': 'Size is expressed as a fraction (0.0 to 1.0) of the '
          'parent height. Use pixels property for absolute values.',
    },
    {
      'icon': Icons.animation,
      'text': 'animateTo smoothly transitions with customizable '
          'duration and curve. jumpTo moves instantly.',
    },
    {
      'icon': Icons.adjust,
      'text': 'Snap points define positions the sheet settles to after '
          'a drag. Enable with snap: true and snapSizes.',
    },
    {
      'icon': Icons.web_asset,
      'text': 'For modals, set expand: false and isScrollControlled: '
          'true on showModalBottomSheet.',
    },
    {
      'icon': Icons.notifications,
      'text': 'Listen to size changes via addListener (ChangeNotifier) '
          'or DraggableScrollableNotification.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.indigo.shade800,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('DraggableScrollableController'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.settings), text: 'Setup'),
            Tab(icon: Icon(Icons.adjust), text: 'Snap'),
            Tab(icon: Icon(Icons.web_asset), text: 'Modal'),
            Tab(icon: Icon(Icons.notifications), text: 'Notify'),
            Tab(icon: Icon(Icons.lightbulb_outline), text: 'Use Cases'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'DraggableScrollableController: programmatic control '
                  'over draggable bottom sheets.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Controller API: properties and methods.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Setting up a DraggableScrollableSheet with controller.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...setupWidgets,
            ],
          ),
          // Tab 4
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Snap points: predefined resting positions for the sheet.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...snapWidgets,
            ],
          ),
          // Tab 5
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Using the sheet in modal bottom sheets.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...modalWidgets,
            ],
          ),
          // Tab 6
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Listening to sheet size changes.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...notifWidgets,
            ],
          ),
          // Tab 7
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Real-world patterns using DraggableScrollableController.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...useCaseWidgets,
            ],
          ),
          // Tab 8
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo.withOpacity(0.12),
                      Colors.indigo.withOpacity(0.04),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about DraggableScrollableController.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}
