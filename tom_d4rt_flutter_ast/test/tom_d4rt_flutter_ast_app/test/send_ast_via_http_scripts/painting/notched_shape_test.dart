// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NotchedShape from painting
// Deep Demo: Visual demonstration of NotchedShape, CircularNotchedRectangle,
// AutomaticNotchedShape, BottomAppBar notch integration, and notchMargin.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NotchedShape Deep Demo executing');

  // Palette: slate / amber / teal
  final slate900 = Color(0xFF0F172A);
  final slate700 = Color(0xFF334155);
  final slate500 = Color(0xFF64748B);
  final slate300 = Color(0xFFCBD5E1);
  final slate100 = Color(0xFFF1F5F9);
  final amber500 = Color(0xFFF59E0B);
  final amber300 = Color(0xFFFCD34D);
  final amber100 = Color(0xFFFEF3C7);
  final teal600 = Color(0xFF0D9488);
  final teal400 = Color(0xFF2DD4BF);
  final teal100 = Color(0xFFCCFBF1);

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate900, slate700, teal600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: teal600.withValues(alpha: 0.25),
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
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: amber500.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: amber500, width: 2.0),
              ),
              child: Icon(
                Icons.crop_din_outlined,
                size: 36.0,
                color: amber300,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NotchedShape',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/painting.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: teal100,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.0,
            ),
          ),
          child: Text(
            'Abstract description of a host rectangle with a notch carved out '
            'for a guest rectangle. The canonical use case is BottomAppBar '
            'docking a FloatingActionButton.',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white.withValues(alpha: 0.92),
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _chip('abstract class', amber300, slate900),
            _chip('Path getOuterPath(Rect, Rect?)', teal400, slate900),
            _chip('CircularNotchedRectangle', amber100, slate900),
            _chip('AutomaticNotchedShape', teal100, slate900),
          ],
        ),
      ],
    ),
  );
  print('Built title banner');

  // ============================================================
  // SECTION 2: Anatomy Diagram
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate100, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: slate300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slate500.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: teal600, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a Notched Shape',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: slate900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Center(
          child: SizedBox(
            width: 320.0,
            height: 200.0,
            child: CustomPaint(
              painter: _AnatomyPainter(
                hostColor: slate700,
                hostFill: slate100,
                guestColor: amber500,
                guestFill: amber100,
                annotation: teal600,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 8.0,
          children: [
            _legendDot('host (Rect)', slate700),
            _legendDot('guest (Rect?)', amber500),
            _legendDot('outer path', teal600),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: slate100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: slate300, width: 1.0),
          ),
          child: Text(
            'getOuterPath(host, guest) returns a Path that traces the host '
            'boundary while curving around the guest at the intersection edge.',
            style: TextStyle(
              fontSize: 12.0,
              color: slate700,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built anatomy diagram');

  // ============================================================
  // SECTION 3: CircularNotchedRectangle Gallery
  // ============================================================
  print('=== Section 3: CircularNotchedRectangle Gallery ===');

  final circularGuests = <Map<String, dynamic>>[
    {'label': 'no guest', 'size': null, 'note': 'guest == null → plain rect'},
    {'label': 'small 40×40', 'size': 40.0, 'note': 'shallow notch'},
    {'label': 'medium 56×56', 'size': 56.0, 'note': 'standard FAB'},
    {'label': 'large 72×72', 'size': 72.0, 'note': 'extended FAB'},
  ];

  final circularGallery = <Widget>[];
  for (final entry in circularGuests) {
    final label = entry['label'] as String;
    final size = entry['size'] as double?;
    final note = entry['note'] as String;
    print('Circular gallery card: $label');
    circularGallery.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, teal100.withValues(alpha: 0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: teal400, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: teal600.withValues(alpha: 0.18),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: teal600,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13.0),
                  topRight: Radius.circular(13.0),
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                width: 200.0,
                height: 90.0,
                child: CustomPaint(
                  painter: _NotchPainter(
                    shapeKind: _NotchKind.circular,
                    guestSize: size,
                    fillColor: slate100,
                    strokeColor: slate900,
                    guestColor: amber500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: teal100,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  note,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: slate900,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${circularGallery.length} circular notch cards');

  // ============================================================
  // SECTION 4: AutomaticNotchedShape Gallery
  // ============================================================
  print('=== Section 4: AutomaticNotchedShape Gallery ===');

  final automaticGuests = <Map<String, dynamic>>[
    {'label': 'no guest', 'size': null, 'note': 'host shape outline only'},
    {'label': 'small 40×40', 'size': 40.0, 'note': 'rectangular notch'},
    {'label': 'medium 56×56', 'size': 56.0, 'note': 'wider rect cutout'},
    {'label': 'large 72×72', 'size': 72.0, 'note': 'guest bounds dominate'},
  ];

  final automaticGallery = <Widget>[];
  for (final entry in automaticGuests) {
    final label = entry['label'] as String;
    final size = entry['size'] as double?;
    final note = entry['note'] as String;
    print('Automatic gallery card: $label');
    automaticGallery.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, amber100.withValues(alpha: 0.55)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: amber500, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: amber500.withValues(alpha: 0.22),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: amber500,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13.0),
                  topRight: Radius.circular(13.0),
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: slate900,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                width: 200.0,
                height: 90.0,
                child: CustomPaint(
                  painter: _NotchPainter(
                    shapeKind: _NotchKind.automatic,
                    guestSize: size,
                    fillColor: slate100,
                    strokeColor: slate900,
                    guestColor: teal600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: amber100,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  note,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: slate900,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${automaticGallery.length} automatic notch cards');

  // ============================================================
  // SECTION 5: Comparison Table
  // ============================================================
  print('=== Section 5: Comparison Table ===');

  final comparisonRows = <List<String>>[
    ['Aspect', 'CircularNotchedRectangle', 'AutomaticNotchedShape'],
    ['Smoothness', 'smooth circular curve', 'rectangular bounding cutout'],
    ['Host shape', 'rectangle only', 'any ShapeBorder'],
    ['Guest sensitivity', 'uses guest center & radius', 'uses guest bounding rect'],
    ['BottomAppBar default', 'yes (when shape provided)', 'no'],
    ['Performance', 'cheap path math', 'depends on host ShapeBorder'],
  ];

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate100, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: slate300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slate500.withValues(alpha: 0.16),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: amber500, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Circular vs Automatic',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: slate900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (var i = 0; i < comparisonRows.length; i = i + 1)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: i == 0
                  ? slate900
                  : (i.isOdd ? slate100 : Colors.white),
              borderRadius: i == 0
                  ? BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    )
                  : BorderRadius.zero,
              border: Border(
                bottom: BorderSide(color: slate300, width: 0.5),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110.0,
                  child: Text(
                    comparisonRows[i][0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: i == 0 ? amber300 : slate900,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    comparisonRows[i][1],
                    style: TextStyle(
                      fontSize: 12.0,
                      color: i == 0 ? Colors.white : slate700,
                      fontFamily: i == 0 ? null : 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    comparisonRows[i][2],
                    style: TextStyle(
                      fontSize: 12.0,
                      color: i == 0 ? Colors.white : slate700,
                      fontFamily: i == 0 ? null : 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  print('Built comparison table');

  // ============================================================
  // SECTION 6: Real-world BottomAppBar Mock
  // ============================================================
  print('=== Section 6: Real-world Mock ===');

  final realWorldMock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate900, slate700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.phone_android, color: amber300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'BottomAppBar + FAB (real Scaffold)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          height: 360.0,
          decoration: BoxDecoration(
            color: slate100,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: slate900, width: 6.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20.0,
                offset: Offset(0.0, 8.0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Scaffold(
              backgroundColor: slate100,
              appBar: AppBar(
                backgroundColor: teal600,
                title: Text(
                  'NotchedShape Demo',
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
                automaticallyImplyLeading: false,
              ),
              body: ListView(
                padding: EdgeInsets.all(12.0),
                children: [
                  _mockListTile(Icons.inbox, 'Inbox', '42 unread', teal600),
                  _mockListTile(Icons.star, 'Starred', '7 items', amber500),
                  _mockListTile(Icons.send, 'Sent', 'today', slate700),
                  _mockListTile(Icons.delete, 'Trash', 'empty', slate500),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                shape: CircularNotchedRectangle(),
                notchMargin: 4.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.menu, color: slate700),
                    Icon(Icons.search, color: slate700),
                    SizedBox(width: 40.0),
                    Icon(Icons.notifications, color: slate700),
                    Icon(Icons.more_vert, color: slate700),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: null,
                backgroundColor: amber500,
                child: Icon(Icons.add, color: slate900),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'shape: CircularNotchedRectangle()  ·  notchMargin: 4.0  ·  '
          'location: centerDocked',
          style: TextStyle(
            color: teal100,
            fontSize: 11.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
  print('Built real-world mock');

  // ============================================================
  // SECTION 7: notchMargin Showcase
  // ============================================================
  print('=== Section 7: notchMargin Showcase ===');

  final notchMargins = <double>[0.0, 4.0, 8.0, 12.0];
  final marginCards = <Widget>[];
  for (final m in notchMargins) {
    print('Building notchMargin card: $m');
    marginCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, slate100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: slate300, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: slate500.withValues(alpha: 0.18),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: amber500,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13.0),
                  topRight: Radius.circular(13.0),
                ),
              ),
              child: Text(
                'notchMargin: ${m.toStringAsFixed(1)}',
                style: TextStyle(
                  color: slate900,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(height: 12.0),
            SizedBox(
              height: 140.0,
              width: 200.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _BottomAppBarPainter(
                        guestSize: 56.0,
                        notchMargin: m,
                        fillColor: Colors.white,
                        strokeColor: slate900,
                        shadowColor: slate500.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 28.0,
                    child: Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: teal600,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: teal600.withValues(alpha: 0.45),
                            blurRadius: 8.0,
                            offset: Offset(0.0, 4.0),
                          ),
                        ],
                      ),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                m == 0.0
                    ? 'FAB hugs the notch edge'
                    : 'gap of ${m.toStringAsFixed(1)} px around guest',
                style: TextStyle(fontSize: 11.0, color: slate700),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${marginCards.length} notchMargin cards');

  // ============================================================
  // SECTION 8: Custom NotchedShape pattern (code block)
  // ============================================================
  print('=== Section 8: Custom NotchedShape ===');

  final customPatternCode =
      '// Skeleton: subclass NotchedShape\n'
      'class TriangleNotchedShape extends NotchedShape {\n'
      '  const TriangleNotchedShape();\n'
      '\n'
      '  @override\n'
      '  Path getOuterPath(Rect host, Rect? guest) {\n'
      '    final p = Path()..addRect(host);\n'
      '    if (guest == null || !host.overlaps(guest)) {\n'
      '      return p;\n'
      '    }\n'
      '    // Carve a triangular notch out of the host top edge\n'
      '    final notch = Path()\n'
      '      ..moveTo(guest.left, host.top)\n'
      '      ..lineTo(guest.center.dx, guest.bottom)\n'
      '      ..lineTo(guest.right, host.top)\n'
      '      ..close();\n'
      '    return Path.combine(PathOperation.difference, p, notch);\n'
      '  }\n'
      '}';

  final customPatternBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slate900,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: teal600, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: slate900.withValues(alpha: 0.55),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: teal400, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'Subclassing NotchedShape (skeleton)',
              style: TextStyle(
                color: amber300,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: teal600.withValues(alpha: 0.6),
              width: 1.0,
            ),
          ),
          child: Text(
            customPatternCode,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: teal100,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Override getOuterPath; combine the host outline with a guest-aware '
          'cutout via Path.combine to ship a fully custom notch.',
          style: TextStyle(
            color: slate300,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
  print('Built custom pattern block');

  // ============================================================
  // SECTION 9: Lifecycle (when getOuterPath is called)
  // ============================================================
  print('=== Section 9: Lifecycle ===');

  final lifecycleSteps = <Map<String, String>>[
    {
      'title': 'Layout pass',
      'body':
          'BottomAppBar resolves its host Rect from constraints; the FAB '
          'reports its guest Rect via the Scaffold geometry notifier.',
    },
    {
      'title': 'Paint pass',
      'body':
          'The render object calls shape.getOuterPath(host, guest) to obtain '
          'a Path, then fills it with the BottomAppBar color.',
    },
    {
      'title': 'Repaint trigger',
      'body':
          'Whenever host bounds, guest bounds, notchMargin, or shape change, '
          'the render object marks itself dirty and re-invokes getOuterPath.',
    },
  ];

  final lifecycleBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [teal100, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: teal400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: teal600.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: teal600, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Lifecycle of getOuterPath',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: slate900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (var i = 0; i < lifecycleSteps.length; i = i + 1)
          Container(
            margin: EdgeInsets.symmetric(vertical: 6.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: teal400, width: 1.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: teal600,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: teal600.withValues(alpha: 0.4),
                        blurRadius: 6.0,
                        offset: Offset(0.0, 3.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lifecycleSteps[i]['title']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: slate900,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        lifecycleSteps[i]['body']!,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: slate700,
                          height: 1.4,
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
  );
  print('Built lifecycle block');

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = <Map<String, String>>[
    {
      'title': 'Guest must intersect host top',
      'body':
          'If the guest does not overlap the host edge, you get a flat host '
          'outline — no notch, no error.',
    },
    {
      'title': 'Null guest renders the host outline only',
      'body':
          'Passing null guest is legal: the path equals the host shape. Useful '
          'for animating the notch in/out by toggling the guest.',
    },
    {
      'title': 'notchMargin lives on the host side',
      'body':
          'BottomAppBar.notchMargin inflates the *guest* rect before computing '
          'the notch — the guest widget itself is unchanged.',
    },
    {
      'title': 'Large notches clip FAB shadow',
      'body':
          'A wide / deep notch cuts into the FAB elevation halo. Adjust '
          'notchMargin or use a smaller guest if the shadow looks chopped.',
    },
    {
      'title': 'Animated notches recompute every frame',
      'body':
          'getOuterPath is called per paint. Avoid expensive Path.combine in '
          'custom subclasses on hot paint paths — cache when feasible.',
    },
  ];

  final footgunCards = <Widget>[];
  for (var i = 0; i < footguns.length; i = i + 1) {
    print('Building footgun ${i + 1}: ${footguns[i]['title']}');
    footgunCards.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [amber100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: amber500, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: amber500.withValues(alpha: 0.3),
              blurRadius: 8.0,
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
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: amber500,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: slate900,
                    size: 16.0,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    footguns[i]['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: slate900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              footguns[i]['body']!,
              style: TextStyle(
                fontSize: 12.0,
                color: slate700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${footgunCards.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapBullets = <String>[
    'NotchedShape is abstract — implement getOuterPath(host, guest).',
    'CircularNotchedRectangle gives the smooth FAB-friendly notch.',
    'AutomaticNotchedShape adapts any ShapeBorder host to a rect-shaped guest.',
    'BottomAppBar.notchMargin pads the guest rect before carving the notch.',
    'Null guest yields the bare host outline — toggle to animate the notch.',
  ];

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slate900, teal600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: teal600.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: slate900.withValues(alpha: 0.3),
          blurRadius: 24.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark, color: amber300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final bullet in recapBullets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.only(top: 6.0, right: 10.0),
                  decoration: BoxDecoration(
                    color: amber300,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    bullet,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  print('Built recap card');

  print('NotchedShape Deep Demo completed successfully');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    backgroundColor: slate100,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 20.0),
          _sectionHeader('1. Anatomy', Icons.architecture, slate900, amber500),
          anatomyDiagram,
          SizedBox(height: 20.0),
          _sectionHeader(
            '2. CircularNotchedRectangle Gallery',
            Icons.circle_outlined,
            slate900,
            teal600,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: circularGallery,
          ),
          SizedBox(height: 20.0),
          _sectionHeader(
            '3. AutomaticNotchedShape Gallery',
            Icons.crop_square,
            slate900,
            amber500,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: automaticGallery,
          ),
          SizedBox(height: 20.0),
          _sectionHeader(
            '4. Comparison',
            Icons.compare_arrows,
            slate900,
            amber500,
          ),
          comparisonTable,
          SizedBox(height: 20.0),
          _sectionHeader(
            '5. Real-world BottomAppBar',
            Icons.phone_android,
            slate900,
            teal600,
          ),
          realWorldMock,
          SizedBox(height: 20.0),
          _sectionHeader(
            '6. notchMargin Showcase',
            Icons.straighten,
            slate900,
            amber500,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: marginCards,
          ),
          SizedBox(height: 20.0),
          _sectionHeader(
            '7. Custom NotchedShape',
            Icons.code,
            slate900,
            teal600,
          ),
          customPatternBlock,
          SizedBox(height: 20.0),
          _sectionHeader(
            '8. Lifecycle',
            Icons.timeline,
            slate900,
            teal600,
          ),
          lifecycleBlock,
          SizedBox(height: 20.0),
          _sectionHeader(
            '9. Footguns',
            Icons.warning_amber_rounded,
            slate900,
            amber500,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: footgunCards,
          ),
          SizedBox(height: 20.0),
          _sectionHeader(
            '10. Recap',
            Icons.bookmark,
            slate900,
            teal600,
          ),
          recapCard,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Top-level helpers (no classes except CustomPainter exception)
// ============================================================

Widget _sectionHeader(String text, IconData icon, Color textColor, Color accent) {
  return Container(
    margin: EdgeInsets.only(top: 8.0, bottom: 10.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [accent.withValues(alpha: 0.12), Colors.white],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(left: BorderSide(color: accent, width: 4.0)),
    ),
    child: Row(
      children: [
        Icon(icon, color: accent, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String text, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _legendDot(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12.0,
        height: 12.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.45),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
      ),
      SizedBox(width: 6.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 11.0,
          color: Color(0xFF334155),
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

Widget _mockListTile(IconData icon, String title, String subtitle, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFCBD5E1), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// CustomPainter subclasses (special exception per spec)
// ============================================================

enum _NotchKind { circular, automatic }

class _NotchPainter extends CustomPainter {
  _NotchPainter({
    required this.shapeKind,
    required this.guestSize,
    required this.fillColor,
    required this.strokeColor,
    required this.guestColor,
  });

  final _NotchKind shapeKind;
  final double? guestSize;
  final Color fillColor;
  final Color strokeColor;
  final Color guestColor;

  @override
  void paint(Canvas canvas, Size size) {
    final hostHeight = 48.0;
    final host = Rect.fromLTWH(
      0.0,
      size.height - hostHeight,
      size.width,
      hostHeight,
    );

    Rect? guest;
    if (guestSize != null) {
      final s = guestSize!;
      guest = Rect.fromCenter(
        center: Offset(size.width / 2.0, size.height - hostHeight),
        width: s,
        height: s,
      );
    }

    final NotchedShape shape;
    if (shapeKind == _NotchKind.circular) {
      shape = const CircularNotchedRectangle();
    } else {
      shape = const AutomaticNotchedShape(
        RoundedRectangleBorder(),
      );
    }

    final path = shape.getOuterPath(host, guest);

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);

    if (guest != null) {
      final guestFill = Paint()
        ..color = guestColor.withValues(alpha: 0.85)
        ..style = PaintingStyle.fill;
      final guestStroke = Paint()
        ..color = guestColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(guest.center, guest.width / 2.0, guestFill);
      canvas.drawCircle(guest.center, guest.width / 2.0, guestStroke);
    }
  }

  @override
  bool shouldRepaint(_NotchPainter old) {
    return old.shapeKind != shapeKind ||
        old.guestSize != guestSize ||
        old.fillColor != fillColor ||
        old.strokeColor != strokeColor ||
        old.guestColor != guestColor;
  }
}

class _AnatomyPainter extends CustomPainter {
  _AnatomyPainter({
    required this.hostColor,
    required this.hostFill,
    required this.guestColor,
    required this.guestFill,
    required this.annotation,
  });

  final Color hostColor;
  final Color hostFill;
  final Color guestColor;
  final Color guestFill;
  final Color annotation;

  @override
  void paint(Canvas canvas, Size size) {
    final hostHeight = 70.0;
    final host = Rect.fromLTWH(
      20.0,
      size.height - hostHeight - 10.0,
      size.width - 40.0,
      hostHeight,
    );
    final guest = Rect.fromCircle(
      center: Offset(size.width / 2.0, host.top),
      radius: 32.0,
    );

    final shape = const CircularNotchedRectangle();
    final outerPath = shape.getOuterPath(host, guest);

    // Host fill + outline
    final hostFillPaint = Paint()
      ..color = hostFill
      ..style = PaintingStyle.fill;
    final hostStrokePaint = Paint()
      ..color = hostColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawPath(outerPath, hostFillPaint);
    canvas.drawPath(outerPath, hostStrokePaint);

    // Guest fill + outline
    final guestFillPaint = Paint()
      ..color = guestFill
      ..style = PaintingStyle.fill;
    final guestStrokePaint = Paint()
      ..color = guestColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(guest.center, guest.width / 2.0, guestFillPaint);
    canvas.drawCircle(guest.center, guest.width / 2.0, guestStrokePaint);

    // Annotation arrow line from notch crest to top-right
    final annotationPaint = Paint()
      ..color = annotation
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final crest = Offset(guest.center.dx, host.top - 6.0);
    final annotationEnd = Offset(size.width - 30.0, 20.0);
    canvas.drawLine(crest, annotationEnd, annotationPaint);

    final dotPaint = Paint()
      ..color = annotation
      ..style = PaintingStyle.fill;
    canvas.drawCircle(crest, 3.0, dotPaint);
    canvas.drawCircle(annotationEnd, 3.0, dotPaint);
  }

  @override
  bool shouldRepaint(_AnatomyPainter old) {
    return old.hostColor != hostColor ||
        old.hostFill != hostFill ||
        old.guestColor != guestColor ||
        old.guestFill != guestFill ||
        old.annotation != annotation;
  }
}

class _BottomAppBarPainter extends CustomPainter {
  _BottomAppBarPainter({
    required this.guestSize,
    required this.notchMargin,
    required this.fillColor,
    required this.strokeColor,
    required this.shadowColor,
  });

  final double guestSize;
  final double notchMargin;
  final Color fillColor;
  final Color strokeColor;
  final Color shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    final hostHeight = 60.0;
    final host = Rect.fromLTWH(
      6.0,
      size.height - hostHeight - 6.0,
      size.width - 12.0,
      hostHeight,
    );
    final guest = Rect.fromCircle(
      center: Offset(size.width / 2.0, host.top),
      radius: guestSize / 2.0,
    ).inflate(notchMargin);

    const shape = CircularNotchedRectangle();
    final path = shape.getOuterPath(host, guest);

    final shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6.0);
    canvas.save();
    canvas.translate(0.0, 4.0);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(_BottomAppBarPainter old) {
    return old.guestSize != guestSize ||
        old.notchMargin != notchMargin ||
        old.fillColor != fillColor ||
        old.strokeColor != strokeColor ||
        old.shadowColor != shadowColor;
  }
}
