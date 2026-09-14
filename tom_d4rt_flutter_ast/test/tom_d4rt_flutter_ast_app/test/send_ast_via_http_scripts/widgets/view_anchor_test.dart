// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ViewAnchor
// Demonstrates ViewAnchor, a widget that renders a secondary view tree
// anchored to a primary widget, enabling multi-view rendering patterns
// like overlays and floating panels that persist across view boundaries.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ViewAnchor Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.anchor,
      'title': 'What is ViewAnchor?',
      'body': 'ViewAnchor is a widget that attaches a secondary View to '
          'a position in the primary widget tree. The anchored view '
          'renders at the same location as its anchor but in a '
          'separate rendering pipeline — ideal for overlays.',
      'accent': Colors.pink,
    },
    {
      'icon': Icons.layers,
      'title': 'Multi-View Architecture',
      'body': 'Flutter supports rendering multiple views from a single '
          'widget tree. ViewAnchor creates an entry point for a '
          'secondary view that is anchored to, but independent of, '
          'the primary rendering surface.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.picture_in_picture,
      'title': 'Overlay-Like Behavior',
      'body': 'Unlike Overlay which composites within the same view, '
          'ViewAnchor creates a genuinely separate view. This means '
          'the anchored content can draw without being clipped by '
          'the primary view\u0027s boundaries.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.update,
      'title': 'Lifecycle Tie-In',
      'body': 'The secondary view is created when ViewAnchor mounts '
          'and disposed when it unmounts. Its position updates '
          'automatically as the anchor widget moves in the primary '
          'view\u0027s layout.',
      'accent': Colors.orange,
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
      'name': 'view',
      'type': 'Widget',
      'desc': 'The widget tree that forms the content of the secondary '
          'view. This tree is rendered in a separate view anchored '
          'to the position of this widget in the primary tree.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The primary-view child widget. This renders in the normal '
          'widget tree. The secondary view is anchored at the same '
          'position as this child in the layout.',
    },
    {
      'name': 'View',
      'type': 'Widget (related)',
      'desc': 'The fundamental single-view widget. ViewAnchor creates a '
          'View internally to host the secondary content. View wraps '
          'a FlutterView and establishes a rendering pipeline.',
    },
    {
      'name': 'ViewCollection',
      'type': 'Widget (related)',
      'desc': 'A widget that manages multiple Views. ViewAnchor can be '
          'thought of as a convenient way to add a view to a '
          'ViewCollection anchored at a specific widget.',
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
              ? Colors.pink.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.pink.withOpacity(0.25)),
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
                    color: Colors.pink.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.pink.shade800,
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
  // SECTION 3: Anchoring Mechanism
  // ============================================================
  print('=== Section 3: Anchoring ===');

  final anchoringSteps = <Map<String, dynamic>>[
    {
      'step': '1. Mount ViewAnchor',
      'desc': 'When ViewAnchor is inserted into the widget tree, it '
          'creates a secondary FlutterView associated with the '
          'current rendering context.',
      'icon': Icons.add_circle,
      'color': Colors.pink,
    },
    {
      'step': '2. Layout Primary Child',
      'desc': 'The primary child is laid out in the normal widget tree. '
          'Its position and size are computed as part of the standard '
          'layout pass.',
      'icon': Icons.straighten,
      'color': Colors.blue,
    },
    {
      'step': '3. Position Secondary View',
      'desc': 'The engine positions the secondary view\u0027s origin at '
          'the top-left of the primary child\u0027s layout rectangle. '
          'The secondary view follows the anchor automatically.',
      'icon': Icons.gps_fixed,
      'color': Colors.green,
    },
    {
      'step': '4. Render Independently',
      'desc': 'The secondary view runs its own rendering pipeline. '
          'It has its own build, layout, and paint phases. It can '
          'extend beyond the primary child\u0027s bounds.',
      'icon': Icons.brush,
      'color': Colors.orange,
    },
    {
      'step': '5. Scroll/Move Updates',
      'desc': 'When the primary child scrolls or repositions, the '
          'secondary view\u0027s anchor point updates accordingly. '
          'The overlay content stays attached to its anchor.',
      'icon': Icons.sync,
      'color': Colors.purple,
    },
    {
      'step': '6. Unmount Cleanup',
      'desc': 'When ViewAnchor unmounts, the secondary view is '
          'destroyed and its rendering resources released. No '
          'manual cleanup is needed.',
      'icon': Icons.delete_sweep,
      'color': Colors.red,
    },
  ];

  final anchorWidgets = <Widget>[];
  for (var i = 0; i < anchoringSteps.length; i++) {
    final as_ = anchoringSteps[i];
    final asColor = as_['color'] as Color;
    print('Anchor ${i + 1}: ${as_['step']}');
    anchorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: asColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    as_['icon'] as IconData,
                    color: asColor,
                    size: 18,
                  ),
                ),
                if (i < anchoringSteps.length - 1)
                  Container(
                    width: 2,
                    height: 24,
                    color: asColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: asColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: asColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      as_['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: asColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      as_['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
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
  // SECTION 4: Overlays with ViewAnchor
  // ============================================================
  print('=== Section 4: Overlays ===');

  final overlayScenarios = <Map<String, dynamic>>[
    {
      'title': 'Tooltip Floating',
      'desc': 'A tooltip that extends beyond the parent widget\u0027s clip '
          'boundary. Traditional overlays are clipped by ancestor '
          'ClipRect or ClipRRect. A ViewAnchor-based tooltip renders '
          'in a separate view, avoiding any clipping.',
      'color': Colors.pink,
      'visual': 'Button \u2192 [ViewAnchor] \u2192 floating tooltip above',
    },
    {
      'title': 'Dropdown Menu',
      'desc': 'A dropdown that appears below a trigger button. Because '
          'the dropdown is in a separate view, it can extend below '
          'the trigger\u0027s container or scroll boundaries without '
          'being cut off.',
      'color': Colors.blue,
      'visual': 'Trigger \u2192 [ViewAnchor] \u2192 dropdown list below',
    },
    {
      'title': 'Context Menu',
      'desc': 'A right-click/long-press context menu anchored to the '
          'interaction point. The menu floats in a secondary view '
          'and is positioned relative to the touch/click location.',
      'color': Colors.green,
      'visual': 'Widget \u2192 long press \u2192 [ViewAnchor] \u2192 menu',
    },
    {
      'title': 'Popover Panel',
      'desc': 'A rich content panel anchored to a specific widget. '
          'Contains forms, images, or interactive content. The panel '
          'is a separate view so it does not affect the primary '
          'layout or receive clipping from ancestors.',
      'color': Colors.orange,
      'visual': 'Info icon \u2192 [ViewAnchor] \u2192 floating panel',
    },
  ];

  final overlayWidgets = <Widget>[];
  for (var i = 0; i < overlayScenarios.length; i++) {
    final os = overlayScenarios[i];
    final osColor = os['color'] as Color;
    print('Overlay ${i + 1}: ${os['title']}');
    overlayWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: osColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: osColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                os['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: osColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                os['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  os['visual'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
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
  // SECTION 5: Multi-View Architecture
  // ============================================================
  print('=== Section 5: Multi-View ===');

  final multiViewTopics = <Map<String, dynamic>>[
    {
      'title': 'Single View (Traditional)',
      'desc': 'Traditional Flutter apps render everything into one '
          'FlutterView. Overlays, menus, and tooltips are all part '
          'of the same rendering pipeline and are subject to the '
          'same clipping and compositing rules.',
      'diagram': 'App \u2192 [Single FlutterView]\n'
          '  \u251C\u2500 Scaffold\n'
          '  \u251C\u2500 Overlay\n'
          '  \u2514\u2500 Tooltips\n'
          '\n'
          '  Everything shares one render surface',
      'color': Colors.grey,
    },
    {
      'title': 'Multi-View (ViewAnchor)',
      'desc': 'With ViewAnchor, floating UI gets its own rendering '
          'surface. The primary view contains the app content. Each '
          'ViewAnchor adds a secondary view that can draw '
          'independently, with its own compositing layer.',
      'diagram': 'App \u2192 [Primary View]\n'
          '  \u251C\u2500 Scaffold (primary)\n'
          '  \u251C\u2500 ViewAnchor1 \u2192 [Secondary View 1]\n'
          '  \u2514\u2500 ViewAnchor2 \u2192 [Secondary View 2]\n'
          '\n'
          '  Multiple independent render surfaces',
      'color': Colors.pink,
    },
    {
      'title': 'Embedding Use Case',
      'desc': 'When Flutter is embedded in a native app (add-to-app), '
          'ViewAnchor allows floating UI that extends beyond the '
          'Flutter container. The secondary view can draw over '
          'native content outside the Flutter embed.',
      'diagram': 'Native App\n'
          '  \u251C\u2500 Native Header\n'
          '  \u251C\u2500 Flutter Embed \u2192 [Primary View]\n'
          '  \u2502   \u2514\u2500 ViewAnchor \u2192 [Secondary View]\n'
          '  \u2514\u2500 Native Footer\n'
          '\n'
          '  Secondary view can draw over native',
      'color': Colors.blue,
    },
  ];

  final multiViewWidgets = <Widget>[];
  for (var i = 0; i < multiViewTopics.length; i++) {
    final mv = multiViewTopics[i];
    final mvColor = mv['color'] as Color;
    print('MultiView ${i + 1}: ${mv['title']}');
    multiViewWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: mvColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: mvColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mv['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: mvColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                mv['desc'] as String,
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
                  mv['diagram'] as String,
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
  // SECTION 6: Positioning
  // ============================================================
  print('=== Section 6: Positioning ===');

  final positionTopics = <Map<String, dynamic>>[
    {
      'title': 'Anchor Origin',
      'desc': 'The secondary view\u0027s origin is at the top-left corner '
          'of the primary child\u0027s render box. All positioning in '
          'the secondary view is relative to this anchor point.',
      'color': Colors.pink,
    },
    {
      'title': 'Offset Within View',
      'desc': 'Content in the secondary view can use Positioned or '
          'Align to place itself relative to the anchor origin. '
          'Negative offsets position content above or to the left '
          'of the anchor.',
      'color': Colors.blue,
    },
    {
      'title': 'Size Independence',
      'desc': 'The secondary view can be larger or smaller than the '
          'anchor child. It is not constrained by the anchor\u0027s '
          'size. A small button can anchor a large popover.',
      'color': Colors.green,
    },
    {
      'title': 'Scroll Tracking',
      'desc': 'As the anchor child scrolls, the secondary view follows. '
          'The engine updates the view\u0027s position each frame '
          'to match the anchor\u0027s current screen coordinates.',
      'color': Colors.orange,
    },
    {
      'title': 'Screen Boundaries',
      'desc': 'The secondary view can extend beyond the screen edges. '
          'The app is responsible for clamping or repositioning '
          'content to keep it visible, similar to how tooltips '
          'flip direction near screen edges.',
      'color': Colors.purple,
    },
  ];

  final positionWidgets = <Widget>[];
  for (var i = 0; i < positionTopics.length; i++) {
    final pt = positionTopics[i];
    final ptColor = pt['color'] as Color;
    print('Position ${i + 1}: ${pt['title']}');
    positionWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ptColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ptColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: ptColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ptColor,
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
                    pt['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ptColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    pt['desc'] as String,
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
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'ViewAnchor + Overlay',
      'desc': 'Wrap an Overlay entry in ViewAnchor for floating content '
          'that escapes clipping. The overlay manages show/hide '
          'logic; ViewAnchor handles rendering surface.',
      'icon': Icons.layers,
      'color': Colors.pink,
    },
    {
      'title': 'ViewAnchor + CompositedTransformTarget',
      'desc': 'Pair ViewAnchor with CompositedTransformTarget/Follower '
          'for precise offset tracking between primary and secondary '
          'view content.',
      'icon': Icons.link,
      'color': Colors.blue,
    },
    {
      'title': 'Conditional ViewAnchor',
      'desc': 'Wrap ViewAnchor in a conditional (if isOpen) to create '
          'and destroy the secondary view on demand. The view is '
          'only allocated while needed.',
      'icon': Icons.toggle_on,
      'color': Colors.green,
    },
    {
      'title': 'ViewAnchor + Portal',
      'desc': 'Use ViewAnchor as a "portal" to render widget subtrees '
          'in a different rendering context. Children in the portal '
          'can access inherited widgets from the anchor location.',
      'icon': Icons.open_in_new,
      'color': Colors.orange,
    },
    {
      'title': 'Nested ViewAnchors',
      'desc': 'ViewAnchors can nest: a secondary view can contain another '
          'ViewAnchor, creating a chain of anchored views. Each is '
          'anchored to its parent\u0027s position in the chain.',
      'icon': Icons.account_tree,
      'color': Colors.purple,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patterns.length; i++) {
    final p = patterns[i];
    final pColor = p['color'] as Color;
    print('Pattern ${i + 1}: ${p['title']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: pColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  p['icon'] as IconData,
                  color: pColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: pColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p['desc'] as String,
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
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.anchor,
      'text': 'ViewAnchor attaches a secondary View rendering surface '
          'to a position in the primary widget tree.',
    },
    {
      'icon': Icons.layers,
      'text': 'The secondary view renders independently, escaping '
          'clipping and compositing constraints of the primary view.',
    },
    {
      'icon': Icons.gps_fixed,
      'text': 'The anchor point tracks the primary child\u0027s position '
          'automatically as it scrolls or repositions.',
    },
    {
      'icon': Icons.picture_in_picture,
      'text': 'Ideal for tooltips, dropdowns, context menus, and '
          'popovers that must not be clipped by ancestors.',
    },
    {
      'icon': Icons.update,
      'text': 'Created on mount, destroyed on unmount. No manual '
          'lifecycle management needed by the developer.',
    },
    {
      'icon': Icons.view_in_ar,
      'text': 'Part of Flutter\u0027s multi-view architecture alongside '
          'View, ViewCollection, and the rendering pipeline.',
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
          color: Colors.pink.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.pink.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.pink.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.pink.shade800,
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
        title: const Text('ViewAnchor'),
        backgroundColor: Colors.pink.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.anchor), text: 'Anchoring'),
            Tab(icon: Icon(Icons.picture_in_picture), text: 'Overlays'),
            Tab(icon: Icon(Icons.view_in_ar), text: 'Multi-View'),
            Tab(icon: Icon(Icons.gps_fixed), text: 'Position'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
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
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'ViewAnchor: anchor a secondary rendering view to a '
                  'position in the primary widget tree.',
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
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'ViewAnchor API and related multi-view widgets.',
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
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How the secondary view is anchored and positioned.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...anchorWidgets,
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
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'ViewAnchor for overlay scenarios that escape clipping.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...overlayWidgets,
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
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Multi-view rendering architecture in Flutter.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...multiViewWidgets,
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
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How content is positioned within the secondary view.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...positionWidgets,
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
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common patterns combining ViewAnchor with other widgets.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
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
                      Colors.pink.withOpacity(0.12),
                      Colors.red.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about ViewAnchor.',
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
