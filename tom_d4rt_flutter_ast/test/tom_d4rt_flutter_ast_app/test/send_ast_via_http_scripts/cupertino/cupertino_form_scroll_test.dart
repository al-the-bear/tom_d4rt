// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of CupertinoFormSection /
// CupertinoTextFormFieldRow / CupertinoFormRow with scroll behavior.
//
// Showcases the complete capability surface of CupertinoFormSection and
// CupertinoFormSection.insetGrouped as a passive, render-only demo.
// Scroll richness is provided by an outer ListView with many sections,
// each containing several CupertinoFormRow / CupertinoTextFormFieldRow
// children. Helpers, prefixes, errors, and decoration variations are
// all illustrated.
//
// Constraints: static `dynamic build(BuildContext context)`, no setState,
// no animations, no controllers (CupertinoTextFormFieldRow is passed
// `controller: null` and `validator: null`), no for-in over
// BridgedInstance, all onTap callbacks empty `() {}`. Must pass
// `dart analyze` with zero issues.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

dynamic build(BuildContext context) {
  return CupertinoApp(
    title: 'CupertinoForm Demo',
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemIndigo,
    ),
    home: CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Form & Scroll'),
        backgroundColor: Color(0xF8F8F8FA),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            _buildIntroCard(),
            _buildBasicFormSection(),
            _buildInsetGroupedFormSection(),
            _buildPrefixesSection(),
            _buildHelpersAndErrorsSection(),
            _buildKeyboardTypesSection(),
            _buildDecorationVariantsSection(),
            _buildLongFormSection(),
            _buildAnatomyDiagram(),
            _buildScrollAnatomyCard(),
            _buildUsageGuide(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Section 1: Intro Card
// ============================================================================

Widget _buildIntroCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF5E5CE6),
          Color(0xFF007AFF),
          Color(0xFF32ADE6),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x335E5CE6),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
        BoxShadow(
          color: Color(0x22007AFF),
          blurRadius: 30,
          offset: Offset(0, 14),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.22),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: CupertinoColors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Icon(
                CupertinoIcons.doc_text,
                color: CupertinoColors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'CupertinoFormSection',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'iOS-style form layouts with helpers and headers',
                    style: TextStyle(
                      color: Color(0xCCFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: CupertinoColors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: CupertinoColors.white.withOpacity(0.25),
              width: 1,
            ),
          ),
          child: const Text(
            'A passive render-only demo. The CupertinoFormSection widget '
            'lays out grouped form rows with optional headers, footers, '
            'and decoration. CupertinoFormRow adds prefix labels, helper '
            'and error texts. CupertinoTextFormFieldRow combines these '
            'into a one-line declaration of a form field row.',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            _introChip('Section'),
            const SizedBox(width: 8),
            _introChip('Row'),
            const SizedBox(width: 8),
            _introChip('TextFormField'),
            const SizedBox(width: 8),
            _introChip('Scroll'),
          ],
        ),
      ],
    ),
  );
}

Widget _introChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: CupertinoColors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: CupertinoColors.white.withOpacity(0.3),
        width: 1,
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: CupertinoColors.white,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ============================================================================
// Section 2: Basic CupertinoFormSection
// ============================================================================

Widget _buildBasicFormSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          'Basic CupertinoFormSection',
          CupertinoIcons.square_list,
          const Color(0xFF007AFF),
        ),
        const SizedBox(height: 8),
        _explanation(
          'The default CupertinoFormSection uses a flat layout with full '
          'width separators between rows. The header is rendered above '
          'the section in caps, and the footer is rendered below. The '
          'children list is wrapped with subtle dividers automatically.',
        ),
        const SizedBox(height: 12),
        CupertinoFormSection(
          header: const Text('PROFILE'),
          footer: const Text(
            'Your profile is visible to people in your network. '
            'These fields are illustrative only.',
          ),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Name'),
              placeholder: 'Alexis Kyaw',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Email'),
              placeholder: 'alexis@example.com',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Phone'),
              placeholder: '+1 555 0136',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Handle'),
              placeholder: '@al_the_bear',
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 3: CupertinoFormSection.insetGrouped
// ============================================================================

Widget _buildInsetGroupedFormSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          'CupertinoFormSection.insetGrouped',
          CupertinoIcons.rectangle_grid_2x2,
          const Color(0xFFAF52DE),
        ),
        const SizedBox(height: 8),
        _explanation(
          'The inset grouped variant gives every section a rounded card '
          'appearance with horizontal padding. This is the look used by '
          'modern iOS Settings screens. Background and margin can still '
          'be customized via decoration and margin parameters.',
        ),
        const SizedBox(height: 12),
        CupertinoFormSection.insetGrouped(
          header: const Text('ACCOUNT'),
          footer: const Text(
            'Inset grouped sections sit on the systemGroupedBackground '
            'fill with their content layered above as a rounded card.',
          ),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Apple ID'),
              placeholder: 'alexis@example.com',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Region'),
              placeholder: 'United Kingdom',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Plan'),
              placeholder: 'Developer Tier',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Storage'),
              placeholder: '184 GB of 200 GB',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Member'),
              placeholder: 'March 2018',
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('BILLING'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Card'),
              placeholder: 'Visa ending 4242',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Expires'),
              placeholder: '12 / 28',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('CVV'),
              placeholder: 'last 3',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Postal'),
              placeholder: 'SW1A 1AA',
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 4: Prefix variations
// ============================================================================

Widget _buildPrefixesSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          'Prefix Variations',
          CupertinoIcons.tag,
          const Color(0xFF34C759),
        ),
        const SizedBox(height: 8),
        _explanation(
          'The prefix slot of CupertinoFormRow / CupertinoTextFormFieldRow '
          'can be any widget. Common choices are short text labels, '
          'icons, or compact icon+text pairs that act as a column on the '
          'left side of every row.',
        ),
        const SizedBox(height: 12),
        CupertinoFormSection.insetGrouped(
          header: const Text('PREFIX: TEXT LABELS'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('First'),
              placeholder: 'Alexis',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Last'),
              placeholder: 'Kyaw',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Title'),
              placeholder: 'Senior Developer',
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('PREFIX: ICONS ONLY'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: _iconPrefix(
                CupertinoIcons.person_fill,
                const Color(0xFF007AFF),
              ),
              placeholder: 'Display name',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: _iconPrefix(
                CupertinoIcons.envelope_fill,
                const Color(0xFFFF9F0A),
              ),
              placeholder: 'Email address',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: _iconPrefix(
                CupertinoIcons.phone_fill,
                const Color(0xFF34C759),
              ),
              placeholder: 'Phone number',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: _iconPrefix(
                CupertinoIcons.location_fill,
                const Color(0xFFFF3B30),
              ),
              placeholder: 'Address',
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('PREFIX: ICON + TEXT'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: _iconLabelPrefix(
                CupertinoIcons.creditcard_fill,
                'Card',
                const Color(0xFFAF52DE),
              ),
              placeholder: 'Visa **** 4242',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: _iconLabelPrefix(
                CupertinoIcons.calendar,
                'Date',
                const Color(0xFF5E5CE6),
              ),
              placeholder: '12 / 28',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: _iconLabelPrefix(
                CupertinoIcons.lock_fill,
                'CVV',
                const Color(0xFFFF3B30),
              ),
              placeholder: 'last 3',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _iconPrefix(IconData icon, Color color) {
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Icon(icon, color: color, size: 18),
  );
}

Widget _iconLabelPrefix(IconData icon, String label, Color color) {
  return SizedBox(
    width: 80,
    child: Row(
      children: <Widget>[
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 5: Helpers and Errors
// ============================================================================

Widget _buildHelpersAndErrorsSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          'Helper and Error Texts',
          CupertinoIcons.exclamationmark_circle,
          const Color(0xFFFF3B30),
        ),
        const SizedBox(height: 8),
        _explanation(
          'CupertinoFormRow and CupertinoTextFormFieldRow expose `helper` '
          'and `error` slots. Helper text appears in subdued grey under '
          'the row content. When `error` is non-null it replaces the '
          'helper area with the error styling.',
        ),
        const SizedBox(height: 12),
        CupertinoFormSection.insetGrouped(
          header: const Text('CREATE PASSWORD'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Username'),
              placeholder: 'pick a unique handle',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Password'),
              placeholder: 'min 12 chars',
              obscureText: true,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Confirm'),
              placeholder: 'retype password',
              obscureText: true,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Recovery'),
              placeholder: 'recovery email',
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('VALIDATION STATES'),
          footer: const Text(
            'These rows showcase static states for visualization only.',
          ),
          children: <Widget>[
            const CupertinoFormRow(
              prefix: Text('Email'),
              helper: Text('We never share your address.'),
              child: Text(
                'alexis@example.com',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.right,
              ),
            ),
            const CupertinoFormRow(
              prefix: Text('Phone'),
              error: Text('Invalid phone number'),
              child: Text(
                '+44 nope',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFF3B30),
                ),
                textAlign: TextAlign.right,
              ),
            ),
            CupertinoFormRow(
              prefix: const Text('Status'),
              helper: const Text('Account in good standing.'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF34C759).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    color: Color(0xFF1F8A3F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            CupertinoFormRow(
              prefix: const Text('Quota'),
              error: const Text('Approaching storage limit'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9F0A).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '92%',
                  style: TextStyle(
                    color: Color(0xFFB36100),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 6: Keyboard Types
// ============================================================================

Widget _buildKeyboardTypesSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          'Keyboard Types',
          CupertinoIcons.keyboard,
          const Color(0xFF30B0C7),
        ),
        const SizedBox(height: 8),
        _explanation(
          'CupertinoTextFormFieldRow forwards the standard keyboardType '
          'parameter so each row can request the most ergonomic input '
          'method. These are visual only in this passive demo, but the '
          'declarations match production usage.',
        ),
        const SizedBox(height: 12),
        CupertinoFormSection.insetGrouped(
          header: const Text('CONTACT'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Name'),
              placeholder: 'Full name',
              keyboardType: TextInputType.name,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Email'),
              placeholder: 'name@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Phone'),
              placeholder: '+1 555 0100',
              keyboardType: TextInputType.phone,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('URL'),
              placeholder: 'https://example.com',
              keyboardType: TextInputType.url,
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('NUMERIC'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Quantity'),
              placeholder: 'integer',
              keyboardType: TextInputType.number,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Price'),
              placeholder: '0.00',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Delta'),
              placeholder: '-1.5',
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Postal'),
              placeholder: 'SW1A 1AA',
              keyboardType: TextInputType.streetAddress,
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('LONG-FORM TEXT'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Bio'),
              placeholder: 'A short description.',
              keyboardType: TextInputType.multiline,
              maxLines: 3,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Notes'),
              placeholder: 'Internal notes.',
              keyboardType: TextInputType.multiline,
              maxLines: 4,
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 7: Decoration Variants
// ============================================================================

Widget _buildDecorationVariantsSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          'Decoration & Background',
          CupertinoIcons.paintbrush_fill,
          const Color(0xFFFF9F0A),
        ),
        const SizedBox(height: 8),
        _explanation(
          'CupertinoFormSection accepts `decoration`, `backgroundColor`, '
          'and `margin`. These let you customize the section card '
          'independently of the iOS-style defaults. Below are three '
          'variants on the same content.',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFFFFFF),
                Color(0xFFF2F2F7),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x18000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CupertinoFormSection.insetGrouped(
            margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
            header: const Text('GRADIENT WRAPPER'),
            children: <Widget>[
              CupertinoTextFormFieldRow(
                controller: null,
                validator: null,
                prefix: const Text('Project'),
                placeholder: 'Tom Forge',
              ),
              CupertinoTextFormFieldRow(
                controller: null,
                validator: null,
                prefix: const Text('Owner'),
                placeholder: 'Alexis Kyaw',
              ),
              CupertinoTextFormFieldRow(
                controller: null,
                validator: null,
                prefix: const Text('Status'),
                placeholder: 'In review',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'DARK PANEL WITH FORM',
                style: TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 12,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x44000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                child: Column(
                  children: <Widget>[
                    _darkRow('Server', 'tom.example.com'),
                    _darkDivider(),
                    _darkRow('Port', '443'),
                    _darkDivider(),
                    _darkRow('Protocol', 'HTTPS'),
                    _darkDivider(),
                    _darkRow('Auth', 'OAuth2'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFFFD60A),
              width: 1.5,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33FFD60A),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(4),
          child: CupertinoFormSection.insetGrouped(
            backgroundColor: Color(0x00000000),
            header: const Text('AMBER ACCENT'),
            footer: const Text(
              'A custom backgroundColor lets the section blend into a '
              'tinted card outside it.',
            ),
            children: <Widget>[
              CupertinoTextFormFieldRow(
                controller: null,
                validator: null,
                prefix: const Text('Tag'),
                placeholder: 'priority',
              ),
              CupertinoTextFormFieldRow(
                controller: null,
                validator: null,
                prefix: const Text('Color'),
                placeholder: 'amber',
              ),
              CupertinoTextFormFieldRow(
                controller: null,
                validator: null,
                prefix: const Text('Pinned'),
                placeholder: 'yes',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _darkRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFFAEAEB2),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 16,
              fontFamily: 'Menlo',
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

Widget _darkDivider() {
  return Container(
    height: 1,
    color: const Color(0xFF3A3A3C),
  );
}

// ============================================================================
// Section 8: Long Form (scroll demonstration)
// ============================================================================

Widget _buildLongFormSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          'Long Form (Scroll Demo)',
          CupertinoIcons.arrow_up_arrow_down_circle,
          const Color(0xFF5E5CE6),
        ),
        const SizedBox(height: 8),
        _explanation(
          'A real registration form often spans many sections. The outer '
          'ListView is what makes the whole layout scrollable. Each '
          'CupertinoFormSection is a regular widget child of the list, '
          'so it can be reordered, hidden, or repeated freely.',
        ),
        const SizedBox(height: 12),
        CupertinoFormSection.insetGrouped(
          header: const Text('PERSONAL DETAILS'),
          footer: const Text('All fields are optional in this passive demo.'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Title'),
              placeholder: 'Mr / Ms / Mx / Dr',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('First'),
              placeholder: 'Alexis',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Middle'),
              placeholder: 'optional',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Last'),
              placeholder: 'Kyaw',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Suffix'),
              placeholder: 'Jr / Sr / III',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('DOB'),
              placeholder: '1990-01-01',
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('CONTACT'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Email'),
              placeholder: 'name@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Mobile'),
              placeholder: '+1 555 0100',
              keyboardType: TextInputType.phone,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Home'),
              placeholder: '+1 555 0102',
              keyboardType: TextInputType.phone,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Work'),
              placeholder: '+1 555 0104',
              keyboardType: TextInputType.phone,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Fax'),
              placeholder: 'optional',
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('ADDRESS'),
          footer: const Text(
            'Street and city are required for billing destinations. '
            'These fields are illustrative.',
          ),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Line 1'),
              placeholder: '10 Downing Street',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Line 2'),
              placeholder: 'Apt 4B',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('City'),
              placeholder: 'London',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('State'),
              placeholder: 'Greater London',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Postal'),
              placeholder: 'SW1A 2AA',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Country'),
              placeholder: 'United Kingdom',
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('PROFESSIONAL'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Company'),
              placeholder: 'Tom Industries',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Position'),
              placeholder: 'Senior Developer',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Years'),
              placeholder: '10+',
              keyboardType: TextInputType.number,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Industry'),
              placeholder: 'Software',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('LinkedIn'),
              placeholder: 'linkedin.com/in/...',
              keyboardType: TextInputType.url,
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('PREFERENCES'),
          footer: const Text(
            'Preferences influence content recommendations and digest '
            'cadence in the production app.',
          ),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Lang'),
              placeholder: 'English (UK)',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Region'),
              placeholder: 'United Kingdom',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Tz'),
              placeholder: 'Europe / London',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Theme'),
              placeholder: 'System',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Digest'),
              placeholder: 'Weekly',
            ),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoFormSection.insetGrouped(
          header: const Text('SECURITY'),
          children: <Widget>[
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Q1'),
              placeholder: 'First pet?',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('A1'),
              placeholder: 'answer',
              obscureText: true,
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('Q2'),
              placeholder: 'Childhood city?',
            ),
            CupertinoTextFormFieldRow(
              controller: null,
              validator: null,
              prefix: const Text('A2'),
              placeholder: 'answer',
              obscureText: true,
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 9: Anatomy Diagram
// ============================================================================

Widget _buildAnatomyDiagram() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          'Anatomy of a CupertinoFormSection',
          CupertinoIcons.square_stack_3d_up,
          const Color(0xFF00C7BE),
        ),
        const SizedBox(height: 8),
        _explanation(
          'A CupertinoFormSection is composed of an optional header, a '
          'rounded card containing the children separated by hairline '
          'dividers, and an optional footer. Each child is typically a '
          'CupertinoFormRow or CupertinoTextFormFieldRow.',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFFFFFF),
                Color(0xFFF2F2F7),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _anatomyLabel('header', const Color(0xFFAF52DE)),
              const SizedBox(height: 4),
              _anatomyHeader('SECTION TITLE'),
              const SizedBox(height: 8),
              _anatomyLabel('children (rounded card)', const Color(0xFF007AFF)),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E5EA)),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    _anatomyRow('prefix', 'child', const Color(0xFF34C759)),
                    _anatomyDivider(),
                    _anatomyRow(
                      'prefix',
                      'child',
                      const Color(0xFF34C759),
                      helper: 'helper',
                    ),
                    _anatomyDivider(),
                    _anatomyRow(
                      'prefix',
                      'child',
                      const Color(0xFF34C759),
                      error: 'error',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              _anatomyDividerLabel('hairline dividers'),
              const SizedBox(height: 8),
              _anatomyLabel('footer', const Color(0xFFFF9F0A)),
              const SizedBox(height: 4),
              _anatomyFooter(
                'Plain explanatory text rendered under the section card.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyLabel(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _anatomyHeader(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 2),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF6D6D72),
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _anatomyFooter(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 4, top: 2),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF6D6D72),
        fontSize: 12,
        height: 1.45,
      ),
    ),
  );
}

Widget _anatomyDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.only(left: 70),
    color: const Color(0xFFE5E5EA),
  );
}

Widget _anatomyDividerLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 4, top: 2),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF8E8E93),
        fontSize: 10,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

Widget _anatomyRow(
  String prefixLabel,
  String childLabel,
  Color color, {
  String? helper,
  String? error,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.18),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                prefixLabel,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF007AFF).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  childLabel,
                  style: const TextStyle(
                    color: Color(0xFF007AFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
        if (helper != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              helper,
              style: const TextStyle(
                color: Color(0xFF8E8E93),
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              error,
              style: const TextStyle(
                color: Color(0xFFFF3B30),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// Section 10: Scroll Anatomy Card
// ============================================================================

Widget _buildScrollAnatomyCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          'Scrolling Long Forms',
          CupertinoIcons.arrow_down_doc,
          const Color(0xFFFF2D55),
        ),
        const SizedBox(height: 8),
        _explanation(
          'A long form is most often hosted in a ListView, '
          'CustomScrollView, or SingleChildScrollView. The Cupertino '
          'form widgets do not scroll themselves, they sit inside the '
          'scrollable parent.',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFFEFEF),
                Color(0xFFFFE0EF),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFFF2D55).withOpacity(0.3),
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x22FF2D55),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _scrollPattern(
                'ListView',
                'children: <Widget>[ Section, Section, Section ]',
                CupertinoIcons.list_bullet,
                const Color(0xFFFF2D55),
              ),
              const SizedBox(height: 8),
              _scrollPattern(
                'CustomScrollView',
                'slivers: <Widget>[ SliverToBoxAdapter(child: Section) ]',
                CupertinoIcons.square_grid_2x2,
                const Color(0xFFAF52DE),
              ),
              const SizedBox(height: 8),
              _scrollPattern(
                'SingleChildScrollView',
                'child: Column(children: <Widget>[ Section, ... ])',
                CupertinoIcons.square_arrow_down,
                const Color(0xFF007AFF),
              ),
              const SizedBox(height: 8),
              _scrollPattern(
                'CupertinoPageScaffold',
                'child: <ScrollableWidget> with SafeArea',
                CupertinoIcons.rectangle_stack,
                const Color(0xFF34C759),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E5EA)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x10000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Scroll Composition Tips',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C1C1E),
                ),
              ),
              SizedBox(height: 6),
              _Bullet(
                'Use ListView for the simplest case: a finite list of '
                'CupertinoFormSection widgets.',
              ),
              _Bullet(
                'Use CustomScrollView when you need pinned headers, '
                'sliver app bars, or pull-to-refresh.',
              ),
              _Bullet(
                'Wrap the whole thing in SafeArea so the form does not '
                'collide with the navigation bar or home indicator.',
              ),
              _Bullet(
                'Set a sensible padding on the outer scrollable, not on '
                'each individual section.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _scrollPattern(
  String name,
  String snippet,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: CupertinoColors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.18),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                snippet,
                style: const TextStyle(
                  color: Color(0xFF3C3C43),
                  fontSize: 11,
                  fontFamily: 'Menlo',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section 11: Usage Guide
// ============================================================================

Widget _buildUsageGuide() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          'Usage Guide',
          CupertinoIcons.book,
          const Color(0xFF8E8E93),
        ),
        const SizedBox(height: 8),
        _explanation(
          'Practical guidance for choosing between flat and inset '
          'grouped sections, when to reach for CupertinoFormRow vs. '
          'CupertinoTextFormFieldRow, and how to keep long forms '
          'maintainable.',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFFFFFFFF),
                Color(0xFFF7F7FB),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE5E5EA)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x10000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _guideEntry(
                'Choose insetGrouped for Settings-style screens',
                'The rounded card style is the modern iOS default. '
                'Reach for the flat constructor only when you need full '
                'bleed dividers across the screen.',
                CupertinoIcons.checkmark_seal_fill,
                const Color(0xFF007AFF),
              ),
              _guideDivider(),
              _guideEntry(
                'CupertinoFormRow for non-text rows',
                'Use CupertinoFormRow when the right-hand widget is a '
                'switch, a picker, a static value, or a custom widget. '
                'Pair with prefix and helper / error slots.',
                CupertinoIcons.slider_horizontal_3,
                const Color(0xFF34C759),
              ),
              _guideDivider(),
              _guideEntry(
                'CupertinoTextFormFieldRow for text input',
                'CupertinoTextFormFieldRow bundles a Cupertino text '
                'field, prefix, helper, error, and form-state into one '
                'row. Use it for the typical name / email / phone case.',
                CupertinoIcons.textformat,
                const Color(0xFFAF52DE),
              ),
              _guideDivider(),
              _guideEntry(
                'Keep prefix widths consistent',
                'Wrap prefix labels in a SizedBox of the same width '
                'across rows so the right-hand inputs line up. This is '
                'the most visible polish detail in iOS forms.',
                CupertinoIcons.rectangle_grid_1x2,
                const Color(0xFFFF9F0A),
              ),
              _guideDivider(),
              _guideEntry(
                'Helper and error are mutually exclusive in spirit',
                'Both slots can render simultaneously, but the iOS '
                'convention is to show helper text in calm states and '
                'replace it with error text only when validation fails.',
                CupertinoIcons.exclamationmark_circle,
                const Color(0xFFFF3B30),
              ),
              _guideDivider(),
              _guideEntry(
                'Compose sections, do not nest forms',
                'A long form is built as several CupertinoFormSection '
                'widgets in a ListView, not as a single section with '
                'twenty rows. Smaller sections are easier to scan, '
                'faster to validate, and align with iOS conventions.',
                CupertinoIcons.square_stack,
                const Color(0xFF5E5CE6),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _guideEntry(
  String title,
  String body,
  IconData icon,
  Color color,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            borderRadius: BorderRadius.circular(8),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1C1C1E),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: Color(0xFF3C3C43),
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _guideDivider() {
  return Container(
    height: 1,
    color: const Color(0xFFE5E5EA),
  );
}

// ============================================================================
// Shared helpers
// ============================================================================

Widget _sectionTitle(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Row(
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                color,
                color.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withOpacity(0.35),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: CupertinoColors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1C1C1E),
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _explanation(String text) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE5E5EA)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(
          CupertinoIcons.info_circle_fill,
          color: Color(0xFF007AFF),
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFF333333),
            ),
          ),
        ),
      ],
    ),
  );
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 5, right: 8),
            child: Icon(
              CupertinoIcons.circle_fill,
              size: 5,
              color: Color(0xFF8E8E93),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Color(0xFF3C3C43),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Material Icons reference — Icons.list_alt is used as the leading icon for
// the small reference badge below, so the material import has a live use.
Widget buildMaterialReferenceBadge() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0xFFEFEFF4),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.list_alt, size: 14, color: Color(0xFF8E8E93)),
        SizedBox(width: 6),
        Text(
          'Reference badge',
          style: TextStyle(
            color: Color(0xFF3C3C43),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
