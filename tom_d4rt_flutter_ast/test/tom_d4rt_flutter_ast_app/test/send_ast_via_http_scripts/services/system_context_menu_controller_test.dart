// ignore_for_file: avoid_print
// D4rt deep demo: SystemContextMenuController — the controller class that
// manages the lifecycle of the platform system context menu, allowing
// Flutter to request show/hide and track the menu's visibility state.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Garnet / Rose palette ───
  const Color garnet = Color(0xFF9F1239);
  const Color rose = Color(0xFFFB7185);
  const Color deepGarnet = Color(0xFF881337);
  const Color palePink = Color(0xFFFFF1F2);
  const Color crimson = Color(0xFFE11D48);
  const Color blush = Color(0xFFFDA4AF);
  const Color maroon = Color(0xFF4C0519);
  const Color ruby = Color(0xFFBE123C);
  const Color petal = Color(0xFFFFE4E6);
  const Color coral = Color(0xFFF43F5E);

  print('===== SYSTEM CONTEXT MENU CONTROLLER DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [maroon, deepGarnet],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: maroon.withValues(alpha: 0.35),
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
              color: garnet,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: rose, width: 1.5),
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
        color: palePink,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: blush),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: maroon.withValues(alpha: 0.9),
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
        border: Border.all(color: petal),
        boxShadow: [
          BoxShadow(
            color: garnet.withValues(alpha: 0.07),
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
              color: palePink,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: garnet)),
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
                    color: deepGarnet)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: maroon)),
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
                  color: maroon.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepGarnet),
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
                  style: TextStyle(fontSize: 11, color: deepGarnet)),
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
              color: petal,
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
          'SystemContextMenuController is the orchestrating class that '
          'manages the platform system context menu lifecycle. It handles '
          'showing, hiding, and tracking the visibility state of the native '
          'context menu — the right-click menu on desktop or the long-press '
          'menu on mobile platforms.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Concrete class'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Show/hide system context menu'),
              dataRow('Companion', 'SystemContextMenuClient'),
            ],
          )),
      infoCard(
          'Key Capabilities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Show menu', 'Request platform to display menu'),
              dataRow('Hide menu', 'Request platform to dismiss menu'),
              dataRow('Track state', 'Know if menu is currently showing'),
              dataRow('Notify clients', 'Dispatch hide events to clients'),
            ],
          )),
    ],
  );

  // ─── Section 2: API Surface ───
  print('[Section 2] API Surface');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'API Surface'),
      noteBox(
          'The controller provides a focused API for menu lifecycle '
          'management. Unlike the client mixin (which is reactive), the '
          'controller is proactive — it sends commands to the platform.'),
      infoCard(
          'Instance Methods',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('show()', 'Show system context menu at rect'),
              dataRow('hide()', 'Hide the system context menu'),
              dataRow('dispose()', 'Clean up listeners and refs'),
            ],
          )),
      infoCard(
          'Static Methods',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('registerClient', 'Add a SystemContextMenuClient'),
              dataRow('unregisterClient', 'Remove a client'),
              dataRow('isSupported', 'Check platform support'),
            ],
          )),
      infoCard(
          'Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('isShowing', 'Whether menu is currently visible'),
              dataRow('onHide', 'Callback for menu dismissal'),
              dataRow('targetRect', 'Rect where menu was last shown'),
            ],
          )),
    ],
  );

  // ─── Section 3: Show/Hide Lifecycle ───
  print('[Section 3] Show/Hide Lifecycle');

  final lifecycle = <Map<String, String>>[
    {'phase': 'Idle', 'state': 'No menu shown', 'action': 'Awaiting show()'},
    {'phase': 'Requesting', 'state': 'Platform notified', 'action': 'Channel message sent'},
    {'phase': 'Showing', 'state': 'Menu visible', 'action': 'isShowing = true'},
    {'phase': 'User interaction', 'state': 'Item selected or dismissed', 'action': 'Platform decides'},
    {'phase': 'Hiding', 'state': 'Menu closing', 'action': 'Platform sends hide'},
    {'phase': 'Hidden', 'state': 'Menu gone', 'action': 'Clients notified'},
    {'phase': 'Disposed', 'state': 'Controller cleaned up', 'action': 'No further events'},
  ];

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Show/Hide Lifecycle'),
      noteBox(
          'The controller manages a clear lifecycle from idle through '
          'showing to hidden. Each phase has defined state transitions '
          'and associated platform channel operations.'),
      for (final phase in lifecycle)
        infoCard(
            'Phase: ${phase['phase']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('State', phase['state']!),
                dataRow('Action', phase['action']!),
              ],
            )),
    ],
  );

  // ─── Section 4: Platform Channel Communication ───
  print('[Section 4] Platform Channel Communication');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Platform Channel Communication'),
      noteBox(
          'The controller communicates with the platform via '
          'SystemChannels.contextMenu. It sends show/hide requests and '
          'receives hide notifications from the native side.'),
      infoCard(
          'Outbound Messages (Flutter → Platform)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('showSystemContextMenu', 'Request to show menu'),
              dataRow('Args: target rect', 'Left, top, right, bottom'),
              dataRow('hideSystemContextMenu', 'Request to hide menu'),
              dataRow('Args', 'None'),
            ],
          )),
      infoCard(
          'Inbound Messages (Platform → Flutter)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('onSystemContextMenuHidden', 'Menu was hidden'),
              dataRow('Args', 'None'),
              dataRow('Timing', 'After menu animation completes'),
              dataRow('Guarantee', 'Always fires if menu was shown'),
            ],
          )),
      infoCard(
          'Channel Specification',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Name', 'flutter/contextmenu'),
              dataRow('Codec', 'StandardMethodCodec'),
              dataRow('Lifecycle', 'Active for app lifetime'),
              dataRow('Thread', 'UI thread only'),
            ],
          )),
    ],
  );

  // ─── Section 5: Target Rect Positioning ───
  print('[Section 5] Target Rect Positioning');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Target Rect Positioning'),
      noteBox(
          'When showing the system menu, the controller sends a target '
          'rectangle that tells the platform where to position the menu. '
          'This is typically the selection rect or the right-click point.'),
      infoCard(
          'Rect Coordinates',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Coordinate space', 'Global logical pixels'),
              dataRow('Origin', 'Top-left of screen'),
              dataRow('left/top', 'Upper-left corner of target'),
              dataRow('right/bottom', 'Lower-right corner of target'),
            ],
          )),
      infoCard(
          'Common Positioning Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Text selection', 'Rect around selected text'),
              dataRow('Right-click point', 'Zero-size rect at click'),
              dataRow('Widget bounds', 'RenderBox.localToGlobal'),
              dataRow('Cursor position', 'Caret rect in text field'),
            ],
          )),
      infoCard(
          'Platform Interpretation',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('iOS', 'Menu above or below rect'),
              dataRow('Android', 'Toolbar anchored to rect top'),
              dataRow('macOS', 'Menu at rect origin'),
              dataRow('Windows', 'Menu at rect corner'),
            ],
          )),
    ],
  );

  // ─── Section 6: Client Management ───
  print('[Section 6] Client Management');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Client Management'),
      noteBox(
          'The controller maintains a registry of SystemContextMenuClient '
          'instances. When the platform sends a hide event, the controller '
          'iterates through all registered clients and calls their '
          'handleSystemHide method.'),
      infoCard(
          'Registration API',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('registerClient(c)', 'Add client to registry'),
              dataRow('unregisterClient(c)', 'Remove client from registry'),
              dataRow('Storage', 'Internal list of weak refs'),
              dataRow('Deduplication', 'Same client can\'t register twice'),
            ],
          )),
      infoCard(
          'Dispatch Strategy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Order', 'Registration order (FIFO)'),
              dataRow('Synchronous', 'All clients notified on UI thread'),
              dataRow('Error isolation', 'One client error doesn\'t block others'),
              dataRow('Null safety', 'Stale weak refs auto-removed'),
            ],
          )),
      infoCard(
          'Multiple Controllers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Allowed', 'Yes — each manages its own show/hide'),
              dataRow('Conflict', 'Last show() wins on platform'),
              dataRow('Best practice', 'One controller per context'),
              dataRow('Shared channel', 'All controllers share the channel'),
            ],
          )),
    ],
  );

  // ─── Section 7: Platform Support Matrix ───
  print('[Section 7] Platform Support Matrix');

  final platformSupport = <Map<String, String>>[
    {'platform': 'iOS', 'supported': 'Yes (iOS 16+)', 'quality': 'Full'},
    {'platform': 'Android', 'supported': 'Yes (API 34+)', 'quality': 'Good'},
    {'platform': 'macOS', 'supported': 'Yes', 'quality': 'Full'},
    {'platform': 'Windows', 'supported': 'Limited', 'quality': 'Partial'},
    {'platform': 'Linux', 'supported': 'Limited', 'quality': 'Partial'},
    {'platform': 'Web', 'supported': 'No', 'quality': 'N/A'},
  ];

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Platform Support Matrix'),
      noteBox(
          'System context menu support varies significantly across '
          'platforms. The isSupported check helps apps adapt gracefully '
          'when the feature is unavailable.'),
      for (final ps in platformSupport)
        infoCard(
            '${ps['platform']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Supported', ps['supported']!),
                dataRow('Quality', ps['quality']!),
                dataRow('Fallback', 'Flutter-rendered context menu'),
              ],
            )),
    ],
  );

  // ─── Section 8: Integration with EditableText ───
  print('[Section 8] Integration with EditableText');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Integration with EditableText'),
      noteBox(
          'EditableText uses SystemContextMenuController internally to '
          'show the system context menu for text selection operations '
          'like cut, copy, paste, and select all.'),
      infoCard(
          'EditableText Usage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Trigger', 'Long-press or right-click on text'),
              dataRow('Target rect', 'Selection bounding rect'),
              dataRow('Menu items', 'Platform default (cut/copy/paste)'),
              dataRow('Hide on edit', 'Menu hidden when text changes'),
            ],
          )),
      infoCard(
          'TextField Chain',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextField', 'User-facing widget'),
              dataRow('EditableText', 'Creates controller internally'),
              dataRow('Controller', 'Sends show/hide to platform'),
              dataRow('Platform', 'Renders native menu'),
            ],
          )),
      infoCard(
          'Custom Context Menus',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('contextMenuBuilder', 'Override for Flutter menus'),
              dataRow('System menu', 'Cannot add custom items'),
              dataRow('Hybrid approach', 'Flutter menu with system styling'),
              dataRow('When to use system', 'Want native look and feel'),
            ],
          )),
    ],
  );

  // ─── Section 9: Dispose & Cleanup ───
  print('[Section 9] Dispose & Cleanup');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Dispose & Cleanup'),
      noteBox(
          'Proper disposal is critical to prevent memory leaks and '
          'stale callback references. The controller should be disposed '
          'in the owning widget\'s dispose method.'),
      infoCard(
          'Dispose Checklist',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Hide menu', 'If currently showing'),
              dataRow('2. Unregister clients', 'Remove all listeners'),
              dataRow('3. Remove channel listener', 'Stop platform events'),
              dataRow('4. Null references', 'Release callback pointers'),
            ],
          )),
      infoCard(
          'Common Mistakes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Forget dispose', 'Menu stays visible after nav'),
              dataRow('Dispose while showing', 'Must hide first'),
              dataRow('Double dispose', 'Should be idempotent'),
              dataRow('Async dispose', 'Channel call may not complete'),
            ],
          )),
      infoCard(
          'Memory Profile',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Controller size', '~64 bytes'),
              dataRow('Client list', 'Proportional to client count'),
              dataRow('Channel ref', 'Shared singleton'),
              dataRow('After dispose', 'Near-zero retained'),
            ],
          )),
    ],
  );

  // ─── Section 10: Error Handling ───
  print('[Section 10] Error Handling');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Error Handling'),
      noteBox(
          'The controller handles platform errors gracefully. When the '
          'system context menu API is unavailable, operations silently '
          'no-op rather than throwing exceptions.'),
      infoCard(
          'Error Scenarios',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Unsupported platform', 'show() returns false'),
              dataRow('Menu already showing', 'Previous hidden first'),
              dataRow('Channel error', 'PlatformException caught'),
              dataRow('Disposed controller', 'AssertionError in debug'),
            ],
          )),
      infoCard(
          'Fallback Strategies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Check isSupported', 'Before calling show()'),
              dataRow('Try-catch', 'Wrap show() for safety'),
              dataRow('Flutter menu fallback', 'Use contextMenuBuilder'),
              dataRow('Feature detection', 'Runtime platform check'),
            ],
          )),
    ],
  );

  // ─── Section 11: Testing Approaches ───
  print('[Section 11] Testing Approaches');

  final testApproaches = <Map<String, String>>[
    {'test': 'Show request', 'verify': 'Channel message sent with rect'},
    {'test': 'Hide request', 'verify': 'Channel message sent'},
    {'test': 'Client notification', 'verify': 'handleSystemHide called'},
    {'test': 'Dispose cleanup', 'verify': 'No lingering references'},
    {'test': 'Unsupported platform', 'verify': 'Graceful no-op'},
    {'test': 'Multiple show/hide', 'verify': 'State stays consistent'},
  ];

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Testing Approaches'),
      noteBox(
          'Testing the controller requires intercepting platform channel '
          'messages. Flutter\'s TestDefaultBinaryMessenger enables this '
          'by capturing and simulating channel traffic.'),
      for (final test in testApproaches)
        infoCard(
            'Test: ${test['test']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Scenario', test['test']!),
                dataRow('Verify', test['verify']!),
                dataRow('Type', 'Unit / Widget test'),
              ],
            )),
    ],
  );

  // ─── Section 12: Comparison with Other Controllers ───
  print('[Section 12] Comparison with Other Controllers');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Comparison with Other Controllers'),
      noteBox(
          'Flutter has several controller classes that manage platform '
          'interactions. The SystemContextMenuController follows a '
          'consistent pattern seen throughout the framework.'),
      infoCard(
          'Controller Family',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextInputConnection', 'Text input lifecycle'),
              dataRow('AnimationController', 'Animation lifecycle'),
              dataRow('ScrollController', 'Scroll position lifecycle'),
              dataRow('ContextMenuController', 'System menu lifecycle'),
            ],
          )),
      infoCard(
          'Design Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Lifecycle managed', 'Create → use → dispose'),
              dataRow('Platform bridge', 'Abstracts channel details'),
              dataRow('Observable', 'Clients/listeners can register'),
              dataRow('Widget-owned', 'Created and disposed by widgets'),
            ],
          )),
    ],
  );

  // ─── Section 13: Security Considerations ───
  print('[Section 13] Security Considerations');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Security Considerations'),
      noteBox(
          'The system context menu has security implications — it can '
          'display clipboard content and provide access to system features. '
          'Apps should be aware of what the menu might expose.'),
      infoCard(
          'Clipboard Exposure',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Paste preview', 'Some platforms show clipboard text'),
              dataRow('Sensitive data', 'Passwords may appear in paste'),
              dataRow('Mitigation', 'Clear clipboard after sensitive ops'),
              dataRow('iOS 16+', 'Paste permission prompt'),
            ],
          )),
      infoCard(
          'Menu Item Access',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Share', 'Can share selected text externally'),
              dataRow('Look Up', 'Sends text to dictionary service'),
              dataRow('Translate', 'Sends text to translation service'),
              dataRow('Services (macOS)', 'Third-party service access'),
            ],
          )),
    ],
  );

  // ─── Section 14: Performance & Optimization ───
  print('[Section 14] Performance & Optimization');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Performance & Optimization'),
      noteBox(
          'The controller itself has minimal performance impact. The '
          'main cost is the platform channel round-trip for show/hide '
          'operations, which is typically under 5ms.'),
      infoCard(
          'Timing Profile',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('show() call', 0.08, garnet),
              progressBar('Channel round-trip', 0.12, crimson),
              progressBar('Menu render (native)', 0.20, ruby),
              progressBar('hide() call', 0.05, coral),
            ],
          )),
      infoCard(
          'Optimization Tips',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Debounce show', 'Avoid rapid show/hide cycles'),
              dataRow('Single instance', 'Reuse controller across shows'),
              dataRow('Lazy creation', 'Create only when needed'),
              dataRow('Dispose early', 'Free when widget deactivates'),
            ],
          )),
    ],
  );

  // ─── Section 15: Best Practices ───
  print('[Section 15] Best Practices');

  final practices = <Map<String, String>>[
    {'practice': 'Check isSupported first', 'reason': 'Avoid no-op on unsupported platforms'},
    {'practice': 'Dispose in widget dispose', 'reason': 'Prevent memory leaks'},
    {'practice': 'Hide before show', 'reason': 'Ensure clean state transition'},
    {'practice': 'Use with client mixin', 'reason': 'Complete event coverage'},
    {'practice': 'Provide Flutter fallback', 'reason': 'Works on all platforms'},
    {'practice': 'Test channel messages', 'reason': 'Verify correct platform API usage'},
  ];

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Best Practices'),
      noteBox(
          'These practices ensure reliable and cross-platform system '
          'context menu management across all supported environments.'),
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
      noteBox('Comprehensive overview of the SystemContextMenuController deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Garnet', garnet),
              colorSwatch('Rose', rose),
              colorSwatch('Deep Garnet', deepGarnet),
              colorSwatch('Pale Pink', palePink),
              colorSwatch('Crimson', crimson),
              colorSwatch('Blush', blush),
              colorSwatch('Maroon', maroon),
              colorSwatch('Ruby', ruby),
              colorSwatch('Petal', petal),
              colorSwatch('Coral', coral),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, garnet),
              progressBar('API Surface', 1.0, crimson),
              progressBar('Show/Hide Lifecycle', 1.0, ruby),
              progressBar('Platform Channel', 1.0, coral),
              progressBar('Target Rect', 1.0, rose),
              progressBar('Client Management', 1.0, garnet),
              progressBar('Platform Support', 1.0, crimson),
              progressBar('EditableText Integration', 1.0, ruby),
              progressBar('Dispose & Cleanup', 1.0, coral),
              progressBar('Error Handling', 1.0, rose),
              progressBar('Testing', 1.0, garnet),
              progressBar('Controller Comparison', 1.0, crimson),
              progressBar('Security', 1.0, ruby),
              progressBar('Performance', 1.0, coral),
              progressBar('Best Practices', 1.0, rose),
              progressBar('Dashboard', 1.0, garnet),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Garnet / Rose'),
              dataRow('Palette colors', '10'),
              dataRow('Lifecycle phases', '${lifecycle.length}'),
              dataRow('Platform support', '${platformSupport.length}'),
              dataRow('Test approaches', '${testApproaches.length}'),
              dataRow('Best practices', '${practices.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('ContextMenuController', garnet, Colors.white),
          tag('Platform Channel', crimson, Colors.white),
          tag('Show/Hide', ruby, Colors.white),
          tag('Services', coral, Colors.white),
          tag('Lifecycle', maroon, Colors.white),
          tag('Desktop', deepGarnet, Colors.white),
          tag('Mobile', rose, Colors.white),
          tag('Controller', garnet.withValues(alpha: 0.8), Colors.white),
        ],
      ),
    ],
  );

  print('===== END SYSTEM CONTEXT MENU CONTROLLER DEEP DEMO =====');

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
