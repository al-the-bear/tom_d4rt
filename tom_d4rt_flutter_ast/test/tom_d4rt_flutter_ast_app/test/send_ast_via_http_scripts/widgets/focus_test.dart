// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of the Flutter Focus widget.
//
// Focus is the building block of Flutter's keyboard focus system. It creates
// a node in the focus tree that wraps a child subtree, tracks whether that
// subtree currently owns keyboard focus, intercepts hardware key events, and
// participates in tab traversal. It is a non-visual widget by default, but
// every TextField, button, MenuItem, dialog and dismissible tile that you
// can "tab to" relies on a Focus instance somewhere in its hierarchy.
//
// This demo walks through:
//   - the conceptual anatomy of a Focus node;
//   - the canonical constructor parameters;
//   - autofocus, canRequestFocus, descendantsAreFocusable, skipTraversal,
//     includeSemantics, debugLabel;
//   - Focus inside a Form;
//   - Focus + Shortcuts + Actions integration;
//   - common footguns and a recap.
//
// Important: this script is executed by the d4rt analyzer-free interpreter.
// The runner posts this source, an in-app interpreter parses it, the
// returned widget is built and rendered. There is therefore no live ticker,
// no FocusNode listener wiring and no setState. Every Focus widget below is
// declarative — it shows the *shape* of the API in a static frame.

import 'package:flutter/material.dart';

// ---------- private value-holder types (const-constructible) ---------------

class _Param {
  final String name;
  final String type;
  final String defaultValue;
  final String summary;
  const _Param(this.name, this.type, this.defaultValue, this.summary);
}

class _Sample {
  final String name;
  final Color color;
  final IconData icon;
  final String role;
  const _Sample(this.name, this.color, this.icon, this.role);
}

class _Footgun {
  final String title;
  final String body;
  final IconData icon;
  final Color tone;
  const _Footgun(this.title, this.body, this.icon, this.tone);
}

class _Step {
  final int index;
  final String title;
  final String body;
  const _Step(this.index, this.title, this.body);
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('Focus Deep Demo executing');

  // Common palette: focus = blue/indigo (suggesting a keyboard focus ring).
  final Color accent = Colors.indigo;
  final Color accentLight = Colors.indigo.shade100;
  final Color accentDark = Colors.indigo.shade900;
  final Color ringBlue = Colors.blue.shade400;

  // ============ SECTION 1: Title banner ============
  print('=== Section 1: Title banner ===');

  final titleCard = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade700, Colors.blue.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.center_focus_strong,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Focus',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'a node in the keyboard focus tree',
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: const Text(
            'Focus wraps a child subtree, registers a FocusNode, listens for '
            'key events, and decides whether the user can "tab to" or '
            'programmatically focus that subtree. Every TextField you can '
            'type into is, at heart, a Focus.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
  print('Title card built');

  // ============ SECTION 2: Anatomy diagram ============
  print('=== Section 2: Anatomy ===');

  final anatomyCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: accentDark, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Anatomy of a Focus node',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: accentDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        // Outer container: the Focus widget itself
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: ringBlue, width: 3.0),
            boxShadow: [
              BoxShadow(
                color: ringBlue.withValues(alpha: 0.4),
                blurRadius: 14.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: ringBlue,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  'Focus(  ←  the focus ring is conceptually here',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              // Inner: FocusNode block
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.fiber_manual_record,
                      color: Colors.indigo.shade600,
                      size: 14.0,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'FocusNode (auto-managed if focusNode is null)',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: accentDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              // Inner: child block
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.shade400),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.widgets,
                      color: Colors.amber.shade800,
                      size: 14.0,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'child: Widget — the subtree you want to be focusable',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              // Inner: callbacks block
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.bolt,
                          color: Colors.green,
                          size: 14.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'onFocusChange(bool hasFocus)',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: Colors.green.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.keyboard,
                          color: Colors.green,
                          size: 14.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'onKeyEvent(node, event) → KeyEventResult',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: Colors.green.shade900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              const Text(
                ')',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: [
            Icon(Icons.arrow_downward, color: accent, size: 20.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'Key events bubble up the focus chain until a node returns '
                'KeyEventResult.handled.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: accentDark,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Anatomy diagram built');

  // ============ SECTION 3: Constructor parameters ============
  print('=== Section 3: Constructor parameters ===');

  final List<_Param> params = <_Param>[
    const _Param(
      'child',
      'Widget',
      'required',
      'The subtree to wrap. Always required.',
    ),
    const _Param(
      'focusNode',
      'FocusNode?',
      'null',
      'Use your own node when you need to call requestFocus from outside.',
    ),
    const _Param(
      'parentNode',
      'FocusNode?',
      'null',
      'Override the parent in the focus tree (advanced).',
    ),
    const _Param(
      'autofocus',
      'bool',
      'false',
      'If true, requests focus when first attached.',
    ),
    const _Param(
      'onFocusChange',
      'ValueChanged<bool>?',
      'null',
      'Fires when this node gains or loses focus.',
    ),
    const _Param(
      'onKeyEvent',
      'FocusOnKeyEventCallback?',
      'null',
      'Hardware-key hook. Return handled / ignored / skipRemaining.',
    ),
    const _Param(
      'canRequestFocus',
      'bool',
      'true',
      'If false, this node cannot become the primary focus.',
    ),
    const _Param(
      'descendantsAreFocusable',
      'bool',
      'true',
      'If false, no descendants can be focused, but this node still can.',
    ),
    const _Param(
      'descendantsAreTraversable',
      'bool',
      'true',
      'If false, descendants are skipped during tab traversal.',
    ),
    const _Param(
      'skipTraversal',
      'bool',
      'false',
      'Stays focusable programmatically but skipped by tab.',
    ),
    const _Param(
      'includeSemantics',
      'bool',
      'true',
      'If false, the focus has no impact on the semantics tree.',
    ),
    const _Param(
      'debugLabel',
      'String?',
      'null',
      'Shown in dump trees and DevTools — invaluable for debugging.',
    ),
  ];

  final List<Widget> paramRows = <Widget>[];
  for (int i = 0; i < params.length; i++) {
    final p = params[i];
    final bool zebra = i % 2 == 0;
    paramRows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: zebra ? Colors.indigo.shade50 : Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.indigo.shade100, width: 1.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  p.name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: accentDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 130.0,
              child: Text(
                p.type,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.purple.shade700,
                ),
              ),
            ),
            SizedBox(
              width: 90.0,
              child: Text(
                p.defaultValue,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                p.summary,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final paramsCard = Container(
    margin: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.1),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade600, Colors.blue.shade500],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Row(
            children: const [
              Icon(Icons.list_alt, color: Colors.white, size: 20.0),
              SizedBox(width: 8.0),
              Text(
                'Constructor parameters',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          color: Colors.grey.shade100,
          child: Row(
            children: [
              SizedBox(
                width: 150.0,
                child: Text(
                  'name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              SizedBox(
                width: 130.0,
                child: Text(
                  'type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              SizedBox(
                width: 90.0,
                child: Text(
                  'default',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'summary',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(children: paramRows),
      ],
    ),
  );
  print('Built ${params.length} parameter rows');

  // ============ SECTION 4: autofocus ============
  print('=== Section 4: autofocus ===');

  final autofocusBox = Focus(
    autofocus: true,
    debugLabel: 'demo.autofocus',
    child: Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade100, Colors.green.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green.shade700, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.4),
            blurRadius: 12.0,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.flash_on, color: Colors.green.shade900, size: 22.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'autofocus: true — grabs focus on first attach',
              style: TextStyle(
                color: Colors.green.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  final autofocusCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.green.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.green.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '4. autofocus',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Setting autofocus: true asks Flutter to make this node the primary '
          'focus as soon as the widget is attached. Useful for the first '
          'TextField of a dialog.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        autofocusBox,
        const SizedBox(height: 12.0),
        _codeBlock(
          'Focus(\n'
          '  autofocus: true,\n'
          '  child: TextField(decoration: InputDecoration(labelText: "Email")),\n'
          ')',
        ),
      ],
    ),
  );
  print('autofocus example built');

  // ============ SECTION 5: canRequestFocus side-by-side ============
  print('=== Section 5: canRequestFocus ===');

  final canRequestFocusCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.orange.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '5. canRequestFocus',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade900,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'When false, the node still exists in the tree but never becomes '
          'the primary focus — neither by tab nor by requestFocus().',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: _comparisonTile(
                title: 'canRequestFocus: true',
                isOn: true,
                tone: Colors.green,
                description: 'Default. The node is reachable and focusable.',
                inner: Focus(
                  canRequestFocus: true,
                  debugLabel: 'demo.canRequestFocus.on',
                  child: _focusableBox(
                    'Reachable',
                    Colors.green,
                    Icons.check_circle,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _comparisonTile(
                title: 'canRequestFocus: false',
                isOn: false,
                tone: Colors.red,
                description:
                    'Skipped during traversal and silently rejects '
                    'requestFocus() calls.',
                inner: Focus(
                  canRequestFocus: false,
                  debugLabel: 'demo.canRequestFocus.off',
                  child: _focusableBox(
                    'Inert',
                    Colors.red,
                    Icons.do_not_disturb_on,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('canRequestFocus side-by-side built');

  // ============ SECTION 6: descendantsAreFocusable ============
  print('=== Section 6: descendantsAreFocusable ===');

  final List<_Sample> descKids = const <_Sample>[
    _Sample('first',  Colors.blue,    Icons.text_fields, 'TextField'),
    _Sample('second', Colors.purple,  Icons.smart_button, 'Button'),
    _Sample('third',  Colors.teal,    Icons.list_alt,    'ListTile'),
  ];

  final List<Widget> reachableKids = <Widget>[];
  for (final s in descKids) {
    reachableKids.add(_namedFocusBox(s.name, s.role, s.color, s.icon, true));
  }
  final List<Widget> blockedKids = <Widget>[];
  for (final s in descKids) {
    blockedKids.add(_namedFocusBox(s.name, s.role, s.color, s.icon, false));
  }

  final descendantsCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade400, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '6. descendantsAreFocusable',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade900,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A common pattern: disable a whole region (a card, a panel, a '
          'half-rendered loading state) without rebuilding its content.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        // Top: descendantsAreFocusable: true
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green.shade400, width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 18.0,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    'Focus(descendantsAreFocusable: true)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Focus(
                descendantsAreFocusable: true,
                debugLabel: 'demo.desc.true',
                child: Wrap(spacing: 8.0, runSpacing: 8.0, children: reachableKids),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        // Bottom: descendantsAreFocusable: false
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.red.shade400, width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.cancel, color: Colors.red, size: 18.0),
                  const SizedBox(width: 6.0),
                  Text(
                    'Focus(descendantsAreFocusable: false)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Focus(
                descendantsAreFocusable: false,
                debugLabel: 'demo.desc.false',
                child: Wrap(spacing: 8.0, runSpacing: 8.0, children: blockedKids),
              ),
              const SizedBox(height: 6.0),
              Text(
                'Children render but are unreachable by the tab key.',
                style: TextStyle(
                  fontSize: 11.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.red.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('descendantsAreFocusable example built');

  // ============ SECTION 7: skipTraversal ============
  print('=== Section 7: skipTraversal ===');

  final List<Map<String, Object>> skipChain = <Map<String, Object>>[
    {'label': 'Username', 'icon': Icons.person, 'skip': false, 'index': 1},
    {'label': 'Hidden helper', 'icon': Icons.help, 'skip': true, 'index': null as Object? ?? '—'},
    {'label': 'Password', 'icon': Icons.lock, 'skip': false, 'index': 2},
    {'label': 'Decorative chip', 'icon': Icons.star, 'skip': true, 'index': '—'},
    {'label': 'Submit', 'icon': Icons.send, 'skip': false, 'index': 3},
  ];

  final List<Widget> skipNodes = <Widget>[];
  for (final entry in skipChain) {
    final bool skip = entry['skip'] as bool;
    skipNodes.add(
      Focus(
        skipTraversal: skip,
        debugLabel: 'demo.skip.${entry['label']}',
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: skip ? Colors.grey.shade200 : Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: skip ? Colors.grey.shade400 : Colors.indigo.shade400,
              width: skip ? 1.0 : 2.0,
              style: skip ? BorderStyle.solid : BorderStyle.solid,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: skip ? Colors.grey.shade400 : Colors.indigo,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Text(
                  '${entry['index']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Icon(
                entry['icon'] as IconData,
                size: 18.0,
                color: skip ? Colors.grey.shade600 : Colors.indigo.shade700,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  entry['label'] as String,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: skip ? Colors.grey.shade700 : Colors.indigo.shade900,
                    fontWeight: skip ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: skip ? Colors.red.shade100 : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  skip ? 'skipTraversal' : 'in tab order',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: skip ? Colors.red.shade900 : Colors.green.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final skipCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [Colors.purple.shade50, Colors.indigo.shade100],
        center: Alignment.topLeft,
        radius: 1.6,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.purple.shade300, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '7. skipTraversal',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade900,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'skipTraversal keeps the node focusable programmatically (you can '
          'still call requestFocus()), but it is hidden from tab traversal. '
          'The traversal renumbers around it.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 12.0),
        Column(children: skipNodes),
      ],
    ),
  );
  print('skipTraversal chain built');

  // ============ SECTION 8: includeSemantics ============
  print('=== Section 8: includeSemantics ===');

  final semanticsCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.green.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.teal.shade400, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '8. includeSemantics',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'By default, Focus contributes a "focusable" boolean and the '
          '"focused" flag to the semantics tree, so screen readers announce '
          'focus changes. Set includeSemantics: false for purely structural '
          'Focus nodes that should not be visible to assistive tech.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.teal.shade300, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.accessibility_new,
                          color: Colors.teal.shade700,
                          size: 18.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'true (default)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade900,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Focus(
                      includeSemantics: true,
                      debugLabel: 'demo.semantics.on',
                      child: _focusableBox(
                        'Announced',
                        Colors.teal,
                        Icons.record_voice_over,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.visibility_off,
                          color: Colors.grey.shade700,
                          size: 18.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'false',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade900,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Focus(
                      includeSemantics: false,
                      debugLabel: 'demo.semantics.off',
                      child: _focusableBox(
                        'Silent node',
                        Colors.grey,
                        Icons.voice_over_off,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('includeSemantics card built');

  // ============ SECTION 9: Login form ============
  print('=== Section 9: Login form ===');

  final loginForm = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.indigo.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.login, color: accentDark, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                '9. Focus inside a Form',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: accentDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          const Text(
            'Each TextField is wrapped in a named Focus. nextFocus() and '
            'previousFocus() can hop between them. The submit button is '
            'autofocus: false but remains in the traversal chain.',
            style: TextStyle(fontSize: 12.0, height: 1.4),
          ),
          const SizedBox(height: 16.0),
          Focus(
            debugLabel: 'login.username',
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: const Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.indigo.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: accent, width: 2.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Focus(
            debugLabel: 'login.password',
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.indigo.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: accent, width: 2.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                child: Focus(
                  debugLabel: 'login.remember',
                  canRequestFocus: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.indigo.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_box_outline_blank,
                          color: accentDark,
                          size: 20.0,
                        ),
                        const SizedBox(width: 8.0),
                        const Text(
                          'Remember me',
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Focus(
                  debugLabel: 'login.forgot',
                  skipTraversal: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Forgot? (skipTraversal)',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: accent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Focus(
            debugLabel: 'login.submit',
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent, Colors.blue.shade400],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.4),
                    blurRadius: 8.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  print('Login form built');

  // ============ SECTION 10: Shortcuts + Actions integration ============
  print('=== Section 10: Shortcuts + Actions ===');

  final shortcutsCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.keyboard_command_key, color: Colors.amber.shade300),
            const SizedBox(width: 8.0),
            Text(
              '10. Focus + Shortcuts + Actions',
              style: TextStyle(
                color: Colors.amber.shade300,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'Focus is the dispatch surface for hardware key events. Combined '
          'with Shortcuts (which maps key chords to Intents) and Actions '
          '(which executes Intents), it builds a desktop-class keyboard UI.',
          style: TextStyle(color: Colors.grey.shade300, fontSize: 12.0),
        ),
        const SizedBox(height: 14.0),
        _darkCodeBlock(
          'Focus(\n'
          '  autofocus: true,\n'
          '  child: Shortcuts(\n'
          '    shortcuts: <ShortcutActivator, Intent>{\n'
          '      SingleActivator(LogicalKeyboardKey.enter): SubmitIntent(),\n'
          '      SingleActivator(LogicalKeyboardKey.escape): CancelIntent(),\n'
          '    },\n'
          '    child: Actions(\n'
          '      actions: <Type, Action<Intent>>{\n'
          '        SubmitIntent: CallbackAction(onInvoke: (i) => save()),\n'
          '        CancelIntent: CallbackAction(onInvoke: (i) => close()),\n'
          '      },\n'
          '      child: MyForm(),\n'
          '    ),\n'
          '  ),\n'
          ')',
          Colors.cyan.shade300,
        ),
        const SizedBox(height: 12.0),
        _darkCodeBlock(
          '// Or hook keys directly:\n'
          'Focus(\n'
          '  onKeyEvent: (node, event) {\n'
          '    if (event is KeyDownEvent &&\n'
          '        event.logicalKey == LogicalKeyboardKey.tab) {\n'
          '      return KeyEventResult.handled;\n'
          '    }\n'
          '    return KeyEventResult.ignored;\n'
          '  },\n'
          '  child: child,\n'
          ')',
          Colors.greenAccent.shade100,
        ),
      ],
    ),
  );
  print('Shortcuts/Actions code block built');

  // ============ SECTION 11: Footguns ============
  print('=== Section 11: Footguns ===');

  final List<_Footgun> footguns = const <_Footgun>[
    _Footgun(
      'Two siblings with autofocus: true',
      'Only one wins, and which one is undefined. Pick a single owner per '
      'route, ideally the first input.',
      Icons.warning_amber,
      Colors.red,
    ),
    _Footgun(
      'canRequestFocus: false mid-traversal',
      'When tab traversal lands on a node that suddenly cannot request '
      'focus, focus snaps to the next reachable node — surprising users.',
      Icons.report_problem,
      Colors.orange,
    ),
    _Footgun(
      'Owning your FocusNode',
      'If you pass a FocusNode you constructed, you must dispose() it. '
      'Otherwise let Focus manage it for you.',
      Icons.delete_forever,
      Colors.deepOrange,
    ),
    _Footgun(
      'descendantsAreFocusable vs canRequestFocus',
      'They are not the same. canRequestFocus disables this node only; '
      'descendantsAreFocusable disables every descendant.',
      Icons.compare_arrows,
      Colors.purple,
    ),
    _Footgun(
      'Forgetting includeSemantics',
      'Structural-only Focus wrappers will pollute the semantics tree '
      'unless you set includeSemantics: false.',
      Icons.accessibility,
      Colors.indigo,
    ),
    _Footgun(
      'onKeyEvent vs onKey (legacy)',
      'onKey is deprecated. Use onKeyEvent with KeyDownEvent / KeyUpEvent / '
      'KeyRepeatEvent — the new event hierarchy.',
      Icons.update,
      Colors.brown,
    ),
  ];

  final List<Widget> footgunTiles = <Widget>[];
  for (final f in footguns) {
    footgunTiles.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              f.tone.withValues(alpha: 0.05),
              f.tone.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: f.tone.withValues(alpha: 0.5),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: f.tone.withValues(alpha: 0.18),
              blurRadius: 6.0,
              offset: const Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: f.tone.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(f.icon, color: f.tone, size: 20.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f.title,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: f.tone,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    f.body,
                    style: TextStyle(
                      fontSize: 12.0,
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

  final footgunsCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning, color: Colors.red.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              '11. Footguns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Things that compile fine but bite users at runtime.',
          style: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10.0),
        Column(children: footgunTiles),
      ],
    ),
  );
  print('Footguns card built');

  // ============ SECTION 12: Recap ============
  print('=== Section 12: Recap ===');

  final List<_Step> recapSteps = const <_Step>[
    _Step(
      1,
      'Wrap subtrees you want focusable',
      'Focus(child: ...) is enough — a FocusNode is created for you.',
    ),
    _Step(
      2,
      'Use named debugLabels',
      'Always set debugLabel for non-trivial focus nodes; DevTools rewards you.',
    ),
    _Step(
      3,
      'Pick exactly one autofocus',
      'Per route, per dialog, per popup. Never two siblings.',
    ),
    _Step(
      4,
      'Disable a region with descendantsAreFocusable',
      'Cheaper than swapping subtrees during a "loading / disabled" state.',
    ),
    _Step(
      5,
      'Hide nodes from tab with skipTraversal',
      'Without making them inert programmatically.',
    ),
    _Step(
      6,
      'Combine with Shortcuts and Actions',
      'For real keyboard UIs: Enter, Escape, Cmd+S, etc.',
    ),
  ];

  final List<Widget> recapRows = <Widget>[];
  for (final s in recapSteps) {
    recapRows.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: accentLight, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withValues(alpha: 0.08),
              blurRadius: 4.0,
              offset: const Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.4),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Text(
                '${s.index}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.title,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: accentDark,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    s.body,
                    style: const TextStyle(fontSize: 11.5, height: 1.35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final recapCard = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checklist, color: accentDark, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              '12. Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: accentDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Column(children: recapRows),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: accent, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'In short: Focus is the smallest, cheapest unit of '
                  'keyboard awareness in Flutter. Use it generously, name '
                  'it well, and let FocusScope handle the larger regions.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: accentDark,
                    fontStyle: FontStyle.italic,
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
  print('Recap card built');

  print('Focus Deep Demo build complete — assembling Scaffold');

  // ---------------------------------------------------------------------------
  // Final scaffold
  // ---------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleCard,
          const SizedBox(height: 8.0),
          _sectionHeader('2. Anatomy', Icons.account_tree, accent),
          anatomyCard,
          const SizedBox(height: 16.0),
          _sectionHeader('3. Parameters', Icons.list_alt, accent),
          paramsCard,
          const SizedBox(height: 8.0),
          autofocusCard,
          const SizedBox(height: 16.0),
          canRequestFocusCard,
          const SizedBox(height: 16.0),
          descendantsCard,
          const SizedBox(height: 16.0),
          skipCard,
          const SizedBox(height: 16.0),
          semanticsCard,
          const SizedBox(height: 16.0),
          loginForm,
          const SizedBox(height: 16.0),
          shortcutsCard,
          const SizedBox(height: 16.0),
          footgunsCard,
          recapCard,
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper widgets
// ---------------------------------------------------------------------------

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18.0),
        const SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _focusableBox(String label, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16.0),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonTile({
  required String title,
  required bool isOn,
  required Color tone,
  required String description,
  required Widget inner,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tone.withValues(alpha: 0.6), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tone.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isOn ? Icons.toggle_on : Icons.toggle_off,
              color: tone,
              size: 22.0,
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: tone,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 8.0),
        inner,
      ],
    ),
  );
}

Widget _namedFocusBox(
  String name,
  String role,
  Color color,
  IconData icon,
  bool reachable,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: reachable
            ? [color.withValues(alpha: 0.15), color.withValues(alpha: 0.3)]
            : [Colors.grey.shade200, Colors.grey.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: reachable ? color : Colors.grey.shade500,
        width: 1.4,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: reachable ? color : Colors.grey.shade600,
          size: 14.0,
        ),
        const SizedBox(width: 6.0),
        Text(
          '$name • $role',
          style: TextStyle(
            fontSize: 11.0,
            color: reachable ? color : Colors.grey.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Colors.cyan.shade200,
        height: 1.45,
      ),
    ),
  );
}

Widget _darkCodeBlock(String code, Color textColor) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade700, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.45,
      ),
    ),
  );
}
