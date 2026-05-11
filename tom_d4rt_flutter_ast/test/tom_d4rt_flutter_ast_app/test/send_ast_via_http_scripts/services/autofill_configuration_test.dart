// ignore_for_file: avoid_print, deprecated_member_use, unused_local_variable, unused_element
// D4rt test script: Deep Demo - AutofillConfiguration from services
// Comprehensive visual exploration of the autofill configuration object used
// by TextInputClient implementations to participate in OS-level autofill.
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// ============================================================================
// HELPERS
// ============================================================================

Widget _sectionHeader(String number, String title, String subtitle) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 24, bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: const Color(0xFF1A237E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEB3B),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'SECTION $number',
                style: const TextStyle(
                  color: Color(0xFF1A237E),
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(color: Color(0xFFE3F2FD), fontSize: 12),
        ),
      ],
    ),
  );
}

Widget _kv(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            key,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Color(0xFF455A64),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: valueColor ?? const Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _configCard({
  required String title,
  required AutofillConfiguration config,
  Color? accent,
  String? description,
  Widget? trailing,
}) {
  final color = accent ?? const Color(0xFF3F51B5);
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 6),
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: color.withOpacity(0.4)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          if (description != null) ...[
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF546E7A),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const Divider(height: 16),
          _kv('uniqueIdentifier', config.uniqueIdentifier),
          _kv('autofillHints', config.autofillHints.toString()),
          _kv('hintText', config.hintText ?? '<none>'),
          _kv('editingValue.text', "'${config.currentEditingValue.text}'"),
          _kv(
            'editingValue.selection',
            config.currentEditingValue.selection.toString(),
          ),
          _kv('runtimeType', config.runtimeType.toString()),
          if (trailing != null) ...[const SizedBox(height: 10), trailing],
        ],
      ),
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontFamily: 'monospace',
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _tableRow(List<String> cells, {bool header = false, Color? bg}) {
  return Container(
    color: bg,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Row(
      children: cells
          .map(
            (c) => Expanded(
              child: Text(
                c,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: header ? null : 'monospace',
                  fontWeight: header ? FontWeight.bold : FontWeight.normal,
                  color: header
                      ? const Color(0xFF1A237E)
                      : const Color(0xFF263238),
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}

Widget _glossaryEntry(String term, String definition) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          term,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Color(0xFF1A237E),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          definition,
          style: const TextStyle(fontSize: 12, color: Color(0xFF37474F)),
        ),
      ],
    ),
  );
}

Widget _recipeCard(String title, String purpose, String code, Color accent) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 6),
    color: const Color(0xFFFAFAFA),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: accent.withOpacity(0.4)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.restaurant_menu, color: accent, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            purpose,
            style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: Color(0xFF546E7A),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF263238),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: Color(0xFFB2EBF2),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  print('=' * 70);
  print('AutofillConfiguration Deep Demo Test');
  print('=' * 70);

  // ==========================================================================
  // SECTION 1: DOSSIER — role of AutofillConfiguration
  // ==========================================================================

  print('\n[SECTION 1] Dossier');
  final dossierFacts = <Map<String, String>>[
    {
      'fact': 'package',
      'value': 'package:flutter/services.dart',
    },
    {
      'fact': 'kind',
      'value': 'immutable data class',
    },
    {
      'fact': 'role',
      'value': 'Bundles all metadata required to participate in OS autofill',
    },
    {
      'fact': 'consumer',
      'value': 'TextInputClient.autofillConfiguration',
    },
    {
      'fact': 'wire format',
      'value': 'serialised to a Map and sent across the platform channel',
    },
    {
      'fact': 'companion',
      'value': 'AutofillScope and AutofillClient on TextInput',
    },
    {
      'fact': 'platforms',
      'value': 'iOS (UITextField), Android (Autofill Framework), Web',
    },
    {
      'fact': 'sentinel',
      'value': 'AutofillConfiguration.disabled opts the field out',
    },
  ];
  for (final f in dossierFacts) {
    print('  - ${f['fact']}: ${f['value']}');
  }

  final dossierWidget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: dossierFacts
        .map((f) => _kv(f['fact']!, f['value']!))
        .toList(),
  );

  // ==========================================================================
  // SECTION 2: ANATOMY — constructor parameters, disabled factory
  // ==========================================================================

  print('\n[SECTION 2] Anatomy');

  final anatomyParams = <Map<String, String>>[
    {
      'name': 'uniqueIdentifier',
      'type': 'String',
      'required': 'yes',
      'desc':
          'Stable identifier the platform uses to correlate fields across rebuilds',
    },
    {
      'name': 'autofillHints',
      'type': 'List<String>',
      'required': 'yes',
      'desc':
          'Ordered list of semantic hints, typically from the AutofillHints class',
    },
    {
      'name': 'currentEditingValue',
      'type': 'TextEditingValue',
      'required': 'yes',
      'desc':
          'The latest editing snapshot — text, selection, and composing range',
    },
    {
      'name': 'hintText',
      'type': 'String?',
      'required': 'no',
      'desc':
          'Optional placeholder string the OS may show in its autofill UI',
    },
  ];

  final anatomyWidget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _tableRow(
        ['name', 'type', 'required', 'description'],
        header: true,
        bg: const Color(0xFFE8EAF6),
      ),
      ...anatomyParams.map(
        (p) => _tableRow([
          p['name']!,
          p['type']!,
          p['required']!,
          p['desc']!,
        ]),
      ),
    ],
  );

  for (final p in anatomyParams) {
    print('  - ${p['name']} : ${p['type']} (${p['required']})');
  }

  // ==========================================================================
  // SECTION 3: AUTOFILLHINTS CATALOG — 20+ semantic hint constants
  // ==========================================================================

  print('\n[SECTION 3] AutofillHints catalog');

  final hintCatalog = <Map<String, String>>[
    {'label': 'email', 'value': AutofillHints.email},
    {'label': 'username', 'value': AutofillHints.username},
    {'label': 'newUsername', 'value': AutofillHints.newUsername},
    {'label': 'password', 'value': AutofillHints.password},
    {'label': 'newPassword', 'value': AutofillHints.newPassword},
    {'label': 'oneTimeCode', 'value': AutofillHints.oneTimeCode},
    {'label': 'name', 'value': AutofillHints.name},
    {'label': 'givenName', 'value': AutofillHints.givenName},
    {'label': 'middleName', 'value': AutofillHints.middleName},
    {'label': 'familyName', 'value': AutofillHints.familyName},
    {'label': 'namePrefix', 'value': AutofillHints.namePrefix},
    {'label': 'nameSuffix', 'value': AutofillHints.nameSuffix},
    {'label': 'nickname', 'value': AutofillHints.nickname},
    {'label': 'telephoneNumber', 'value': AutofillHints.telephoneNumber},
    {'label': 'streetAddressLine1', 'value': AutofillHints.streetAddressLine1},
    {'label': 'streetAddressLine2', 'value': AutofillHints.streetAddressLine2},
    {'label': 'addressCity', 'value': AutofillHints.addressCity},
    {'label': 'addressState', 'value': AutofillHints.addressState},
    {'label': 'postalCode', 'value': AutofillHints.postalCode},
    {'label': 'countryName', 'value': AutofillHints.countryName},
    {'label': 'creditCardNumber', 'value': AutofillHints.creditCardNumber},
    {
      'label': 'creditCardSecurityCode',
      'value': AutofillHints.creditCardSecurityCode,
    },
    {
      'label': 'creditCardExpirationDate',
      'value': AutofillHints.creditCardExpirationDate,
    },
    {
      'label': 'creditCardExpirationMonth',
      'value': AutofillHints.creditCardExpirationMonth,
    },
    {
      'label': 'creditCardExpirationYear',
      'value': AutofillHints.creditCardExpirationYear,
    },
    {'label': 'birthday', 'value': AutofillHints.birthday},
    {'label': 'gender', 'value': AutofillHints.gender},
    {'label': 'jobTitle', 'value': AutofillHints.jobTitle},
    {'label': 'organizationName', 'value': AutofillHints.organizationName},
    {'label': 'url', 'value': AutofillHints.url},
  ];

  print('  total hints catalogued: ${hintCatalog.length}');
  for (final h in hintCatalog.take(6)) {
    print("    ${h['label']} -> '${h['value']}'");
  }
  print('    ... and ${hintCatalog.length - 6} more');

  final hintCatalogWidget = Wrap(
    spacing: 6,
    runSpacing: 6,
    children: [
      for (var i = 0; i < hintCatalog.length; i++)
        _chip(
          hintCatalog[i]['label']!,
          [
            const Color(0xFF1976D2),
            const Color(0xFF388E3C),
            const Color(0xFFD32F2F),
            const Color(0xFFF57C00),
            const Color(0xFF7B1FA2),
            const Color(0xFF00838F),
          ][i % 6],
        ),
    ],
  );

  // ==========================================================================
  // SECTION 4: REALISTIC FIELD GALLERY — login / address / payment
  // ==========================================================================

  print('\n[SECTION 4] Realistic field gallery');

  // ----- 4a: login form -----
  final loginUsername = AutofillConfiguration(
    uniqueIdentifier: 'login.username',
    autofillHints: const [AutofillHints.username, AutofillHints.email],
    currentEditingValue: const TextEditingValue(text: 'jane.doe@example.com'),
    hintText: 'Email or username',
  );
  final loginPassword = AutofillConfiguration(
    uniqueIdentifier: 'login.password',
    autofillHints: const [AutofillHints.password],
    currentEditingValue: TextEditingValue.empty,
    hintText: 'Password',
  );

  // ----- 4b: address form -----
  final addrStreet1 = AutofillConfiguration(
    uniqueIdentifier: 'address.street1',
    autofillHints: const [AutofillHints.streetAddressLine1],
    currentEditingValue: const TextEditingValue(text: '221B Baker Street'),
    hintText: 'Street address',
  );
  final addrStreet2 = AutofillConfiguration(
    uniqueIdentifier: 'address.street2',
    autofillHints: const [AutofillHints.streetAddressLine2],
    currentEditingValue: TextEditingValue.empty,
    hintText: 'Apt, suite, unit (optional)',
  );
  final addrCity = AutofillConfiguration(
    uniqueIdentifier: 'address.city',
    autofillHints: const [AutofillHints.addressCity],
    currentEditingValue: const TextEditingValue(text: 'London'),
    hintText: 'City',
  );
  final addrPostal = AutofillConfiguration(
    uniqueIdentifier: 'address.postalCode',
    autofillHints: const [AutofillHints.postalCode],
    currentEditingValue: const TextEditingValue(text: 'NW1 6XE'),
    hintText: 'Postal / ZIP code',
  );
  final addrCountry = AutofillConfiguration(
    uniqueIdentifier: 'address.country',
    autofillHints: const [AutofillHints.countryName],
    currentEditingValue: const TextEditingValue(text: 'United Kingdom'),
    hintText: 'Country',
  );

  // ----- 4c: payment form -----
  final payNumber = AutofillConfiguration(
    uniqueIdentifier: 'payment.cardNumber',
    autofillHints: const [AutofillHints.creditCardNumber],
    currentEditingValue: TextEditingValue.empty,
    hintText: '1234 5678 9012 3456',
  );
  final payExpiry = AutofillConfiguration(
    uniqueIdentifier: 'payment.expiry',
    autofillHints: const [AutofillHints.creditCardExpirationDate],
    currentEditingValue: TextEditingValue.empty,
    hintText: 'MM/YY',
  );
  final payCvv = AutofillConfiguration(
    uniqueIdentifier: 'payment.cvv',
    autofillHints: const [AutofillHints.creditCardSecurityCode],
    currentEditingValue: TextEditingValue.empty,
    hintText: 'CVV',
  );
  final payName = AutofillConfiguration(
    uniqueIdentifier: 'payment.cardholder',
    autofillHints: const [AutofillHints.name],
    currentEditingValue: const TextEditingValue(text: 'JANE DOE'),
    hintText: 'Cardholder name',
  );

  print('  login fields:    2');
  print('  address fields:  5');
  print('  payment fields:  4');

  Widget _buildLoginForm() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login form (AutofillGroup)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const [
                  AutofillHints.username,
                  AutofillHints.email,
                ],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: loginUsername.hintText,
                  isDense: true,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const [AutofillHints.password],
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: loginPassword.hintText,
                  isDense: true,
                ),
              ),
              const SizedBox(height: 8),
              _kv('group.identifier', '"login.username + login.password"'),
              _kv('group.scope', 'shared AutofillScope across both fields'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressForm() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Address form (AutofillGroup)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF388E3C),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const [AutofillHints.streetAddressLine1],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: addrStreet1.hintText,
                  isDense: true,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const [AutofillHints.streetAddressLine2],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: addrStreet2.hintText,
                  isDense: true,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      autofillHints: const [AutofillHints.addressCity],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: addrCity.hintText,
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      autofillHints: const [AutofillHints.postalCode],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: addrPostal.hintText,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const [AutofillHints.countryName],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: addrCountry.hintText,
                  isDense: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment form (AutofillGroup)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD32F2F),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const [AutofillHints.creditCardNumber],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: payNumber.hintText,
                  isDense: true,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofillHints: const [
                        AutofillHints.creditCardExpirationDate,
                      ],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: payExpiry.hintText,
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      autofillHints: const [
                        AutofillHints.creditCardSecurityCode,
                      ],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: payCvv.hintText,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                autofillHints: const [AutofillHints.name],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: payName.hintText,
                  isDense: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final galleryWidget = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _configCard(
        title: 'login.username',
        config: loginUsername,
        accent: const Color(0xFF1976D2),
        description: 'Accepts either an email or a stored username.',
      ),
      _configCard(
        title: 'login.password',
        config: loginPassword,
        accent: const Color(0xFF1976D2),
        description: 'Linked to login.username via the shared AutofillGroup.',
      ),
      _buildLoginForm(),
      _configCard(
        title: 'address.street1',
        config: addrStreet1,
        accent: const Color(0xFF388E3C),
      ),
      _configCard(
        title: 'address.street2',
        config: addrStreet2,
        accent: const Color(0xFF388E3C),
      ),
      _configCard(
        title: 'address.city',
        config: addrCity,
        accent: const Color(0xFF388E3C),
      ),
      _configCard(
        title: 'address.postalCode',
        config: addrPostal,
        accent: const Color(0xFF388E3C),
      ),
      _configCard(
        title: 'address.country',
        config: addrCountry,
        accent: const Color(0xFF388E3C),
      ),
      _buildAddressForm(),
      _configCard(
        title: 'payment.cardNumber',
        config: payNumber,
        accent: const Color(0xFFD32F2F),
      ),
      _configCard(
        title: 'payment.expiry',
        config: payExpiry,
        accent: const Color(0xFFD32F2F),
      ),
      _configCard(
        title: 'payment.cvv',
        config: payCvv,
        accent: const Color(0xFFD32F2F),
      ),
      _configCard(
        title: 'payment.cardholder',
        config: payName,
        accent: const Color(0xFFD32F2F),
      ),
      _buildPaymentForm(),
    ],
  );

  // ==========================================================================
  // SECTION 5: TextEditingValue exploration
  // ==========================================================================

  print('\n[SECTION 5] TextEditingValue exploration');

  final tevEmpty = TextEditingValue.empty;
  final tevPlain = const TextEditingValue(text: 'hello world');
  final tevSelection = const TextEditingValue(
    text: 'hello world',
    selection: TextSelection(baseOffset: 0, extentOffset: 5),
  );
  final tevCollapsed = const TextEditingValue(
    text: 'cursor|here',
    selection: TextSelection.collapsed(offset: 6),
  );
  final tevComposing = const TextEditingValue(
    text: 'compose',
    composing: TextRange(start: 0, end: 7),
  );

  final tevConfigs = <AutofillConfiguration>[
    AutofillConfiguration(
      uniqueIdentifier: 'tev.empty',
      autofillHints: const [AutofillHints.username],
      currentEditingValue: tevEmpty,
      hintText: 'empty value',
    ),
    AutofillConfiguration(
      uniqueIdentifier: 'tev.plain',
      autofillHints: const [AutofillHints.username],
      currentEditingValue: tevPlain,
      hintText: 'plain text',
    ),
    AutofillConfiguration(
      uniqueIdentifier: 'tev.selection',
      autofillHints: const [AutofillHints.username],
      currentEditingValue: tevSelection,
      hintText: 'with selection',
    ),
    AutofillConfiguration(
      uniqueIdentifier: 'tev.collapsed',
      autofillHints: const [AutofillHints.username],
      currentEditingValue: tevCollapsed,
      hintText: 'collapsed cursor',
    ),
    AutofillConfiguration(
      uniqueIdentifier: 'tev.composing',
      autofillHints: const [AutofillHints.username],
      currentEditingValue: tevComposing,
      hintText: 'composing range',
    ),
  ];

  for (final c in tevConfigs) {
    print(
      "  ${c.uniqueIdentifier}: text='${c.currentEditingValue.text}' sel=${c.currentEditingValue.selection}",
    );
  }

  final tevWidget = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: tevConfigs
        .map(
          (c) => _configCard(
            title: c.uniqueIdentifier,
            config: c,
            accent: const Color(0xFF7B1FA2),
          ),
        )
        .toList(),
  );

  // ==========================================================================
  // SECTION 6: AutofillScope discussion
  // ==========================================================================

  print('\n[SECTION 6] AutofillScope discussion');

  final scopeFacts = <String>[
    'AutofillScope groups related fields so the platform can save / restore them together.',
    'In Flutter, AutofillGroup is the widget-level surface for an AutofillScope.',
    'A field reports its scope via TextInputClient.currentAutofillScope.',
    'Without a scope, each field is treated by the platform as a standalone form.',
    'A scope is required for "commit on submit" autofill flows on iOS.',
    'AutofillGroup automatically forwards onDispose so saved values are flushed.',
  ];
  for (final s in scopeFacts) {
    print('  - $s');
  }

  final scopeWidget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final s in scopeFacts)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_right, size: 18, color: Color(0xFF00838F)),
              Expanded(
                child: Text(
                  s,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
    ],
  );

  // ==========================================================================
  // SECTION 7: AutofillConfiguration.disabled use case
  // ==========================================================================

  print('\n[SECTION 7] AutofillConfiguration.disabled');

  const disabled = AutofillConfiguration.disabled;
  print('  disabled.uniqueIdentifier = ${disabled.uniqueIdentifier}');
  print('  disabled.autofillHints    = ${disabled.autofillHints}');
  print('  disabled.hintText         = ${disabled.hintText}');
  print(
    "  disabled.currentEditingValue = '${disabled.currentEditingValue.text}'",
  );

  final disabledWidget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _configCard(
        title: 'AutofillConfiguration.disabled',
        config: disabled,
        accent: const Color(0xFF616161),
        description:
            'Sentinel value used by TextField when autofill should be off.',
      ),
      const SizedBox(height: 8),
      const Text(
        'When to reach for it:',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      _glossaryEntry(
        'Sensitive temporary inputs',
        'OTP fields that are short-lived and should not be remembered.',
      ),
      _glossaryEntry(
        'In-app search boxes',
        'Search queries are noise for the OS autofill database.',
      ),
      _glossaryEntry(
        'Custom in-app surveys',
        'Form-like UIs whose values are not "user identity" data.',
      ),
      _glossaryEntry(
        'Dev / debug fields',
        'Inputs in scaffolds or developer tools where autofill is distracting.',
      ),
    ],
  );

  // ==========================================================================
  // SECTION 8: Recipe cards
  // ==========================================================================

  print('\n[SECTION 8] Recipes');

  final recipeWidget = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _recipeCard(
        'Recipe 1 — Basic username field',
        'Single hint, empty editing value.',
        "AutofillConfiguration(\n  uniqueIdentifier: 'user',\n  autofillHints: [AutofillHints.username],\n  currentEditingValue: TextEditingValue.empty,\n)",
        const Color(0xFF1976D2),
      ),
      _recipeCard(
        'Recipe 2 — Email or username',
        'Multiple hints in priority order.',
        "AutofillConfiguration(\n  uniqueIdentifier: 'id',\n  autofillHints: [\n    AutofillHints.username,\n    AutofillHints.email,\n  ],\n  currentEditingValue: TextEditingValue.empty,\n)",
        const Color(0xFF388E3C),
      ),
      _recipeCard(
        'Recipe 3 — New password',
        'Distinguishes signup from sign-in for the password manager.',
        "AutofillConfiguration(\n  uniqueIdentifier: 'pw',\n  autofillHints: [AutofillHints.newPassword],\n  currentEditingValue: TextEditingValue.empty,\n  hintText: 'Choose a password',\n)",
        const Color(0xFFD32F2F),
      ),
      _recipeCard(
        'Recipe 4 — Address line composing',
        'Provide an existing draft via currentEditingValue.',
        "AutofillConfiguration(\n  uniqueIdentifier: 'addr1',\n  autofillHints: [AutofillHints.streetAddressLine1],\n  currentEditingValue: TextEditingValue(\n    text: '221B Baker St',\n  ),\n)",
        const Color(0xFFF57C00),
      ),
      _recipeCard(
        'Recipe 5 — Credit card group',
        'Use one AutofillGroup wrapping number / expiry / cvv.',
        "AutofillGroup(\n  child: Column(children: [\n    TextField(autofillHints: [\n      AutofillHints.creditCardNumber,\n    ]),\n    TextField(autofillHints: [\n      AutofillHints.creditCardExpirationDate,\n    ]),\n    TextField(autofillHints: [\n      AutofillHints.creditCardSecurityCode,\n    ]),\n  ]),\n)",
        const Color(0xFF7B1FA2),
      ),
      _recipeCard(
        'Recipe 6 — Opt out',
        'Use AutofillConfiguration.disabled for sensitive transient input.',
        "TextField(\n  // no autofillHints -> disabled\n  decoration: InputDecoration(\n    labelText: 'OTP',\n  ),\n)",
        const Color(0xFF616161),
      ),
      _recipeCard(
        'Recipe 7 — One-time code',
        'Special hint that lets the OS pull SMS-delivered codes on iOS.',
        "AutofillConfiguration(\n  uniqueIdentifier: 'otp',\n  autofillHints: [AutofillHints.oneTimeCode],\n  currentEditingValue: TextEditingValue.empty,\n)",
        const Color(0xFF00838F),
      ),
      _recipeCard(
        'Recipe 8 — Phone number',
        'Standard telephone hint for contact pickers.',
        "AutofillConfiguration(\n  uniqueIdentifier: 'phone',\n  autofillHints: [AutofillHints.telephoneNumber],\n  currentEditingValue: TextEditingValue.empty,\n  hintText: '+44 20 7946 0958',\n)",
        const Color(0xFF1A237E),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 9: Comparison table — disabled / single / multi
  // ==========================================================================

  print('\n[SECTION 9] Comparison table');

  final singleHint = AutofillConfiguration(
    uniqueIdentifier: 'compare.single',
    autofillHints: const [AutofillHints.email],
    currentEditingValue: TextEditingValue.empty,
    hintText: 'single hint',
  );
  final multiHint = AutofillConfiguration(
    uniqueIdentifier: 'compare.multi',
    autofillHints: const [
      AutofillHints.username,
      AutofillHints.email,
      AutofillHints.newUsername,
    ],
    currentEditingValue: TextEditingValue.empty,
    hintText: 'multi hint',
  );

  final comparisonRows = <List<String>>[
    ['property', 'disabled', 'single-hint', 'multi-hint'],
    [
      'uniqueIdentifier',
      disabled.uniqueIdentifier,
      singleHint.uniqueIdentifier,
      multiHint.uniqueIdentifier,
    ],
    [
      'hints.length',
      disabled.autofillHints.length.toString(),
      singleHint.autofillHints.length.toString(),
      multiHint.autofillHints.length.toString(),
    ],
    [
      'first hint',
      disabled.autofillHints.isEmpty ? '<none>' : disabled.autofillHints.first,
      singleHint.autofillHints.first,
      multiHint.autofillHints.first,
    ],
    [
      'hintText',
      disabled.hintText ?? '<null>',
      singleHint.hintText ?? '<null>',
      multiHint.hintText ?? '<null>',
    ],
    [
      'editing.text',
      "'${disabled.currentEditingValue.text}'",
      "'${singleHint.currentEditingValue.text}'",
      "'${multiHint.currentEditingValue.text}'",
    ],
    [
      'participates?',
      'no (opt-out)',
      'yes',
      'yes (ranked)',
    ],
  ];

  for (final row in comparisonRows) {
    print('  ${row.join(' | ')}');
  }

  final comparisonWidget = Column(
    children: [
      _tableRow(
        comparisonRows.first,
        header: true,
        bg: const Color(0xFFE8EAF6),
      ),
      ...comparisonRows.skip(1).map((r) => _tableRow(r)),
    ],
  );

  // ==========================================================================
  // SECTION 10: Glossary
  // ==========================================================================

  print('\n[SECTION 10] Glossary');

  final glossary = <Map<String, String>>[
    {
      'term': 'AutofillConfiguration',
      'def':
          'Immutable object holding metadata a TextInputClient needs to participate in autofill.',
    },
    {
      'term': 'uniqueIdentifier',
      'def':
          'Application-defined ID that survives rebuilds; used to correlate save / restore on the platform side.',
    },
    {
      'term': 'AutofillHints',
      'def':
          'Class exposing string constants understood by iOS, Android, and the web for semantic field types.',
    },
    {
      'term': 'AutofillGroup',
      'def':
          'Widget marking a set of TextFields as one logical form for autofill save dialogs.',
    },
    {
      'term': 'AutofillScope',
      'def':
          'Runtime object exposing the fields in an AutofillGroup; queried via TextInputClient.',
    },
    {
      'term': 'TextEditingValue',
      'def':
          'Tuple of text, selection, and composing range describing the live state of an editor.',
    },
    {
      'term': 'TextInputClient',
      'def':
          'Low-level protocol implemented by every editable widget; surfaces autofillConfiguration.',
    },
    {
      'term': 'disabled (factory)',
      'def':
          'Sentinel AutofillConfiguration meaning "do not participate in autofill".',
    },
    {
      'term': 'hintText',
      'def':
          'Optional human-readable placeholder used by some platforms in the autofill picker UI.',
    },
    {
      'term': 'oneTimeCode',
      'def':
          'Special hint enabling SMS-derived OTP autofill on iOS and supported Android versions.',
    },
  ];
  for (final g in glossary) {
    print("  - ${g['term']}: ${g['def']}");
  }

  final glossaryWidget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: glossary
        .map((g) => _glossaryEntry(g['term']!, g['def']!))
        .toList(),
  );

  // ==========================================================================
  // SECTION 11: Final composed widget tree
  // ==========================================================================

  print('\n[SECTION 11] Composed widget tree');

  final allConfigs = <AutofillConfiguration>[
    loginUsername,
    loginPassword,
    addrStreet1,
    addrStreet2,
    addrCity,
    addrPostal,
    addrCountry,
    payNumber,
    payExpiry,
    payCvv,
    payName,
    singleHint,
    multiHint,
    disabled,
    ...tevConfigs,
  ];
  print('  total configurations built: ${allConfigs.length}');
  print('  total hint catalog entries: ${hintCatalog.length}');
  print('  total glossary terms:       ${glossary.length}');

  final summaryWidget = Card(
    color: const Color(0xFFFFFDE7),
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Test summary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFFE65100),
            ),
          ),
          const SizedBox(height: 8),
          _kv('configurations', allConfigs.length.toString()),
          _kv('hint constants', hintCatalog.length.toString()),
          _kv('glossary terms', glossary.length.toString()),
          _kv('forms rendered', '3 (login, address, payment)'),
          _kv('recipes', '8'),
          _kv('sections', '11'),
        ],
      ),
    ),
  );

  print('\n' + '=' * 70);
  print('AutofillConfiguration Deep Demo complete');
  print('=' * 70);

  // ==========================================================================
  // FINAL: assemble the whole document
  // ==========================================================================

  return Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'AutofillConfiguration — Deep Demo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color(0xFF1A237E),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'package:flutter/services.dart',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFF455A64),
          ),
        ),
        _sectionHeader(
          '1',
          'Dossier',
          'What AutofillConfiguration is and where it sits in the autofill pipeline.',
        ),
        dossierWidget,
        _sectionHeader(
          '2',
          'Anatomy',
          'Constructor parameters, the disabled factory, and the framework message shape.',
        ),
        anatomyWidget,
        _sectionHeader(
          '3',
          'AutofillHints catalog',
          '${hintCatalog.length} semantic hint constants rendered as a chip grid.',
        ),
        hintCatalogWidget,
        _sectionHeader(
          '4',
          'Realistic field gallery',
          'Login, address, and payment forms with real TextFields inside AutofillGroups.',
        ),
        galleryWidget,
        _sectionHeader(
          '5',
          'TextEditingValue exploration',
          'Empty, plain, selection, collapsed, and composing variants.',
        ),
        tevWidget,
        _sectionHeader(
          '6',
          'AutofillScope discussion',
          'How a group of fields shares context for save / restore.',
        ),
        scopeWidget,
        _sectionHeader(
          '7',
          'AutofillConfiguration.disabled',
          'When and why to opt a field out of autofill.',
        ),
        disabledWidget,
        _sectionHeader(
          '8',
          'Recipes',
          'Copy-paste-ready snippets for common autofill setups.',
        ),
        recipeWidget,
        _sectionHeader(
          '9',
          'Comparison',
          'disabled vs single-hint vs multi-hint side by side.',
        ),
        comparisonWidget,
        _sectionHeader(
          '10',
          'Glossary',
          'Terms you will see across the autofill subsystem.',
        ),
        glossaryWidget,
        _sectionHeader(
          '11',
          'Summary',
          'Roll-up of everything built in this demo.',
        ),
        summaryWidget,
      ],
    ),
  );
}
