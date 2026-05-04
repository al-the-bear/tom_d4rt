// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for StreamBuilder<T> from Flutter widgets.
// Theme: cyan/teal flowing-water motif. No live subscriptions.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StreamBuilder Deep Demo executing');

  // ============================================================
  // PALETTE - cyan/teal flowing-water theme
  // ============================================================
  final Color tealDeep = Color(0xFF00695C);
  final Color tealMid = Color(0xFF00897B);
  final Color tealSoft = Color(0xFF4DB6AC);
  final Color cyanDeep = Color(0xFF006064);
  final Color cyanMid = Color(0xFF00ACC1);
  final Color cyanSoft = Color(0xFF4DD0E1);
  final Color slateBg = Color(0xFFE0F7FA);
  final Color slateInk = Color(0xFF263238);
  final Color codeBg = Color(0xFF0F1B1F);
  final Color codeInk = Color(0xFFB2EBF2);
  final Color amberWarn = Color(0xFFFFA000);
  final Color redErr = Color(0xFFE53935);
  final Color greenOk = Color(0xFF43A047);
  final Color greyIdle = Color(0xFF90A4AE);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    width: double.infinity,
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cyanDeep, tealMid, cyanSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: cyanDeep.withValues(alpha: 0.45),
          blurRadius: 22.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: tealSoft.withValues(alpha: 0.35),
          blurRadius: 38.0,
          offset: Offset(0.0, 18.0),
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
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(Icons.water_drop_outlined,
                  size: 36.0, color: Colors.white),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'StreamBuilder<T>',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Reactive widgets driven by stream events',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            'Flutter widgets - async pipe',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  Widget anatomyBox(String label, String sub, Color c, IconData icon) {
    return Container(
      width: 140.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [c.withValues(alpha: 0.85), c.withValues(alpha: 0.55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: c.withValues(alpha: 0.35),
            blurRadius: 10.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28.0),
          SizedBox(height: 6.0),
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 4.0),
          Text(sub,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white.withValues(alpha: 0.9))),
        ],
      ),
    );
  }

  Widget anatomyArrow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(Icons.arrow_forward, color: tealDeep, size: 22.0),
    );
  }

  final anatomyDiagram = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, slateBg],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanSoft, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyanMid.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: tealDeep,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text('2. Anatomy',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Text(
          'Each event emitted by the source Stream is wrapped into an AsyncSnapshot, '
          'piped to the builder function, which returns a fresh widget subtree.',
          style: TextStyle(fontSize: 13.0, color: slateInk),
        ),
        SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            anatomyBox('Stream<T>', 'event source', cyanDeep, Icons.water),
            anatomyArrow(),
            anatomyBox('AsyncSnapshot<T>', 'value + state', tealMid,
                Icons.bookmark_outline),
            anatomyArrow(),
            anatomyBox('builder fn', '(ctx, snap) =>', cyanMid,
                Icons.functions),
            anatomyArrow(),
            anatomyBox(
                'Widget tree', 'rendered output', tealSoft, Icons.widgets),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: AsyncSnapshot fields
  // ============================================================
  print('=== Section 3: AsyncSnapshot fields ===');

  Widget snapshotFieldRow(
      String name, String type, String desc, IconData icon, Color c) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: c.withValues(alpha: 0.4), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: c.withValues(alpha: 0.12),
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: c, size: 22.0),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: slateInk,
                            fontFamily: 'monospace')),
                    SizedBox(width: 8.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: c.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(type,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: c,
                              fontFamily: 'monospace')),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(desc,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: slateInk.withValues(alpha: 0.75))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final snapshotFields = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateBg, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealSoft.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tealSoft.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: tealMid,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text('3. AsyncSnapshot fields',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Text(
          'AsyncSnapshot<T> is the immutable record passed to the builder. '
          'It contains the latest emitted value, any error, and the connection state.',
          style: TextStyle(fontSize: 13.0, color: slateInk),
        ),
        SizedBox(height: 14.0),
        snapshotFieldRow('connectionState', 'ConnectionState',
            'lifecycle: none / waiting / active / done', Icons.timeline, tealDeep),
        snapshotFieldRow('data', 'T?', 'latest emitted value, or null',
            Icons.data_object, cyanMid),
        snapshotFieldRow('error', 'Object?',
            'last error emitted, if any', Icons.error_outline, redErr),
        snapshotFieldRow('stackTrace', 'StackTrace?',
            'stack for the error, when supplied', Icons.layers, amberWarn),
        snapshotFieldRow('hasData', 'bool',
            'true when data is non-null', Icons.check_circle_outline, greenOk),
        snapshotFieldRow('hasError', 'bool',
            'true when error is non-null', Icons.report_gmailerrorred, redErr),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: ConnectionState enum table
  // ============================================================
  print('=== Section 4: ConnectionState table ===');

  final connStates = [
    {
      'name': 'none',
      'desc': 'No stream provided (stream == null)',
      'example': 'StreamBuilder(stream: null, ...)',
      'color': greyIdle,
      'icon': Icons.power_off,
    },
    {
      'name': 'waiting',
      'desc': 'Subscribed; awaiting first event',
      'example': 'attached to a fresh Stream',
      'color': amberWarn,
      'icon': Icons.hourglass_empty,
    },
    {
      'name': 'active',
      'desc': 'At least one event received; stream open',
      'example': 'Stream emitting periodic ticks',
      'color': cyanMid,
      'icon': Icons.bolt,
    },
    {
      'name': 'done',
      'desc': 'Stream closed; no more events expected',
      'example': 'Stream emitted last value and closed',
      'color': greenOk,
      'icon': Icons.flag_circle_outlined,
    },
  ];

  final connRows = <Widget>[];
  connRows.add(Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    decoration: BoxDecoration(
      color: cyanDeep,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
            width: 110.0,
            child: Text('state',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0))),
        Expanded(
            child: Text('description',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0))),
        SizedBox(
            width: 220.0,
            child: Text('example',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0))),
      ],
    ),
  ));

  for (final s in connStates) {
    final c = s['color'] as Color;
    connRows.add(Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.08),
        border: Border(
          bottom: BorderSide(
              color: c.withValues(alpha: 0.25), width: 1.0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110.0,
            child: Row(
              children: [
                Icon(s['icon'] as IconData, color: c, size: 16.0),
                SizedBox(width: 6.0),
                Text(s['name'] as String,
                    style: TextStyle(
                        color: c,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        fontSize: 13.0)),
              ],
            ),
          ),
          Expanded(
            child: Text(s['desc'] as String,
                style: TextStyle(fontSize: 12.0, color: slateInk)),
          ),
          SizedBox(
            width: 220.0,
            child: Text(s['example'] as String,
                style: TextStyle(
                    fontSize: 11.0,
                    color: slateInk.withValues(alpha: 0.7),
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    ));
  }

  final connStateTable = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, slateBg],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanMid.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyanMid.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: cyanDeep,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text('4. ConnectionState lifecycle',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Text(
          'A snapshot moves through states in order: none -> waiting -> active -> done. '
          'StreamBuilder also keeps the last data and error across state transitions.',
          style: TextStyle(fontSize: 13.0, color: slateInk),
        ),
        SizedBox(height: 14.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Column(children: connRows),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Mocked snapshot states - six cards
  // ============================================================
  print('=== Section 5: Mocked snapshot cards ===');

  Widget mockSnapshotCard({
    required String stateLabel,
    required Color stateColor,
    required IconData stateIcon,
    required String dataText,
    required String errorText,
    required String hasDataText,
    required String hasErrorText,
    required String synopsis,
  }) {
    return Container(
      width: 230.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            stateColor.withValues(alpha: 0.18),
            stateColor.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
            color: stateColor.withValues(alpha: 0.55), width: 1.4),
        boxShadow: [
          BoxShadow(
            color: stateColor.withValues(alpha: 0.25),
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
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: stateColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(stateIcon, color: Colors.white, size: 16.0),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text('snapshot in $stateLabel',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: stateColor,
                        fontFamily: 'monospace')),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                  color: stateColor.withValues(alpha: 0.3), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('data: $dataText',
                    style: TextStyle(
                        fontSize: 11.0,
                        color: slateInk,
                        fontFamily: 'monospace')),
                SizedBox(height: 3.0),
                Text('error: $errorText',
                    style: TextStyle(
                        fontSize: 11.0,
                        color: slateInk.withValues(alpha: 0.8),
                        fontFamily: 'monospace')),
                SizedBox(height: 3.0),
                Text('hasData: $hasDataText',
                    style: TextStyle(
                        fontSize: 11.0,
                        color: slateInk.withValues(alpha: 0.8),
                        fontFamily: 'monospace')),
                SizedBox(height: 3.0),
                Text('hasError: $hasErrorText',
                    style: TextStyle(
                        fontSize: 11.0,
                        color: slateInk.withValues(alpha: 0.8),
                        fontFamily: 'monospace')),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Text(synopsis,
              style: TextStyle(
                  fontSize: 11.0,
                  color: slateInk.withValues(alpha: 0.75),
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  final mockedCards = <Widget>[
    mockSnapshotCard(
      stateLabel: 'none',
      stateColor: greyIdle,
      stateIcon: Icons.power_off,
      dataText: 'null',
      errorText: 'null',
      hasDataText: 'false',
      hasErrorText: 'false',
      synopsis: 'No stream attached. Builder still runs once.',
    ),
    mockSnapshotCard(
      stateLabel: 'waiting',
      stateColor: amberWarn,
      stateIcon: Icons.hourglass_empty,
      dataText: 'null',
      errorText: 'null',
      hasDataText: 'false',
      hasErrorText: 'false',
      synopsis: 'Subscribed - first event has not arrived yet.',
    ),
    mockSnapshotCard(
      stateLabel: 'waiting + initialData',
      stateColor: tealSoft,
      stateIcon: Icons.bookmark_added_outlined,
      dataText: '"Initial"',
      errorText: 'null',
      hasDataText: 'true',
      hasErrorText: 'false',
      synopsis: 'initialData seeds data before the first event.',
    ),
    mockSnapshotCard(
      stateLabel: 'active',
      stateColor: cyanMid,
      stateIcon: Icons.bolt,
      dataText: '17',
      errorText: 'null',
      hasDataText: 'true',
      hasErrorText: 'false',
      synopsis: 'Latest event delivered; stream still open.',
    ),
    mockSnapshotCard(
      stateLabel: 'active + error',
      stateColor: redErr,
      stateIcon: Icons.report_gmailerrorred,
      dataText: '17',
      errorText: '"socket lost"',
      hasDataText: 'true',
      hasErrorText: 'true',
      synopsis: 'Error replaces the value; data is the previous one.',
    ),
    mockSnapshotCard(
      stateLabel: 'done',
      stateColor: greenOk,
      stateIcon: Icons.flag_circle_outlined,
      dataText: '42',
      errorText: 'null',
      hasDataText: 'true',
      hasErrorText: 'false',
      synopsis: 'Stream closed - last data preserved in snapshot.',
    ),
  ];

  final mockedCardsSection = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, cyanSoft.withValues(alpha: 0.18)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanMid.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyanDeep.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: cyanMid,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text('5. Mocked snapshot states',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Text(
          'These six cards show what AsyncSnapshot looks like across the lifecycle. '
          'Values here are constants - the demo never subscribes to a live stream.',
          style: TextStyle(fontSize: 13.0, color: slateInk),
        ),
        SizedBox(height: 14.0),
        Wrap(children: mockedCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Live StreamBuilder<int> with Stream.empty + initialData
  // ============================================================
  print('=== Section 6: Live StreamBuilder<int> ===');

  final liveStreamBuilder = StreamBuilder<int>(
    stream: const Stream<int>.empty(),
    initialData: 42,
    builder: (BuildContext ctx, AsyncSnapshot<int> snap) {
      final int value = snap.data ?? 0;
      final String stateName = snap.connectionState.toString();
      return Container(
        width: 320.0,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [tealMid, cyanMid],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              color: tealMid.withValues(alpha: 0.4),
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
                Icon(Icons.water_drop, color: Colors.white, size: 20.0),
                SizedBox(width: 8.0),
                Text('current value',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0)),
              ],
            ),
            SizedBox(height: 10.0),
            Text('$value',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 42.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 6.0),
            Text('connectionState: $stateName',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 11.0,
                    fontFamily: 'monospace')),
            SizedBox(height: 4.0),
            Text('hasData: ${snap.hasData}, hasError: ${snap.hasError}',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 11.0,
                    fontFamily: 'monospace')),
          ],
        ),
      );
    },
  );

  final liveSection = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateBg, Colors.white],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealMid.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tealMid.withValues(alpha: 0.2),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: tealDeep,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text('6. Live StreamBuilder<int>',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Text(
          'A real StreamBuilder<int> with const Stream<int>.empty() and initialData: 42. '
          'The stream emits nothing, so the snapshot keeps the seeded data.',
          style: TextStyle(fontSize: 13.0, color: slateInk),
        ),
        SizedBox(height: 16.0),
        Center(child: liveStreamBuilder),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Builder skeleton with switch
  // ============================================================
  print('=== Section 7: Builder skeleton ===');

  final codeLines = <String>[
    'StreamBuilder<int>(',
    '  stream: source,',
    '  initialData: 0,',
    '  builder: (ctx, snap) {',
    '    if (snap.hasError) {',
    '      return ErrorBox(snap.error);',
    '    }',
    '    switch (snap.connectionState) {',
    '      case ConnectionState.none:',
    '        return Text(\'no stream\');',
    '      case ConnectionState.waiting:',
    '        return CircularProgressIndicator();',
    '      case ConnectionState.active:',
    '        return Text(\'live: \${snap.data}\');',
    '      case ConnectionState.done:',
    '        return Text(\'done: \${snap.data}\');',
    '    }',
    '  },',
    ');',
  ];

  final codeRows = <Widget>[];
  for (int i = 0; i < codeLines.length; i++) {
    codeRows.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 28.0,
          child: Text('${i + 1}',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 11.0,
                  color: codeInk.withValues(alpha: 0.5),
                  fontFamily: 'monospace')),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(codeLines[i],
              style: TextStyle(
                  fontSize: 12.0,
                  color: codeInk,
                  fontFamily: 'monospace',
                  height: 1.4)),
        ),
      ],
    ));
  }

  final builderSkeleton = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, slateBg],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealDeep.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: tealDeep,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text('7. Builder skeleton',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Text(
          'Always handle hasError first, then switch on connectionState. '
          'The switch is exhaustive over the four ConnectionState cases.',
          style: TextStyle(fontSize: 13.0, color: slateInk),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: codeBg,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 12.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: codeRows,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Compared with FutureBuilder
  // ============================================================
  print('=== Section 8: vs FutureBuilder ===');

  Widget compareCell(String text, Color c,
      {bool header = false, double width = 120.0}) {
    return SizedBox(
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: header ? c : c.withValues(alpha: 0.08),
          border: Border(
            right: BorderSide(
                color: cyanDeep.withValues(alpha: 0.2), width: 1.0),
          ),
        ),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: header ? 12.0 : 11.0,
                color: header ? Colors.white : slateInk,
                fontWeight: header ? FontWeight.bold : FontWeight.normal,
                fontFamily: header ? null : 'monospace')),
      ),
    );
  }

  final compareRows = <List<String>>[
    ['source type', 'Stream<T>', 'Future<T>'],
    ['emits', 'many events', 'one value'],
    ['initialData', 'yes', 'yes'],
    ['ConnectionState', 'none/waiting/active/done', 'none/waiting/done'],
    ['rebuild trigger', 'on each event', 'once on completion'],
    ['error path', 'onError of stream', 'rejected future'],
    ['typical use', 'realtime feeds', 'one-shot loads'],
  ];

  final compareWidgets = <Widget>[];
  compareWidgets.add(Row(children: [
    compareCell('feature', cyanDeep, header: true, width: 160.0),
    compareCell('StreamBuilder', tealDeep, header: true, width: 200.0),
    compareCell('FutureBuilder', cyanMid, header: true, width: 200.0),
  ]));
  for (final r in compareRows) {
    compareWidgets.add(Row(children: [
      compareCell(r[0], cyanDeep, width: 160.0),
      compareCell(r[1], tealDeep, width: 200.0),
      compareCell(r[2], cyanMid, width: 200.0),
    ]));
  }

  final compareSection = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, cyanSoft.withValues(alpha: 0.2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanDeep.withValues(alpha: 0.45), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyanDeep.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: cyanDeep,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text('8. StreamBuilder vs FutureBuilder',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Text(
          'StreamBuilder is the multi-shot sibling of FutureBuilder. The shape of the '
          'snapshot and builder is the same, but the lifecycle and rebuild cadence differ.',
          style: TextStyle(fontSize: 13.0, color: slateInk),
        ),
        SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Column(children: compareWidgets),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Use cases
  // ============================================================
  print('=== Section 9: Use cases ===');

  Widget useCaseCard(String title, String body, IconData icon, Color c) {
    return Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [c.withValues(alpha: 0.85), c.withValues(alpha: 0.55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: c.withValues(alpha: 0.35),
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
              Icon(icon, color: Colors.white, size: 22.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0)),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(body,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.95),
                  fontSize: 11.5,
                  height: 1.35)),
        ],
      ),
    );
  }

  final useCases = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateBg, Colors.white],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealMid.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tealMid.withValues(alpha: 0.2),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: tealMid,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text('9. Use cases',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Text(
          'StreamBuilder shines anywhere the UI must reflect a sequence of asynchronous '
          'updates: ticking prices, message streams, sensor feeds, websocket lifecycles.',
          style: TextStyle(fontSize: 13.0, color: slateInk),
        ),
        SizedBox(height: 14.0),
        Wrap(
          children: <Widget>[
            useCaseCard('Realtime price ticker',
                'Render last bid/ask as new ticks arrive on a market feed.',
                Icons.show_chart, cyanDeep),
            useCaseCard('Chat messages',
                'Append new messages to the list as they stream from the server.',
                Icons.chat_bubble_outline, tealMid),
            useCaseCard('Sensor feed',
                'Visualise gyroscope/accel readings without manual setState.',
                Icons.sensors, cyanMid),
            useCaseCard('Websocket status',
                'Map socket state events to a coloured connection badge.',
                Icons.wifi_tethering, tealDeep),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  Widget footgunRow(String title, String body, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: redErr.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: redErr, width: 4.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: redErr, size: 22.0),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: redErr)),
                SizedBox(height: 4.0),
                Text(body,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: slateInk.withValues(alpha: 0.8),
                        height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final footgunSection = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, redErr.withValues(alpha: 0.07)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: redErr.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: redErr.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: redErr,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text('10. Footguns',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Text(
          'Common pitfalls that quietly break StreamBuilder-based UIs. '
          'They look fine at first run and surface only under load or on reroute.',
          style: TextStyle(fontSize: 13.0, color: slateInk),
        ),
        SizedBox(height: 14.0),
        footgunRow(
          'Rebuilding parents on every event',
          'If the parent widget rebuilds the StreamBuilder on every frame, the '
              'underlying subscription is recreated and you lose buffered events.',
          Icons.repeat,
        ),
        footgunRow(
          'Missing initialData -> waiting flicker',
          'Without initialData the first frame is in waiting state - users see a '
              'spinner that vanishes one frame later. Provide initialData when known.',
          Icons.flash_off,
        ),
        footgunRow(
          'Forgetting to handle hasError',
          'If you only check connectionState, errors are dropped silently. Always '
              'branch on hasError before reading data.',
          Icons.report_gmailerrorred,
        ),
        footgunRow(
          'Leaking subscriptions on reference change',
          'If the stream: argument is a freshly-built object every build, the '
              'previous subscription is cancelled and a new one is opened. Keep the '
              'stream stable in a State or controller.',
          Icons.cleaning_services_outlined,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Decision matrix
  // ============================================================
  print('=== Section 11: Decision matrix ===');

  Widget decisionCell(String text, Color c,
      {bool header = false, double width = 130.0}) {
    return SizedBox(
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        decoration: BoxDecoration(
          color: header ? c : c.withValues(alpha: 0.08),
          border: Border(
            right: BorderSide(
                color: cyanDeep.withValues(alpha: 0.2), width: 1.0),
            bottom: BorderSide(
                color: cyanDeep.withValues(alpha: 0.2), width: 1.0),
          ),
        ),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: header ? 12.0 : 11.0,
                color: header ? Colors.white : slateInk,
                fontWeight: header ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }

  final decisionRows = <List<String>>[
    ['multiple values over time', 'yes', 'yes', 'yes'],
    ['simple value swap', 'overkill', 'good', 'best'],
    ['domain object as source', 'good', 'best', 'limited'],
    ['cross-widget broadcast', 'yes', 'manual', 'manual'],
    ['rebuild granularity', 'subtree', 'subtree', 'leaf'],
    ['error channel', 'first-class', 'manual', 'manual'],
    ['cancellation', 'stream lifecycle', 'dispose', 'dispose'],
  ];

  final decisionWidgets = <Widget>[];
  decisionWidgets.add(Row(children: [
    decisionCell('scenario', cyanDeep, header: true, width: 200.0),
    decisionCell('Stream', tealDeep, header: true),
    decisionCell('ChangeNotifier', tealMid, header: true),
    decisionCell('ValueListenable', cyanMid, header: true),
  ]));
  for (final row in decisionRows) {
    decisionWidgets.add(Row(children: [
      decisionCell(row[0], cyanDeep, width: 200.0),
      decisionCell(row[1], tealDeep),
      decisionCell(row[2], tealMid),
      decisionCell(row[3], cyanMid),
    ]));
  }

  final decisionMatrix = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, slateBg],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanDeep.withValues(alpha: 0.45), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyanDeep.withValues(alpha: 0.2),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: cyanDeep,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text('11. Decision matrix',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10.0),
        Text(
          'Stream is one of several reactive sources. ChangeNotifier and '
          'ValueListenable are simpler when state is local to one widget tree.',
          style: TextStyle(fontSize: 13.0, color: slateInk),
        ),
        SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Column(children: decisionWidgets),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Recap
  // ============================================================
  print('=== Section 12: Recap ===');

  Widget recapBullet(String text, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 18.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    height: 1.4)),
          ),
        ],
      ),
    );
  }

  final recapCard = Container(
    width: double.infinity,
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, cyanDeep, tealMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: cyanSoft.withValues(alpha: 0.3),
          blurRadius: 30.0,
          offset: Offset(0.0, 16.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize_outlined, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text('12. Recap',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
          ],
        ),
        SizedBox(height: 14.0),
        recapBullet(
            'StreamBuilder<T> rebuilds when its Stream emits an event.',
            Icons.water_drop),
        recapBullet(
            'AsyncSnapshot<T> carries data, error, and connectionState.',
            Icons.bookmark_outline),
        recapBullet(
            'Lifecycle: none -> waiting -> active -> done. Provide initialData '
                'to avoid the waiting flicker.',
            Icons.timeline),
        recapBullet(
            'Always branch on hasError before reading data; switch on '
                'connectionState for the rest.',
            Icons.alt_route),
        recapBullet(
            'Keep the stream reference stable across rebuilds to avoid '
                'subscription churn.',
            Icons.lock_outline),
        recapBullet(
            'Reach for Stream when the source is multi-shot, broadcast, or '
                'externally produced; ChangeNotifier and ValueListenable cover '
                'simpler local cases.',
            Icons.compare_arrows),
      ],
    ),
  );

  // ============================================================
  // FINAL SCAFFOLD
  // ============================================================
  print('Assembling final scaffold');

  return Scaffold(
    backgroundColor: slateBg,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleBanner,
          anatomyDiagram,
          snapshotFields,
          connStateTable,
          mockedCardsSection,
          liveSection,
          builderSkeleton,
          compareSection,
          useCases,
          footgunSection,
          decisionMatrix,
          recapCard,
        ],
      ),
    ),
  );
}
