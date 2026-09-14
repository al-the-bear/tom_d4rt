// ignore_for_file: avoid_print
// D4rt deep demo: RestorationManager — the singleton that coordinates
// the entire state restoration lifecycle between Flutter framework and
// the hosting platform engine.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Crimson / Flame palette ───
  const Color crimson = Color(0xFFDC2626);
  const Color flame = Color(0xFFFF6B35);
  const Color deepCrimson = Color(0xFF991B1B);
  const Color paleFlame = Color(0xFFFEF2F2);
  const Color scarlet = Color(0xFFEF4444);
  const Color ember = Color(0xFFFCA5A5);
  const Color ruby = Color(0xFFB91C1C);
  const Color magma = Color(0xFF7F1D1D);
  const Color blush = Color(0xFFFEE2E2);
  const Color coral = Color(0xFFF87171);

  print('[rg] ===== RESTORATION MANAGER DEEP DEMO =====');

  // ─── Local helpers ───

  Widget rgBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [magma, deepCrimson],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: magma.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: crimson,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: flame, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget rgNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleFlame,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ember),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: magma.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget rgCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ember.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: magma.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: crimson.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: magma)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget rgRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? crimson.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: ember.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? magma : deepCrimson)),
          );
        }).toList(),
      ),
    );
  }

  Widget rgFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? magma : deepCrimson,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.arrow_forward, size: 12, color: crimson),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is RestorationManager? ━━━━━━
  print('[rg-01] Section 1: What is RestorationManager?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('01', 'What Is RestorationManager?'),
      rgNote(
        'RestorationManager is a singleton from ServicesBinding that owns the '
        'root RestorationBucket. It coordinates receiving restoration data from '
        'the engine on launch, distributing it to the widget tree, and sending '
        'updated state back when values change.',
      ),
      rgCard(
        'Manager Role',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rgFlow(['Engine data', 'Manager receives', 'Root bucket',
                'Widget tree', 'State restored']),
            const SizedBox(height: 10),
            _rgRoleBadge('Receives', 'Data from engine on launch', magma),
            _rgRoleBadge('Creates', 'Root RestorationBucket', deepCrimson),
            _rgRoleBadge('Distributes', 'Data to widget scopes', crimson),
            _rgRoleBadge('Sends', 'Updated state back to engine', ruby),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Binding integration ━━━━━━
  print('[rg-02] Section 2: Binding integration');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('02', 'ServicesBinding Integration'),
      rgNote(
        'RestorationManager is accessed via ServicesBinding.instance.restorationManager. '
        'It is initialized during binding initialization, before the first frame. '
        'The manager listens for system channel messages carrying restoration data.',
      ),
      rgCard(
        'Binding Initialization',
        Column(
          children: [
            rgRow(['Step', 'Component', 'Action'], isHeader: true),
            rgRow(['1', 'WidgetsBinding', 'initInstances()']),
            rgRow(['2', 'ServicesBinding', 'Creates RestorationManager']),
            rgRow(['3', 'Manager', 'Registers system channel handler']),
            rgRow(['4', 'Engine', 'Sends restoration data (if any)']),
            rgRow(['5', 'Manager', 'Creates root bucket from data']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Root bucket ━━━━━━
  print('[rg-03] Section 3: Root bucket');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('03', 'Root Bucket Ownership'),
      rgNote(
        'The manager owns the root bucket (rootBucket). This is the top of '
        'the bucket hierarchy. The RootRestorationScope widget connects the '
        'root bucket to the widget tree. All child buckets descend from here.',
      ),
      rgCard(
        'Root Bucket Access',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rgCodeLine('ServicesBinding.instance', magma),
            _rgCodeLine('  .restorationManager', deepCrimson),
            _rgCodeLine('  .rootBucket  // Future<RestorationBucket?>', crimson),
            const SizedBox(height: 8),
            _rgPropertyRow('rootBucket', 'Future<RestorationBucket?>', 'The top-level bucket', magma),
            _rgPropertyRow('isReplacing', 'bool', 'True during hot restart', deepCrimson),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: System channel protocol ━━━━━━
  print('[rg-04] Section 4: System channel');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('04', 'System Channel Protocol'),
      rgNote(
        'The manager communicates with the engine via SystemChannels.restoration. '
        'Two messages: "push" sends serialized state to the engine, and the '
        'engine sends restoration data on launch via the same channel.',
      ),
      rgCard(
        'Channel Messages',
        Column(
          children: [
            rgRow(['Direction', 'Message', 'Data'], isHeader: true),
            rgRow(['Engine → Flutter', 'Restoration data', 'Map<dynamic, dynamic>']),
            rgRow(['Flutter → Engine', '"push"', 'Serialized bucket tree']),
            rgRow(['Flutter → Engine', '"get"', 'Request restoration data']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Data receive flow ━━━━━━
  print('[rg-05] Section 5: Data receive');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('05', 'Data Receive Flow'),
      rgNote(
        'On app launch (after process restart), the engine sends restoration '
        'data as a Map. The manager deserializes it into a root bucket with '
        'nested children. This happens before the first frame builds.',
      ),
      rgCard(
        'Receive Sequence',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rgFlow(['Engine restore', 'Channel msg', 'Deserialize',
                'Root bucket', 'Notify listeners']),
            const SizedBox(height: 10),
            _rgTimelineItem('T0', 'App process starts', magma),
            _rgTimelineItem('T1', 'Binding initializes manager', deepCrimson),
            _rgTimelineItem('T2', 'Engine sends restoration Map', crimson),
            _rgTimelineItem('T3', 'Manager creates root bucket', ruby),
            _rgTimelineItem('T4', 'Listeners notified (bucket ready)', scarlet),
            _rgTimelineItem('T5', 'Widget tree builds with restored state', coral),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: State push protocol ━━━━━━
  print('[rg-06] Section 6: State push');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('06', 'State Push to Engine'),
      rgNote(
        'When any bucket value changes, the manager schedules a "push" to '
        'the engine. This is debounced — multiple rapid changes result in '
        'a single push containing the latest state. The push sends the '
        'entire serialized bucket tree.',
      ),
      rgCard(
        'Push Debouncing',
        Column(
          children: [
            rgRow(['Event', 'Manager Action', 'Engine Action'], isHeader: true),
            rgRow(['Value changed', 'Mark dirty', 'N/A']),
            rgRow(['Another change', 'Already dirty', 'N/A']),
            rgRow(['Microtask end', 'Serialize + push', 'N/A']),
            rgRow(['Push received', 'N/A', 'Persist to disk']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Hot restart handling ━━━━━━
  print('[rg-07] Section 7: Hot restart');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('07', 'Hot Restart Handling'),
      rgNote(
        'During hot restart, the manager\'s isReplacing flag is true. The '
        'root bucket is recreated from the previous state rather than from '
        'engine data. This preserves restoration state across hot restarts '
        'during development.',
      ),
      rgCard(
        'Hot Restart vs Process Restart',
        Column(
          children: [
            rgRow(['Scenario', 'Data Source', 'State'], isHeader: true),
            rgRow(['Cold launch', 'None', 'Empty buckets']),
            rgRow(['Process restart', 'Engine data', 'Previous state']),
            rgRow(['Hot restart', 'In-memory copy', 'Current state']),
            rgRow(['Hot reload', 'N/A', 'State unchanged']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Listener management ━━━━━━
  print('[rg-08] Section 8: Listeners');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('08', 'Listener Management'),
      rgNote(
        'Components listen to hasListeners and addListener on the manager. '
        'The RootRestorationScope listens for root bucket availability. When '
        'the root bucket changes (e.g., new data from engine), all listeners '
        'are notified to re-register their properties.',
      ),
      rgCard(
        'Listener API',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rgMethodCard('addListener', 'VoidCallback', 'Notified when root changes', magma),
            _rgMethodCard('removeListener', 'VoidCallback', 'Stop listening', deepCrimson),
            _rgMethodCard('rootBucket', 'Future<Bucket?>', 'The root bucket future', crimson),
            _rgMethodCard('isReplacing', 'bool getter', 'True during hot restart', ruby),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: RootRestorationScope ━━━━━━
  print('[rg-09] Section 9: RootRestorationScope');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('09', 'RootRestorationScope'),
      rgNote(
        'RootRestorationScope is the widget that connects the manager to the '
        'widget tree. WidgetsApp wraps itself in a RootRestorationScope which '
        'claims the root bucket and provides it via InheritedWidget.',
      ),
      rgCard(
        'Widget Tree Connection',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rgFlow(['Manager', 'RootRestorationScope', 'InheritedWidget',
                'RestorationScope.of()', 'Widget buckets']),
            const SizedBox(height: 10),
            rgRow(['Layer', 'Widget', 'Role'], isHeader: true),
            rgRow(['1', 'RootRestorationScope', 'Owns root bucket']),
            rgRow(['2', 'MaterialApp', 'restorationScopeId']),
            rgRow(['3', 'Navigator', 'Route restoration']),
            rgRow(['4', 'Scaffold / Page', 'Widget-level scopes']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Error handling ━━━━━━
  print('[rg-10] Section 10: Error handling');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('10', 'Error Handling'),
      rgNote(
        'Restoration failures are non-fatal. If the engine data is corrupt '
        'or incompatible, the manager creates fresh empty buckets. If push '
        'fails, the state is lost on next restart. Widgets should always '
        'handle the case where no restoration data is available.',
      ),
      rgCard(
        'Failure Scenarios',
        Column(
          children: [
            rgRow(['Failure', 'Behavior', 'Impact'], isHeader: true),
            rgRow(['Corrupt data', 'Fresh buckets', 'State lost']),
            rgRow(['Schema mismatch', 'Partial restore', 'Some state lost']),
            rgRow(['Push failure', 'Retry on next change', 'Risk of loss']),
            rgRow(['No engine support', 'Null root bucket', 'No restoration']),
            rgRow(['Data too large', 'Platform may truncate', 'Partial state']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Testing restoration ━━━━━━
  print('[rg-11] Section 11: Testing');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('11', 'Testing Restoration'),
      rgNote(
        'Use TestRestorationManager in widget tests. It lets you feed '
        'restoration data and verify push calls without the engine. Call '
        'restoreFrom() to simulate the engine providing data, then check '
        'the serialized output.',
      ),
      rgCard(
        'Test Utilities',
        Column(
          children: [
            rgRow(['Utility', 'Purpose', 'Module'], isHeader: true),
            rgRow(['TestRestorationManager', 'Mock manager', 'flutter_test']),
            rgRow(['MockRestorationBucket', 'Mock bucket', 'Custom']),
            rgRow(['tester.restoreFrom()', 'Feed data', 'WidgetTester']),
            rgRow(['tester.getRestorationData()', 'Read state', 'WidgetTester']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Custom manager ━━━━━━
  print('[rg-12] Section 12: Custom manager');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('12', 'Custom RestorationManager'),
      rgNote(
        'You can subclass RestorationManager to add custom persistence '
        '(e.g., SharedPreferences, SQLite). Override createDefaultValue() '
        'and handleRestorationUpdateFromEngine(). Bind your custom manager '
        'via a custom WidgetsFlutterBinding.',
      ),
      rgCard(
        'Extension Points',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rgCodeLine('class MyManager extends RestorationManager {', magma),
            _rgCodeLine('  @override', deepCrimson),
            _rgCodeLine('  Future<Map<dynamic, dynamic>?>', crimson),
            _rgCodeLine('    getRestorationData() async {', crimson),
            _rgCodeLine('    return prefs.getMap("restore");', ruby),
            _rgCodeLine('  }', ruby),
            _rgCodeLine('  @override', deepCrimson),
            _rgCodeLine('  void handleRestorationDataChanged() {', scarlet),
            _rgCodeLine('    prefs.setMap("restore", data);', scarlet),
            _rgCodeLine('  }', magma),
            _rgCodeLine('}', magma),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Manager lifecycle ━━━━━━
  print('[rg-13] Section 13: Lifecycle');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('13', 'Manager Lifecycle'),
      rgNote(
        'The manager persists for the lifetime of the app. It handles the '
        'complete lifecycle: initialization → receive data → distribute → '
        'monitor changes → push updates → handle restarts.',
      ),
      rgCard(
        'Complete Lifecycle',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rgLifecyclePhase(1, 'Init', 'Binding creates manager', Icons.power_settings_new, magma),
            _rgLifecyclePhase(2, 'Listen', 'Register channel handler', Icons.hearing, deepCrimson),
            _rgLifecyclePhase(3, 'Receive', 'Engine sends data', Icons.download, crimson),
            _rgLifecyclePhase(4, 'Distribute', 'Create root bucket tree', Icons.account_tree, ruby),
            _rgLifecyclePhase(5, 'Monitor', 'Watch for value changes', Icons.visibility, scarlet),
            _rgLifecyclePhase(6, 'Push', 'Send updates to engine', Icons.upload, coral),
            _rgLifecyclePhase(7, 'Repeat', 'Back to monitor', Icons.refresh, flame),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Platform differences ━━━━━━
  print('[rg-14] Section 14: Platform differences');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('14', 'Platform Differences'),
      rgNote(
        'Restoration behavior varies by platform. Android has mature support '
        'via onSaveInstanceState. iOS uses NSUserActivity. Web and desktop '
        'have limited or no support — rootBucket may be null.',
      ),
      rgCard(
        'Platform Matrix',
        Column(
          children: [
            rgRow(['Platform', 'Supported', 'Mechanism', 'Trigger'], isHeader: true),
            rgRow(['Android', 'Yes', 'Bundle', 'Low memory kill']),
            rgRow(['iOS', 'Yes', 'NSUserActivity', 'Background kill']),
            rgRow(['Web', 'No', 'N/A', 'Refresh = full reset']),
            rgRow(['macOS', 'Limited', 'NSUserActivity', 'Rare']),
            rgRow(['Linux', 'No', 'N/A', 'N/A']),
            rgRow(['Windows', 'No', 'N/A', 'N/A']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Common pitfalls ━━━━━━
  print('[rg-15] Section 15: Pitfalls');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('15', 'Common Pitfalls'),
      rgNote(
        'The manager is often misunderstood or misused. Key mistakes: '
        'forgetting restorationScopeId on MaterialApp, storing too much data, '
        'not testing with process death, and assuming restoration always works.',
      ),
      rgCard(
        'Pitfall Guide',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rgPitfall('No restorationScopeId', 'Entire subtree has no restoration', magma),
            _rgPitfall('Data too large', 'Android drops SavedInstanceState', deepCrimson),
            _rgPitfall('Non-serializable', 'RuntimeError on push', crimson),
            _rgPitfall('Not testing', 'Issues found only in production', ruby),
            _rgPitfall('Web assumptions', 'rootBucket is null on web', scarlet),
            _rgPitfall('Async race', 'rootBucket is a Future, widget may build before ready', coral),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[rg-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rgBanner('16', 'Summary Dashboard'),
      rgCard(
        'RestorationManager — Complete',
        Column(
          children: [
            rgRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            rgRow(['What', 'S01', 'Singleton coordinating restoration']),
            rgRow(['Binding', 'S02', 'ServicesBinding initialization']),
            rgRow(['Root bucket', 'S03', 'Owns the top-level bucket']),
            rgRow(['Channel', 'S04', 'SystemChannels.restoration']),
            rgRow(['Receive', 'S05', 'Engine → Manager → Root bucket']),
            rgRow(['Push', 'S06', 'Debounced state serialization']),
            rgRow(['Hot restart', 'S07', 'In-memory state preserved']),
            rgRow(['Listeners', 'S08', 'Notifies on root changes']),
            rgRow(['Root scope', 'S09', 'RootRestorationScope widget']),
            rgRow(['Errors', 'S10', 'Non-fatal, fresh buckets']),
            rgRow(['Testing', 'S11', 'TestRestorationManager']),
            rgRow(['Custom', 'S12', 'Subclass for custom persistence']),
            rgRow(['Lifecycle', 'S13', 'Init → receive → push loop']),
            rgRow(['Platforms', 'S14', 'Android/iOS yes, web no']),
            rgRow(['Pitfalls', 'S15', 'Missing IDs, large data, async']),
          ],
        ),
      ),
      rgCard(
        'Crimson / Flame Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _rgColorSwatch('Crimson', crimson),
            _rgColorSwatch('Flame', flame),
            _rgColorSwatch('Ruby', ruby),
            _rgColorSwatch('Scarlet', scarlet),
            _rgColorSwatch('Magma', magma),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [magma, deepCrimson],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('RestorationManager — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'The singleton orchestrator of Flutter state restoration: '
              'from engine communication through root bucket management, '
              'change monitoring, hot restart, and platform differences.',
              style: TextStyle(color: paleFlame, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[rg] palette: $blush, $ember, $coral, $scarlet');
  print('[rg] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RestorationManager — State Coordination'),
        backgroundColor: magma,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFFBF8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _rgRoleBadge(String role, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 70,
          child: Text(role,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _rgCodeLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(text,
        style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: color,
            height: 1.3)),
  );
}

Widget _rgPropertyRow(String name, String type, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(name,
              style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: color)),
        ),
        SizedBox(
          width: 100,
          child: Text(type,
              style: TextStyle(
                  fontSize: 8, fontFamily: 'monospace', color: color.withValues(alpha: 0.7))),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _rgTimelineItem(String time, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Container(
          width: 28,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(time,
                style: const TextStyle(
                    color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _rgMethodCard(String name, String sig, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        Text(sig,
            style: TextStyle(
                fontSize: 8, fontFamily: 'monospace', color: color.withValues(alpha: 0.6))),
        Text(desc,
            style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.8))),
      ],
    ),
  );
}

Widget _rgLifecyclePhase(int num, String name, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 6),
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        SizedBox(
          width: 50,
          child: Text(name,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _rgPitfall(String issue, String consequence, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Icon(Icons.warning_amber, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: '$issue: ',
                    style: TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold, color: color)),
                TextSpan(
                    text: consequence,
                    style: TextStyle(
                        fontSize: 10, color: color.withValues(alpha: 0.7))),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _rgColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
