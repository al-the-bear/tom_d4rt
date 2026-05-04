// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demonstration of the Shortcuts/Actions API.
// Covers Shortcuts widget, Actions widget, Intent, Action<T>, ActivateIntent,
// DismissIntent, LogicalKeySet bindings, CallbackAction, FocusableActionDetector.
// Visualizes the keyboard event -> Shortcut -> Intent -> Action pipeline.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF311B92),
          Color(0xFF4A148C),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.keyboard, size: 64.0, color: Colors.white),
        SizedBox(height: 12.0),
        Text(
          'Shortcuts & Actions',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Keyboard ➜ Shortcut ➜ Intent ➜ Action',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white70,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white30, width: 1.0),
          ),
          child: Text(
            'package:flutter/widgets.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.cyanAccent,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of the Keyboard Pipeline
  // ============================================================
  final pipelineNodes = [
    {
      'label': 'Key Event',
      'sub': 'KeyDownEvent',
      'icon': Icons.keyboard_alt,
      'color': Colors.blue,
    },
    {
      'label': 'Shortcuts',
      'sub': 'LogicalKeySet match',
      'icon': Icons.shortcut,
      'color': Colors.teal,
    },
    {
      'label': 'Intent',
      'sub': 'Describes "what"',
      'icon': Icons.lightbulb_outline,
      'color': Colors.amber,
    },
    {
      'label': 'Actions',
      'sub': 'Looks up handler',
      'icon': Icons.search,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Action<T>',
      'sub': 'invoke(intent)',
      'icon': Icons.flash_on,
      'color': Colors.green,
    },
  ];

  final pipelineWidgets = <Widget>[];
  for (var i = 0; i < pipelineNodes.length; i++) {
    final node = pipelineNodes[i];
    final color = node['color'] as Color;
    pipelineWidgets.add(
      Container(
        width: 110.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.15),
              color.withValues(alpha: 0.35),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(node['icon'] as IconData, size: 32.0, color: color),
            SizedBox(height: 6.0),
            Text(
              node['label'] as String,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              node['sub'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
    if (i < pipelineNodes.length - 1) {
      pipelineWidgets.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.grey.shade600,
            size: 24.0,
          ),
        ),
      );
    }
  }

  final pipelineSection = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade50, Colors.grey.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Anatomy of the Keyboard Pipeline',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: pipelineWidgets,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Each layer transforms input into intent, then delegates to a handler.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Shortcuts Widget Card
  // ============================================================
  final shortcutsCard = _buildApiCard(
    title: 'Shortcuts',
    subtitle: 'Maps key combos to Intents',
    icon: Icons.shortcut,
    primary: Colors.teal,
    secondary: Colors.tealAccent,
    description:
        'Wraps a subtree and converts hardware key events into Intent objects '
        'using a LogicalKeySet -> Intent table. The matching Intent is then '
        'dispatched up the widget tree, where Actions can pick it up.',
    code: 'Shortcuts(\n'
        '  shortcuts: <LogicalKeySet, Intent>{\n'
        '    LogicalKeySet(\n'
        '      LogicalKeyboardKey.meta,\n'
        '      LogicalKeyboardKey.keyS,\n'
        '    ): SaveIntent(),\n'
        '  },\n'
        '  child: Actions(\n'
        '    actions: { ... },\n'
        '    child: Focus(child: Editor()),\n'
        '  ),\n'
        ')',
  );

  // ============================================================
  // SECTION 4: Actions Widget Card
  // ============================================================
  final actionsCard = _buildApiCard(
    title: 'Actions',
    subtitle: 'Dispatches Intents to Action<T>',
    icon: Icons.search,
    primary: Colors.deepPurple,
    secondary: Colors.purpleAccent,
    description:
        'Wraps a subtree and provides a map from Intent type to Action<T>. '
        'When an Intent bubbles up through the tree, the nearest Actions '
        'widget that can handle it invokes the matching Action.',
    code: 'Actions(\n'
        '  actions: <Type, Action<Intent>>{\n'
        '    SaveIntent: CallbackAction<SaveIntent>(\n'
        '      onInvoke: (intent) => save(),\n'
        '    ),\n'
        '    DismissIntent: CallbackAction<DismissIntent>(\n'
        '      onInvoke: (intent) => closeDialog(),\n'
        '    ),\n'
        '  },\n'
        '  child: child,\n'
        ')',
  );

  // ============================================================
  // SECTION 5: Intent Card
  // ============================================================
  final intentCard = _buildApiCard(
    title: 'Intent',
    subtitle: 'Describes WHAT should happen',
    icon: Icons.lightbulb_outline,
    primary: Colors.amber.shade800,
    secondary: Colors.amberAccent,
    description:
        'A semantic description of an action, decoupled from any specific '
        'implementation. Common built-ins: ActivateIntent (Enter/Space), '
        'DismissIntent (Escape), DirectionalFocusIntent (arrow keys), '
        'NextFocusIntent (Tab). Custom intents are just subclasses.',
    code: 'class SaveIntent extends Intent {\n'
        '  const SaveIntent();\n'
        '}\n\n'
        'class CopyIntent extends Intent {\n'
        '  const CopyIntent();\n'
        '}\n\n'
        '// Built-in intents:\n'
        'const ActivateIntent();   // Enter / Space\n'
        'const DismissIntent();    // Escape\n'
        'const NextFocusIntent();  // Tab',
  );

  // ============================================================
  // SECTION 6: Action<T> Card
  // ============================================================
  final actionCard = _buildApiCard(
    title: 'Action<T>',
    subtitle: 'Implements HOW the intent runs',
    icon: Icons.flash_on,
    primary: Colors.green.shade700,
    secondary: Colors.lightGreenAccent,
    description:
        'A concrete handler for a specific Intent type. Override invoke() to '
        'execute the work, isEnabled() to gate availability, and consumesKey() '
        'to control whether the platform key event is swallowed.',
    code: 'class SaveAction extends Action<SaveIntent> {\n'
        '  @override\n'
        '  Object? invoke(SaveIntent intent) {\n'
        '    document.save();\n'
        '    return null;\n'
        '  }\n\n'
        '  @override\n'
        '  bool isEnabled(SaveIntent intent) =>\n'
        '      document.isDirty;\n'
        '}',
  );

  // ============================================================
  // SECTION 7: CallbackAction Recipe
  // ============================================================
  final callbackRecipe = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.2),
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
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(Icons.bolt, color: Colors.white, size: 20.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CallbackAction Recipe',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                  Text(
                    'The fastest way to wire up an action',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.green.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildRecipeStep(
          step: 1,
          title: 'Define an Intent (or use a built-in)',
          color: Colors.green,
        ),
        _buildRecipeStep(
          step: 2,
          title: 'Wrap with Shortcuts (LogicalKeySet -> Intent)',
          color: Colors.green,
        ),
        _buildRecipeStep(
          step: 3,
          title: 'Wrap with Actions, register CallbackAction<T>',
          color: Colors.green,
        ),
        _buildRecipeStep(
          step: 4,
          title: 'Place a Focus or FocusableActionDetector inside',
          color: Colors.green,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Shortcuts(\n'
            '  shortcuts: {\n'
            '    LogicalKeySet(\n'
            '      LogicalKeyboardKey.meta,\n'
            '      LogicalKeyboardKey.keyZ,\n'
            '    ): const UndoIntent(),\n'
            '  },\n'
            '  child: Actions(\n'
            '    actions: {\n'
            '      UndoIntent: CallbackAction<UndoIntent>(\n'
            '        onInvoke: (intent) => undoStack.pop(),\n'
            '      ),\n'
            '    },\n'
            '    child: Focus(\n'
            '      autofocus: true,\n'
            '      child: child,\n'
            '    ),\n'
            '  ),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.lightGreenAccent,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: FocusableActionDetector Recipe
  // ============================================================
  final detectorRecipe = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 7.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade600,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withValues(alpha: 0.5),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.center_focus_strong,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FocusableActionDetector Recipe',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade900,
                    ),
                  ),
                  Text(
                    'All-in-one: focus + shortcuts + actions + hover',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.deepPurple.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'FocusableActionDetector composes Focus + Shortcuts + Actions + '
          'MouseRegion in a single widget. It is the recommended building '
          'block for custom focusable controls (buttons, menu items, list '
          'tiles) that need both pointer and keyboard handling.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.deepPurple.shade900,
            height: 1.5,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'FocusableActionDetector(\n'
            '  shortcuts: {\n'
            '    LogicalKeySet(LogicalKeyboardKey.enter):\n'
            '        const ActivateIntent(),\n'
            '    LogicalKeySet(LogicalKeyboardKey.escape):\n'
            '        const DismissIntent(),\n'
            '  },\n'
            '  actions: {\n'
            '    ActivateIntent: CallbackAction<ActivateIntent>(\n'
            '      onInvoke: (i) => onPressed?.call(),\n'
            '    ),\n'
            '    DismissIntent: CallbackAction<DismissIntent>(\n'
            '      onInvoke: (i) => Navigator.maybePop(context),\n'
            '    ),\n'
            '  },\n'
            '  onShowFocusHighlight: (v) => setState(...),\n'
            '  onShowHoverHighlight: (v) => setState(...),\n'
            '  child: visualBuilder(),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyanAccent,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _buildPill('Focus', Colors.blue),
            SizedBox(width: 6.0),
            _buildPill('Shortcuts', Colors.teal),
            SizedBox(width: 6.0),
            _buildPill('Actions', Colors.deepPurple),
            SizedBox(width: 6.0),
            _buildPill('MouseRegion', Colors.pink),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Built-in Intent Showcase (uses ActivateIntent / DismissIntent)
  // ============================================================
  final activateIntent = ActivateIntent();
  final dismissIntent = DismissIntent();
  final doNothing = DoNothingAction();
  final doNothingNoConsume = DoNothingAction(consumesKey: false);

  final builtInIntents = [
    {
      'name': 'ActivateIntent',
      'keys': 'Enter / Space',
      'description': 'Default activation: button press, toggle.',
      'instance': activateIntent.toString(),
      'icon': Icons.touch_app,
      'color': Colors.blue,
    },
    {
      'name': 'DismissIntent',
      'keys': 'Escape',
      'description': 'Cancel a dialog, close a popup, exit a mode.',
      'instance': dismissIntent.toString(),
      'icon': Icons.close,
      'color': Colors.red,
    },
    {
      'name': 'NextFocusIntent',
      'keys': 'Tab',
      'description': 'Move focus to next focusable widget.',
      'instance': 'NextFocusIntent()',
      'icon': Icons.skip_next,
      'color': Colors.orange,
    },
    {
      'name': 'PreviousFocusIntent',
      'keys': 'Shift+Tab',
      'description': 'Move focus to previous focusable widget.',
      'instance': 'PreviousFocusIntent()',
      'icon': Icons.skip_previous,
      'color': Colors.deepOrange,
    },
    {
      'name': 'DirectionalFocusIntent',
      'keys': 'Arrow keys',
      'description': 'Move focus in a 2D direction.',
      'instance': 'DirectionalFocusIntent(TraversalDirection.up)',
      'icon': Icons.swap_vert,
      'color': Colors.teal,
    },
    {
      'name': 'ScrollIntent',
      'keys': 'PageUp/PageDown',
      'description': 'Scroll the nearest Scrollable.',
      'instance': 'ScrollIntent(direction: AxisDirection.down)',
      'icon': Icons.swap_vertical_circle,
      'color': Colors.indigo,
    },
  ];

  final builtInCards = <Widget>[];
  for (final entry in builtInIntents) {
    final color = entry['color'] as Color;
    builtInCards.add(
      Container(
        width: 240.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(entry['icon'] as IconData, color: color, size: 28.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    entry['name'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                entry['keys'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              entry['description'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final builtInSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade50, Colors.blueGrey.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Built-in Intents',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Provided by package:flutter/widgets.dart out of the box.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: builtInCards,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Common Shortcuts Table (Cmd+S, Cmd+Z, ...)
  // ============================================================
  final commonShortcuts = [
    {
      'combo': ['Cmd', 'S'],
      'intent': 'SaveIntent',
      'description': 'Save the current document',
      'color': Colors.blue,
    },
    {
      'combo': ['Cmd', 'Z'],
      'intent': 'UndoIntent',
      'description': 'Undo last edit',
      'color': Colors.green,
    },
    {
      'combo': ['Cmd', 'Shift', 'Z'],
      'intent': 'RedoIntent',
      'description': 'Redo previously undone edit',
      'color': Colors.lightGreen,
    },
    {
      'combo': ['Cmd', 'C'],
      'intent': 'CopySelectionTextIntent',
      'description': 'Copy selection to clipboard',
      'color': Colors.orange,
    },
    {
      'combo': ['Cmd', 'V'],
      'intent': 'PasteTextIntent',
      'description': 'Paste from clipboard',
      'color': Colors.deepOrange,
    },
    {
      'combo': ['Cmd', 'X'],
      'intent': 'CopySelectionTextIntent',
      'description': 'Cut selection',
      'color': Colors.red,
    },
    {
      'combo': ['Cmd', 'A'],
      'intent': 'SelectAllTextIntent',
      'description': 'Select all text',
      'color': Colors.purple,
    },
    {
      'combo': ['Enter'],
      'intent': 'ActivateIntent',
      'description': 'Activate the focused widget',
      'color': Colors.indigo,
    },
    {
      'combo': ['Esc'],
      'intent': 'DismissIntent',
      'description': 'Dismiss / cancel the focused widget',
      'color': Colors.pink,
    },
    {
      'combo': ['Tab'],
      'intent': 'NextFocusIntent',
      'description': 'Advance focus traversal',
      'color': Colors.teal,
    },
  ];

  final shortcutRows = <Widget>[];
  for (var i = 0; i < commonShortcuts.length; i++) {
    final s = commonShortcuts[i];
    final color = s['color'] as Color;
    final combo = s['combo'] as List<String>;
    final keyChips = <Widget>[];
    for (var k = 0; k < combo.length; k++) {
      keyChips.add(_buildKeyCap(combo[k], color));
      if (k < combo.length - 1) {
        keyChips.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              '+',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        );
      }
    }
    shortcutRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.grey.shade100
              : Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 200.0,
              child: Row(children: keyChips),
            ),
            SizedBox(
              width: 220.0,
              child: Text(
                s['intent'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                s['description'] as String,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final shortcutsTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    clipBehavior: Clip.hardEdge,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade700, Colors.purple.shade700],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 200.0,
                child: Text(
                  'Combo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13.0,
                  ),
                ),
              ),
              SizedBox(
                width: 220.0,
                child: Text(
                  'Intent',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...shortcutRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Pitfalls
  // ============================================================
  final pitfalls = [
    {
      'title': 'Forgot the Focus widget',
      'detail':
          'Shortcuts only fire if there is a focused widget in the subtree. '
              'Wrap with Focus(autofocus: true, ...) or use FocusableActionDetector.',
      'icon': Icons.report_problem,
    },
    {
      'title': 'Action returns true/false from invoke',
      'detail':
          'invoke() returns Object?, not bool. Returning false does not '
              'prevent propagation. Use isEnabled() or Action.overridable instead.',
      'icon': Icons.error_outline,
    },
    {
      'title': 'Wrong key on macOS vs others',
      'detail':
          'LogicalKeyboardKey.meta is Cmd on macOS but the Windows key on PC. '
              'Use SingleActivator or platform-specific tables for portability.',
      'icon': Icons.devices,
    },
    {
      'title': 'consumesKey hides the event',
      'detail':
          'If consumesKey returns true, the platform never sees the key. '
              'For Tab/Esc passthrough, return false (see DoNothingAction(consumesKey: false)).',
      'icon': Icons.visibility_off,
    },
    {
      'title': 'Intent identity vs Type lookup',
      'detail':
          'Actions matches by Intent type, not by instance. Always register '
              'against the exact runtimeType you dispatch.',
      'icon': Icons.fingerprint,
    },
  ];

  final pitfallCards = <Widget>[];
  for (final p in pitfalls) {
    pitfallCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade50, Colors.orange.shade50],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border(
            left: BorderSide(color: Colors.red.shade400, width: 4.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.12),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              p['icon'] as IconData,
              color: Colors.red.shade600,
              size: 24.0,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: Colors.red.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    p['detail'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade800,
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

  final pitfallSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning, color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Common Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...pitfallCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Quick Reference
  // ============================================================
  final quickRef = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
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
            Icon(Icons.menu_book, color: Colors.cyanAccent, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Quick Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRefRow('Shortcuts', 'Maps LogicalKeySet -> Intent'),
        _buildRefRow('Actions', 'Maps Type -> Action<Intent>'),
        _buildRefRow('Intent', 'Marker for "what should happen"'),
        _buildRefRow('Action<T>', 'Implements invoke(T intent)'),
        _buildRefRow('CallbackAction<T>', 'Action wrapping a function'),
        _buildRefRow('DoNothingAction', 'Explicitly no-op (block defaults)'),
        _buildRefRow('FocusableActionDetector',
            'Composite: Focus + Shortcuts + Actions + MouseRegion'),
        _buildRefRow('LogicalKeySet', 'Set of logical keys (chord)'),
        _buildRefRow('SingleActivator', 'Modern, platform-aware single combo'),
        _buildRefRow('Actions.invoke', 'Programmatic dispatch from code'),
      ],
    ),
  );

  // ============================================================
  // SECTION 13: ASCII Footer / Pipeline Diagram
  // ============================================================
  final asciiDiagram = '''
+-------------+    +-------------+    +-----------+    +-----------+    +-----------+
|  Key Event  | -> |  Shortcuts  | -> |  Intent   | -> |  Actions  | -> | Action<T> |
| (KeyDown)   |    | LogicalKey  |    | semantic  |    | dispatch  |    | invoke()  |
| Cmd+S/Esc   |    | -> Intent   |    |  marker   |    | by Type   |    | side-fx   |
+-------------+    +-------------+    +-----------+    +-----------+    +-----------+
        \\                                                                  /
         \\______________________ widget tree _____________________________/
                       (Focus is required for delivery!)
''';

  final footer = Container(
    margin: EdgeInsets.only(top: 16.0, bottom: 32.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.cyan.shade700, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pipeline Diagram',
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            asciiDiagram,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent,
              height: 1.3,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '// Static demonstration only — no interactivity required.',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.grey.shade500,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Static Animations to satisfy "AlwaysStoppedAnimation only" rule
  // ============================================================
  final pulseAnimation = AlwaysStoppedAnimation<double>(0.65);
  final scaleAnimation = AlwaysStoppedAnimation<double>(1.0);
  final fadeAnimation = AlwaysStoppedAnimation<double>(0.85);
  final zeroDuration = Duration.zero;

  final animationStrip = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.lightBlue.shade50],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.0),
    ),
    child: Row(
      children: [
        Icon(Icons.timer_outlined, color: Colors.cyan.shade800, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            'Static motion: AlwaysStoppedAnimation<double>'
            '(${pulseAnimation.value}, '
            '${scaleAnimation.value}, '
            '${fadeAnimation.value}) | '
            'Duration: ${zeroDuration.inMilliseconds}ms',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyan.shade900,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Final Layout
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            SizedBox(height: 24.0),
            _sectionTitle('1. Anatomy of the Pipeline', Icons.account_tree),
            pipelineSection,
            SizedBox(height: 20.0),
            _sectionTitle('2. Shortcuts Widget', Icons.shortcut),
            shortcutsCard,
            SizedBox(height: 16.0),
            _sectionTitle('3. Actions Widget', Icons.search),
            actionsCard,
            SizedBox(height: 16.0),
            _sectionTitle('4. Intent', Icons.lightbulb_outline),
            intentCard,
            SizedBox(height: 16.0),
            _sectionTitle('5. Action<T>', Icons.flash_on),
            actionCard,
            SizedBox(height: 20.0),
            _sectionTitle('6. CallbackAction Recipe', Icons.bolt),
            callbackRecipe,
            SizedBox(height: 16.0),
            _sectionTitle(
              '7. FocusableActionDetector Recipe',
              Icons.center_focus_strong,
            ),
            detectorRecipe,
            SizedBox(height: 20.0),
            _sectionTitle('8. Built-in Intents', Icons.layers),
            builtInSection,
            SizedBox(height: 20.0),
            _sectionTitle('9. Common Shortcuts', Icons.keyboard),
            shortcutsTable,
            SizedBox(height: 20.0),
            _sectionTitle('10. Pitfalls', Icons.warning_amber),
            pitfallSection,
            SizedBox(height: 20.0),
            _sectionTitle('11. Quick Reference', Icons.menu_book),
            quickRef,
            SizedBox(height: 12.0),
            animationStrip,
            footer,
            // Touch the demo references so analyzer keeps them visible.
            Offstage(
              offstage: true,
              child: Text(
                'activate=$activateIntent dismiss=$dismissIntent '
                'doNothing=$doNothing doNothingNoConsume=$doNothingNoConsume',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------

Widget _sectionTitle(String text, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 4.0, bottom: 8.0, left: 4.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _buildApiCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color primary,
  required Color secondary,
  required String description,
  required String code,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: primary.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 7.0),
        ),
      ],
    ),
    clipBehavior: Clip.hardEdge,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header band
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primary, secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(icon, color: Colors.white, size: 28.0),
              ),
              SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Body
        Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey.shade800,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  code,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.cyanAccent,
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

Widget _buildRecipeStep({
  required int step,
  required String title,
  required MaterialColor color,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 26.0,
          height: 26.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.shade600,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPill(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

Widget _buildKeyCap(String label, Color color) {
  return Container(
    constraints: BoxConstraints(minWidth: 36.0),
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.grey.shade200],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.7), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 2.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

Widget _buildRefRow(String name, String desc) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180.0,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade300,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
