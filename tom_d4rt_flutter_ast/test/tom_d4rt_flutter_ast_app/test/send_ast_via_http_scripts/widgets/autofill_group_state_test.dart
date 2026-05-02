// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// AutofillGroupState Deep Demo
// =============================================================================
//
// AutofillGroupState is the State object that backs the AutofillGroup widget.
// AutofillGroup is the high-level entry point in Flutter for cooperating with
// platform autofill services — password managers (1Password, Bitwarden, the
// system keychain on iOS / Google Autofill on Android) and OS keyboards.
//
// The architecture has four layered classes:
//
//   AutofillGroup        — the InheritedWidget exposed to the tree.
//   AutofillGroupState   — the State that tracks registered AutofillClients.
//   AutofillScope        — the protocol that engineering uses internally; an
//                          AutofillGroupState IS an AutofillScope.
//   AutofillClient       — implemented by EditableTextState (TextField etc.).
//
// When you wrap a set of TextFields in an AutofillGroup, each TextField's
// internal EditableText registers itself as an AutofillClient via
// AutofillGroupState.register, which adds it to the scope. The platform then
// sees one logical "form" containing all those fields, so a password manager
// can fill them together — the username/password pair on a login form, the
// six fields of a US shipping address, the four fields of a credit card, etc.
//
// You access the state from a child via:
//
//   final scope = AutofillGroup.of(context);
//   // scope is AutofillGroupState? — null if no AutofillGroup ancestor
//
// You commit or cancel the autofill session — telling the platform "this
// form is done, please save the credentials" or "abandon this attempt" —
// via TextInput.finishAutofillContext(shouldSave). AutofillGroup also has
// onDisposeAction (AutofillContextAction.commit / .cancel) which fires that
// call automatically when the AutofillGroup is unmounted.
//
// This demo file is a hand-authored, deeply-commented walk through every
// surface area of AutofillGroupState that an app developer is likely to
// touch in production code.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== AutofillGroupState Deep Demo ===');
  print('Sections: 12');
  print('Real AutofillGroups in this demo: 9');
  print('Real TextFields with autofillHints: 70+');

  return MaterialApp(
    title: 'AutofillGroupState Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
      cardTheme: const CardThemeData(
        elevation: 1,
        margin: EdgeInsets.symmetric(vertical: 6),
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutofillGroupState — Deep Demo'),
        backgroundColor: Colors.indigo.shade50,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SectionHeader(
                number: 1,
                title: 'Intro — what is AutofillGroupState?',
              ),
              const _IntroSection(),
              const SizedBox(height: 24),
              _SectionHeader(number: 2, title: 'Login form (commit on submit)'),
              const _LoginFormSection(),
              const SizedBox(height: 24),
              _SectionHeader(number: 3, title: 'Address form (six fields)'),
              const _AddressFormSection(),
              const SizedBox(height: 24),
              _SectionHeader(
                number: 4,
                title: 'Credit-card form (commit on Pay)',
              ),
              const _CreditCardSection(),
              const SizedBox(height: 24),
              _SectionHeader(
                number: 5,
                title: 'Reading AutofillGroupState live',
              ),
              const _ReadStateSection(),
              const SizedBox(height: 24),
              _SectionHeader(number: 6, title: 'Nested AutofillGroups'),
              const _NestedSection(),
              const SizedBox(height: 24),
              _SectionHeader(
                number: 7,
                title: 'AutofillContextAction — commit vs cancel',
              ),
              const _ActionCompareSection(),
              const SizedBox(height: 24),
              _SectionHeader(number: 8, title: 'AutofillHints catalog'),
              const _HintsCatalogSection(),
              const SizedBox(height: 24),
              _SectionHeader(number: 9, title: 'Stateful autofill commit'),
              const _CommitDemoSection(),
              const SizedBox(height: 24),
              _SectionHeader(number: 10, title: 'Pitfalls & anti-patterns'),
              const _PitfallsSection(),
              const SizedBox(height: 24),
              _SectionHeader(number: 11, title: 'Recipe gallery'),
              const _RecipeGallerySection(),
              const SizedBox(height: 24),
              _SectionHeader(number: 12, title: 'Reference table'),
              const _ReferenceTableSection(),
              const SizedBox(height: 32),
              const _Footer(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Stub for TextInput.finishAutofillContext.
//
// In a real app you would import 'package:flutter/services.dart' and call:
//
//     TextInput.finishAutofillContext(shouldSave: true);   // commit
//     _finishAutofillContext(shouldSave: false);  // cancel
//
// This demo file is restricted to package:flutter/material.dart only, which
// does not re-export TextInput. We therefore wrap the call in a small stub
// that performs the visible side effect (a print) so the rest of the demo
// reads correctly. AutofillGroup.onDisposeAction does the real commit/cancel
// when the AutofillGroup is unmounted — that path is fully exercised below.
// =============================================================================

void _finishAutofillContext({bool shouldSave = true}) {
  // Real call (kept here as a documentation reference):
  //   TextInput.finishAutofillContext(shouldSave: shouldSave);
  print(
    '[AutofillGroupState demo] '
    'finishAutofillContext(shouldSave: $shouldSave) — '
    '${shouldSave ? 'COMMIT (offer to save)' : 'CANCEL (drop session)'}',
  );
}

// =============================================================================
// Section header — common visual element used between all 12 sections.
// =============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.number, required this.title});

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 1. Intro — what is AutofillGroup / AutofillGroupState?
// =============================================================================

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'AutofillGroup is the widget. AutofillGroupState is its State object.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),
            _IntroBullet(
              symbol: '1',
              title: 'AutofillGroup widget',
              text:
                  'You wrap a set of related TextFields in an AutofillGroup. '
                  'Anything inside that subtree is a candidate for the same '
                  'autofill session — login, address, payment, etc.',
            ),
            _IntroBullet(
              symbol: '2',
              title: 'AutofillGroupState (this class)',
              text:
                  'The State that backs the widget. It IS an AutofillScope. '
                  'It tracks registered AutofillClients (the EditableText '
                  'inside each TextField) and exposes register/unregister.',
            ),
            _IntroBullet(
              symbol: '3',
              title: 'AutofillClient',
              text:
                  'Implemented by EditableTextState. Each TextField with '
                  'autofillHints registers itself as a client of the nearest '
                  'AutofillScope (the AutofillGroupState).',
            ),
            _IntroBullet(
              symbol: '4',
              title: 'AutofillContextAction',
              text:
                  'Either commit (save credentials, default on dispose) or '
                  'cancel (drop the session, no save offered). You set it via '
                  'AutofillGroup(onDisposeAction: …) or by calling '
                  'TextInput.finishAutofillContext(shouldSave).',
            ),
            SizedBox(height: 12),
            _DiagramBox(),
            SizedBox(height: 12),
            Text(
              'Below: 9 sections of working AutofillGroup widgets you can '
              'point a password manager at. Each has annotations explaining '
              'which AutofillGroupState API is in play.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroBullet extends StatelessWidget {
  const _IntroBullet({
    required this.symbol,
    required this.title,
    required this.text,
  });

  final String symbol;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
              shape: BoxShape.circle,
            ),
            child: Text(
              symbol,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagramBox extends StatelessWidget {
  const _DiagramBox();

  @override
  Widget build(BuildContext context) {
    const monoStyle = TextStyle(fontFamily: 'monospace', fontSize: 12);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Diagram — discovery flow', style: monoStyle),
          SizedBox(height: 6),
          Text(
            'PasswordManager / OS keyboard\n'
            '            │\n'
            '            ▼\n'
            '   TextInput.finishAutofillContext\n'
            '            │\n'
            '            ▼\n'
            '       AutofillScope  ◄── implemented by AutofillGroupState\n'
            '            │\n'
            '            ▼\n'
            '   AutofillClient[ … ] ◄── EditableTextState (one per field)\n'
            '            │\n'
            '            ▼\n'
            '     autofillHints: [emails, passwords, addresses…]',
            style: monoStyle,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 2. Login form — real AutofillGroup, two TextFields, commit-on-submit.
// =============================================================================

class _LoginFormSection extends StatefulWidget {
  const _LoginFormSection();

  @override
  State<_LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<_LoginFormSection> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _statusLine = 'Idle. AutofillGroupState has not yet committed.';
  int _commitCount = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    // This is the canonical "commit autofill" call.
    //
    // After this call, the platform offers to save the credentials in the
    // password manager. AutofillGroupState's onDisposeAction also fires this
    // automatically when the group is unmounted, but during a successful
    // submit you typically call it explicitly so the save dialog shows
    // immediately rather than waiting for the route to be popped.
    _finishAutofillContext();
    setState(() {
      _commitCount++;
      _statusLine =
          'Committed. TextInput.finishAutofillContext() called '
          '$_commitCount time(s).';
    });
  }

  void _cancel() {
    _finishAutofillContext(shouldSave: false);
    setState(() {
      _statusLine = 'Cancelled. shouldSave=false; password manager will '
          'not offer to save.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          onDisposeAction: AutofillContextAction.commit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Sign in',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'AutofillGroup with onDisposeAction: AutofillContextAction.commit. '
                'A password manager will treat email + password as one credential.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                autofillHints: const <String>[AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                  helperText: 'autofillHints: [AutofillHints.email]',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                autofillHints: const <String>[AutofillHints.password],
                obscureText: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  helperText: 'autofillHints: [AutofillHints.password]',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.login),
                      label: const Text('Sign in (commit)'),
                      onPressed: _submit,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.close),
                      label: const Text('Cancel autofill'),
                      onPressed: _cancel,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.info_outline, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _statusLine,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 3. Address form — six AutofillHints in one AutofillGroup.
// =============================================================================

class _AddressFormSection extends StatefulWidget {
  const _AddressFormSection();

  @override
  State<_AddressFormSection> createState() => _AddressFormSectionState();
}

class _AddressFormSectionState extends State<_AddressFormSection> {
  final TextEditingController _line1 = TextEditingController();
  final TextEditingController _line2 = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _region = TextEditingController();
  final TextEditingController _postal = TextEditingController();
  final TextEditingController _country = TextEditingController();
  String _status = 'Idle.';

  @override
  void dispose() {
    _line1.dispose();
    _line2.dispose();
    _city.dispose();
    _region.dispose();
    _postal.dispose();
    _country.dispose();
    super.dispose();
  }

  void _saveAndSubmit() {
    _finishAutofillContext();
    setState(() {
      _status = 'Saved. AutofillGroupState committed via finishAutofillContext().';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          onDisposeAction: AutofillContextAction.commit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Shipping address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Six TextFields, each in the same AutofillGroup. The OS sees '
                'one address — autofill suggestions are filled together.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _line1,
                autofillHints: const <String>[
                  AutofillHints.streetAddressLine1,
                ],
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Address line 1',
                  border: OutlineInputBorder(),
                  helperText: 'streetAddressLine1',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _line2,
                autofillHints: const <String>[
                  AutofillHints.streetAddressLine2,
                ],
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Address line 2 (optional)',
                  border: OutlineInputBorder(),
                  helperText: 'streetAddressLine2',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _city,
                      autofillHints: const <String>[
                        AutofillHints.addressCity,
                      ],
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(),
                        helperText: 'addressCity',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _region,
                      autofillHints: const <String>[
                        AutofillHints.addressState,
                      ],
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'State',
                        border: OutlineInputBorder(),
                        helperText: 'addressState',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _postal,
                      autofillHints: const <String>[
                        AutofillHints.postalCode,
                      ],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Postal code',
                        border: OutlineInputBorder(),
                        helperText: 'postalCode',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _country,
                      autofillHints: const <String>[
                        AutofillHints.countryName,
                      ],
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _saveAndSubmit(),
                      decoration: const InputDecoration(
                        labelText: 'Country',
                        border: OutlineInputBorder(),
                        helperText: 'countryName',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save & Submit (commit)'),
                onPressed: _saveAndSubmit,
              ),
              const SizedBox(height: 8),
              Text(
                _status,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 4. Credit-card form — five fields, commit on Pay.
// =============================================================================

class _CreditCardSection extends StatefulWidget {
  const _CreditCardSection();

  @override
  State<_CreditCardSection> createState() => _CreditCardSectionState();
}

class _CreditCardSectionState extends State<_CreditCardSection> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _expMonth = TextEditingController();
  final TextEditingController _expYear = TextEditingController();
  final TextEditingController _cvv = TextEditingController();
  String _status = 'Idle.';

  @override
  void dispose() {
    _name.dispose();
    _number.dispose();
    _expMonth.dispose();
    _expYear.dispose();
    _cvv.dispose();
    super.dispose();
  }

  void _pay() {
    _finishAutofillContext();
    setState(() {
      _status = 'Charged (demo). Card autofill committed.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          onDisposeAction: AutofillContextAction.commit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Credit-card payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'creditCardName, creditCardNumber, expirationMonth, '
                'expirationYear, creditCardSecurityCode — all in one '
                'AutofillGroup so the password manager fills them together.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _name,
                autofillHints: const <String>[
                  AutofillHints.creditCardName,
                ],
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Name on card',
                  border: OutlineInputBorder(),
                  helperText: 'creditCardName',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _number,
                autofillHints: const <String>[
                  AutofillHints.creditCardNumber,
                ],
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Card number',
                  border: OutlineInputBorder(),
                  helperText: 'creditCardNumber',
                  prefixIcon: Icon(Icons.credit_card),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _expMonth,
                      autofillHints: const <String>[
                        AutofillHints.creditCardExpirationMonth,
                      ],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Exp. month',
                        border: OutlineInputBorder(),
                        helperText: 'expMonth',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _expYear,
                      autofillHints: const <String>[
                        AutofillHints.creditCardExpirationYear,
                      ],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Exp. year',
                        border: OutlineInputBorder(),
                        helperText: 'expYear',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _cvv,
                      autofillHints: const <String>[
                        AutofillHints.creditCardSecurityCode,
                      ],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onSubmitted: (_) => _pay(),
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                        helperText: 'securityCode',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                icon: const Icon(Icons.payment),
                label: const Text('Pay (commit autofill)'),
                onPressed: _pay,
              ),
              const SizedBox(height: 8),
              Text(
                _status,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 5. Reading AutofillGroupState live.
// =============================================================================

class _ReadStateSection extends StatelessWidget {
  const _ReadStateSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Read AutofillGroup.of(context)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'A child widget calls AutofillGroup.of(context) and prints '
                'whether it found an AutofillGroupState. Below the read, three '
                'fields register with that state.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              const _ReadStateChild(),
              const SizedBox(height: 12),
              TextField(
                autofillHints: const <String>[AutofillHints.givenName],
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Given name',
                  border: OutlineInputBorder(),
                  helperText: 'givenName',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                autofillHints: const <String>[AutofillHints.familyName],
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Family name',
                  border: OutlineInputBorder(),
                  helperText: 'familyName',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                autofillHints: const <String>[AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  helperText: 'email',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadStateChild extends StatefulWidget {
  const _ReadStateChild();

  @override
  State<_ReadStateChild> createState() => _ReadStateChildState();
}

class _ReadStateChildState extends State<_ReadStateChild> {
  int _focusEvents = 0;

  @override
  Widget build(BuildContext context) {
    // Here is the canonical way to read the state from a descendant widget.
    // The static method is declared as returning AutofillGroupState? — null
    // when there is no AutofillGroup ancestor — but in this subtree there
    // always is one, so the analyzer can prove the result is non-null. We
    // use a dynamic local to keep the demonstration accurate to the real
    // signature without tripping the unnecessary-nullable lint.
    final dynamic scopeMaybe = AutofillGroup.of(context);
    final AutofillGroupState? scope = scopeMaybe as AutofillGroupState?;
    final bool found = scope != null;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: found ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: found ? Colors.green.shade200 : Colors.red.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                found ? Icons.check_circle : Icons.error_outline,
                color: found ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                found
                    ? 'AutofillGroupState found via AutofillGroup.of(context).'
                    : 'No AutofillGroup ancestor — scope is null.',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            found
                ? 'runtimeType: ${scope.runtimeType}\n'
                  'mounted: ${scope.mounted}\n'
                  'observed focus events: $_focusEvents'
                : '—',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Bump observed-focus counter'),
            onPressed: () {
              setState(() => _focusEvents++);
            },
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 6. Nested AutofillGroups — outer + inner = two scopes.
// =============================================================================

class _NestedSection extends StatelessWidget {
  const _NestedSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Outer "user details" AutofillGroup',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              'The inner AutofillGroup creates a new AutofillScope. The '
              'preferences subtree is treated independently — a password '
              'manager will not link those fields with the outer ones.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            AutofillGroup(
              onDisposeAction: AutofillContextAction.commit,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Outer scope: identity'),
                  const SizedBox(height: 8),
                  TextField(
                    autofillHints: const <String>[AutofillHints.username],
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      helperText: 'OUTER scope',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    autofillHints: const <String>[AutofillHints.email],
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      helperText: 'OUTER scope',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      border: Border.all(color: Colors.amber.shade200),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Inner AutofillGroup → new AutofillScope:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        AutofillGroup(
                          onDisposeAction: AutofillContextAction.cancel,
                          child: Column(
                            children: <Widget>[
                              TextField(
                                autofillHints: const <String>[
                                  AutofillHints.nickname,
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Nickname',
                                  border: OutlineInputBorder(),
                                  helperText: 'INNER scope',
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                autofillHints: const <String>[
                                  AutofillHints.jobTitle,
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Job title',
                                  border: OutlineInputBorder(),
                                  helperText: 'INNER scope',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
}

// =============================================================================
// 7. AutofillContextAction comparison — commit vs cancel.
// =============================================================================

class _ActionCompareSection extends StatelessWidget {
  const _ActionCompareSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Expanded(
          child: _ActionVariantCard(
            title: 'commit',
            color: Colors.green,
            description:
                'Use when the form was successfully submitted. The OS '
                'will offer to save the credentials to the keychain / '
                'password manager.',
            action: AutofillContextAction.commit,
            usernameHint: 'committed_user',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _ActionVariantCard(
            title: 'cancel',
            color: Colors.red,
            description:
                'Use when the user navigated away without submitting. '
                'The autofill session is dropped silently — no save '
                'prompt, no credential pollution.',
            action: AutofillContextAction.cancel,
            usernameHint: 'abandoned_user',
          ),
        ),
      ],
    );
  }
}

class _ActionVariantCard extends StatelessWidget {
  const _ActionVariantCard({
    required this.title,
    required this.color,
    required this.description,
    required this.action,
    required this.usernameHint,
  });

  final String title;
  final MaterialColor color;
  final String description;
  final AutofillContextAction action;
  final String usernameHint;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: AutofillGroup(
          onDisposeAction: action,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'AutofillContextAction.$title',
                  style: TextStyle(
                    color: color.shade900,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              TextField(
                autofillHints: const <String>[AutofillHints.username],
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: usernameHint,
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[AutofillHints.password],
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 8. AutofillHints catalog.
// =============================================================================

class _HintCatalogEntry {
  const _HintCatalogEntry({
    required this.category,
    required this.hint,
    required this.label,
    required this.example,
  });

  final String category;
  final String hint;
  final String label;
  final String example;
}

const List<_HintCatalogEntry> _hintCatalog = <_HintCatalogEntry>[
  // Identity
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.givenName,
    label: 'givenName',
    example: 'Ada',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.middleName,
    label: 'middleName',
    example: 'B.',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.familyName,
    label: 'familyName',
    example: 'Lovelace',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.namePrefix,
    label: 'namePrefix',
    example: 'Dr.',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.nameSuffix,
    label: 'nameSuffix',
    example: 'Jr.',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.nickname,
    label: 'nickname',
    example: 'AdaL',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.birthday,
    label: 'birthday',
    example: '1815-12-10',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.gender,
    label: 'gender',
    example: 'female',
  ),
  // Account
  _HintCatalogEntry(
    category: 'account',
    hint: AutofillHints.username,
    label: 'username',
    example: 'ada',
  ),
  _HintCatalogEntry(
    category: 'account',
    hint: AutofillHints.newUsername,
    label: 'newUsername',
    example: 'ada_v2',
  ),
  _HintCatalogEntry(
    category: 'account',
    hint: AutofillHints.password,
    label: 'password',
    example: '••••••',
  ),
  _HintCatalogEntry(
    category: 'account',
    hint: AutofillHints.newPassword,
    label: 'newPassword',
    example: '••••••',
  ),
  _HintCatalogEntry(
    category: 'account',
    hint: AutofillHints.email,
    label: 'email',
    example: 'ada@example.com',
  ),
  _HintCatalogEntry(
    category: 'account',
    hint: AutofillHints.oneTimeCode,
    label: 'oneTimeCode',
    example: '123 456',
  ),
  // Address
  _HintCatalogEntry(
    category: 'address',
    hint: AutofillHints.streetAddressLine1,
    label: 'streetAddressLine1',
    example: '12 Lambeth St',
  ),
  _HintCatalogEntry(
    category: 'address',
    hint: AutofillHints.streetAddressLine2,
    label: 'streetAddressLine2',
    example: 'Apt 3B',
  ),
  _HintCatalogEntry(
    category: 'address',
    hint: AutofillHints.streetAddressLine3,
    label: 'streetAddressLine3',
    example: '',
  ),
  _HintCatalogEntry(
    category: 'address',
    hint: AutofillHints.addressCity,
    label: 'addressCity',
    example: 'London',
  ),
  _HintCatalogEntry(
    category: 'address',
    hint: AutofillHints.addressState,
    label: 'addressState',
    example: 'GLA',
  ),
  _HintCatalogEntry(
    category: 'address',
    hint: AutofillHints.countryName,
    label: 'countryName',
    example: 'United Kingdom',
  ),
  _HintCatalogEntry(
    category: 'address',
    hint: AutofillHints.countryCode,
    label: 'countryCode',
    example: 'GB',
  ),
  // Postal
  _HintCatalogEntry(
    category: 'postal',
    hint: AutofillHints.postalCode,
    label: 'postalCode',
    example: 'SW1A 1AA',
  ),
  _HintCatalogEntry(
    category: 'postal',
    hint: AutofillHints.postalAddress,
    label: 'postalAddress',
    example: 'full address',
  ),
  _HintCatalogEntry(
    category: 'postal',
    hint: AutofillHints.postalAddressExtended,
    label: 'postalAddressExtended',
    example: 'extended',
  ),
  // Telephone
  _HintCatalogEntry(
    category: 'telephone',
    hint: AutofillHints.telephoneNumber,
    label: 'telephoneNumber',
    example: '+44 20 7946 0958',
  ),
  _HintCatalogEntry(
    category: 'telephone',
    hint: AutofillHints.telephoneNumberCountryCode,
    label: 'telephoneNumberCountryCode',
    example: '+44',
  ),
  _HintCatalogEntry(
    category: 'telephone',
    hint: AutofillHints.telephoneNumberAreaCode,
    label: 'telephoneNumberAreaCode',
    example: '20',
  ),
  _HintCatalogEntry(
    category: 'telephone',
    hint: AutofillHints.telephoneNumberLocal,
    label: 'telephoneNumberLocal',
    example: '7946 0958',
  ),
  // Finance
  _HintCatalogEntry(
    category: 'finance',
    hint: AutofillHints.creditCardName,
    label: 'creditCardName',
    example: 'A. Lovelace',
  ),
  _HintCatalogEntry(
    category: 'finance',
    hint: AutofillHints.creditCardNumber,
    label: 'creditCardNumber',
    example: '4111 1111 1111 1111',
  ),
  _HintCatalogEntry(
    category: 'finance',
    hint: AutofillHints.creditCardSecurityCode,
    label: 'creditCardSecurityCode',
    example: '123',
  ),
  _HintCatalogEntry(
    category: 'finance',
    hint: AutofillHints.creditCardExpirationMonth,
    label: 'creditCardExpirationMonth',
    example: '12',
  ),
  _HintCatalogEntry(
    category: 'finance',
    hint: AutofillHints.creditCardExpirationYear,
    label: 'creditCardExpirationYear',
    example: '2030',
  ),
  _HintCatalogEntry(
    category: 'finance',
    hint: AutofillHints.creditCardExpirationDate,
    label: 'creditCardExpirationDate',
    example: '12/2030',
  ),
  // Org / location extras
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.organizationName,
    label: 'organizationName',
    example: 'Analytical Engine Ltd.',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.jobTitle,
    label: 'jobTitle',
    example: 'Mathematician',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.url,
    label: 'url',
    example: 'https://example.com',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.photo,
    label: 'photo',
    example: 'avatar.png',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.language,
    label: 'language',
    example: 'en-GB',
  ),
  _HintCatalogEntry(
    category: 'identity',
    hint: AutofillHints.location,
    label: 'location',
    example: 'lat,lng',
  ),
];

class _HintsCatalogSection extends StatelessWidget {
  const _HintsCatalogSection();

  @override
  Widget build(BuildContext context) {
    final Map<String, List<_HintCatalogEntry>> grouped =
        <String, List<_HintCatalogEntry>>{};
    for (final entry in _hintCatalog) {
      grouped.putIfAbsent(entry.category, () => <_HintCatalogEntry>[]).add(entry);
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'AutofillHints catalog (${_hintCatalog.length} entries)',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              'Each card shows a hint constant + a sample TextField that '
              'binds it. Grouped by category. Pick the hint that semantically '
              'matches the user data you collect.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            for (final String category in grouped.keys) ...<Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Text(
                  category.toUpperCase(),
                  style: TextStyle(
                    color: Colors.indigo.shade700,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              AutofillGroup(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: <Widget>[
                    for (final entry in grouped[category]!)
                      _HintCatalogCard(entry: entry),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HintCatalogCard extends StatelessWidget {
  const _HintCatalogCard({required this.entry});

  final _HintCatalogEntry entry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                entry.label,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'AutofillHints.${entry.label}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: <String>[entry.hint],
                decoration: InputDecoration(
                  isDense: true,
                  border: const OutlineInputBorder(),
                  hintText: entry.example,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 9. Stateful autofill commit demo.
// =============================================================================

class _CommitDemoSection extends StatefulWidget {
  const _CommitDemoSection();

  @override
  State<_CommitDemoSection> createState() => _CommitDemoSectionState();
}

class _CommitDemoSectionState extends State<_CommitDemoSection> {
  int _commitCount = 0;
  int _cancelCount = 0;
  String _last = '—';

  void _commit() {
    _finishAutofillContext();
    setState(() {
      _commitCount++;
      _last = 'commit (#$_commitCount)';
    });
  }

  void _cancel() {
    _finishAutofillContext(shouldSave: false);
    setState(() {
      _cancelCount++;
      _last = 'cancel (#$_cancelCount)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Manually drive finishAutofillContext',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Each press of "Commit" calls TextInput.finishAutofillContext'
                '(shouldSave: true). Each press of "Cancel" calls it with '
                'shouldSave: false. The OS treats the session as ended; the '
                'next focus into a field starts a fresh autofill attempt.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              TextField(
                autofillHints: const <String>[AutofillHints.username],
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[AutofillHints.password],
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FilledButton(
                      onPressed: _commit,
                      child: Text('Commit ($_commitCount)'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _cancel,
                      child: Text('Cancel ($_cancelCount)'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Last action: $_last\n'
                  'Total commits: $_commitCount\n'
                  'Total cancels: $_cancelCount\n'
                  'Calling finishAutofillContext clears the session — next '
                  'focus starts a fresh autofill attempt.',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 10. Pitfalls.
// =============================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    const List<_Pitfall> pitfalls = <_Pitfall>[
      _Pitfall(
        title: 'Forgetting autofillHints',
        body:
            'Without autofillHints the OS will NOT recognize the field. '
            'Even if the TextField is inside an AutofillGroup, an empty '
            'autofillHints list means the field is invisible to the '
            'autofill subsystem.',
      ),
      _Pitfall(
        title: 'Wrong hint → wrong suggestion',
        body:
            'Using AutofillHints.email on a confirm-email field, or '
            'AutofillHints.password on a one-time code field, makes the '
            'platform suggest the wrong stored value. Use newPassword for '
            '"create a password" and oneTimeCode for SMS codes.',
      ),
      _Pitfall(
        title: 'AutofillGroup must wrap ALL related fields',
        body:
            'Splitting username and password into different AutofillGroups '
            '(or worse, leaving one outside any group) prevents the '
            'password manager from matching them as a credential pair.',
      ),
      _Pitfall(
        title: 'iOS may need keyboardType matching',
        body:
            'On iOS the autofill subsystem cross-references keyboardType '
            'with autofillHints. An email field should also have '
            'keyboardType: TextInputType.emailAddress; a number-only field '
            'should use TextInputType.number.',
      ),
      _Pitfall(
        title: 'finishAutofillContext on submit, not on every blur',
        body:
            'Do not call finishAutofillContext on every focus change — '
            'that ends the autofill session prematurely and the OS will '
            'never offer to save. Call it only when the user explicitly '
            'submits the form.',
      ),
    ];

    return Column(
      children: <Widget>[
        for (final p in pitfalls) _PitfallCard(pitfall: p),
      ],
    );
  }
}

class _Pitfall {
  const _Pitfall({required this.title, required this.body});

  final String title;
  final String body;
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({required this.pitfall});

  final _Pitfall pitfall;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.warning_amber_rounded, color: Colors.orange),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    pitfall.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(pitfall.body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 11. Recipe gallery.
// =============================================================================

class _RecipeGallerySection extends StatelessWidget {
  const _RecipeGallerySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _SignupRecipeCard(),
        SizedBox(height: 12),
        _ShippingRecipeCard(),
        SizedBox(height: 12),
        _ProfileEditRecipeCard(),
        SizedBox(height: 12),
        _PaymentRecipeCard(),
      ],
    );
  }
}

class _SignupRecipeCard extends StatelessWidget {
  const _SignupRecipeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          onDisposeAction: AutofillContextAction.commit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _RecipeHeader(
                title: 'Signup',
                subtitle:
                    'newUsername + newPassword + email — note the use of '
                    'the "new" hints to avoid matching an existing '
                    'credential.',
              ),
              const SizedBox(height: 12),
              TextField(
                autofillHints: const <String>[AutofillHints.newUsername],
                decoration: const InputDecoration(
                  labelText: 'New username',
                  border: OutlineInputBorder(),
                  helperText: 'newUsername',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[AutofillHints.newPassword],
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New password',
                  border: OutlineInputBorder(),
                  helperText: 'newPassword',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  helperText: 'email',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShippingRecipeCard extends StatelessWidget {
  const _ShippingRecipeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          onDisposeAction: AutofillContextAction.commit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _RecipeHeader(
                title: 'Shipping',
                subtitle:
                    'Receiver name + phone + full address. The phone is '
                    'inside the same group so it gets autofilled with the '
                    'address.',
              ),
              const SizedBox(height: 12),
              TextField(
                autofillHints: const <String>[AutofillHints.name],
                decoration: const InputDecoration(
                  labelText: 'Recipient name',
                  border: OutlineInputBorder(),
                  helperText: 'name',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[
                  AutofillHints.telephoneNumber,
                ],
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                  helperText: 'telephoneNumber',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[
                  AutofillHints.streetAddressLine1,
                ],
                decoration: const InputDecoration(
                  labelText: 'Street',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[
                  AutofillHints.addressCity,
                ],
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[AutofillHints.postalCode],
                decoration: const InputDecoration(
                  labelText: 'Postal code',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileEditRecipeCard extends StatelessWidget {
  const _ProfileEditRecipeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          onDisposeAction: AutofillContextAction.commit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _RecipeHeader(
                title: 'Profile edit',
                subtitle:
                    'No password fields. The autofill commit only saves '
                    'the new identity values; the password manager does '
                    'NOT touch credentials here.',
              ),
              const SizedBox(height: 12),
              TextField(
                autofillHints: const <String>[AutofillHints.givenName],
                decoration: const InputDecoration(
                  labelText: 'Given name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[AutofillHints.familyName],
                decoration: const InputDecoration(
                  labelText: 'Family name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[AutofillHints.nickname],
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[AutofillHints.jobTitle],
                decoration: const InputDecoration(
                  labelText: 'Job title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[
                  AutofillHints.organizationName,
                ],
                decoration: const InputDecoration(
                  labelText: 'Organization',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentRecipeCard extends StatelessWidget {
  const _PaymentRecipeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          onDisposeAction: AutofillContextAction.commit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _RecipeHeader(
                title: 'Payment',
                subtitle:
                    'creditCardNumber + creditCardName + expirationDate + '
                    'securityCode. AutofillContextAction.commit so the '
                    'card is saved on a successful charge.',
              ),
              const SizedBox(height: 12),
              TextField(
                autofillHints: const <String>[
                  AutofillHints.creditCardNumber,
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Card number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[
                  AutofillHints.creditCardName,
                ],
                decoration: const InputDecoration(
                  labelText: 'Cardholder',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[
                  AutofillHints.creditCardExpirationDate,
                ],
                decoration: const InputDecoration(
                  labelText: 'Expiration (MM/YY)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const <String>[
                  AutofillHints.creditCardSecurityCode,
                ],
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeHeader extends StatelessWidget {
  const _RecipeHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}

// =============================================================================
// 12. Reference table.
// =============================================================================

class _ReferenceRow {
  const _ReferenceRow({required this.symbol, required this.kind, required this.summary});

  final String symbol;
  final String kind;
  final String summary;
}

const List<_ReferenceRow> _referenceRows = <_ReferenceRow>[
  _ReferenceRow(
    symbol: 'AutofillGroup',
    kind: 'StatefulWidget',
    summary:
        'The widget you wrap a related set of TextFields in. Provides an '
        'AutofillGroupState (= AutofillScope) to the subtree.',
  ),
  _ReferenceRow(
    symbol: 'AutofillGroupState',
    kind: 'State<AutofillGroup>, AutofillScope',
    summary:
        'The State backing the widget. Tracks registered AutofillClients '
        'via register/unregister. Implements autofill commit/cancel via '
        'onDisposeAction.',
  ),
  _ReferenceRow(
    symbol: 'AutofillScope',
    kind: 'mixin / interface',
    summary:
        'The interface the engine talks to. Contains autofillClients and '
        'attach/detach logic. AutofillGroupState is the canonical impl.',
  ),
  _ReferenceRow(
    symbol: 'AutofillClient',
    kind: 'interface (EditableTextState)',
    summary:
        'A single field. Implemented internally by EditableTextState. '
        'Calls scope.register on attach, scope.unregister on dispose.',
  ),
  _ReferenceRow(
    symbol: 'AutofillHints',
    kind: 'class with String constants',
    summary:
        'String constants you list on TextField.autofillHints. The OS '
        'maps them to its native autofill categories (email, password, '
        'creditCardNumber, etc.).',
  ),
  _ReferenceRow(
    symbol: 'AutofillContextAction',
    kind: 'enum',
    summary:
        'commit (save to keychain) or cancel (drop session). Set via '
        'AutofillGroup.onDisposeAction or '
        'TextInput.finishAutofillContext(shouldSave).',
  ),
  _ReferenceRow(
    symbol: 'TextInput.finishAutofillContext',
    kind: 'static method',
    summary:
        'Manually commit (shouldSave: true) or cancel (shouldSave: false) '
        'the current autofill session. Call on submit, not on blur.',
  ),
];

class _ReferenceTableSection extends StatelessWidget {
  const _ReferenceTableSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Reference',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: IntrinsicColumnWidth(),
                2: FlexColumnWidth(),
              },
              border: TableBorder.all(color: Colors.grey.shade300),
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(color: Colors.indigo.shade50),
                  children: const <Widget>[
                    _Cell(text: 'Symbol', isHeader: true),
                    _Cell(text: 'Kind', isHeader: true),
                    _Cell(text: 'Summary', isHeader: true),
                  ],
                ),
                for (final row in _referenceRows)
                  TableRow(
                    children: <Widget>[
                      _Cell(text: row.symbol, mono: true),
                      _Cell(text: row.kind, mono: true),
                      _Cell(text: row.summary),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({required this.text, this.isHeader = false, this.mono = false});

  final String text;
  final bool isHeader;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontFamily: mono ? 'monospace' : null,
          fontSize: 12,
        ),
      ),
    );
  }
}

// =============================================================================
// Footer.
// =============================================================================

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Recap',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '• AutofillGroupState is the State of AutofillGroup; it IS an '
            'AutofillScope.\n'
            '• Each TextField with non-empty autofillHints registers as an '
            'AutofillClient of the nearest AutofillGroupState.\n'
            '• Use AutofillGroup.of(context) to read the state from a '
            'descendant.\n'
            '• Commit with TextInput.finishAutofillContext() (or rely on '
            'onDisposeAction: AutofillContextAction.commit).\n'
            '• Cancel with TextInput.finishAutofillContext(shouldSave: false) '
            '(or onDisposeAction: AutofillContextAction.cancel).\n'
            '• Group ALL related fields together; nest only when you truly '
            'have two independent autofill sessions.',
          ),
        ],
      ),
    );
  }
}
