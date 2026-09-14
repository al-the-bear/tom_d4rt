// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TapRegionSurface
// Demonstrates TapRegionSurface, the widget that creates the registration
// surface for TapRegion descendants. It is the host that provides the
// RenderTapRegionSurface — the render object that actually intercepts
// pointer events and evaluates which regions are "inside" or "outside".
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapRegionSurface Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.crop_square,
      'title': 'What is TapRegionSurface?',
      'body': 'TapRegionSurface is a SingleChildRenderObjectWidget that '
          'creates a RenderTapRegionSurface. It provides the "surface" '
          'on which TapRegion children register themselves. The surface '
          'intercepts all pointer-down events in its subtree to evaluate '
          'which registered regions were hit.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.widgets,
      'title': 'Automatic in MaterialApp',
      'body': 'MaterialApp and WidgetsApp insert a TapRegionSurface '
          'near the root of the widget tree. This means you rarely '
          'need to add one yourself — your TapRegion widgets will '
          'find the surface automatically via the render tree.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.compare,
      'title': 'Surface vs TapRegion',
      'body': 'TapRegionSurface is the host; TapRegion is the guest. '
          'The surface collects all registered regions and performs '
          'hit testing. TapRegion defines the callbacks and group '
          'membership. You need at least one surface for TapRegion '
          'widgets to work.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.account_tree,
      'title': 'Render Object Architecture',
      'body': 'Under the hood, RenderTapRegionSurface is a RenderProxyBox '
          'that adds a tap-tracking layer. It does not change layout — '
          'it only observes pointer events. TapRegion render objects '
          'walk up the tree to find the nearest surface and register.',
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
      'name': 'TapRegionSurface()',
      'type': 'Constructor',
      'desc': 'Creates a tap region surface widget. Takes a required '
          'child parameter and an optional behavior parameter. '
          'The child is the widget subtree that will contain '
          'TapRegion descendants.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The widget below this one in the tree. All TapRegion '
          'widgets within this subtree will register with this '
          'surface for tap detection.',
    },
    {
      'name': 'behavior',
      'type': 'HitTestBehavior',
      'desc': 'How this surface participates in hit testing. Defaults '
          'to HitTestBehavior.deferToChild. Usually you do not need '
          'to change this.',
    },
    {
      'name': 'RenderTapRegionSurface',
      'type': 'RenderObject',
      'desc': 'The render object created by TapRegionSurface. It is '
          'a RenderProxyBox that maintains a set of registered '
          'TapRegion render objects and evaluates pointer events '
          'against their bounds.',
    },
    {
      'name': 'registerTapRegion()',
      'type': 'Method (internal)',
      'desc': 'Called automatically when a TapRegion render object is '
          'inserted into the tree. Adds the region to the surface\'s '
          'tracking set. Not part of the public API.',
    },
    {
      'name': 'unregisterTapRegion()',
      'type': 'Method (internal)',
      'desc': 'Called when a TapRegion render object is removed. Removes '
          'the region from the tracking set. Not public API.',
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
              ? Colors.indigo.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.2)),
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
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
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
  // SECTION 3: Placement
  // ============================================================
  print('=== Section 3: Placement ===');

  final placementItems = <Map<String, dynamic>>[
    {
      'title': 'Root Level (Automatic)',
      'desc': 'MaterialApp and WidgetsApp wrap their content in '
          'TapRegionSurface. This is the default — you get a surface '
          'for free. All TapRegion widgets in the app tree register '
          'with this root surface.',
      'code': '// Already provided by MaterialApp:\n'
          'MaterialApp(\n'
          '  home: Scaffold(\n'
          '    body: TapRegion(\n'
          '      // finds root surface automatically\n'
          '      onTapOutside: (_) => print("outside"),\n'
          '      child: myWidget,\n'
          '    ),\n'
          '  ),\n'
          ')',
      'icon': Icons.home,
      'color': Colors.indigo,
    },
    {
      'title': 'Custom Surface Scope',
      'desc': 'Add your own TapRegionSurface to limit the scope of '
          'tap detection. Regions inside this surface only see taps '
          'within the surface bounds — useful for embedded panels '
          'or modular components.',
      'code': 'TapRegionSurface(\n'
          '  child: Column(\n'
          '    children: [\n'
          '      TapRegion(\n'
          '        onTapOutside: (_) => close(),\n'
          '        child: searchField,\n'
          '      ),\n'
          '      TapRegion(\n'
          '        groupId: searchGroup,\n'
          '        child: suggestions,\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ')',
      'icon': Icons.crop_free,
      'color': Colors.blue,
    },
    {
      'title': 'Overlay Entry Surface',
      'desc': 'Overlay entries live outside the normal widget subtree, '
          'so they may not be descendants of the root surface. If '
          'your overlay needs TapRegion, you may need a second '
          'TapRegionSurface wrapping the overlay content.',
      'code': '// In an OverlayEntry builder:\n'
          'OverlayEntry(\n'
          '  builder: (_) => TapRegionSurface(\n'
          '    child: TapRegion(\n'
          '      onTapOutside: (_) => removeOverlay(),\n'
          '      child: tooltipContent,\n'
          '    ),\n'
          '  ),\n'
          ')',
      'icon': Icons.layers,
      'color': Colors.orange,
    },
  ];

  final placementWidgets = <Widget>[];
  for (var i = 0; i < placementItems.length; i++) {
    final pi = placementItems[i];
    final piColor = pi['color'] as Color;
    print('Placement ${i + 1}: ${pi['title']}');
    placementWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: piColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: piColor.withOpacity(0.2)),
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
                      color: piColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      pi['icon'] as IconData,
                      color: piColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      pi['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: piColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                pi['desc'] as String,
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
                  color: piColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  pi['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: piColor,
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
  // SECTION 4: Multiple Surfaces
  // ============================================================
  print('=== Section 4: Multiple Surfaces ===');

  final multiSurfaceInfo = <Map<String, dynamic>>[
    {
      'title': 'Nested Surfaces',
      'desc': 'A TapRegion registers with its nearest ancestor surface. '
          'If you nest surfaces, inner TapRegions only see the inner '
          'surface. Outer TapRegions only see the outer surface. '
          'They operate independently.',
      'color': Colors.indigo,
    },
    {
      'title': 'Sibling Surfaces',
      'desc': 'Two sibling TapRegionSurface widgets create independent '
          'scopes. A tap in surface A does not affect regions in '
          'surface B — they have separate registries.',
      'color': Colors.blue,
    },
    {
      'title': 'Use Cases for Multiple',
      'desc': 'Multi-panel apps (e.g. split-view editors) might want '
          'each panel to have its own surface. This way, dismissing '
          'a dropdown in one panel does not interfere with regions '
          'in the other panel.',
      'color': Colors.green,
    },
  ];

  final multiWidgets = <Widget>[];
  for (var i = 0; i < multiSurfaceInfo.length; i++) {
    final ms = multiSurfaceInfo[i];
    final msColor = ms['color'] as Color;
    print('MultiSurface ${i + 1}: ${ms['title']}');
    multiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: msColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: msColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: msColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: msColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ms['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: msColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    ms['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.4,
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

  // Visual: nested surfaces diagram
  multiWidgets.add(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visual: Nested Surface Scopes',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.indigo.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Outer TapRegionSurface',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'TapRegion A\n(outer scope)',
                          style: TextStyle(fontSize: 9),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Inner TapRegionSurface',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: const Text(
                                      'TapRegion B\n(inner scope)',
                                      style: TextStyle(fontSize: 8),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: const Text(
                                      'TapRegion C\n(inner scope)',
                                      style: TextStyle(fontSize: 8),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 5: Behavior
  // ============================================================
  print('=== Section 5: Behavior ===');

  final behaviorItems = <Map<String, dynamic>>[
    {
      'title': 'HitTestBehavior.deferToChild',
      'desc': 'The default. The surface only catches pointer events that '
          'hit a child widget. Blank areas within the surface bounds '
          'are transparent to hit testing.',
      'icon': Icons.child_care,
      'color': Colors.indigo,
    },
    {
      'title': 'HitTestBehavior.opaque',
      'desc': 'The surface catches all pointer events within its bounds, '
          'even in blank areas. Use this if you want tapping empty '
          'space to trigger onTapOutside for all regions.',
      'icon': Icons.square,
      'color': Colors.orange,
    },
    {
      'title': 'HitTestBehavior.translucent',
      'desc': 'Like opaque, but the event also passes through to widgets '
          'behind the surface. Rarely needed for TapRegionSurface.',
      'icon': Icons.opacity,
      'color': Colors.purple,
    },
  ];

  final behaviorWidgets = <Widget>[];
  for (var i = 0; i < behaviorItems.length; i++) {
    final bi = behaviorItems[i];
    final biColor = bi['color'] as Color;
    print('Behavior ${i + 1}: ${bi['title']}');
    behaviorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: biColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: biColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: biColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                bi['icon'] as IconData,
                color: biColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bi['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: biColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    bi['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.4,
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
  // SECTION 6: Integration
  // ============================================================
  print('=== Section 6: Integration ===');

  final integrationItems = <Map<String, dynamic>>[
    {
      'title': 'TextField Integration',
      'desc': 'Flutter TextField uses TapRegion internally to detect '
          'taps outside the text field for unfocusing. The surface '
          'provided by MaterialApp makes this work without any extra '
          'setup from the developer.',
      'code': '// TextField already uses TapRegion:\n'
          '// When you tap outside a focused TextField,\n'
          '// the FocusNode loses focus automatically.\n'
          'TextField(\n'
          '  decoration: InputDecoration(\n'
          '    labelText: "Name",\n'
          '  ),\n'
          ')',
      'color': Colors.indigo,
    },
    {
      'title': 'Autocomplete & Search',
      'desc': 'The Autocomplete widget groups the text field and the '
          'suggestion list using a shared groupId. Tapping a suggestion '
          'is "inside" the group, so the suggestions stay visible. '
          'Tapping away dismisses them.',
      'code': '// Autocomplete internally uses:\n'
          'TapRegion(\n'
          '  groupId: _autocompleteGroup,\n'
          '  child: textField,\n'
          ')\n'
          'TapRegion(\n'
          '  groupId: _autocompleteGroup,\n'
          '  child: suggestionsList,\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'PopupMenuButton',
      'desc': 'Material popup menus typically use a ModalRoute, but '
          'custom popup implementations can use TapRegionSurface + '
          'TapRegion for a lighter-weight approach without routes.',
      'code': '// Lightweight popup without routes:\n'
          'Stack(\n'
          '  children: [\n'
          '    mainContent,\n'
          '    if (showPopup)\n'
          '      TapRegion(\n'
          '        groupId: popupGroup,\n'
          '        onTapOutside: (_) =>\n'
          '          setState(() => showPopup = false),\n'
          '        child: popupContent,\n'
          '      ),\n'
          '  ],\n'
          ')',
      'color': Colors.green,
    },
    {
      'title': 'Custom Dropdown',
      'desc': 'Build a custom dropdown by placing the trigger and the '
          'dropdown panel in the same TapRegion group. Use an Overlay '
          'or Stack to position the panel below the trigger.',
      'code': '// Trigger and dropdown share groupId:\n'
          'TapRegion(\n'
          '  groupId: "dropdown_\$id",\n'
          '  child: triggerButton,\n'
          ')\n'
          '// In overlay:\n'
          'TapRegion(\n'
          '  groupId: "dropdown_\$id",\n'
          '  onTapOutside: (_) => closeDropdown(),\n'
          '  child: dropdownPanel,\n'
          ')',
      'color': Colors.orange,
    },
  ];

  final integrationWidgets = <Widget>[];
  for (var i = 0; i < integrationItems.length; i++) {
    final ii = integrationItems[i];
    final iiColor = ii['color'] as Color;
    print('Integration ${i + 1}: ${ii['title']}');
    integrationWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: iiColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: iiColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ii['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: iiColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                ii['desc'] as String,
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
                  color: iiColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ii['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: iiColor,
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
  // SECTION 7: Debug
  // ============================================================
  print('=== Section 7: Debug ===');

  final debugTopics = <Map<String, dynamic>>[
    {
      'title': 'No Surface in Ancestor Tree',
      'desc': 'If a TapRegion cannot find a TapRegionSurface ancestor, '
          'it will assert in debug mode. This typically happens when '
          'using TapRegion outside MaterialApp or in isolated overlay '
          'entries. Fix: wrap in TapRegionSurface.',
      'severity': 'error',
      'color': Colors.red,
    },
    {
      'title': 'onTapOutside Not Firing',
      'desc': 'Check that the tap target is within the same surface scope. '
          'If the tap lands in a different TapRegionSurface subtree, '
          'the region in the original surface is not notified. Also '
          'check that groupId grouping is correct.',
      'severity': 'debug',
      'color': Colors.orange,
    },
    {
      'title': 'Performance with Many Regions',
      'desc': 'TapRegionSurface evaluates all registered regions on every '
          'pointer-down event. With hundreds of regions, this can become '
          'a bottleneck. Use fewer surfaces or reduce the number of '
          'active TapRegion widgets.',
      'severity': 'perf',
      'color': Colors.amber,
    },
    {
      'title': 'consumeOutsideTaps Side Effects',
      'desc': 'When consumeOutsideTaps is true, the event is eaten by '
          'the surface. Other gesture detectors (buttons, sliders) '
          'will not receive the tap. Only use for truly modal cases.',
      'severity': 'warn',
      'color': Colors.purple,
    },
  ];

  final debugWidgets = <Widget>[];
  for (var i = 0; i < debugTopics.length; i++) {
    final dt = debugTopics[i];
    final dtColor = dt['color'] as Color;
    final sev = dt['severity'] as String;
    print('Debug ${i + 1}: ${dt['title']}');
    debugWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: dtColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(color: dtColor, width: 4),
            top: BorderSide(color: dtColor.withOpacity(0.1)),
            right: BorderSide(color: dtColor.withOpacity(0.1)),
            bottom: BorderSide(color: dtColor.withOpacity(0.1)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: dtColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    sev.toUpperCase(),
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: dtColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    dt['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: dtColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              dt['desc'] as String,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.crop_square,
      'text': 'TapRegionSurface creates a RenderTapRegionSurface that '
          'hosts all TapRegion registration.',
    },
    {
      'icon': Icons.widgets,
      'text': 'MaterialApp provides a root surface automatically — you '
          'rarely need to add your own.',
    },
    {
      'icon': Icons.layers,
      'text': 'Multiple surfaces create independent scopes; nested vs '
          'sibling surfaces have different isolation behaviors.',
    },
    {
      'icon': Icons.touch_app,
      'text': 'The surface intercepts pointer-down events and evaluates '
          'all registered regions to determine inside/outside.',
    },
    {
      'icon': Icons.settings,
      'text': 'The behavior property controls hit testing; deferToChild '
          'is the default and best for most cases.',
    },
    {
      'icon': Icons.build,
      'text': 'Framework widgets like TextField and Autocomplete use '
          'TapRegion internally, relying on the surface.',
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
          border: Border.all(color: Colors.indigo.withOpacity(0.12)),
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
                color: Colors.indigo,
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
        title: const Text('TapRegionSurface'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.place), text: 'Placement'),
            Tab(icon: Icon(Icons.layers), text: 'Multi'),
            Tab(icon: Icon(Icons.toggle_on), text: 'Behavior'),
            Tab(icon: Icon(Icons.extension), text: 'Integrate'),
            Tab(icon: Icon(Icons.bug_report), text: 'Debug'),
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TapRegionSurface: the widget that creates the '
                  'registration surface for tap-outside detection.',
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Constructor, properties, and internal render object API.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Placement
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
                  'Where to place TapRegionSurface in the widget tree.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...placementWidgets,
            ],
          ),

          // Tab 4: Multiple Surfaces
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
                  'Nested and sibling surfaces: independent scopes.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...multiWidgets,
            ],
          ),

          // Tab 5: Behavior
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
                  'HitTestBehavior options for the surface.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...behaviorWidgets,
            ],
          ),

          // Tab 6: Integration
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
                  'How framework widgets use TapRegionSurface internally.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...integrationWidgets,
            ],
          ),

          // Tab 7: Debug
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
                  'Common issues and debugging tips.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...debugWidgets,
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
                      Colors.indigo.withOpacity(0.12),
                      Colors.blue.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TapRegionSurface.',
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
