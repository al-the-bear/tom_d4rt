// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DoNothingAction
// Demonstrates DoNothingAction — a built-in Action that deliberately
// does nothing when invoked, used to swallow or block keyboard shortcuts
// at a specific point in the widget tree. Key parameter: consumesKey.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DoNothingAction Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DoNothingAction?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.block,
      'title': 'An Action That Does Nothing',
      'body': 'DoNothingAction is a built-in Action<DoNothingIntent> '
          'that, when invoked, deliberately performs no operation. '
          'It exists purely to intercept and swallow keyboard '
          'shortcuts at a specific point in the widget tree, '
          'preventing them from propagating upward to ancestor '
          'handlers.',
      'accent': Colors.brown[700]!,
    },
    {
      'icon': Icons.shield,
      'title': 'Shortcut Blocker',
      'body': 'The primary use case is blocking shortcuts you do not '
          'want handled in a specific subtree. Wrap a subtree in an '
          'Actions widget mapping DoNothingIntent() to DoNothingAction() '
          'and the shortcut is silently consumed — no handler fires.',
      'accent': Colors.blueGrey[700]!,
    },
    {
      'icon': Icons.swap_vert,
      'title': 'consumesKey Parameter',
      'body': 'The critical parameter is consumesKey (defaults to true). '
          'When true, the action reports that it consumed the key '
          'event, stopping further propagation. When false, the '
          'action does nothing but the key event still bubbles up, '
          'allowing a parent handler to act on it.',
      'accent': Colors.brown[600]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Works with Shortcuts Widget',
      'body': 'DoNothingAction is typically used alongside the Shortcuts '
          'widget. Map a key combination to DoNothingIntent(), then '
          'register DoNothingAction() in an Actions widget. The '
          'shortcut fires, the action swallows it, done.',
      'accent': Colors.blueGrey[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: consumesKey Behavior
  // ============================================================
  print('=== Section 2: consumesKey ===');

  final consumesRows = <Map<String, dynamic>>[
    {
      'scenario': 'consumesKey: true (default)',
      'icon': Icons.cancel,
      'color': Colors.red[600]!,
      'keyAction': 'Key event is consumed — stops propagating',
      'parentSees': 'Parent NEVER sees the shortcut',
      'useCase': 'Silently swallow a shortcut entirely',
      'example': 'Ctrl+S in a read-only view — editor should NOT save',
    },
    {
      'scenario': 'consumesKey: false',
      'icon': Icons.arrow_upward,
      'color': Colors.green[600]!,
      'keyAction': 'Key event is NOT consumed — continues bubbling',
      'parentSees': 'Parent CAN still handle the shortcut',
      'useCase': 'Prevent local handling but allow parent handling',
      'example': 'Override local Escape behavior but let parent '
          'close a modal',
    },
  ];

  print('  Prepared ${consumesRows.length} consumesKey scenarios');

  // ============================================================
  // SECTION 3: Properties & Constructor
  // ============================================================
  print('=== Section 3: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'consumesKey',
      'type': 'bool',
      'icon': Icons.vpn_key,
      'color': Colors.brown[700]!,
      'description': 'Whether this action reports that it consumed the '
          'key event. When true (default), the key event stops '
          'propagating after this action handles it. When false, '
          'the event continues bubbling to parent Actions widgets.',
    },
    {
      'name': 'intentType',
      'type': 'Type (inherited)',
      'icon': Icons.category,
      'color': Colors.blueGrey[700]!,
      'description': 'The type of Intent this Action handles — always '
          'DoNothingIntent for DoNothingAction. DoNothingIntent is '
          'a simple Intent subclass with no payload or configuration.',
    },
    {
      'name': 'isEnabled(intent)',
      'type': 'bool (method)',
      'icon': Icons.check_circle,
      'color': Colors.brown[600]!,
      'description': 'Always returns true. The action is unconditionally '
          'enabled — it will always handle DoNothingIntent when '
          'invoked. There is no condition that disables it.',
    },
    {
      'name': 'invoke(intent)',
      'type': 'void (method)',
      'icon': Icons.not_interested,
      'color': Colors.blueGrey[600]!,
      'description': 'Does literally nothing. The method body is empty. '
          'The entire purpose is the consumesKey flag that controls '
          'whether the key event is reported as handled.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 4: How It Fits in the Actions System
  // ============================================================
  print('=== Section 4: Actions System ===');

  final flowSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Key Event',
      'color': Colors.brown[700]!,
      'detail': 'User presses a key combination (e.g., Ctrl+S). The '
          'RawKeyEvent enters the widget tree starting from the '
          'focused widget and begins traversing up.',
    },
    {
      'step': 2,
      'title': 'Shortcuts Widget Matches',
      'color': Colors.blueGrey[700]!,
      'detail': 'A Shortcuts widget in the tree has a KeyboardKey map '
          'entry matching Ctrl+S → DoNothingIntent(). It creates '
          'a DoNothingIntent and looks for an Action to handle it.',
    },
    {
      'step': 3,
      'title': 'Actions Widget Resolves',
      'color': Colors.brown[600]!,
      'detail': 'An Actions widget maps DoNothingIntent → '
          'DoNothingAction(). The framework calls invoke() on the '
          'DoNothingAction instance.',
    },
    {
      'step': 4,
      'title': 'invoke() Runs (Does Nothing)',
      'color': Colors.blueGrey[600]!,
      'detail': 'The invoke() method executes — and does nothing. No '
          'state changes, no callbacks, no side effects. The method '
          'body is literally empty.',
    },
    {
      'step': 5,
      'title': 'consumesKey Checked',
      'color': Colors.brown[500]!,
      'detail': 'The framework checks consumesKey on the action. If '
          'true, the key event is marked as handled — no further '
          'propagation. If false, the event continues bubbling up.',
    },
  ];

  print('  Prepared ${flowSteps.length} flow steps');

  // ============================================================
  // SECTION 5: Use Cases
  // ============================================================
  print('=== Section 5: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Block Save in Read-Only Views',
      'icon': Icons.save,
      'color': Colors.brown[700]!,
      'description': 'A document viewer that inherits a save shortcut '
          'from the parent editor framework. The viewer is read-only '
          'and should not trigger any save operation. Map Ctrl+S to '
          'DoNothingAction to silently ignore the shortcut.',
      'shortcut': 'Ctrl+S → DoNothingIntent()',
    },
    {
      'title': 'Disable Escape in Nested Dialogs',
      'icon': Icons.close,
      'color': Colors.blueGrey[700]!,
      'description': 'A confirmation dialog where pressing Escape should '
          'not dismiss the dialog (because the user must click a '
          'button to respond). Map Escape to DoNothingAction with '
          'consumesKey: true to prevent the dismiss behavior.',
      'shortcut': 'Escape → DoNothingIntent()',
    },
    {
      'title': 'Override Platform Defaults',
      'icon': Icons.desktop_mac,
      'color': Colors.brown[600]!,
      'description': 'Platform-level shortcuts like Ctrl+A (select all) '
          'or Ctrl+Z (undo) can be blocked in specific subtrees '
          'where those operations are not meaningful, without '
          'affecting the rest of the application.',
      'shortcut': 'Ctrl+A → DoNothingIntent()',
    },
    {
      'title': 'Prevent Tab Navigation in Custom Focus',
      'icon': Icons.tab,
      'color': Colors.blueGrey[600]!,
      'description': 'In a custom focus management system (e.g., a grid '
          'with arrow key navigation), block Tab from changing focus '
          'by mapping Tab to DoNothingAction. Focus is managed '
          'entirely by your custom arrow key handler.',
      'shortcut': 'Tab → DoNothingIntent()',
    },
    {
      'title': 'consumesKey: false — Override Local, Allow Parent',
      'icon': Icons.arrow_upward,
      'color': Colors.brown[500]!,
      'description': 'A child widget has a shortcut handler you want to '
          'disable, but the parent should still handle the same '
          'shortcut. Use consumesKey: false so the action fires '
          'locally (doing nothing) but the event still reaches '
          'the parent\'s handler.',
      'shortcut': 'Any key → DoNothingAction(consumesKey: false)',
    },
  ];

  print('  Prepared ${useCases.length} use cases');

  // ============================================================
  // SECTION 6: Code Patterns
  // ============================================================
  print('=== Section 6: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Basic: Block a Shortcut',
      'color': Colors.brown[700]!,
      'code': '// Block Ctrl+S in a read-only view\n'
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    SingleActivator(\n'
          '      LogicalKeyboardKey.keyS,\n'
          '      control: true,\n'
          '    ): DoNothingIntent(),\n'
          '  },\n'
          '  child: Actions(\n'
          '    actions: <Type, Action<Intent>>{\n'
          '      DoNothingIntent:\n'
          '          DoNothingAction(),\n'
          '    },\n'
          '    child: _buildReadOnlyView(),\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'consumesKey: false — Bubble to Parent',
      'color': Colors.blueGrey[700]!,
      'code': '// Do nothing locally but let parent\n'
          '// still handle the shortcut\n'
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    SingleActivator(\n'
          '      LogicalKeyboardKey.escape,\n'
          '    ): DoNothingIntent(),\n'
          '  },\n'
          '  child: Actions(\n'
          '    actions: <Type, Action<Intent>>{\n'
          '      DoNothingIntent:\n'
          '          DoNothingAction(\n'
          '            consumesKey: false,\n'
          '          ),\n'
          '    },\n'
          '    child: _buildChildView(),\n'
          '  ),\n'
          ')\n'
          '// Parent can still see Escape',
    },
    {
      'title': 'Block Multiple Shortcuts',
      'color': Colors.brown[600]!,
      'code': '// Block multiple shortcuts at once\n'
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    SingleActivator(\n'
          '      LogicalKeyboardKey.keyS,\n'
          '      control: true,\n'
          '    ): DoNothingIntent(),\n'
          '    SingleActivator(\n'
          '      LogicalKeyboardKey.keyZ,\n'
          '      control: true,\n'
          '    ): DoNothingIntent(),\n'
          '    SingleActivator(\n'
          '      LogicalKeyboardKey.keyA,\n'
          '      control: true,\n'
          '    ): DoNothingIntent(),\n'
          '  },\n'
          '  child: Actions(\n'
          '    actions: <Type, Action<Intent>>{\n'
          '      DoNothingIntent:\n'
          '          DoNothingAction(),\n'
          '    },\n'
          '    child: _buildProtectedArea(),\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'CallbackShortcuts Alternative',
      'color': Colors.blueGrey[600]!,
      'code': '// For simple cases, CallbackShortcuts\n'
          '// can also block shortcuts with an\n'
          '// empty callback. But DoNothingAction\n'
          '// is more semantic and composable.\n'
          '\n'
          '// Less clear — empty callback:\n'
          'CallbackShortcuts(\n'
          '  bindings: {\n'
          '    SingleActivator(\n'
          '      LogicalKeyboardKey.keyS,\n'
          '      control: true,\n'
          '    ): () {},  // Does nothing\n'
          '  },\n'
          '  child: _buildView(),\n'
          ')\n'
          '\n'
          '// Better — explicit DoNothingAction:\n'
          '// Shortcuts + Actions + DoNothingAction',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 7: Event Propagation Diagram
  // ============================================================
  print('=== Section 7: Event Propagation ===');

  final propagationScenarios = <Map<String, dynamic>>[
    {
      'title': 'Normal: Shortcut Handled',
      'color': Colors.green[600]!,
      'steps': [
        'Key pressed → Shortcuts matches → Intent created',
        'Actions finds handler → invoke() runs',
        'Handler performs operation (e.g., saves file)',
        'Event consumed ✓',
      ],
    },
    {
      'title': 'DoNothingAction (consumesKey: true)',
      'color': Colors.brown[700]!,
      'steps': [
        'Key pressed → Shortcuts matches → DoNothingIntent',
        'Actions finds DoNothingAction → invoke() runs',
        'invoke() does NOTHING (empty body)',
        'Event consumed ✓ — parent never sees it',
      ],
    },
    {
      'title': 'DoNothingAction (consumesKey: false)',
      'color': Colors.blueGrey[700]!,
      'steps': [
        'Key pressed → Shortcuts matches → DoNothingIntent',
        'Actions finds DoNothingAction → invoke() runs',
        'invoke() does NOTHING (empty body)',
        'Event NOT consumed → bubbles to parent ↑',
      ],
    },
    {
      'title': 'No Action Registered',
      'color': Colors.grey[600]!,
      'steps': [
        'Key pressed → Shortcuts matches → Intent created',
        'Actions looks for handler → not found',
        'Event bubbles to parent Shortcuts/Actions ↑',
        'Parent may or may not handle it',
      ],
    },
  ];

  print('  Prepared ${propagationScenarios.length} propagation scenarios');

  // ============================================================
  // SECTION 8: Related Classes
  // ============================================================
  print('=== Section 8: Related Classes ===');

  final relatedClasses = <Map<String, dynamic>>[
    {
      'name': 'DoNothingIntent',
      'color': Colors.brown[700]!,
      'role': 'The Intent subclass that DoNothingAction handles. Has '
          'no fields or configuration — it is the simplest possible '
          'Intent. Create with DoNothingIntent().',
    },
    {
      'name': 'Action<T>',
      'color': Colors.blueGrey[700]!,
      'role': 'The base class DoNothingAction extends. Action<T> '
          'defines invoke(), isEnabled(), and consumesKey. '
          'DoNothingAction overrides invoke() to be empty and '
          'consumesKey to be configurable.',
    },
    {
      'name': 'Shortcuts',
      'color': Colors.brown[600]!,
      'role': 'Maps key combinations to Intent objects. You register '
          'a key combo → DoNothingIntent() mapping here. Without '
          'Shortcuts, DoNothingAction has nothing to intercept.',
    },
    {
      'name': 'Actions',
      'color': Colors.blueGrey[600]!,
      'role': 'Maps Intent types to Action handlers. Register '
          'DoNothingIntent → DoNothingAction() here. When Shortcuts '
          'produces a DoNothingIntent, Actions invokes your '
          'DoNothingAction.',
    },
    {
      'name': 'CallbackShortcuts',
      'color': Colors.brown[500]!,
      'role': 'A simpler alternative that maps keys directly to '
          'callbacks. An empty callback achieves a similar effect '
          'to DoNothingAction, but is less composable and less '
          'semantically clear.',
    },
    {
      'name': 'ActivateAction / DismissAction',
      'color': Colors.blueGrey[500]!,
      'role': 'Other built-in Actions that DO something — ActivateAction '
          'triggers onTap/onPressed, DismissAction pops routes. '
          'DoNothingAction is the opposite: it explicitly does nothing.',
    },
  ];

  print('  Prepared ${relatedClasses.length} related classes');

  // ============================================================
  // SECTION 9: Tips & Pitfalls
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Semantic Intent > Empty Callback',
      'body': 'Prefer DoNothingAction over an empty callback in '
          'CallbackShortcuts. DoNothingAction makes the intent '
          'explicit: "we deliberately do nothing here." An empty '
          'callback looks like a bug or forgotten implementation.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'consumesKey Matters for Composition',
      'body': 'If you set consumesKey: false, parent Actions widgets '
          'WILL still see the event. This is intentional for layered '
          'designs. But if you forget, you may wonder why the parent '
          'is still handling the shortcut you thought you blocked.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Pair with ActivateIntent for Full Control',
      'body': 'You can block default behavior and then provide custom '
          'behavior by mapping the default shortcuts to DoNothingAction '
          'and adding your own Shortcuts+Actions with different Intents '
          'for the same keys. This gives full shortcut replacement.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Does Not Block Hardware Keys',
      'body': 'DoNothingAction only operates within the Flutter '
          'Actions/Shortcuts framework. It does not block raw key '
          'handlers (RawKeyboardListener, Focus.onKey) or '
          'platform-level shortcuts (Alt+F4, Cmd+Q).',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Testing: Verify No Side Effects',
      'body': 'When testing, verify that the shortcut truly has no '
          'effect by checking that no callback fires, no state '
          'changes, and the UI remains identical. Use the Actions '
          'test helpers to invoke DoNothingIntent directly.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Document Why You Block',
      'body': 'Always add a comment explaining WHY a shortcut is '
          'blocked. "DoNothingAction" is clear about WHAT happens, '
          'but the reader needs to know WHY. Example: "// Block '
          'Ctrl+S because this view is read-only."',
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
      title: Text('DoNothingAction'),
      backgroundColor: Colors.brown[700],
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
                colors: [Colors.brown[700]!, Colors.blueGrey[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.block, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DoNothingAction',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A built-in Action that intentionally performs no '
                  'operation when invoked. Used to silently swallow or '
                  'block keyboard shortcuts at a specific point in the '
                  'widget tree. The consumesKey parameter controls '
                  'whether the key event stops propagating.',
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
          _dnHead('1', 'What is DoNothingAction?'),
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

          // ── Section 2: consumesKey Comparison ──
          _dnHead('2', 'consumesKey: true vs false'),
          SizedBox(height: 12),
          ...consumesRows.map((cr) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cr['color'] as Color, width: 4),
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
                        Icon(cr['icon'] as IconData,
                            color: cr['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(cr['scenario'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 8),
                      _dnBadge('Key Event', cr['keyAction'] as String,
                          cr['color'] as Color),
                      SizedBox(height: 4),
                      _dnBadge('Parent', cr['parentSees'] as String,
                          cr['color'] as Color),
                      SizedBox(height: 4),
                      _dnBadge('Use Case', cr['useCase'] as String,
                          cr['color'] as Color),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.brown[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(cr['example'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.brown[800])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Properties ──
          _dnHead('3', 'Properties & API'),
          SizedBox(height: 12),
          ...properties.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
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
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace')),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: (p['color'] as Color)
                                .withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(p['type'] as String,
                              style: TextStyle(
                                  color: p['color'] as Color,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace')),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Actions System Flow ──
          _dnHead('4', 'How It Fits in the Actions System'),
          SizedBox(height: 12),
          ...flowSteps.map((fs) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: fs['color'] as Color, width: 4),
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
                          color: fs['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${fs['step']}',
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
                            Text(fs['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 4),
                            Text(fs['detail'] as String,
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

          // ── Section 5: Use Cases ──
          _dnHead('5', 'Use Cases'),
          SizedBox(height: 12),
          ...useCases.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: uc['color'] as Color, width: 4),
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
                        Icon(uc['icon'] as IconData,
                            color: uc['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(uc['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(uc['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(uc['shortcut'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.amber[200])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Code Patterns ──
          _dnHead('6', 'Code Patterns'),
          SizedBox(height: 12),
          ...codePatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4),
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
                      Text(cp['title'] as String,
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
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.brown[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Event Propagation ──
          _dnHead('7', 'Event Propagation Scenarios'),
          SizedBox(height: 12),
          ...propagationScenarios.map((ps) => Padding(
                padding: EdgeInsets.only(bottom: 12),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ps['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: ps['color'] as Color)),
                      SizedBox(height: 8),
                      ...(ps['steps'] as List<String>)
                          .asMap()
                          .entries
                          .map((entry) {
                        final idx = entry.key;
                        final step = entry.value;
                        final isLast =
                            idx == (ps['steps'] as List).length - 1;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(isLast ? '└─' : '├─',
                                  style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 10,
                                      color: Colors.grey[400])),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(step,
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: isLast
                                            ? ps['color'] as Color
                                            : Colors.grey[700],
                                        fontWeight: isLast
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        height: 1.3)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Related Classes ──
          _dnHead('8', 'Related Classes'),
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
                      Text(rc['name'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              fontFamily: 'monospace')),
                      SizedBox(height: 6),
                      Text(rc['role'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _dnHead('9', 'Tips & Best Practices'),
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
              'End of DoNothingAction Deep Demo',
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
Widget _dnHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.brown[700],
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
// Helper: Labeled badge row
// ──────────────────────────────────────────────────────────
Widget _dnBadge(String label, String value, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 60,
        child: Text(label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9,
                color: color)),
      ),
      Expanded(
        child: Text(value,
            style: TextStyle(fontSize: 10, color: Colors.grey[700])),
      ),
    ],
  );
}
