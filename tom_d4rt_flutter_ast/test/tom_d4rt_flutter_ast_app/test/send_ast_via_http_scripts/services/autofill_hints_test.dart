// ignore_for_file: avoid_print
// D4rt deep demo: AutofillHints — The Complete Hint Catalog
// Demonstrates every category of autofill hint available in Flutter, how they
// map to platform constants, and when to use each one.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Crimson / Ruby palette ───
  const Color crimson = Color(0xFFDC143C);
  const Color ruby = Color(0xFFE0115F);
  const Color garnet = Color(0xFF9B111E);
  const Color rosePink = Color(0xFFFFE4E8);
  const Color burgundy = Color(0xFF800020);
  const Color scarlet = Color(0xFFFF2400);
  const Color wine = Color(0xFF722F37);
  const Color blush = Color(0xFFFFF0F2);
  const Color deepRed = Color(0xFF8B0000);
  const Color coral = Color(0xFFFF6F61);

  print('[ah] ===== AUTOFILL HINTS DEEP DEMO =====');

  // ─── Helpers declared before use ───

  Widget ahBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [burgundy, crimson],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: burgundy.withValues(alpha: 0.35),
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
              color: deepRed,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: coral, width: 1.5),
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

  Widget ahNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: blush,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: rosePink),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: wine.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget ahCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: rosePink.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: crimson, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: burgundy,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: wine)),
          ),
        ],
      ),
    );
  }

  Widget ahCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: rosePink.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: burgundy.withValues(alpha: 0.06),
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
              color: crimson.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: burgundy)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget ahRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? crimson.withValues(alpha: 0.05) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: rosePink.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? burgundy : wine)),
          );
        }).toList(),
      ),
    );
  }

  Widget ahHintEntry(String hint, String desc, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hint,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                          color: color)),
                  Text(desc,
                      style: TextStyle(fontSize: 10, color: wine)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ━━━━━━ SECTION 1: What are autofill hints? ━━━━━━
  print('[ah-01] Section 1: What are autofill hints?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('01', 'What Are AutofillHints?'),
      ahNote(
        'AutofillHints are string constants that tell the platform\'s autofill '
        'service what type of data a text field expects. When you set '
        'autofillHints on a TextField, the platform knows to suggest an email, '
        'password, phone number, or address from saved data. Without hints, '
        'the platform guesses or ignores the field.',
      ),
      ahCard(
        'How Hints Work',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: rosePink.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.edit, color: crimson, size: 28),
                        const SizedBox(height: 6),
                        Text('TextField',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: burgundy)),
                        Text('autofillHints:\n[AutofillHints.email]',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                fontFamily: 'monospace',
                                color: wine)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Icon(Icons.arrow_forward, color: crimson, size: 16),
                      Text('hint', style: TextStyle(fontSize: 8, color: wine)),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: garnet.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.auto_awesome, color: garnet, size: 28),
                        const SizedBox(height: 6),
                        Text('Platform Service',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: garnet)),
                        Text('Suggests matching\nsaved emails',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 9, color: wine)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ahRow(['Aspect', 'Detail'], isHeader: true),
            ahRow(['Type', 'List<String>']),
            ahRow(['Source', 'AutofillHints class (60+ constants)']),
            ahRow(['Platform', 'Maps to native hint values']),
            ahRow(['Multiple', 'Can specify multiple hints per field']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Credential hints ━━━━━━
  print('[ah-02] Section 2: Credential hints');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('02', 'Credential Hints — Login & Passwords'),
      ahNote(
        'Credential hints cover usernames, passwords, and authentication-related '
        'data. These are the most commonly used hints and directly trigger '
        'platform password managers like Google Password Manager or iCloud Keychain.',
      ),
      ahCard(
        'Authentication Hints',
        Column(
          children: [
            ahHintEntry('username', 'User\'s account identifier',
                Icons.person, crimson),
            ahHintEntry('password', 'Current password (sign in)',
                Icons.lock, burgundy),
            ahHintEntry('newPassword', 'Password during registration',
                Icons.lock_open, garnet),
            ahHintEntry('email', 'Email address (often used as username)',
                Icons.email, ruby),
            ahHintEntry('oneTimeCode', 'OTP / verification code',
                Icons.pin, scarlet),
          ],
        ),
      ),
      ahCard(
        'password vs newPassword',
        Column(
          children: [
            ahRow(['Hint', 'Use Case', 'Platform Behavior'], isHeader: true),
            ahRow(['password', 'Login form', 'Offers saved passwords']),
            ahRow(['newPassword', 'Registration', 'Offers to generate + save']),
            ahRow(['Both', 'Change password', 'Old field + new field']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Identity hints ━━━━━━
  print('[ah-03] Section 3: Identity hints');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('03', 'Identity Hints — Name & Personal'),
      ahNote(
        'Identity hints cover personal information — names, birthdays, and '
        'gender. These help autofill profile and registration forms.',
      ),
      ahCard(
        'Name Hints',
        Column(
          children: [
            ahHintEntry('name', 'Full name', Icons.badge, crimson),
            ahHintEntry('givenName', 'First name', Icons.person_outline, burgundy),
            ahHintEntry('familyName', 'Last name / surname', Icons.people, garnet),
            ahHintEntry('middleName', 'Middle name', Icons.person, wine),
            ahHintEntry('namePrefix', 'Mr., Mrs., Dr.', Icons.title, ruby),
            ahHintEntry('nameSuffix', 'Jr., III, PhD', Icons.short_text, scarlet),
            ahHintEntry('nickname', 'Preferred / display name', Icons.face, coral),
          ],
        ),
      ),
      ahCard(
        'Personal Hints',
        Column(
          children: [
            ahHintEntry('birthday', 'Date of birth', Icons.cake, crimson),
            ahHintEntry('birthdayDay', 'Birth day (1-31)', Icons.event, burgundy),
            ahHintEntry('birthdayMonth', 'Birth month (1-12)', Icons.date_range, garnet),
            ahHintEntry('birthdayYear', 'Birth year (YYYY)', Icons.calendar_today, wine),
            ahHintEntry('gender', 'Gender identity', Icons.wc, ruby),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Address hints ━━━━━━
  print('[ah-04] Section 4: Address hints');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('04', 'Address Hints — Location & Postal'),
      ahNote(
        'Address hints cover all parts of a physical address. These are commonly '
        'used in shipping forms, billing fields, and registration. All address '
        'fields in a form should be in the same AutofillGroup.',
      ),
      ahCard(
        'Address Hint Catalog',
        Column(
          children: [
            ahHintEntry('fullStreetAddress', 'Complete street address',
                Icons.home, crimson),
            ahHintEntry('streetAddressLine1', 'Primary street address',
                Icons.location_on, burgundy),
            ahHintEntry('streetAddressLine2', 'Apt, suite, unit',
                Icons.apartment, garnet),
            ahHintEntry('streetAddressLine3', 'Additional address info',
                Icons.add_location, wine),
            ahHintEntry('addressCity', 'City name',
                Icons.location_city, crimson),
            ahHintEntry('addressCityAndLocality', 'City + district',
                Icons.map, ruby),
            ahHintEntry('addressState', 'State or province',
                Icons.flag, scarlet),
            ahHintEntry('postalCode', 'ZIP / postal code',
                Icons.pin_drop, burgundy),
            ahHintEntry('postalCodeExtended', 'Extended ZIP (ZIP+4)',
                Icons.more, garnet),
            ahHintEntry('countryCode', 'ISO country code',
                Icons.public, wine),
            ahHintEntry('countryName', 'Full country name',
                Icons.language, coral),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Phone & communication hints ━━━━━━
  print('[ah-05] Section 5: Phone & communication');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('05', 'Phone & Communication Hints'),
      ahNote(
        'Communication hints cover phone numbers (with various formats) and '
        'related contact information. Flutter provides granular hints for '
        'different phone number components.',
      ),
      ahCard(
        'Phone Number Hints',
        Column(
          children: [
            ahHintEntry('telephoneNumber', 'Full phone number',
                Icons.phone, crimson),
            ahHintEntry('telephoneNumberCountryCode', 'Country calling code (+1, +44)',
                Icons.flag, burgundy),
            ahHintEntry('telephoneNumberNational', 'National number without country',
                Icons.phone_android, garnet),
            ahHintEntry('telephoneNumberLocal', 'Local number without area code',
                Icons.phone_in_talk, wine),
            ahHintEntry('telephoneNumberLocalPrefix', 'First part of local number',
                Icons.call, ruby),
            ahHintEntry('telephoneNumberLocalSuffix', 'Second part of local number',
                Icons.call_end, scarlet),
            ahHintEntry('telephoneNumberDevice', 'This device\'s phone number',
                Icons.smartphone, coral),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Financial hints ━━━━━━
  print('[ah-06] Section 6: Financial hints');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('06', 'Financial Hints — Cards & Banking'),
      ahNote(
        'Financial hints are used for payment forms. These trigger the platform\'s '
        'saved card information. Security-sensitive fields like CVV and expiry '
        'require careful handling.',
      ),
      ahCard(
        'Credit Card Hints',
        Column(
          children: [
            ahHintEntry('creditCardNumber', 'Full card number (16 digits)',
                Icons.credit_card, crimson),
            ahHintEntry('creditCardName', 'Name on card',
                Icons.badge, burgundy),
            ahHintEntry('creditCardFamilyName', 'Cardholder last name',
                Icons.person, garnet),
            ahHintEntry('creditCardGivenName', 'Cardholder first name',
                Icons.person_outline, wine),
            ahHintEntry('creditCardMiddleName', 'Cardholder middle name',
                Icons.account_circle, ruby),
            ahHintEntry('creditCardExpirationDate', 'Full expiry (MM/YY)',
                Icons.event, scarlet),
            ahHintEntry('creditCardExpirationMonth', 'Expiry month (01-12)',
                Icons.date_range, coral),
            ahHintEntry('creditCardExpirationYear', 'Expiry year (YYYY)',
                Icons.calendar_today, crimson),
            ahHintEntry('creditCardExpirationDay', 'Expiry day (rare)',
                Icons.today, burgundy),
            ahHintEntry('creditCardSecurityCode', 'CVV / CVC code',
                Icons.security, garnet),
            ahHintEntry('creditCardType', 'Card network (Visa, MC, etc.)',
                Icons.payment, wine),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: URL & web hints ━━━━━━
  print('[ah-07] Section 7: URL & web hints');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('07', 'URL & Web Hints'),
      ahNote(
        'Web-related hints cover URLs, IMPP handles, and photo URLs. '
        'These are less commonly used but important for social media '
        'profiles and contact management.',
      ),
      ahCard(
        'Web & URL Hints',
        Column(
          children: [
            ahHintEntry('url', 'Website URL',
                Icons.link, crimson),
            ahHintEntry('photo', 'Profile photo URL',
                Icons.photo, burgundy),
            ahHintEntry('impp', 'Instant messaging handle',
                Icons.chat, garnet),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Job & organization hints ━━━━━━
  print('[ah-08] Section 8: Job & organization');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('08', 'Job & Organization Hints'),
      ahNote(
        'Professional hints cover job-related information: title, '
        'organization name, and other workplace details.',
      ),
      ahCard(
        'Professional Hints',
        Column(
          children: [
            ahHintEntry('jobTitle', 'Job title / position',
                Icons.work, crimson),
            ahHintEntry('organizationName', 'Company or org name',
                Icons.business, burgundy),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Platform mapping ━━━━━━
  print('[ah-09] Section 9: Platform mapping');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('09', 'Platform-Specific Hint Mapping'),
      ahNote(
        'Each Flutter hint maps to platform-specific constants. Android uses '
        'the Autofill Framework hint constants, iOS uses UITextContentType, '
        'and web uses HTML autocomplete attributes. Not all hints are supported '
        'on all platforms.',
      ),
      ahCard(
        'Key Hint Mappings',
        Column(
          children: [
            ahRow(['Flutter', 'Android', 'iOS', 'Web'], isHeader: true),
            ahRow(['email', 'emailAddress', 'emailAddress', 'email']),
            ahRow(['password', 'password', 'password', 'current-password']),
            ahRow(['newPassword', 'newPassword', 'newPassword', 'new-password']),
            ahRow(['username', 'username', 'username', 'username']),
            ahRow(['name', 'personName', 'name', 'name']),
            ahRow(['phone', 'phoneNumber', 'telephoneNumber', 'tel']),
            ahRow(['postalCode', 'postalCode', 'postalCode', 'postal-code']),
            ahRow(['creditCardNumber', 'creditCardNumber', 'creditCardNumber', 'cc-number']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Multiple hints ━━━━━━
  print('[ah-10] Section 10: Multiple hints per field');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('10', 'Multiple Hints Per Field'),
      ahNote(
        'A field can accept multiple hints. This increases the chance the '
        'platform will match the field. For example, a username field might '
        'accept both username and email. The platform uses the most specific '
        'match available.',
      ),
      ahCard(
        'Multi-Hint Patterns',
        Column(
          children: [
            ahRow(['Field', 'Hints', 'Rationale'], isHeader: true),
            ahRow(['Login', 'username, email', 'Could be either']),
            ahRow(['Contact', 'telephoneNumber, telephoneNumberNational',
                'Flexibility']),
            ahRow(['Name', 'name, givenName', 'Full or first']),
          ],
        ),
      ),
      ahCard(
        'Platform Priority',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ahCode('First hint', 'Has highest priority on most platforms'),
            ahCode('Subsequent', 'Used as fallback if first doesn\'t match'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Hint categories visualization ━━━━━━
  print('[ah-11] Section 11: Categories visualization');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('11', 'Hint Categories — Visual Map'),
      ahCard(
        'All AutofillHints by Category',
        Column(
          children: [
            _ahCategoryBar('Credentials', 5, crimson),
            const SizedBox(height: 6),
            _ahCategoryBar('Names', 7, burgundy),
            const SizedBox(height: 6),
            _ahCategoryBar('Personal', 5, garnet),
            const SizedBox(height: 6),
            _ahCategoryBar('Address', 11, wine),
            const SizedBox(height: 6),
            _ahCategoryBar('Phone', 7, ruby),
            const SizedBox(height: 6),
            _ahCategoryBar('Financial', 11, scarlet),
            const SizedBox(height: 6),
            _ahCategoryBar('Web/URL', 3, coral),
            const SizedBox(height: 6),
            _ahCategoryBar('Professional', 2, deepRed),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: rosePink.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('Total: 51+ distinct AutofillHints constants',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: burgundy)),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Common form recipes ━━━━━━
  print('[ah-12] Section 12: Form recipes');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('12', 'Common Form Recipes'),
      ahNote(
        'Practical autofill hint combinations for common form types. Each '
        'recipe shows which hints to use and how to group them.',
      ),
      ahCard(
        'Login Form',
        Column(
          children: [
            _ahRecipeField('Email / Username', '[email, username]', crimson),
            _ahRecipeField('Password', '[password]', burgundy),
          ],
        ),
      ),
      ahCard(
        'Registration Form',
        Column(
          children: [
            _ahRecipeField('Full Name', '[name]', crimson),
            _ahRecipeField('Email', '[email]', burgundy),
            _ahRecipeField('Phone', '[telephoneNumber]', garnet),
            _ahRecipeField('New Password', '[newPassword]', wine),
          ],
        ),
      ),
      ahCard(
        'Checkout / Payment Form',
        Column(
          children: [
            _ahRecipeField('Card Number', '[creditCardNumber]', crimson),
            _ahRecipeField('Name on Card', '[creditCardName]', burgundy),
            _ahRecipeField('Expiry', '[creditCardExpirationDate]', garnet),
            _ahRecipeField('CVV', '[creditCardSecurityCode]', wine),
            _ahRecipeField('Billing ZIP', '[postalCode]', ruby),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Keyboard type pairing ━━━━━━
  print('[ah-13] Section 13: Keyboard pairing');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('13', 'Hint + Keyboard Type Pairing'),
      ahNote(
        'For the best user experience, pair autofill hints with the correct '
        'keyboard type. A phone number hint with a numeric keyboard, an email '
        'hint with an email keyboard, etc.',
      ),
      ahCard(
        'Recommended Pairings',
        Column(
          children: [
            ahRow(['Hint', 'KeyboardType', 'Why'], isHeader: true),
            ahRow(['email', 'emailAddress', '@ and .com keys']),
            ahRow(['telephoneNumber', 'phone', 'Numeric pad']),
            ahRow(['postalCode', 'number', 'Digits only (many countries)']),
            ahRow(['url', 'url', '.com and / keys']),
            ahRow(['creditCardNumber', 'number', 'Digits only']),
            ahRow(['oneTimeCode', 'number', 'Numeric codes']),
            ahRow(['password', 'visiblePassword', 'Show password option']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Platform-specific behavior ━━━━━━
  print('[ah-14] Section 14: Platform behavior');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('14', 'Platform-Specific Behavior'),
      ahNote(
        'Each platform implements autofill differently. Android has a pluggable '
        'autofill service architecture. iOS uses built-in Keychain and iCloud. '
        'Web delegates to the browser. These differences affect hint behavior.',
      ),
      ahCard(
        'Platform Autofill Differences',
        Column(
          children: [
            ahRow(['Feature', 'Android', 'iOS', 'Web'], isHeader: true),
            ahRow(['Service', 'Pluggable', 'Built-in', 'Browser']),
            ahRow(['3rd party', 'Yes (1Password, etc.)', 'Yes (iOS 12+)', 'Extensions']),
            ahRow(['OTP from SMS', 'API based', 'Automatic', 'No']),
            ahRow(['Password gen', 'Service dep.', 'Strong passwords', 'Browser']),
            ahRow(['Save prompt', 'After commit', 'After commit', 'Browser UI']),
            ahRow(['Inline suggest', 'Android 11+', 'Keyboard bar', 'Dropdown']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Troubleshooting hints ━━━━━━
  print('[ah-15] Section 15: Troubleshooting');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('15', 'Troubleshooting Hint Issues'),
      ahNote(
        'When autofill hints don\'t work as expected, common causes include '
        'missing AutofillGroup, wrong hint values, or platform service issues.',
      ),
      ahCard(
        'Common Issues',
        Column(
          children: [
            _ahTroubleshoot('No suggestions appear',
                'Check AutofillGroup wrapping; verify hints are correct',
                Icons.not_interested, crimson),
            _ahTroubleshoot('Wrong data suggested',
                'Use more specific hints; check hint order (first = primary)',
                Icons.swap_horiz, burgundy),
            _ahTroubleshoot('Suggestions appear but don\'t fill',
                'Verify TextEditingController is not overriding values',
                Icons.block, garnet),
            _ahTroubleshoot('Works on Android but not iOS',
                'Some hints are Android-specific; check iOS mapping',
                Icons.phone_android, wine),
            _ahTroubleshoot('Web form not saving',
                'Ensure autocomplete mapping is correct; check HTTPS',
                Icons.web, ruby),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[ah-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ahBanner('16', 'Summary Dashboard'),
      ahCard(
        'AutofillHints System — Complete',
        Column(
          children: [
            ahRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            ahRow(['Concept', 'S01', 'Semantic hints for platform autofill']),
            ahRow(['Credentials', 'S02', 'username, password, newPassword']),
            ahRow(['Identity', 'S03', 'name, givenName, birthday, gender']),
            ahRow(['Address', 'S04', 'street, city, state, postal, country']),
            ahRow(['Phone', 'S05', '7 phone-related hints']),
            ahRow(['Financial', 'S06', '11 credit card hints']),
            ahRow(['Web/URL', 'S07', 'url, photo, impp']),
            ahRow(['Professional', 'S08', 'jobTitle, organizationName']),
            ahRow(['Mapping', 'S09', 'Flutter → Android/iOS/Web']),
            ahRow(['Multiple', 'S10', 'Multiple hints increase matching']),
            ahRow(['Categories', 'S11', '51+ hints across 8 categories']),
            ahRow(['Recipes', 'S12', 'Login, registration, payment']),
            ahRow(['Keyboards', 'S13', 'Pair hints with input types']),
            ahRow(['Platforms', 'S14', 'Android/iOS/Web differences']),
            ahRow(['Troubleshoot', 'S15', 'Common hint failures & fixes']),
          ],
        ),
      ),
      ahCard(
        'Crimson / Ruby Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ahColorSwatch('Crimson', crimson),
            _ahColorSwatch('Ruby', ruby),
            _ahColorSwatch('Garnet', garnet),
            _ahColorSwatch('Burgundy', burgundy),
            _ahColorSwatch('Coral', coral),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [burgundy, crimson],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('AutofillHints — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From credentials to credit cards, identity to addresses — '
              'the complete catalog of 51+ autofill hints with platform '
              'mapping, form recipes, and troubleshooting.',
              style: TextStyle(color: rosePink, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[ah] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AutofillHints — Complete Hint Catalog'),
        backgroundColor: burgundy,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFF5F7),
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

Widget _ahCategoryBar(String category, int count, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 90,
        child: Text(category,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color)),
      ),
      Expanded(
        child: Stack(
          children: [
            Container(
              height: 18,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            FractionallySizedBox(
              widthFactor: count / 12.0,
              child: Container(
                height: 18,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Text('$count',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _ahRecipeField(String label, String hints, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600, color: color)),
          ),
          Text(hints,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: const Color(0xFF722F37))),
        ],
      ),
    ),
  );
}

Widget _ahTroubleshoot(String issue, String fix, IconData icon, Color color) {
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
              Text(issue,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(fix,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF722F37))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _ahColorSwatch(String name, Color color) {
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
