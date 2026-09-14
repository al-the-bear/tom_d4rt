// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ClipboardStatusNotifier
// Demonstrates ClipboardStatusNotifier — a ValueNotifier<ClipboardStatus>
// that polls the system clipboard to determine whether pasteable content
// is available. Used by text editing widgets and paste buttons to
// enable/disable themselves reactively.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClipboardStatusNotifier Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ClipboardStatusNotifier?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.content_paste,
      'title': 'Clipboard Awareness',
      'body': 'ClipboardStatusNotifier is a ValueNotifier that tracks '
          'whether the system clipboard contains pasteable content. '
          'It periodically polls the platform clipboard and notifies '
          'listeners when the status changes. This allows UI elements '
          'like paste buttons to reactively enable or disable '
          'themselves based on clipboard state.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.notifications_active,
      'title': 'ValueNotifier<ClipboardStatus>',
      'body': 'It extends ValueNotifier<ClipboardStatus>, so you '
          'can listen to it like any other ChangeNotifier. The value '
          'is one of ClipboardStatus.pasteable, .unknown, or '
          '.notPasteable. You can use ValueListenableBuilder to '
          'rebuild widgets whenever the clipboard status changes.',
      'accent': Colors.green[600]!,
    },
    {
      'icon': Icons.timer_outlined,
      'title': 'Polling Mechanism',
      'body': 'Since there is no clipboard-change event on most '
          'platforms, ClipboardStatusNotifier polls the clipboard '
          'at regular intervals when it has listeners. It calls '
          'Clipboard.hasStrings() which returns a Future<bool> via '
          'the platform channel. When listeners are added or '
          'removed, polling starts or stops automatically.',
      'accent': Colors.teal[500]!,
    },
    {
      'icon': Icons.text_fields,
      'title': 'Text Editing Integration',
      'body': 'Flutter\'s text editing widgets (TextField, '
          'EditableText) use ClipboardStatusNotifier internally to '
          'decide whether to show the "Paste" option in the text '
          'selection toolbar. When the clipboard is empty, the Paste '
          'button is hidden or disabled.',
      'accent': Colors.green[500]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: ClipboardStatus Enum
  // ============================================================
  print('=== Section 2: ClipboardStatus Enum ===');

  final statusValues = <Map<String, dynamic>>[
    {
      'value': 'ClipboardStatus.pasteable',
      'icon': Icons.check_circle,
      'color': Colors.green[600]!,
      'meaning': 'The clipboard contains content that can be pasted. '
          'Clipboard.hasStrings() returned true. UI should enable '
          'paste buttons and show paste options.',
      'example': 'User copied text from another app → pasteable',
    },
    {
      'value': 'ClipboardStatus.notPasteable',
      'icon': Icons.block,
      'color': Colors.red[500]!,
      'meaning': 'The clipboard is empty or does not contain string '
          'content. Clipboard.hasStrings() returned false. UI should '
          'disable or hide paste buttons.',
      'example': 'Fresh app start, nothing copied → notPasteable',
    },
    {
      'value': 'ClipboardStatus.unknown',
      'icon': Icons.help_outline,
      'color': Colors.orange[600]!,
      'meaning': 'The clipboard status has not been determined yet. '
          'This is the initial state before the first poll completes. '
          'The async Clipboard.hasStrings() call is still pending.',
      'example': 'Just created the notifier → unknown until poll',
    },
  ];

  print('  Prepared ${statusValues.length} status values');

  // ============================================================
  // SECTION 3: How Polling Works
  // ============================================================
  print('=== Section 3: Polling ===');

  final pollingSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Listener Added',
      'color': Colors.teal[700]!,
      'detail': 'When the first listener is added via addListener(), '
          'the notifier starts polling. It immediately calls '
          'update() to check the current clipboard state.',
    },
    {
      'step': 2,
      'title': 'Clipboard.hasStrings()',
      'color': Colors.green[600]!,
      'detail': 'update() calls Clipboard.hasStrings() via the '
          'platform channel. This is async — it sends a message '
          'to the native platform and waits for a boolean response.',
    },
    {
      'step': 3,
      'title': 'Value Update',
      'color': Colors.teal[500]!,
      'detail': 'When the Future completes, the notifier sets its '
          'value to pasteable or notPasteable based on the result. '
          'If the value changed, all listeners are notified.',
    },
    {
      'step': 4,
      'title': 'Periodic Re-poll',
      'color': Colors.green[500]!,
      'detail': 'The notifier does not continuously poll on a timer. '
          'Instead, it re-polls when update() is called explicitly '
          'or when the app regains focus (via didChangeAppLifecycleState). '
          'Text editing widgets call update() when the toolbar is shown.',
    },
    {
      'step': 5,
      'title': 'Listeners Removed',
      'color': Colors.teal[400]!,
      'detail': 'When the last listener is removed, polling stops. '
          'The notifier becomes idle. This prevents unnecessary '
          'platform channel calls when no widget cares about '
          'clipboard status.',
    },
  ];

  print('  Prepared ${pollingSteps.length} polling steps');

  // ============================================================
  // SECTION 4: Usage Patterns
  // ============================================================
  print('=== Section 4: Usage Patterns ===');

  final usagePatterns = <Map<String, dynamic>>[
    {
      'title': 'ValueListenableBuilder Pattern',
      'color': Colors.teal[700]!,
      'code': '// Create the notifier\n'
          'final clipNotifier =\n'
          '    ClipboardStatusNotifier();\n'
          '\n'
          '// In build():\n'
          'ValueListenableBuilder<ClipboardStatus>(\n'
          '  valueListenable: clipNotifier,\n'
          '  builder: (context, status, child) {\n'
          '    final canPaste =\n'
          '      status == ClipboardStatus.pasteable;\n'
          '    return IconButton(\n'
          '      icon: Icon(Icons.paste),\n'
          '      onPressed: canPaste\n'
          '        ? () => _handlePaste()\n'
          '        : null,  // disabled\n'
          '    );\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Manual Listener Pattern',
      'color': Colors.green[600]!,
      'code': 'class _MyState extends State<MyWidget> {\n'
          '  late ClipboardStatusNotifier _clip;\n'
          '  ClipboardStatus _status =\n'
          '    ClipboardStatus.unknown;\n'
          '\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    _clip = ClipboardStatusNotifier();\n'
          '    _clip.addListener(_onChanged);\n'
          '    _clip.update(); // initial poll\n'
          '  }\n'
          '\n'
          '  void _onChanged() {\n'
          '    setState(() {\n'
          '      _status = _clip.value;\n'
          '    });\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  void dispose() {\n'
          '    _clip.removeListener(_onChanged);\n'
          '    _clip.dispose();\n'
          '    super.dispose();\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Explicit update() Call',
      'color': Colors.teal[500]!,
      'code': '// The text editing toolbar does this:\n'
          '//\n'
          '// When toolbar becomes visible:\n'
          '//   clipboardStatusNotifier.update();\n'
          '//\n'
          '// This forces an immediate re-check\n'
          '// of the clipboard contents, ensuring\n'
          '// the paste button reflects the latest\n'
          '// clipboard state.\n'
          '//\n'
          '// Without update(), the notifier may\n'
          '// show stale .unknown status if no\n'
          '// poll has occurred recently.',
    },
    {
      'title': 'Dispose Correctly',
      'color': Colors.green[500]!,
      'code': '// ALWAYS dispose ClipboardStatusNotifier\n'
          '// when done. It holds platform resources.\n'
          '//\n'
          '// ❌ Wrong:\n'
          '//   final notifier = ClipboardStatusNotifier();\n'
          '//   // forgotten — leaks resources\n'
          '//\n'
          '// ✅ Right:\n'
          '//   @override\n'
          '//   void dispose() {\n'
          '//     _notifier.dispose();\n'
          '//     super.dispose();\n'
          '//   }\n'
          '//\n'
          '// dispose() removes all listeners and\n'
          '// stops any pending clipboard queries.',
    },
  ];

  print('  Prepared ${usagePatterns.length} usage patterns');

  // ============================================================
  // SECTION 5: Internal Architecture
  // ============================================================
  print('=== Section 5: Architecture ===');

  final architectureCards = <Map<String, dynamic>>[
    {
      'title': 'Platform Channel Layer',
      'icon': Icons.swap_horiz,
      'color': Colors.teal[700]!,
      'body': 'Clipboard.hasStrings() uses the flutter/platform '
          'SystemChannels.platform channel to query the native '
          'clipboard. On Android it calls getSystemService(CLIPBOARD), '
          'on iOS it checks UIPasteboard. The result travels back '
          'as a Map with a "value" key.',
    },
    {
      'title': 'Async but Cached',
      'icon': Icons.cached,
      'color': Colors.green[600]!,
      'body': 'The notifier caches the last known status in its '
          'value property. Between polls, the cached value is '
          'used. This means the UI never blocks on clipboard '
          'queries — it shows the last known state immediately.',
    },
    {
      'title': 'App Lifecycle Awareness',
      'icon': Icons.swap_vert_circle,
      'color': Colors.teal[500]!,
      'body': 'ClipboardStatusNotifier can re-poll when the app '
          'resumes from background. When a user switches to '
          'another app, copies text, and returns, the notifier '
          'detects the new clipboard content on the next update().',
    },
    {
      'title': 'Error Handling',
      'icon': Icons.shield,
      'color': Colors.green[500]!,
      'body': 'If the platform channel call fails (e.g., on web '
          'where clipboard access may be restricted), the notifier '
          'keeps its current value or falls back to unknown. It '
          'does not throw — clipboard access is best-effort.',
    },
  ];

  print('  Prepared ${architectureCards.length} architecture cards');

  // ============================================================
  // SECTION 6: Visual Clipboard Status Display
  // ============================================================
  print('=== Section 6: Visual Display ===');

  final statusDisplays = <Map<String, dynamic>>[
    {
      'status': 'pasteable',
      'icon': Icons.content_paste_go,
      'bgColor': Colors.green[50]!,
      'borderColor': Colors.green[400]!,
      'iconColor': Colors.green[600]!,
      'label': 'Paste Available',
      'desc': 'Clipboard has string content. The paste button is '
          'enabled. User can paste into text fields.',
    },
    {
      'status': 'notPasteable',
      'icon': Icons.content_paste_off,
      'bgColor': Colors.red[50]!,
      'borderColor': Colors.red[300]!,
      'iconColor': Colors.red[400]!,
      'label': 'Nothing to Paste',
      'desc': 'Clipboard is empty or has non-string content. The '
          'paste button is disabled or hidden.',
    },
    {
      'status': 'unknown',
      'icon': Icons.content_paste_search,
      'bgColor': Colors.orange[50]!,
      'borderColor': Colors.orange[300]!,
      'iconColor': Colors.orange[500]!,
      'label': 'Checking...',
      'desc': 'Status not yet determined. Waiting for the platform '
          'to respond. Usually resolves within milliseconds.',
    },
  ];

  print('  Prepared ${statusDisplays.length} status displays');

  // ============================================================
  // SECTION 7: Related Classes
  // ============================================================
  print('=== Section 7: Related Classes ===');

  final relatedClasses = <Map<String, dynamic>>[
    {
      'class': 'Clipboard',
      'role': 'Static access to the system clipboard',
      'color': Colors.teal[700]!,
      'desc': 'Clipboard class provides static methods: getData(), '
          'setData(), hasStrings(). ClipboardStatusNotifier wraps '
          'hasStrings() with a notifier pattern.',
    },
    {
      'class': 'ClipboardStatus',
      'role': 'Enum representing clipboard state',
      'color': Colors.green[600]!,
      'desc': 'The three-value enum: pasteable, notPasteable, unknown. '
          'This is the value type of ClipboardStatusNotifier.',
    },
    {
      'class': 'TextSelectionControls',
      'role': 'Toolbar that uses clipboard status',
      'color': Colors.teal[500]!,
      'desc': 'The text selection toolbar (copy/cut/paste/select all) '
          'queries ClipboardStatusNotifier to decide whether to show '
          'the Paste button.',
    },
    {
      'class': 'EditableTextState',
      'role': 'Text editing state manager',
      'color': Colors.green[500]!,
      'desc': 'EditableTextState creates and manages a '
          'ClipboardStatusNotifier internally, using it to control '
          'toolbar button visibility during text selection.',
    },
    {
      'class': 'ValueNotifier<T>',
      'role': 'Base class',
      'color': Colors.teal[400]!,
      'desc': 'ClipboardStatusNotifier extends ValueNotifier, '
          'inheriting the listener pattern, value property, and '
          'automatic notification on value change.',
    },
  ];

  print('  Prepared ${relatedClasses.length} related classes');

  // ============================================================
  // SECTION 8: Edge Cases & Platform Differences
  // ============================================================
  print('=== Section 8: Edge Cases ===');

  final edgeCases = <Map<String, dynamic>>[
    {
      'platform': 'Web',
      'icon': Icons.web,
      'color': Colors.blue[600]!,
      'detail': 'Clipboard access on web is restricted by browser '
          'security policies. Clipboard.hasStrings() may always '
          'return false or throw. ClipboardStatusNotifier handles '
          'this gracefully by staying at unknown.',
    },
    {
      'platform': 'macOS',
      'icon': Icons.laptop_mac,
      'color': Colors.grey[700]!,
      'detail': 'macOS supports clipboard change count, so polling '
          'can efficiently detect changes without reading content. '
          'The platform implementation uses changeCount to check '
          'if the clipboard has changed since the last query.',
    },
    {
      'platform': 'Android',
      'icon': Icons.android,
      'color': Colors.green[700]!,
      'detail': 'Android provides clipboard change listeners via '
          'ClipboardManager. However, the Flutter platform channel '
          'currently uses polling rather than native listeners. '
          'Future versions may use native events.',
    },
    {
      'platform': 'Images & Rich Content',
      'icon': Icons.image,
      'color': Colors.purple[500]!,
      'detail': 'ClipboardStatusNotifier only checks for string '
          'content via hasStrings(). If the clipboard contains '
          'an image or rich media but no plain text, the status '
          'will be notPasteable for text paste operations.',
    },
  ];

  print('  Prepared ${edgeCases.length} edge cases');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Call update() at the Right Time',
      'body': 'Don\'t rely on automatic polling alone. Call update() '
          'when you show a paste-related UI to ensure fresh status. '
          'The toolbar does this, and so should your custom paste '
          'buttons.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Always Dispose',
      'body': 'ClipboardStatusNotifier maintains platform resources. '
          'Forgetting to dispose it creates a resource leak. In '
          'StatefulWidget, dispose it in State.dispose().',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Handle Unknown Gracefully',
      'body': 'The initial status is unknown until the first poll '
          'completes. Design your UI to handle this state — either '
          'show the paste button as disabled or optimistically '
          'enabled while the poll is in flight.',
      'severity': 'tip',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'One Notifier Per Context',
      'body': 'Create one ClipboardStatusNotifier per editing '
          'context, not a global singleton. Different text fields '
          'may need to poll at different times. Having a per-widget '
          'notifier ensures correct lifecycle management.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Web Clipboard Limitations',
      'body': 'On web, clipboard reads require user gesture and '
          'Permissions API. ClipboardStatusNotifier may not work '
          'accurately. Test your web app separately and consider '
          'always showing the paste button on web.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine with Clipboard.getData',
      'body': 'ClipboardStatusNotifier tells you IF you can paste. '
          'To actually paste, use Clipboard.getData(\'text/plain\'). '
          'Check the notifier first to avoid unnecessary async calls '
          'to getData when the clipboard is empty.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('ClipboardStatusNotifier'),
      backgroundColor: Colors.teal[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal[700]!, Colors.green[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.content_paste, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ClipboardStatusNotifier',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A ValueNotifier<ClipboardStatus> that polls the system '
                  'clipboard to determine whether pasteable content is '
                  'available. Enables reactive paste buttons and toolbar '
                  'integration across all Flutter text editing widgets.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _cnHead('1', 'What is ClipboardStatusNotifier?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Enum Values ──
          _cnHead('2', 'ClipboardStatus Enum'),
          SizedBox(height: 12),
          ...statusValues.map((sv) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: sv['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(sv['icon'] as IconData,
                            color: sv['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(sv['value'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: sv['color'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(sv['meaning'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: (sv['color'] as Color).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(sv['example'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Polling ──
          _cnHead('3', 'How Polling Works'),
          SizedBox(height: 12),
          ...pollingSteps.map((ps) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ps['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: ps['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${ps['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ps['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 4),
                            Text(ps['detail'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Code Patterns ──
          _cnHead('4', 'Usage Patterns'),
          SizedBox(height: 12),
          ...usagePatterns.map((up) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: up['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(up['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(up['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.teal[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Architecture ──
          _cnHead('5', 'Internal Architecture'),
          SizedBox(height: 12),
          ...architectureCards.map((ac) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ac['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ac['icon'] as IconData,
                            color: ac['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ac['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(ac['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Visual Status Display ──
          _cnHead('6', 'Visual Clipboard States'),
          SizedBox(height: 12),
          ...statusDisplays.map((sd) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: sd['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: sd['borderColor'] as Color, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (sd['iconColor'] as Color)
                              .withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(sd['icon'] as IconData,
                              color: sd['iconColor'] as Color, size: 28),
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sd['label'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: sd['iconColor'] as Color)),
                            SizedBox(height: 2),
                            Text(sd['status'] as String,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: Colors.grey[500])),
                            SizedBox(height: 4),
                            Text(sd['desc'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Related Classes ──
          _cnHead('7', 'Related Classes'),
          SizedBox(height: 12),
          ...relatedClasses.map((rc) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: rc['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        _cnTag(rc['class'] as String,
                            rc['color'] as Color),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(rc['role'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(rc['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Edge Cases ──
          _cnHead('8', 'Platform Differences'),
          SizedBox(height: 12),
          ...edgeCases.map((ec) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (ec['color'] as Color).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (ec['color'] as Color).withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ec['icon'] as IconData,
                            color: ec['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(ec['platform'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: ec['color'] as Color)),
                      ]),
                      SizedBox(height: 8),
                      Text(ec['detail'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _cnHead('9', 'Tips & Best Practices'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),
          Center(
            child: Text(
              'End of ClipboardStatusNotifier Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _cnHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.teal[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Class name tag
// ──────────────────────────────────────────────────────────
Widget _cnTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
