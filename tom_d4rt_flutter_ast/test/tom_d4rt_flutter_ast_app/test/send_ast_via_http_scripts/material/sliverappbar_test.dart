// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverAppBar, FlexibleSpaceBar, CollapseMode from material
// Deep Demo: Visual demonstration of every meaningful SliverAppBar parameter
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverAppBar Deep Demo executing');

  // ============================================================
  // SECTION 1: SliverAppBar Concept Overview
  // ============================================================
  print('=== Section 1: SliverAppBar Concept Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: What is SliverAppBar
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.view_headline, size: 44.0, color: Colors.indigo),
          SizedBox(height: 10.0),
          Text(
            'SliverAppBar',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'A material AppBar that can\nintegrate with a CustomScrollView',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: Scroll behaviors
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.green.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.swap_vert, size: 44.0, color: Colors.teal),
          SizedBox(height: 10.0),
          Text(
            'Scroll Behaviors',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'pinned · floating · snap\nstretch · forceElevated',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.teal.shade700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ),
  );

  // Concept 3: Composition slots
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade50, Colors.purple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.dashboard_customize, size: 44.0, color: Colors.deepPurple),
          SizedBox(height: 10.0),
          Text(
            'Slots',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'leading · title · actions\nflexibleSpace · bottom',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.deepPurple.shade700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: pinned / floating / snap matrix
  // ============================================================
  print('=== Section 2: pinned / floating / snap matrix ===');

  // Card 2a: pinned + floating (rarely used together but valid)
  final pinnedFloatingDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('pinned + floating'),
          pinned: true,
          floating: true,
          expandedHeight: 120.0,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade700, Colors.blueGrey.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(
              leading: Icon(Icons.push_pin, color: Colors.indigo),
              title: Text('Bar stays visible (pinned)'),
            ),
            ListTile(
              leading: Icon(Icons.swap_vert, color: Colors.indigo),
              title: Text('Appears on scroll-up (floating)'),
            ),
            ListTile(title: Text('Item 3')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  // Card 2b: pinned only
  final pinnedOnlyDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('pinned only'),
          pinned: true,
          expandedHeight: 130.0,
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade600, Colors.cyan.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.push_pin,
                  size: 56.0,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('Collapses to a fixed bar')),
            ListTile(title: Text('Always visible on scroll')),
            ListTile(title: Text('Item 3')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  // Card 2c: floating + snap
  final floatingSnapDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('floating + snap'),
          floating: true,
          snap: true,
          expandedHeight: 120.0,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange, Colors.amber],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.flash_on,
                  size: 56.0,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('Snaps to full extent')),
            ListTile(title: Text('Triggered by scroll-up')),
            ListTile(title: Text('Item 3')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  // Card 2d: none (default scroll-off behavior)
  final defaultScrollDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('default (no flags)'),
          expandedHeight: 130.0,
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey.shade700, Colors.blueGrey.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('Scrolls off the top')),
            ListTile(title: Text('Returns only at top')),
            ListTile(title: Text('Item 3')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  print('Created 4 scroll-behavior matrix cards');

  // ============================================================
  // SECTION 3: expandedHeight + FlexibleSpaceBar gallery
  // ============================================================
  print('=== Section 3: expandedHeight + FlexibleSpaceBar gallery ===');

  // Gradient 1: sunset
  final flexSunsetDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 200.0,
          collapsedHeight: 60.0,
          toolbarHeight: 56.0,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Sunset',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            collapseMode: CollapseMode.parallax,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepOrange.shade700,
                    Colors.orange.shade400,
                    Colors.amber.shade300,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.wb_sunny,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 80.0,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('expandedHeight: 200')),
            ListTile(title: Text('collapsedHeight: 60')),
            ListTile(title: Text('parallax collapse')),
            ListTile(title: Text('centerTitle: true')),
            ListTile(title: Text('Row 5')),
            ListTile(title: Text('Row 6')),
          ]),
        ),
      ],
    ),
  );

  // Gradient 2: ocean
  final flexOceanDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 220.0,
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Ocean',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            collapseMode: CollapseMode.parallax,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo.shade900,
                    Colors.blue.shade600,
                    Colors.cyan.shade300,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.waves,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 80.0,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('Linear vertical gradient')),
            ListTile(title: Text('Waves background')),
            ListTile(title: Text('expandedHeight: 220')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  // Gradient 3: forest
  final flexForestDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 210.0,
          backgroundColor: Colors.green.shade800,
          foregroundColor: Colors.white,
          titleSpacing: 16.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Forest',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            titlePadding: EdgeInsets.only(left: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.parallax,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade900,
                    Colors.green.shade500,
                    Colors.lightGreen.shade200,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.park,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 80.0,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('titleSpacing: 16')),
            ListTile(title: Text('titlePadding bottom: 14')),
            ListTile(title: Text('Item 3')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  print('Created 3 FlexibleSpaceBar gallery cards');

  // ============================================================
  // SECTION 4: SliverAppBar.medium / SliverAppBar.large
  // ============================================================
  print('=== Section 4: SliverAppBar.medium / SliverAppBar.large ===');

  final mediumDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar.medium(
          title: Text('Medium AppBar'),
          backgroundColor: Colors.deepPurple.shade50,
          foregroundColor: Colors.deepPurple.shade900,
          leading: Icon(Icons.menu, color: Colors.deepPurple),
          actions: <Widget>[
            Icon(Icons.search, color: Colors.deepPurple),
            SizedBox(width: 12.0),
            Icon(Icons.more_vert, color: Colors.deepPurple),
            SizedBox(width: 8.0),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('SliverAppBar.medium')),
            ListTile(title: Text('Two-line collapsing header')),
            ListTile(title: Text('Material 3 spec')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  final largeDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar.large(
          title: Text('Large AppBar'),
          backgroundColor: Colors.pink.shade50,
          foregroundColor: Colors.pink.shade900,
          leading: Icon(Icons.menu, color: Colors.pink),
          actions: <Widget>[
            Icon(Icons.favorite, color: Colors.pink),
            SizedBox(width: 12.0),
            Icon(Icons.share, color: Colors.pink),
            SizedBox(width: 8.0),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('SliverAppBar.large')),
            ListTile(title: Text('Bigger collapsing header')),
            ListTile(title: Text('Big title style')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  print('Created medium and large constructor cards');

  // ============================================================
  // SECTION 5: stretch + CollapseMode variants
  // ============================================================
  print('=== Section 5: stretch + CollapseMode variants ===');

  var stretchTriggerCount = 0;
  Future<void> onStretchTriggered() async {
    stretchTriggerCount++;
    print('Stretch trigger fired ($stretchTriggerCount)');
  }

  final stretchDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('stretch'),
          pinned: true,
          stretch: true,
          stretchTriggerOffset: 80.0,
          onStretchTrigger: onStretchTriggered,
          expandedHeight: 200.0,
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
            title: Text(
              'Stretch on overscroll',
              style: TextStyle(color: Colors.white),
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade800, Colors.pinkAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.zoom_out_map,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 70.0,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('stretch: true')),
            ListTile(title: Text('stretchTriggerOffset: 80')),
            ListTile(title: Text('zoom + blur + fadeTitle modes')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  final collapseParallaxDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('CollapseMode.parallax'),
          pinned: true,
          expandedHeight: 200.0,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            title: Text('Parallax', style: TextStyle(color: Colors.white)),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.landscape,
                  size: 70.0,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('Background scrolls slower')),
            ListTile(title: Text('Creates depth effect')),
            ListTile(title: Text('Item 3')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  final collapsePinDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('CollapseMode.pin'),
          pinned: true,
          expandedHeight: 200.0,
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            title: Text('Pinned bg', style: TextStyle(color: Colors.white)),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown.shade800, Colors.brown.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.terrain,
                  size: 70.0,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('Background stays still')),
            ListTile(title: Text('Foreground collapses')),
            ListTile(title: Text('Item 3')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  final collapseNoneDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('CollapseMode.none'),
          pinned: true,
          expandedHeight: 200.0,
          backgroundColor: Colors.grey.shade800,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            title: Text('No collapse', style: TextStyle(color: Colors.white)),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey.shade900, Colors.grey.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.layers,
                  size: 70.0,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('Background fixed in place')),
            ListTile(title: Text('Only the bar contracts')),
            ListTile(title: Text('Item 3')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  print('Created stretch + 3 collapseMode demo cards');

  // ============================================================
  // SECTION 6: Styled gallery
  // ============================================================
  print('=== Section 6: Styled gallery ===');

  final styledRoundedDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('rounded shape'),
          pinned: true,
          expandedHeight: 130.0,
          backgroundColor: Colors.pink.shade400,
          foregroundColor: Colors.white,
          elevation: 8.0,
          shadowColor: Colors.pink.shade900,
          surfaceTintColor: Colors.pinkAccent,
          scrolledUnderElevation: 12.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24.0),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade300, Colors.purple.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24.0),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('shape: rounded bottom')),
            ListTile(title: Text('elevation: 8')),
            ListTile(title: Text('shadowColor: pink900')),
            ListTile(title: Text('surfaceTintColor set')),
            ListTile(title: Text('scrolledUnderElevation: 12')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  final styledOutlinedDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('elevation 0'),
          pinned: true,
          expandedHeight: 120.0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0.0,
          shape: Border(
            bottom: BorderSide(color: Colors.grey.shade400, width: 1.0),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'Flat outlined bar',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('elevation: 0')),
            ListTile(title: Text('shadowColor: transparent')),
            ListTile(title: Text('shape: bottom border only')),
            ListTile(title: Text('Item 4')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  final styledForcedElevationDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('forceElevated'),
          pinned: true,
          forceElevated: true,
          expandedHeight: 120.0,
          backgroundColor: Colors.cyan.shade700,
          foregroundColor: Colors.white,
          elevation: 4.0,
          scrolledUnderElevation: 6.0,
          systemOverlayStyle: null,
          primary: true,
          automaticallyImplyLeading: false,
          excludeHeaderSemantics: false,
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(title: Text('forceElevated: true')),
            ListTile(title: Text('automaticallyImplyLeading: false')),
            ListTile(title: Text('excludeHeaderSemantics: false')),
            ListTile(title: Text('primary: true')),
            ListTile(title: Text('Item 5')),
            ListTile(title: Text('Item 6')),
          ]),
        ),
      ],
    ),
  );

  print('Created 3 styled gallery cards');

  // ============================================================
  // SECTION 7: Real-world profile-style header
  // ============================================================
  print('=== Section 7: Profile-style header ===');

  final profileDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 220.0,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              print('Profile back tapped');
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print('Edit profile tapped');
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                print('Settings tapped');
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            title: Text(
              'Alex Morgan',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade900,
                    Colors.deepPurple.shade400,
                    Colors.purpleAccent.shade100,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 36.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 44.0,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '@alex.morgan',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 36.0),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            ListTile(
              leading: Icon(Icons.email, color: Colors.deepPurple),
              title: Text('alex@example.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.deepPurple),
              title: Text('+1 555 0100'),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.deepPurple),
              title: Text('San Francisco, CA'),
            ),
            ListTile(
              leading: Icon(Icons.work, color: Colors.deepPurple),
              title: Text('Senior Engineer'),
            ),
            ListTile(
              leading: Icon(Icons.cake, color: Colors.deepPurple),
              title: Text('Birthday: 12 May'),
            ),
          ]),
        ),
      ],
    ),
  );

  print('Created profile-style header card');

  // ============================================================
  // SECTION 8: bottom: TabBar integration
  // ============================================================
  print('=== Section 8: bottom: TabBar integration ===');

  final tabBarDemo = SizedBox(
    height: 280.0,
    child: DefaultTabController(
      length: 3,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Tabs'),
            pinned: true,
            expandedHeight: 160.0,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.deepPurpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.amberAccent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.star), text: 'Starred'),
                Tab(icon: Icon(Icons.history), text: 'History'),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              ListTile(title: Text('bottom: TabBar')),
              ListTile(title: Text('Wrapped in DefaultTabController')),
              ListTile(title: Text('Stays under the title')),
              ListTile(title: Text('Item 4')),
              ListTile(title: Text('Item 5')),
              ListTile(title: Text('Item 6')),
            ]),
          ),
        ],
      ),
    ),
  );

  print('Created TabBar integration card');

  // ============================================================
  // SECTION 9: SliverFillRemaining showcase
  // ============================================================
  print('=== Section 9: SliverFillRemaining showcase ===');

  final fillRemainingDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('SliverFillRemaining'),
          pinned: true,
          expandedHeight: 110.0,
          backgroundColor: Colors.amber.shade800,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleSpacing: 0.0,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            color: Colors.amber.shade50,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.inbox, size: 56.0, color: Colors.amber.shade700),
                  SizedBox(height: 12.0),
                  Text(
                    'Empty state body',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'SliverFillRemaining fills the viewport',
                    style: TextStyle(color: Colors.amber.shade700),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  print('Created SliverFillRemaining showcase card');

  // ============================================================
  // SECTION 10: Code examples (dark panels)
  // ============================================================
  print('=== Section 10: Code examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Usage Patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Basic SliverAppBar in a CustomScrollView\n'
            'CustomScrollView(\n'
            '  slivers: [\n'
            '    SliverAppBar(\n'
            '      title: Text("Title"),\n'
            '      pinned: true,\n'
            '      floating: false,\n'
            '      expandedHeight: 200,\n'
            '      flexibleSpace: FlexibleSpaceBar(\n'
            '        title: Text("Flexible"),\n'
            '        background: Image.network(url, fit: BoxFit.cover),\n'
            '      ),\n'
            '    ),\n'
            '    SliverList(delegate: ...),\n'
            '  ],\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Material 3 named constructors\n'
            'SliverAppBar.medium(title: Text("Medium"));\n'
            'SliverAppBar.large(title: Text("Large"));\n'
            '\n'
            '// Stretch with overscroll callback\n'
            'SliverAppBar(\n'
            '  stretch: true,\n'
            '  stretchTriggerOffset: 100,\n'
            '  onStretchTrigger: () async { /* refresh */ },\n'
            '  flexibleSpace: FlexibleSpaceBar(\n'
            '    stretchModes: [\n'
            '      StretchMode.zoomBackground,\n'
            '      StretchMode.blurBackground,\n'
            '      StretchMode.fadeTitle,\n'
            '    ],\n'
            '  ),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// CollapseMode controls background motion\n'
            'FlexibleSpaceBar(collapseMode: CollapseMode.parallax);\n'
            'FlexibleSpaceBar(collapseMode: CollapseMode.pin);\n'
            'FlexibleSpaceBar(collapseMode: CollapseMode.none);\n'
            '\n'
            '// TabBar in the bottom slot\n'
            'SliverAppBar(\n'
            '  bottom: TabBar(tabs: [...]),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amber.shade200,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code examples panel');

  // ============================================================
  // SECTION 11: Summary takeaways
  // ============================================================
  print('=== Section 11: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: <Widget>[
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.view_headline,
          'Sliver-aware AppBar',
          'Use inside CustomScrollView, not Scaffold.appBar',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.push_pin,
          'pinned / floating / snap',
          'Three flags control scroll-time visibility',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.zoom_out_map,
          'stretch + onStretchTrigger',
          'Overscroll grows the bar and can fire a callback',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.layers,
          'FlexibleSpaceBar',
          'Provides title + background + CollapseMode',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.style,
          'Material 3 sizes',
          'SliverAppBar.medium and SliverAppBar.large',
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.tab,
          'bottom: PreferredSize',
          'Slot for TabBar or any preferred-size header',
          Colors.deepOrange,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('SliverAppBar Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.indigo, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: <Widget>[
              Icon(Icons.view_headline, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'SliverAppBar',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Scroll-aware Material App Bar',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1: Concept overview
        Text(
          '1. Concept Overview',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 32.0),

        // Section 2: Scroll behavior matrix
        Text(
          '2. pinned / floating / snap matrix',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Text(
          'pinned + floating',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.0),
        pinnedFloatingDemo,
        SizedBox(height: 12.0),
        Text('pinned only', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 6.0),
        pinnedOnlyDemo,
        SizedBox(height: 12.0),
        Text('floating + snap', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 6.0),
        floatingSnapDemo,
        SizedBox(height: 12.0),
        Text(
          'default (no flags)',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.0),
        defaultScrollDemo,
        SizedBox(height: 32.0),

        // Section 3: FlexibleSpaceBar gradient gallery
        Text(
          '3. expandedHeight + FlexibleSpaceBar Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Text('Sunset', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 6.0),
        flexSunsetDemo,
        SizedBox(height: 12.0),
        Text('Ocean', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 6.0),
        flexOceanDemo,
        SizedBox(height: 12.0),
        Text('Forest', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 6.0),
        flexForestDemo,
        SizedBox(height: 32.0),

        // Section 4: Medium / Large constructors
        Text(
          '4. SliverAppBar.medium and SliverAppBar.large',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Text('Medium', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 6.0),
        mediumDemo,
        SizedBox(height: 12.0),
        Text('Large', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 6.0),
        largeDemo,
        SizedBox(height: 32.0),

        // Section 5: stretch + collapse modes
        Text(
          '5. stretch + CollapseMode Variants',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Text(
          'stretch + onStretchTrigger',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.0),
        stretchDemo,
        SizedBox(height: 12.0),
        Text(
          'CollapseMode.parallax',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.0),
        collapseParallaxDemo,
        SizedBox(height: 12.0),
        Text(
          'CollapseMode.pin',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.0),
        collapsePinDemo,
        SizedBox(height: 12.0),
        Text(
          'CollapseMode.none',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.0),
        collapseNoneDemo,
        SizedBox(height: 32.0),

        // Section 6: Styled gallery
        Text(
          '6. Styled Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Text(
          'Rounded shape + elevation',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.0),
        styledRoundedDemo,
        SizedBox(height: 12.0),
        Text(
          'Elevation 0 + outlined',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.0),
        styledOutlinedDemo,
        SizedBox(height: 12.0),
        Text(
          'forceElevated + primary',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.0),
        styledForcedElevationDemo,
        SizedBox(height: 32.0),

        // Section 7: Profile header
        Text(
          '7. Real-world Profile-Style Header',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        profileDemo,
        SizedBox(height: 32.0),

        // Section 8: TabBar integration
        Text(
          '8. bottom: TabBar Integration',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        tabBarDemo,
        SizedBox(height: 32.0),

        // Section 9: SliverFillRemaining
        Text(
          '9. SliverFillRemaining',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        fillRemainingDemo,
        SizedBox(height: 32.0),

        // Section 10: Code examples
        Text(
          '10. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeExamples,
        SizedBox(height: 32.0),

        // Section 11: Summary
        Text(
          '11. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// Helper: Build a summary takeaway row
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
