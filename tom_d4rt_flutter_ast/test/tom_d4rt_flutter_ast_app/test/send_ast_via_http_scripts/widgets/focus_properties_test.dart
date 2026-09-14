// ignore_for_file: avoid_print
// D4rt deep demo: FocusScopeNode — the organizational node that groups
// FocusNodes into scopes, controlling autofocus, first-focus, traversal
// boundaries, and the way focus moves between logical regions of the UI.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Copper / Bronze palette ───
  const Color copper = Color(0xFFB87333);
  const Color bronze = Color(0xFFCD7F32);
  const Color deepCopper = Color(0xFF8B4513);
  const Color paleSand = Color(0xFFFDF6EC);
  const Color rust = Color(0xFFA0522D);
  const Color cream = Color(0xFFF5E6D0);
  const Color mahogany = Color(0xFF4A2C2A);
  const Color amber = Color(0xFFD4A76A);
  const Color terracotta = Color(0xFFCC6633);
  const Color sienna = Color(0xFFA0673C);

  print('===== FOCUS SCOPE NODE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [mahogany, deepCopper],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: mahogany.withValues(alpha: 0.35),
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
              color: copper,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: amber, width: 1.5),
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
        color: paleSand,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cream),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepCopper.withValues(alpha: 0.9),
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
        border: Border.all(color: cream),
        boxShadow: [
          BoxShadow(
            color: copper.withValues(alpha: 0.07),
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
              color: paleSand,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: mahogany)),
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
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: mahogany)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: deepCopper)),
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
                  color: mahogany.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: mahogany),
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
                  style: TextStyle(fontSize: 11, color: mahogany)),
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
              color: amber.withValues(alpha: 0.3),
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

  Widget scopeBlock(String label, Color borderColor, bool active, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: active ? borderColor.withValues(alpha: 0.06) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: active ? 2.5 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: borderColor.withValues(alpha: active ? 0.15 : 0.07),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Row(
              children: [
                Icon(Icons.account_tree, size: 14, color: borderColor),
                const SizedBox(width: 6),
                Text(label,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: borderColor)),
                if (active) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: borderColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Active',
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget focusableItem(String label, bool focused, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: focused ? color.withValues(alpha: 0.15) : paleSand,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: focused ? color : amber.withValues(alpha: 0.4),
            width: focused ? 2 : 1),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: focused ? color : amber.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(5),
              border: focused
                  ? Border.all(color: color, width: 1.5)
                  : null,
            ),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: focused ? FontWeight.w700 : FontWeight.normal,
                  color: focused ? color : deepCopper)),
          if (focused) ...[
            const Spacer(),
            Icon(Icons.keyboard, size: 14, color: color),
          ],
        ],
      ),
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'FocusScopeNode is a special FocusNode that groups child focus '
          'nodes into a logical scope. It tracks which child had focus '
          'last, manages autofocus within its subtree, and defines a '
          'boundary for focus traversal. Every Flutter app has at least '
          'one — the root scope created by WidgetsApp.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'FocusNode subclass'),
              dataRow('Package', 'flutter/widgets'),
              dataRow('Widget', 'FocusScope wraps FocusScopeNode'),
              dataRow('Purpose', 'Group and manage focus regions'),
              dataRow('Hierarchy', 'Tree of scopes and nodes'),
            ],
          )),
      infoCard(
          'Key Differences from FocusNode',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('FocusNode', 'Single focusable element'),
              dataRow('FocusScopeNode', 'Group of focusable elements'),
              dataRow('FocusNode tracks', 'Its own focus state'),
              dataRow('Scope tracks', 'Which child has focus'),
              dataRow('FocusNode.autofocus', 'Focus this node'),
              dataRow('Scope.autofocus', 'Focus first child in scope'),
            ],
          )),
    ],
  );

  // ─── Section 2: Scope Hierarchy ───
  print('[Section 2] Scope Hierarchy');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Scope Hierarchy'),
      noteBox(
          'Scopes form a tree. The root scope contains child scopes '
          '(e.g., dialog scope, drawer scope). Each scope independently '
          'tracks focused children and manages traversal within itself.'),
      infoCard(
          'Nested Scope Visualization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              scopeBlock('Root Scope (WidgetsApp)', mahogany, false, [
                scopeBlock('Page Scope', copper, true, [
                  focusableItem('Search Field', true, copper),
                  focusableItem('Filter Button', false, copper),
                  focusableItem('Sort Button', false, copper),
                ]),
                scopeBlock('Dialog Scope (overlay)', terracotta, false, [
                  focusableItem('OK Button', false, terracotta),
                  focusableItem('Cancel Button', false, terracotta),
                ]),
              ]),
            ],
          )),
      infoCard(
          'Scope Nesting Rules',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Any depth', 'Scopes nest arbitrarily deep'),
              dataRow('One focused child', 'per scope at any time'),
              dataRow('Parent scope', 'Must be focused for child to focus'),
              dataRow('Root scope', 'Always has focus path'),
            ],
          )),
    ],
  );

  // ─── Section 3: Autofocus ───
  print('[Section 3] Autofocus');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Autofocus'),
      noteBox(
          'A FocusScopeNode can declare autofocus, which requests that one '
          'of its children receives focus when the scope first enters the '
          'tree. This is how dialogs grab focus automatically.'),
      infoCard(
          'Autofocus Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Scope mounts', 'FocusScopeNode attached to tree'),
              dataRow('2. autofocus: true', 'Scope requests focus'),
              dataRow('3. First child', 'With autofocus gets focus'),
              dataRow('4. No autofocus child', 'Scope itself gets focus'),
            ],
          )),
      infoCard(
          'Dialog Autofocus Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              scopeBlock('showDialog Scope (autofocus: true)', copper, true, [
                focusableItem('Title (not focusable)', false, copper),
                focusableItem('Input Field (autofocus: true)', true, copper),
                focusableItem('Submit Button', false, copper),
              ]),
              const SizedBox(height: 4),
              dataRow('Result', 'Input Field gets focus immediately'),
              dataRow('No user action', 'Focus just appears there'),
            ],
          )),
      infoCard(
          'Multiple Autofocus Nodes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('First wins', 'Only first autofocus child is honored'),
              dataRow('Order', 'Tree order (depth-first)'),
              dataRow('Debug warning', 'Framework warns if ambiguous'),
              dataRow('Best practice', 'Single autofocus per scope'),
            ],
          )),
    ],
  );

  // ─── Section 4: First Focus & Focus Memory ───
  print('[Section 4] First Focus & Focus Memory');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'First Focus & Focus Memory'),
      noteBox(
          'FocusScopeNode remembers which child had focus in its scope. '
          'When focus returns to the scope (e.g., dialog closes), it '
          'restores focus to the previously-focused child — focus memory.'),
      infoCard(
          'Focus Memory Visualization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Step 1: User is editing name field',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: mahogany)),
              const SizedBox(height: 4),
              scopeBlock('Form Scope', copper, true, [
                focusableItem('Name Field', true, copper),
                focusableItem('Email Field', false, copper),
                focusableItem('Save Button', false, copper),
              ]),
              const SizedBox(height: 8),
              Text('Step 2: Dialog opens — form scope loses focus',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: mahogany)),
              const SizedBox(height: 4),
              scopeBlock('Form Scope (remembers: Name)', copper, false, [
                focusableItem('Name Field (remembered)', false, copper),
                focusableItem('Email Field', false, copper),
              ]),
              const SizedBox(height: 8),
              Text('Step 3: Dialog closes — focus returns to Name',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: mahogany)),
              const SizedBox(height: 4),
              scopeBlock('Form Scope', copper, true, [
                focusableItem('Name Field', true, copper),
                focusableItem('Email Field', false, copper),
              ]),
            ],
          )),
    ],
  );

  // ─── Section 5: setFirstFocus ───
  print('[Section 5] setFirstFocus');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'setFirstFocus'),
      noteBox(
          'setFirstFocus allows programmatically setting which child should '
          'receive focus when the scope is first focused. This is used '
          'internally by FocusScope widgets with autofocus children.'),
      infoCard(
          'setFirstFocus vs requestFocus',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('setFirstFocus', 'Deferred — focus on scope entry'),
              dataRow('requestFocus', 'Immediate — focus now'),
              dataRow('setFirstFocus when', 'Scope not yet focused'),
              dataRow('requestFocus when', 'Scope already active'),
            ],
          )),
      infoCard(
          'Use Cases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Dialog opens', 'setFirstFocus on OK button'),
              dataRow('Page transition', 'setFirstFocus on search bar'),
              dataRow('Dropdown opens', 'setFirstFocus on first item'),
              dataRow('Tab switch', 'setFirstFocus on tab content'),
            ],
          )),
    ],
  );

  // ─── Section 6: Unfocus Strategies ───
  print('[Section 6] Unfocus Strategies');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Unfocus Strategies'),
      noteBox(
          'When unfocusing a node within a scope, the disposition controls '
          'what happens: does focus move to the scope, to the previous '
          'node, or nowhere?'),
      infoCard(
          'UnfocusDisposition.scope',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Behavior', 'Focus returns to enclosing scope'),
              dataRow('Scope focused', 'Yes — scope is now primary focus'),
              dataRow('No child focused', 'All children unfocused'),
              dataRow('Keyboard events', 'Go to scope node'),
            ],
          )),
      infoCard(
          'UnfocusDisposition.previouslyFocusedChild',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Behavior', 'Focus moves to previously focused child'),
              dataRow('Memory used', 'Scope\'s remembered child'),
              dataRow('No previous', 'Falls back to scope itself'),
              dataRow('Use case', 'Dismissing temporary overlay'),
            ],
          )),
      infoCard(
          'Visual: Unfocus Comparison',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Disposition.scope:',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: copper)),
              scopeBlock('Scope (receives focus)', copper, true, [
                focusableItem('Button A', false, copper),
                focusableItem('Button B (was focused)', false, copper),
              ]),
              const SizedBox(height: 6),
              Text('Disposition.previouslyFocusedChild:',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: terracotta)),
              scopeBlock('Scope', terracotta, true, [
                focusableItem('Button A (previously focused)', true, terracotta),
                focusableItem('Button B', false, terracotta),
              ]),
            ],
          )),
    ],
  );

  // ─── Section 7: Traversal Boundaries ───
  print('[Section 7] Traversal Boundaries');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Traversal Boundaries'),
      noteBox(
          'A scope can act as a traversal boundary via traversalEdgeBehavior. '
          'This controls whether Tab focus can leave the scope or wraps '
          'around within it.'),
      infoCard(
          'TraversalEdgeBehavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('closedLoop', 'Tab wraps within scope'),
              dataRow('leaveFlutterView', 'Tab can leave the app'),
              dataRow('parentScope', 'Tab exits to parent scope'),
            ],
          )),
      infoCard(
          'Dialog Trap Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              scopeBlock('Dialog Scope (closedLoop)', rust, true, [
                focusableItem('Input Field', true, rust),
                focusableItem('OK Button', false, rust),
                focusableItem('Cancel Button', false, rust),
              ]),
              const SizedBox(height: 4),
              dataRow('Tab from Cancel', '→ wraps to Input Field'),
              dataRow('Shift+Tab from Input', '→ wraps to Cancel'),
              dataRow('Focus escapes?', 'Never — trapped in dialog'),
            ],
          )),
    ],
  );

  // ─── Section 8: FocusScope Widget ───
  print('[Section 8] FocusScope Widget');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'FocusScope Widget'),
      noteBox(
          'FocusScope is the widget wrapper for FocusScopeNode, just as '
          'Focus wraps FocusNode. It automatically manages node lifecycle '
          'and provides the scope to its descendants.'),
      infoCard(
          'FocusScope Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('node', 'Optional external FocusScopeNode'),
              dataRow('autofocus', 'Whether to auto-focus on mount'),
              dataRow('canRequestFocus', 'Enable/disable scope'),
              dataRow('skipTraversal', 'Exclude from Tab order'),
              dataRow('debugLabel', 'For debugging focus tree'),
            ],
          )),
      infoCard(
          'FocusScope.of(context)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Returns', 'Nearest enclosing FocusScopeNode'),
              dataRow('Always available', 'Root scope always exists'),
              dataRow('Use case', 'Move focus within current scope'),
              dataRow('Common call', 'FocusScope.of(context).unfocus()'),
            ],
          )),
    ],
  );

  // ─── Section 9: Focus Path ───
  print('[Section 9] Focus Path');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Focus Path'),
      noteBox(
          'The focus path is the chain from the root scope down to the '
          'currently focused node. Each scope in the path has its own '
          '"focused child" pointing to the next scope or node.'),
      infoCard(
          'Focus Path Visualization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  color: mahogany.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: mahogany),
                    const SizedBox(width: 6),
                    Text('Root Scope',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: mahogany)),
                    const Spacer(),
                    Text('focusedChild → Page Scope',
                        style: TextStyle(fontSize: 10, color: deepCopper)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, bottom: 4),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  color: copper.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: copper),
                    const SizedBox(width: 6),
                    Text('Page Scope',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: copper)),
                    const Spacer(),
                    Text('focusedChild → Form Scope',
                        style: TextStyle(fontSize: 10, color: deepCopper)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 40, bottom: 4),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  color: terracotta.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: terracotta),
                    const SizedBox(width: 6),
                    Text('Form Scope',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: terracotta)),
                    const Spacer(),
                    Text('focusedChild → Name Field',
                        style: TextStyle(fontSize: 10, color: deepCopper)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 60, bottom: 4),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  color: bronze.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: bronze, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.keyboard, size: 14, color: bronze),
                    const SizedBox(width: 6),
                    Text('Name Field (primary focus)',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: bronze)),
                  ],
                ),
              ),
            ],
          )),
    ],
  );

  // ─── Section 10: canRequestFocus ───
  print('[Section 10] canRequestFocus');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'canRequestFocus'),
      noteBox(
          'Setting canRequestFocus to false on a scope disables the entire '
          'subtree. No children can receive focus. This is used to disable '
          'portions of the UI, like greyed-out form sections.'),
      infoCard(
          'Disabled Scope',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              scopeBlock('Enabled Section', copper, true, [
                focusableItem('Username', true, copper),
                focusableItem('Password', false, copper),
              ]),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: amber.withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.block, size: 14, color: rust),
                        const SizedBox(width: 6),
                        Text('Disabled Section (canRequestFocus: false)',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: rust)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    focusableItem('Credit Card (disabled)', false, amber),
                    focusableItem('Expiry (disabled)', false, amber),
                  ],
                ),
              ),
              dataRow('Tab from Password', 'Skips entire disabled section'),
              dataRow('Click credit card', 'No focus response'),
            ],
          )),
    ],
  );

  // ─── Section 11: skipTraversal ───
  print('[Section 11] skipTraversal');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'skipTraversal'),
      noteBox(
          'skipTraversal removes a scope from Tab traversal order but still '
          'allows programmatic focus. Useful for auxiliary panels that '
          'should not be in the main Tab flow.'),
      infoCard(
          'skipTraversal vs canRequestFocus',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('skipTraversal', 'Skipped by Tab, focusable by code'),
              dataRow('canRequestFocus false', 'Not focusable at all'),
              dataRow('skipTraversal children', 'Also skip Tab traversal'),
              dataRow('canRequestFocus children', 'Completely disabled'),
            ],
          )),
      infoCard(
          'Use Case: Toolbar',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Main content', 'Tab traversal includes form fields'),
              dataRow('Toolbar scope', 'skipTraversal: true'),
              dataRow('Keyboard shortcut', 'Can programmatically focus toolbar'),
              dataRow('User expectation', 'Tab stays in document'),
            ],
          )),
    ],
  );

  // ─── Section 12: Common Scenarios ───
  print('[Section 12] Common Scenarios');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Common Scenarios'),
      noteBox(
          'FocusScopeNode appears in many everyday Flutter patterns. '
          'Understanding these helps navigate focus issues in real apps.'),
      infoCard(
          'Bottom Sheet',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('New scope', 'showBottomSheet creates one'),
              dataRow('Autofocus', 'First field in sheet'),
              dataRow('Dismiss', 'Focus returns to trigger button'),
              dataRow('Barrier tap', 'Unfocuses sheet scope'),
            ],
          )),
      infoCard(
          'Search Bar',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('App bar scope', 'Contains search field'),
              dataRow('Suggestions', 'May have their own scope'),
              dataRow('Escape key', 'Unfocuses search, closes overlay'),
              dataRow('Submit', 'Focus moves to results'),
            ],
          )),
      infoCard(
          'Navigation Drawer',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Drawer scope', 'Separate from page scope'),
              dataRow('Menu items', 'Focused within drawer scope'),
              dataRow('Drawer close', 'Focus returns to page'),
              dataRow('Traversal', 'Trapped in drawer while open'),
            ],
          )),
    ],
  );

  // ─── Section 13: Debugging Focus ───
  print('[Section 13] Debugging Focus');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Debugging Focus'),
      noteBox(
          'Flutter provides tools for debugging focus: debugLabel, '
          'FocusManager.instance.highlightMode, and the focus tree in '
          'DevTools. FocusScopeNode.debugLabel is essential for large apps.'),
      infoCard(
          'Debug Tools',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('debugLabel', 'Name your scopes for clarity'),
              dataRow('FocusManager.instance', 'Inspect entire focus tree'),
              dataRow('primaryFocus', 'Currently focused node'),
              dataRow('highlightMode', 'Touch vs keyboard mode'),
            ],
          )),
      infoCard(
          'Common Focus Bugs',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Focus lost on rebuild', 'Key not preserved'),
              dataRow('Tab skips widget', 'Wrong scope or skipTraversal'),
              dataRow('Focus trapped', 'closedLoop without escape'),
              dataRow('Autofocus ignored', 'Another already focused'),
            ],
          )),
    ],
  );

  // ─── Section 14: FocusScopeNode API ───
  print('[Section 14] API Surface');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'API Surface'),
      noteBox(
          'FocusScopeNode extends FocusNode and adds scope-specific '
          'properties and methods for managing child focus.'),
      infoCard(
          'Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('focusedChild', 'Currently focused child node'),
              dataRow('isFirstFocus', 'Whether no child focused yet'),
              dataRow('traversalChildren', 'Focusable children in scope'),
              dataRow('traversalDescendants', 'All descendants for traversal'),
            ],
          )),
      infoCard(
          'Methods',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('setFirstFocus(node)', 'Set default focus target'),
              dataRow('autofocus(node)', 'Mark child for autofocus'),
              dataRow('requestFocus([node])', 'Focus scope or specific child'),
              dataRow('unfocus()', 'Remove focus from scope'),
            ],
          )),
    ],
  );

  // ─── Section 15: Performance Considerations ───
  print('[Section 15] Performance');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Performance'),
      noteBox(
          'Focus scope operations are lightweight. The tree is traversed '
          'only on focus changes, not every frame. However, deeply nested '
          'scopes with many children can slow traversal computation.'),
      infoCard(
          'Cost Analysis',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Focus change routing', 0.10, copper),
              progressBar('Traversal sorting', 0.25, bronze),
              progressBar('Scope notification', 0.15, terracotta),
              progressBar('Rebuild via listeners', 0.50, rust),
            ],
          )),
      infoCard(
          'Best Practices',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Limit nesting', 'Avoid more than 4-5 scope levels'),
              dataRow('Scope per region', 'Not per widget'),
              dataRow('Disable unused', 'canRequestFocus: false'),
              dataRow('Reuse nodes', 'Preserve across rebuilds'),
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
      noteBox('Complete overview of the FocusScopeNode deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Copper', copper),
              colorSwatch('Bronze', bronze),
              colorSwatch('Deep Cop.', deepCopper),
              colorSwatch('Pale Sand', paleSand),
              colorSwatch('Rust', rust),
              colorSwatch('Cream', cream),
              colorSwatch('Mahogany', mahogany),
              colorSwatch('Amber', amber),
              colorSwatch('Terracotta', terracotta),
              colorSwatch('Sienna', sienna),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, copper),
              progressBar('Scope Hierarchy', 1.0, bronze),
              progressBar('Autofocus', 1.0, terracotta),
              progressBar('Focus Memory', 1.0, rust),
              progressBar('setFirstFocus', 1.0, copper),
              progressBar('Unfocus Strategies', 1.0, bronze),
              progressBar('Traversal Boundaries', 1.0, terracotta),
              progressBar('FocusScope Widget', 1.0, rust),
              progressBar('Focus Path', 1.0, copper),
              progressBar('canRequestFocus', 1.0, bronze),
              progressBar('skipTraversal', 1.0, terracotta),
              progressBar('Common Scenarios', 1.0, rust),
              progressBar('Debugging', 1.0, copper),
              progressBar('API Surface', 1.0, bronze),
              progressBar('Performance', 1.0, terracotta),
              progressBar('Dashboard', 1.0, rust),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Copper / Bronze'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('FocusScopeNode', copper, Colors.white),
          tag('Focus Hierarchy', bronze, Colors.white),
          tag('Autofocus', terracotta, Colors.white),
          tag('Traversal', rust, Colors.white),
          tag('Focus Memory', sienna, Colors.white),
          tag('Scope Boundary', mahogany, Colors.white),
        ],
      ),
    ],
  );

  print('===== END FOCUS SCOPE NODE DEEP DEMO =====');

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
