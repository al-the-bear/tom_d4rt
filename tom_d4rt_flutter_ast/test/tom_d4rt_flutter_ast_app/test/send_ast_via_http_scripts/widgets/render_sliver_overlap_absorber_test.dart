// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for RenderSliverOverlapAbsorber
// Theme: indigo / cyan "scroll mechanics"
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverOverlapAbsorber Deep Demo executing');

  // ============================================================
  // Palette
  // ============================================================
  final Color indigo = Color(0xFF3F51B5);
  final Color indigoDark = Color(0xFF1A237E);
  final Color cyan = Color(0xFF00ACC1);
  final Color cyanDark = Color(0xFF006064);
  final Color amber = Color(0xFFFFB300);
  final Color rose = Color(0xFFE91E63);
  final Color slate = Color(0xFF455A64);
  final Color mint = Color(0xFF26A69A);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');
  final Widget titleBanner = Container(
    width: double.infinity,
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [indigoDark, indigo, cyan],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: cyan.withValues(alpha: 0.25),
          blurRadius: 40.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers_outlined, color: Colors.white, size: 36.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'RenderSliverOverlapAbsorber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Absorbs sliver overlap from a pinned/floating header so an inner '
          'CustomScrollView can offset its content correctly.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 13.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: Text(
                'package:flutter/rendering.dart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: Text(
                'extends RenderSliver',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');
  Widget diagramBlock(String label, String sub, Color color, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.28),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.4),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: color,
                  ),
                ),
                Text(
                  sub,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: slate,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigo.withValues(alpha: 0.3), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SECTION 2  -  Anatomy',
          style: TextStyle(
            color: indigo,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'NestedScrollView wires an outer CustomScrollView to an inner one '
          'using a SliverOverlapAbsorberHandle.',
          style: TextStyle(fontSize: 12.0, color: slate, height: 1.4),
        ),
        SizedBox(height: 12.0),
        diagramBlock(
          'OUTER  CustomScrollView',
          'headerSliverBuilder()',
          indigo,
          Icons.menu_open,
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.subdirectory_arrow_right, color: indigo, size: 20.0),
              diagramBlock(
                'SliverAppBar (pinned)',
                'flexibleSpace, expandedHeight',
                cyan,
                Icons.view_headline,
              ),
              diagramBlock(
                'SliverOverlapAbsorber',
                'handle: handle  (records overlap)',
                rose,
                Icons.compress,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        diagramBlock(
          'INNER  CustomScrollView',
          'body: TabBarView -> CustomScrollView',
          indigoDark,
          Icons.view_list,
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.subdirectory_arrow_right,
                  color: indigoDark, size: 20.0),
              diagramBlock(
                'SliverOverlapInjector',
                'handle: handle  (re-inserts overlap)',
                mint,
                Icons.expand,
              ),
              diagramBlock(
                'SliverList / SliverGrid',
                'actual content slivers',
                slate,
                Icons.list_alt,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Handle pipeline
  // ============================================================
  print('=== Section 3: Handle Pipeline ===');
  Widget pipelineCard(String title, String body, Color color, IconData icon) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 26.0),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              body,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.95),
                fontSize: 11.0,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget pipeline = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          indigo.withValues(alpha: 0.06),
          cyan.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyan.withValues(alpha: 0.3), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: cyan.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SECTION 3  -  Handle pipeline',
          style: TextStyle(
            color: cyanDark,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 12.0),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #125, P1):
        // The pipeline Row uses CrossAxisAlignment.stretch so the three
        // pipelineCard tiles end up with matching heights. It lives inside
        // a page-root `SingleChildScrollView > Column(stretch)` chain
        // (line 1167) which propagates unbounded vertical constraints; a
        // bare `Row(stretch)` then demands a tight height which would be
        // infinite, firing "BoxConstraints forces an infinite height".
        // `IntrinsicHeight` resolves the cross-axis height to the tallest
        // child's intrinsic height before the stretch rule fires, while
        // preserving the height-matched visual.
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              pipelineCard(
                '1. ABSORB',
              'SliverOverlapAbsorber wraps the header, computes its overlap, '
                  'writes layoutExtent + scrollExtent into the handle.',
              rose,
              Icons.compress,
            ),
            Icon(Icons.east, color: slate, size: 20.0),
            pipelineCard(
              '2. HANDLE',
              'SliverOverlapAbsorberHandle is a Listenable shared between '
                  'the outer absorber and the inner injector.',
              indigo,
              Icons.swap_horiz,
            ),
            Icon(Icons.east, color: slate, size: 20.0),
            pipelineCard(
              '3. INJECT',
              'SliverOverlapInjector reads the handle and inserts that same '
                  'extent at the top of the inner scroll view.',
              mint,
              Icons.expand,
            ),
          ],
        ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Handle field reference
  // ============================================================
  print('=== Section 4: Handle Fields ===');
  final List<List<String>> handleFields = <List<String>>[
    <String>[
      'layoutExtent',
      'double',
      'Extent the absorber removed from layout '
          '(painted height at this scroll offset).',
    ],
    <String>[
      'scrollExtent',
      'double',
      'Extent the absorber removed from scrollable area '
          '(scroll-time accounting).',
    ],
    <String>[
      'addListener',
      'method',
      'Listenable hook - inner injector re-layouts when this fires.',
    ],
    <String>[
      'removeListener',
      'method',
      'Symmetric cleanup; managed automatically by the widget pair.',
    ],
    <String>[
      'notifyListeners',
      'method',
      'Called from RenderSliverOverlapAbsorber.performLayout when extents '
          'change.',
    ],
    <String>[
      'debugLabel',
      'String?',
      'Optional label shown by toString - useful for debugPrint.',
    ],
  ];

  Widget fieldRow(List<String> data, int index) {
    final Color base = index.isEven ? indigo : cyan;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            base.withValues(alpha: 0.06),
            base.withValues(alpha: 0.16),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: base.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.0,
            child: Text(
              data[0],
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: base,
              ),
            ),
          ),
          SizedBox(
            width: 60.0,
            child: Text(
              data[1],
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: slate,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Expanded(
            child: Text(
              data[2],
              style: TextStyle(fontSize: 11.0, color: slate, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> fieldChildren = <Widget>[];
  for (int i = 0; i < handleFields.length; i++) {
    fieldChildren.add(fieldRow(handleFields[i], i));
  }

  final Widget handleFieldsCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyan.withValues(alpha: 0.4), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SECTION 4  -  SliverOverlapAbsorberHandle',
          style: TextStyle(
            color: indigoDark,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 10.0),
        Column(children: fieldChildren),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Real NestedScrollView mock
  // ============================================================
  print('=== Section 5: Live NestedScrollView ===');
  final List<String> tabLabels = <String>['Logs', 'Metrics', 'Traces'];

  final Widget livePreview = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigo.withValues(alpha: 0.4), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.22),
          blurRadius: 18.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: cyan.withValues(alpha: 0.18),
          blurRadius: 26.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: SizedBox(
        height: 360.0,
        child: DefaultTabController(
          length: tabLabels.length,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    pinned: true,
                    expandedHeight: 140.0,
                    backgroundColor: indigoDark,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        'Scroll Mechanics',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [indigoDark, indigo, cyan],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      indicatorColor: amber,
                      labelColor: Colors.white,
                      unselectedLabelColor:
                          Colors.white.withValues(alpha: 0.65),
                      tabs: <Widget>[
                        Tab(text: tabLabels[0], icon: Icon(Icons.notes)),
                        Tab(text: tabLabels[1], icon: Icon(Icons.bar_chart)),
                        Tab(text: tabLabels[2], icon: Icon(Icons.timeline)),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                _buildInnerScrollView(context, indigo, 'log'),
                _buildInnerScrollView(context, cyan, 'metric'),
                _buildInnerScrollView(context, mint, 'trace'),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 6: Without absorber
  // ============================================================
  print('=== Section 6: Without absorber ===');
  Widget asciiBox(String s, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      ),
      child: Text(
        s,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          color: color,
          height: 1.55,
        ),
      ),
    );
  }

  final Widget withoutAbsorber = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          rose.withValues(alpha: 0.07),
          rose.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: rose.withValues(alpha: 0.5), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: rose.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.error_outline, color: rose, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'SECTION 6  -  Without absorber (broken)',
              style: TextStyle(
                color: rose,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Inner CustomScrollView starts at offset 0 - the pinned header '
          'visually overlaps the first items.',
          style: TextStyle(fontSize: 12.0, color: slate, height: 1.4),
        ),
        SizedBox(height: 10.0),
        asciiBox(
          '+----- outer viewport -----+\n'
          '| ##### SliverAppBar ##### |  <- pinned, height = H\n'
          '| ##### TabBar         ### |\n'
          '+--------------------------+\n'
          '|  Item 0  (HIDDEN)        |  <- overlapped!\n'
          '|  Item 1  (PARTIAL)       |\n'
          '|  Item 2  visible         |\n'
          '|  Item 3  visible         |\n'
          '+--------------------------+',
          rose,
        ),
        SizedBox(height: 8.0),
        Text(
          'Symptoms: tap targets clipped, leading items unreachable, '
          'inner scrollbar wrong length.',
          style: TextStyle(
            fontSize: 11.0,
            color: rose,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: With absorber
  // ============================================================
  print('=== Section 7: With absorber ===');
  final Widget withAbsorber = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          mint.withValues(alpha: 0.08),
          cyan.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: mint.withValues(alpha: 0.55), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: mint.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle_outline, color: mint, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'SECTION 7  -  With absorber (correct)',
              style: TextStyle(
                color: cyanDark,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Absorber removes layoutExtent of the header. Injector re-inserts '
          'an empty sliver of the same size at the top of the inner list.',
          style: TextStyle(fontSize: 12.0, color: slate, height: 1.4),
        ),
        SizedBox(height: 10.0),
        asciiBox(
          '+----- outer viewport -----+\n'
          '| ##### SliverAppBar ##### |  <- pinned, height = H\n'
          '| ##### TabBar         ### |\n'
          '+--------------------------+\n'
          '|  [SliverOverlapInjector] |  <- size = H (transparent)\n'
          '|  Item 0  visible         |  <- starts AFTER header\n'
          '|  Item 1  visible         |\n'
          '|  Item 2  visible         |\n'
          '|  Item 3  visible         |\n'
          '+--------------------------+',
          cyanDark,
        ),
        SizedBox(height: 8.0),
        Text(
          'Result: scrollOffset is in sync, inner scrollbar correct, '
          'every item is reachable.',
          style: TextStyle(
            fontSize: 11.0,
            color: cyanDark,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Use cases
  // ============================================================
  print('=== Section 8: Use Cases ===');
  final List<List<String>> useCases = <List<String>>[
    <String>[
      'Tabbed scaffold',
      'SliverAppBar (pinned) + TabBar bottom + TabBarView of '
          'CustomScrollViews. Each tab needs its own injector.',
      '0xFF3F51B5',
    ],
    <String>[
      'Stretchy masthead',
      'expandedHeight + FlexibleSpaceBar.background. Absorber keeps overlap '
          'math correct while the header parallaxes.',
      '0xFF00ACC1',
    ],
    <String>[
      'Floating filter bar',
      'pinned: false, floating: true, snap: true. Overlap shrinks to 0 '
          'when scrolled away - injector tracks live.',
      '0xFFE91E63',
    ],
    <String>[
      'Profile screen',
      'Hero header + tab list of feeds (Posts / Replies / Likes). The '
          'classic NestedScrollView pattern.',
      '0xFFFFB300',
    ],
    <String>[
      'Custom NestedScrollView',
      'Build your own outer scroll without NestedScrollView; you create '
          'and own the SliverOverlapAbsorberHandle yourself.',
      '0xFF26A69A',
    ],
  ];

  Widget useCaseCard(List<String> uc) {
    final Color color = Color(int.parse(uc[2]));
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.22),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.0,
            height: 50.0,
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
                  uc[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: color,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  uc[1],
                  style: TextStyle(
                    fontSize: 11.5,
                    color: slate,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> useCaseChildren = <Widget>[];
  for (int i = 0; i < useCases.length; i++) {
    useCaseChildren.add(useCaseCard(useCases[i]));
  }

  final Widget useCasesCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigo.withValues(alpha: 0.3), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SECTION 8  -  Use cases',
          style: TextStyle(
            color: indigoDark,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 10.0),
        Column(children: useCaseChildren),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');
  final List<List<String>> footguns = <List<String>>[
    <String>[
      'Different handles',
      'Passing one handle to the absorber and another to the injector. '
          'The injector inserts 0 - inner content overlaps the header.',
    ],
    <String>[
      'Multiple absorbers, one handle',
      'A handle records ONE extent. Two absorbers writing to the same '
          'handle race; only the last layout wins.',
    ],
    <String>[
      'Forgot SliverOverlapInjector',
      'Inner CustomScrollView starts at top of viewport, ignoring the '
          'absorbed extent - first items are eaten by the SliverAppBar.',
    ],
    <String>[
      'Using Container as inner body',
      'NestedScrollView body must be a Scrollable that consumes the '
          'inner CustomScrollView pattern, otherwise the handle has no '
          'consumer.',
    ],
    <String>[
      'Hand-built handle without disposal',
      'Custom NestedScrollView - if you create the handle yourself, '
          'remember it is a ChangeNotifier; share its lifetime with the '
          'widget pair.',
    ],
    <String>[
      'Wrong sliver under the absorber',
      'SliverOverlapAbsorber should wrap the actual overlapping sliver '
          '(typically a SliverAppBar). Wrapping a SliverList does nothing '
          'useful.',
    ],
  ];

  Widget footgunCard(List<String> data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            amber.withValues(alpha: 0.12),
            rose.withValues(alpha: 0.18),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: rose.withValues(alpha: 0.5), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: rose, size: 22.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    color: rose,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  data[1],
                  style: TextStyle(
                    fontSize: 11.0,
                    color: slate,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> footgunChildren = <Widget>[];
  for (int i = 0; i < footguns.length; i++) {
    footgunChildren.add(footgunCard(footguns[i]));
  }

  final Widget footgunsCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: rose.withValues(alpha: 0.4), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: rose.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SECTION 9  -  Footguns',
          style: TextStyle(
            color: rose,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 10.0),
        Column(children: footgunChildren),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Recap
  // ============================================================
  print('=== Section 10: Recap ===');
  Widget recapBullet(IconData icon, String s, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              s,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget recap = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cyanDark, indigo, indigoDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: indigoDark.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: cyan.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'SECTION 10  -  Recap',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        recapBullet(
          Icons.layers,
          'RenderSliverOverlapAbsorber removes header overlap from the outer '
          'layout; SliverOverlapInjector re-applies it on the inner side.',
          cyan,
        ),
        recapBullet(
          Icons.link,
          'They communicate via a SliverOverlapAbsorberHandle - one shared '
          'instance per outer/inner pair.',
          mint,
        ),
        recapBullet(
          Icons.dashboard,
          'NestedScrollView wires this for you; '
          'NestedScrollView.sliverOverlapAbsorberHandleFor(context) returns '
          'the active handle.',
          amber,
        ),
        recapBullet(
          Icons.bug_report,
          'Most bugs are: missing injector, wrong handle, or wrapping the '
          'wrong sliver.',
          rose,
        ),
        recapBullet(
          Icons.check_circle,
          'Use it whenever a pinned/floating sliver header sits above a '
          'CustomScrollView body inside another CustomScrollView.',
          Colors.white,
        ),
      ],
    ),
  );

  // ============================================================
  // Assemble
  // ============================================================
  print('RenderSliverOverlapAbsorber Deep Demo built');
  return Scaffold(
    backgroundColor: Color(0xFFF3F4F8),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleBanner,
          anatomy,
          pipeline,
          handleFieldsCard,
          livePreview,
          withoutAbsorber,
          withAbsorber,
          useCasesCard,
          footgunsCard,
          recap,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

Widget _buildInnerScrollView(BuildContext context, Color color, String label) {
  return Builder(
    builder: (BuildContext context) {
      return CustomScrollView(
        key: PageStorageKey<String>(label),
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withValues(alpha: 0.10),
                          color.withValues(alpha: 0.25),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: color.withValues(alpha: 0.55),
                        width: 1.0,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: color.withValues(alpha: 0.18),
                          blurRadius: 6.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 32.0,
                          height: 32.0,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$index',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            '$label entry #$index '
                            '- absorber keeps offset accurate',
                            style: TextStyle(
                              color: Color(0xFF263238),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 18,
              ),
            ),
          ),
        ],
      );
    },
  );
}
