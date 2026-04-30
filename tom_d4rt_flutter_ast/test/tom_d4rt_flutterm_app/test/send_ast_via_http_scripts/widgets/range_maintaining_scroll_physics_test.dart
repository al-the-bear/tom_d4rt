// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — RangeMaintainingScrollPhysics
// Demonstrates RangeMaintainingScrollPhysics — a ScrollPhysics
// subclass that keeps the scroll position stable when content
// dimensions change (items added/removed). Covers adjustment
// logic, boundary enforcement, overscroll handling, physics
// chaining, and practical dynamic-content patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RangeMaintainingScrollPhysics Deep Demo executing');

  // ============================================================
  // SECTION 1: What is RangeMaintainingScrollPhysics?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.swap_vert,
      'title': 'Stable Scroll Position',
      'body': 'RangeMaintainingScrollPhysics ensures the scroll position '
          'stays stable when the size or number of items in a scrollable '
          'changes. Without it, adding or removing items can cause the '
          'viewport to jump to an unexpected position.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.dynamic_feed,
      'title': 'Dynamic Content Friendly',
      'body': 'Perfect for lists where items are added to the top, removed '
          'from the middle, or change size. Chat apps, feeds, and live '
          'dashboards all benefit from this physics. The user\'s view '
          'remains anchored while content mutates.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.tune,
      'title': 'Position Adjustment Logic',
      'body': 'The key method is adjustPositionForNewDimensions(). It '
          'examines old vs. new scroll extents and applies intelligent '
          'logic: if the user was in range, keep them in range. If they '
          'were overscrolled, preserve the overscroll distance.',
      'accent': Colors.teal[600]!,
    },
    {
      'icon': Icons.link,
      'title': 'Physics Chaining',
      'body': 'Like all ScrollPhysics subclasses, it can be combined '
          'with a parent physics via applyTo(). For example, combine '
          'with BouncingScrollPhysics for iOS-style bouncing that '
          'also maintains position on content changes.',
      'accent': Colors.cyan[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Adjustment Algorithm
  // ============================================================
  print('=== Section 2: Adjustment Algorithm ===');

  final algorithmSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Check Animation State',
      'detail': 'If the scroll position is currently animating (e.g., '
          'a fling or programmatic scroll is in progress), skip all '
          'adjustments. Let the animation complete naturally.',
      'icon': Icons.animation,
      'color': Colors.teal[700]!,
    },
    {
      'step': 2,
      'title': 'Detect Extent Changes',
      'detail': 'Compare old min/maxScrollExtent with new values. '
          'If both are unchanged, ignore any overscroll and return '
          'the old position — the viewport hasn\'t actually changed.',
      'icon': Icons.compare_arrows,
      'color': Colors.cyan[700]!,
    },
    {
      'step': 3,
      'title': 'Detect Position Changes',
      'detail': 'If the position was already corrected elsewhere '
          '(e.g., by another listener), respect that correction '
          'and skip further adjustment.',
      'icon': Icons.track_changes,
      'color': Colors.teal[600]!,
    },
    {
      'step': 4,
      'title': 'Handle Overscroll',
      'detail': 'If the old position was beyond min or max, compute '
          'the overscroll delta (how far past the boundary). Apply '
          'the same delta to the new boundary to maintain the same '
          'overscroll distance.',
      'icon': Icons.expand,
      'color': Colors.cyan[600]!,
    },
    {
      'step': 5,
      'title': 'Enforce Boundaries',
      'detail': 'If the old position was within range but new dimensions '
          'moved the boundaries, clamp the position to the new range. '
          'The user stays as close to their original position as possible.',
      'icon': Icons.border_inner,
      'color': Colors.teal[500]!,
    },
  ];

  print('  Prepared ${algorithmSteps.length} algorithm steps');

  // ============================================================
  // SECTION 3: Properties & Methods
  // ============================================================
  print('=== Section 3: Properties & Methods ===');

  final apiEntries = <Map<String, dynamic>>[
    {
      'name': 'adjustPositionForNewDimensions',
      'type': 'double Function(...)',
      'icon': Icons.tune,
      'color': Colors.teal[700]!,
      'description': 'The core method. Called by the scroll position when '
          'content dimensions change. Receives old/new metrics and the '
          'current velocity, then returns the adjusted pixel position. '
          'This is where all the stabilization logic lives.',
    },
    {
      'name': 'applyTo',
      'type': 'RangeMaintainingScrollPhysics Function(ScrollPhysics?)',
      'icon': Icons.link,
      'color': Colors.cyan[700]!,
      'description': 'Creates a new RangeMaintainingScrollPhysics chained '
          'with the given parent physics. Delegation is automatic — '
          'createBallisticSimulation, tolerance, and other behaviors '
          'come from the parent while position adjustment stays here.',
    },
    {
      'name': 'parent',
      'type': 'ScrollPhysics?',
      'icon': Icons.account_tree,
      'color': Colors.teal[600]!,
      'description': 'The parent physics in the chain. When non-null, '
          'most physics behaviors delegated to this parent. '
          'RangeMaintainingScrollPhysics only overrides the position '
          'adjustment method.',
    },
    {
      'name': 'tolerance',
      'type': 'Tolerance (inherited)',
      'icon': Icons.straighten,
      'color': Colors.cyan[600]!,
      'description': 'The precision thresholds for velocity and distance. '
          'Used to decide when a scroll should stop. Inherited from '
          'parent or uses the default Tolerance values.',
    },
  ];

  print('  API entries: ${apiEntries.length}');

  // ============================================================
  // SECTION 4: Dynamic List Scenario
  // ============================================================
  print('=== Section 4: Dynamic List Scenario ===');

  final scenarioItems = <Map<String, dynamic>>[
    {'id': 1, 'text': 'First message in the chat', 'time': '09:00', 'mine': false},
    {'id': 2, 'text': 'Hey, how are you?', 'time': '09:01', 'mine': true},
    {'id': 3, 'text': 'I\'m great, thanks! Working on the demo.', 'time': '09:02', 'mine': false},
    {'id': 4, 'text': 'That sounds interesting. Tell me more!', 'time': '09:03', 'mine': true},
    {'id': 5, 'text': 'It\'s about scroll physics — they keep the view stable.', 'time': '09:04', 'mine': false},
    {'id': 6, 'text': 'So no jumping when new messages arrive?', 'time': '09:05', 'mine': true},
    {'id': 7, 'text': 'Exactly! The physics adjust the position automatically.', 'time': '09:06', 'mine': false},
    {'id': 8, 'text': 'That\'s really useful for real-time apps.', 'time': '09:07', 'mine': true},
  ];

  print('  Chat messages: ${scenarioItems.length}');

  // ============================================================
  // SECTION 5: Physics Chaining Patterns
  // ============================================================
  print('=== Section 5: Physics Chaining ===');

  final chainingExamples = <Map<String, dynamic>>[
    {
      'title': 'Bouncing + Range Maintaining',
      'code': 'BouncingScrollPhysics(\n'
          '  parent: RangeMaintainingScrollPhysics(),\n'
          ')',
      'description': 'iOS-style bouncing overscroll combined with position '
          'stability. Items can be added/removed without jumps, and the '
          'overscroll still bounces at the edges.',
      'icon': Icons.phone_iphone,
      'color': Colors.teal[700]!,
    },
    {
      'title': 'Clamping + Range Maintaining',
      'code': 'ClampingScrollPhysics(\n'
          '  parent: RangeMaintainingScrollPhysics(),\n'
          ')',
      'description': 'Android-style clamped overscroll with position '
          'stability. Edges glow instead of bounce, but content changes '
          'don\'t shift the viewport.',
      'icon': Icons.phone_android,
      'color': Colors.cyan[700]!,
    },
    {
      'title': 'Never Scrollable + Range Maintaining',
      'code': 'NeverScrollableScrollPhysics(\n'
          '  parent: RangeMaintainingScrollPhysics(),\n'
          ')',
      'description': 'Disabled scrolling with position stability. Useful '
          'when you programmatically control the position but still want '
          'stable behavior when content dimensions change.',
      'icon': Icons.lock,
      'color': Colors.teal[600]!,
    },
    {
      'title': 'Standalone (Default)',
      'code': 'RangeMaintainingScrollPhysics()',
      'description': 'Without parent, delegates to the platform default. '
          'On iOS this means BouncingScrollPhysics behavior, on Android '
          'ClampingScrollPhysics — both with position maintenance.',
      'icon': Icons.settings,
      'color': Colors.cyan[600]!,
    },
  ];

  print('  Chaining examples: ${chainingExamples.length}');

  // ============================================================
  // SECTION 6: Before vs After Comparison
  // ============================================================
  print('=== Section 6: Before vs After ===');

  final beforeAfterRows = <Map<String, dynamic>>[
    {
      'scenario': 'Item added above viewport',
      'without': 'Viewport jumps down by item height',
      'with': 'Position adjusted — view stays put',
    },
    {
      'scenario': 'Item removed above viewport',
      'without': 'Viewport jumps up unexpectedly',
      'with': 'Position adjusted — view stays put',
    },
    {
      'scenario': 'Content shrinks below viewport',
      'without': 'May overscroll past new max',
      'with': 'Clamped to new max extent',
    },
    {
      'scenario': 'Already overscrolled, content grows',
      'without': 'Overscroll distance changes',
      'with': 'Same overscroll delta preserved',
    },
    {
      'scenario': 'During fling animation',
      'without': 'Animation may overshoot',
      'with': 'No adjustment — animation finishes',
    },
  ];

  print('  Before/after rows: ${beforeAfterRows.length}');

  // ============================================================
  // SECTION 7: When to Use (and When Not)
  // ============================================================
  print('=== Section 7: When to Use ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Chat / Messaging',
      'recommend': true,
      'detail': 'New messages arrive at the bottom while the user reads '
          'earlier messages. Without range maintaining, the view jumps.',
      'icon': Icons.chat_bubble_outline,
      'color': Colors.green[700]!,
    },
    {
      'title': 'Social Media Feed',
      'recommend': true,
      'detail': 'New posts appear and old posts are removed as the user '
          'scrolls. The feed should feel stable despite mutations.',
      'icon': Icons.dynamic_feed,
      'color': Colors.green[700]!,
    },
    {
      'title': 'Live Dashboard',
      'recommend': true,
      'detail': 'Widgets resize based on real-time data. Position stays '
          'stable despite fluctuating content heights.',
      'icon': Icons.dashboard,
      'color': Colors.green[700]!,
    },
    {
      'title': 'Static Content',
      'recommend': false,
      'detail': 'If content never changes after initial build, the '
          'overhead of RangeMaintainingScrollPhysics is unnecessary. '
          'Standard physics work fine.',
      'icon': Icons.article,
      'color': Colors.orange[700]!,
    },
    {
      'title': 'Pagination Only',
      'recommend': false,
      'detail': 'If items are only appended at the end (infinite scroll), '
          'no position shift occurs. Standard physics are sufficient.',
      'icon': Icons.more_horiz,
      'color': Colors.orange[700]!,
    },
  ];

  print('  Use cases: ${useCases.length}');

  // ============================================================
  // SECTION 8: Code Examples
  // ============================================================
  print('=== Section 8: Code Examples ===');

  final codeExamples = <Map<String, String>>[
    {
      'title': 'Basic ListView Usage',
      'code': 'ListView.builder(\n'
          '  physics: RangeMaintainingScrollPhysics(),\n'
          '  itemCount: items.length,\n'
          '  itemBuilder: (ctx, i) => ListTile(\n'
          '    title: Text(items[i]),\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'CustomScrollView with Slivers',
      'code': 'CustomScrollView(\n'
          '  physics: RangeMaintainingScrollPhysics(),\n'
          '  slivers: [\n'
          '    SliverAppBar(title: Text("Feed")),\n'
          '    SliverList(\n'
          '      delegate: SliverChildBuilderDelegate(\n'
          '        (ctx, i) => FeedCard(items[i]),\n'
          '        childCount: items.length,\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
    },
    {
      'title': 'Chained with BouncingScrollPhysics',
      'code': 'ListView.builder(\n'
          '  physics: BouncingScrollPhysics(\n'
          '    parent: RangeMaintainingScrollPhysics(),\n'
          '  ),\n'
          '  itemCount: messages.length,\n'
          '  itemBuilder: (ctx, i) => ChatBubble(\n'
          '    messages[i],\n'
          '  ),\n'
          ')',
    },
  ];

  print('  Code examples: ${codeExamples.length}');

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
              colors: [Colors.teal[800]!, Colors.cyan[700]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.swap_vert, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'RangeMaintainingScrollPhysics',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Keeps scroll position stable when content dimensions '
                'change — no viewport jumps when items are added, removed, '
                'or resized dynamically.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.teal[700]!),
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

        // ---- Section 2: Algorithm ----
        _sectionHeader('2. Adjustment Algorithm', Icons.account_tree, Colors.cyan[700]!),
        SizedBox(height: 10),
        ...algorithmSteps.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: s['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('${s['step']}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s['title'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        SizedBox(height: 3),
                        Text(s['detail'] as String,
                            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: API ----
        _sectionHeader('3. Properties & Methods', Icons.api, Colors.teal[700]!),
        SizedBox(height: 10),
        ...apiEntries.map((a) => Padding(
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
                        Icon(a['icon'] as IconData, color: a['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(a['name'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace', color: a['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(a['type'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.grey[800])),
                    ),
                    SizedBox(height: 6),
                    Text(a['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 4: Chat Scenario ----
        _sectionHeader('4. Chat Scenario', Icons.chat, Colors.teal[700]!),
        SizedBox(height: 10),
        Text(
          'A chat app using RangeMaintainingScrollPhysics. New messages '
          'can arrive without shifting the viewport for the reader:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            children: scenarioItems.map((m) {
              final isMine = m['mine'] as bool;
              return Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    if (!isMine) SizedBox(width: 0),
                    Container(
                      constraints: BoxConstraints(maxWidth: 260),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isMine ? Colors.teal[600] : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: isMine ? Radius.circular(12) : Radius.circular(2),
                          bottomRight: isMine ? Radius.circular(2) : Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m['text'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              color: isMine ? Colors.white : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            m['time'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              color: isMine ? Colors.white60 : Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.teal[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.teal[700], size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'With RangeMaintainingScrollPhysics, reading earlier '
                  'messages stays undisturbed when new ones arrive.',
                  style: TextStyle(fontSize: 12, color: Colors.teal[800]),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 5: Physics Chaining ----
        _sectionHeader('5. Physics Chaining', Icons.link, Colors.cyan[700]!),
        SizedBox(height: 10),
        ...chainingExamples.map((e) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (e['color'] as Color).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: e['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(e['icon'] as IconData, color: e['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Text(e['title'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: e['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(e['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.greenAccent[200])),
                    ),
                    SizedBox(height: 6),
                    Text(e['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 6: Before vs. After ----
        _sectionHeader('6. Before vs. After', Icons.compare, Colors.teal[700]!),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Colors.teal[700],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Scenario', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 3, child: Text('Without', style: TextStyle(color: Colors.red[200], fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 3, child: Text('With', style: TextStyle(color: Colors.greenAccent[100], fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
              ),
              ...List.generate(beforeAfterRows.length, (i) {
                final r = beforeAfterRows[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.grey[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text(r['scenario'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
                      Expanded(flex: 3, child: Text(r['without'] as String, style: TextStyle(fontSize: 12, color: Colors.red[700]))),
                      Expanded(flex: 3, child: Text(r['with'] as String, style: TextStyle(fontSize: 12, color: Colors.green[700]))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 7: When to Use ----
        _sectionHeader('7. When to Use', Icons.help_outline, Colors.teal[700]!),
        SizedBox(height: 10),
        ...useCases.map((u) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (u['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: u['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Icon(u['icon'] as IconData, color: u['color'] as Color, size: 24),
                        SizedBox(height: 4),
                        Icon(
                          (u['recommend'] as bool) ? Icons.check_circle : Icons.info_outline,
                          color: u['color'] as Color,
                          size: 16,
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(u['title'] as String,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              SizedBox(width: 6),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: u['color'] as Color,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  (u['recommend'] as bool) ? 'Recommended' : 'Not needed',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(u['detail'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Code Examples ----
        _sectionHeader('8. Code Examples', Icons.code, Colors.cyan[700]!),
        SizedBox(height: 10),
        ...codeExamples.map((ex) => Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ex['title']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(ex['code']!,
                        style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.greenAccent[200])),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

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
              Icon(Icons.swap_vert, color: Colors.teal[600], size: 28),
              SizedBox(height: 6),
              Text(
                'RangeMaintainingScrollPhysics: the invisible guardian of '
                'scroll stability. Content can mutate freely while your '
                'users\' viewport stays exactly where they expect.',
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
