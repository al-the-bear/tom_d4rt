// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TapRegionRegistry
// Demonstrates TapRegionSurface (the registry surface) which is the
// InheritedWidget that manages groups of TapRegion widgets. It provides
// the mechanism for detecting taps outside a group of related regions,
// enabling patterns like dismissing popups, dropdowns, and overlays.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapRegionRegistry Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.touch_app,
      'title': 'What is TapRegionSurface?',
      'body': 'TapRegionSurface is a widget that provides a surface for '
          'TapRegion widgets to register with. It acts as the registry '
          'that tracks all active tap regions and their group memberships, '
          'enabling "tap outside" detection across grouped regions.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.group_work,
      'title': 'Group-Based Detection',
      'body': 'TapRegion widgets sharing the same groupId form a logical group. '
          'When a tap occurs outside ALL regions in a group, the onTapOutside '
          'callback fires on every member. Tapping inside any group member '
          'does NOT trigger the outside callback.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.layers,
      'title': 'Registry Hierarchy',
      'body': 'TapRegionSurface uses RenderTapRegionSurface under the hood. '
          'WidgetsApp and MaterialApp already include a TapRegionSurface '
          'near the root, so most apps get the registry automatically '
          'without adding one explicitly.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.exit_to_app,
      'title': 'Primary Use Case',
      'body': 'The most common use is dismissing floating UI when the user '
          'taps elsewhere: menus, dropdowns, search suggestions, tooltips, '
          'and bottom sheets. Each floating element and its trigger can '
          'share a group so the overlay stays open while interacting.',
      'accent': Colors.deepPurple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final e = conceptItems[i];
    final accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
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
                child: Icon(e['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
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
      'name': 'TapRegionSurface',
      'type': 'Widget',
      'desc': 'The registry surface widget. Wraps a subtree to provide '
          'tap region registration. Creates a RenderTapRegionSurface '
          'that tracks all descendant TapRegion widgets.',
    },
    {
      'name': 'TapRegion',
      'type': 'Widget',
      'desc': 'A widget that registers a region with the nearest '
          'TapRegionSurface. Provides onTapOutside and onTapInside '
          'callbacks based on group membership.',
    },
    {
      'name': 'TapRegion.groupId',
      'type': 'Object?',
      'desc': 'An identifier that groups multiple TapRegion widgets. '
          'Regions with the same groupId are treated as one logical '
          'area. A tap must be outside ALL members to trigger onTapOutside.',
    },
    {
      'name': 'TapRegion.onTapOutside',
      'type': 'TapRegionCallback?',
      'desc': 'Called when a tap occurs outside this region (or its group). '
          'Receives a PointerDownEvent with the tap position. Use this '
          'to dismiss overlays, close menus, or unfocus fields.',
    },
    {
      'name': 'TapRegion.onTapInside',
      'type': 'TapRegionCallback?',
      'desc': 'Called when a tap occurs inside this region. Useful for '
          'tracking engagement or resetting dismiss timers.',
    },
    {
      'name': 'TapRegion.consumeOutsideTaps',
      'type': 'bool',
      'desc': 'When true, taps outside this region are consumed and not '
          'passed to other widgets. Defaults to false. Use sparingly '
          'as it blocks all other tap handlers.',
    },
    {
      'name': 'TapRegion.behavior',
      'type': 'HitTestBehavior?',
      'desc': 'Controls how hit testing works for this region. Defaults to '
          'deferToChild. Set to opaque to capture taps on blank areas '
          'within the region bounds.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.teal.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.2)),
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
                    color: Colors.teal.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
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
            const SizedBox(height: 8),
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
  // SECTION 3: Groups Visual
  // ============================================================
  print('=== Section 3: Groups ===');

  // Simulate grouped vs ungrouped regions visually
  final groupScenarios = <Map<String, dynamic>>[
    {
      'title': 'Ungrouped Regions',
      'desc': 'Each TapRegion has no groupId. A tap outside any individual '
          'region triggers its own onTapOutside — even if the tap lands '
          'inside another TapRegion.',
      'regions': ['Region A', 'Region B', 'Region C'],
      'grouped': false,
      'color': Colors.red,
    },
    {
      'title': 'Same-Group Regions',
      'desc': 'All TapRegion widgets share groupId: "menu". A tap inside '
          'any member does NOT fire onTapOutside. Only a tap outside '
          'all three regions triggers the callback on every member.',
      'regions': ['Trigger', 'Menu Body', 'Sub-Menu'],
      'grouped': true,
      'color': Colors.teal,
    },
    {
      'title': 'Mixed Groups',
      'desc': 'Regions can belong to different groups. Group A and Group B '
          'are independent — tapping inside Group A triggers onTapOutside '
          'for Group B members, and vice versa.',
      'regions': ['Group A: Field', 'Group B: Dropdown'],
      'grouped': false,
      'color': Colors.orange,
    },
  ];

  final groupWidgets = <Widget>[];
  for (var i = 0; i < groupScenarios.length; i++) {
    final gs = groupScenarios[i];
    final gsColor = gs['color'] as Color;
    final regions = gs['regions'] as List<String>;
    final isGrouped = gs['grouped'] as bool;
    print('Group ${i + 1}: ${gs['title']}');

    final regionChips = <Widget>[];
    for (var r = 0; r < regions.length; r++) {
      regionChips.add(
        Container(
          margin: const EdgeInsets.only(right: 8, bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isGrouped
                ? gsColor.withOpacity(0.12)
                : [
                    Colors.red.withOpacity(0.12),
                    Colors.blue.withOpacity(0.12),
                    Colors.green.withOpacity(0.12),
                  ][r % 3],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isGrouped
                  ? gsColor.withOpacity(0.4)
                  : [
                      Colors.red.withOpacity(0.4),
                      Colors.blue.withOpacity(0.4),
                      Colors.green.withOpacity(0.4),
                    ][r % 3],
              width: isGrouped ? 2 : 1,
              style: isGrouped ? BorderStyle.solid : BorderStyle.solid,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isGrouped ? Icons.link : Icons.link_off,
                size: 14,
                color: gsColor,
              ),
              const SizedBox(width: 6),
              Text(
                regions[r],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: gsColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    groupWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: gsColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: gsColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: gsColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: gsColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      gs['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: gsColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(children: regionChips),
              const SizedBox(height: 8),
              Text(
                gs['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Registration
  // ============================================================
  print('=== Section 4: Registration ===');

  final regSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'TapRegionSurface Inserted',
      'desc': 'The surface creates a RenderTapRegionSurface that '
          'listens for pointer events on the entire surface area. '
          'MaterialApp/WidgetsApp inserts one automatically.',
      'icon': Icons.layers,
      'color': Colors.teal,
    },
    {
      'step': 2,
      'title': 'TapRegion Mounts',
      'desc': 'When a TapRegion widget is inserted into the tree, '
          'its render object registers with the nearest ancestor '
          'TapRegionSurface. The region bounds and groupId are '
          'recorded in the registry.',
      'icon': Icons.add_circle,
      'color': Colors.blue,
    },
    {
      'step': 3,
      'title': 'Pointer Event Arrives',
      'desc': 'When the user taps anywhere on the surface, the '
          'RenderTapRegionSurface receives the PointerDownEvent. '
          'It performs hit-testing against all registered regions.',
      'icon': Icons.touch_app,
      'color': Colors.orange,
    },
    {
      'step': 4,
      'title': 'Group Evaluation',
      'desc': 'For each group, the surface checks whether the tap '
          'landed inside ANY member of that group. If inside, '
          'onTapInside fires. If outside ALL members, onTapOutside '
          'fires on every member of the group.',
      'icon': Icons.compare_arrows,
      'color': Colors.purple,
    },
    {
      'step': 5,
      'title': 'TapRegion Unmounts',
      'desc': 'When a TapRegion is removed from the tree, its render '
          'object unregisters from the surface. Future taps will '
          'no longer consider this region for group membership.',
      'icon': Icons.remove_circle,
      'color': Colors.red,
    },
  ];

  final regWidgets = <Widget>[];
  for (var i = 0; i < regSteps.length; i++) {
    final rs = regSteps[i];
    final rsColor = rs['color'] as Color;
    print('Reg ${i + 1}: ${rs['title']}');
    regWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step number + connector line
            Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: rsColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: rsColor, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      '${rs['step']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: rsColor,
                      ),
                    ),
                  ),
                ),
                if (i < regSteps.length - 1)
                  Container(
                    width: 2,
                    height: 30,
                    color: rsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: rsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: rsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(rs['icon'] as IconData,
                            color: rsColor, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            rs['title'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: rsColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      rs['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Inside / Outside
  // ============================================================
  print('=== Section 5: Inside/Outside ===');

  // Visual diagram of hit testing
  final hitScenarios = <Map<String, dynamic>>[
    {
      'title': 'Tap Inside Region',
      'desc': 'The pointer lands within the bounds of a TapRegion. '
          'onTapInside fires for that region. If the region is in a '
          'group, no onTapOutside fires on any group member.',
      'diagram': 'inside',
      'color': Colors.green,
    },
    {
      'title': 'Tap Outside Individual',
      'desc': 'For ungrouped regions (no groupId), a tap anywhere '
          'outside the single region triggers onTapOutside. Other '
          'regions are not considered.',
      'diagram': 'outside-single',
      'color': Colors.red,
    },
    {
      'title': 'Tap Outside Group',
      'desc': 'For grouped regions, the tap must be outside every '
          'member of the group. If it hits even one member, the tap '
          'is "inside" the group.',
      'diagram': 'outside-group',
      'color': Colors.teal,
    },
    {
      'title': 'Overlapping Regions',
      'desc': 'When regions overlap, a tap in the overlapping area is '
          '"inside" both regions (and both groups). Hit testing uses '
          'the region bounds, not widget z-order.',
      'diagram': 'overlap',
      'color': Colors.purple,
    },
  ];

  final hitWidgets = <Widget>[];
  for (var i = 0; i < hitScenarios.length; i++) {
    final hs = hitScenarios[i];
    final hsColor = hs['color'] as Color;
    print('Hit ${i + 1}: ${hs['title']}');

    // Build a mini visual for each scenario
    Widget miniDiagram;
    switch (hs['diagram'] as String) {
      case 'inside':
        miniDiagram = Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.15)),
          ),
          child: Center(
            child: Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'TapRegion',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 50,
                    child: Icon(
                      Icons.touch_app,
                      size: 16,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        break;
      case 'outside-single':
        miniDiagram = Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.04),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.touch_app, size: 16, color: Colors.red),
              Container(
                width: 80,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Center(
                  child: Text(
                    'Region',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case 'outside-group':
        miniDiagram = Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.04),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.withOpacity(0.15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.touch_app, size: 16, color: Colors.red),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Center(
                        child: Text('A',
                            style: TextStyle(fontSize: 10)),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 50,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Center(
                        child: Text('B',
                            style: TextStyle(fontSize: 10)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        break;
      default:
        miniDiagram = Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.04),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: const Center(
                    child: Text('R1', style: TextStyle(fontSize: 9)),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 8,
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border:
                          Border.all(color: Colors.purple.withOpacity(0.3)),
                    ),
                    child: const Center(
                      child: Text('R2', style: TextStyle(fontSize: 9)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }

    hitWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: hsColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: hsColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hs['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: hsColor,
                ),
              ),
              const SizedBox(height: 8),
              miniDiagram,
              const SizedBox(height: 8),
              Text(
                hs['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Lifecycle
  // ============================================================
  print('=== Section 6: Lifecycle ===');

  final lifecycleItems = <Map<String, dynamic>>[
    {
      'phase': 'Mount',
      'icon': Icons.play_arrow,
      'desc': 'TapRegion renders and registers with the nearest '
          'TapRegionSurface ancestor. The region becomes active for '
          'hit testing immediately.',
      'code': 'TapRegion(\n'
          '  groupId: myGroupId,\n'
          '  onTapOutside: (_) => dismiss(),\n'
          '  child: menuContent,\n'
          ')',
      'color': Colors.green,
    },
    {
      'phase': 'Active',
      'icon': Icons.fiber_manual_record,
      'desc': 'While mounted, the region participates in all tap '
          'evaluations. Group membership can change if groupId '
          'changes via setState rebuild.',
      'code': '// groupId can change dynamically\n'
          'TapRegion(\n'
          '  groupId: isExpanded\n'
          '    ? expandedGroupId\n'
          '    : collapsedGroupId,\n'
          '  child: myWidget,\n'
          ')',
      'color': Colors.teal,
    },
    {
      'phase': 'Unmount',
      'icon': Icons.stop,
      'desc': 'When removed from the tree, the region unregisters. '
          'If it was the last member of a group, the group is '
          'effectively dissolved. No dangling references remain.',
      'code': '// Region auto-unregisters on dispose\n'
          'if (showOverlay)\n'
          '  TapRegion(\n'
          '    groupId: overlayGroup,\n'
          '    child: overlay,\n'
          '  )',
      'color': Colors.red,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (var i = 0; i < lifecycleItems.length; i++) {
    final li = lifecycleItems[i];
    final liColor = li['color'] as Color;
    print('Lifecycle ${i + 1}: ${li['phase']}');
    lifecycleWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: liColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: liColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: liColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      li['icon'] as IconData,
                      color: liColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    li['phase'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: liColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                li['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: liColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  li['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: liColor,
                    height: 1.4,
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
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Dismiss Menu on Outside Tap',
      'desc': 'Wrap a popup menu trigger and the menu body in TapRegion '
          'widgets with the same groupId. When the user taps outside '
          'both, call setState to close the menu.',
      'code': 'TapRegion(\n'
          '  groupId: "myMenu",\n'
          '  onTapOutside: (_) {\n'
          '    setState(() => showMenu = false);\n'
          '  },\n'
          '  child: menuContent,\n'
          ')',
      'icon': Icons.menu,
      'color': Colors.teal,
    },
    {
      'title': 'Unfocus TextField on Outside Tap',
      'desc': 'TextField already uses TapRegion internally. The focus '
          'node unfocuses when a tap lands outside the field. '
          'TextFieldTapRegion extends this to custom overlays.',
      'code': '// TextField handles this automatically:\n'
          '// tap outside the field => unfocus\n'
          '// No extra code needed for basic cases.',
      'icon': Icons.text_fields,
      'color': Colors.blue,
    },
    {
      'title': 'Dropdown with Trigger',
      'desc': 'The trigger button and dropdown panel share a groupId. '
          'Tapping the trigger opens the dropdown; tapping inside '
          'the dropdown keeps it open; tapping outside both closes it.',
      'code': 'TapRegion(\n'
          '  groupId: dropdownId,\n'
          '  child: IconButton(\n'
          '    onPressed: toggleDropdown,\n'
          '    icon: Icon(Icons.arrow_drop_down),\n'
          '  ),\n'
          ')\n'
          '// ... overlay entry also uses same groupId',
      'icon': Icons.arrow_drop_down_circle,
      'color': Colors.orange,
    },
    {
      'title': 'Multi-Level Menu',
      'desc': 'Nested sub-menus share the same groupId as the parent. '
          'This means tapping inside any level of the menu hierarchy '
          'keeps everything open, while tapping away dismisses all.',
      'code': '// Parent menu, sub-menu, sub-sub-menu\n'
          '// all share groupId: "cascadingMenu"',
      'icon': Icons.account_tree,
      'color': Colors.purple,
    },
    {
      'title': 'Modal Barrier Alternative',
      'desc': 'Use consumeOutsideTaps: true to block taps from reaching '
          'widgets behind the overlay. This behaves like a modal '
          'barrier but without the visual scrim.',
      'code': 'TapRegion(\n'
          '  consumeOutsideTaps: true,\n'
          '  onTapOutside: (_) => closeModal(),\n'
          '  child: modalContent,\n'
          ')',
      'icon': Icons.block,
      'color': Colors.red,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patterns.length; i++) {
    final pt = patterns[i];
    final ptColor = pt['color'] as Color;
    print('Pattern ${i + 1}: ${pt['title']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ptColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ptColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ptColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      pt['icon'] as IconData,
                      color: ptColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      pt['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ptColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                pt['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ptColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  pt['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: ptColor,
                    height: 1.4,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.layers,
      'text': 'TapRegionSurface is the registry that manages all '
          'TapRegion widgets in its subtree.',
    },
    {
      'icon': Icons.group_work,
      'text': 'TapRegion.groupId groups multiple regions — taps outside '
          'the entire group fire onTapOutside on all members.',
    },
    {
      'icon': Icons.touch_app,
      'text': 'onTapOutside is the primary callback — used for dismissing '
          'floating UI when the user taps elsewhere.',
    },
    {
      'icon': Icons.apps,
      'text': 'MaterialApp includes a TapRegionSurface automatically; '
          'most apps do not need to add one explicitly.',
    },
    {
      'icon': Icons.block,
      'text': 'consumeOutsideTaps blocks taps from reaching other widgets, '
          'acting like a modal barrier without a scrim.',
    },
    {
      'icon': Icons.link,
      'text': 'Common pattern: trigger + overlay share a groupId so tapping '
          'either keeps the overlay open.',
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
          color: Colors.teal.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.teal,
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
        title: const Text('TapRegionRegistry'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.group_work), text: 'Groups'),
            Tab(icon: Icon(Icons.app_registration), text: 'Register'),
            Tab(icon: Icon(Icons.touch_app), text: 'Hit Test'),
            Tab(icon: Icon(Icons.timeline), text: 'Lifecycle'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TapRegionSurface: the invisible registry that enables '
                  '"tap outside" detection for grouped widgets.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key properties and types for the tap region system.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Groups
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How groupId links multiple regions into a single '
                  'logical tap area.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...groupWidgets,
            ],
          ),

          // Tab 4: Registration
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The lifecycle of region registration, from mount '
                  'to hit evaluation to unmount.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...regWidgets,
            ],
          ),

          // Tab 5: Hit Test
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Inside vs outside detection: how the surface '
                  'determines where a tap landed.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...hitWidgets,
            ],
          ),

          // Tab 6: Lifecycle
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Mount, active, and unmount phases with code examples.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...lifecycleWidgets,
            ],
          ),

          // Tab 7: Patterns
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common usage patterns: menus, dropdowns, modals, '
                  'and text fields.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal.withOpacity(0.12),
                      Colors.cyan.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about the TapRegion registry system.',
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
