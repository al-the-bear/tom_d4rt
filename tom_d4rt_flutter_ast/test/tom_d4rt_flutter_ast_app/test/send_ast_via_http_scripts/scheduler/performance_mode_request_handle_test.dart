// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: PerformanceModeRequestHandle + DartPerformanceMode
// Deep Demo: Cockpit-style flight-deck dashboard explaining the handle
// lifecycle, the three performance modes, and the dispose() contract.
//
// IMPORTANT: This script is interpreted by D4rt. We never actually call
// SchedulerBinding.requestPerformanceMode or handle.dispose() at runtime
// inside this demo — every aspect is illustrated through STATIC visuals,
// gauge readouts, code-listing widgets and lifecycle diagrams.
import 'dart:ui' show DartPerformanceMode;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('==================================================');
  print(' COCKPIT INSTRUMENTATION — Performance Mode Handle');
  print('==================================================');
  print('Booting flight-deck visualization for');
  print('  - PerformanceModeRequestHandle (scheduler)');
  print('  - DartPerformanceMode (dart:ui)');
  print('All actions are simulated; no engine API is invoked.');

  // Cockpit palette — committed to one theme.
  final Color cockpitDeep = Color(0xFF0A1929);
  final Color cockpitPanel = Color(0xFF13273D);
  final Color cockpitFrame = Colors.blueGrey.shade700;
  final Color amberLamp = Colors.amber.shade400;
  final Color cyanLamp = Colors.cyan.shade400;
  final Color redLamp = Colors.red.shade400;
  final Color greenLamp = Colors.lightGreen.shade400;
  final Color brushedMetal = Colors.blueGrey.shade300;

  // ============================================================
  // SECTION 1: COCKPIT BRIEFING — Handle overview
  // ============================================================
  print('--- SECTION 1: Cockpit Briefing ---');

  final Widget briefing = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cockpitDeep, cockpitPanel],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: amberLamp, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: amberLamp.withValues(alpha: 0.18),
          blurRadius: 20.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flight_takeoff, color: amberLamp, size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'CAPTAIN BRIEFING — PerformanceModeRequestHandle',
              style: TextStyle(
                color: amberLamp,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'A PerformanceModeRequestHandle is your formal request slip to '
          'the Flutter scheduler asking the Dart VM to bias its scheduling '
          'toward a particular DartPerformanceMode for a finite scope.',
          style: TextStyle(color: brushedMetal, fontSize: 13.0, height: 1.45),
        ),
        SizedBox(height: 10.0),
        Text(
          'The handle is created by SchedulerBinding.instance'
          '.requestPerformanceMode(mode) and stays in effect until you '
          'call handle.dispose(). The scheduler tracks outstanding handles '
          'with reference counting — the engine remains in the requested '
          'mode while ANY handle for that mode is still alive.',
          style: TextStyle(color: brushedMetal, fontSize: 13.0, height: 1.45),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: cyanLamp.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: cyanLamp, size: 18.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Treat the handle like a fuel valve: opening it costs '
                  'energy. Always close it (dispose) the moment the high-'
                  'performance phase ends.',
                  style: TextStyle(
                    color: cyanLamp,
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: MODE SELECTOR PANEL — Three gauges
  // ============================================================
  print('--- SECTION 2: Mode Selector Panel ---');

  final List<Map<String, Object>> modeData = <Map<String, Object>>[
    <String, Object>{
      'mode': DartPerformanceMode.balanced,
      'lamp': greenLamp,
      'icon': Icons.balance,
      'title': 'BALANCED',
      'tagline': 'Default cruise',
      'gaugeValue': 0.5,
      'use': 'Steady-state UI, idle screens, normal scrolling.',
    },
    <String, Object>{
      'mode': DartPerformanceMode.latency,
      'lamp': redLamp,
      'icon': Icons.speed,
      'title': 'LATENCY',
      'tagline': 'Sharp inputs',
      'gaugeValue': 0.85,
      'use': 'Touch interactions, fling-scroll, animation curves.',
    },
    <String, Object>{
      'mode': DartPerformanceMode.throughput,
      'lamp': cyanLamp,
      'icon': Icons.show_chart,
      'title': 'THROUGHPUT',
      'tagline': 'Bulk power',
      'gaugeValue': 0.95,
      'use': 'Video decode, batch image processing, bulk parsing.',
    },
  ];

  final List<Widget> modeGauges = <Widget>[];
  for (var i = 0; i < modeData.length; i++) {
    final Map<String, Object> data = modeData[i];
    final DartPerformanceMode mode = data['mode'] as DartPerformanceMode;
    final Color lamp = data['lamp'] as Color;
    final IconData icon = data['icon'] as IconData;
    final String title = data['title'] as String;
    final String tagline = data['tagline'] as String;
    final double gaugeValue = data['gaugeValue'] as double;
    final String use = data['use'] as String;

    print(
      'Mode ${mode.name} (index ${mode.index}): tagline="$tagline" use="$use"',
    );

    modeGauges.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              cockpitPanel,
              cockpitDeep,
            ],
            radius: 1.1,
            center: Alignment.topLeft,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: lamp, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: lamp.withValues(alpha: 0.45),
              blurRadius: 18.0,
              offset: Offset(0.0, 0.0),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.7),
              blurRadius: 4.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: lamp, size: 28.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: lamp.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: lamp.withValues(alpha: 0.6)),
                  ),
                  child: Text(
                    'IDX ${mode.index}',
                    style: TextStyle(
                      color: lamp,
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                color: lamp,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                letterSpacing: 2.0,
              ),
            ),
            Text(
              tagline,
              style: TextStyle(
                color: brushedMetal,
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 14.0),
            // Half-disc gauge mock-up.
            Container(
              height: 90.0,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, cockpitDeep],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cockpitFrame),
                boxShadow: [
                  BoxShadow(
                    color: lamp.withValues(alpha: 0.3),
                    blurRadius: 12.0,
                    spreadRadius: -2.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'LOAD ${(gaugeValue * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: lamp,
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: cockpitFrame),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: gaugeValue,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              lamp.withValues(alpha: 0.6),
                              lamp,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                              color: lamp.withValues(alpha: 0.7),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              use,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: brushedMetal,
                fontSize: 11.0,
                height: 1.35,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'DartPerformanceMode.${mode.name}',
                style: TextStyle(
                  color: lamp,
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${modeGauges.length} mode gauge cards.');

  // ============================================================
  // SECTION 3: REQUEST → HANDLE → DISPOSE FLIGHT PATH
  // ============================================================
  print('--- SECTION 3: Lifecycle Flight Path ---');

  final List<Map<String, Object>> stages = <Map<String, Object>>[
    <String, Object>{
      'icon': Icons.touch_app,
      'label': '1. REQUEST',
      'sub': 'requestPerformanceMode(mode)',
      'color': amberLamp,
      'desc':
          'Pilot pushes the throttle. SchedulerBinding registers the request '
              'and returns a handle.',
    },
    <String, Object>{
      'icon': Icons.confirmation_number,
      'label': '2. HANDLE',
      'sub': 'PerformanceModeRequestHandle',
      'color': cyanLamp,
      'desc':
          'Engine is now biased toward the chosen mode. Hold this handle '
              'for the duration of the high-performance phase.',
    },
    <String, Object>{
      'icon': Icons.flight_land,
      'label': '3. DISPOSE',
      'sub': 'handle.dispose()',
      'color': greenLamp,
      'desc':
          'Phase complete. Handle is released; reference count for the mode '
              'decreases. When count hits zero, mode is cleared.',
    },
  ];

  final List<Widget> flightPathTiles = <Widget>[];
  for (var i = 0; i < stages.length; i++) {
    final Map<String, Object> s = stages[i];
    final IconData icon = s['icon'] as IconData;
    final String label = s['label'] as String;
    final String sub = s['sub'] as String;
    final Color color = s['color'] as Color;
    final String desc = s['desc'] as String;

    flightPathTiles.add(
      Container(
        width: 200.0,
        margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.16),
              cockpitDeep,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 12.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 26.0),
                SizedBox(width: 8.0),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                sub,
                style: TextStyle(
                  color: brushedMetal,
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              desc,
              style: TextStyle(
                color: brushedMetal,
                fontSize: 11.0,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
    if (i < stages.length - 1) {
      flightPathTiles.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(
            Icons.chevron_right,
            color: amberLamp,
            size: 32.0,
          ),
        ),
      );
    }
  }

  final Widget flightPath = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [cockpitPanel, cockpitDeep],
        radius: 1.4,
        center: Alignment.center,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cockpitFrame, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 12.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: amberLamp, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'FLIGHT PATH — request → handle → dispose',
              style: TextStyle(
                color: amberLamp,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: flightPathTiles,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: HANDLE STATE MACHINE
  // ============================================================
  print('--- SECTION 4: Handle State Machine ---');

  final Widget stateMachine = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cockpitDeep, Color(0xFF071421)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanLamp, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyanLamp.withValues(alpha: 0.25),
          blurRadius: 18.0,
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: cyanLamp, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'DartPerformanceMode — STATE MACHINE',
              style: TextStyle(
                color: cyanLamp,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildStateNode(
              'BALANCED',
              greenLamp,
              Icons.balance,
              cockpitDeep,
            ),
            Column(
              children: [
                Icon(Icons.swap_horiz, color: amberLamp, size: 28.0),
                Text(
                  'request(latency)',
                  style: TextStyle(
                    color: amberLamp,
                    fontSize: 9.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            _buildStateNode(
              'LATENCY',
              redLamp,
              Icons.speed,
              cockpitDeep,
            ),
            Column(
              children: [
                Icon(Icons.swap_horiz, color: amberLamp, size: 28.0),
                Text(
                  'request(throughput)',
                  style: TextStyle(
                    color: amberLamp,
                    fontSize: 9.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            _buildStateNode(
              'THROUGHPUT',
              cyanLamp,
              Icons.show_chart,
              cockpitDeep,
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: cockpitFrame),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transitions are NOT instantaneous switches; the engine '
                'aggregates outstanding handles per-mode and picks the '
                'highest-priority active mode.',
                style: TextStyle(
                  color: brushedMetal,
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'When the LAST handle for a mode is disposed, the engine '
                'returns to balanced (or to the next-active mode if other '
                'requests remain).',
                style: TextStyle(
                  color: brushedMetal,
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: "FORGOT TO DISPOSE" — leak warning panel
  // ============================================================
  print('--- SECTION 5: Forgotten Dispose Warning ---');

  final List<Map<String, String>> leakBullets = <Map<String, String>>[
    <String, String>{
      'h': 'Engine pinned',
      'd': 'The engine remains in the requested mode forever — no '
          'reference count ever reaches zero.',
    },
    <String, String>{
      'h': 'Power drain',
      'd': 'latency / throughput modes consume more energy. On battery, '
          'this shortens device lifetime.',
    },
    <String, String>{
      'h': 'Thermal headroom lost',
      'd': 'Sustained boost mode raises chip temperature; the OS may '
          'throttle other apps as a result.',
    },
    <String, String>{
      'h': 'Reference leak',
      'd': 'Each forgotten handle bumps the count permanently — even '
          'further dispose() calls from siblings cannot clear the mode.',
    },
  ];

  final List<Widget> leakRows = <Widget>[];
  for (var i = 0; i < leakBullets.length; i++) {
    final Map<String, String> b = leakBullets[i];
    leakRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              redLamp.withValues(alpha: 0.18),
              cockpitDeep,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: redLamp.withValues(alpha: 0.55)),
          boxShadow: [
            BoxShadow(
              color: redLamp.withValues(alpha: 0.25),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber, color: redLamp, size: 20.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    b['h']!,
                    style: TextStyle(
                      color: redLamp,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    b['d']!,
                    style: TextStyle(
                      color: brushedMetal,
                      fontSize: 11.0,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget leakPanel = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [
          Color(0xFF2A0A12),
          cockpitDeep,
        ],
        radius: 1.2,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: redLamp, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: redLamp.withValues(alpha: 0.45),
          blurRadius: 20.0,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 8.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.error_outline, color: redLamp, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'CAUTION — UNDISPOSED HANDLES',
              style: TextStyle(
                color: redLamp,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'If you obtain a PerformanceModeRequestHandle and lose the '
          'reference (or your widget is disposed without forwarding the '
          'call to handle.dispose()), you have created a performance-mode '
          'leak. Symptoms:',
          style: TextStyle(
            color: brushedMetal,
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 8.0),
        Column(children: leakRows),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: greenLamp.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: greenLamp, size: 20.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Mitigation: store the handle as a nullable field, '
                  'dispose it inside your State.dispose() / parent dispose '
                  'hook, and null it out so re-disposal is a no-op.',
                  style: TextStyle(
                    color: greenLamp,
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

  // ============================================================
  // SECTION 6: WHEN-TO-USE GUIDE — instructive paragraphs
  // ============================================================
  print('--- SECTION 6: When-To-Use Guide ---');

  final List<Map<String, Object>> guideEntries = <Map<String, Object>>[
    <String, Object>{
      'mode': DartPerformanceMode.balanced,
      'lamp': greenLamp,
      'icon': Icons.balance,
      'title': 'BALANCED — the default cruise altitude',
      'body': 'Use balanced for the vast majority of your application '
          'time. It signals to the Dart VM that nothing exceptional is '
          'happening: the GC may run, JIT may optimize, the CPU governor '
          'may down-clock. Idle screens, settings pages, and any code '
          'path where the user is reading rather than acting belong here. '
          'You almost never request balanced explicitly — it is the '
          'state the engine returns to when no other handle is alive.',
    },
    <String, Object>{
      'mode': DartPerformanceMode.latency,
      'lamp': redLamp,
      'icon': Icons.speed,
      'title': 'LATENCY — sharp inputs, smooth animation',
      'body': 'Request latency the moment a high-frequency interaction '
          'begins: gesture start, fling-scroll, drag-and-drop, focused '
          'text editing, or a custom animation curve where every frame '
          'must land in the 16ms (or 8ms on 120Hz) budget. The engine '
          'will avoid expensive batch work, prefer short GC pauses, and '
          'keep the CPU clocked up. Dispose the handle the instant the '
          'interaction ends (gesture release, animation status becomes '
          'completed/dismissed).',
    },
    <String, Object>{
      'mode': DartPerformanceMode.throughput,
      'lamp': cyanLamp,
      'icon': Icons.show_chart,
      'title': 'THROUGHPUT — bulk power for finite jobs',
      'body': 'Request throughput when you need maximum total work per '
          'unit time and the user is willing to tolerate a small input-'
          'lag jitter: video transcoding, large image filter chains, '
          'bulk JSON parsing on launch, scientific number-crunching. '
          'Latency-sensitive UI may briefly suffer, so do not hold this '
          'mode while the user is interacting — bracket it tightly '
          'around the bulk operation and dispose immediately after.',
    },
  ];

  final List<Widget> guideCards = <Widget>[];
  for (var i = 0; i < guideEntries.length; i++) {
    final Map<String, Object> g = guideEntries[i];
    final DartPerformanceMode mode = g['mode'] as DartPerformanceMode;
    final Color lamp = g['lamp'] as Color;
    final IconData icon = g['icon'] as IconData;
    final String title = g['title'] as String;
    final String body = g['body'] as String;

    guideCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lamp.withValues(alpha: 0.12),
              cockpitDeep,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: lamp.withValues(alpha: 0.6)),
          boxShadow: [
            BoxShadow(
              color: lamp.withValues(alpha: 0.18),
              blurRadius: 14.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: lamp, size: 22.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: lamp,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    '.${mode.name}',
                    style: TextStyle(
                      color: lamp,
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              body,
              style: TextStyle(
                color: brushedMetal,
                fontSize: 12.0,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: REFERENCE-COUNTED HANDLE STACK
  // ============================================================
  print('--- SECTION 7: Reference-Counted Handle Stack ---');

  final List<Map<String, Object>> stackSamples = <Map<String, Object>>[
    <String, Object>{
      'caption': 'Single handle alive — engine bias active.',
      'count': 1,
      'mode': DartPerformanceMode.latency,
      'color': redLamp,
    },
    <String, Object>{
      'caption': 'Three nested requests — refcount = 3.',
      'count': 3,
      'mode': DartPerformanceMode.latency,
      'color': redLamp,
    },
    <String, Object>{
      'caption': 'Two disposed, one remains — still biased.',
      'count': 1,
      'mode': DartPerformanceMode.latency,
      'color': redLamp,
    },
    <String, Object>{
      'caption': 'Final dispose — count hits zero, mode cleared.',
      'count': 0,
      'mode': DartPerformanceMode.balanced,
      'color': greenLamp,
    },
  ];

  final List<Widget> stackRows = <Widget>[];
  for (var i = 0; i < stackSamples.length; i++) {
    final Map<String, Object> s = stackSamples[i];
    final String caption = s['caption'] as String;
    final int count = s['count'] as int;
    final DartPerformanceMode mode = s['mode'] as DartPerformanceMode;
    final Color color = s['color'] as Color;

    final List<Widget> tokens = <Widget>[];
    for (var t = 0; t < count; t++) {
      tokens.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: 26.0,
          height: 36.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.9),
                color.withValues(alpha: 0.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.black, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.55),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.confirmation_number,
              color: Colors.black,
              size: 14.0,
            ),
          ),
        ),
      );
    }
    if (count == 0) {
      tokens.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: greenLamp.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: greenLamp),
          ),
          child: Text(
            'EMPTY',
            style: TextStyle(
              color: greenLamp,
              fontFamily: 'monospace',
              fontSize: 11.0,
            ),
          ),
        ),
      );
    }

    stackRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: cockpitFrame),
        ),
        child: Row(
          children: [
            Container(
              width: 70.0,
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: cockpitDeep,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: amberLamp.withValues(alpha: 0.5)),
              ),
              child: Center(
                child: Text(
                  'count: $count',
                  style: TextStyle(
                    color: amberLamp,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Row(children: tokens),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                caption,
                style: TextStyle(
                  color: brushedMetal,
                  fontSize: 11.5,
                  height: 1.35,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: color.withValues(alpha: 0.5)),
              ),
              child: Text(
                mode.name,
                style: TextStyle(
                  color: color,
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget refCountStack = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cockpitPanel, cockpitDeep],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amberLamp, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: amberLamp.withValues(alpha: 0.18),
          blurRadius: 14.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: amberLamp, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'REFERENCE-COUNTED HANDLE STACK',
              style: TextStyle(
                color: amberLamp,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Each requestPerformanceMode() bumps the per-mode counter. '
          'Each dispose() decrements it. Mode bias is active iff at '
          'least one handle remains alive.',
          style: TextStyle(
            color: brushedMetal,
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Column(children: stackRows),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: FLIGHT MANUAL — code listings
  // ============================================================
  print('--- SECTION 8: Flight Manual / Code Listings ---');

  final Widget codePanel = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF050B12), cockpitDeep],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanLamp.withValues(alpha: 0.7), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: cyanLamp.withValues(alpha: 0.2),
          blurRadius: 14.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: cyanLamp, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'FLIGHT MANUAL — code listings',
              style: TextStyle(
                color: cyanLamp,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeListing(
          'Acquire and dispose around an animation phase',
          '// During a high-stakes animation, request latency:\n'
              'PerformanceModeRequestHandle? _perfHandle;\n'
              '\n'
              'void onGestureStart() {\n'
              '  _perfHandle = SchedulerBinding.instance\n'
              '      .requestPerformanceMode(\n'
              '        DartPerformanceMode.latency,\n'
              '      );\n'
              '}\n'
              '\n'
              'void onGestureEnd() {\n'
              '  _perfHandle?.dispose();\n'
              '  _perfHandle = null;\n'
              '}',
          cyanLamp,
        ),
        SizedBox(height: 10.0),
        _buildCodeListing(
          'Bulk-throughput bracket',
          '// Long-running batch job — bias toward throughput:\n'
              'final handle = SchedulerBinding.instance\n'
              '    .requestPerformanceMode(\n'
              '      DartPerformanceMode.throughput,\n'
              '    );\n'
              'try {\n'
              '  // ... bulk work ...\n'
              '} finally {\n'
              '  handle.dispose();\n'
              '}',
          greenLamp,
        ),
        SizedBox(height: 10.0),
        _buildCodeListing(
          'Defensive null-out pattern',
          '// Guard against double-dispose by nulling the field:\n'
              'PerformanceModeRequestHandle? _h;\n'
              '\n'
              'void enter() {\n'
              '  _h ??= SchedulerBinding.instance\n'
              '      .requestPerformanceMode(\n'
              '        DartPerformanceMode.latency,\n'
              '      );\n'
              '}\n'
              '\n'
              'void leave() {\n'
              '  final h = _h;\n'
              '  _h = null;\n'
              '  h?.dispose();\n'
              '}',
          amberLamp,
        ),
        SizedBox(height: 10.0),
        _buildCodeListing(
          'Inspecting the enum statically',
          '// DartPerformanceMode is a plain enum — safe to read .index/.name:\n'
              'for (final m in DartPerformanceMode.values) {\n'
              '  print(\'\${m.name} -> \${m.index}\');\n'
              '}',
          redLamp,
        ),
      ],
    ),
  );

  // ============================================================
  // ENUM ENUMERATION (visual sanity readout)
  // ============================================================
  print('--- Enumerating DartPerformanceMode.values ---');
  final List<DartPerformanceMode> allModes = DartPerformanceMode.values;
  for (var i = 0; i < allModes.length; i++) {
    final DartPerformanceMode m = allModes[i];
    print('  values[$i] = DartPerformanceMode.${m.name} (idx ${m.index})');
  }

  final List<Widget> enumChips = <Widget>[];
  for (var i = 0; i < allModes.length; i++) {
    final DartPerformanceMode m = allModes[i];
    enumChips.add(
      Container(
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: cockpitDeep,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: amberLamp.withValues(alpha: 0.6)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.tag, color: amberLamp, size: 14.0),
            SizedBox(width: 6.0),
            Text(
              '${m.index}:${m.name}',
              style: TextStyle(
                color: amberLamp,
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget enumStrip = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: cockpitFrame),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DartPerformanceMode.values  (${allModes.length} entries)',
          style: TextStyle(
            color: brushedMetal,
            fontSize: 11.0,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 6.0),
        Wrap(children: enumChips),
      ],
    ),
  );

  print('Cockpit dashboard assembly complete; emitting widget tree.');

  // ============================================================
  // FINAL RETURN — full cockpit dashboard
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Cockpit master header
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          padding: EdgeInsets.all(22.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF000814),
                cockpitDeep,
                cockpitPanel,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: amberLamp, width: 2.0),
            boxShadow: [
              BoxShadow(
                color: amberLamp.withValues(alpha: 0.35),
                blurRadius: 28.0,
                offset: Offset(0.0, 8.0),
              ),
              BoxShadow(
                color: Colors.black,
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.airplanemode_active,
                color: amberLamp,
                size: 56.0,
              ),
              SizedBox(height: 8.0),
              Text(
                'PERFORMANCE-MODE COCKPIT',
                style: TextStyle(
                  color: amberLamp,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'PerformanceModeRequestHandle  ·  DartPerformanceMode',
                style: TextStyle(
                  color: brushedMetal,
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: cyanLamp),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shield, color: cyanLamp, size: 14.0),
                    SizedBox(width: 6.0),
                    Text(
                      'STATIC-DEMO MODE — engine APIs not invoked',
                      style: TextStyle(
                        color: cyanLamp,
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 8.0),
        _sectionHeading('1. Captain Briefing', amberLamp, brushedMetal),
        briefing,

        SizedBox(height: 12.0),
        _sectionHeading('2. Mode Selector Panel', amberLamp, brushedMetal),
        Wrap(alignment: WrapAlignment.center, children: modeGauges),

        SizedBox(height: 12.0),
        _sectionHeading('3. Lifecycle Flight Path', amberLamp, brushedMetal),
        flightPath,

        SizedBox(height: 12.0),
        _sectionHeading('4. Handle State Machine', amberLamp, brushedMetal),
        stateMachine,

        SizedBox(height: 12.0),
        _sectionHeading(
          '5. Forgot to Dispose? Caution Panel',
          amberLamp,
          brushedMetal,
        ),
        leakPanel,

        SizedBox(height: 12.0),
        _sectionHeading('6. When-To-Use Guide', amberLamp, brushedMetal),
        Column(children: guideCards),

        SizedBox(height: 12.0),
        _sectionHeading(
          '7. Reference-Counted Handle Stack',
          amberLamp,
          brushedMetal,
        ),
        refCountStack,

        SizedBox(height: 12.0),
        _sectionHeading('8. Flight Manual', amberLamp, brushedMetal),
        codePanel,

        SizedBox(height: 12.0),
        enumStrip,

        SizedBox(height: 16.0),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: cockpitDeep,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: cockpitFrame),
          ),
          child: Row(
            children: [
              Icon(Icons.flight_land, color: greenLamp, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Touchdown — cockpit demo concluded. All gauges static; '
                  'no handle was actually requested or disposed.',
                  style: TextStyle(
                    color: greenLamp,
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Top-level helpers
// ----------------------------------------------------------------

Widget _sectionHeading(String title, Color amber, Color metal) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          amber.withValues(alpha: 0.22),
          Colors.transparent,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      border: Border(
        left: BorderSide(color: amber, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(Icons.chevron_right, color: amber, size: 20.0),
        SizedBox(width: 6.0),
        Text(
          title,
          style: TextStyle(
            color: amber,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            height: 1.0,
            color: metal.withValues(alpha: 0.4),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateNode(
  String label,
  Color color,
  IconData icon,
  Color bg,
) {
  return Container(
    width: 92.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [
          color.withValues(alpha: 0.35),
          bg,
        ],
        radius: 1.1,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.55),
          blurRadius: 12.0,
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 26.0),
        SizedBox(height: 4.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
            letterSpacing: 1.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeListing(String title, String code, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.terminal, color: accent, size: 14.0),
              SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            code,
            style: TextStyle(
              color: accent,
              fontFamily: 'monospace',
              fontSize: 11.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}
