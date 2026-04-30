// ignore_for_file: avoid_print
// D4rt deep demo: AutofillClient & the Autofill Framework
// Demonstrates how Flutter integrates with platform autofill — client interface,
// scoping, hints, lifecycle, and the full save/restore pipeline.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Mint / Jade palette ───
  const Color mint = Color(0xFF26A69A);
  const Color jade = Color(0xFF00897B);
  const Color seafoam = Color(0xFF80CBC4);
  const Color paleMint = Color(0xFFE0F2F1);
  const Color darkTeal = Color(0xFF004D40);
  const Color deepJade = Color(0xFF00695C);
  const Color lightMint = Color(0xFFB2DFDB);
  const Color softSage = Color(0xFFF1F8F6);
  const Color emeraldDark = Color(0xFF1B5E20);
  const Color malachite = Color(0xFF4DB6AC);

  print('[ac] ===== AUTOFILL CLIENT DEEP DEMO =====');

  // ─── Helpers declared before use ───

  Widget acBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkTeal, jade],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: darkTeal.withValues(alpha: 0.35),
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
              color: emeraldDark,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: seafoam, width: 1.5),
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

  Widget acNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: softSage,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lightMint.withValues(alpha: 0.7)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: darkTeal.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget acCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: paleMint.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: jade, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: darkTeal,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: deepJade)),
          ),
        ],
      ),
    );
  }

  Widget acCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lightMint.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: darkTeal.withValues(alpha: 0.06),
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
              color: jade.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: darkTeal)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget acRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? jade.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: lightMint.withValues(alpha: 0.4)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? darkTeal : deepJade)),
          );
        }).toList(),
      ),
    );
  }

  Widget acFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? darkTeal : jade,
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
          child: Icon(Icons.east, size: 12, color: mint),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  Widget acLayerBox(String label, Color color, double height) {
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
                    ? darkTeal
                    : Colors.white)),
      ),
    );
  }

  // ━━━━━━ SECTION 1: What is autofill? ━━━━━━
  print('[ac-01] Section 1: What is autofill?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('01', 'What Is Autofill?'),
      acNote(
        'Autofill is a platform feature that automatically fills form fields '
        'with saved data — names, addresses, passwords, credit cards, phone '
        'numbers. On Android, the Autofill Framework provides this service. '
        'On iOS, AutoFill and Password AutoFill handle it. Flutter\'s '
        'AutofillClient interface bridges between the Flutter text input '
        'system and these platform autofill services.',
      ),
      acCard(
        'The Autofill Concept',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            acFlow([
              'User taps field',
              'Platform detects',
              'Autofill popup',
              'User selects',
              'Fields filled',
            ]),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: jade.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: jade),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, color: jade, size: 24),
                        const SizedBox(height: 4),
                        Text('Identity',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: jade)),
                        Text('Name, email, phone',
                            style: TextStyle(fontSize: 9, color: deepJade)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: darkTeal.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: darkTeal),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock, color: darkTeal, size: 24),
                        const SizedBox(height: 4),
                        Text('Credentials',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: darkTeal)),
                        Text('Username, password',
                            style: TextStyle(fontSize: 9, color: deepJade)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: mint.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: mint),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.credit_card, color: mint, size: 24),
                        const SizedBox(height: 4),
                        Text('Payment',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: mint)),
                        Text('Card number, CVV',
                            style: TextStyle(fontSize: 9, color: deepJade)),
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

  // ━━━━━━ SECTION 2: AutofillClient interface ━━━━━━
  print('[ac-02] Section 2: AutofillClient interface');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('02', 'AutofillClient Interface'),
      acNote(
        'AutofillClient is an abstract interface that text input widgets implement '
        'to participate in autofill. It defines how a widget provides its current '
        'value to the autofill framework and how it receives autofilled values. '
        'EditableTextState is the primary implementor.',
      ),
      acCard(
        'Interface Contract',
        Column(
          children: [
            acRow(['Member', 'Type', 'Purpose'], isHeader: true),
            acRow(['textInputConfiguration', 'getter', 'Returns autofill config']),
            acRow(['autofillId', 'String', 'Unique ID for this client']),
            acRow(['currentTextEditingValue', 'getter', 'Current text value']),
            acRow(['autofill()', 'method', 'Receive autofilled value']),
          ],
        ),
      ),
      acCard(
        'Who Implements AutofillClient?',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _acImplementor('EditableTextState', 'Primary text input implementation',
                Icons.edit, jade),
            const SizedBox(height: 6),
            _acImplementor('Custom TextInputClient', 'For custom text fields',
                Icons.code, darkTeal),
            const SizedBox(height: 6),
            _acImplementor('Third-party packages', 'Any package wrapping text input',
                Icons.extension, mint),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: AutofillGroup ━━━━━━
  print('[ac-03] Section 3: AutofillGroup');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('03', 'AutofillGroup — Scoping Autofill'),
      acNote(
        'AutofillGroup is a widget that groups multiple autofill clients into '
        'a single autofill scope. When the platform\'s autofill service fills '
        'one field, it can fill all related fields in the same group — e.g., '
        'username and password together, or all address fields at once.',
      ),
      acCard(
        'AutofillGroup Structure',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visual form group
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: paleMint,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: jade, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AutofillGroup',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: darkTeal)),
                  const SizedBox(height: 8),
                  _acFormField('Username', Icons.person, jade),
                  const SizedBox(height: 6),
                  _acFormField('Password', Icons.lock, darkTeal),
                  const SizedBox(height: 6),
                  _acFormField('Confirm Password', Icons.lock_outline, mint),
                ],
              ),
            ),
            const SizedBox(height: 10),
            acCode('onDisposeAction', 'What to do when group disposes (commit/cancel)'),
          ],
        ),
      ),
      acCard(
        'AutofillGroupState API',
        Column(
          children: [
            acRow(['Method', 'Purpose'], isHeader: true),
            acRow(['register(client)', 'Add a client to the group']),
            acRow(['unregister(autofillId)', 'Remove a client from the group']),
            acRow(['getAutofillClients()', 'Get all clients in the group']),
            acRow(['attach(client)', 'Attach a specific client to the platform']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Autofill lifecycle ━━━━━━
  print('[ac-04] Section 4: Autofill lifecycle');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('04', 'Autofill Lifecycle'),
      acNote(
        'The autofill lifecycle spans from field creation to form submission. '
        'Fields register with the platform, the user triggers autofill, the '
        'platform fills matching fields, and finally the data is committed '
        'for future use when the form is submitted.',
      ),
      acCard(
        'Lifecycle Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _acLifecycleStep(1, 'Register', 'Fields announce themselves to the platform',
                jade),
            _acLifecycleStep(2, 'Activate', 'User focuses a field — platform shows popup',
                darkTeal),
            _acLifecycleStep(3, 'Fill', 'Platform fills matching fields in the group',
                mint),
            _acLifecycleStep(4, 'Edit', 'User may modify autofilled values',
                deepJade),
            _acLifecycleStep(5, 'Commit', 'Form submits — save new credentials',
                emeraldDark),
            _acLifecycleStep(6, 'Unregister', 'Fields are disposed and removed',
                malachite),
          ],
        ),
      ),
      acCard(
        'AutofillContextAction (onDisposeAction)',
        Column(
          children: [
            acRow(['Action', 'When', 'Effect'], isHeader: true),
            acRow(['commit', 'Form success', 'Save autofill data']),
            acRow(['cancel', 'Form cancelled', 'Discard changes']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: TextInputConfiguration ━━━━━━
  print('[ac-05] Section 5: TextInputConfiguration');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('05', 'TextInputConfiguration for Autofill'),
      acNote(
        'Each AutofillClient provides a TextInputConfiguration that describes '
        'the field to the platform. The autofillHints property is the most '
        'important — it tells the autofill service what kind of data the field '
        'expects (email, password, name, etc.).',
      ),
      acCard(
        'Autofill-Relevant Configuration',
        Column(
          children: [
            acCode('autofillHints', 'List<String> of semantic hints'),
            acCode('autofillId', 'Unique identifier for this field'),
            acCode('inputType', 'Keyboard type (email, number, etc.)'),
            acCode('obscureText', 'Whether field is a password'),
          ],
        ),
      ),
      acCard(
        'How Hints Map to Platform',
        Column(
          children: [
            acRow(['Flutter Hint', 'Android', 'iOS'], isHeader: true),
            acRow(['AutofillHints.email', 'AUTOFILL_EMAIL', 'emailAddress']),
            acRow(['AutofillHints.password', 'AUTOFILL_PASSWORD', 'password']),
            acRow(['AutofillHints.name', 'AUTOFILL_NAME', 'name']),
            acRow(['AutofillHints.phone', 'AUTOFILL_PHONE', 'telephoneNumber']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Platform integration ━━━━━━
  print('[ac-06] Section 6: Platform integration');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('06', 'Platform Autofill Integration'),
      acNote(
        'Flutter communicates with platform autofill services through the text '
        'input system channel. The engine translates autofill hints and field '
        'configurations into platform-specific autofill structures. Each OS '
        'has different capabilities and behaviors.',
      ),
      acCard(
        'Platform Autofill Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            acLayerBox('Flutter: AutofillClient + AutofillGroup', jade.withValues(alpha: 0.15), 38),
            acLayerBox('Engine: TextInput channel', mint.withValues(alpha: 0.15), 38),
            acLayerBox('Platform: AutofillManager / ASAuthorization', deepJade.withValues(alpha: 0.12), 38),
            acLayerBox('Service: Google / iCloud Keychain / 3rd party', darkTeal.withValues(alpha: 0.08), 38),
            const SizedBox(height: 10),
            acRow(['Platform', 'Service', 'Features'], isHeader: true),
            acRow(['Android 8+', 'Autofill Framework', 'Save, fill, datasets']),
            acRow(['Android 11+', 'Inline suggestions', 'Keyboard-inline']),
            acRow(['iOS 11+', 'Password AutoFill', 'Keychain + 3rd party']),
            acRow(['iOS 12+', 'Security codes', 'SMS OTP autofill']),
            acRow(['macOS', 'AutoFill', 'Keychain integration']),
            acRow(['Web', 'autocomplete', 'Browser autofill']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Autofill save flow ━━━━━━
  print('[ac-07] Section 7: Save flow');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('07', 'Autofill Save Flow'),
      acNote(
        'After a user fills and submits a form, the autofill framework can '
        'save new or updated data. This happens when AutofillGroup.onDisposeAction '
        'is set to commit. The platform may show a "Save password?" prompt.',
      ),
      acCard(
        'Save Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            acFlow([
              'User submits',
              'commit() called',
              'Platform checks',
              'Save prompt',
              'Stored',
            ]),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 90,
                    decoration: BoxDecoration(
                      color: jade.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: jade),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, color: jade, size: 22),
                        const SizedBox(height: 4),
                        Text('New Data',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: jade)),
                        Text('"Save password?"',
                            style: TextStyle(fontSize: 9, color: deepJade)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 90,
                    decoration: BoxDecoration(
                      color: darkTeal.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: darkTeal),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.update, color: darkTeal, size: 22),
                        const SizedBox(height: 4),
                        Text('Updated Data',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: darkTeal)),
                        Text('"Update password?"',
                            style: TextStyle(fontSize: 9, color: deepJade)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 90,
                    decoration: BoxDecoration(
                      color: mint.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: mint),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel, color: mint, size: 22),
                        const SizedBox(height: 4),
                        Text('Cancelled',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: mint)),
                        Text('No save prompt',
                            style: TextStyle(fontSize: 9, color: deepJade)),
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

  // ━━━━━━ SECTION 8: TextField autofill ━━━━━━
  print('[ac-08] Section 8: TextField autofill');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('08', 'TextField Autofill Integration'),
      acNote(
        'TextField is the most common widget to use autofill. Set the '
        'autofillHints property on TextField\'s decoration or directly on '
        'TextField to enable autofill. Wrap related fields in an AutofillGroup.',
      ),
      acCard(
        'TextField → Autofill Configuration',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: paleMint.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'AutofillGroup(\n'
                '  child: Column(\n'
                '    children: [\n'
                '      TextField(\n'
                '        autofillHints: [AutofillHints.email],\n'
                '      ),\n'
                '      TextField(\n'
                '        autofillHints: [AutofillHints.password],\n'
                '        obscureText: true,\n'
                '      ),\n'
                '    ],\n'
                '  ),\n'
                ')',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: darkTeal,
                    height: 1.4),
              ),
            ),
          ],
        ),
      ),
      acCard(
        'Key Properties on TextField',
        Column(
          children: [
            acCode('autofillHints', 'List of AutofillHints constants'),
            acCode('keyboardType', 'Helps platform show correct keyboard'),
            acCode('obscureText', 'True for password fields'),
            acCode('enableSuggestions', 'Control autocorrect/suggestions'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Multi-field forms ━━━━━━
  print('[ac-09] Section 9: Multi-field forms');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('09', 'Multi-Field Form Autofill'),
      acNote(
        'Real-world forms have multiple fields that should autofill together. '
        'Address forms, registration forms, and payment forms all benefit from '
        'grouping. The AutofillGroup ensures the platform fills all related '
        'fields from the same autofill entry.',
      ),
      acCard(
        'Address Form Pattern',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: paleMint,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: jade, style: BorderStyle.solid),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AutofillGroup: Address',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: darkTeal)),
                  const Divider(),
                  _acFormField('Street Address', Icons.home, jade),
                  const SizedBox(height: 4),
                  _acFormField('City', Icons.location_city, darkTeal),
                  const SizedBox(height: 4),
                  _acFormField('State/Province', Icons.map, mint),
                  const SizedBox(height: 4),
                  _acFormField('ZIP/Postal Code', Icons.pin_drop, deepJade),
                  const SizedBox(height: 4),
                  _acFormField('Country', Icons.flag, emeraldDark),
                ],
              ),
            ),
          ],
        ),
      ),
      acCard(
        'Multiple AutofillGroups',
        Column(
          children: [
            acRow(['Group', 'Fields', 'Use Case'], isHeader: true),
            acRow(['Login', 'email + password', 'Sign in form']),
            acRow(['Registration', 'name + email + password', 'Sign up form']),
            acRow(['Address', 'street + city + state + zip', 'Shipping form']),
            acRow(['Payment', 'card + expiry + CVV', 'Checkout form']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Security considerations ━━━━━━
  print('[ac-10] Section 10: Security');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('10', 'Security Considerations'),
      acNote(
        'Autofill touches sensitive data — passwords, credit cards, personal '
        'information. Proper implementation protects user data. Mark password '
        'fields correctly, use HTTPS, and handle secure storage responsibly.',
      ),
      acCard(
        'Security Checklist',
        Column(
          children: [
            _acSecurityItem(Icons.check_circle, 'Mark passwords with AutofillHints.password',
                jade, true),
            _acSecurityItem(Icons.check_circle, 'Use obscureText: true for sensitive fields',
                jade, true),
            _acSecurityItem(Icons.check_circle, 'Commit credentials only on successful auth',
                jade, true),
            _acSecurityItem(Icons.check_circle, 'Use HTTPS for all auth endpoints',
                jade, true),
            _acSecurityItem(Icons.warning, 'Don\'t log autofilled values',
                darkTeal, false),
            _acSecurityItem(Icons.warning, 'Don\'t expose saved passwords in debug',
                darkTeal, false),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: OTP autofill ━━━━━━
  print('[ac-11] Section 11: OTP autofill');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('11', 'OTP / Security Code Autofill'),
      acNote(
        'iOS 12+ and Android 11+ can automatically detect SMS verification '
        'codes and suggest them in the keyboard. Flutter supports this via '
        'AutofillHints.oneTimeCode. The platform parses incoming SMS for '
        'code patterns.',
      ),
      acCard(
        'OTP Autofill Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            acFlow([
              'SMS received',
              'Platform parses',
              'Code extracted',
              'Keyboard suggests',
              'Field filled',
            ]),
            const SizedBox(height: 12),
            acRow(['Platform', 'Feature', 'Requirement'], isHeader: true),
            acRow(['iOS 12+', 'SMS AutoFill', 'Associated domains']),
            acRow(['Android 11+', 'SMS User Consent', 'SMS format standards']),
            acRow(['Android', 'SMS Retriever API', 'App hash in SMS']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Web autofill ━━━━━━
  print('[ac-12] Section 12: Web autofill');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('12', 'Web Autofill (Flutter Web)'),
      acNote(
        'On Flutter Web, autofill maps to the HTML autocomplete attribute. '
        'Flutter creates hidden input elements that the browser\'s autofill '
        'can detect. This allows Chrome, Safari, and Firefox password managers '
        'to fill Flutter web forms.',
      ),
      acCard(
        'Web Autofill Mapping',
        Column(
          children: [
            acRow(['Flutter Hint', 'HTML autocomplete'], isHeader: true),
            acRow(['AutofillHints.email', 'email']),
            acRow(['AutofillHints.password', 'current-password']),
            acRow(['AutofillHints.newPassword', 'new-password']),
            acRow(['AutofillHints.username', 'username']),
            acRow(['AutofillHints.name', 'name']),
            acRow(['AutofillHints.telephoneNumber', 'tel']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Testing autofill ━━━━━━
  print('[ac-13] Section 13: Testing');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('13', 'Testing Autofill'),
      acNote(
        'Testing autofill requires platform interaction. Unit tests can verify '
        'configuration (hints, grouping), but end-to-end testing on real devices '
        'is needed to confirm the platform service responds correctly.',
      ),
      acCard(
        'Testing Strategies',
        Column(
          children: [
            acRow(['Level', 'Test', 'Tools'], isHeader: true),
            acRow(['Unit', 'Hints are set correctly', 'widget test']),
            acRow(['Unit', 'AutofillGroup exists', 'widget test (find)']),
            acRow(['Integration', 'Platform fills fields', 'integration_test']),
            acRow(['Manual', 'Real password manager', 'Device testing']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Accessibility ━━━━━━
  print('[ac-14] Section 14: Accessibility');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('14', 'Autofill & Accessibility'),
      acNote(
        'Autofill improves accessibility by reducing typing for users with '
        'motor impairments. Proper autofill hints also provide semantic '
        'information to screen readers and assistive technologies.',
      ),
      acCard(
        'Accessibility Benefits',
        Column(
          children: [
            _acA11yBenefit(Icons.accessibility, 'Reduced motor effort',
                'Fewer keystrokes for form completion', jade),
            const SizedBox(height: 6),
            _acA11yBenefit(Icons.text_fields, 'Semantic labeling',
                'Hints provide context for screen readers', darkTeal),
            const SizedBox(height: 6),
            _acA11yBenefit(Icons.speed, 'Faster task completion',
                'Important for users with cognitive load', mint),
            const SizedBox(height: 6),
            _acA11yBenefit(Icons.touch_app, 'Reduced error rate',
                'Pre-filled data avoids typos', deepJade),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Common pitfalls ━━━━━━
  print('[ac-15] Section 15: Common pitfalls');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('15', 'Common Pitfalls'),
      acNote(
        'Autofill failures often stem from misconfigured hints, missing groups, '
        'or platform-specific quirks. Understanding common issues saves debugging '
        'time.',
      ),
      acCard(
        'Pitfalls & Solutions',
        Column(
          children: [
            _acPitfall('Missing AutofillGroup', 'Fields fill individually, not together',
                'Wrap related fields in AutofillGroup'),
            _acPitfall('Wrong hints', 'Platform shows wrong suggestions',
                'Use exact AutofillHints constants'),
            _acPitfall('No onDisposeAction', 'Credentials not saved',
                'Set AutofillContextAction.commit'),
            _acPitfall('Hot restart clears', 'Autofill state lost on restart',
                'Expected; test on release builds'),
            _acPitfall('Web iframe issues', 'Browser blocks cross-origin autofill',
                'Ensure same-origin or use allowAutofill'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[ac-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      acBanner('16', 'Summary Dashboard'),
      acCard(
        'AutofillClient System — Complete',
        Column(
          children: [
            acRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            acRow(['Concept', 'S01', 'Platform fills saved data']),
            acRow(['Interface', 'S02', 'AutofillClient contract']),
            acRow(['Scoping', 'S03', 'AutofillGroup widget']),
            acRow(['Lifecycle', 'S04', 'Register → Fill → Commit']),
            acRow(['Configuration', 'S05', 'Hints + TextInputConfig']),
            acRow(['Platform', 'S06', 'Android/iOS/Web integration']),
            acRow(['Save flow', 'S07', 'Commit vs cancel']),
            acRow(['TextField', 'S08', 'autofillHints property']),
            acRow(['Multi-field', 'S09', 'Address & payment forms']),
            acRow(['Security', 'S10', 'Passwords, HTTPS, logging']),
            acRow(['OTP', 'S11', 'SMS code autofill']),
            acRow(['Web', 'S12', 'HTML autocomplete mapping']),
            acRow(['Testing', 'S13', 'Unit + integration + manual']),
            acRow(['Accessibility', 'S14', 'Motor, cognitive benefits']),
            acRow(['Pitfalls', 'S15', 'Groups, hints, dispose action']),
          ],
        ),
      ),
      acCard(
        'Mint / Jade Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _acColorSwatch('Mint', mint),
            _acColorSwatch('Jade', jade),
            _acColorSwatch('Seafoam', seafoam),
            _acColorSwatch('DarkTeal', darkTeal),
            _acColorSwatch('Malachite', malachite),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [darkTeal, jade],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('AutofillClient — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From interface contract through grouping, platform integration, '
              'OTP autofill, web mapping, and security — the full Flutter '
              'autofill pipeline.',
              style: TextStyle(color: paleMint, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[ac] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutofillClient & Autofill Framework'),
        backgroundColor: darkTeal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF0FAF8),
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

Widget _acFormField(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(label,
            style: TextStyle(fontSize: 12, color: color)),
        const Spacer(),
        Icon(Icons.auto_awesome, size: 14, color: color.withValues(alpha: 0.4)),
      ],
    ),
  );
}

Widget _acImplementor(String name, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              Text(desc,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF004D40))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _acLifecycleStep(int num, String phase, String desc, Color color) {
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
                  style: const TextStyle(fontSize: 11, color: Color(0xFF004D40))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _acSecurityItem(IconData icon, String text, Color color, bool isGood) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFF004D40),
                  fontWeight: isGood ? FontWeight.normal : FontWeight.w600)),
        ),
      ],
    ),
  );
}

Widget _acA11yBenefit(IconData icon, String title, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              Text(desc,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF004D40))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _acPitfall(String issue, String symptom, String fix) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.report_problem, size: 16, color: const Color(0xFF00897B)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(issue,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              Text(symptom,
                  style: TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF00695C))),
              Text('Fix: $fix',
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF004D40))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _acColorSwatch(String name, Color color) {
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
