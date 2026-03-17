// D4rt Deep Demo: AppLifecycleState - Application Lifecycle States
// This demo comprehensively explores AppLifecycleState enum which represents
// the various states an application can be in during its lifecycle.
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '═══════════════════════════════════════════════════════════════════════════',
  );
  print(
    '                    APPLIFECYCLESTATE DEEP DEMO                            ',
  );
  print(
    '═══════════════════════════════════════════════════════════════════════════',
  );

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 1: AppLifecycleState Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 1: AppLifecycleState Fundamentals');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('AppLifecycleState represents the current state of an application:');
  print('- Determines what the app can/should do');
  print('- Affects resource allocation');
  print('- Guides animation and processing decisions');
  print('');
  print('All lifecycle states:');
  for (final state in AppLifecycleState.values) {
    print('  [${state.index}] ${state.name}');
  }
  print('Total: ${AppLifecycleState.values.length} states');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 2: Resumed State
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 2: Resumed State');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  final resumed = AppLifecycleState.resumed;
  print('State: $resumed');
  print('Name: ${resumed.name}');
  print('Index: ${resumed.index}');
  print('');
  print('Characteristics:');
  print('  • App is visible and has focus');
  print('  • User can interact with the app');
  print('  • Animations should run smoothly');
  print('  • Full resources available');
  print('');
  print('Actions in resumed state:');
  print('  • Start animations');
  print('  • Resume playback (video/audio)');
  print('  • Fetch/sync data');
  print('  • Track user engagement');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 3: Inactive State
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 3: Inactive State');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  final inactive = AppLifecycleState.inactive;
  print('State: $inactive');
  print('Name: ${inactive.name}');
  print('Index: ${inactive.index}');
  print('');
  print('Characteristics:');
  print('  • App is visible but lost focus');
  print('  • May be obscured by system UI');
  print('  • User cannot interact');
  print('  • Transitional state');
  print('');
  print('Triggers:');
  print('  • Phone call incoming');
  print('  • System dialog displayed');
  print('  • App switching in progress');
  print('  • Control Center / notification shade');
  print('');
  print('Actions in inactive state:');
  print('  • Pause interactions');
  print('  • Consider pausing animations');
  print('  • Prepare for potential pause/resume');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 4: Paused State
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 4: Paused State');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  final paused = AppLifecycleState.paused;
  print('State: $paused');
  print('Name: ${paused.name}');
  print('Index: ${paused.index}');
  print('');
  print('Characteristics:');
  print('  • App is not visible');
  print('  • Running in background');
  print('  • Limited CPU time');
  print('  • Memory may be reclaimed');
  print('');
  print('Triggers:');
  print('  • User switched to another app');
  print('  • User pressed home button');
  print('  • Screen locked');
  print('');
  print('Actions in paused state:');
  print('  • Save state immediately');
  print('  • Stop animations');
  print('  • Release expensive resources');
  print('  • Pause audio/video playback');
  print('  • Cancel network requests');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 5: Hidden State
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 5: Hidden State');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  final hidden = AppLifecycleState.hidden;
  print('State: $hidden');
  print('Name: ${hidden.name}');
  print('Index: ${hidden.index}');
  print('');
  print('Characteristics:');
  print('  • All views are hidden');
  print('  • App still running');
  print('  • Desktop: window minimized/hidden');
  print('  • Used on desktop platforms primarily');
  print('');
  print('Triggers:');
  print('  • Window minimized');
  print('  • Window moved to hidden desktop');
  print('  • All windows closed (but app running)');
  print('');
  print('Actions in hidden state:');
  print('  • Similar to paused');
  print('  • May continue background work');
  print('  • Keep service connections alive');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 6: Detached State
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 6: Detached State');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  final detached = AppLifecycleState.detached;
  print('State: $detached');
  print('Name: ${detached.name}');
  print('Index: ${detached.index}');
  print('');
  print('Characteristics:');
  print('  • App is running in Flutter engine');
  print('  • No host views attached');
  print('  • Startup or shutdown phase');
  print('');
  print('When this occurs:');
  print('  • Just after engine starts (before first frame)');
  print('  • During engine teardown');
  print('  • Background isolate scenarios');
  print('');
  print('Actions in detached state:');
  print('  • Minimal operations only');
  print('  • Initialize/cleanup resources');
  print('  • Avoid UI-related code');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 7: State Transitions
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 7: State Transitions');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('Common lifecycle transitions:');
  print('');
  print('App Launch:');
  print('  detached → resumed');
  print('');
  print('To Background (mobile):');
  print('  resumed → inactive → hidden → paused');
  print('');
  print('To Foreground:');
  print('  paused → hidden → inactive → resumed');
  print('');
  print('Phone Call:');
  print('  resumed → inactive → resumed');
  print('');
  print('App Termination:');
  print('  resumed → inactive → paused → detached');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 8: Platform Differences
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 8: Platform Differences');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('Mobile (iOS/Android):');
  print('  • Uses all states');
  print('  • paused = app in background');
  print('  • May be killed anytime when paused');
  print('');
  print('Desktop (Windows/macOS/Linux):');
  print('  • hidden more relevant than paused');
  print('  • Window minimize → hidden');
  print('  • Apps rarely truly "paused"');
  print('');
  print('Web:');
  print('  • Limited lifecycle support');
  print('  • Tab switch → inactive/paused');
  print('  • Page visibility API maps to states');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 9: WidgetsBindingObserver Implementation
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 9: Observer Implementation');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('To respond to lifecycle changes, implement WidgetsBindingObserver:');
  print('');
  print('''
  class MyApp extends StatefulWidget {
    @override
    State<MyApp> createState() => _MyAppState();
  }
  
  class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
    @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addObserver(this);
    }
    
    @override
    void dispose() {
      WidgetsBinding.instance.removeObserver(this);
      super.dispose();
    }
    
    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
      switch (state) {
        case AppLifecycleState.resumed:
          // App is in foreground
          break;
        case AppLifecycleState.inactive:
          // App is transitioning
          break;
        case AppLifecycleState.paused:
          // App is in background
          break;
        case AppLifecycleState.hidden:
          // All views hidden
          break;
        case AppLifecycleState.detached:
          // Engine running, no views
          break;
      }
    }
  }
  ''');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 10: Resource Management Guidelines
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 10: Resource Management');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('Resource management by state:');
  print('');
  print('┌──────────────┬───────────┬────────────┬──────────┬───────────┐');
  print('│   Resource   │  resumed  │  inactive  │  paused  │  hidden   │');
  print('├──────────────┼───────────┼────────────┼──────────┼───────────┤');
  print('│ Animations   │    Run    │   Pause    │   Stop   │   Stop    │');
  print('│ Audio/Video  │    Play   │   Pause    │   Stop   │   Stop    │');
  print('│ GPS          │  Active   │   Active   │   Stop   │   Stop    │');
  print('│ Camera       │  Active   │   Release  │ Release  │  Release  │');
  print('│ Network      │  Active   │   Active   │  Reduce  │  Reduce   │');
  print('│ Sensors      │  Active   │   Active   │   Stop   │   Stop    │');
  print('└──────────────┴───────────┴────────────┴──────────┴───────────┘');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 11: State Comparison
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 11: State Comparison');
  print(
    '─────────────────────────────────────────────────────────────────────────',
  );
  print('Comparing all states:');
  final states = AppLifecycleState.values;
  for (var i = 0; i < states.length; i++) {
    for (var j = i + 1; j < states.length; j++) {
      print(
        '${states[i].name} == ${states[j].name}: ${states[i] == states[j]}',
      );
    }
  }

  print(
    '\n═══════════════════════════════════════════════════════════════════════════',
  );
  print(
    '                    APPLIFECYCLESTATE DEEP DEMO COMPLETE                   ',
  );
  print(
    '═══════════════════════════════════════════════════════════════════════════',
  );

  // ═══════════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION UI
  // ═══════════════════════════════════════════════════════════════════════════════
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade600, Colors.purple.shade600],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.refresh, size: 48, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  'AppLifecycleState',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Application Lifecycle Management',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // State Cards
          Text(
            'Lifecycle States',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          SizedBox(height: 12),

          _buildStateCard(
            'resumed',
            'App is visible, has focus, user interacting',
            Icons.play_circle_fill,
            Colors.green,
            ['Animations run', 'Full resources', 'User input active'],
          ),
          SizedBox(height: 10),

          _buildStateCard(
            'inactive',
            'Visible but lost focus - transitional',
            Icons.pause_circle_outline,
            Colors.orange,
            ['System dialog shown', 'Phone call incoming', 'Switching apps'],
          ),
          SizedBox(height: 10),

          _buildStateCard(
            'hidden',
            'All views hidden, still running',
            Icons.visibility_off,
            Colors.blueGrey,
            ['Window minimized', 'Desktop platforms', 'Background tasks ok'],
          ),
          SizedBox(height: 10),

          _buildStateCard(
            'paused',
            'Not visible, running in background',
            Icons.stop_circle_outlined,
            Colors.red,
            ['In background', 'Save state now', 'May be killed'],
          ),
          SizedBox(height: 10),

          _buildStateCard(
            'detached',
            'Engine running, no host views',
            Icons.link_off,
            Colors.grey,
            ['App starting/stopping', 'No UI possible', 'Minimal operations'],
          ),

          SizedBox(height: 24),

          // Lifecycle Flow
          Text(
            'Lifecycle Flow',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFlowRow('📲 App Launch:', 'detached → resumed'),
                Divider(),
                _buildFlowRow(
                  '📴 To Background:',
                  'resumed → inactive → hidden → paused',
                ),
                Divider(),
                _buildFlowRow(
                  '📲 To Foreground:',
                  'paused → hidden → inactive → resumed',
                ),
                Divider(),
                _buildFlowRow('📞 Phone Call:', 'resumed → inactive → resumed'),
                Divider(),
                _buildFlowRow(
                  '❌ App Close:',
                  'resumed → inactive → paused → detached',
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Resource Management Matrix
          Text(
            'Resource Management',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildResourceRow('Resource', [
                  'resumed',
                  'inactive',
                  'paused',
                ], true),
                Divider(height: 1),
                _buildResourceRow('Animations', [
                  '▶️ Run',
                  '⏸️ Pause',
                  '⏹️ Stop',
                ], false),
                _buildResourceRow('Audio', [
                  '🔊 Play',
                  '🔉 Pause',
                  '🔇 Stop',
                ], false),
                _buildResourceRow('Camera', [
                  '📷 Active',
                  '❌ Release',
                  '❌ Release',
                ], false),
                _buildResourceRow('Network', [
                  '🌐 Active',
                  '🌐 Active',
                  '📉 Reduce',
                ], false),
                _buildResourceRow('Location', [
                  '📍 Active',
                  '📍 Active',
                  '❌ Stop',
                ], false),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Platform Comparison
          Text(
            'Platform Behavior',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildPlatformBox(
                  'Mobile',
                  Icons.phone_android,
                  Colors.green,
                  ['All states used', 'paused = background', 'May be killed'],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildPlatformBox(
                  'Desktop',
                  Icons.desktop_mac,
                  Colors.blue,
                  ['hidden common', 'Window minimize', 'Rarely paused'],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildPlatformBox('Web', Icons.web, Colors.orange, [
                  'Limited support',
                  'Tab visibility',
                  'Page API',
                ]),
              ),
            ],
          ),

          SizedBox(height: 32),

          // Footer
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '🔄 AppLifecycleState Deep Demo',
                style: TextStyle(
                  color: Colors.indigo.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStateCard(
  String name,
  String description,
  IconData icon,
  Color color,
  List<String> points,
) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.3)),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.1),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: points
                    .map(
                      (p) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          p,
                          style: TextStyle(fontSize: 10, color: color),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowRow(String label, String flow) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(flow, style: TextStyle(color: Colors.indigo.shade700)),
        ),
      ],
    ),
  );
}

Widget _buildResourceRow(String resource, List<String> values, bool isHeader) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            resource,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
        ...values.map(
          (v) => Expanded(
            child: Text(
              v,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPlatformBox(
  String platform,
  IconData icon,
  Color color,
  List<String> features,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 6),
        Text(
          platform,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        ...features.map(
          (f) => Text(
            f,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}
