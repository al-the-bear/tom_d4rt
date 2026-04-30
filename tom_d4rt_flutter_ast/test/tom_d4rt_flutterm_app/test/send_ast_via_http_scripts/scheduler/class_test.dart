// ignore_for_file: avoid_print
// D4rt deep-demo: SchedulerBinding & Phases — Steel / Iron theme, prefix sk
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget skSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF455A64), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Color(0xFF263238))),
        ),
      ],
    ),
  );
}

Widget skChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12.0)),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget skInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 150.0,
          child: Text(label, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xFF263238)))),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 12.0, color: Color(0xFF546E7A)))),
      ],
    ),
  );
}

Widget skCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(color: Color(0xFFECEFF1), borderRadius: BorderRadius.circular(6.0)),
    child: Text(code, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF263238))),
  );
}

Widget skPhaseBox(String label, Color color, String desc) {
  return Container(
    margin: EdgeInsets.only(bottom: 6.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
    ),
    child: Row(
      children: [
        Container(
          width: 12.0, height: 12.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                  fontFamily: 'monospace', color: color)),
              Text(desc, style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A))),
            ],
          ),
        ),
      ],
    ),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ── Section 1: Title ──────────────────────────────────────────
  print('\n[1] SchedulerBinding & Phases Deep Demo');
  print('  Frame scheduling, phases, callbacks, timing');

  final skTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF455A64), Color(0xFF263238)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.schedule, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('SchedulerBinding & Phases',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Frame scheduling, callback phases, and timing in the Flutter engine',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFB0BEC5))),
        SizedBox(height: 8.0),
        Wrap(children: [
          skChip('SchedulerPhase', Color(0xFF607D8B)),
          skChip('Callbacks', Color(0xFF546E7A)),
          skChip('Frame Timing', Color(0xFF455A64)),
          skChip('Lifecycle', Color(0xFF37474F)),
        ]),
      ],
    ),
  );

  // ── Section 2: SchedulerPhase ────────────────────────────────
  print('\n[2] SchedulerPhase Enum');
  for (final sp in SchedulerPhase.values) {
    print('  ${sp.name}: index=${sp.index}');
  }

  final phases = <Map<String, dynamic>>[
    {'value': SchedulerPhase.idle, 'color': Color(0xFF78909C),
     'desc': 'No frame in progress; between frames'},
    {'value': SchedulerPhase.transientCallbacks, 'color': Color(0xFF607D8B),
     'desc': 'Processing animation callbacks (tickers)'},
    {'value': SchedulerPhase.midFrameMicrotasks, 'color': Color(0xFF546E7A),
     'desc': 'Processing microtasks between transient and persistent'},
    {'value': SchedulerPhase.persistentCallbacks, 'color': Color(0xFF455A64),
     'desc': 'Processing layout and paint callbacks'},
    {'value': SchedulerPhase.postFrameCallbacks, 'color': Color(0xFF37474F),
     'desc': 'Processing post-frame cleanup callbacks'},
  ];

  final skPhaseSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      children: phases.map((p) {
        final sp = p['value'] as SchedulerPhase;
        return skPhaseBox(sp.name, p['color'] as Color, p['desc'] as String);
      }).toList(),
    ),
  );

  // ── Section 3: Frame Lifecycle ───────────────────────────────
  print('\n[3] Frame Lifecycle');
  print('  idle → transient → microtasks → persistent → postFrame → idle');

  final lifecycleSteps = <Map<String, dynamic>>[
    {'step': '1', 'phase': 'idle', 'icon': Icons.pause, 'color': Color(0xFF78909C)},
    {'step': '2', 'phase': 'transientCallbacks', 'icon': Icons.animation, 'color': Color(0xFF607D8B)},
    {'step': '3', 'phase': 'midFrameMicrotasks', 'icon': Icons.memory, 'color': Color(0xFF546E7A)},
    {'step': '4', 'phase': 'persistentCallbacks', 'icon': Icons.layers, 'color': Color(0xFF455A64)},
    {'step': '5', 'phase': 'postFrameCallbacks', 'icon': Icons.cleaning_services, 'color': Color(0xFF37474F)},
    {'step': '6', 'phase': '→ idle', 'icon': Icons.loop, 'color': Color(0xFF78909C)},
  ];

  final skLifecycleSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      children: lifecycleSteps.map((ls) {
        return Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Row(
            children: [
              Container(
                width: 28.0, height: 28.0,
                decoration: BoxDecoration(color: ls['color'] as Color, shape: BoxShape.circle),
                child: Center(child: Text(ls['step'] as String,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0))),
              ),
              SizedBox(width: 8.0),
              Icon(ls['icon'] as IconData, color: ls['color'] as Color, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(ls['phase'] as String,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600,
                        fontFamily: 'monospace', color: ls['color'] as Color)),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 4: Transient Callbacks ───────────────────────────
  print('\n[4] Transient Callbacks (Animations)');
  print('  One-shot callbacks consumed each frame');
  print('  Used by Ticker for AnimationController');

  final skTransientSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.animation, color: Color(0xFF607D8B), size: 24.0),
            SizedBox(width: 8.0),
            Text('One-shot animation callbacks',
                style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF263238))),
          ],
        ),
        SizedBox(height: 10.0),
        skInfoRow('Registered via:', 'scheduleFrameCallback()'),
        skInfoRow('Cancelled via:', 'cancelFrameCallbackWithId()'),
        skInfoRow('Consumed:', 'Yes — removed after firing'),
        skInfoRow('Primary user:', 'Ticker (AnimationController)'),
        skInfoRow('Receives:', 'Duration timeStamp'),
        SizedBox(height: 8.0),
        skCodeBlock('final id = SchedulerBinding.instance\n  .scheduleFrameCallback((Duration timeStamp) {\n    print(\'Frame at: \$timeStamp\');\n  });\n\n// Cancel if needed:\nSchedulerBinding.instance\n  .cancelFrameCallbackWithId(id);'),
      ],
    ),
  );

  // ── Section 5: Persistent Callbacks ──────────────────────────
  print('\n[5] Persistent Callbacks (Build/Layout/Paint)');
  print('  Called every frame, never removed');
  print('  Used by WidgetsBinding for build phase');

  final skPersistentSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: Color(0xFF455A64), size: 24.0),
            SizedBox(width: 8.0),
            Text('Permanent per-frame callbacks',
                style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF263238))),
          ],
        ),
        SizedBox(height: 10.0),
        skInfoRow('Registered via:', 'addPersistentFrameCallback()'),
        skInfoRow('Removed:', 'Never — permanent'),
        skInfoRow('Primary user:', 'WidgetsBinding.drawFrame'),
        skInfoRow('Receives:', 'Duration timeStamp'),
        skInfoRow('Purpose:', 'Build, layout, and paint phases'),
        SizedBox(height: 8.0),
        skCodeBlock('SchedulerBinding.instance\n  .addPersistentFrameCallback((Duration timeStamp) {\n    // Called every frame\n    // Build → Layout → Paint pipeline\n  });'),
      ],
    ),
  );

  // ── Section 6: Post-Frame Callbacks ──────────────────────────
  print('\n[6] Post-Frame Callbacks');
  print('  Cleanup after frame completes');
  print('  One-shot, like transient but after rendering');

  final skPostFrameSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.cleaning_services, color: Color(0xFF37474F), size: 24.0),
            SizedBox(width: 8.0),
            Text('One-shot post-render cleanup',
                style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF263238))),
          ],
        ),
        SizedBox(height: 10.0),
        skInfoRow('Registered via:', 'addPostFrameCallback()'),
        skInfoRow('Consumed:', 'Yes — one-shot'),
        skInfoRow('Timing:', 'After persistent callbacks'),
        skInfoRow('Common use:', 'Measure widgets, navigate'),
        SizedBox(height: 8.0),
        skCodeBlock('SchedulerBinding.instance\n  .addPostFrameCallback((_) {\n    // Safe to read widget sizes\n    final size = key.currentContext?.size;\n    print(\'Widget size: \$size\');\n  });'),
      ],
    ),
  );

  // ── Section 7: Callback Comparison ───────────────────────────
  print('\n[7] Callback Type Comparison');

  final callbackTypes = <Map<String, dynamic>>[
    {'type': 'Transient', 'oneShot': true, 'when': 'Before layout',
     'color': Color(0xFF607D8B), 'use': 'Animations'},
    {'type': 'Persistent', 'oneShot': false, 'when': 'Every frame',
     'color': Color(0xFF455A64), 'use': 'Build pipeline'},
    {'type': 'Post-frame', 'oneShot': true, 'when': 'After paint',
     'color': Color(0xFF37474F), 'use': 'Measurement'},
  ];

  final skCallbackCompareSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      children: [
        // Header row
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              SizedBox(width: 80.0, child: Text('Type', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF263238)))),
              SizedBox(width: 60.0, child: Text('One-shot?', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF263238)))),
              SizedBox(width: 80.0, child: Text('When', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF263238)))),
              Expanded(child: Text('Purpose', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF263238)))),
            ],
          ),
        ),
        ...callbackTypes.map((ct) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 4.0),
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: [
                SizedBox(width: 80.0, child: Text(ct['type'] as String,
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: ct['color'] as Color))),
                SizedBox(width: 60.0, child: Text((ct['oneShot'] as bool) ? 'Yes' : 'No',
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A)))),
                SizedBox(width: 80.0, child: Text(ct['when'] as String,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A)))),
                Expanded(child: Text(ct['use'] as String,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A)))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 8: SchedulerBinding Key Methods ──────────────────
  print('\n[8] SchedulerBinding Key Methods');

  final keyMethods = <Map<String, dynamic>>[
    {'method': 'scheduleFrame()', 'color': Color(0xFF78909C),
     'desc': 'Request a new frame be scheduled'},
    {'method': 'scheduleForcedFrame()', 'color': Color(0xFF607D8B),
     'desc': 'Schedule frame even when lifecycle paused'},
    {'method': 'scheduleFrameCallback()', 'color': Color(0xFF546E7A),
     'desc': 'Register a transient frame callback'},
    {'method': 'addPersistentFrameCallback()', 'color': Color(0xFF455A64),
     'desc': 'Register a permanent per-frame callback'},
    {'method': 'addPostFrameCallback()', 'color': Color(0xFF37474F),
     'desc': 'Register a post-frame cleanup callback'},
    {'method': 'addTimingsCallback()', 'color': Color(0xFF263238),
     'desc': 'Receive FrameTiming data for performance'},
  ];

  final skMethodsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      children: keyMethods.map((km) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 6.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border(left: BorderSide(color: km['color'] as Color, width: 3.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(km['method'] as String,
                  style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                      fontFamily: 'monospace', color: km['color'] as Color)),
              Text(km['desc'] as String, style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 9: FrameTiming ───────────────────────────────────
  print('\n[9] FrameTiming — Performance Metrics');

  final timingPhases = <Map<String, dynamic>>[
    {'phase': 'vsyncStart', 'desc': 'When vsync signal arrived', 'color': Color(0xFF78909C)},
    {'phase': 'buildStart', 'desc': 'When build phase began', 'color': Color(0xFF607D8B)},
    {'phase': 'buildFinish', 'desc': 'When build phase ended', 'color': Color(0xFF546E7A)},
    {'phase': 'rasterStart', 'desc': 'When rasterization started on GPU', 'color': Color(0xFF455A64)},
    {'phase': 'rasterFinish', 'desc': 'When rasterization completed', 'color': Color(0xFF37474F)},
  ];

  final skTimingSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Detailed timing breakdown for each rendered frame',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF263238))),
        SizedBox(height: 10.0),
        // Timeline visualization
        Container(
          width: double.infinity,
          height: 60.0,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Stack(
            children: [
              Positioned(left: 10.0, top: 25.0, right: 10.0,
                child: Container(height: 2.0, color: Color(0xFFB0BEC5))),
              // vsync
              Positioned(left: 10.0, top: 15.0,
                child: Container(width: 12.0, height: 12.0,
                  decoration: BoxDecoration(color: Color(0xFF78909C), shape: BoxShape.circle))),
              Positioned(left: 2.0, top: 35.0,
                child: Text('vsync', style: TextStyle(fontSize: 7.0, color: Color(0xFF546E7A)))),
              // build start
              Positioned(left: 60.0, top: 15.0,
                child: Container(width: 12.0, height: 12.0,
                  decoration: BoxDecoration(color: Color(0xFF607D8B), shape: BoxShape.circle))),
              // build end
              Positioned(left: 120.0, top: 15.0,
                child: Container(width: 12.0, height: 12.0,
                  decoration: BoxDecoration(color: Color(0xFF546E7A), shape: BoxShape.circle))),
              Positioned(left: 65.0, top: 35.0,
                child: Text('build phase', style: TextStyle(fontSize: 7.0, color: Color(0xFF546E7A)))),
              // raster start
              Positioned(left: 180.0, top: 15.0,
                child: Container(width: 12.0, height: 12.0,
                  decoration: BoxDecoration(color: Color(0xFF455A64), shape: BoxShape.circle))),
              // raster end
              Positioned(left: 260.0, top: 15.0,
                child: Container(width: 12.0, height: 12.0,
                  decoration: BoxDecoration(color: Color(0xFF37474F), shape: BoxShape.circle))),
              Positioned(left: 190.0, top: 35.0,
                child: Text('raster phase', style: TextStyle(fontSize: 7.0, color: Color(0xFF546E7A)))),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        ...timingPhases.map((tp) {
          return Padding(
            padding: EdgeInsets.only(bottom: 3.0),
            child: Row(
              children: [
                Container(width: 8.0, height: 8.0,
                  decoration: BoxDecoration(color: tp['color'] as Color, shape: BoxShape.circle)),
                SizedBox(width: 8.0),
                SizedBox(width: 90.0,
                  child: Text(tp['phase'] as String,
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, fontFamily: 'monospace', color: tp['color'] as Color))),
                Expanded(child: Text(tp['desc'] as String,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A)))),
              ],
            ),
          );
        }),
        SizedBox(height: 8.0),
        skCodeBlock('SchedulerBinding.instance.addTimingsCallback(\n  (List<FrameTiming> timings) {\n    for (final t in timings) {\n      print(\'Build: \${t.buildDuration}\');\n      print(\'Raster: \${t.rasterDuration}\');\n    }\n  },\n);'),
      ],
    ),
  );

  // ── Section 10: AppLifecycleState ────────────────────────────
  print('\n[10] AppLifecycleState & Scheduler');
  for (final state in AppLifecycleState.values) {
    print('  ${state.name}: index=${state.index}');
  }

  final appStates = <Map<String, dynamic>>[
    {'state': AppLifecycleState.resumed, 'icon': Icons.play_circle_outline,
     'color': Color(0xFF43A047), 'desc': 'App visible, responding to input'},
    {'state': AppLifecycleState.inactive, 'icon': Icons.pause_circle_outline,
     'color': Color(0xFFFFA726), 'desc': 'App visible but not receiving input'},
    {'state': AppLifecycleState.paused, 'icon': Icons.stop_circle_outlined,
     'color': Color(0xFFEF5350), 'desc': 'App not visible, may be suspended'},
    {'state': AppLifecycleState.detached, 'icon': Icons.close,
     'color': Color(0xFF78909C), 'desc': 'Still hosted but detached from views'},
    {'state': AppLifecycleState.hidden, 'icon': Icons.visibility_off,
     'color': Color(0xFF455A64), 'desc': 'All views hidden'},
  ];

  final skLifecycleStateSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scheduler adjusts frame scheduling based on app lifecycle',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF263238))),
        SizedBox(height: 8.0),
        ...appStates.map((appS) {
          final state = appS['state'] as AppLifecycleState;
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 4.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
            child: Row(
              children: [
                Icon(appS['icon'] as IconData, color: appS['color'] as Color, size: 20.0),
                SizedBox(width: 8.0),
                SizedBox(width: 70.0, child: Text(state.name,
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: appS['color'] as Color))),
                Expanded(child: Text(appS['desc'] as String,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A)))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 11: Frame Scheduling Flow ────────────────────────
  print('\n[11] Frame Scheduling Flow');
  print('  scheduleFrame() → engine callback → handleBeginFrame → handleDrawFrame');

  final flowSteps = <Map<String, dynamic>>[
    {'step': 'scheduleFrame()', 'desc': 'Request engine schedule a vsync', 'color': Color(0xFF78909C)},
    {'step': 'handleBeginFrame()', 'desc': 'Process transient callbacks + microtasks', 'color': Color(0xFF607D8B)},
    {'step': 'handleDrawFrame()', 'desc': 'Process persistent + post-frame callbacks', 'color': Color(0xFF455A64)},
    {'step': 'Frame complete', 'desc': 'Return to idle, display rendered frame', 'color': Color(0xFF37474F)},
  ];

  final skFlowSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      children: flowSteps.asMap().entries.map((entry) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Container(
                width: 28.0, height: 28.0,
                decoration: BoxDecoration(color: entry.value['color'] as Color, shape: BoxShape.circle),
                child: Center(child: Text('${entry.key + 1}',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.0))),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.value['step'] as String,
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                              fontFamily: 'monospace', color: entry.value['color'] as Color)),
                      Text(entry.value['desc'] as String,
                          style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 12: Typedefs ─────────────────────────────────────
  print('\n[12] Related Typedefs');

  final typedefs = <Map<String, dynamic>>[
    {'name': 'FrameCallback', 'sig': 'void Function(Duration timeStamp)',
     'color': Color(0xFF607D8B), 'desc': 'Callback for transient and persistent frames'},
    {'name': 'TimingsCallback', 'sig': 'void Function(List<FrameTiming> timings)',
     'color': Color(0xFF455A64), 'desc': 'Callback for performance timing data'},
    {'name': 'VoidCallback', 'sig': 'void Function()',
     'color': Color(0xFF37474F), 'desc': 'Post-frame callback (no arguments)'},
  ];

  final skTypedefsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      children: typedefs.map((td) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(td['name'] as String,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: td['color'] as Color)),
                SizedBox(width: 6.0),
                skChip('typedef', (td['color'] as Color).withValues(alpha: 0.7)),
              ]),
              Text(td['sig'] as String,
                  style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF263238))),
              SizedBox(height: 2.0),
              Text(td['desc'] as String, style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 13: Frame Budget ─────────────────────────────────
  print('\n[13] Frame Budget (16.67ms for 60fps)');

  final budgetItems = <Map<String, dynamic>>[
    {'phase': 'Build', 'ms': 4.0, 'color': Color(0xFF607D8B)},
    {'phase': 'Layout', 'ms': 3.0, 'color': Color(0xFF546E7A)},
    {'phase': 'Paint', 'ms': 2.0, 'color': Color(0xFF455A64)},
    {'phase': 'Compositing', 'ms': 2.0, 'color': Color(0xFF37474F)},
    {'phase': 'Raster (GPU)', 'ms': 4.0, 'color': Color(0xFF263238)},
  ];
  final totalMs = budgetItems.fold<double>(0.0, (s, b) => s + (b['ms'] as double));

  final skBudgetSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('16.67ms total budget per frame at 60fps',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF263238))),
        SizedBox(height: 10.0),
        // Budget bar
        Container(
          width: double.infinity, height: 24.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: budgetItems.map((bi) {
              return Expanded(
                flex: ((bi['ms'] as double) * 10).round(),
                child: Container(
                  color: bi['color'] as Color,
                  child: Center(child: Text('${(bi['ms'] as double).toStringAsFixed(0)}ms',
                      style: TextStyle(fontSize: 8.0, color: Colors.white, fontWeight: FontWeight.bold))),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 8.0),
        ...budgetItems.map((bi) {
          return Padding(
            padding: EdgeInsets.only(bottom: 2.0),
            child: Row(
              children: [
                Container(width: 8.0, height: 8.0,
                  decoration: BoxDecoration(color: bi['color'] as Color, shape: BoxShape.circle)),
                SizedBox(width: 8.0),
                SizedBox(width: 100.0, child: Text(bi['phase'] as String,
                    style: TextStyle(fontSize: 10.0, color: bi['color'] as Color, fontWeight: FontWeight.w600))),
                Text('~${(bi['ms'] as double).toStringAsFixed(0)}ms',
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF546E7A))),
              ],
            ),
          );
        }),
        SizedBox(height: 4.0),
        skInfoRow('Total shown:', '${totalMs.toStringAsFixed(0)}ms / 16.67ms budget'),
      ],
    ),
  );

  // ── Section 14: scheduleMicrotask ────────────────────────────
  print('\n[14] scheduleMicrotask in Frame Context');

  final skMicrotaskSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Microtasks run between transient and persistent callbacks',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF263238))),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SchedulerPhase.midFrameMicrotasks',
                        style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', fontWeight: FontWeight.w700, color: Color(0xFF546E7A))),
                    SizedBox(height: 4.0),
                    Text('Dart microtasks queued during transient callbacks execute here',
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Caution',
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFFEF5350))),
                    SizedBox(height: 4.0),
                    Text('Heavy microtask work can delay persistent callbacks and cause jank',
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ── Section 15: Priority & Scheduling ────────────────────────
  print('\n[15] Priority & scheduleTask');

  final priorities = <Map<String, dynamic>>[
    {'name': 'Priority.animation', 'value': 100000, 'color': Color(0xFF607D8B),
     'desc': 'Highest — for smooth animations'},
    {'name': 'Priority.touch', 'value': 100000, 'color': Color(0xFF546E7A),
     'desc': 'Highest — same as animation'},
    {'name': 'Priority.idle', 'value': 0, 'color': Color(0xFF455A64),
     'desc': 'Lowest — deferred background work'},
    {'name': 'Priority.kMaxOffset', 'value': 10000, 'color': Color(0xFF37474F),
     'desc': 'Maximum offset for custom priorities'},
  ];

  final skPrioritySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('scheduleTask() runs work between frames based on priority',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF263238))),
        SizedBox(height: 8.0),
        ...priorities.map((pr) {
          return Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: [
                Container(width: 8.0, height: 8.0,
                  decoration: BoxDecoration(color: pr['color'] as Color, shape: BoxShape.circle)),
                SizedBox(width: 8.0),
                SizedBox(width: 140.0,
                  child: Text(pr['name'] as String,
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, fontFamily: 'monospace', color: pr['color'] as Color))),
                Expanded(child: Text(pr['desc'] as String,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF546E7A)))),
              ],
            ),
          );
        }),
        SizedBox(height: 8.0),
        skCodeBlock('SchedulerBinding.instance.scheduleTask(\n  () async {\n    // Deferred computation\n    await heavyWork();\n  },\n  Priority.idle,\n);'),
      ],
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  5 phases, 3 callback types, frame budget 16.67ms');

  final skSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF455A64)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('Scheduler Dashboard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Text('5', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Phases', style: TextStyle(fontSize: 11.0, color: Color(0xFFB0BEC5))),
            ]),
            Column(children: [
              Text('3', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Callback Types', style: TextStyle(fontSize: 11.0, color: Color(0xFFB0BEC5))),
            ]),
            Column(children: [
              Text('16.67', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('ms Budget', style: TextStyle(fontSize: 11.0, color: Color(0xFFB0BEC5))),
            ]),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0, runSpacing: 4.0, alignment: WrapAlignment.center,
          children: [
            skChip('SchedulerPhase', Color(0xFF607D8B)),
            skChip('FrameTiming', Color(0xFF546E7A)),
            skChip('AppLifecycleState', Color(0xFF455A64)),
            skChip('Priority', Color(0xFF37474F)),
          ],
        ),
      ],
    ),
  );

  print('\nSchedulerBinding & Phases Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        skTitleSection,
        skSectionHeader('SchedulerPhase', Icons.tune),
        skPhaseSection,
        skSectionHeader('Frame Lifecycle', Icons.loop),
        skLifecycleSection,
        skSectionHeader('Transient Callbacks', Icons.animation),
        skTransientSection,
        skSectionHeader('Persistent Callbacks', Icons.layers),
        skPersistentSection,
        skSectionHeader('Post-Frame Callbacks', Icons.cleaning_services),
        skPostFrameSection,
        skSectionHeader('Callback Comparison', Icons.compare),
        skCallbackCompareSection,
        skSectionHeader('Key Methods', Icons.code),
        skMethodsSection,
        skSectionHeader('FrameTiming', Icons.timer),
        skTimingSection,
        skSectionHeader('AppLifecycleState', Icons.app_settings_alt),
        skLifecycleStateSection,
        skSectionHeader('Frame Scheduling Flow', Icons.swap_calls),
        skFlowSection,
        skSectionHeader('Typedefs', Icons.text_fields),
        skTypedefsSection,
        skSectionHeader('Frame Budget', Icons.speed),
        skBudgetSection,
        skSectionHeader('Microtasks', Icons.memory),
        skMicrotaskSection,
        skSectionHeader('Priority & scheduleTask', Icons.low_priority),
        skPrioritySection,
        SizedBox(height: 8.0),
        skSummarySection,
      ],
    ),
  );
}
