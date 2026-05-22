// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Scrollbar, RawScrollbar, CupertinoScrollbar
// Deep Demo: Visual demonstration of scrollbar variants and theming
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scrollbar Deep Demo executing');

  // ============================================================
  // SECTION 1: Understanding Scrollbar Family
  // ============================================================
  print('=== Section 1: Scrollbar Family Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: Material Scrollbar
  conceptCards.add(
    Container(
      width: 200.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.view_week, size: 44.0, color: Colors.blue),
          SizedBox(height: 10.0),
          Text(
            'Scrollbar',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Material-styled scrollbar\nwith hover/drag interactions',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.blue.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: RawScrollbar
  conceptCards.add(
    Container(
      width: 200.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.tune, size: 44.0, color: Colors.orange),
          SizedBox(height: 10.0),
          Text(
            'RawScrollbar',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Unstyled primitive — full\ncontrol over color & shape',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 3: CupertinoScrollbar
  conceptCards.add(
    Container(
      width: 200.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade100, Colors.blueGrey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blueGrey.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.phone_iphone, size: 44.0, color: Colors.blueGrey),
          SizedBox(height: 10.0),
          Text(
            'CupertinoScrollbar',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'iOS-styled thin pill that\nthickens while dragging',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.blueGrey.shade700),
          ),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Material Scrollbar Variants
  // ============================================================
  print('=== Section 2: Material Scrollbar Variants ===');

  Widget colorTile(int idx, Color color) {
    return Container(
      height: 56.0,
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.85), color.withValues(alpha: 0.55)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Text(
          'Row $idx',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }

  List<Widget> rainbowRows(int count) {
    final palette = [
      Colors.red,
      Colors.orange,
      Colors.amber,
      Colors.green,
      Colors.teal,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.pink,
      Colors.brown,
    ];
    final out = <Widget>[];
    for (int i = 0; i < count; i++) {
      out.add(colorTile(i + 1, palette[i % palette.length]));
    }
    return out;
  }

  // Variant 1: Default Scrollbar (hover-driven)
  final scrollDefault = Scrollbar(
    child: ListView(children: rainbowRows(20)),
  );
  print('Variant 1: default Scrollbar');

  // Variant 2: thumbVisibility=true
  final scrollThumbVisible = Scrollbar(
    thumbVisibility: true,
    child: ListView(children: rainbowRows(20)),
  );
  print('Variant 2: thumbVisibility=true');

  // Variant 3: trackVisibility + thumbVisibility
  final scrollTrackVisible = Scrollbar(
    thumbVisibility: true,
    trackVisibility: true,
    child: ListView(children: rainbowRows(20)),
  );
  print('Variant 3: trackVisibility=true');

  // Variant 4: thick scrollbar with rounded radius
  final scrollThickRadius = Scrollbar(
    thumbVisibility: true,
    thickness: 14.0,
    radius: Radius.circular(8.0),
    child: ListView(children: rainbowRows(20)),
  );
  print('Variant 4: thickness=14, radius=8');

  // Variant 5: orientation=left
  final scrollLeft = Scrollbar(
    thumbVisibility: true,
    scrollbarOrientation: ScrollbarOrientation.left,
    child: ListView(children: rainbowRows(20)),
  );
  print('Variant 5: scrollbarOrientation=left');

  // Variant 6: interactive=false (display-only)
  final scrollNonInteractive = Scrollbar(
    thumbVisibility: true,
    interactive: false,
    child: ListView(children: rainbowRows(20)),
  );
  print('Variant 6: interactive=false');

  final materialVariants = <Map<String, dynamic>>[
    {
      'label': 'Default',
      'desc': 'Appears on scroll, fades out',
      'widget': scrollDefault,
      'color': Colors.blue,
    },
    {
      'label': 'thumbVisibility',
      'desc': 'Always shows the thumb',
      'widget': scrollThumbVisible,
      'color': Colors.green,
    },
    {
      'label': 'trackVisibility',
      'desc': 'Track and thumb both painted',
      'widget': scrollTrackVisible,
      'color': Colors.indigo,
    },
    {
      'label': 'thickness + radius',
      'desc': 'thickness=14, radius=8',
      'widget': scrollThickRadius,
      'color': Colors.purple,
    },
    {
      'label': 'left orientation',
      'desc': 'Bar painted on left edge',
      'widget': scrollLeft,
      'color': Colors.teal,
    },
    {
      'label': 'interactive=false',
      'desc': 'Pointer events ignored',
      'widget': scrollNonInteractive,
      'color': Colors.orange,
    },
  ];

  final materialVariantPanels = <Widget>[];
  for (final v in materialVariants) {
    final color = v['color'] as Color;
    materialVariantPanels.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    v['label'] as String,
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
                    v['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: color.withValues(alpha: 0.9),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
              child: SizedBox(height: 200.0, child: v['widget'] as Widget),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${materialVariantPanels.length} material variant panels');

  // ============================================================
  // SECTION 3: RawScrollbar and CupertinoScrollbar
  // ============================================================
  print('=== Section 3: Raw and Cupertino Scrollbars ===');

  // Custom-colored RawScrollbar (full control)
  final rawCustom = RawScrollbar(
    thumbVisibility: true,
    thumbColor: Colors.pink.shade400,
    thickness: 10.0,
    radius: Radius.circular(5.0),
    child: ListView(children: rainbowRows(20)),
  );
  print('Raw scrollbar with pink thumb');

  // RawScrollbar with track painted
  final rawTrack = RawScrollbar(
    thumbVisibility: true,
    trackVisibility: true,
    thumbColor: Colors.deepPurple,
    trackColor: Colors.deepPurple.shade100,
    trackBorderColor: Colors.deepPurple.shade300,
    thickness: 12.0,
    radius: Radius.circular(2.0),
    child: ListView(children: rainbowRows(20)),
  );
  print('Raw scrollbar with track painted');

  // Cupertino default
  final cupertinoDefault = CupertinoScrollbar(
    child: ListView(children: rainbowRows(20)),
  );
  print('Cupertino default scrollbar');

  // Cupertino thick + always visible
  final cupertinoThick = CupertinoScrollbar(
    thumbVisibility: true,
    thickness: 8.0,
    thicknessWhileDragging: 14.0,
    radius: Radius.circular(7.0),
    radiusWhileDragging: Radius.circular(0.0),
    child: ListView(children: rainbowRows(20)),
  );
  print('Cupertino thick scrollbar');

  final rawCupertinoPanels = <Map<String, dynamic>>[
    {
      'label': 'RawScrollbar — pink',
      'desc': 'Custom thumb color and radius',
      'widget': rawCustom,
      'color': Colors.pink,
    },
    {
      'label': 'RawScrollbar — track',
      'desc': 'trackColor + trackBorderColor',
      'widget': rawTrack,
      'color': Colors.deepPurple,
    },
    {
      'label': 'CupertinoScrollbar',
      'desc': 'iOS-style thin pill',
      'widget': cupertinoDefault,
      'color': Colors.blueGrey,
    },
    {
      'label': 'CupertinoScrollbar — thick',
      'desc': 'thicknessWhileDragging=14',
      'widget': cupertinoThick,
      'color': Colors.indigo,
    },
  ];

  final rawCupertinoPanelWidgets = <Widget>[];
  for (final v in rawCupertinoPanels) {
    final color = v['color'] as Color;
    rawCupertinoPanelWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.architecture, color: color, size: 18.0),
                SizedBox(width: 6.0),
                Text(
                  v['label'] as String,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    v['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
              child: SizedBox(height: 200.0, child: v['widget'] as Widget),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${rawCupertinoPanelWidgets.length} raw/cupertino panels');

  // ============================================================
  // SECTION 4: Real-World Panels — Log, Sidebar, Chat
  // ============================================================
  print('=== Section 4: Real-World Scrollbar Panels ===');

  // 4a. Log viewer with dark theme
  final logLines = <Map<String, dynamic>>[
    {
      'level': 'INFO',
      'msg': 'Server started on :8080',
      'color': Colors.cyan,
    },
    {
      'level': 'DEBUG',
      'msg': 'Connection pool initialized',
      'color': Colors.grey,
    },
    {
      'level': 'INFO',
      'msg': 'Loaded 142 routes',
      'color': Colors.cyan,
    },
    {
      'level': 'WARN',
      'msg': 'Cache miss for key=user:42',
      'color': Colors.orange,
    },
    {
      'level': 'INFO',
      'msg': 'Request GET /api/v1/items',
      'color': Colors.cyan,
    },
    {
      'level': 'DEBUG',
      'msg': 'SQL: SELECT * FROM items LIMIT 50',
      'color': Colors.grey,
    },
    {
      'level': 'ERROR',
      'msg': 'Timeout on upstream service',
      'color': Colors.red,
    },
    {
      'level': 'INFO',
      'msg': 'Retry attempt 1 of 3',
      'color': Colors.cyan,
    },
    {
      'level': 'INFO',
      'msg': 'Retry succeeded after 240ms',
      'color': Colors.greenAccent,
    },
    {
      'level': 'DEBUG',
      'msg': 'Response 200 OK (1.4 KB)',
      'color': Colors.grey,
    },
    {
      'level': 'WARN',
      'msg': 'Slow query: 1.2s for /reports',
      'color': Colors.orange,
    },
    {
      'level': 'INFO',
      'msg': 'Background job queued: id=8821',
      'color': Colors.cyan,
    },
    {
      'level': 'INFO',
      'msg': 'Job 8821 completed in 320ms',
      'color': Colors.greenAccent,
    },
    {
      'level': 'DEBUG',
      'msg': 'Garbage collected 8 MiB',
      'color': Colors.grey,
    },
    {
      'level': 'ERROR',
      'msg': 'Auth failed for user=guest',
      'color': Colors.red,
    },
    {
      'level': 'INFO',
      'msg': 'Healthcheck OK',
      'color': Colors.cyan,
    },
    {
      'level': 'INFO',
      'msg': 'Metrics flushed to sink',
      'color': Colors.cyan,
    },
    {
      'level': 'DEBUG',
      'msg': 'Reloaded config (mtime changed)',
      'color': Colors.grey,
    },
  ];

  final logTiles = <Widget>[];
  for (int i = 0; i < logLines.length; i++) {
    final entry = logLines[i];
    final levelColor = entry['color'] as Color;
    logTiles.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (i + 1).toString().padLeft(3, '0'),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              width: 56.0,
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
              decoration: BoxDecoration(
                color: levelColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(
                  color: levelColor.withValues(alpha: 0.6),
                  width: 1.0,
                ),
              ),
              child: Text(
                entry['level'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: levelColor,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                entry['msg'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final logViewer = Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade700, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.terminal, color: Colors.greenAccent, size: 16.0),
              SizedBox(width: 8.0),
              Text(
                'server.log',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '${logLines.length} lines',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220.0,
          child: RawScrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            thumbColor: Colors.greenAccent.withValues(alpha: 0.7),
            trackColor: Colors.grey.shade800,
            trackBorderColor: Colors.grey.shade700,
            thickness: 8.0,
            radius: Radius.circular(4.0),
            child: ListView(children: logTiles),
          ),
        ),
      ],
    ),
  );
  print('Created log viewer panel');

  // 4b. Sidebar navigation
  final navItems = [
    {'icon': Icons.dashboard, 'label': 'Dashboard'},
    {'icon': Icons.inbox, 'label': 'Inbox'},
    {'icon': Icons.assignment, 'label': 'Tasks'},
    {'icon': Icons.event, 'label': 'Calendar'},
    {'icon': Icons.bar_chart, 'label': 'Reports'},
    {'icon': Icons.people, 'label': 'Team'},
    {'icon': Icons.folder, 'label': 'Files'},
    {'icon': Icons.cloud, 'label': 'Storage'},
    {'icon': Icons.settings, 'label': 'Settings'},
    {'icon': Icons.security, 'label': 'Security'},
    {'icon': Icons.payment, 'label': 'Billing'},
    {'icon': Icons.help_outline, 'label': 'Help'},
    {'icon': Icons.bookmark, 'label': 'Saved'},
    {'icon': Icons.archive, 'label': 'Archive'},
    {'icon': Icons.delete_outline, 'label': 'Trash'},
  ];

  final sidebarTiles = <Widget>[];
  for (int i = 0; i < navItems.length; i++) {
    final selected = i == 2;
    sidebarTiles.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: selected ? Colors.indigo.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: selected
              ? Border.all(color: Colors.indigo.shade400, width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              navItems[i]['icon'] as IconData,
              size: 18.0,
              color: selected ? Colors.indigo.shade700 : Colors.grey.shade700,
            ),
            SizedBox(width: 10.0),
            Text(
              navItems[i]['label'] as String,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? Colors.indigo.shade900 : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final sidebarPanel = Container(
    margin: EdgeInsets.all(8.0),
    width: 220.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.1),
          blurRadius: 8.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade600, Colors.indigo.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.menu, color: Colors.white, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 240.0,
          child: Scrollbar(
            thumbVisibility: true,
            thickness: 6.0,
            radius: Radius.circular(3.0),
            child: ListView(children: sidebarTiles),
          ),
        ),
      ],
    ),
  );
  print('Created sidebar panel');

  // 4c. Chat list
  final chatMessages = <Map<String, dynamic>>[
    {'from': 'Alice', 'msg': 'Morning! Sprint review at 10?', 'isMe': false},
    {'from': 'Me', 'msg': 'Yes — I have the slides ready.', 'isMe': true},
    {'from': 'Alice', 'msg': 'Perfect, thanks!', 'isMe': false},
    {'from': 'Bob', 'msg': 'Can someone review PR #482?', 'isMe': false},
    {'from': 'Me', 'msg': 'On it.', 'isMe': true},
    {'from': 'Bob', 'msg': 'Thanks!', 'isMe': false},
    {'from': 'Carol', 'msg': 'Lunch at the new sushi place?', 'isMe': false},
    {'from': 'Me', 'msg': 'In!', 'isMe': true},
    {'from': 'Alice', 'msg': 'Demo recording is up.', 'isMe': false},
    {'from': 'Me', 'msg': 'Will watch after standup.', 'isMe': true},
    {'from': 'Bob', 'msg': 'PR merged, thanks again.', 'isMe': false},
    {'from': 'Carol', 'msg': '12:30 work?', 'isMe': false},
    {'from': 'Me', 'msg': '12:30 it is.', 'isMe': true},
  ];

  final chatTiles = <Widget>[];
  for (final m in chatMessages) {
    final isMe = m['isMe'] as bool;
    chatTiles.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: isMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              CircleAvatar(
                radius: 14.0,
                backgroundColor: Colors.teal.shade200,
                child: Text(
                  (m['from'] as String).substring(0, 1),
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
            if (!isMe) SizedBox(width: 8.0),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: isMe ? Colors.teal.shade400 : Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(isMe ? 12.0 : 2.0),
                    bottomRight: Radius.circular(isMe ? 2.0 : 12.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isMe)
                      Text(
                        m['from'] as String,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade900,
                        ),
                      ),
                    Text(
                      m['msg'] as String,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.grey.shade900,
                        fontSize: 13.0,
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

  final chatPanel = Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.1),
          blurRadius: 8.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade600, Colors.teal.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.chat_bubble_outline, color: Colors.white, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'Team Chat',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '${chatMessages.length} msgs',
                style: TextStyle(color: Colors.white70, fontSize: 11.0),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 260.0,
          child: CupertinoScrollbar(
            thumbVisibility: true,
            thickness: 6.0,
            radius: Radius.circular(3.0),
            child: ListView(children: chatTiles),
          ),
        ),
      ],
    ),
  );
  print('Created chat panel');

  // ============================================================
  // SECTION 5: ScrollbarTheme demo
  // ============================================================
  print('=== Section 5: ScrollbarTheme Demo ===');

  final themedThumbColor = WidgetStateProperty.resolveWith<Color?>((states) {
    if (states.contains(WidgetState.dragged)) {
      return Colors.deepOrange.shade600;
    }
    if (states.contains(WidgetState.hovered)) {
      return Colors.deepOrange.shade400;
    }
    return Colors.deepOrange.shade200;
  });

  final themedThickness = WidgetStateProperty.resolveWith<double?>((states) {
    if (states.contains(WidgetState.dragged)) return 14.0;
    if (states.contains(WidgetState.hovered)) return 10.0;
    return 6.0;
  });

  final themedTrackColor = WidgetStateProperty.resolveWith<Color?>((states) {
    if (states.contains(WidgetState.hovered)) {
      return Colors.deepOrange.shade50;
    }
    return Colors.orange.shade50;
  });

  final scrollbarThemeData = ScrollbarThemeData(
    thumbVisibility: WidgetStateProperty.all(true),
    trackVisibility: WidgetStateProperty.all(true),
    thumbColor: themedThumbColor,
    trackColor: themedTrackColor,
    trackBorderColor: WidgetStateProperty.all(Colors.deepOrange.shade200),
    thickness: themedThickness,
    radius: Radius.circular(8.0),
    interactive: true,
    crossAxisMargin: 2.0,
    mainAxisMargin: 4.0,
  );

  final themedScrollable = Theme(
    data: Theme.of(context).copyWith(scrollbarTheme: scrollbarThemeData),
    child: Scrollbar(child: ListView(children: rainbowRows(25))),
  );
  print('Created themed scrollbar (MaterialState-aware)');

  final themePanel = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepOrange.shade300, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: Colors.deepOrange, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'ScrollbarThemeData',
              style: TextStyle(
                color: Colors.deepOrange.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Thumb thickness & color resolve through WidgetState:\n'
          ' default = 6 / shade200    hover = 10 / shade400    drag = 14 / shade600',
          style: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
            color: Colors.deepOrange.shade800,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: SizedBox(height: 220.0, child: themedScrollable),
        ),
      ],
    ),
  );
  print('Created theme panel');

  // ============================================================
  // SECTION 6: Comparison Table + Code Panels
  // ============================================================
  print('=== Section 6: Comparison Table and Code Panels ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'feature': 'Default style',
      'scrollbar': 'Material',
      'raw': 'Unstyled',
      'cupertino': 'iOS pill',
    },
    {
      'feature': 'thumbVisibility',
      'scrollbar': 'yes',
      'raw': 'yes',
      'cupertino': 'yes',
    },
    {
      'feature': 'trackVisibility',
      'scrollbar': 'yes',
      'raw': 'yes',
      'cupertino': 'no',
    },
    {
      'feature': 'thickness',
      'scrollbar': 'yes',
      'raw': 'yes',
      'cupertino': 'yes',
    },
    {
      'feature': 'thumbColor',
      'scrollbar': 'via theme',
      'raw': 'direct prop',
      'cupertino': 'fixed iOS',
    },
    {
      'feature': 'thicknessWhileDragging',
      'scrollbar': 'no',
      'raw': 'no',
      'cupertino': 'yes',
    },
    {
      'feature': 'scrollbarOrientation',
      'scrollbar': 'yes',
      'raw': 'yes',
      'cupertino': 'no',
    },
    {
      'feature': 'interactive',
      'scrollbar': 'yes',
      'raw': 'yes',
      'cupertino': 'yes',
    },
  ];

  Widget tableCell(String text, {bool header = false, Color? color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: header
            ? Colors.blueGrey.shade700
            : (color ?? Colors.grey.shade50),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: header ? FontWeight.bold : FontWeight.normal,
          color: header ? Colors.white : Colors.grey.shade900,
          fontFamily: header ? null : 'monospace',
        ),
      ),
    );
  }

  final tableRows = <TableRow>[
    TableRow(
      children: [
        tableCell('Feature', header: true),
        tableCell('Scrollbar', header: true),
        tableCell('RawScrollbar', header: true),
        tableCell('CupertinoScrollbar', header: true),
      ],
    ),
  ];
  for (int i = 0; i < comparisonRows.length; i++) {
    final row = comparisonRows[i];
    final stripe = i.isEven ? Colors.grey.shade50 : Colors.white;
    tableRows.add(
      TableRow(
        children: [
          tableCell(row['feature'] as String, color: stripe),
          tableCell(row['scrollbar'] as String, color: stripe),
          tableCell(row['raw'] as String, color: stripe),
          tableCell(row['cupertino'] as String, color: stripe),
        ],
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.blueGrey, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Scrollbar Variant Comparison',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2.0),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1.7),
            3: FlexColumnWidth(2.0),
          },
          children: tableRows,
        ),
      ],
    ),
  );
  print('Created comparison table');

  // Code panels in dark Containers
  Widget codePanel(String title, String code, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: accent, size: 16.0),
              SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.green.shade300,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final codePanels = Column(
    children: [
      codePanel(
        'Material Scrollbar',
        '// Always-visible Material scrollbar\n'
            'Scrollbar(\n'
            '  thumbVisibility: true,\n'
            '  trackVisibility: true,\n'
            '  thickness: 10,\n'
            '  radius: Radius.circular(6),\n'
            '  child: ListView(children: items),\n'
            ');',
        Colors.cyan.shade400,
      ),
      codePanel(
        'RawScrollbar (full control)',
        '// Custom colors, no Material defaults\n'
            'RawScrollbar(\n'
            '  thumbColor: Colors.pink.shade400,\n'
            '  trackColor: Colors.pink.shade50,\n'
            '  thumbVisibility: true,\n'
            '  trackVisibility: true,\n'
            '  thickness: 12,\n'
            '  child: ListView(children: items),\n'
            ');',
        Colors.pink.shade300,
      ),
      codePanel(
        'CupertinoScrollbar (iOS)',
        '// iOS-style pill, thickens during drag\n'
            'CupertinoScrollbar(\n'
            '  thumbVisibility: true,\n'
            '  thickness: 6,\n'
            '  thicknessWhileDragging: 12,\n'
            '  radius: Radius.circular(3),\n'
            '  child: ListView(children: items),\n'
            ');',
        Colors.lightBlueAccent,
      ),
      codePanel(
        'ScrollbarThemeData (MaterialState)',
        '// Global theme with state-aware properties\n'
            'Theme(\n'
            '  data: Theme.of(context).copyWith(\n'
            '    scrollbarTheme: ScrollbarThemeData(\n'
            '      thumbColor: WidgetStateProperty.resolveWith((s) {\n'
            '        if (s.contains(WidgetState.dragged)) return red;\n'
            '        if (s.contains(WidgetState.hovered)) return orange;\n'
            '        return amber;\n'
            '      }),\n'
            '      thickness: WidgetStateProperty.all(8),\n'
            '      radius: Radius.circular(8),\n'
            '    ),\n'
            '  ),\n'
            '  child: Scrollbar(child: ListView(...)),\n'
            ');',
        Colors.orange.shade300,
      ),
    ],
  );
  print('Created code panels');

  // ============================================================
  // SECTION 7: Summary Panel
  // ============================================================
  print('=== Section 7: Summary ===');

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
      children: [
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
          Icons.view_week,
          'Scrollbar is opinionated',
          'Use Material Scrollbar for default platform look-and-feel.',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.tune,
          'RawScrollbar is the kit',
          'Drop down to RawScrollbar when you need bespoke colors or behavior.',
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.phone_iphone,
          'CupertinoScrollbar for iOS',
          'Thin pill that thickens on drag, matching iOS conventions.',
          Colors.blueGrey,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.palette,
          'Theme it once',
          'ScrollbarThemeData centralizes thumb, track, thickness, and radius.',
          Colors.deepOrange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.touch_app,
          'MaterialState-aware',
          'Resolve color/thickness through WidgetStateProperty for hover & drag.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.visibility,
          'thumbVisibility + trackVisibility',
          'Pin the bar permanently for desktop-style scrolling cues.',
          Colors.green,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('Scrollbar Deep Demo completed successfully');

  // ============================================================
  // Final composition
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header banner
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.4),
                    blurRadius: 14.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.swap_vert_circle_outlined,
                    size: 56.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Scrollbar Family',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Material, Raw, Cupertino & ScrollbarTheme',
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1: Concept cards
            Text(
              '1. Scrollbar Variants',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: conceptCards,
            ),
            SizedBox(height: 32.0),

            // Section 2: Material variants
            Text(
              '2. Material Scrollbar Variants',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...materialVariantPanels,
            SizedBox(height: 32.0),

            // Section 3: Raw + Cupertino
            Text(
              '3. RawScrollbar and CupertinoScrollbar',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...rawCupertinoPanelWidgets,
            SizedBox(height: 32.0),

            // Section 4: Real-world panels
            Text(
              '4. Real-World Panels',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            logViewer,
            SizedBox(height: 12.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sidebarPanel,
                Expanded(child: chatPanel),
              ],
            ),
            SizedBox(height: 32.0),

            // Section 5: ScrollbarTheme
            Text(
              '5. ScrollbarTheme + WidgetStateProperty',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            themePanel,
            SizedBox(height: 32.0),

            // Section 6: Comparison + code
            Text(
              '6. Comparison Table and Code Examples',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            comparisonTable,
            codePanels,
            SizedBox(height: 32.0),

            // Section 7: Summary
            Text(
              '7. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// Helper: Build summary item
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
      children: [
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
            children: [
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
