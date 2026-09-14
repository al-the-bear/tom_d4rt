// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of Actions / Intent / Action / ActionDispatcher.
//
// Sent over HTTP and rendered live by a d4rt-driven Flutter test app. The demo
// is meant to teach the Actions framework visually: it explains the role of
// every moving part (Intent, Action, Actions widget, ActionDispatcher,
// ActionListener, Shortcuts) and renders real, instantiated Actions widgets
// so developers can inspect the wiring on screen.
//
// HARD constraints honoured by this script:
//   * Static `dynamic build(BuildContext)` entry-point.
//   * No setState / StatefulWidget / AnimationController / controllers.
//   * No `.value` on Tween.animate().
//   * No for-in over BridgedInstance — only over plain Dart lists/maps.
//   * No invocation of Actions.invoke — we only render the wiring.
//
// Sections (≥ 9):
//   1. Intro card.
//   2. Class hierarchy diagram (Intent → ActivateIntent / DismissIntent / …).
//   3. Intent examples (built-in subtypes catalogue).
//   4. Action examples (CallbackAction + custom subclasses).
//   5. Actions widget section (≥ 3 real Actions widgets).
//   6. Shortcuts wiring section (LogicalKeySet / SingleActivator → Intent).
//   7. ActionListener section.
//   8. ActionDispatcher section.
//   9. Usage guide / cheat-sheet.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ===========================================================================
// Custom Intent + Action types used in the live-rendered Actions widgets.
// They are top-level so that the Actions(actions: { _GreetIntent: _GreetAction() })
// instances we render really compile and the d4rt interpreter can build them.
// ===========================================================================

class _GreetIntent extends Intent {
  const _GreetIntent();
}

class _GreetAction extends Action<_GreetIntent> {
  @override
  Object? invoke(_GreetIntent intent) {
    // Pure function — never actually invoked at runtime by this demo.
    return 'hello';
  }
}

class _SaveIntent extends Intent {
  const _SaveIntent();
}

class _SaveAction extends Action<_SaveIntent> {
  @override
  Object? invoke(_SaveIntent intent) {
    return 'saved';
  }
}

class _UndoIntent extends Intent {
  const _UndoIntent();
}

class _UndoAction extends Action<_UndoIntent> {
  @override
  Object? invoke(_UndoIntent intent) {
    return 'undone';
  }
}

class _RedoIntent extends Intent {
  const _RedoIntent();
}

class _RedoAction extends Action<_RedoIntent> {
  @override
  Object? invoke(_RedoIntent intent) {
    return 'redone';
  }
}

// ===========================================================================
// Entry-point.
// ===========================================================================

dynamic build(BuildContext context) {
  print('Actions / Intent Deep Demo executing');
  return MaterialApp(
    title: 'Actions / Intent Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.light,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F3FA),
      appBar: AppBar(
        title: const Text('Actions & Intents'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildIntroCard(),
          const SizedBox(height: 16),
          _buildClassHierarchyDiagram(),
          const SizedBox(height: 16),
          _buildIntentExamples(),
          const SizedBox(height: 16),
          _buildActionExamples(),
          const SizedBox(height: 16),
          _buildActionsWidgetSection(),
          const SizedBox(height: 16),
          _buildShortcutsConnectionSection(),
          const SizedBox(height: 16),
          _buildActionListenerSection(),
          const SizedBox(height: 16),
          _buildActionDispatcherSection(),
          const SizedBox(height: 16),
          _buildUsageGuide(),
          const SizedBox(height: 24),
          _buildFooter(),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ===========================================================================
// Reusable visual helpers — kept as pure top-level functions so the d4rt
// interpreter can re-evaluate them deterministically.
// ===========================================================================

Widget _sectionHeader(String title, String subtitle, IconData icon, Color accent) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[accent, accent.withOpacity(0.55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.35),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.22),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.55)),
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.92),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _explanatoryParagraph(String text, Color accent) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.06),
      borderRadius: BorderRadius.circular(12),
      border: Border(
        left: BorderSide(color: accent, width: 4),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13.2,
        height: 1.45,
        color: Colors.grey.shade800,
      ),
    ),
  );
}

Widget _codeBlock(String code, {Color background = const Color(0xFF1E1E2E)}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: Color(0xFFD4D4F0),
        height: 1.4,
      ),
    ),
  );
}

Widget _pillBadge(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.16),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _sectionShell({required Widget header, required List<Widget> children, Color background = Colors.white}) {
  return Container(
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(18),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[header, ...children],
    ),
  );
}

// ===========================================================================
// SECTION 1 — Intro card.
// ===========================================================================

Widget _buildIntroCard() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF512DA8),
          Color(0xFF7E57C2),
          Color(0xFFB39DDB),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF512DA8).withOpacity(0.45),
          blurRadius: 22,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.22),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.6), width: 2),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.white.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.flash_on, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Actions / Intents',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Decoupled command dispatch in Flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'The Actions framework separates "what should happen" (Intent) '
          'from "how it should happen" (Action). A widget higher up the tree '
          'declares the Action that handles a given Intent type via the '
          'Actions widget; widgets below dispatch Intents and the framework '
          'walks the tree to find the right handler. This decoupling is the '
          'foundation of Flutter\'s keyboard-shortcut, focus traversal, '
          'context-menu and accessibility plumbing.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.5,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _pillBadge('Intent', Colors.amberAccent),
            _pillBadge('Action', Colors.lightGreenAccent),
            _pillBadge('Actions widget', Colors.cyanAccent),
            _pillBadge('Dispatcher', Colors.pinkAccent),
            _pillBadge('Shortcuts', Colors.orangeAccent),
            _pillBadge('ActionListener', Colors.tealAccent),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 2 — Class hierarchy diagram.
// ===========================================================================

Widget _hierarchyNode(String label, Color color, {double width = 180, IconData? icon}) {
  return Container(
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[color, color.withOpacity(0.65)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.4),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget _verticalConnector({double height = 18, Color color = Colors.deepPurple}) {
  return Container(
    width: 2,
    height: height,
    color: color.withOpacity(0.55),
  );
}

Widget _buildClassHierarchyDiagram() {
  return _sectionShell(
    header: _sectionHeader(
      'Class Hierarchy',
      'Intent → ActivateIntent / DismissIntent / ScrollIntent / …',
      Icons.account_tree,
      Colors.indigo,
    ),
    children: <Widget>[
      _explanatoryParagraph(
        'Every dispatchable command in Flutter is an Intent subclass. The '
        'Action<T> base class is parameterised by the Intent type it handles. '
        'When you wire up an Actions widget you map Intent runtime types to '
        'Action instances. Below is the most-used branch of the hierarchy — '
        'there are many more concrete subclasses in flutter/widgets and '
        'flutter/material that you can extend or replace.',
        Colors.indigo,
      ),
      const SizedBox(height: 10),
      Center(
        child: _hierarchyNode('Intent (abstract)', Colors.indigo, width: 220, icon: Icons.bolt),
      ),
      Center(child: _verticalConnector(height: 18)),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.indigo.withOpacity(0.2)),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _hierarchyNode('ActivateIntent', Colors.deepPurple, width: 160, icon: Icons.touch_app),
            _hierarchyNode('ButtonActivateIntent', Colors.deepPurple, width: 200, icon: Icons.smart_button),
            _hierarchyNode('DismissIntent', Colors.pink, width: 160, icon: Icons.cancel_outlined),
            _hierarchyNode('DoNothingIntent', Colors.grey, width: 170, icon: Icons.do_not_disturb),
            _hierarchyNode('DoNothingAndStopPropagationIntent', Colors.grey, width: 280, icon: Icons.block),
            _hierarchyNode('NextFocusIntent', Colors.teal, width: 160, icon: Icons.arrow_forward),
            _hierarchyNode('PreviousFocusIntent', Colors.teal, width: 180, icon: Icons.arrow_back),
            _hierarchyNode('DirectionalFocusIntent', Colors.cyan, width: 200, icon: Icons.navigation),
            _hierarchyNode('RequestFocusIntent', Colors.lightBlue, width: 180, icon: Icons.center_focus_strong),
            _hierarchyNode('ScrollIntent', Colors.orange, width: 150, icon: Icons.swap_vert),
            _hierarchyNode('CopySelectionTextIntent', Colors.green, width: 220, icon: Icons.copy),
            _hierarchyNode('_GreetIntent (custom)', Colors.amber, width: 200, icon: Icons.waving_hand),
            _hierarchyNode('_SaveIntent (custom)', Colors.lightGreen, width: 190, icon: Icons.save_alt),
            _hierarchyNode('_UndoIntent (custom)', Colors.redAccent, width: 180, icon: Icons.undo),
            _hierarchyNode('_RedoIntent (custom)', Colors.deepOrange, width: 180, icon: Icons.redo),
          ],
        ),
      ),
      const SizedBox(height: 14),
      Center(
        child: _hierarchyNode(
          'Action<T extends Intent> (abstract)',
          Colors.deepOrange,
          width: 280,
          icon: Icons.bolt_outlined,
        ),
      ),
      Center(child: _verticalConnector(height: 18, color: Colors.deepOrange)),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _hierarchyNode('CallbackAction<T>', Colors.orange, width: 170, icon: Icons.call_to_action),
          _hierarchyNode('ContextAction<T>', Colors.orange, width: 170, icon: Icons.web_asset),
          _hierarchyNode('_GreetAction (custom)', Colors.amber, width: 200, icon: Icons.waving_hand),
          _hierarchyNode('_SaveAction (custom)', Colors.lightGreen, width: 200, icon: Icons.save),
          _hierarchyNode('_UndoAction (custom)', Colors.redAccent, width: 200, icon: Icons.undo),
          _hierarchyNode('_RedoAction (custom)', Colors.deepOrange, width: 200, icon: Icons.redo),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.indigo.withOpacity(0.12),
              Colors.deepPurple.withOpacity(0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Reading the diagram: top half is the Intent tree (data classes '
          'describing "what"). Bottom half is the Action tree (handlers '
          'describing "how"). The Actions widget is the glue that maps '
          'Intent → Action at a particular point in the widget tree.',
          style: TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.4),
        ),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 3 — Intent examples (catalogue of built-in Intents).
// ===========================================================================

Widget _intentChip({
  required String name,
  required String purpose,
  required IconData icon,
  required Color color,
}) {
  return Container(
    width: 280,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[color.withOpacity(0.18), color.withOpacity(0.04)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.45)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.18),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                purpose,
                style: TextStyle(
                  fontSize: 11.5,
                  height: 1.35,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildIntentExamples() {
  return _sectionShell(
    header: _sectionHeader(
      'Intent Catalogue',
      'Built-in Intent subclasses you can dispatch out of the box',
      Icons.list_alt,
      Colors.deepPurple,
    ),
    children: <Widget>[
      _explanatoryParagraph(
        'An Intent is a tiny, immutable data object. It carries no behaviour '
        'on its own. Dispatching an Intent is how you say "this kind of thing '
        'should happen" without caring which widget actually performs it. '
        'Below is a curated list of the Intents that ship with Flutter — they '
        'cover button activation, dismissal, focus traversal and scrolling.',
        Colors.deepPurple,
      ),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          _intentChip(
            name: 'ActivateIntent',
            purpose: 'Generic "activate this widget" — what Enter/Space do on '
                'a focused button.',
            icon: Icons.touch_app,
            color: Colors.deepPurple,
          ),
          _intentChip(
            name: 'ButtonActivateIntent',
            purpose: 'Specialisation used by Material buttons; differs from '
                'ActivateIntent in semantic-only ways.',
            icon: Icons.smart_button,
            color: Colors.indigo,
          ),
          _intentChip(
            name: 'DismissIntent',
            purpose: 'Closes a dialog, popup, drawer or modal route.',
            icon: Icons.cancel_outlined,
            color: Colors.pink,
          ),
          _intentChip(
            name: 'DoNothingIntent',
            purpose: 'Used to explicitly opt out of a shortcut at a given '
                'scope without removing it.',
            icon: Icons.do_not_disturb,
            color: Colors.grey,
          ),
          _intentChip(
            name: 'DoNothingAndStopPropagationIntent',
            purpose: 'Like DoNothing but also halts further key-event '
                'propagation up the tree.',
            icon: Icons.block,
            color: Colors.blueGrey,
          ),
          _intentChip(
            name: 'NextFocusIntent',
            purpose: 'Move keyboard focus to the next focusable widget '
                'in tab order.',
            icon: Icons.arrow_forward,
            color: Colors.teal,
          ),
          _intentChip(
            name: 'PreviousFocusIntent',
            purpose: 'Move keyboard focus to the previous focusable widget.',
            icon: Icons.arrow_back,
            color: Colors.teal,
          ),
          _intentChip(
            name: 'DirectionalFocusIntent',
            purpose: 'Move focus in a 2-D direction (up / down / left / '
                'right) — used by gamepads and arrow keys.',
            icon: Icons.navigation,
            color: Colors.cyan,
          ),
          _intentChip(
            name: 'RequestFocusIntent',
            purpose: 'Request focus on a specific FocusNode; used to '
                'programmatically focus a widget.',
            icon: Icons.center_focus_strong,
            color: Colors.lightBlue,
          ),
          _intentChip(
            name: 'ScrollIntent',
            purpose: 'Scroll the nearest enclosing scrollable. Carries a '
                'direction and amount.',
            icon: Icons.swap_vert,
            color: Colors.orange,
          ),
          _intentChip(
            name: 'CopySelectionTextIntent',
            purpose: 'Copy the currently selected text to the clipboard '
                '(Cmd/Ctrl-C).',
            icon: Icons.copy,
            color: Colors.green,
          ),
        ],
      ),
      const SizedBox(height: 12),
      _codeBlock(
        '// Defining your own Intent is one line:\n'
        'class _GreetIntent extends Intent {\n'
        '  const _GreetIntent();\n'
        '}\n\n'
        '// Intents are normal const classes. Add fields to carry payload:\n'
        'class ScrollIntent extends Intent {\n'
        '  const ScrollIntent({\n'
        '    required this.direction,\n'
        '    this.type = ScrollIncrementType.line,\n'
        '  });\n'
        '  final AxisDirection direction;\n'
        '  final ScrollIncrementType type;\n'
        '}',
      ),
    ],
  );
}

// ===========================================================================
// SECTION 4 — Action examples.
// ===========================================================================

Widget _actionRow({
  required String name,
  required String description,
  required Color color,
  required IconData icon,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.35)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.12),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[color, color.withOpacity(0.55)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.35,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildActionExamples() {
  return _sectionShell(
    header: _sectionHeader(
      'Action Subclasses',
      'CallbackAction shortcut + four custom Action types in this script',
      Icons.bolt,
      Colors.deepOrange,
    ),
    children: <Widget>[
      _explanatoryParagraph(
        'An Action<T> is the handler half. It overrides invoke(T intent) and '
        'returns whatever value should propagate back to the dispatcher. The '
        'easiest way to write one is the CallbackAction<T> shortcut, which '
        'takes an onInvoke callback. For more complex behaviour — analytics, '
        'undo support, or context-aware logic — you subclass Action directly.',
        Colors.deepOrange,
      ),
      _actionRow(
        name: 'CallbackAction<T>',
        description: 'Built-in shortcut — wraps a callback. Best for one-off '
            'actions that don\'t need state or context.',
        color: Colors.orange,
        icon: Icons.call_to_action,
      ),
      _actionRow(
        name: '_GreetAction extends Action<_GreetIntent>',
        description: 'Custom action defined at top of this script. Returns '
            '"hello" when its Intent is dispatched.',
        color: Colors.amber,
        icon: Icons.waving_hand,
      ),
      _actionRow(
        name: '_SaveAction extends Action<_SaveIntent>',
        description: 'Demonstrates a save operation. In a real app it would '
            'persist data and return the persisted entity id.',
        color: Colors.lightGreen,
        icon: Icons.save,
      ),
      _actionRow(
        name: '_UndoAction extends Action<_UndoIntent>',
        description: 'Reverses the last edit. Real implementations consult an '
            'undo stack stored in an InheritedWidget.',
        color: Colors.redAccent,
        icon: Icons.undo,
      ),
      _actionRow(
        name: '_RedoAction extends Action<_RedoIntent>',
        description: 'Re-applies the most recently undone edit, popping from '
            'the redo stack.',
        color: Colors.deepOrange,
        icon: Icons.redo,
      ),
      const SizedBox(height: 8),
      _codeBlock(
        '// CallbackAction shortcut — quick & inline:\n'
        'CallbackAction<ActivateIntent>(\n'
        '  onInvoke: (ActivateIntent intent) {\n'
        '    debugPrint(\'activated!\');\n'
        '    return null;\n'
        '  },\n'
        ');\n\n'
        '// Custom subclass — used in this demo:\n'
        'class _GreetAction extends Action<_GreetIntent> {\n'
        '  @override\n'
        '  Object? invoke(_GreetIntent intent) => \'hello\';\n'
        '}',
      ),
    ],
  );
}

// ===========================================================================
// SECTION 5 — Actions widget section (renders ≥ 3 real Actions widgets).
// ===========================================================================

Widget _renderedActionsCard({
  required String title,
  required String description,
  required Widget actionsWidget,
  required Color accent,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[accent.withOpacity(0.10), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withOpacity(0.4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.15),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.widgets, color: accent, size: 18),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.5,
            height: 1.4,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accent.withOpacity(0.35), width: 1.4),
          ),
          child: actionsWidget,
        ),
      ],
    ),
  );
}

Widget _buildActionsWidgetSection() {
  // Three real Actions(...) widget instances — these are the "live wiring"
  // demonstrations. We do NOT call Actions.invoke; we only render the tree.
  final Widget actionsOne = Actions(
    actions: <Type, Action<Intent>>{
      _GreetIntent: _GreetAction(),
    },
    child: Builder(
      builder: (BuildContext innerContext) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.waving_hand, color: Colors.amber, size: 22),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Inside this Actions scope, dispatching a _GreetIntent '
                  'would invoke _GreetAction.invoke and return "hello".',
                  style: TextStyle(fontSize: 12.5),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  final Widget actionsTwo = Actions(
    actions: <Type, Action<Intent>>{
      _SaveIntent: _SaveAction(),
      _UndoIntent: _UndoAction(),
      _RedoIntent: _RedoAction(),
    },
    child: Builder(
      builder: (BuildContext innerContext) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _pillBadge('_SaveIntent', Colors.lightGreen),
                const SizedBox(width: 6),
                _pillBadge('_UndoIntent', Colors.redAccent),
                const SizedBox(width: 6),
                _pillBadge('_RedoIntent', Colors.deepOrange),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'A single Actions widget can register many handlers at once. '
              'Editor-style apps usually expose Save / Undo / Redo at a high '
              'level so every descendant can dispatch them.',
              style: TextStyle(fontSize: 12.5, height: 1.4),
            ),
          ],
        );
      },
    ),
  );

  final Widget actionsThree = Actions(
    actions: <Type, Action<Intent>>{
      _GreetIntent: _GreetAction(),
    },
    // Nested Actions widget — overrides the outer _GreetAction for a subtree.
    child: Actions(
      actions: <Type, Action<Intent>>{
        _GreetIntent: CallbackAction<_GreetIntent>(
          onInvoke: (_GreetIntent intent) => 'hi from inner scope',
        ),
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (ActivateIntent intent) => null,
        ),
      },
      child: Builder(
        builder: (BuildContext innerContext) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Two Actions widgets are nested. The inner one overrides '
                '_GreetIntent with a CallbackAction returning "hi from '
                'inner scope". The outer registration is shadowed within '
                'the inner subtree but still active outside.',
                style: TextStyle(fontSize: 12.5, height: 1.4),
              ),
            ],
          );
        },
      ),
    ),
  );

  // A fourth one for good measure — combines built-in Intents with a custom one.
  final Widget actionsFour = Actions(
    actions: <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (ActivateIntent intent) => null,
      ),
      DismissIntent: CallbackAction<DismissIntent>(
        onInvoke: (DismissIntent intent) => null,
      ),
      _GreetIntent: _GreetAction(),
    },
    child: const Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        'Mixing built-in Intents with custom ones in the same Actions map '
        'is the normal case for applications.',
        style: TextStyle(fontSize: 12.5, height: 1.4),
      ),
    ),
  );

  return _sectionShell(
    header: _sectionHeader(
      'Actions Widget — Live Wiring',
      'Four real Actions(...) instances rendered inline',
      Icons.widgets,
      Colors.cyan,
    ),
    children: <Widget>[
      _explanatoryParagraph(
        'The Actions widget is an InheritedWidget that publishes a '
        'Type → Action<Intent> map to its descendants. When code lower in '
        'the tree calls Actions.invoke(context, intent), the framework walks '
        'up the tree, finds the first Actions widget whose map contains the '
        'Intent\'s runtime type, and asks its dispatcher to invoke that '
        'Action. Below are four real Actions widgets — we render them but '
        'do not actually invoke them.',
        Colors.cyan,
      ),
      _renderedActionsCard(
        title: 'Actions #1 — single custom Action',
        description: 'The minimal form: one Intent type mapped to one Action.',
        actionsWidget: actionsOne,
        accent: Colors.amber,
      ),
      _renderedActionsCard(
        title: 'Actions #2 — multiple Actions registered',
        description: 'Save / Undo / Redo registered side-by-side at one scope.',
        actionsWidget: actionsTwo,
        accent: Colors.lightGreen,
      ),
      _renderedActionsCard(
        title: 'Actions #3 — nested Actions, inner overrides outer',
        description: 'Showcases scoping: the inner Actions widget shadows the '
            'outer registration for its subtree only.',
        actionsWidget: actionsThree,
        accent: Colors.deepPurple,
      ),
      _renderedActionsCard(
        title: 'Actions #4 — mixing built-in + custom Intents',
        description: 'Real applications register ActivateIntent and '
            'DismissIntent alongside their own custom Intents.',
        actionsWidget: actionsFour,
        accent: Colors.teal,
      ),
      const SizedBox(height: 8),
      _codeBlock(
        'Actions(\n'
        '  actions: <Type, Action<Intent>>{\n'
        '    _GreetIntent: _GreetAction(),\n'
        '    _SaveIntent: _SaveAction(),\n'
        '    ActivateIntent: CallbackAction<ActivateIntent>(\n'
        '      onInvoke: (ActivateIntent intent) => null,\n'
        '    ),\n'
        '  },\n'
        '  child: MyEditor(),\n'
        ');',
      ),
    ],
  );
}

// ===========================================================================
// SECTION 6 — Shortcuts wiring.
// ===========================================================================

Widget _shortcutRow(String keys, String intent, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[color.withOpacity(0.18), color.withOpacity(0.04)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: Text(
            keys,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward, size: 14, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            intent,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildShortcutsConnectionSection() {
  // Render a real Shortcuts widget paired with a real Actions widget.
  final Widget liveShortcuts = Shortcuts(
    shortcuts: <ShortcutActivator, Intent>{
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS):
          const _SaveIntent(),
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ):
          const _UndoIntent(),
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift,
          LogicalKeyboardKey.keyZ): const _RedoIntent(),
      const SingleActivator(LogicalKeyboardKey.escape): const DismissIntent(),
      const SingleActivator(LogicalKeyboardKey.enter): const ActivateIntent(),
    },
    child: Actions(
      actions: <Type, Action<Intent>>{
        _SaveIntent: _SaveAction(),
        _UndoIntent: _UndoAction(),
        _RedoIntent: _RedoAction(),
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.withOpacity(0.35)),
        ),
        child: const Text(
          'This Shortcuts + Actions pair is a real, instantiated subtree. '
          'Pressing Ctrl+S inside it would dispatch _SaveIntent which '
          'resolves to _SaveAction. We render the wiring but do not '
          'actually invoke it.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
    ),
  );

  return _sectionShell(
    header: _sectionHeader(
      'Shortcuts → Intents → Actions',
      'How keyboard shortcuts flow into the Action framework',
      Icons.keyboard,
      Colors.orange,
    ),
    children: <Widget>[
      _explanatoryParagraph(
        'The Shortcuts widget maps keyboard activations to Intents. It does '
        'not invoke anything itself — it just translates keystrokes into '
        'Intent objects and dispatches them through Actions. This is why '
        'Shortcuts and Actions are nearly always paired.',
        Colors.orange,
      ),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.orange.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Mappings declared in this section\'s Shortcuts widget:',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            const SizedBox(height: 8),
            _shortcutRow('Ctrl + S', '_SaveIntent', Colors.lightGreen),
            _shortcutRow('Ctrl + Z', '_UndoIntent', Colors.redAccent),
            _shortcutRow('Ctrl + Shift + Z', '_RedoIntent', Colors.deepOrange),
            _shortcutRow('Escape', 'DismissIntent', Colors.pink),
            _shortcutRow('Enter', 'ActivateIntent', Colors.deepPurple),
          ],
        ),
      ),
      const SizedBox(height: 12),
      liveShortcuts,
      const SizedBox(height: 12),
      _codeBlock(
        'Shortcuts(\n'
        '  shortcuts: <ShortcutActivator, Intent>{\n'
        '    LogicalKeySet(\n'
        '      LogicalKeyboardKey.control,\n'
        '      LogicalKeyboardKey.keyS,\n'
        '    ): const _SaveIntent(),\n'
        '    SingleActivator(\n'
        '      LogicalKeyboardKey.keyZ,\n'
        '      control: true,\n'
        '      shift: true,\n'
        '    ): const _RedoIntent(),\n'
        '    const SingleActivator(LogicalKeyboardKey.escape):\n'
        '        const DismissIntent(),\n'
        '  },\n'
        '  child: Actions(actions: ..., child: MyEditor()),\n'
        ');',
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.orange.withOpacity(0.10),
              Colors.deepOrange.withOpacity(0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Two activator types: LogicalKeySet — multi-modifier sets, order-'
          'independent. SingleActivator — modern, fluent API with named '
          'control / shift / alt / meta flags. Prefer SingleActivator for '
          'new code; LogicalKeySet is still common in older codebases.',
          style: TextStyle(fontSize: 12.2, height: 1.4),
        ),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 7 — ActionListener.
// ===========================================================================

Widget _buildActionListenerSection() {
  // Render a real ActionListener bound to a custom action instance.
  final _GreetAction observedAction = _GreetAction();
  final Widget liveListener = ActionListener(
    action: observedAction,
    listener: (Action<Intent> action) {
      // Triggered if the action's notifyActionListeners() were called.
      // We don't call it in this demo — we just declare the wiring.
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.teal.withOpacity(0.14),
            Colors.cyan.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.teal.withOpacity(0.35)),
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.hearing, color: Colors.teal, size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'ActionListener subscribes to an Action\'s notifications. '
              'Useful for showing a UI badge when an action becomes '
              'enabled or disabled, or for analytics on every dispatch.',
              style: TextStyle(fontSize: 12.5, height: 1.4),
            ),
          ),
        ],
      ),
    ),
  );

  return _sectionShell(
    header: _sectionHeader(
      'ActionListener',
      'Observe Action notifications without subclassing',
      Icons.hearing,
      Colors.teal,
    ),
    children: <Widget>[
      _explanatoryParagraph(
        'ActionListener wraps a child and registers a listener on a specific '
        'Action instance. When that action calls notifyActionListeners() — '
        'typically because its enabled state changed — the listener fires. '
        'It is the "inherited widget"-style mirror of Action.addListener().',
        Colors.teal,
      ),
      liveListener,
      const SizedBox(height: 12),
      _codeBlock(
        'final action = _GreetAction();\n\n'
        'ActionListener(\n'
        '  action: action,\n'
        '  listener: (Action<Intent> a) {\n'
        '    setState(() => _enabled = a.isEnabled(_GreetIntent()));\n'
        '  },\n'
        '  child: const Text(\'Hello world\'),\n'
        ');',
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.2)),
        ),
        child: const Text(
          'Tip: ActionListener is a Stateful widget under the hood — but '
          'consumers of it only need to remember it removes the listener on '
          'dispose, so it is leak-safe. Use it instead of manually wiring '
          'addListener / removeListener whenever you can.',
          style: TextStyle(fontSize: 12.2, height: 1.4),
        ),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 8 — ActionDispatcher.
// ===========================================================================

Widget _dispatcherFlowStep(String label, IconData icon, Color color, {bool last = false}) {
  return Row(
    children: <Widget>[
      Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[color, color.withOpacity(0.55)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withOpacity(0.45),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
      ),
      if (!last)
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.arrow_downward, size: 16, color: Colors.grey),
        ),
    ],
  );
}

Widget _buildActionDispatcherSection() {
  // Render an Actions widget with an explicit ActionDispatcher.
  final Widget liveDispatcher = Actions(
    dispatcher: ActionDispatcher(),
    actions: <Type, Action<Intent>>{
      _GreetIntent: _GreetAction(),
      _SaveIntent: _SaveAction(),
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.pink.withOpacity(0.3)),
      ),
      child: const Text(
        'This Actions widget passes a custom dispatcher: instead of using '
        'the default one inherited from above, it installs its own. A real '
        'app would subclass ActionDispatcher to add logging or metrics here.',
        style: TextStyle(fontSize: 12.5, height: 1.4),
      ),
    ),
  );

  return _sectionShell(
    header: _sectionHeader(
      'ActionDispatcher',
      'The traffic controller between Intent.invoke and Action.invoke',
      Icons.call_split,
      Colors.pink,
    ),
    children: <Widget>[
      _explanatoryParagraph(
        'Once Actions has resolved which Action handles an Intent, it asks '
        'the ActionDispatcher to actually invoke it. The default dispatcher '
        'simply forwards the call. Custom dispatchers are where you put '
        'logging, analytics, permission checks, undo recording, or anything '
        'else that should apply to every dispatch within a scope.',
        Colors.pink,
      ),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.pink.withOpacity(0.10),
              Colors.purple.withOpacity(0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.pink.withOpacity(0.10),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            _dispatcherFlowStep('User input or Actions.invoke(context, intent)', Icons.input, Colors.deepPurple),
            const SizedBox(height: 6),
            _dispatcherFlowStep('Walk up tree, find matching Actions widget', Icons.search, Colors.indigo),
            const SizedBox(height: 6),
            _dispatcherFlowStep('Look up Action for runtimeType in actions map', Icons.map, Colors.blue),
            const SizedBox(height: 6),
            _dispatcherFlowStep('ActionDispatcher.invokeAction(action, intent)', Icons.send, Colors.teal),
            const SizedBox(height: 6),
            _dispatcherFlowStep('action.invoke(intent) — your code runs', Icons.bolt, Colors.green, last: true),
          ],
        ),
      ),
      const SizedBox(height: 12),
      liveDispatcher,
      const SizedBox(height: 12),
      _codeBlock(
        'class LoggingDispatcher extends ActionDispatcher {\n'
        '  @override\n'
        '  Object? invokeAction(\n'
        '    covariant Action<Intent> action,\n'
        '    covariant Intent intent, [\n'
        '    BuildContext? context,\n'
        '  ]) {\n'
        '    debugPrint(\'dispatching \${intent.runtimeType}\');\n'
        '    final result = super.invokeAction(action, intent, context);\n'
        '    debugPrint(\'  -> \${result}\');\n'
        '    return result;\n'
        '  }\n'
        '}\n\n'
        'Actions(\n'
        '  dispatcher: LoggingDispatcher(),\n'
        '  actions: <Type, Action<Intent>>{ ... },\n'
        '  child: child,\n'
        ');',
      ),
    ],
  );
}

// ===========================================================================
// SECTION 9 — Usage guide / cheat-sheet.
// ===========================================================================

Widget _guideRow(String when, String use, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.all(11),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.35)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.10),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey.shade900,
                height: 1.4,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'When: ',
                  style: TextStyle(fontWeight: FontWeight.w800, color: color),
                ),
                TextSpan(text: when),
                const TextSpan(text: '\n'),
                const TextSpan(
                  text: 'Use: ',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(text: use),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUsageGuide() {
  return _sectionShell(
    header: _sectionHeader(
      'Usage Guide / Cheat Sheet',
      'When to reach for which piece of the framework',
      Icons.menu_book,
      Colors.green,
    ),
    children: <Widget>[
      _explanatoryParagraph(
        'The Actions framework looks heavy for trivial cases — a button that '
        'calls a callback does not need any of this. You start to need it as '
        'soon as the same command can be dispatched from multiple places '
        '(a menu item, a toolbar button, a keyboard shortcut, a context '
        'menu) and you want one canonical implementation.',
        Colors.green,
      ),
      _guideRow(
        'You have a single button calling a single function.',
        'Just use onPressed: () { ... }. No Intent / Action needed.',
        Icons.touch_app,
        Colors.deepPurple,
      ),
      _guideRow(
        'A keyboard shortcut should do the same thing as a menu item.',
        'Define an Intent + Action. Wire the menu item to dispatch the '
        'Intent and bind the shortcut in Shortcuts.',
        Icons.keyboard,
        Colors.orange,
      ),
      _guideRow(
        'Different parts of your app should override the same command.',
        'Wrap each part in its own Actions widget mapping the Intent to a '
        'different Action. Lookup is scope-based.',
        Icons.account_tree,
        Colors.indigo,
      ),
      _guideRow(
        'Every dispatch should be logged or audited.',
        'Subclass ActionDispatcher and pass it to the top-level Actions '
        'widget via the dispatcher: argument.',
        Icons.analytics,
        Colors.pink,
      ),
      _guideRow(
        'A side-bar should highlight while a particular Action is enabled.',
        'Wrap the side-bar in ActionListener and rebuild from its '
        'listener callback.',
        Icons.hearing,
        Colors.teal,
      ),
      _guideRow(
        'You want to tab between custom focusable widgets.',
        'Bind Tab/Shift-Tab to NextFocusIntent / PreviousFocusIntent in '
        'Shortcuts; default Actions registrations already handle them.',
        Icons.tab,
        Colors.cyan,
      ),
      _guideRow(
        'You need to opt out of a shortcut at a particular scope.',
        'Map the activator to DoNothingIntent or '
        'DoNothingAndStopPropagationIntent.',
        Icons.do_not_disturb,
        Colors.grey,
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.green.withOpacity(0.12),
              Colors.lightGreen.withOpacity(0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.green.withOpacity(0.10),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Text(
          'Mental model: Intent = noun ("save"), Action = verb '
          '(actually save), Actions = scope (which verb wins here?), '
          'ActionDispatcher = middleware (logging, undo, analytics), '
          'Shortcuts = key-to-noun translation.',
          style: TextStyle(fontSize: 12.5, height: 1.45, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

// ===========================================================================
// Footer.
// ===========================================================================

Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF311B92),
          Color(0xFF512DA8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF311B92).withOpacity(0.4),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'End of demo. Nine sections covered: intro, hierarchy diagram, '
            'Intent catalogue, Action examples, four live Actions widgets, '
            'Shortcuts wiring, ActionListener, ActionDispatcher, usage guide.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
