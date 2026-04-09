// ignore_for_file: avoid_print
// D4rt deep demo: AutofillScope — the abstract interface that groups
// autofill-capable fields so the platform can fill entire forms at once.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Amber / Honey palette ───
  const Color amber = Color(0xFFFFBF00);
  const Color honey = Color(0xFFEB9E34);
  const Color darkAmber = Color(0xFF996600);
  const Color paleHoney = Color(0xFFFFF8E7);
  const Color deepAmber = Color(0xFF7A5200);
  const Color goldenrod = Color(0xFFDAA520);
  const Color beeswax = Color(0xFFFFF0C1);
  const Color butterscotch = Color(0xFFE09540);
  const Color caramel = Color(0xFFC27F24);
  const Color cream = Color(0xFFFFFDD0);

  print('[af] ===== AUTOFILL SCOPE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget afBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepAmber, darkAmber],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepAmber.withValues(alpha: 0.35),
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
              color: caramel,
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

  Widget afNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: beeswax),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepAmber.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget afCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: paleHoney.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: amber, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: deepAmber,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: darkAmber)),
          ),
        ],
      ),
    );
  }

  Widget afCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: beeswax.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: deepAmber.withValues(alpha: 0.06),
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
              color: amber.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepAmber)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget afRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? amber.withValues(alpha: 0.07) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: beeswax.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? deepAmber : darkAmber)),
          );
        }).toList(),
      ),
    );
  }

  Widget afFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? deepAmber : caramel,
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
          child: Icon(Icons.east, size: 12, color: honey),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  Widget afLayerBox(String label, Color color, double height) {
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
                    ? deepAmber
                    : Colors.white)),
      ),
    );
  }

  Widget afFieldBox(String label, String hint, IconData icon, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: accent),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: accent)),
                Text(hint,
                    style: TextStyle(fontSize: 10, color: darkAmber)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ━━━━━━ SECTION 1: What is AutofillScope? ━━━━━━
  print('[af-01] Section 1: What is AutofillScope?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('01', 'What Is AutofillScope?'),
      afNote(
        'AutofillScope is an abstract interface that defines how a group of '
        'autofill-capable fields (AutofillClients) are organized into a single '
        'unit. When the platform\'s autofill service fills one field, it uses '
        'the scope to find and fill all related fields at once — so email, '
        'password, and name fields in a login form all get filled together.',
      ),
      afCard(
        'AutofillScope in the Widget Tree',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            afLayerBox('Scaffold / Page', amber.withValues(alpha: 0.1), 34),
            afLayerBox('AutofillGroup  ← creates AutofillScope', goldenrod.withValues(alpha: 0.15), 40),
            afLayerBox('  TextField (email)   ← AutofillClient', honey.withValues(alpha: 0.12), 34),
            afLayerBox('  TextField (password) ← AutofillClient', butterscotch.withValues(alpha: 0.12), 34),
            afLayerBox('Platform Autofill Service', deepAmber.withValues(alpha: 0.08), 34),
            const SizedBox(height: 10),
            afFlow(['AutofillGroup', 'creates scope', 'fields register', 'platform fills all']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Core API ━━━━━━
  print('[af-02] Section 2: Core API');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('02', 'Core API Surface'),
      afNote(
        'AutofillScope defines three key members: a getter for all registered '
        'clients, a lookup method to find a specific client by its autofill ID, '
        'and an attach method that connects a client to the platform text input '
        'system with autofill context.',
      ),
      afCard(
        'Abstract Members',
        Column(
          children: [
            afRow(['Member', 'Returns', 'Purpose'], isHeader: true),
            afRow(['autofillClients', 'Iterable<AutofillClient>',
                'All fields in this scope']),
            afRow(['getAutofillClient(id)', 'AutofillClient?',
                'Lookup by autofill ID']),
            afRow(['attach(client, config)', 'TextInputConnection',
                'Connect client to platform']),
          ],
        ),
      ),
      afCard(
        'API Details',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            afCode('autofillClients',
                'Read-only collection of all registered AutofillClient instances'),
            afCode('getAutofillClient(String)',
                'Platform calls this to route filled values to specific fields'),
            afCode('attach(AutofillClient, TextInputConfiguration)',
                'Creates TextInputConnection with autofill context from all clients'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: AutofillGroup as primary implementation ━━━━━━
  print('[af-03] Section 3: AutofillGroup implementation');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('03', 'AutofillGroup — Primary Implementation'),
      afNote(
        'AutofillGroup is the widget that implements AutofillScope through '
        'its State class (AutofillGroupState). Developers wrap their form '
        'fields in AutofillGroup, and the state object manages client '
        'registration, platform attachment, and disposal automatically.',
      ),
      afCard(
        'AutofillGroup Widget',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: paleHoney,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AutofillGroup(',
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: deepAmber,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('onDisposeAction: AutofillContextAction.commit,',
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: darkAmber)),
                        Text('child: Column(',
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: darkAmber)),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('children: [',
                                  style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 11,
                                      color: darkAmber)),
                              Text('  TextField(autofillHints: [AutofillHints.email]),',
                                  style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 11,
                                      color: caramel)),
                              Text('  TextField(autofillHints: [AutofillHints.password]),',
                                  style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 11,
                                      color: caramel)),
                              Text('],',
                                  style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 11,
                                      color: darkAmber)),
                            ],
                          ),
                        ),
                        Text('),',
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: darkAmber)),
                      ],
                    ),
                  ),
                  Text(')',
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: deepAmber,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
      afCard(
        'AutofillGroupState Responsibilities',
        Column(
          children: [
            afRow(['Role', 'Mechanism'], isHeader: true),
            afRow(['Implements AutofillScope', 'Mixin + override']),
            afRow(['Tracks registered clients', 'Internal map by autofillId']),
            afRow(['Provides scope via InheritedWidget', 'Children look up scope']),
            afRow(['Manages dispose action', 'commit or cancel']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Registration flow ━━━━━━
  print('[af-04] Section 4: Client registration flow');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('04', 'Client Registration Flow'),
      afNote(
        'When a TextField builds inside an AutofillGroup, its EditableTextState '
        '(which is an AutofillClient) looks up the nearest AutofillScope and '
        'registers itself. The scope stores the client by its autofillId for '
        'later lookup by the platform.',
      ),
      afCard(
        'Registration Sequence',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _afStepItem(1, 'AutofillGroup builds', 'AutofillGroupState is created with AutofillScopeMixin', amber),
            _afStepItem(2, 'TextField builds inside', 'EditableTextState.didChangeDependencies() fires', honey),
            _afStepItem(3, 'EditableText looks up scope', 'AutofillGroup.of(context) returns scope', goldenrod),
            _afStepItem(4, 'Client registers', 'scope.register(this) adds to client map', butterscotch),
            _afStepItem(5, 'User taps field', 'scope.attach() sends ALL client configs to platform', caramel),
            _afStepItem(6, 'Platform fills', 'Values routed via getAutofillClient(id)', deepAmber),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Platform integration ━━━━━━
  print('[af-05] Section 5: Platform integration');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('05', 'Platform Integration'),
      afNote(
        'Each platform implements autofill differently, but the scope\'s role '
        'is the same: group related fields so the OS can fill them together.',
      ),
      afCard(
        'Platform Mapping',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _afPlatformBox('Android',
                    'AutofillService groups fields by the scope. '
                    'Uses autofillHints to match saved entries.',
                    Icons.android, const Color(0xFF3DDC84))),
                const SizedBox(width: 8),
                Expanded(child: _afPlatformBox('iOS',
                    'UITextContentType groups via accessoryView. '
                    'Scope maps to a single form context.',
                    Icons.phone_iphone, const Color(0xFF007AFF))),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _afPlatformBox('Web',
                    'HTML autocomplete attribute per input. '
                    'Browser groups by form element.',
                    Icons.web, const Color(0xFFE44D26))),
                const SizedBox(width: 8),
                Expanded(child: _afPlatformBox('Desktop',
                    'Password managers provide autofill. '
                    'Scope tells manager which fields relate.',
                    Icons.desktop_windows, const Color(0xFF6E6E6E))),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Scope isolation ━━━━━━
  print('[af-06] Section 6: Scope isolation');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('06', 'Scope Isolation'),
      afNote(
        'Scopes are independent — filling or committing one scope does not '
        'affect another. This prevents a login form from interfering with a '
        'separate registration form on the same page.',
      ),
      afCard(
        'Isolation Diagram',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: amber.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: amber),
                    ),
                    child: Column(
                      children: [
                        Text('Scope A',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: deepAmber)),
                        const SizedBox(height: 6),
                        afFieldBox('Email', 'AutofillHints.email', Icons.email, amber),
                        afFieldBox('Password', 'AutofillHints.password', Icons.lock, honey),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50).withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('✓ Fills together',
                              style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32)),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Icon(Icons.block, color: Colors.red.withValues(alpha: 0.4), size: 20),
                      Text('isolated',
                          style: TextStyle(fontSize: 9, color: Colors.red.withValues(alpha: 0.5))),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: goldenrod.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: goldenrod),
                    ),
                    child: Column(
                      children: [
                        Text('Scope B',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: darkAmber)),
                        const SizedBox(height: 6),
                        afFieldBox('Name', 'AutofillHints.name', Icons.person, goldenrod),
                        afFieldBox('Phone', 'AutofillHints.telephoneNumber', Icons.phone, butterscotch),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50).withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('✓ Fills together',
                              style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32)),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Login form scope ━━━━━━
  print('[af-07] Section 7: Login form scope');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('07', 'Login Form — Single Scope'),
      afNote(
        'The most common AutofillScope use case: a login form with two fields. '
        'The scope ensures both fields are sent to the autofill service together.',
      ),
      afCard(
        'Login Form Layout',
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: paleHoney,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: goldenrod.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lock_outline, color: deepAmber, size: 22),
                  const SizedBox(width: 8),
                  Text('Login',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: deepAmber)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: amber.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.email_outlined, size: 18, color: honey),
                    const SizedBox(width: 8),
                    Text('user@example.com',
                        style: TextStyle(fontSize: 13, color: darkAmber)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: amber.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.password, size: 18, color: honey),
                    const SizedBox(width: 8),
                    Text('••••••••',
                        style: TextStyle(fontSize: 13, color: darkAmber)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: deepAmber,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 8),
              Text('Both fields share one AutofillScope → platform fills '
                  'email+password simultaneously from saved credentials.',
                  style: TextStyle(fontSize: 10, color: darkAmber)),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Multi-scope page ━━━━━━
  print('[af-08] Section 8: Multi-scope page');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('08', 'Multi-Scope Page Layout'),
      afNote(
        'A single page can host multiple independent AutofillScopes. '
        'Each scope operates in isolation — the platform treats them as '
        'separate "forms" with different autofill contexts.',
      ),
      afCard(
        'Tabbed Settings Page',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _afScopeTab('Profile', Icons.person, amber, true),
                const SizedBox(width: 4),
                _afScopeTab('Billing', Icons.credit_card, honey, false),
                const SizedBox(width: 4),
                _afScopeTab('Shipping', Icons.local_shipping, goldenrod, false),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: amber.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: amber.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Scope: Profile',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: deepAmber)),
                  const SizedBox(height: 4),
                  afFieldBox('Full Name', 'name', Icons.person, amber),
                  afFieldBox('Email', 'email', Icons.email, honey),
                  afFieldBox('Phone', 'telephoneNumber', Icons.phone, goldenrod),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text('Each tab creates its own AutofillScope. Filling profile '
                'fields does not trigger billing autofill.',
                style: TextStyle(fontSize: 10, color: darkAmber)),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Credential autofill ━━━━━━
  print('[af-09] Section 9: Credential autofill');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('09', 'Credential Autofill Flow'),
      afNote(
        'Credential autofill is the most time-critical scope scenario. '
        'The scope groups username/email and password so the platform can '
        'offer a single-tap login experience.',
      ),
      afCard(
        'Credential Flow Timeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            afFlow(['Page loads', 'Scope created', 'Fields register',
                'Focus email', 'Platform offers', 'User taps', 'Both filled']),
            const SizedBox(height: 12),
            afRow(['Step', 'Actor', 'Result'], isHeader: true),
            afRow(['1. build()', 'Flutter', 'Scope + fields created']),
            afRow(['2. focus', 'User', 'Scope sends config to platform']),
            afRow(['3. offer', 'OS', 'Autofill popup appears']),
            afRow(['4. select', 'User', 'Platform calls updateEditingState']),
            afRow(['5. fill', 'Platform→Scope', 'Both email and password filled']),
            afRow(['6. submit', 'User', 'onDisposeAction: commit']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Address autofill ━━━━━━
  print('[af-10] Section 10: Address autofill');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('10', 'Address Autofill Scope'),
      afNote(
        'Address forms typically have 5-7 fields all within one scope. '
        'The platform fills street, city, state, zip, and country in one action.',
      ),
      afCard(
        'Address Form',
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: beeswax.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AutofillGroup — Address Scope',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: deepAmber)),
              const Divider(),
              afFieldBox('Street', 'streetAddressLine1', Icons.home, amber),
              afFieldBox('Apt/Suite', 'streetAddressLine2', Icons.apartment, honey),
              Row(
                children: [
                  Expanded(
                    child: afFieldBox('City', 'addressCity', Icons.location_city, goldenrod),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: afFieldBox('State', 'addressState', Icons.map, butterscotch),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: afFieldBox('Zip', 'postalCode', Icons.pin, caramel),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: afFieldBox('Country', 'countryName', Icons.flag, deepAmber),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('All 6 fields: one scope → one autofill action',
                  style: TextStyle(fontSize: 10, color: darkAmber)),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Payment scope ━━━━━━
  print('[af-11] Section 11: Payment scope');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('11', 'Payment Form Scope'),
      afNote(
        'Payment forms group card number, expiration, CVV, and cardholder '
        'name. This scope is security-sensitive — platforms handle payment '
        'fields with extra protection (e.g., no screenshots on Android).',
      ),
      afCard(
        'Payment Card Form',
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepAmber.withValues(alpha: 0.08), caramel.withValues(alpha: 0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: goldenrod.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('CREDIT CARD',
                      style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 2,
                          color: darkAmber)),
                  Icon(Icons.credit_card, color: goldenrod, size: 22),
                ],
              ),
              const SizedBox(height: 12),
              afFieldBox('Card Number', 'creditCardNumber', Icons.payment, amber),
              Row(
                children: [
                  Expanded(
                    child: afFieldBox('Exp', 'creditCardExpDate', Icons.date_range, honey),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: afFieldBox('CVV', 'creditCardSecurityCode', Icons.security, goldenrod),
                  ),
                ],
              ),
              afFieldBox('Name on Card', 'creditCardName', Icons.person, butterscotch),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, size: 14, color: caramel),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Separate scope from login/address — prevents credential '
                        'manager from accessing payment data',
                        style: TextStyle(fontSize: 9, color: darkAmber),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Nested scopes ━━━━━━
  print('[af-12] Section 12: Nested scopes');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('12', 'Nested Scopes in Complex Forms'),
      afNote(
        'AutofillGroup widgets can nest. The innermost group owns its fields. '
        'This is useful for checkout pages where billing address might differ '
        'from shipping address — each gets its own scope.',
      ),
      afCard(
        'Checkout Page — Nested Scopes',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: paleHoney.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: amber.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Outer: Page-Level (no direct fields)',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: deepAmber)),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 14),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: amber.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: amber.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Scope: Shipping',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: amber)),
                    afFieldBox('Street', 'street', Icons.home, amber),
                    afFieldBox('City', 'city', Icons.location_city, amber),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 14),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: goldenrod.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: goldenrod.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Scope: Billing',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: goldenrod)),
                    afFieldBox('Card#', 'creditCardNumber', Icons.credit_card, goldenrod),
                    afFieldBox('Exp', 'creditCardExpDate', Icons.date_range, goldenrod),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Commit vs cancel ━━━━━━
  print('[af-13] Section 13: Commit vs cancel');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('13', 'Commit vs Cancel Lifecycle'),
      afNote(
        'When the scope disposes, it tells the platform whether to save '
        '(commit) or discard (cancel) the autofill context. This is controlled '
        'by AutofillGroup.onDisposeAction.',
      ),
      afCard(
        'Commit vs Cancel',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF4CAF50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: const Color(0xFF4CAF50)),
                        const SizedBox(height: 4),
                        Text('Commit',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2E7D32))),
                        Text('Save to autofill',
                            style: TextStyle(fontSize: 9, color: const Color(0xFF388E3C))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE53935)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel, color: const Color(0xFFE53935)),
                        const SizedBox(height: 4),
                        Text('Cancel',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFC62828))),
                        Text('Discard changes',
                            style: TextStyle(fontSize: 9, color: const Color(0xFFD32F2F))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            afRow(['Action', 'When', 'Platform Effect'], isHeader: true),
            afRow(['commit', 'Login success', 'OS offers "Save password?"']),
            afRow(['cancel', 'User navigates away', 'Nothing saved']),
            afRow(['commit', 'Registration done', 'Store new credentials']),
            afRow(['cancel', 'Form reset', 'Clear autofill buffer']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: TextInput relationship ━━━━━━
  print('[af-14] Section 14: TextInput relationship');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('14', 'Scope ↔ TextInput Integration'),
      afNote(
        'AutofillScope.attach() creates a TextInputConnection that includes '
        'autofill context. This connection tells the platform about all fields '
        'in the scope when any single field gains focus.',
      ),
      afCard(
        'Attach Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            afLayerBox('scope.attach(client, config)', amber.withValues(alpha: 0.15), 36),
            afLayerBox('TextInput.setClient + autofillConfig', honey.withValues(alpha: 0.12), 36),
            afLayerBox('Platform receives all client configs', goldenrod.withValues(alpha: 0.1), 36),
            afLayerBox('OS builds autofill view with all fields', deepAmber.withValues(alpha: 0.08), 36),
            const SizedBox(height: 10),
            afRow(['Message', 'Payload', 'Direction'], isHeader: true),
            afRow(['setClient', 'autofillConfig with all hints', 'Dart → Platform']),
            afRow(['updateEditingState', 'Filled text value', 'Platform → Dart']),
            afRow(['finishAutofillContext', 'shouldSave flag', 'Dart → Platform']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing & debugging ━━━━━━
  print('[af-15] Section 15: Testing & debugging');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('15', 'Testing & Debugging Scopes'),
      afNote(
        'Autofill is platform-dependent and hard to test in widget tests. '
        'Key strategies: mock the TextInput channel, verify scope creation, '
        'and test client registration. On devices, test with real credentials.',
      ),
      afCard(
        'Testing Strategies',
        Column(
          children: [
            afRow(['Strategy', 'Layer', 'What It Verifies'], isHeader: true),
            afRow(['find.byType(AutofillGroup)', 'Widget', 'Scope widget present']),
            afRow(['AutofillGroup.of(context)', 'Widget', 'Scope accessible']),
            afRow(['Mock TextInput channel', 'Platform', 'Messages sent correctly']),
            afRow(['Integration test on device', 'E2E', 'Real autofill popup']),
            afRow(['Check autofillHints list', 'Config', 'Correct hints assigned']),
          ],
        ),
      ),
      afCard(
        'Debugging Checklist',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _afCheckItem('Fields inside AutofillGroup?', true, amber),
            _afCheckItem('autofillHints non-empty?', true, honey),
            _afCheckItem('onDisposeAction correct?', true, goldenrod),
            _afCheckItem('Not nested accidentally?', true, butterscotch),
            _afCheckItem('Web: autocomplete attribute set?', true, caramel),
            _afCheckItem('Device: credentials saved in OS?', true, deepAmber),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[af-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      afBanner('16', 'Summary Dashboard'),
      afCard(
        'AutofillScope — Complete Overview',
        Column(
          children: [
            afRow(['Topic', 'Section', 'Insight'], isHeader: true),
            afRow(['What', 'S01', 'Groups autofill clients as one unit']),
            afRow(['API', 'S02', 'autofillClients, getAutofillClient, attach']),
            afRow(['Implementation', 'S03', 'AutofillGroup + AutofillGroupState']),
            afRow(['Registration', 'S04', 'Fields register on build inside scope']),
            afRow(['Platforms', 'S05', 'Android/iOS/Web/Desktop mapping']),
            afRow(['Isolation', 'S06', 'Scopes are independent']),
            afRow(['Login', 'S07', 'Two-field credential scope']),
            afRow(['Multi-scope', 'S08', 'Tabs with separate scopes']),
            afRow(['Credentials', 'S09', 'One-tap login flow']),
            afRow(['Address', 'S10', '6-field address scope']),
            afRow(['Payment', 'S11', 'Security-sensitive card scope']),
            afRow(['Nesting', 'S12', 'Checkout with sub-scopes']),
            afRow(['Dispose', 'S13', 'Commit saves, cancel discards']),
            afRow(['TextInput', 'S14', 'Scope attaches via channel']),
            afRow(['Testing', 'S15', 'Mock channel + device tests']),
          ],
        ),
      ),
      afCard(
        'Amber / Honey Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _afColorSwatch('Amber', amber),
            _afColorSwatch('Honey', honey),
            _afColorSwatch('Golden', goldenrod),
            _afColorSwatch('Butter', butterscotch),
            _afColorSwatch('Deep', deepAmber),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [deepAmber, caramel],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('AutofillScope — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From abstract interface through registration lifecycle, scope '
              'isolation, credential/address/payment forms, commit vs cancel, '
              'and platform integration — the full autofill scoping surface.',
              style: TextStyle(color: cream, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[af] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutofillScope — Grouping Autofill Fields'),
        backgroundColor: deepAmber,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFFBF0),
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

Widget _afStepItem(int num, String phase, String desc, Color color) {
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
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF7A5200))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _afPlatformBox(String name, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(name,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color)),
          ],
        ),
        const SizedBox(height: 4),
        Text(desc,
            style: TextStyle(fontSize: 10, color: const Color(0xFF7A5200))),
      ],
    ),
  );
}

Widget _afScopeTab(String label, IconData icon, Color color, bool active) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        border: active
            ? Border(bottom: BorderSide(color: color, width: 2))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  color: color)),
        ],
      ),
    ),
  );
}

Widget _afCheckItem(String text, bool ok, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(
          ok ? Icons.check_circle : Icons.error,
          size: 16,
          color: ok ? color : Colors.red,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 12, color: const Color(0xFF7A5200))),
        ),
      ],
    ),
  );
}

Widget _afColorSwatch(String name, Color color) {
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
