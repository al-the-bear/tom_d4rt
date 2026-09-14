// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RenderSliverFillRemaining
// Demonstrates RenderSliverFillRemaining — the render object that sizes a
// single non-scrollable child to fill the remaining viewport space in a
// scrollable container. Accessed through the SliverFillRemaining widget.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFillRemaining Deep Demo executing');

  // ============================================================
  // SECTION 1: What RenderSliverFillRemaining Is — Concept
  // ============================================================
  print('=== Section 1: RenderSliverFillRemaining Concept ===');

  // RenderSliverFillRemaining is a RenderSliver that takes a single
  // RenderBox child and sizes it to fill whatever remaining space
  // exists in the viewport's main axis. It extends
  // RenderSliverSingleBoxAdapter and is typically the LAST sliver
  // in a CustomScrollView.
  //
  // The widget-level API is SliverFillRemaining, which delegates
  // to one of three render objects depending on configuration:
  //   1. RenderSliverFillRemainingWithScrollable (hasScrollBody=true)
  //   2. RenderSliverFillRemaining (hasScrollBody=false, fillOverscroll=false)
  //   3. RenderSliverFillRemainingAndOverscroll (hasScrollBody=false, fillOverscroll=true)
  //
  // This demo focuses on RenderSliverFillRemaining — the non-scrollable
  // fill variant — and shows how it behaves through its widget wrapper.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.vertical_align_bottom, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RenderSliverFillRemaining',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'extends RenderSliverSingleBoxAdapter',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'A render sliver that takes a single non-scrollable box child '
            'and sizes it to fill all remaining space in the viewport\'s '
            'main axis. Typically used as the last sliver in a '
            'CustomScrollView to create footers, empty-state displays, '
            'loading indicators, or any content that should expand to '
            'fill unused viewport area.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildConceptChip('Fill Space', Icons.expand, Color(0xFFCE93D8)),
            _buildConceptChip('Non-Scrollable', Icons.block, Color(0xFFEF9A9A)),
            _buildConceptChip('Last Sliver', Icons.last_page, Color(0xFF80CBC4)),
          ],
        ),
      ],
    ),
  );

  print('  Concept card built');

  // ============================================================
  // SECTION 2: The Three SliverFillRemaining Modes
  // ============================================================
  print('=== Section 2: Three Modes ===');

  // SliverFillRemaining has three modes that select different
  // render objects internally:
  //
  // Mode 1: hasScrollBody=true (default)
  //   → Uses RenderSliverFillRemainingWithScrollable
  //   → Child has a scrollable body (like NestedScrollView)
  //   → Minimum size = remaining space, but can grow larger
  //
  // Mode 2: hasScrollBody=false, fillOverscroll=false
  //   → Uses RenderSliverFillRemaining (THIS class)
  //   → Child fills exactly the remaining space
  //   → If child intrinsic size > remaining, child wins
  //
  // Mode 3: hasScrollBody=false, fillOverscroll=true
  //   → Uses RenderSliverFillRemainingAndOverscroll
  //   → Like Mode 2 but stretches into overscroll area (iOS bounce)

  final modesSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Three SliverFillRemaining Modes', Icons.tune),
        SizedBox(height: 12.0),
        _buildModeCard(
          'Mode 1: hasScrollBody = true',
          'RenderSliverFillRemainingWithScrollable',
          'The child extends beyond the viewport and can scroll '
          'within its space. Used with scrollable children like '
          'ListView or SingleChildScrollView.',
          Color(0xFF1B5E20),
          Icons.swap_vert,
          'SliverFillRemaining(\n'
          '  hasScrollBody: true, // default\n'
          '  child: ListView(...),\n'
          ')',
        ),
        SizedBox(height: 10.0),
        _buildModeCard(
          'Mode 2: hasScrollBody = false (THIS)',
          'RenderSliverFillRemaining',
          'The child is non-scrollable and fills exactly the remaining '
          'viewport space. If the child\'s intrinsic size exceeds the '
          'remaining space, the child\'s size wins.',
          Color(0xFF0D47A1),
          Icons.vertical_align_bottom,
          'SliverFillRemaining(\n'
          '  hasScrollBody: false,\n'
          '  child: Center(child: Text("Footer")),\n'
          ')',
        ),
        SizedBox(height: 10.0),
        _buildModeCard(
          'Mode 3: fillOverscroll = true',
          'RenderSliverFillRemainingAndOverscroll',
          'Like Mode 2, but the child also stretches to fill the '
          'overscroll area when bouncing (iOS-style physics). '
          'Only effective when hasScrollBody is false.',
          Color(0xFFE65100),
          Icons.expand,
          'SliverFillRemaining(\n'
          '  hasScrollBody: false,\n'
          '  fillOverscroll: true,\n'
          '  child: Container(color: Colors.purple),\n'
          ')',
        ),
      ],
    ),
  );

  print('  Three modes section built');

  // ============================================================
  // SECTION 3: Layout Mechanics — performLayout() Deep Dive
  // ============================================================
  print('=== Section 3: Layout Mechanics ===');

  // The performLayout() method:
  // 1. Calculates remaining extent:
  //    extent = viewportMainAxisExtent - precedingScrollExtent
  // 2. Measures child intrinsic size along main axis
  // 3. Uses max(extent, childIntrinsicSize) → child never clipped
  // 4. Constrains child with both min and max = computed extent
  // 5. Calculates paint offset accounting for scroll position
  // 6. Reports SliverGeometry with scrollExtent, paintExtent, etc.

  final layoutSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Layout Mechanics — performLayout()', Icons.settings_applications),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFCE93D8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How RenderSliverFillRemaining Sizes Its Child',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 12.0),
              _buildLayoutStep(
                1,
                'Calculate remaining space',
                'extent = viewportMainAxisExtent\n'
                '       - precedingScrollExtent',
                'viewport is 800px, preceding content is 300px → remaining = 500px',
              ),
              _buildLayoutStep(
                2,
                'Measure child intrinsic size',
                'childExtent = child.getMaxIntrinsicHeight(\n'
                '                crossAxisExtent)',
                'Child wants 200px height intrinsically',
              ),
              _buildLayoutStep(
                3,
                'Choose the larger value',
                'finalExtent = max(extent, childExtent)',
                'max(500, 200) = 500px — remaining space wins',
              ),
              _buildLayoutStep(
                4,
                'Layout child with tight constraints',
                'child.layout(BoxConstraints(\n'
                '  minHeight: 500, maxHeight: 500,\n'
                '  minWidth: 0, maxWidth: crossAxisExtent))',
                'Child fills exactly 500px of remaining viewport',
              ),
              _buildLayoutStep(
                5,
                'Calculate paint offset for scrolling',
                'paintedChildSize = calculatePaintOffset(\n'
                '  from: 0.0, to: extent)',
                'Adjusts visibility as user scrolls through content',
              ),
              _buildLayoutStep(
                6,
                'Report SliverGeometry',
                'geometry = SliverGeometry(\n'
                '  scrollExtent: extent,\n'
                '  paintExtent: paintedChildSize,\n'
                '  maxPaintExtent: paintedChildSize)',
                'Viewport now knows how much space this sliver uses',
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  Layout mechanics section built');

  // ============================================================
  // SECTION 4: Live Demo — Footer Filling Remaining Space
  // ============================================================
  print('=== Section 4: Footer Demo ===');

  // A CustomScrollView with some content slivers followed by
  // SliverFillRemaining(hasScrollBody: false) as a footer.
  // The footer fills whatever space remains below the content.

  final footerDemo = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Live Demo — Footer at Bottom', Icons.dock),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'The SliverFillRemaining footer (purple) fills all space '
            'below the content items. Scroll to see slivers + footer.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF2E7D32)),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 350.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFF9E9E9E), width: 2.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text('My App'),
                backgroundColor: Color(0xFF1565C0),
                pinned: true,
                expandedHeight: 80.0,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36.0,
                          height: 36.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFBBDEFB),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1565C0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          'Content item #${index + 1}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                  childCount: 3,
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF7B1FA2), Color(0xFF4A148C)],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.white, size: 48.0),
                      SizedBox(height: 12.0),
                      Text(
                        'Footer — Fills Remaining Space',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        'SliverFillRemaining(hasScrollBody: false)',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        'Uses RenderSliverFillRemaining internally',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        _buildCodeSnippetCard(
          'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverAppBar(title: Text("My App"), pinned: true),\n'
          '    SliverList(delegate: SliverChildBuilderDelegate(...)),\n'
          '    SliverFillRemaining(  // ← Fills remaining space\n'
          '      hasScrollBody: false,\n'
          '      child: Container(\n'
          '        color: Colors.purple,\n'
          '        child: Center(child: Text("Footer")),\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
        ),
      ],
    ),
  );

  print('  Footer demo built');

  // ============================================================
  // SECTION 5: Live Demo — Empty State Centered
  // ============================================================
  print('=== Section 5: Empty State Demo ===');

  // When there's no content above, SliverFillRemaining fills the
  // entire viewport. Perfect for empty states.

  final emptyStateDemo = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Live Demo — Empty State Placeholder', Icons.inbox),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'With no preceding slivers, SliverFillRemaining occupies '
            'the entire viewport — ideal for "no data" empty states.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFFE65100)),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 280.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFF9E9E9E), width: 2.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  color: Color(0xFFFAFAFA),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined, size: 64.0, color: Color(0xFFBDBDBD)),
                      SizedBox(height: 16.0),
                      Text(
                        'No Items Yet',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF616161),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Add some items to get started.',
                        style: TextStyle(fontSize: 14.0, color: Color(0xFF9E9E9E)),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF1565C0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'Add Item',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  Empty state demo built');

  // ============================================================
  // SECTION 6: Live Demo — hasScrollBody = true
  // ============================================================
  print('=== Section 6: hasScrollBody Demo ===');

  // When hasScrollBody=true (default), the remaining space is set
  // as minimum extent, but the child can grow larger and scroll.
  // Uses RenderSliverFillRemainingWithScrollable internally.

  final scrollBodyDemo = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('hasScrollBody = true (Default Mode)', Icons.swap_vert),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'With hasScrollBody=true (default), the child gets at least '
            'the remaining space but can grow larger and scroll internally. '
            'Uses RenderSliverFillRemainingWithScrollable.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF0D47A1)),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFF42A5F5), width: 2.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  color: Color(0xFF1565C0),
                  child: Text(
                    'Header Content',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: Container(
                  color: Color(0xFFE8EAF6),
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFC5CAE9)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8.0,
                            color: Color(0xFF5C6BC0),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Scrollable item ${index + 1}',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Color(0xFF283593),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        _buildCodeSnippetCard(
          'SliverFillRemaining(\n'
          '  hasScrollBody: true, // default — child can scroll\n'
          '  child: ListView.builder(\n'
          '    itemCount: 15,\n'
          '    itemBuilder: (ctx, i) => ListTile(title: Text("Item \$i")),\n'
          '  ),\n'
          ')',
        ),
      ],
    ),
  );

  print('  hasScrollBody demo built');

  // ============================================================
  // SECTION 7: fillOverscroll Behavior
  // ============================================================
  print('=== Section 7: fillOverscroll Behavior ===');

  // fillOverscroll only has effect when hasScrollBody=false.
  // On platforms with bouncing scroll physics (iOS), pulling
  // past the end causes overscroll. With fillOverscroll=true,
  // the child stretches into that overscroll area.
  //
  // This uses RenderSliverFillRemainingAndOverscroll internally.

  final overscrollSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('fillOverscroll Behavior', Icons.expand),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xFF66BB6A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18.0),
                        SizedBox(width: 6.0),
                        Text(
                          'fillOverscroll: true',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Child stretches into the overscroll area '
                      'when the user pulls beyond the scroll extent. '
                      'Creates a natural background fill effect.',
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF1B5E20), height: 1.4),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Uses:\nRenderSliverFillRemaining\nAndOverscroll',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: Color(0xFF388E3C),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFCE4EC),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xFFEF5350)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.cancel, color: Color(0xFFC62828), size: 18.0),
                        SizedBox(width: 6.0),
                        Text(
                          'fillOverscroll: false',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            color: Color(0xFFC62828),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Child stays at its computed size even during '
                      'overscroll. A gap may appear between the child '
                      'and viewport edge during bounce.',
                      style: TextStyle(fontSize: 11.0, color: Color(0xFFB71C1C), height: 1.4),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Uses:\nRenderSliverFill\nRemaining',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Live side-by-side comparison
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'fillOverscroll: true',
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Color(0xFF66BB6A), width: 2.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            height: 60.0,
                            color: Color(0xFF42A5F5),
                            alignment: Alignment.center,
                            child: Text('Header', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          fillOverscroll: true,
                          child: Container(
                            color: Color(0xFFA5D6A7),
                            alignment: Alignment.center,
                            child: Text(
                              'Stretches\ninto overscroll',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'fillOverscroll: false',
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Color(0xFFEF5350), width: 2.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            height: 60.0,
                            color: Color(0xFF42A5F5),
                            alignment: Alignment.center,
                            child: Text('Header', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          fillOverscroll: false,
                          child: Container(
                            color: Color(0xFFEF9A9A),
                            alignment: Alignment.center,
                            child: Text(
                              'Does NOT stretch\ninto overscroll',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB71C1C),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('  fillOverscroll section built');

  // ============================================================
  // SECTION 8: Intrinsic Size vs Remaining Space
  // ============================================================
  print('=== Section 8: Intrinsic Size vs Remaining Space ===');

  // When hasScrollBody=false, RenderSliverFillRemaining computes:
  //   extent = max(remainingSpace, childIntrinsicHeight)
  // This means if the child needs MORE space than what remains,
  // the child's intrinsic size wins and the sliver grows.
  //
  // This prevents content from being clipped or squeezed.

  final intrinsicSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Intrinsic Size vs Remaining Space', Icons.compare_arrows),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFFFB300)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Size Resolution Rule',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'finalExtent = max(remainingViewport, childIntrinsicHeight)',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: Color(0xFF795548),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Remaining > Intrinsic',
                            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Child fills\nremaining space',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10.0, color: Color(0xFF2E7D32)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFCE4EC),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Intrinsic > Remaining',
                            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Child uses its\nintrinsic height',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10.0, color: Color(0xFFC62828)),
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
        SizedBox(height: 12.0),
        // Demo: lots of preceding content → remaining space is small
        Container(
          height: 280.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFFFB300), width: 2.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomScrollView(
            slivers: [
              SliverFixedExtentList(
                itemExtent: 40.0,
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    color: index.isEven ? Color(0xFFE3F2FD) : Color(0xFFBBDEFB),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 14.0),
                    child: Text(
                      'Preceding item ${index + 1}',
                      style: TextStyle(fontSize: 12.0, color: Color(0xFF1565C0)),
                    ),
                  ),
                  childCount: 8,
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  color: Color(0xFFFFF9C4),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, size: 32.0, color: Color(0xFFF57F17)),
                      SizedBox(height: 8.0),
                      Text(
                        'This child has a large intrinsic height.',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF57F17),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'If the preceding content takes most of the viewport, '
                        'the intrinsic height may exceed the remaining space. '
                        'In that case, the child\'s intrinsic height wins '
                        'and the sliver grows beyond what "remains".',
                        style: TextStyle(fontSize: 11.0, color: Color(0xFF795548), height: 1.4),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  Intrinsic vs remaining section built');

  // ============================================================
  // SECTION 9: Real-World Patterns
  // ============================================================
  print('=== Section 9: Real-World Patterns ===');

  // Common usage patterns for SliverFillRemaining / RenderSliverFillRemaining

  final patternsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Real-World Usage Patterns', Icons.apps),
        SizedBox(height: 12.0),
        // Pattern 1: Loading indicator
        _buildPatternCard(
          'Loading Indicator',
          Icons.hourglass_empty,
          Color(0xFF0D47A1),
          'Show a centered spinner below existing content while more data loads.',
          Container(
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFFBBDEFB)),
            ),
            clipBehavior: Clip.antiAlias,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 40.0,
                    color: Color(0xFFE3F2FD),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text('Loaded content...', style: TextStyle(fontSize: 12.0)),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Loading more...',
                          style: TextStyle(fontSize: 11.0, color: Color(0xFF9E9E9E)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // Pattern 2: Error state
        _buildPatternCard(
          'Error State',
          Icons.error_outline,
          Color(0xFFC62828),
          'Display an error message filling the remaining viewport after partial content.',
          Container(
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFFEF9A9A)),
            ),
            clipBehavior: Clip.antiAlias,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 30.0,
                    color: Color(0xFFEEEEEE),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text('Some data loaded...', style: TextStyle(fontSize: 11.0)),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    color: Color(0xFFFCE4EC),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.cloud_off, size: 30.0, color: Color(0xFFC62828)),
                          SizedBox(height: 6.0),
                          Text(
                            'Failed to load remaining data',
                            style: TextStyle(fontSize: 12.0, color: Color(0xFFC62828)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // Pattern 3: Centered form
        _buildPatternCard(
          'Centered Form',
          Icons.edit_note,
          Color(0xFF2E7D32),
          'Position a login form or input area centered in remaining viewport space.',
          Container(
            height: 140.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFFA5D6A7)),
            ),
            clipBehavior: Clip.antiAlias,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 30.0,
                    color: Color(0xFF2E7D32),
                    alignment: Alignment.center,
                    child: Text('App Header', style: TextStyle(color: Colors.white, fontSize: 12.0)),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Container(
                      width: 200.0,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Sign In', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8.0),
                          Container(
                            height: 24.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFBDBDBD)),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Container(
                            height: 24.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF2E7D32),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            alignment: Alignment.center,
                            child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 11.0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  print('  Patterns section built');

  // ============================================================
  // SECTION 10: Related Render Classes Comparison
  // ============================================================
  print('=== Section 10: Related Render Classes ===');

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Related Render Sliver Classes', Icons.compare),
        SizedBox(height: 12.0),
        _buildComparisonRow(
          'RenderSliverFillRemaining',
          'Non-scrollable child sized to fill remaining viewport. '
          'Child intrinsic height used if larger than remaining space.',
          Color(0xFF7B1FA2),
          true,
        ),
        SizedBox(height: 8.0),
        _buildComparisonRow(
          'RenderSliverFillRemainingWithScrollable',
          'Scrollable child gets remaining space as minimum extent. '
          'Child can grow beyond and scroll. Default mode.',
          Color(0xFF1565C0),
          false,
        ),
        SizedBox(height: 8.0),
        _buildComparisonRow(
          'RenderSliverFillRemainingAndOverscroll',
          'Like FillRemaining but also stretches child into overscroll '
          'area during iOS-style bounce.',
          Color(0xFFE65100),
          false,
        ),
        SizedBox(height: 8.0),
        _buildComparisonRow(
          'RenderSliverFillViewport',
          'Sizes EACH child to fill the entire viewport extent. '
          'Used by SliverFillViewport for page-like scrolling.',
          Color(0xFF2E7D32),
          false,
        ),
        SizedBox(height: 8.0),
        _buildComparisonRow(
          'RenderSliverSingleBoxAdapter',
          'Base class for slivers with a single box child. '
          'Parent of all Fill variants.',
          Color(0xFF616161),
          false,
        ),
      ],
    ),
  );

  print('  Comparison section built');

  // ============================================================
  // SECTION 11: API Property Reference
  // ============================================================
  print('=== Section 11: API Property Reference ===');

  final apiSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'API Reference — SliverFillRemaining',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Widget wrapper for RenderSliverFillRemaining',
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: Color(0xFF757575),
          ),
        ),
        Divider(height: 20.0),
        _buildApiRow('child', 'Widget?', 'The box widget to size and paint'),
        _buildApiRow('hasScrollBody', 'bool', 'true → scrollable child; false → fixed child'),
        _buildApiRow('fillOverscroll', 'bool', 'true → stretch into overscroll (iOS). Only when hasScrollBody=false'),
        Divider(height: 20.0),
        Text(
          'Render Object: RenderSliverFillRemaining',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        SizedBox(height: 8.0),
        _buildApiRow('child', 'RenderBox?', 'The child render box'),
        _buildApiRow('performLayout()', 'void', 'Calculates remaining space and lays out child'),
        _buildApiRow('constraints', 'SliverConstraints', 'Inherited — viewport main/cross axis info'),
        _buildApiRow('geometry', 'SliverGeometry?', 'Output — scroll extent, paint extent, etc.'),
        Divider(height: 20.0),
        Text(
          'Key SliverConstraints properties used:',
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xFF424242)),
        ),
        SizedBox(height: 6.0),
        _buildApiRow('viewportMainAxisExtent', 'double', 'Total viewport size in scroll direction'),
        _buildApiRow('precedingScrollExtent', 'double', 'Total scroll extent before this sliver'),
        _buildApiRow('crossAxisExtent', 'double', 'Viewport size perpendicular to scroll'),
        _buildApiRow('scrollOffset', 'double', 'How far this sliver has been scrolled'),
      ],
    ),
  );

  print('  API section built');

  // ============================================================
  // Assemble all sections
  // ============================================================
  print('Assembling RenderSliverFillRemaining demo...');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        conceptCard,
        SizedBox(height: 12.0),
        modesSection,
        SizedBox(height: 20.0),
        layoutSection,
        SizedBox(height: 20.0),
        footerDemo,
        SizedBox(height: 20.0),
        emptyStateDemo,
        SizedBox(height: 20.0),
        scrollBodyDemo,
        SizedBox(height: 20.0),
        overscrollSection,
        SizedBox(height: 20.0),
        intrinsicSection,
        SizedBox(height: 20.0),
        patternsSection,
        SizedBox(height: 20.0),
        comparisonSection,
        SizedBox(height: 20.0),
        apiSection,
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ============================================================
// Helper Widgets
// ============================================================

Widget _buildSectionTitle(String title, IconData icon) {
  return Row(
    children: [
      Icon(icon, color: Color(0xFF4A148C), size: 22.0),
      SizedBox(width: 8.0),
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
      ),
    ],
  );
}

Widget _buildConceptChip(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.0, color: color),
        SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(fontSize: 11.0, color: color, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

Widget _buildModeCard(
  String title,
  String renderClass,
  String description,
  Color accentColor,
  IconData icon,
  String codeSnippet,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accentColor.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accentColor.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accentColor, size: 20.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          renderClass,
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: accentColor.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(fontSize: 12.0, color: Color(0xFF424242), height: 1.4),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            codeSnippet,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLayoutStep(int step, String title, String code, String example) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: Color(0xFF7B1FA2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  code,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF80CBC4),
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Example: $example',
                style: TextStyle(
                  fontSize: 10.0,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeSnippetCard(String code) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontSize: 11.0,
        fontFamily: 'monospace',
        color: Color(0xFF80CBC4),
        height: 1.4,
      ),
    ),
  );
}

Widget _buildPatternCard(
  String title,
  IconData icon,
  Color color,
  String description,
  Widget demo,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161), height: 1.3),
        ),
        SizedBox(height: 8.0),
        demo,
      ],
    ),
  );
}

Widget _buildComparisonRow(
  String className,
  String description,
  Color color,
  bool isHighlighted,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: isHighlighted ? color.withValues(alpha: 0.08) : Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: isHighlighted ? color : Color(0xFFE0E0E0),
        width: isHighlighted ? 2.0 : 1.0,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                className,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(fontSize: 11.0, color: Color(0xFF616161), height: 1.3),
              ),
            ],
          ),
        ),
        if (isHighlighted)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'THIS',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _buildApiRow(String param, String type, String description) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.0,
          child: Text(
            param,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A148C),
            ),
          ),
        ),
        SizedBox(
          width: 80.0,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFF757575),
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF616161)),
          ),
        ),
      ],
    ),
  );
}
