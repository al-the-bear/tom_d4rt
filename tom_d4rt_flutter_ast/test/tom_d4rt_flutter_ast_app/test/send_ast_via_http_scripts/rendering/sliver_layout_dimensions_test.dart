// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: SliverLayoutDimensions deep demo
// Visual demonstration of how persistent sliver headers receive layout
// dimensions on every layout pass and how each of the four fields contributes
// to the rendering decisions of a custom SliverPersistentHeaderDelegate.
import 'package:flutter/material.dart';

// ============================================================
// Custom delegate used by Section 3, 6 and others. The
// SliverPersistentHeaderDelegate.build hook receives the
// shrinkOffset which is conceptually a slice of the four-field
// SliverLayoutDimensions record. We render a debug card that
// reports the live shrinkOffset value as a progress bar.
// ============================================================
class _DimsHeaderDelegate extends SliverPersistentHeaderDelegate {
  _DimsHeaderDelegate({
    required this.label,
    required this.minHeight,
    required this.maxHeight,
    required this.color,
    required this.icon,
  });

  final String label;
  final double minHeight;
  final double maxHeight;
  final Color color;
  final IconData icon;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double range = (maxHeight - minHeight);
    final double progress =
        range <= 0.0 ? 0.0 : (shrinkOffset / range).clamp(0.0, 1.0);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.85),
            color.withValues(alpha: 0.55),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: 10.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'shrinkOffset=${shrinkOffset.toStringAsFixed(1)} '
                  'overlaps=$overlapsContent',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 4.0),
                Container(
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate old) => true;
}

// ============================================================
// Decorative section header used at the start of every block.
// ============================================================
Widget _sectionTitle(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 24.0, bottom: 12.0),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.06),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 26.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// Mono code-style block for inline snippets.
Widget _codeBlock(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.5)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Color(0xFFB5CEA8),
        fontFamily: 'monospace',
        fontSize: 12.0,
        height: 1.4,
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  print('SliverLayoutDimensions Deep Demo executing');

  // ============================================================
  // SECTION 1: HERO HEADER — what is SliverLayoutDimensions?
  // ============================================================
  print('=== Section 1: Hero Header ===');

  final Widget hero = Container(
    width: double.infinity,
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF283593),
          Color(0xFF3949AB),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1A237E).withValues(alpha: 0.4),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.view_agenda_outlined,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SliverLayoutDimensions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'The four-field record passed to delegate.build()',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Text(
          'A SliverPersistentHeaderDelegate.build() callback receives the live '
          'layout dimensions on every layout pass. The four fields '
          '(scrollOffset, precedingScrollExtent, viewportMainAxisExtent, '
          'crossAxisExtent) describe where the header sits inside the viewport '
          'and how big the surrounding viewport currently is.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            height: 1.45,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip(Icons.swap_vert, 'scrollOffset'),
            _heroChip(Icons.linear_scale, 'precedingScrollExtent'),
            _heroChip(Icons.height, 'viewportMainAxisExtent'),
            _heroChip(Icons.aspect_ratio, 'crossAxisExtent'),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: THE FOUR FIELDS — one card per field
  // ============================================================
  print('=== Section 2: Four field cards ===');

  final List<Widget> fieldCards = <Widget>[];

  fieldCards.add(_fieldCard(
    title: 'scrollOffset',
    subtitle: 'How far the user has scrolled past this header',
    color: Color(0xFF00897B),
    icon: Icons.swap_vert,
    example: '0.0 ........ 320.0 (when scrolled 320px past the header)',
    diagram: 'viewport top  +---------------+\n'
        '              |  header(0px)  |   scrollOffset = 0\n'
        '              +---------------+\n'
        '   (scroll v)\n'
        'viewport top  +---------------+\n'
        '              |  header(120px)|   scrollOffset = 120\n'
        '              +---------------+',
    narrative:
        'scrollOffset is the distance from the leading edge of the '
        'sliver to the leading edge of the viewport. When pinned, this '
        'grows past minExtent and the delegate uses it to collapse '
        'visuals (shrink title, hide secondary content).',
  ));

  fieldCards.add(_fieldCard(
    title: 'precedingScrollExtent',
    subtitle: 'Total scroll length of slivers before this one',
    color: Color(0xFFE65100),
    icon: Icons.linear_scale,
    example: 'Header at index 3 with two 200px slivers before -> 400.0',
    diagram: 'slivers in scroll order:\n'
        '[ A=200px ][ B=200px ][ HEADER ][ C=... ][ D=... ]\n'
        '+--------- 400.0 ---------+\n'
        'precedingScrollExtent = 400.0',
    narrative:
        'precedingScrollExtent answers the question: how much scroll '
        'must the user produce before the header could possibly come '
        'into view? Useful for sticky table-of-contents and global '
        'progress indicators.',
  ));

  fieldCards.add(_fieldCard(
    title: 'viewportMainAxisExtent',
    subtitle: 'Live size of the surrounding viewport on the main axis',
    color: Color(0xFF6A1B9A),
    icon: Icons.height,
    example: 'On a phone in portrait: 812.0; rotated to landscape: 375.0',
    diagram: '+------------ viewport ------------+\n'
        '|                                  |  height = 812\n'
        '|   ...slivers scroll inside...    |\n'
        '|                                  |\n'
        '+----------------------------------+\n'
        'viewportMainAxisExtent = 812.0',
    narrative:
        'Lets a delegate decide when to switch to compact layouts. '
        'Headers may render extra metadata only when the viewport is '
        'tall enough to comfortably fit the expanded form.',
  ));

  fieldCards.add(_fieldCard(
    title: 'crossAxisExtent',
    subtitle: 'Width perpendicular to the scroll direction',
    color: Color(0xFFC2185B),
    icon: Icons.aspect_ratio,
    example: 'Phone width 375.0; tablet split-view width 720.0',
    diagram: 'horizontal range available to the header\n'
        '+--------------------------------------+  crossAxisExtent\n'
        '|<-- header content area (width) ----->|\n'
        '+--------------------------------------+',
    narrative:
        'crossAxisExtent describes the cross-direction. For a vertical '
        'CustomScrollView this is the width. The delegate uses it to '
        'select responsive layouts (single column vs multi column) '
        'without a separate MediaQuery lookup.',
  ));

  final Widget fieldGrid = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: fieldCards,
  );

  // ============================================================
  // SECTION 3: LIVE CustomScrollView with a real persistent header
  // ============================================================
  print('=== Section 3: Live CustomScrollView ===');

  final Widget liveDemo = Container(
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF8E24AA), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF8E24AA).withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    padding: EdgeInsets.all(8.0),
    child: SizedBox(
      height: 320.0,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: _DimsHeaderDelegate(
              label: 'Pinned debug header (reads shrinkOffset)',
              minHeight: 60.0,
              maxHeight: 110.0,
              color: Color(0xFF6A1B9A),
              icon: Icons.push_pin,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              _scrollItem('Item 0 - scroll me to see shrinkOffset grow',
                  Color(0xFFE1BEE7)),
              _scrollItem('Item 1 - header collapses from 110->60',
                  Color(0xFFCE93D8)),
              _scrollItem('Item 2 - once shrinkOffset=range, header is min',
                  Color(0xFFBA68C8)),
              _scrollItem('Item 3 - pinned headers stay fully visible',
                  Color(0xFFAB47BC)),
              _scrollItem(
                  'Item 4 - overlapsContent flips when content scrolls under',
                  Color(0xFF9C27B0)),
              _scrollItem('Item 5 - try a longer scroll to see clamping',
                  Color(0xFF8E24AA)),
              _scrollItem('Item 6 - delegate.build() runs every layout pass',
                  Color(0xFF7B1FA2)),
              _scrollItem('Item 7 - that is by design and very cheap',
                  Color(0xFF6A1B9A)),
            ]),
          ),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 4: PERSISTENT HEADER LIFECYCLE DIAGRAM
  // ============================================================
  print('=== Section 4: Lifecycle diagram ===');

  final Widget lifecycle = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF00838F).withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Persistent header lifecycle',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006064),
          ),
        ),
        SizedBox(height: 14.0),
        _lifecycleStep(
          '1. Layout pass starts',
          'Viewport requests size of every sliver via performLayout().',
          Icons.play_arrow,
          Color(0xFF00838F),
        ),
        _lifecycleArrow(),
        _lifecycleStep(
          '2. Sliver computes dimensions',
          'scrollOffset, precedingScrollExtent, viewportMainAxisExtent, '
              'crossAxisExtent are bundled.',
          Icons.calculate_outlined,
          Color(0xFF0097A7),
        ),
        _lifecycleArrow(),
        _lifecycleStep(
          '3. delegate.build(context, shrinkOffset, overlapsContent)',
          'Rebuilds widget tree. shouldRebuild() decides if cached '
              'output can be reused.',
          Icons.build_circle_outlined,
          Color(0xFF00ACC1),
        ),
        _lifecycleArrow(),
        _lifecycleStep(
          '4. paint()',
          'Header is painted between minExtent and maxExtent depending '
              'on shrinkOffset.',
          Icons.format_paint,
          Color(0xFF00BCD4),
        ),
        _lifecycleArrow(),
        _lifecycleStep(
          '5. pinned vs floating',
          'pinned=true sticks to the leading edge; floating=true flies '
              'in on reverse scroll.',
          Icons.push_pin_outlined,
          Color(0xFF26C6DA),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: SliverLayoutDimensions vs SliverConstraints
  // ============================================================
  print('=== Section 5: Comparison table ===');

  final Widget comparison = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF455A64), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF455A64).withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SliverLayoutDimensions vs SliverConstraints',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(child: _compareHeader('Field', Color(0xFF263238))),
            Expanded(
                child: _compareHeader(
                    'LayoutDimensions', Color(0xFF1565C0))),
            Expanded(
                child: _compareHeader('Constraints', Color(0xFFAD1457))),
          ],
        ),
        Divider(),
        _compareRow('scrollOffset', true, true),
        _compareRow('precedingScrollExtent', true, true),
        _compareRow('viewportMainAxisExtent', true, true),
        _compareRow('crossAxisExtent', true, true),
        _compareRow('overlap', false, true),
        _compareRow('remainingPaintExtent', false, true),
        _compareRow('axisDirection', false, true),
        _compareRow('userScrollDirection', false, true),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Newer signature receives layout dimensions as a record:\n'
          '@override\n'
          'Widget build(BuildContext c, SliverLayoutDimensions dims) {\n'
          '  final double offset = dims.scrollOffset;\n'
          '  final double w = dims.crossAxisExtent;\n'
          '  return SizedBox(width: w, child: ...);\n'
          '}',
          Color(0xFF1565C0),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: PINNED VS FLOATING — side-by-side comparison
  // ============================================================
  print('=== Section 6: Pinned vs floating ===');

  final Widget pinnedBox = Container(
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFEF6C00), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFEF6C00).withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    padding: EdgeInsets.all(6.0),
    child: SizedBox(
      height: 200.0,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: _DimsHeaderDelegate(
              label: 'pinned: true',
              minHeight: 50.0,
              maxHeight: 90.0,
              color: Color(0xFFEF6C00),
              icon: Icons.push_pin,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              _scrollItem('Pinned A', Color(0xFFFFE0B2)),
              _scrollItem('Pinned B', Color(0xFFFFCC80)),
              _scrollItem('Pinned C', Color(0xFFFFB74D)),
              _scrollItem('Pinned D', Color(0xFFFFA726)),
              _scrollItem('Pinned E', Color(0xFFFB8C00)),
            ]),
          ),
        ],
      ),
    ),
  );

  final Widget floatingBox = Container(
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFF2E7D32), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF2E7D32).withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    padding: EdgeInsets.all(6.0),
    child: SizedBox(
      height: 200.0,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            floating: true,
            delegate: _DimsHeaderDelegate(
              label: 'floating: true',
              minHeight: 50.0,
              maxHeight: 90.0,
              color: Color(0xFF2E7D32),
              icon: Icons.cloud_outlined,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              _scrollItem('Floating A', Color(0xFFC8E6C9)),
              _scrollItem('Floating B', Color(0xFFA5D6A7)),
              _scrollItem('Floating C', Color(0xFF81C784)),
              _scrollItem('Floating D', Color(0xFF66BB6A)),
              _scrollItem('Floating E', Color(0xFF4CAF50)),
            ]),
          ),
        ],
      ),
    ),
  );

  final Widget pinnedFloating = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: pinnedBox),
      SizedBox(width: 12.0),
      Expanded(child: floatingBox),
    ],
  );

  // ============================================================
  // SECTION 7: CROSS AXIS EXTENT VISUALIZATION
  // ============================================================
  print('=== Section 7: Cross axis extent ===');

  final Widget crossAxisRuler = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFC2185B).withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cross-axis extent live ruler',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'A LayoutBuilder gives us the exact width that a sliver delegate '
          'would observe via dims.crossAxisExtent.',
          style: TextStyle(
            color: Color(0xFF880E4F),
            fontSize: 13.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double w = constraints.maxWidth;
            final List<Widget> ticks = <Widget>[];
            for (int i = 0; i < 11; i++) {
              ticks.add(Expanded(
                child: Column(
                  children: [
                    Container(
                      height: i % 5 == 0 ? 14.0 : 8.0,
                      width: 2.0,
                      color: Color(0xFFC2185B),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      (w * i / 10.0).toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Color(0xFF880E4F),
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ));
            }
            return Column(
              children: [
                Container(
                  height: 22.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFE91E63),
                        Color(0xFFAD1457),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Text(
                      'crossAxisExtent ~ ${w.toStringAsFixed(1)} px',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.0),
                Row(children: ticks),
              ],
            );
          },
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: API SURFACE REFERENCE
  // ============================================================
  print('=== Section 8: API surface ===');

  final Widget apiSurface = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF455A64), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF455A64).withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Public API surface',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
        SizedBox(height: 10.0),
        _apiRow(
          'final double scrollOffset',
          'How far past the header the user has scrolled.',
          Icons.swap_vert,
          Color(0xFF00897B),
        ),
        _apiRow(
          'final double precedingScrollExtent',
          'Sum of scrollExtent of every sliver before this one.',
          Icons.linear_scale,
          Color(0xFFE65100),
        ),
        _apiRow(
          'final double viewportMainAxisExtent',
          'Live size of the viewport on the scrolling axis.',
          Icons.height,
          Color(0xFF6A1B9A),
        ),
        _apiRow(
          'final double crossAxisExtent',
          'Width perpendicular to the scrolling axis.',
          Icons.aspect_ratio,
          Color(0xFFC2185B),
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Consumed by the new delegate signature:\n'
          'abstract class SliverPersistentHeaderDelegate {\n'
          '  Widget build(BuildContext c,\n'
          '               double shrinkOffset,\n'
          '               bool overlapsContent);\n'
          '  double get minExtent;\n'
          '  double get maxExtent;\n'
          '  bool shouldRebuild(\n'
          '      covariant SliverPersistentHeaderDelegate old);\n'
          '}',
          Color(0xFF455A64),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: PITFALLS
  // ============================================================
  print('=== Section 9: Pitfalls ===');

  final Widget pitfalls = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFC62828), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFC62828).withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Color(0xFFB71C1C), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls and debugging',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallRow(
          'Forgot to override shouldRebuild()',
          'Defaulting to always-true rebuilds works but wastes CPU. '
              'Compare previous fields and return false when unchanged.',
        ),
        _pitfallRow(
          'minExtent > maxExtent',
          'Fails an assertion in debug builds. Always keep min <= max.',
        ),
        _pitfallRow(
          'Reading shrinkOffset above range',
          'shrinkOffset is clamped to (maxExtent - minExtent). Anything '
              'above that is the responsibility of the delegate to ignore.',
        ),
        _pitfallRow(
          'Mixing pinned + floating without sliverappbar',
          'For combined behavior use SliverAppBar.pinned: true, '
              'floating: true. A custom delegate cannot do both at once.',
        ),
        _pitfallRow(
          'Heavy work inside build()',
          'build() runs every layout pass. Cache derived values in '
              'fields of the delegate constructor instead.',
        ),
        _pitfallRow(
          'Forgetting overlapsContent',
          'When true, your header is being painted on top of underlying '
              'sliver content - adjust shadows or backgrounds accordingly.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: SEE ALSO
  // ============================================================
  print('=== Section 10: See also ===');

  final Widget seeAlso = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1565C0).withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book_outlined,
                color: Color(0xFF0D47A1), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'See also',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _seeAlsoRow(
            Icons.layers, 'SliverConstraints', 'low-level layout protocol'),
        _seeAlsoRow(Icons.view_agenda, 'SliverPersistentHeader',
            'widget that uses the delegate'),
        _seeAlsoRow(Icons.person_pin_circle_outlined,
            'SliverPersistentHeaderDelegate', 'subclass to customize'),
        _seeAlsoRow(Icons.dashboard_customize_outlined, 'SliverAppBar',
            'high-level flexible header'),
        _seeAlsoRow(Icons.swap_vert, 'CustomScrollView',
            'composes any sliver into a scrollable area'),
        _seeAlsoRow(Icons.straighten, 'RenderViewport',
            'where dimensions are computed'),
      ],
    ),
  );

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFFAFAFA),
    appBar: AppBar(
      title: Text('SliverLayoutDimensions Deep Demo'),
      backgroundColor: Color(0xFF1A237E),
      foregroundColor: Colors.white,
      elevation: 4.0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          hero,
          _sectionTitle('1. The four fields up close',
              Icons.list_alt_outlined, Color(0xFF1A237E)),
          fieldGrid,
          _sectionTitle('2. Live persistent header', Icons.bolt,
              Color(0xFF6A1B9A)),
          liveDemo,
          _sectionTitle('3. Lifecycle of a layout pass', Icons.timeline,
              Color(0xFF00838F)),
          lifecycle,
          _sectionTitle('4. SliverLayoutDimensions vs SliverConstraints',
              Icons.compare_arrows, Color(0xFF455A64)),
          comparison,
          _sectionTitle(
              '5. Pinned vs floating', Icons.compare, Color(0xFFEF6C00)),
          pinnedFloating,
          _sectionTitle('6. Cross-axis extent visualised',
              Icons.straighten, Color(0xFFC2185B)),
          crossAxisRuler,
          _sectionTitle(
              '7. API surface reference', Icons.code, Color(0xFF263238)),
          apiSurface,
          _sectionTitle('8. Pitfalls and debugging',
              Icons.warning_amber_rounded, Color(0xFFB71C1C)),
          pitfalls,
          _sectionTitle('9. See also', Icons.link, Color(0xFF0D47A1)),
          seeAlso,
          SizedBox(height: 32.0),
          Center(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 22.0, vertical: 14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                ),
                borderRadius: BorderRadius.circular(28.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF1A237E).withValues(alpha: 0.4),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.white),
                  SizedBox(width: 8.0),
                  Text(
                    'End of SliverLayoutDimensions deep demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPERS — used across sections.
// ============================================================
Widget _heroChip(IconData icon, String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 16.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _fieldCard({
  required String title,
  required String subtitle,
  required Color color,
  required IconData icon,
  required String example,
  required String diagram,
  required String narrative,
}) {
  return Container(
    width: 340.0,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: color, size: 24.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: color.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Example: $example',
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: color,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            diagram,
            style: TextStyle(
              fontSize: 10.5,
              fontFamily: 'monospace',
              color: Color(0xFFB2DFDB),
              height: 1.3,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          narrative,
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _scrollItem(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.drag_indicator, color: Colors.white, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleStep(
    String title, String body, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(fontSize: 12.0, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Center(
      child: Icon(
        Icons.arrow_downward,
        color: Color(0xFF00838F),
        size: 22.0,
      ),
    ),
  );
}

Widget _compareHeader(String label, Color color) {
  return Text(
    label,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: color,
      fontSize: 12.0,
    ),
  );
}

Widget _compareRow(String field, bool inDims, bool inConstraints) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            field,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          child: Icon(
            inDims ? Icons.check_circle : Icons.cancel,
            color: inDims ? Color(0xFF1565C0) : Color(0xFFBDBDBD),
            size: 18.0,
          ),
        ),
        Expanded(
          child: Icon(
            inConstraints ? Icons.check_circle : Icons.cancel,
            color: inConstraints ? Color(0xFFAD1457) : Color(0xFFBDBDBD),
            size: 18.0,
          ),
        ),
      ],
    ),
  );
}

Widget _apiRow(String signature, String body, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                signature,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(fontSize: 12.0, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallRow(String title, String body) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: Color(0xFFB71C1C), width: 3.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.error_outline,
                color: Color(0xFFB71C1C), size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFFB71C1C),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(body, style: TextStyle(fontSize: 12.0, height: 1.35)),
      ],
    ),
  );
}

Widget _seeAlsoRow(IconData icon, String name, String desc) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF0D47A1), size: 20.0),
        SizedBox(width: 10.0),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
            fontSize: 13.0,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            '- $desc',
            style: TextStyle(fontSize: 12.5),
          ),
        ),
      ],
    ),
  );
}
