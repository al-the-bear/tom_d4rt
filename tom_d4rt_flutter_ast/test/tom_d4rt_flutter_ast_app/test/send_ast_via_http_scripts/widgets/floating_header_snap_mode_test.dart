// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — FloatingHeaderSnapMode
// Demonstrates FloatingHeaderSnapMode — the enum that controls how
// floating SliverPersistentHeaders snap into view. Covers the enum
// values (overlay, snap), relationship with SliverPersistentHeader,
// SliverAppBar floating behavior, visual comparisons, and usage tips.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FloatingHeaderSnapMode Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FloatingHeaderSnapMode?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.vertical_align_top,
      'title': 'Controls Floating Header Snap',
      'body': 'FloatingHeaderSnapMode is an enum with two values '
          'that define how a floating SliverPersistentHeader snaps '
          'back into view when the user scrolls down. It controls '
          'the visual behavior of the snap animation — whether the '
          'header overlays content or pushes content down.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Used with SliverPersistentHeader',
      'body': 'When a SliverPersistentHeader has floating=true and '
          'a SliverPersistentHeaderDelegate that returns a non-null '
          'snapConfiguration, the FloatingHeaderSnapMode determines '
          'how the snap animation interacts with the scroll content.',
      'accent': Colors.blue[700]!,
    },
    {
      'icon': Icons.app_settings_alt,
      'title': 'SliverAppBar Connection',
      'body': 'SliverAppBar internally creates a '
          'SliverPersistentHeader. When floating=true and snap=true '
          'on SliverAppBar, the snap behavior follows the default '
          'FloatingHeaderSnapMode. The enum gives precise control '
          'over that animation.',
      'accent': Colors.cyan[600]!,
    },
    {
      'icon': Icons.animation,
      'title': 'Two Distinct Behaviors',
      'body': 'overlay: The header appears to slide over the scroll '
          'content without pushing it. snap: The header pushes '
          'content down as it snaps into place, creating a more '
          '"physical" feel. Both animate, but the spatial '
          'relationship with content differs.',
      'accent': Colors.blue[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Enum Values
  // ============================================================
  print('=== Section 2: Enum Values ===');

  final enumValues = <Map<String, dynamic>>[
    {
      'name': 'FloatingHeaderSnapMode.overlay',
      'index': 0,
      'icon': Icons.layers,
      'color': Colors.cyan[700]!,
      'shortLabel': 'overlay',
      'behavior': 'Slides over content',
      'description': 'The header overlays scroll content as it '
          'appears. The scroll content does not move — only the '
          'header animates into position. This creates an effect '
          'where the header "covers" the top of the list. '
          'This is the DEFAULT mode.',
      'visual': 'Header slides DOWN over the content, obscuring '
          'the top items until it reaches its resting position. '
          'Content stays in place.',
      'useCase': 'Suitable for transparent or semi-transparent '
          'headers, search bars, or toolbars that don\'t need to '
          'displace content. Common in social media feeds.',
    },
    {
      'name': 'FloatingHeaderSnapMode.snap',
      'index': 1,
      'icon': Icons.vertical_align_top,
      'color': Colors.blue[700]!,
      'shortLabel': 'snap',
      'behavior': 'Pushes content down',
      'description': 'The header snaps into view by pushing scroll '
          'content down. Both the header and the list content '
          'animate together — the list moves to make room. This '
          'creates a more "solid" / "physical" behavior.',
      'visual': 'Header pushes DOWN the content. List items move '
          'down as the header appears, no items are obscured. '
          'Feels more like a real object sliding into a slot.',
      'useCase': 'Better for opaque headers where content must '
          'always be fully visible. Navigation bars, status bars, '
          'or any header that shouldn\'t overlap content.',
    },
  ];

  print('  Prepared ${enumValues.length} enum values');

  // ============================================================
  // SECTION 3: SliverPersistentHeader Architecture
  // ============================================================
  print('=== Section 3: Architecture ===');

  final architecture = <Map<String, dynamic>>[
    {
      'name': 'CustomScrollView',
      'role': 'Container',
      'icon': Icons.view_list,
      'color': Colors.grey[600]!,
      'description': 'The outer scrollable that holds slivers. '
          'All SliverPersistentHeaders live inside this.',
    },
    {
      'name': 'SliverPersistentHeader',
      'role': 'Header Sliver',
      'icon': Icons.view_agenda,
      'color': Colors.cyan[600]!,
      'description': 'A sliver that stays at the top of the '
          'viewport. Can be floating (re-appears when scrolling '
          'down) or pinned (always visible).',
    },
    {
      'name': 'SliverPersistentHeaderDelegate',
      'role': 'Configuration',
      'icon': Icons.settings,
      'color': Colors.blue[600]!,
      'description': 'Defines the header\'s min/max extent, build '
          'method, and optionally a snapConfiguration with the '
          'FloatingHeaderSnapMode.',
    },
    {
      'name': 'FloatingHeaderSnapConfiguration',
      'role': 'Snap Config',
      'icon': Icons.tune,
      'color': Colors.cyan[700]!,
      'description': 'Contains the snapMode (FloatingHeaderSnapMode) '
          'and optional vsync for the snap animation. Created by '
          'the delegate\'s snapConfiguration getter.',
    },
    {
      'name': 'FloatingHeaderSnapMode',
      'role': 'Mode Enum',
      'icon': Icons.toggle_on,
      'color': Colors.blue[800]!,
      'description': 'THIS ENUM. Determines whether the snap '
          'animation overlays content or pushes it. Set in '
          'FloatingHeaderSnapConfiguration.',
    },
    {
      'name': 'SliverAppBar',
      'role': 'High-Level Widget',
      'icon': Icons.web_asset,
      'color': Colors.grey[500]!,
      'description': 'Convenience widget that wraps '
          'SliverPersistentHeader. When floating=true & snap=true, '
          'it uses the default snap mode (overlay).',
    },
  ];

  print('  Prepared ${architecture.length} architecture items');

  // ============================================================
  // SECTION 4: Visual Comparison
  // ============================================================
  print('=== Section 4: Visual Comparison ===');

  final visualComparison = <Map<String, dynamic>>[
    {
      'aspect': 'Mode',
      'overlay': 'overlay (default)',
      'snap': 'snap',
    },
    {
      'aspect': 'Header animation',
      'overlay': 'Slides down over content',
      'snap': 'Slides down, pushes content',
    },
    {
      'aspect': 'Content position',
      'overlay': 'Content stays in place',
      'snap': 'Content moves down',
    },
    {
      'aspect': 'Item obscuring',
      'overlay': 'Top items hidden behind header',
      'snap': 'No items hidden',
    },
    {
      'aspect': 'Feel',
      'overlay': 'Lightweight, layered',
      'snap': 'Solid, physical',
    },
    {
      'aspect': 'Performance',
      'overlay': 'Slightly easier (no content shift)',
      'snap': 'Slightly more work (content shifts)',
    },
    {
      'aspect': 'Best for',
      'overlay': 'Transparent / blurred headers',
      'snap': 'Opaque / solid headers',
    },
  ];

  print('  Prepared ${visualComparison.length} comparison rows');

  // ============================================================
  // SECTION 5: Timeline of the Snap Animation
  // ============================================================
  print('=== Section 5: Snap Timeline ===');

  final snapTimeline = <Map<String, dynamic>>[
    {
      'phase': 'Scrolling Up',
      'step': 1,
      'icon': Icons.arrow_upward,
      'color': Colors.cyan[600]!,
      'overlay': 'Header hidden above viewport. Content scrolls '
          'normally upward.',
      'snap': 'Same. Header hidden above viewport. Content scrolls '
          'normally upward.',
    },
    {
      'phase': 'Scroll Direction Reverses',
      'step': 2,
      'icon': Icons.swap_vert,
      'color': Colors.blue[600]!,
      'overlay': 'User starts scrolling down. The floating header '
          'begins to appear from the top edge.',
      'snap': 'Same trigger. User scrolls down; header starts to '
          'appear from top edge.',
    },
    {
      'phase': 'Snap Activated',
      'step': 3,
      'icon': Icons.animation,
      'color': Colors.cyan[700]!,
      'overlay': 'Header slides down OVER the content. Content '
          'stays still. Header covers top list items.',
      'snap': 'Header slides down AND content shifts down. No '
          'items are covered — they move to make room.',
    },
    {
      'phase': 'Snap Complete',
      'step': 4,
      'icon': Icons.check,
      'color': Colors.blue[700]!,
      'overlay': 'Header rests at its maxExtent position, still '
          'overlaying content. First visible list item may be '
          'partially hidden.',
      'snap': 'Header rests at maxExtent. Content has shifted down '
          'by the header height. All list items fully visible.',
    },
    {
      'phase': 'Resume Scroll Up',
      'step': 5,
      'icon': Icons.arrow_upward,
      'color': Colors.cyan[800]!,
      'overlay': 'Header shrinks/hides as user scrolls up. Content '
          'remains in place; previously hidden items re-appear.',
      'snap': 'Header shrinks/hides. Content shifts back up to fill '
          'the space the header occupied.',
    },
  ];

  print('  Prepared ${snapTimeline.length} timeline phases');

  // ============================================================
  // SECTION 6: Usage with SliverAppBar
  // ============================================================
  print('=== Section 6: SliverAppBar Usage ===');

  final appBarUsage = <Map<String, dynamic>>[
    {
      'name': 'Default floating SliverAppBar',
      'icon': Icons.web_asset,
      'color': Colors.cyan[700]!,
      'description': 'SliverAppBar(floating: true, snap: true) uses '
          'overlay mode by default. The app bar appears over the '
          'list content when scrolling down. This is the most '
          'common configuration.',
      'code': 'SliverAppBar(\n'
          '  floating: true,\n'
          '  snap: true,\n'
          '  title: Text(\'My App\'),\n'
          ')',
    },
    {
      'name': 'Custom delegate with snap mode',
      'icon': Icons.settings,
      'color': Colors.blue[700]!,
      'description': 'To control the snap mode, create a custom '
          'SliverPersistentHeaderDelegate and override '
          'snapConfiguration to return a '
          'FloatingHeaderSnapConfiguration with the desired mode.',
      'code': 'FloatingHeaderSnapConfiguration(\n'
          '  snapMode: FloatingHeaderSnapMode.snap,\n'
          '  curve: Curves.easeOut,\n'
          '  duration: Duration(milliseconds: 200),\n'
          ')',
    },
    {
      'name': 'Floating without snap',
      'icon': Icons.drag_handle,
      'color': Colors.cyan[600]!,
      'description': 'Setting floating=true but snap=false means '
          'the header follows the finger position exactly — no '
          'snap animation. FloatingHeaderSnapMode is irrelevant '
          'in this case because no snap occurs.',
      'code': 'SliverAppBar(\n'
          '  floating: true,\n'
          '  snap: false, // no snap animation\n'
          '  title: Text(\'Manual Float\'),\n'
          ')',
    },
    {
      'name': 'Pinned + floating + snap',
      'icon': Icons.push_pin,
      'color': Colors.blue[600]!,
      'description': 'When pinned=true, the header never fully '
          'disappears — it collapses to minExtent. The snap '
          'animation then expands it from minExtent to maxExtent. '
          'The snap mode still applies to how the expansion '
          'interacts with content.',
      'code': 'SliverAppBar(\n'
          '  pinned: true,\n'
          '  floating: true,\n'
          '  snap: true,\n'
          '  expandedHeight: 200,\n'
          ')',
    },
  ];

  print('  Prepared ${appBarUsage.length} usage patterns');

  // ============================================================
  // SECTION 7: Related Classes
  // ============================================================
  print('=== Section 7: Related Classes ===');

  final relatedClasses = <Map<String, dynamic>>[
    {
      'name': 'SliverPersistentHeader',
      'icon': Icons.view_agenda,
      'color': Colors.cyan[600]!,
      'relationship': 'Consumer',
      'description': 'The sliver widget that uses the snap mode. '
          'Its delegate provides the FloatingHeaderSnapConfiguration '
          'which contains the FloatingHeaderSnapMode enum value.',
    },
    {
      'name': 'FloatingHeaderSnapConfiguration',
      'icon': Icons.tune,
      'color': Colors.blue[700]!,
      'relationship': 'Container',
      'description': 'Configuration record that holds the snap mode '
          'enum value together with optional animation curve and '
          'duration. Returned by the delegate\'s snapConfiguration.',
    },
    {
      'name': 'SliverPersistentHeaderDelegate',
      'icon': Icons.settings,
      'color': Colors.cyan[700]!,
      'relationship': 'Provider',
      'description': 'Abstract delegate that provides the snap '
          'configuration. Override snapConfiguration getter to '
          'return a FloatingHeaderSnapConfiguration with the '
          'desired snap mode.',
    },
    {
      'name': 'SliverAppBar',
      'icon': Icons.web_asset,
      'color': Colors.blue[600]!,
      'relationship': 'High-level wrapper',
      'description': 'Creates a SliverPersistentHeader internally. '
          'When floating=true and snap=true, it configures the '
          'snap behavior. Does not directly expose the snap mode '
          'enum — uses overlay by default.',
    },
    {
      'name': 'RenderSliverFloatingPersistentHeader',
      'icon': Icons.developer_board,
      'color': Colors.grey[600]!,
      'relationship': 'Implementation',
      'description': 'The render object that implements the floating '
          'behavior. Reads the snap mode to decide whether to '
          'adjust content offset during the snap animation.',
    },
  ];

  print('  Prepared ${relatedClasses.length} related classes');

  // ============================================================
  // SECTION 8: Real-World Scenarios
  // ============================================================
  print('=== Section 8: Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'name': 'Search Bar Reveal',
      'icon': Icons.search,
      'color': Colors.cyan[700]!,
      'mode': 'overlay',
      'description': 'A search bar floating at the top of a product '
          'list. When the user scrolls down, the bar slides over '
          'the list. Overlay mode is natural here because the bar '
          'is semi-transparent / blurred and items behind it are '
          'still partially visible.',
    },
    {
      'name': 'Navigation Bar Return',
      'icon': Icons.menu,
      'color': Colors.blue[700]!,
      'mode': 'snap',
      'description': 'A solid navigation bar with tabs. When it '
          'snaps back, content should shift down — you don\'t want '
          'list items hidden behind an opaque bar. Snap mode '
          'ensures all content stays visible.',
    },
    {
      'name': 'Quick Action Toolbar',
      'icon': Icons.construction,
      'color': Colors.cyan[600]!,
      'mode': 'overlay',
      'description': 'A thin action toolbar (share, like, bookmark) '
          'that reappears when you start scrolling down in a feed. '
          'It\'s small enough that overlay is fine — minimal '
          'content is hidden and it feels lightweight.',
    },
    {
      'name': 'Filter/Sort Header',
      'icon': Icons.filter_list,
      'color': Colors.blue[600]!,
      'mode': 'snap',
      'description': 'A filter bar above search results. Users need '
          'to see the first result below the bar. Snap mode pushes '
          'results down so the first item is always fully visible '
          'after the header settles.',
    },
    {
      'name': 'Expandable AppBar with Hero Image',
      'icon': Icons.image,
      'color': Colors.cyan[800]!,
      'mode': 'overlay',
      'description': 'A SliverAppBar with a large hero image that '
          'collapses. When floating/snap re-expands it, overlay '
          'mode creates a nice parallax effect as the image '
          'appears over the scrolling content.',
    },
  ];

  print('  Prepared ${scenarios.length} scenarios');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Default Is Overlay',
      'body': 'If you don\'t specify a snap mode, overlay is used. '
          'This means headers will cover content when snapping. '
          'If your header is opaque and content shouldn\'t be '
          'hidden, explicitly set snap mode.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'snap=false Makes Mode Irrelevant',
      'body': 'FloatingHeaderSnapMode only matters when snap is '
          'enabled (snap=true on SliverAppBar, or '
          'snapConfiguration is non-null on the delegate). Without '
          'snap, the header follows the scroll position directly '
          'and no snap animation occurs.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test Both Modes Visually',
      'body': 'The difference between overlay and snap is subtle '
          'but important. Always test both modes with your actual '
          'header content to see which feels right. Opaque headers '
          'almost always want snap mode.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Custom Delegates for Custom Modes',
      'body': 'SliverAppBar does not expose the snap mode directly. '
          'To use FloatingHeaderSnapMode.snap with SliverAppBar, '
          'you need a custom SliverPersistentHeaderDelegate that '
          'overrides snapConfiguration.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Combine with stretchConfiguration',
      'body': 'In Flutter 3+, SliverAppBar also supports stretch '
          'mode. FloatingHeaderSnapMode and stretch modes are '
          'independent — you can combine them for rich scroll '
          'behaviors (snap on re-appear, stretch on overscroll).',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Snap Duration Affects UX',
      'body': 'FloatingHeaderSnapConfiguration also takes a '
          'duration and curve. A fast snap (100-200ms) feels '
          'responsive; a slow one (400ms+) feels sluggish. The '
          'mode determines WHAT animates, the duration determines '
          'HOW FAST.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('FloatingHeaderSnapMode'),
      backgroundColor: Colors.cyan[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan[700]!, Colors.blue[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.vertical_align_top,
                    color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'FloatingHeaderSnapMode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'An enum with two values that control how '
                  'floating SliverPersistentHeaders snap into '
                  'view — overlay (slides over content) or snap '
                  '(pushes content down).',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _snapHead('1', 'What is FloatingHeaderSnapMode?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Enum Values ──
          _snapHead('2', 'The Two Values'),
          SizedBox(height: 12),
          ...enumValues.map((ev) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border(
                      left: BorderSide(
                          color: ev['color'] as Color, width: 5),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ev['icon'] as IconData,
                            color: ev['color'] as Color, size: 24),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(ev['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: ev['color'] as Color)),
                        ),
                        _snapChip(ev['behavior'] as String,
                            ev['color'] as Color),
                      ]),
                      SizedBox(height: 10),
                      Text(ev['description'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (ev['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: (ev['color'] as Color)
                                  .withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Visual:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: ev['color'] as Color)),
                            SizedBox(height: 2),
                            Text(ev['visual'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Text('Use case: ${ev['useCase']}',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Architecture ──
          _snapHead('3', 'Architecture & Class Relationships'),
          SizedBox(height: 12),
          ...architecture.map((a) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: a['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(a['icon'] as IconData,
                            color: a['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(a['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: a['color'] as Color)),
                        ),
                        _snapChip(
                            a['role'] as String, Colors.grey[500]!),
                      ]),
                      SizedBox(height: 4),
                      Text(a['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Visual Comparison Table ──
          _snapHead('4', 'Overlay vs Snap Comparison'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.cyan[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('Overlay',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('Snap',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...visualComparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 6, horizontal: 10),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(row['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))),
                      Expanded(
                          flex: 3,
                          child: Text(row['overlay'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.cyan[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 3,
                          child: Text(row['snap'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.blue[700],
                                  height: 1.3))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 5: Snap Timeline ──
          _snapHead('5', 'Snap Animation Timeline'),
          SizedBox(height: 12),
          ...snapTimeline.map((st) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: st['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: st['color'] as Color,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text('${st['step']}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11)),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Icon(st['icon'] as IconData,
                                      color: st['color'] as Color,
                                      size: 14),
                                  SizedBox(width: 4),
                                  Text(st['phase'] as String,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ]),
                                SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.cyan[50],
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('overlay',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color:
                                                        Colors.cyan[700],
                                                    fontSize: 9)),
                                            SizedBox(height: 2),
                                            Text(
                                                st['overlay'] as String,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color:
                                                        Colors.grey[700],
                                                    height: 1.2)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.blue[50],
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('snap',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color:
                                                        Colors.blue[700],
                                                    fontSize: 9)),
                                            SizedBox(height: 2),
                                            Text(st['snap'] as String,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color:
                                                        Colors.grey[700],
                                                    height: 1.2)),
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
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: SliverAppBar Usage ──
          _snapHead('6', 'Usage with SliverAppBar'),
          SizedBox(height: 12),
          ...appBarUsage.map((u) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: u['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(u['icon'] as IconData,
                            color: u['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(u['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(u['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(u['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.cyan[800],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Related Classes ──
          _snapHead('7', 'Related Classes'),
          SizedBox(height: 12),
          ...relatedClasses.map((rc) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: rc['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(rc['icon'] as IconData,
                            color: rc['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(rc['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: rc['color'] as Color)),
                        ),
                        _snapChip(rc['relationship'] as String,
                            Colors.grey[500]!),
                      ]),
                      SizedBox(height: 4),
                      Text(rc['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Scenarios ──
          _snapHead('8', 'Real-World Scenarios'),
          SizedBox(height: 12),
          ...scenarios.map((s) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: s['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(s['icon'] as IconData,
                            color: s['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(s['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                        _snapChip(s['mode'] as String,
                            s['mode'] == 'overlay'
                                ? Colors.cyan[600]!
                                : Colors.blue[600]!),
                      ]),
                      SizedBox(height: 8),
                      Text(s['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _snapHead('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of FloatingHeaderSnapMode Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading with numbered badge
// ──────────────────────────────────────────────────────────
Widget _snapHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.cyan[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Small chip/tag badge
// ──────────────────────────────────────────────────────────
Widget _snapChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
