// ignore_for_file: avoid_print
// D4rt deep demo: AutofillScopeMixin & Autofill Scoping Architecture
// Demonstrates how AutofillScopeMixin provides scoped autofill registration,
// client management, and the relationship between scopes and groups.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Teal / Lagoon palette ───
  const Color teal = Color(0xFF008080);
  const Color lagoon = Color(0xFF006D6F);
  const Color aqua = Color(0xFF00B4D8);
  const Color paleTeal = Color(0xFFE0F7FA);
  const Color deepLagoon = Color(0xFF004D4D);
  const Color seaGreen = Color(0xFF2E8B57);
  const Color lightAqua = Color(0xFFB2EBF2);
  const Color softCyan = Color(0xFFF0FDFD);
  const Color darkSea = Color(0xFF1A5653);
  const Color turquoise = Color(0xFF40E0D0);

  print('[as] ===== AUTOFILL SCOPE MIXIN DEEP DEMO =====');

  // ─── Helpers declared before use ───

  Widget asBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [deepLagoon, teal],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepLagoon.withValues(alpha: 0.35),
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
              color: darkSea,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: turquoise, width: 1.5),
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

  Widget asNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: softCyan,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lightAqua.withValues(alpha: 0.7)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepLagoon.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget asCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: paleTeal.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: teal, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: deepLagoon,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: lagoon)),
          ),
        ],
      ),
    );
  }

  Widget asCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lightAqua.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: deepLagoon.withValues(alpha: 0.06),
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
              color: teal.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepLagoon)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget asRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? teal.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: lightAqua.withValues(alpha: 0.4)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? deepLagoon : lagoon)),
          );
        }).toList(),
      ),
    );
  }

  Widget asFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? deepLagoon : teal,
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
          child: Icon(Icons.east, size: 12, color: aqua),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  Widget asLayerBox(String label, Color color, double height) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color.computeLuminance() > 0.5
                    ? deepLagoon
                    : Colors.white)),
      ),
    );
  }

  // ━━━━━━ SECTION 1: What is AutofillScopeMixin? ━━━━━━
  print('[as-01] Section 1: What is AutofillScopeMixin?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('01', 'What Is AutofillScopeMixin?'),
      asNote(
        'AutofillScopeMixin is a mixin on State that provides the machinery '
        'for managing a group of AutofillClients as a single autofill scope. '
        'It maintains a registry of clients, assigns unique autofill IDs, and '
        'coordinates the attach/detach lifecycle with the platform. '
        'AutofillGroupState is the primary user of this mixin.',
      ),
      asCard(
        'Mixin in the Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            asLayerBox('AutofillGroup (widget)', teal.withValues(alpha: 0.15), 38),
            asLayerBox('AutofillGroupState with AutofillScopeMixin', aqua.withValues(alpha: 0.18), 42),
            asLayerBox('AutofillClient instances (TextFields)', lagoon.withValues(alpha: 0.12), 38),
            asLayerBox('Platform Autofill Service', deepLagoon.withValues(alpha: 0.08), 38),
            const SizedBox(height: 10),
            asFlow(['Mixin provides', 'register/unregister', 'client map', 'attach/detach']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Why a mixin? ━━━━━━
  print('[as-02] Section 2: Why a mixin?');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('02', 'Why a Mixin?'),
      asNote(
        'Flutter uses a mixin instead of a base class because State already '
        'inherits from a framework class. Dart doesn\'t allow multiple '
        'inheritance, but mixins let you compose behavior. Any State subclass '
        'can add autofill scope management without changing its class hierarchy.',
      ),
      asCard(
        'Mixin vs Inheritance',
        Column(
          children: [
            asRow(['Approach', 'Limitation', 'Flexibility'], isHeader: true),
            asRow(['Base class', 'Single inheritance', 'Low — locked hierarchy']),
            asRow(['Interface', 'No default impl', 'High — but boilerplate']),
            asRow(['Mixin ✓', 'on State constraint', 'High — composable']),
          ],
        ),
      ),
      asCard(
        'Dart Mixin Mechanics',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            asCode('mixin AutofillScopeMixin on State',
                'Constrains to State subclasses only'),
            asCode('with AutofillScopeMixin',
                'Added to any State<T> class declaration'),
            asCode('on constraint',
                'Ensures lifecycle methods (dispose) are available'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Core API surface ━━━━━━
  print('[as-03] Section 3: Core API');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('03', 'Core API Surface'),
      asNote(
        'AutofillScopeMixin exposes a small but focused API for managing '
        'autofill clients within a scope. The key members are the client '
        'registry, registration methods, and the autofillId property.',
      ),
      asCard(
        'Mixin Members',
        Column(
          children: [
            asRow(['Member', 'Type', 'Purpose'], isHeader: true),
            asRow(['autofillClients', 'Map<String, AutofillClient>',
                'All registered clients']),
            asRow(['register(client)', 'method',
                'Add a client to the scope']),
            asRow(['unregister(id)', 'method',
                'Remove a client from the scope']),
            asRow(['currentAutofillScope', 'getter',
                'The current active scope']),
            asRow(['attach(client)', 'method',
                'Connect client to platform']),
          ],
        ),
      ),
      asCard(
        'autofillClients Map',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: paleTeal.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Map<String, AutofillClient>',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          color: deepLagoon)),
                  const SizedBox(height: 8),
                  _asScopeEntry('autofill_0', 'Email TextField', teal),
                  _asScopeEntry('autofill_1', 'Password TextField', lagoon),
                  _asScopeEntry('autofill_2', 'Name TextField', seaGreen),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Registration lifecycle ━━━━━━
  print('[as-04] Section 4: Registration lifecycle');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('04', 'Registration Lifecycle'),
      asNote(
        'Clients register when they\'re built and unregister when disposed. '
        'The mixin tracks registration state to prevent double-registration '
        'and to properly clean up when the scope widget is disposed.',
      ),
      asCard(
        'Lifecycle Steps',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _asStepItem(1, 'AutofillGroup builds', 'Creates the scope', teal),
            _asStepItem(2, 'TextField builds inside', 'EditableTextState registers', lagoon),
            _asStepItem(3, 'User focuses field', 'Scope attaches to platform', aqua),
            _asStepItem(4, 'Platform fills values', 'All group clients receive data', seaGreen),
            _asStepItem(5, 'TextField disposes', 'Unregisters from scope', turquoise),
            _asStepItem(6, 'AutofillGroup disposes', 'Commits/cancels, cleans up', deepLagoon),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: ID generation ━━━━━━
  print('[as-05] Section 5: ID generation');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('05', 'Autofill ID Generation'),
      asNote(
        'Each AutofillClient needs a unique autofillId so the platform can '
        'address individual fields. The mixin generates these IDs, typically '
        'using a counter or hash-based scheme to ensure uniqueness within '
        'the scope.',
      ),
      asCard(
        'ID Assignment Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            asFlow(['Client registers', 'Mixin assigns ID', 'Stored in map', 'Platform uses ID']),
            const SizedBox(height: 12),
            asRow(['Property', 'Value', 'Uniqueness'], isHeader: true),
            asRow(['autofillId', 'String', 'Per-scope unique']),
            asRow(['Based on', 'EditableText hashCode', 'Deterministic']),
            asRow(['Lifetime', 'Registration → disposal', 'Scope-bound']),
          ],
        ),
      ),
      asCard(
        'ID Properties',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            asCode('Unique per scope', 'No two clients share an ID'),
            asCode('Stable', 'Doesn\'t change during rebuild'),
            asCode('String-typed', 'Platform-compatible format'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Scope vs Group ━━━━━━
  print('[as-06] Section 6: Scope vs Group');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('06', 'AutofillScopeMixin vs AutofillGroup'),
      asNote(
        'AutofillScopeMixin is the implementation detail; AutofillGroup is '
        'the public-facing widget. The mixin provides the machinery, while '
        'the widget provides the tree structure and API that developers use.',
      ),
      asCard(
        'Relationship',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: teal.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: teal),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.widgets, color: teal, size: 24),
                        const SizedBox(height: 4),
                        Text('AutofillGroup',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: teal)),
                        Text('Widget (public API)',
                            style: TextStyle(fontSize: 9, color: lagoon)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Text('uses',
                          style: TextStyle(fontSize: 9, color: lagoon)),
                      Icon(Icons.arrow_forward, color: aqua, size: 16),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: deepLagoon.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: deepLagoon),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, color: deepLagoon, size: 24),
                        const SizedBox(height: 4),
                        Text('AutofillScopeMixin',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: deepLagoon)),
                        Text('Machinery (internal)',
                            style: TextStyle(fontSize: 9, color: lagoon)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            asRow(['Aspect', 'AutofillGroup', 'AutofillScopeMixin'], isHeader: true),
            asRow(['Layer', 'Widget', 'Mixin on State']),
            asRow(['Visibility', 'Public API', 'Framework internal']),
            asRow(['Role', 'Tree structure', 'Client management']),
            asRow(['Developer use', 'Directly in code', 'Rarely used directly']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Platform attach/detach ━━━━━━
  print('[as-07] Section 7: Platform attach/detach');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('07', 'Platform Attach & Detach'),
      asNote(
        'When a client in the scope gains focus, the mixin attaches the entire '
        'scope to the platform autofill service. This tells the platform about '
        'all fields in the scope at once, enabling it to fill multiple fields '
        'from a single autofill entry.',
      ),
      asCard(
        'Attach Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            asFlow([
              'Focus gained',
              'Scope attaches',
              'All clients sent',
              'Platform maps fields',
            ]),
            const SizedBox(height: 12),
            asRow(['Event', 'Action', 'Platform Effect'], isHeader: true),
            asRow(['Focus in', 'Attach scope', 'Autofill popup appears']),
            asRow(['Focus out', 'May detach', 'Popup dismissed']),
            asRow(['Dispose', 'Detach + commit', 'Save or discard']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Multiple scopes ━━━━━━
  print('[as-08] Section 8: Multiple scopes');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('08', 'Multiple Scopes in One Screen'),
      asNote(
        'A screen can have multiple independent autofill scopes. For example, '
        'a login form and a registration form on the same page. Each scope '
        'operates independently — filling one scope doesn\'t affect the other.',
      ),
      asCard(
        'Multi-Scope Layout',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: teal.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: teal),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Scope A: Login',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: teal)),
                        const SizedBox(height: 6),
                        _asScopeEntry('email', 'Email field', teal),
                        _asScopeEntry('password', 'Password field', lagoon),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: deepLagoon.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: deepLagoon),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Scope B: Register',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: deepLagoon)),
                        const SizedBox(height: 6),
                        _asScopeEntry('name', 'Name field', deepLagoon),
                        _asScopeEntry('newEmail', 'Email field', darkSea),
                        _asScopeEntry('newPass', 'New password', lagoon),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: paleTeal,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Each scope independently manages its clients and '
                  'communicates with the platform separately.',
                  style: TextStyle(fontSize: 11, color: deepLagoon)),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Nested scopes ━━━━━━
  print('[as-09] Section 9: Nested scopes');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('09', 'Nested Scopes'),
      asNote(
        'AutofillGroups can be nested. The innermost scope wins for each '
        'client — a TextField registers with the nearest AutofillGroup '
        'ancestor. This is useful for complex forms with sub-sections.',
      ),
      asCard(
        'Nested Scope Resolution',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: teal.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: teal.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Outer AutofillGroup',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: teal)),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 6),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: aqua.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: aqua.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Inner AutofillGroup',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: aqua)),
                          const SizedBox(height: 4),
                          Text('→ TextField registers HERE',
                              style: TextStyle(fontSize: 10, color: lagoon)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Dispose behavior ━━━━━━
  print('[as-10] Section 10: Dispose behavior');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('10', 'Dispose Behavior & Cleanup'),
      asNote(
        'When the scope widget disposes (form navigated away), the mixin '
        'performs cleanup: unregisters all remaining clients, then either '
        'commits autofill data (success path) or cancels (abort path). '
        'This is controlled by AutofillGroup.onDisposeAction.',
      ),
      asCard(
        'Dispose Cleanup Steps',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _asStepItem(1, 'Scope widget disposes', 'Widget tree teardown', teal),
            _asStepItem(2, 'Check onDisposeAction', 'Commit or cancel?', lagoon),
            _asStepItem(3, 'Platform notified', 'TextInput.finishAutofillContext', aqua),
            _asStepItem(4, 'Clients unregistered', 'Map cleared', seaGreen),
            _asStepItem(5, 'Resources released', 'GC-ready', deepLagoon),
          ],
        ),
      ),
      asCard(
        'onDisposeAction Values',
        Column(
          children: [
            asRow(['Value', 'Platform Call', 'When to Use'], isHeader: true),
            asRow(['commit', 'finishAutofill(shouldSave: true)', 'Login success']),
            asRow(['cancel', 'finishAutofill(shouldSave: false)', 'Navigation away']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Relationship to TextInput ━━━━━━
  print('[as-11] Section 11: TextInput relationship');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('11', 'Relationship to TextInput System'),
      asNote(
        'AutofillScopeMixin works through the TextInput system channel. When '
        'attaching, it sends a setClient message with all autofill field '
        'configurations. This integrates directly with the same channel that '
        'handles keyboard input and text editing.',
      ),
      asCard(
        'TextInput Channel Integration',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            asLayerBox('AutofillScopeMixin', teal.withValues(alpha: 0.15), 35),
            asLayerBox('TextInputConnection', aqua.withValues(alpha: 0.12), 35),
            asLayerBox('SystemChannels.textInput', lagoon.withValues(alpha: 0.1), 35),
            asLayerBox('Platform TextInput Service', deepLagoon.withValues(alpha: 0.08), 35),
            const SizedBox(height: 10),
            asRow(['Message', 'Direction', 'Purpose'], isHeader: true),
            asRow(['TextInput.setClient', 'Dart → Platform', 'Register fields']),
            asRow(['TextInput.updateConfig', 'Dart → Platform', 'Update hints']),
            asRow(['TextInputClient.updateEditingState', 'Platform → Dart', 'Filled values']),
            asRow(['TextInput.finishAutofillContext', 'Dart → Platform', 'Commit/cancel']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Custom scope impl ━━━━━━
  print('[as-12] Section 12: Custom scope');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('12', 'Implementing a Custom Autofill Scope'),
      asNote(
        'While most developers use AutofillGroup, you can build a custom '
        'scope widget by applying AutofillScopeMixin directly. This is useful '
        'for specialized form management or custom autofill lifecycle control.',
      ),
      asCard(
        'Custom Scope Pattern',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: paleTeal.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'class MyFormState extends State<MyForm>\n'
                '    with AutofillScopeMixin {\n'
                '  // Override attach/detach for custom behavior\n'
                '  // Manage client registration manually\n'
                '  // Control commit/cancel timing\n'
                '}',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: deepLagoon,
                    height: 1.4),
              ),
            ),
            const SizedBox(height: 8),
            asRow(['When to Use', 'Example'], isHeader: true),
            asRow(['Custom commit timing', 'Multi-step wizard forms']),
            asRow(['Conditional registration', 'Dynamic field visibility']),
            asRow(['Custom ID generation', 'Server-side ID matching']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: State serialization ━━━━━━
  print('[as-13] Section 13: State serialization');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('13', 'Autofill State Serialization'),
      asNote(
        'When the scope attaches to the platform, all client configurations '
        'are serialized into a map structure. This includes autofill hints, '
        'current values, and text input types. The platform uses this map to '
        'build its autofill view structure.',
      ),
      asCard(
        'Serialized Configuration',
        Column(
          children: [
            asCode('autofillId', 'Unique string ID for the field'),
            asCode('autofillHints', 'List<String> of hint constants'),
            asCode('editingValue', 'Current TextEditingValue (text, selection)'),
            asCode('inputType', 'TextInputType (text, email, number, etc.)'),
            asCode('obscureText', 'Boolean for password fields'),
            asCode('inputAction', 'TextInputAction (done, next, etc.)'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Testing scopes ━━━━━━
  print('[as-14] Section 14: Testing');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('14', 'Testing Autofill Scopes'),
      asNote(
        'Widget tests can verify scope configuration and registration. '
        'Use tester.binding to intercept TextInput channel messages and '
        'verify autofill-related calls.',
      ),
      asCard(
        'Testing Strategies',
        Column(
          children: [
            asRow(['Test', 'Approach', 'Verifies'], isHeader: true),
            asRow(['Registration', 'find.byType(AutofillGroup)', 'Group exists']),
            asRow(['Hints present', 'Check TextField config', 'Correct hints']),
            asRow(['Channel calls', 'Mock TextInput channel', 'Platform messages']),
            asRow(['Commit/cancel', 'Dispose + check calls', 'onDisposeAction']),
            asRow(['Multi-scope', 'Two groups in tree', 'Independence']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Edge cases ━━━━━━
  print('[as-15] Section 15: Edge cases');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('15', 'Edge Cases & Gotchas'),
      asNote(
        'Autofill scoping has subtle edge cases around dynamic forms, '
        'hot restart, and platform differences.',
      ),
      asCard(
        'Known Edge Cases',
        Column(
          children: [
            _asEdgeCaseRow('Dynamic field add/remove',
                'Clients must re-register; scope may need to re-attach',
                Icons.swap_vert, teal),
            _asEdgeCaseRow('Hot restart clears state',
                'Platform autofill context is lost; expected in dev',
                Icons.refresh, lagoon),
            _asEdgeCaseRow('Scope in dialog',
                'Dialog closes = dispose → commit fires; may be undesired',
                Icons.launch, aqua),
            _asEdgeCaseRow('Tab switching with form',
                'Tab change may dispose/rebuild scope; state can be lost',
                Icons.tab, seaGreen),
            _asEdgeCaseRow('Animation-driven field visibility',
                'Register/unregister during animation can cause jank',
                Icons.animation, deepLagoon),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[as-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      asBanner('16', 'Summary Dashboard'),
      asCard(
        'AutofillScopeMixin Architecture — Complete',
        Column(
          children: [
            asRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            asRow(['Concept', 'S01', 'Mixin provides scope machinery']),
            asRow(['Why mixin', 'S02', 'Composable, no hierarchy lock']),
            asRow(['API', 'S03', 'register, unregister, autofillClients']),
            asRow(['Lifecycle', 'S04', 'Build → register → fill → dispose']),
            asRow(['IDs', 'S05', 'Unique string IDs per scope']),
            asRow(['vs Group', 'S06', 'Mixin = internal; Group = public']),
            asRow(['Attach/detach', 'S07', 'Platform connection on focus']),
            asRow(['Multi-scope', 'S08', 'Independent parallel scopes']),
            asRow(['Nesting', 'S09', 'Innermost scope wins']),
            asRow(['Dispose', 'S10', 'Commit or cancel on cleanup']),
            asRow(['TextInput', 'S11', 'Channel-based communication']),
            asRow(['Custom scope', 'S12', 'Mixin directly for control']),
            asRow(['Serialization', 'S13', 'Config map to platform']),
            asRow(['Testing', 'S14', 'Channel mocking & group finding']),
            asRow(['Edge cases', 'S15', 'Dynamic, dialogs, tabs']),
          ],
        ),
      ),
      asCard(
        'Teal / Lagoon Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _asColorSwatch('Teal', teal),
            _asColorSwatch('Lagoon', lagoon),
            _asColorSwatch('Aqua', aqua),
            _asColorSwatch('DeepLag', deepLagoon),
            _asColorSwatch('Turquoise', turquoise),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [deepLagoon, teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('AutofillScopeMixin — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From mixin mechanics through registration lifecycle, scope vs '
              'group, platform attachment, nested scopes, and state '
              'serialization — the full autofill scoping architecture.',
              style: TextStyle(color: paleTeal, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[as] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutofillScopeMixin & Scoping'),
        backgroundColor: deepLagoon,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF0FAFA),
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

Widget _asScopeEntry(String id, String label, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(id,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: color)),
        ),
        const SizedBox(width: 8),
        Icon(Icons.arrow_right_alt, size: 14, color: color),
        const SizedBox(width: 4),
        Text(label,
            style: TextStyle(fontSize: 11, color: const Color(0xFF004D4D))),
      ],
    ),
  );
}

Widget _asStepItem(int num, String phase, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(phase,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(desc,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF004D4D))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _asEdgeCaseRow(String title, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF004D4D))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _asColorSwatch(String name, Color color) {
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
