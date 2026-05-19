// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import, unnecessary_type_check, avoid_print
// =============================================================================
// ObjectEvent visual studio (foundation/ variant)
// =============================================================================
//
// Subject: the ObjectEvent class hierarchy from package:flutter/foundation.dart.
//   - ObjectEvent (abstract base) holds a reference to an Object.
//   - ObjectCreated extends ObjectEvent and adds (library, className).
//   - ObjectDisposed extends ObjectEvent (no extra fields beyond object).
//   - FlutterMemoryAllocations is the singleton dispatcher that fires events
//     to registered ObjectEventListener callbacks.
//
// Companion file: retest/foundation/object_event_test.dart already exists and
// uses a purple/lavender palette with vertical card flows. To avoid duplicate
// visuals this studio uses:
//   - a dark slate stage with teal / coral / amber accents
//   - horizontal "track" layouts and a timeline strip
//   - completely different recipe scenarios (network image cache, ticker
//     subscriptions, scroll position observers, GPU picture pool, isolate
//     bootstrapping) instead of the retest variant's general widget flow
//   - a constellation diagram of the type hierarchy instead of a flat tree
//
// The script is statically rendered (no controllers, no main / test / expect).
// It returns a MaterialApp from a top-level build(BuildContext) function.
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Palette - intentionally different from the retest variant.
// -----------------------------------------------------------------------------
const Color _kStageBg = Color(0xFF0E1A24);
const Color _kStageBgAlt = Color(0xFF132433);
const Color _kSurface = Color(0xFF1A2D3F);
const Color _kSurfaceAlt = Color(0xFF223A50);
const Color _kInk = Color(0xFFE8F1F8);
const Color _kInkSoft = Color(0xFFA9BCCC);
const Color _kInkFaint = Color(0xFF6E8497);
const Color _kTeal = Color(0xFF2DD4BF);
const Color _kTealDeep = Color(0xFF0F766E);
const Color _kCoral = Color(0xFFFB7185);
const Color _kCoralDeep = Color(0xFFBE123C);
const Color _kAmber = Color(0xFFFBBF24);
const Color _kAmberDeep = Color(0xFFB45309);
const Color _kViolet = Color(0xFFA78BFA);
const Color _kSky = Color(0xFF60A5FA);
const Color _kLime = Color(0xFFA3E635);

// =============================================================================
// Top-level entry point
// =============================================================================
dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Sample events, exercised via the concrete subclasses (ObjectEvent itself
  // is abstract). The retest companion uses generic widget objects; this
  // studio focuses on system-level instrumentation: image cache, picture pool,
  // ticker providers, scroll observers, isolate bootstrap.
  // ---------------------------------------------------------------------------
  final Object imageHandle = Object();
  final Object pictureHandle = Object();
  final Object tickerHandle = Object();
  final Object scrollObserver = Object();
  final Object isolateBootstrap = Object();
  final Object networkCacheEntry = Object();
  final Object disposedImage = Object();
  final Object disposedPicture = Object();
  final Object disposedTicker = Object();
  final Object disposedScroll = Object();

  final ObjectCreated cImage = ObjectCreated(
    library: 'dart:ui',
    className: 'Image',
    object: imageHandle,
  );
  final ObjectCreated cPicture = ObjectCreated(
    library: 'dart:ui',
    className: 'Picture',
    object: pictureHandle,
  );
  final ObjectCreated cTicker = ObjectCreated(
    library: 'package:flutter/scheduler.dart',
    className: 'Ticker',
    object: tickerHandle,
  );
  final ObjectCreated cScroll = ObjectCreated(
    library: 'package:flutter/widgets.dart',
    className: 'ScrollPositionWithSingleContext',
    object: scrollObserver,
  );
  final ObjectCreated cIsolate = ObjectCreated(
    library: 'package:flutter/services.dart',
    className: 'IsolateNameServer',
    object: isolateBootstrap,
  );
  final ObjectCreated cNetCache = ObjectCreated(
    library: 'package:flutter/painting.dart',
    className: 'NetworkImageProvider',
    object: networkCacheEntry,
  );

  final ObjectDisposed dImage = ObjectDisposed(object: disposedImage);
  final ObjectDisposed dPicture = ObjectDisposed(object: disposedPicture);
  final ObjectDisposed dTicker = ObjectDisposed(object: disposedTicker);
  final ObjectDisposed dScroll = ObjectDisposed(object: disposedScroll);

  // Polymorphic references viewed as ObjectEvent.
  final ObjectEvent polyA = cImage;
  final ObjectEvent polyB = dImage;
  final ObjectEvent polyC = cTicker;
  final ObjectEvent polyD = dPicture;
  final ObjectEvent polyE = cScroll;
  final ObjectEvent polyF = dTicker;

  final List<ObjectEvent> stream = <ObjectEvent>[
    cImage,
    cPicture,
    cTicker,
    dImage,
    cScroll,
    cIsolate,
    dPicture,
    cNetCache,
    dTicker,
    dScroll,
  ];

  // Aggregate counts for a small dashboard.
  int createdCount = 0;
  int disposedCount = 0;
  for (final ObjectEvent e in stream) {
    if (e is ObjectCreated) createdCount += 1;
    if (e is ObjectDisposed) disposedCount += 1;
  }

  // toMap snapshots for the JSON output cards.
  final Map<Object, Map<String, Object>> mapImage = cImage.toMap();
  final Map<Object, Map<String, Object>> mapTicker = cTicker.toMap();
  final Map<Object, Map<String, Object>> mapDispImage = dImage.toMap();
  final Map<Object, Map<String, Object>> mapDispTicker = dTicker.toMap();

  // Static animation values consumed by anything expecting an Animation.
  final Animation<double> still = AlwaysStoppedAnimation<double>(1.0);
  final Animation<double> half = AlwaysStoppedAnimation<double>(0.5);
  final Duration noMotion = Duration.zero;

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: _kStageBg,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // 1. Hero banner with system-level framing.
            _buildHeroBanner(createdCount, disposedCount, stream.length),
            SizedBox(height: 28.0),

            // 2. Type hierarchy as a constellation / diamond.
            _buildSectionTitle(
              '01',
              'Type Constellation',
              'How ObjectEvent fans out into ObjectCreated and ObjectDisposed.',
              _kTeal,
            ),
            SizedBox(height: 14.0),
            _buildHierarchyConstellation(),
            SizedBox(height: 32.0),

            // 3. Event stream timeline (horizontal track).
            _buildSectionTitle(
              '02',
              'Event Stream Timeline',
              'A chronological strip showing alternating create/dispose pulses.',
              _kCoral,
            ),
            SizedBox(height: 14.0),
            _buildEventTimeline(stream),
            SizedBox(height: 32.0),

            // 4. Field anatomy split panels.
            _buildSectionTitle(
              '03',
              'Field Anatomy',
              'Side-by-side layout of every property for both subclasses.',
              _kAmber,
            ),
            SizedBox(height: 14.0),
            _buildFieldAnatomy(),
            SizedBox(height: 32.0),

            // 5. Library palette - distinct scenarios from the retest version.
            _buildSectionTitle(
              '04',
              'Instrumented Library Palette',
              'System-level subsystems where ObjectCreated commonly fires.',
              _kViolet,
            ),
            SizedBox(height: 14.0),
            _buildLibraryPalette(),
            SizedBox(height: 32.0),

            // 6. toMap output - styled like a JSON inspector.
            _buildSectionTitle(
              '05',
              'toMap() Inspector',
              'Live serialisation of created and disposed events.',
              _kSky,
            ),
            SizedBox(height: 14.0),
            _buildToMapInspector(
              cImage,
              cTicker,
              dImage,
              dTicker,
              mapImage,
              mapTicker,
              mapDispImage,
              mapDispTicker,
            ),
            SizedBox(height: 32.0),

            // 7. Listener pipeline diagram (dispatch flow).
            _buildSectionTitle(
              '06',
              'Dispatch Pipeline',
              'How FlutterMemoryAllocations broadcasts events to listeners.',
              _kLime,
            ),
            SizedBox(height: 14.0),
            _buildDispatchPipeline(),
            SizedBox(height: 32.0),

            // 8. Lifecycle recipes - new scenarios.
            _buildSectionTitle(
              '07',
              'Lifecycle Recipes',
              'Hand-picked instrumentation patterns from real Flutter code.',
              _kCoral,
            ),
            SizedBox(height: 14.0),
            _buildLifecycleRecipes(),
            SizedBox(height: 32.0),

            // 9. Counters dashboard (compact stat strip).
            _buildSectionTitle(
              '08',
              'Counters Dashboard',
              'Snapshot of how many of each event passed through the stream.',
              _kTeal,
            ),
            SizedBox(height: 14.0),
            _buildCountersDashboard(stream, createdCount, disposedCount),
            SizedBox(height: 32.0),

            // 10. Pitfalls + cheat sheet footer.
            _buildSectionTitle(
              '09',
              'Pitfalls & Cheat Sheet',
              'Quick reminders for safe ObjectEvent instrumentation.',
              _kAmber,
            ),
            SizedBox(height: 14.0),
            _buildPitfalls(),
            SizedBox(height: 18.0),
            _buildCheatSheet(),
            SizedBox(height: 24.0),

            // Footer band.
            _buildFooter(),
            SizedBox(height: 12.0),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// 0. Common building blocks
// =============================================================================

Widget _buildSectionTitle(
  String number,
  String title,
  String subtitle,
  Color accent,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          accent.withValues(alpha: 0.18),
          accent.withValues(alpha: 0.04),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border(
        left: BorderSide(color: accent, width: 4.0),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 18.0,
          spreadRadius: -4.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: _kStageBgAlt,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: accent, width: 1.5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: accent.withValues(alpha: 0.35),
                blurRadius: 10.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 12.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _kvRow(String key, String value, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 92.0,
          child: Text(
            key,
            style: TextStyle(
              color: accent,
              fontSize: 11.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _kInk,
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String text, Color accent) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, top: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: accent,
        fontSize: 10.5,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// =============================================================================
// 1. Hero banner
// =============================================================================
Widget _buildHeroBanner(int created, int disposed, int total) {
  return Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0F766E),
          Color(0xFF1E3A8A),
          Color(0xFFBE123C),
        ],
        stops: <double>[0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kTeal.withValues(alpha: 0.30),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: _kCoral.withValues(alpha: 0.18),
          blurRadius: 30.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.45),
                  width: 1.0,
                ),
              ),
              child: Text(
                'package:flutter/foundation.dart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  letterSpacing: 0.3,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'foundation/ studio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ObjectEvent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Memory allocation lifecycle - created and disposed pulses',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.88),
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 14.0),
                  Text(
                    'A static visual studio of the ObjectEvent hierarchy from\n'
                    'package:flutter/foundation.dart. The abstract base class\n'
                    'ObjectEvent is exercised through its concrete subclasses\n'
                    'ObjectCreated and ObjectDisposed, which are dispatched by\n'
                    'FlutterMemoryAllocations.instance to registered listeners.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.78),
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 18.0),
            Container(
              width: 168.0,
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _heroStat('events', '$total', Colors.white),
                  Divider(
                    height: 12.0,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                  _heroStat('created', '$created', _kTeal),
                  SizedBox(height: 4.0),
                  _heroStat('disposed', '$disposed', _kCoral),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _heroStat(String label, String value, Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.75),
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
      Text(
        value,
        style: TextStyle(
          color: color,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

// =============================================================================
// 2. Type constellation diagram
// =============================================================================
Widget _buildHierarchyConstellation() {
  return Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_kSurface, _kStageBgAlt],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kTeal.withValues(alpha: 0.45), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kTeal.withValues(alpha: 0.12),
          blurRadius: 18.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        // Apex node: ObjectEvent (abstract).
        Center(child: _constellationNode(
          'ObjectEvent',
          'abstract base',
          <String>['object: Object', 'toMap()'],
          _kTeal,
          big: true,
        )),
        SizedBox(height: 6.0),
        // Connecting lines (rendered as gradient bars).
        Row(
          children: <Widget>[
            Expanded(child: _connector(_kTeal, _kCoral)),
            SizedBox(width: 80.0),
            Expanded(child: _connector(_kTeal, _kAmber)),
          ],
        ),
        SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _constellationNode(
              'ObjectCreated',
              'extends ObjectEvent',
              <String>[
                'library: String',
                'className: String',
                'object: Object',
              ],
              _kCoral,
            ),
            _constellationNode(
              'ObjectDisposed',
              'extends ObjectEvent',
              <String>['object: Object'],
              _kAmber,
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kStageBg,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: _kInkFaint.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.info_outline, color: _kSky, size: 18.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'ObjectEvent itself cannot be constructed directly - it is '
                  'abstract. Polymorphic code accepts ObjectEvent and dispatches '
                  'on its runtime subclass with a type check.',
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 11.5,
                    height: 1.4,
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

Widget _connector(Color a, Color b) {
  return Container(
    height: 38.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[a, b],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Center(
      child: Container(
        height: 2.0,
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.25),
        ),
      ),
    ),
  );
}

Widget _constellationNode(
  String title,
  String subtitle,
  List<String> bullets,
  Color accent, {
  bool big = false,
}) {
  return Container(
    width: big ? 240.0 : 200.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          accent.withValues(alpha: 0.18),
          accent.withValues(alpha: 0.05),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.30),
          blurRadius: 16.0,
          spreadRadius: -2.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              big ? Icons.hub_outlined : Icons.bubble_chart_outlined,
              color: accent,
              size: big ? 22.0 : 18.0,
            ),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontSize: big ? 16.0 : 14.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8.0),
        for (final String b in bullets)
          Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 4.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    b,
                    style: TextStyle(
                      color: _kInk,
                      fontSize: 11.0,
                      fontFamily: 'monospace',
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

// =============================================================================
// 3. Event timeline (horizontal)
// =============================================================================
Widget _buildEventTimeline(List<ObjectEvent> events) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_kStageBgAlt, _kSurface],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kCoral.withValues(alpha: 0.4), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kCoral.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < events.length; i++)
            _timelineNode(events[i], i, i == events.length - 1),
        ],
      ),
    ),
  );
}

Widget _timelineNode(ObjectEvent ev, int index, bool last) {
  final bool isCreated = ev is ObjectCreated;
  final Color accent = isCreated ? _kTeal : _kCoral;
  final IconData icon = isCreated ? Icons.add_circle_outline : Icons.cancel_outlined;
  final String title = isCreated ? 'CREATE' : 'DISPOSE';
  final String detail = ev is ObjectCreated
      ? '${ev.className}\n${ev.library}'
      : '(no payload)';
  return Row(
    children: <Widget>[
      Column(
        children: <Widget>[
          Container(
            width: 144.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withValues(alpha: 0.22),
                  accent.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: accent, width: 1.2),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: accent.withValues(alpha: 0.25),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon, color: accent, size: 16.0),
                    SizedBox(width: 6.0),
                    Text(
                      title,
                      style: TextStyle(
                        color: accent,
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'T+$index',
                      style: TextStyle(
                        color: _kInkFaint,
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                Text(
                  detail,
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.0),
          // tick marker
          Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: accent.withValues(alpha: 0.55),
                  blurRadius: 8.0,
                ),
              ],
            ),
          ),
        ],
      ),
      if (!last)
        Container(
          width: 18.0,
          height: 2.0,
          margin: EdgeInsets.only(top: 70.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[_kTeal, _kCoral],
            ),
          ),
        ),
    ],
  );
}

// =============================================================================
// 4. Field anatomy
// =============================================================================
Widget _buildFieldAnatomy() {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #17):
  // `Row(crossAxisAlignment: stretch)` inside the outer SingleChildScrollView
  // (unbounded height) propagates infinite height to the Expanded children.
  // Wrap in IntrinsicHeight so the Row sizes to its tallest intrinsic child.
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child: _anatomyPanel(
          'ObjectCreated',
          _kCoral,
          Icons.add_box_outlined,
          <_FieldRow>[
            _FieldRow('object', 'final Object', 'The instrumented instance reference', true),
            _FieldRow('library', 'final String', 'A library Uri, e.g. package:flutter/widgets.dart', true),
            _FieldRow('className', 'final String', 'Runtime type name of the instrumented class', true),
          ],
          <String>['toMap() -> { object: { libraryName, className, eventType: created } }'],
        )),
        SizedBox(width: 14.0),
        Expanded(child: _anatomyPanel(
          'ObjectDisposed',
          _kAmber,
          Icons.indeterminate_check_box_outlined,
          <_FieldRow>[
            _FieldRow('object', 'final Object', 'The instance about to be released', true),
          ],
          <String>['toMap() -> { object: { eventType: disposed } }'],
        )),
      ],
    ),
  );
}

class _FieldRow {
  const _FieldRow(this.name, this.type, this.description, this.required);
  final String name;
  final String type;
  final String description;
  final bool required;
}

Widget _anatomyPanel(
  String title,
  Color accent,
  IconData icon,
  List<_FieldRow> fields,
  List<String> notes,
) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          accent.withValues(alpha: 0.18),
          _kSurface,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final _FieldRow f in fields) _anatomyField(f, accent),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: accent.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final String n in notes)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5),
                  child: Text(
                    n,
                    style: TextStyle(
                      color: _kInkSoft,
                      fontSize: 10.5,
                      fontFamily: 'monospace',
                      height: 1.4,
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

Widget _anatomyField(_FieldRow f, Color accent) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _kStageBg.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.35),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              f.name,
              style: TextStyle(
                color: _kInk,
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(width: 6.0),
            Text(
              f.type,
              style: TextStyle(
                color: accent,
                fontSize: 11.0,
                fontFamily: 'monospace',
              ),
            ),
            Spacer(),
            if (f.required) _chip('required', accent),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          f.description,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 11.0,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// 5. Library palette
// =============================================================================
class _LibScenario {
  const _LibScenario(this.lib, this.icon, this.classes, this.accent, this.lead);
  final String lib;
  final IconData icon;
  final List<String> classes;
  final Color accent;
  final String lead;
}

Widget _buildLibraryPalette() {
  final List<_LibScenario> scenarios = <_LibScenario>[
    _LibScenario(
      'dart:ui',
      Icons.image_outlined,
      <String>['Image', 'Picture'],
      _kTeal,
      'Engine-side handles instrumented automatically when memory tracking is on.',
    ),
    _LibScenario(
      'package:flutter/scheduler.dart',
      Icons.schedule_outlined,
      <String>['Ticker', 'TickerProvider'],
      _kCoral,
      'Frame-driver subscriptions; misbalanced create/dispose causes leaks.',
    ),
    _LibScenario(
      'package:flutter/widgets.dart',
      Icons.account_tree_outlined,
      <String>[
        'ScrollPositionWithSingleContext',
        'OverlayEntry',
        'FocusNode',
      ],
      _kAmber,
      'Container widgets that own resources beyond their build closure.',
    ),
    _LibScenario(
      'package:flutter/painting.dart',
      Icons.brush_outlined,
      <String>['NetworkImageProvider', 'ImageStream', 'PictureLayer'],
      _kViolet,
      'Image cache and rasterisation entries. Disposal frees GPU memory.',
    ),
    _LibScenario(
      'package:flutter/services.dart',
      Icons.settings_remote_outlined,
      <String>['IsolateNameServer', 'PlatformChannel'],
      _kSky,
      'Native interop primitives - leaks here cross the Dart/native boundary.',
    ),
    _LibScenario(
      'package:flutter/rendering.dart',
      Icons.architecture_outlined,
      <String>['RenderObject', 'Layer', 'PipelineOwner'],
      _kLime,
      'Render tree nodes; their lifecycles drive Layer disposal events.',
    ),
  ];
  return Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: <Widget>[
      for (final _LibScenario s in scenarios) _libraryCard(s),
    ],
  );
}

Widget _libraryCard(_LibScenario s) {
  return Container(
    width: 270.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          s.accent.withValues(alpha: 0.20),
          _kSurface.withValues(alpha: 0.95),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: s.accent.withValues(alpha: 0.7), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: s.accent.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: s.accent.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(s.icon, color: s.accent, size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                s.lib,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          s.lead,
          style: TextStyle(color: _kInkSoft, fontSize: 11.0, height: 1.4),
        ),
        SizedBox(height: 8.0),
        Wrap(children: <Widget>[for (final String c in s.classes) _chip(c, s.accent)]),
      ],
    ),
  );
}

// =============================================================================
// 6. toMap inspector
// =============================================================================
Widget _buildToMapInspector(
  ObjectCreated cImage,
  ObjectCreated cTicker,
  ObjectDisposed dImage,
  ObjectDisposed dTicker,
  Map<Object, Map<String, Object>> mapImage,
  Map<Object, Map<String, Object>> mapTicker,
  Map<Object, Map<String, Object>> mapDispImage,
  Map<Object, Map<String, Object>> mapDispTicker,
) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #17):
  // Same as _buildFieldAnatomy — wrap stretch-Rows in IntrinsicHeight so
  // they don't inherit infinite height from the outer SingleChildScrollView.
  return Column(
    children: <Widget>[
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _inspectorCard(
                'ObjectCreated -> dart:ui.Image',
                _kTeal,
                <String>[
                  '{',
                  '  <object>: {',
                  '    "libraryName": "${cImage.library}",',
                  '    "className": "${cImage.className}",',
                  '    "eventType": "created"',
                  '  }',
                  '}',
                ],
                'entries: ${mapImage.length}',
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: _inspectorCard(
                'ObjectCreated -> Ticker',
                _kCoral,
                <String>[
                  '{',
                  '  <object>: {',
                  '    "libraryName": "${cTicker.library}",',
                  '    "className": "${cTicker.className}",',
                  '    "eventType": "created"',
                  '  }',
                  '}',
                ],
                'entries: ${mapTicker.length}',
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 14.0),
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _inspectorCard(
                'ObjectDisposed -> dart:ui.Image',
                _kAmber,
                <String>[
                  '{',
                  '  <object>: {',
                  '    "eventType": "disposed"',
                  '  }',
                  '}',
                ],
                'entries: ${mapDispImage.length}',
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: _inspectorCard(
                'ObjectDisposed -> Ticker',
                _kViolet,
                <String>[
                  '{',
                  '  <object>: {',
                  '    "eventType": "disposed"',
                  '  }',
                  '}',
                ],
                'entries: ${mapDispTicker.length}',
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _inspectorCard(
  String title,
  Color accent,
  List<String> jsonLines,
  String footer,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_kStageBgAlt, _kSurface],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.16),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.data_object, color: accent, size: 18.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: accent.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final String line in jsonLines)
                Text(
                  line,
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    height: 1.35,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          footer,
          style: TextStyle(
            color: _kInkFaint,
            fontSize: 10.5,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// 7. Dispatch pipeline
// =============================================================================
class _PipelineStep {
  const _PipelineStep(this.label, this.detail, this.icon, this.color);
  final String label;
  final String detail;
  final IconData icon;
  final Color color;
}

Widget _buildDispatchPipeline() {
  final List<_PipelineStep> steps = <_PipelineStep>[
    _PipelineStep(
      'instrument',
      'Framework code\ncreates an object',
      Icons.build_outlined,
      _kTeal,
    ),
    _PipelineStep(
      'wrap',
      'ObjectCreated /\nObjectDisposed',
      Icons.inventory_2_outlined,
      _kSky,
    ),
    _PipelineStep(
      'gate',
      'kFlutterMemoryAllocations\nEnabled?',
      Icons.toggle_on_outlined,
      _kAmber,
    ),
    _PipelineStep(
      'dispatch',
      'FlutterMemoryAllocations\n.instance.dispatch...',
      Icons.send_outlined,
      _kViolet,
    ),
    _PipelineStep(
      'fanout',
      'Iterate _listeners,\ncatch exceptions',
      Icons.alt_route_outlined,
      _kCoral,
    ),
    _PipelineStep(
      'observe',
      'ObjectEventListener\ncallback fires',
      Icons.visibility_outlined,
      _kLime,
    ),
  ];
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_kSurface, _kStageBgAlt],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kLime.withValues(alpha: 0.5), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kLime.withValues(alpha: 0.10),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < steps.length; i++) ...<Widget>[
                _pipelineStep(steps[i], i + 1),
                if (i != steps.length - 1) _pipelineArrow(),
              ],
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kStageBg,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: _kInkFaint.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.lightbulb_outline, color: _kAmber, size: 18.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Listeners that throw during dispatch are caught and reported '
                  'via FlutterError.reportError - the dispatch loop continues so '
                  'a single bad listener never blocks others.',
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 11.5,
                    height: 1.4,
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

Widget _pipelineStep(_PipelineStep s, int index) {
  return Container(
    width: 150.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          s.color.withValues(alpha: 0.22),
          s.color.withValues(alpha: 0.06),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: s.color, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: s.color.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 22.0,
              height: 22.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: s.color,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$index',
                style: TextStyle(
                  color: _kStageBg,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(s.icon, color: s.color, size: 18.0),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          s.label.toUpperCase(),
          style: TextStyle(
            color: s.color,
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          s.detail,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _kInk,
            fontSize: 10.5,
            fontFamily: 'monospace',
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _pipelineArrow() {
  return Container(
    width: 36.0,
    height: 18.0,
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    alignment: Alignment.center,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 2.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[_kTeal, _kCoral],
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          child: Icon(Icons.play_arrow, color: _kCoral, size: 16.0),
        ),
      ],
    ),
  );
}

// =============================================================================
// 8. Lifecycle recipes (different from retest)
// =============================================================================
class _Recipe {
  const _Recipe({
    required this.title,
    required this.icon,
    required this.accent,
    required this.steps,
    required this.snippet,
    required this.tag,
  });
  final String title;
  final IconData icon;
  final Color accent;
  final List<String> steps;
  final String snippet;
  final String tag;
}

Widget _buildLifecycleRecipes() {
  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      title: 'Image cache eviction',
      icon: Icons.photo_library_outlined,
      accent: _kTeal,
      tag: 'painting',
      steps: <String>[
        '1. ImageProvider creates a ui.Image -> ObjectCreated fires',
        '2. The cache holds the entry while LRU score allows it',
        '3. Eviction calls Image.dispose() -> ObjectDisposed fires',
      ],
      snippet:
          'final ui.Image img = await frame.image;\n'
          '// engine -> ObjectCreated(library: dart:ui, className: Image)\n'
          'cache.maybeEvict(img);\n'
          '// engine -> ObjectDisposed(object: img)',
    ),
    _Recipe(
      title: 'Ticker subscription leak',
      icon: Icons.timer_outlined,
      accent: _kCoral,
      tag: 'scheduler',
      steps: <String>[
        '1. State.initState() creates a Ticker',
        '2. dispose() forgets to cancel -> no ObjectDisposed pulse',
        '3. Memory tracker reports unmatched create count',
      ],
      snippet:
          'class _S extends State<W> with TickerProviderStateMixin {\n'
          '  late final ticker = createTicker(_tick); // ObjectCreated\n'
          '  @override\n'
          '  void dispose() {\n'
          '    ticker.dispose(); // ObjectDisposed - REQUIRED\n'
          '    super.dispose();\n'
          '  }\n'
          '}',
    ),
    _Recipe(
      title: 'Scroll position observer',
      icon: Icons.swipe_vertical_outlined,
      accent: _kAmber,
      tag: 'widgets',
      steps: <String>[
        '1. ScrollController binds to a ScrollPosition',
        '2. ObjectCreated fires per ScrollPositionWithSingleContext',
        '3. detach() and dispose() emit a paired ObjectDisposed',
      ],
      snippet:
          'final ctrl = ScrollController();\n'
          '// each attach: ObjectCreated(\n'
          '//   className: ScrollPositionWithSingleContext)\n'
          'ctrl.dispose(); // releases positions, emits disposed events',
    ),
    _Recipe(
      title: 'GPU picture pool',
      icon: Icons.brush_outlined,
      accent: _kViolet,
      tag: 'rasterisation',
      steps: <String>[
        '1. Layer tree records a Picture via PictureRecorder',
        '2. Engine assigns it to a Layer -> ObjectCreated',
        '3. Layer rebuild releases old Picture -> ObjectDisposed',
      ],
      snippet:
          'final recorder = ui.PictureRecorder();\n'
          'final canvas = Canvas(recorder);\n'
          '// ... draw ...\n'
          'final ui.Picture pic = recorder.endRecording();\n'
          '// engine -> ObjectCreated(library: dart:ui, className: Picture)',
    ),
    _Recipe(
      title: 'Isolate bootstrap',
      icon: Icons.workspaces_outlined,
      accent: _kSky,
      tag: 'services',
      steps: <String>[
        '1. Spawning isolate creates SendPort lookup entries',
        '2. Each lookup entry is wrapped in ObjectCreated',
        '3. Isolate.kill() releases entries via ObjectDisposed',
      ],
      snippet:
          'final port = ReceivePort();\n'
          'IsolateNameServer.registerPortWithName(\n'
          '  port.sendPort, "bus");\n'
          '// ... later ...\n'
          'IsolateNameServer.removePortNameMapping("bus");',
    ),
    _Recipe(
      title: 'Network image stream',
      icon: Icons.cloud_outlined,
      accent: _kLime,
      tag: 'painting',
      steps: <String>[
        '1. NetworkImageProvider.resolve() creates an ImageStream',
        '2. Decoded ui.Image objects emit nested ObjectCreated events',
        '3. ImageStream.removeListener triggers ObjectDisposed cascade',
      ],
      snippet:
          'final stream = NetworkImage(url).resolve(\n'
          '  ImageConfiguration.empty);\n'
          'stream.addListener(ImageStreamListener(_onFrame));\n'
          '// release path: ObjectDisposed across the stream chain',
    ),
  ];
  return Column(
    children: <Widget>[
      for (int i = 0; i < recipes.length; i += 2)
        Padding(
          padding: EdgeInsets.only(bottom: 14.0),
          // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #17, P1):
          // Wrap stretch-Row in IntrinsicHeight to bound height.
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _recipeCard(recipes[i])),
                SizedBox(width: 14.0),
                if (i + 1 < recipes.length)
                  Expanded(child: _recipeCard(recipes[i + 1]))
                else
                  Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        ),
    ],
  );
}

Widget _recipeCard(_Recipe r) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          r.accent.withValues(alpha: 0.16),
          _kSurface,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: r.accent.withValues(alpha: 0.7), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: r.accent.withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                color: r.accent.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(r.icon, color: r.accent, size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                r.title,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _chip(r.tag, r.accent),
          ],
        ),
        SizedBox(height: 10.0),
        for (final String step in r.steps)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              step,
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: r.accent.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            r.snippet,
            style: TextStyle(
              color: _kInk,
              fontSize: 10.5,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// 9. Counters dashboard
// =============================================================================
Widget _buildCountersDashboard(
  List<ObjectEvent> stream,
  int created,
  int disposed,
) {
  // Tally per library among ObjectCreated events.
  final Map<String, int> perLib = <String, int>{};
  for (final ObjectEvent ev in stream) {
    if (ev is ObjectCreated) {
      perLib[ev.library] = (perLib[ev.library] ?? 0) + 1;
    }
  }
  final int maxLib = perLib.values.fold<int>(
    0,
    (int prev, int v) => v > prev ? v : prev,
  );
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_kStageBgAlt, _kSurface],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kTeal.withValues(alpha: 0.45), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kTeal.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: _counterTile('total events', stream.length, _kInk, Icons.list_alt)),
            SizedBox(width: 12.0),
            Expanded(child: _counterTile('created', created, _kTeal, Icons.add_circle_outline)),
            SizedBox(width: 12.0),
            Expanded(child: _counterTile('disposed', disposed, _kCoral, Icons.cancel_outlined)),
            SizedBox(width: 12.0),
            Expanded(child: _counterTile('libraries', perLib.length, _kAmber, Icons.layers_outlined)),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Created events grouped by library',
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 8.0),
        for (final MapEntry<String, int> entry in perLib.entries)
          _libraryBar(entry.key, entry.value, maxLib),
      ],
    ),
  );
}

Widget _counterTile(String label, int value, Color accent, IconData icon) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kStageBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.5),
        width: 1.0,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              label,
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 10.5,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          '$value',
          style: TextStyle(
            color: accent,
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _libraryBar(String lib, int count, int maxCount) {
  final double pct = maxCount == 0 ? 0.0 : count / maxCount;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                lib,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'x$count',
              style: TextStyle(
                color: _kTeal,
                fontSize: 11.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Container(
          height: 8.0,
          decoration: BoxDecoration(
            color: _kStageBg,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: _kInkFaint.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: pct.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[_kTeal, _kSky],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// 10. Pitfalls & cheat sheet
// =============================================================================
class _Pitfall {
  const _Pitfall(this.label, this.detail, this.icon, this.color);
  final String label;
  final String detail;
  final IconData icon;
  final Color color;
}

Widget _buildPitfalls() {
  final List<_Pitfall> pitfalls = <_Pitfall>[
    _Pitfall(
      'Long-lived references',
      'Do not store the object field anywhere - it pins the instance and '
          'defeats garbage collection.',
      Icons.warning_amber_outlined,
      _kCoral,
    ),
    _Pitfall(
      'Disabled in release',
      'kFlutterMemoryAllocationsEnabled is false in release. Listeners do not '
          'fire. Gate any allocation-driven analytics on it.',
      Icons.power_settings_new,
      _kAmber,
    ),
    _Pitfall(
      'Throwing listeners',
      'Exceptions in listeners are swallowed and reported via FlutterError - '
          'they will not crash the dispatch loop, but they pollute logs.',
      Icons.error_outline,
      _kViolet,
    ),
    _Pitfall(
      'Add/remove during dispatch',
      'Listeners added during dispatch are skipped for the in-flight event. '
          'Removed ones are nulled and defragmented after the loop.',
      Icons.sync_problem_outlined,
      _kSky,
    ),
  ];
  return Column(
    children: <Widget>[
      for (int i = 0; i < pitfalls.length; i += 2)
        Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #17, P1):
          // Wrap stretch-Row in IntrinsicHeight to bound height.
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _pitfallTile(pitfalls[i])),
                SizedBox(width: 12.0),
                if (i + 1 < pitfalls.length)
                  Expanded(child: _pitfallTile(pitfalls[i + 1]))
                else
                  Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        ),
    ],
  );
}

Widget _pitfallTile(_Pitfall p) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          p.color.withValues(alpha: 0.22),
          _kSurface,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: p.color.withValues(alpha: 0.6), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: p.color.withValues(alpha: 0.16),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            color: p.color.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(p.icon, color: p.color, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                p.label,
                style: TextStyle(
                  color: p.color,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                p.detail,
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 11.0,
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

Widget _buildCheatSheet() {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_kStageBgAlt, _kSurface, _kSurfaceAlt],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kTeal.withValues(alpha: 0.45), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kTeal.withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book_outlined, color: _kTeal, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                color: _kTeal,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _kvRow('class', 'ObjectEvent (abstract)', _kTeal),
        _kvRow('field', 'final Object object', _kInk),
        _kvRow('method', 'Map<Object, Map<String, Object>> toMap()', _kInk),
        _kvRow('subclass', 'ObjectCreated(library, className, object)', _kCoral),
        _kvRow('subclass', 'ObjectDisposed(object)', _kAmber),
        _kvRow('typedef', 'ObjectEventListener = void Function(ObjectEvent)', _kViolet),
        _kvRow('singleton', 'FlutterMemoryAllocations.instance', _kSky),
        _kvRow('flag', 'kFlutterMemoryAllocationsEnabled', _kLime),
        SizedBox(height: 10.0),
        Wrap(children: <Widget>[
          _chip('addListener', _kTeal),
          _chip('removeListener', _kCoral),
          _chip('hasListeners', _kAmber),
          _chip('dispatchObjectCreated', _kViolet),
          _chip('dispatchObjectDisposed', _kSky),
          _chip('dispatchObjectEvent', _kLime),
        ]),
      ],
    ),
  );
}

// =============================================================================
// Footer band
// =============================================================================
Widget _buildFooter() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _kTeal.withValues(alpha: 0.20),
          _kCoral.withValues(alpha: 0.20),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: _kInkFaint.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.memory_outlined, color: _kInk, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            'foundation/object_event_test.dart - dark slate studio variant. '
            'See retest/foundation/object_event_test.dart for the lavender '
            'companion piece.',
            style: TextStyle(
              color: _kInk,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}
