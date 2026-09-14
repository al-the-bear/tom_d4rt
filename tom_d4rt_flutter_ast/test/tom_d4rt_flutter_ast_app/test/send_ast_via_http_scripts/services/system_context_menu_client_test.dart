// ignore_for_file: avoid_print
// D4rt deep demo: SystemContextMenuClient — the mixin that allows Flutter
// widgets to receive callbacks when the system-level context menu (right-click
// or long-press menu) is shown or hidden by the platform.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Forest / Sage palette ───
  const Color forest = Color(0xFF166534);
  const Color sage = Color(0xFF4ADE80);
  const Color deepForest = Color(0xFF14532D);
  const Color paleLeaf = Color(0xFFF0FDF4);
  const Color emerald = Color(0xFF059669);
  const Color mint = Color(0xFFBBF7D0);
  const Color pine = Color(0xFF064E3B);
  const Color fern = Color(0xFF10B981);
  const Color dew = Color(0xFFD1FAE5);
  const Color lime = Color(0xFF34D399);

  print('===== SYSTEM CONTEXT MENU CLIENT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [pine, deepForest],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: pine.withValues(alpha: 0.35),
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
              color: forest,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: sage, width: 1.5),
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

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleLeaf,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: mint),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: pine.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: dew),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.07),
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
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: paleLeaf,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: forest)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepForest)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: pine)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: pine.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepForest),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 11, color: deepForest)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: dew,
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section 1: Overview & Purpose ───
  print('[Section 1] Overview & Purpose');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'SystemContextMenuClient is a mixin in the Flutter services layer '
          'that provides a client-side interface for receiving system context '
          'menu events. It allows widgets to know when the platform shows or '
          'hides its native context menu (such as right-click menus on '
          'desktop or long-press menus on mobile).'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Mixin'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Receive system context menu callbacks'),
              dataRow('Companion', 'SystemContextMenuController'),
            ],
          )),
      infoCard(
          'Mixin Contract',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('handleSystemHide', 'Called when system hides menu'),
              dataRow('Registration', 'Via SystemContextMenuController'),
              dataRow('Platform bridge', 'ContextMenu platform channel'),
              dataRow('Lifecycle', 'Register on init, unregister on dispose'),
            ],
          )),
    ],
  );

  // ─── Section 2: Mixin API Surface ───
  print('[Section 2] Mixin API Surface');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Mixin API Surface'),
      noteBox(
          'The mixin exposes a minimal API — a single callback that fires '
          'when the system decides to hide the context menu. The show event '
          'is handled by the controller, not the client.'),
      infoCard(
          'Callback Method',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Method', 'handleSystemHide()'),
              dataRow('Return', 'void'),
              dataRow('When called', 'System hides the context menu'),
              dataRow('Thread', 'Main isolate / UI thread'),
            ],
          )),
      infoCard(
          'Registration Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Step 1', 'Mix in SystemContextMenuClient'),
              dataRow('Step 2', 'Implement handleSystemHide'),
              dataRow('Step 3', 'Register with controller'),
              dataRow('Step 4', 'Controller manages channel comms'),
            ],
          )),
      infoCard(
          'Design Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Observer pattern', 'Client observes system events'),
              dataRow('Inversion of control', 'Platform calls Flutter'),
              dataRow('Single responsibility', 'Only menu hide events'),
              dataRow('Composable', 'Multiple clients can register'),
            ],
          )),
    ],
  );

  // ─── Section 3: Platform Context Menu Types ───
  print('[Section 3] Platform Context Menu Types');

  final menuTypes = <Map<String, String>>[
    {'platform': 'iOS', 'trigger': 'Long-press', 'style': 'UIMenu callout'},
    {'platform': 'Android', 'trigger': 'Long-press', 'style': 'ActionMode toolbar'},
    {'platform': 'macOS', 'trigger': 'Right-click / Ctrl+click', 'style': 'NSMenu'},
    {'platform': 'Windows', 'trigger': 'Right-click', 'style': 'Win32 context menu'},
    {'platform': 'Linux', 'trigger': 'Right-click', 'style': 'GTK/Qt popup menu'},
    {'platform': 'Web', 'trigger': 'Right-click', 'style': 'Browser context menu'},
  ];

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Platform Context Menu Types'),
      noteBox(
          'Each platform has its own native context menu system with '
          'different triggers, appearances, and behaviors. The client '
          'mixin provides a unified callback regardless of platform.'),
      for (final menu in menuTypes)
        infoCard(
            '${menu['platform']} Context Menu',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Trigger', menu['trigger']!),
                dataRow('Style', menu['style']!),
                dataRow('Hide callback', 'Routed to client mixin'),
              ],
            )),
    ],
  );

  // ─── Section 4: Event Flow Architecture ───
  print('[Section 4] Event Flow Architecture');

  final eventFlow = <Map<String, String>>[
    {'step': '1', 'event': 'User right-clicks', 'handler': 'Platform OS'},
    {'step': '2', 'event': 'System menu shown', 'handler': 'Native layer'},
    {'step': '3', 'event': 'User selects/dismisses', 'handler': 'Native layer'},
    {'step': '4', 'event': 'Hide signal sent', 'handler': 'Platform channel'},
    {'step': '5', 'event': 'Channel message', 'handler': 'SystemChannels.contextMenu'},
    {'step': '6', 'event': 'Client notified', 'handler': 'handleSystemHide()'},
    {'step': '7', 'event': 'Widget updates', 'handler': 'setState or rebuild'},
  ];

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Event Flow Architecture'),
      noteBox(
          'The event flow starts from the platform native layer and '
          'travels through the platform channel to the client mixin. '
          'Each step transforms the event into Flutter-compatible form.'),
      for (final step in eventFlow)
        infoCard(
            'Step ${step['step']}: ${step['event']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Event', step['event']!),
                dataRow('Handler', step['handler']!),
              ],
            )),
    ],
  );

  // ─── Section 5: Controller-Client Relationship ───
  print('[Section 5] Controller-Client Relationship');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Controller-Client Relationship'),
      noteBox(
          'The client mixin works hand-in-hand with SystemContextMenuController. '
          'The controller manages the platform channel and dispatches events '
          'to registered clients. Think of it as a publisher-subscriber model.'),
      infoCard(
          'Controller Responsibilities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Show menu', 'Sends show request to platform'),
              dataRow('Track visibility', 'Knows if menu is visible'),
              dataRow('Dispatch hide', 'Notifies all registered clients'),
              dataRow('Lifecycle', 'Manages channel listener'),
            ],
          )),
      infoCard(
          'Client Responsibilities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Implement callback', 'handleSystemHide()'),
              dataRow('Register', 'Connect to controller on init'),
              dataRow('Unregister', 'Disconnect on dispose'),
              dataRow('React', 'Update UI based on menu state'),
            ],
          )),
      infoCard(
          'Pub-Sub Topology',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Publishers', 'One controller (single channel)'),
              dataRow('Subscribers', 'Multiple clients possible'),
              dataRow('Delivery', 'Synchronous, on UI thread'),
              dataRow('Ordering', 'Registration order preserved'),
            ],
          )),
    ],
  );

  // ─── Section 6: Use Cases & Scenarios ───
  print('[Section 6] Use Cases & Scenarios');

  final useCases = <Map<String, String>>[
    {'case': 'Text selection', 'detail': 'Track when copy/paste menu closes'},
    {'case': 'Custom editor', 'detail': 'Sync custom toolbar with system menu'},
    {'case': 'Drawing canvas', 'detail': 'Resume drawing after menu dismissed'},
    {'case': 'Game overlay', 'detail': 'Pause game while menu is shown'},
    {'case': 'Accessibility', 'detail': 'Announce menu state changes'},
  ];

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Use Cases & Scenarios'),
      noteBox(
          'The client mixin is most useful when an app needs to coordinate '
          'its own UI state with the visibility of the system context menu. '
          'Without this, apps cannot know when the menu disappears.'),
      for (final uc in useCases)
        infoCard(
            uc['case']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Use case', uc['case']!),
                dataRow('Detail', uc['detail']!),
                dataRow('Mixin role', 'Receive hide notification'),
              ],
            )),
      infoCard(
          'Anti-Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Polling', 'Don\'t poll for menu state — use mixin'),
              dataRow('Timer fallback', 'Don\'t guess when menu closes'),
              dataRow('Global state', 'Keep menu state in local widget'),
              dataRow('Skip dispose', 'Always unregister to avoid leaks'),
            ],
          )),
    ],
  );

  // ─── Section 7: Platform Channel Details ───
  print('[Section 7] Platform Channel Details');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Platform Channel Details'),
      noteBox(
          'The communication between platform and Flutter happens over '
          'SystemChannels.contextMenu, a method channel that carries '
          'show/hide messages as simple string method calls.'),
      infoCard(
          'Channel Specification',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Channel', 'flutter/contextmenu'),
              dataRow('Codec', 'StandardMethodCodec'),
              dataRow('Direction', 'Platform → Flutter (callbacks)'),
              dataRow('Also', 'Flutter → Platform (show request)'),
            ],
          )),
      infoCard(
          'Message Format',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Show', 'showSystemContextMenu(targetRect)'),
              dataRow('Hide', 'onSystemContextMenuHidden()'),
              dataRow('Args', 'Rect coordinates for positioning'),
              dataRow('Response', 'Void / acknowledgment'),
            ],
          )),
      infoCard(
          'Channel Lifecycle',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Setup', 'Automatic with WidgetsBinding'),
              dataRow('Listener', 'Set by controller on first use'),
              dataRow('Teardown', 'Removed on last client unregister'),
              dataRow('Thread safety', 'UI thread only'),
            ],
          )),
    ],
  );

  // ─── Section 8: Implementation Pattern ───
  print('[Section 8] Implementation Pattern');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Implementation Pattern'),
      noteBox(
          'Implementing the mixin is straightforward: mix it into a State '
          'class, override handleSystemHide, register on initState, and '
          'unregister on dispose. The pattern follows Flutter conventions.'),
      infoCard(
          'Step-by-Step',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Mixin', 'with SystemContextMenuClient'),
              dataRow('2. Override', 'handleSystemHide()'),
              dataRow('3. Init', 'Register in initState'),
              dataRow('4. Dispose', 'Unregister in dispose'),
            ],
          )),
      infoCard(
          'State Management',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Local bool', 'Track menu visibility'),
              dataRow('Set on show', 'Before calling controller.show'),
              dataRow('Clear on hide', 'In handleSystemHide callback'),
              dataRow('Rebuild', 'setState in callback'),
            ],
          )),
      infoCard(
          'Code Structure',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Mixin placement', 'After State<T> declaration'),
              dataRow('Callback body', 'Minimal — just state update'),
              dataRow('Registration', 'Controller.addClient(this)'),
              dataRow('Error handling', 'Platform may not support it'),
            ],
          )),
    ],
  );

  // ─── Section 9: Testing Strategy ───
  print('[Section 9] Testing Strategy');

  final testScenarios = <Map<String, String>>[
    {'scenario': 'Register callback', 'verify': 'Client is registered with controller'},
    {'scenario': 'Receive hide event', 'verify': 'handleSystemHide is called'},
    {'scenario': 'Multiple clients', 'verify': 'All clients get notified'},
    {'scenario': 'Unregister', 'verify': 'No callback after unregister'},
    {'scenario': 'Dispose cleanup', 'verify': 'No memory leak'},
    {'scenario': 'Platform unavailable', 'verify': 'Graceful no-op'},
  ];

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Testing Strategy'),
      noteBox(
          'Testing the client mixin requires simulating platform channel '
          'messages. Flutter\'s test framework provides tools to fake '
          'method channel calls for reliable unit testing.'),
      for (final ts in testScenarios)
        infoCard(
            'Test: ${ts['scenario']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Scenario', ts['scenario']!),
                dataRow('Verify', ts['verify']!),
                dataRow('Type', 'Widget / Unit test'),
              ],
            )),
    ],
  );

  // ─── Section 10: Comparison with Other Clients ───
  print('[Section 10] Comparison with Other Clients');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Comparison with Other Client Mixins'),
      noteBox(
          'Flutter uses the client mixin pattern for several platform '
          'interactions. SystemContextMenuClient follows the same design '
          'as other client mixins in the services layer.'),
      infoCard(
          'Client Mixin Family',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextInputClient', 'Text editing callbacks'),
              dataRow('UndoManagerClient', 'Undo/redo callbacks'),
              dataRow('ScribbleClient', 'Stylus writing callbacks'),
              dataRow('ContextMenuClient', 'System context menu callbacks'),
            ],
          )),
      infoCard(
          'Shared Characteristics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Pattern', 'Mixin on State class'),
              dataRow('Lifecycle', 'Register on init, dispose cleans'),
              dataRow('Threading', 'Always UI thread'),
              dataRow('Extensibility', 'Override specific callbacks'),
            ],
          )),
    ],
  );

  // ─── Section 11: Desktop-Specific Behavior ───
  print('[Section 11] Desktop-Specific Behavior');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Desktop-Specific Behavior'),
      noteBox(
          'On desktop platforms, the system context menu is triggered by '
          'right-click and provides a richer set of options. The client '
          'mixin is particularly useful on desktop.'),
      infoCard(
          'macOS Specifics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Trigger', 'Right-click or Ctrl+click'),
              dataRow('Menu style', 'Native NSMenu dropdown'),
              dataRow('Services menu', 'OS services integrated'),
              dataRow('Dismissal', 'Click outside or Escape key'),
            ],
          )),
      infoCard(
          'Windows Specifics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Trigger', 'Right-click or Menu key'),
              dataRow('Menu style', 'Win32 popup menu'),
              dataRow('Clipboard integration', 'Cut/Copy/Paste built-in'),
              dataRow('Dismissal', 'Click outside or Escape'),
            ],
          )),
      infoCard(
          'Linux Specifics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Trigger', 'Right-click'),
              dataRow('Menu style', 'GTK or Qt popup'),
              dataRow('Variation', 'Desktop environment dependent'),
              dataRow('Dismissal', 'Click outside or Escape'),
            ],
          )),
    ],
  );

  // ─── Section 12: Mobile Context Menu Behavior ───
  print('[Section 12] Mobile Context Menu Behavior');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Mobile Context Menu Behavior'),
      noteBox(
          'On mobile platforms, the system context menu typically appears '
          'via long-press on text selections. The behavior is more '
          'constrained than desktop but follows the same mixin pattern.'),
      infoCard(
          'iOS Mobile Menu',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Trigger', 'Long-press on selected text'),
              dataRow('Style', 'Callout bubble above selection'),
              dataRow('Items', 'Cut, Copy, Paste, Select All'),
              dataRow('Custom items', 'Via UIMenuElement (limited)'),
            ],
          )),
      infoCard(
          'Android Mobile Menu',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Trigger', 'Long-press on text'),
              dataRow('Style', 'ActionMode toolbar at top'),
              dataRow('Items', 'Copy, Cut, Paste, Share'),
              dataRow('Custom items', 'Via processTextAction (API 34+)'),
            ],
          )),
      infoCard(
          'Cross-Platform Consistency',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('The mixin', 'Same API on all platforms'),
              dataRow('Hide callback', 'Fires identically everywhere'),
              dataRow('Differences', 'Only in trigger and visual style'),
              dataRow('Testing', 'Mock channel works for all'),
            ],
          )),
    ],
  );

  // ─── Section 13: Memory & Performance ───
  print('[Section 13] Memory & Performance');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Memory & Performance'),
      noteBox(
          'The mixin adds negligible overhead — it is purely an event '
          'callback mechanism with no internal state or resource allocation '
          'beyond the registration itself.'),
      infoCard(
          'Memory Footprint',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Mixin overhead', 'Near zero (no fields)'),
              dataRow('Registration', 'One reference in controller'),
              dataRow('Callback', 'Pointer to method — ~8 bytes'),
              dataRow('Channel listener', 'Shared — not per-client'),
            ],
          )),
      infoCard(
          'Performance Profile',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Register/unregister', 0.02, forest),
              progressBar('Channel message', 0.05, emerald),
              progressBar('Callback dispatch', 0.01, sage),
              progressBar('Widget rebuild', 0.10, fern),
            ],
          )),
    ],
  );

  // ─── Section 14: Error Handling & Edge Cases ───
  print('[Section 14] Error Handling & Edge Cases');

  final edgeCases = <Map<String, String>>[
    {'case': 'Platform unsupported', 'handling': 'handleSystemHide never called'},
    {'case': 'Double register', 'handling': 'Controller deduplicates'},
    {'case': 'Dispose without unregister', 'handling': 'Memory leak risk'},
    {'case': 'Menu dismissed by system', 'handling': 'Normal hide callback'},
    {'case': 'App backgrounded', 'handling': 'Menu auto-dismissed by OS'},
  ];

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Error Handling & Edge Cases'),
      noteBox(
          'The mixin is designed to be resilient, but developers should '
          'handle edge cases around registration lifecycle and platform '
          'availability to avoid unexpected behavior.'),
      for (final ec in edgeCases)
        infoCard(
            'Edge: ${ec['case']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Case', ec['case']!),
                dataRow('Handling', ec['handling']!),
              ],
            )),
    ],
  );

  // ─── Section 15: Best Practices ───
  print('[Section 15] Best Practices');

  final practices = <Map<String, String>>[
    {'practice': 'Always unregister', 'reason': 'Prevents memory leaks'},
    {'practice': 'Minimal callback', 'reason': 'Keep handleSystemHide fast'},
    {'practice': 'Local state only', 'reason': 'Don\'t modify global state'},
    {'practice': 'Test with mocks', 'reason': 'Platform channel not available in tests'},
    {'practice': 'Check platform', 'reason': 'Not all platforms support it'},
    {'practice': 'Group with controller', 'reason': 'Client/controller are a pair'},
  ];

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Best Practices'),
      noteBox(
          'Following these practices ensures clean integration with the '
          'system context menu lifecycle and prevents common pitfalls.'),
      for (final pr in practices)
        infoCard(
            pr['practice']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Practice', pr['practice']!),
                dataRow('Reason', pr['reason']!),
              ],
            )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Comprehensive overview of the SystemContextMenuClient deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Forest', forest),
              colorSwatch('Sage', sage),
              colorSwatch('Deep Forest', deepForest),
              colorSwatch('Pale Leaf', paleLeaf),
              colorSwatch('Emerald', emerald),
              colorSwatch('Mint', mint),
              colorSwatch('Pine', pine),
              colorSwatch('Fern', fern),
              colorSwatch('Dew', dew),
              colorSwatch('Lime', lime),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, forest),
              progressBar('Mixin API', 1.0, emerald),
              progressBar('Platform Menus', 1.0, sage),
              progressBar('Event Flow', 1.0, fern),
              progressBar('Controller Relationship', 1.0, lime),
              progressBar('Use Cases', 1.0, forest),
              progressBar('Platform Channel', 1.0, emerald),
              progressBar('Implementation', 1.0, sage),
              progressBar('Testing', 1.0, fern),
              progressBar('Client Comparison', 1.0, lime),
              progressBar('Desktop Behavior', 1.0, forest),
              progressBar('Mobile Behavior', 1.0, emerald),
              progressBar('Performance', 1.0, sage),
              progressBar('Error Handling', 1.0, fern),
              progressBar('Best Practices', 1.0, lime),
              progressBar('Dashboard', 1.0, forest),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Forest / Sage'),
              dataRow('Palette colors', '10'),
              dataRow('Platform menus', '${menuTypes.length}'),
              dataRow('Event flow steps', '${eventFlow.length}'),
              dataRow('Use cases', '${useCases.length}'),
              dataRow('Test scenarios', '${testScenarios.length}'),
              dataRow('Edge cases', '${edgeCases.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('ContextMenuClient', forest, Colors.white),
          tag('Mixin', emerald, Colors.white),
          tag('Platform Channel', sage, Colors.white),
          tag('Services', fern, Colors.white),
          tag('Desktop', pine, Colors.white),
          tag('Mobile', deepForest, Colors.white),
          tag('Observer', lime, Colors.white),
          tag('Lifecycle', forest.withValues(alpha: 0.8), Colors.white),
        ],
      ),
    ],
  );

  print('===== END SYSTEM CONTEXT MENU CLIENT DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}
