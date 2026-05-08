// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: AutofillGroup, AutofillHints, AutofillConfiguration,
// AutofillContextAction, AutofillScope demonstration.
// Deep Demo: a Notary Public's filing-cabinet — manilla folders, brass tabs,
// rubber stamps and a hint vocabulary that tells the platform autofill service
// which document goes in which drawer.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('AutofillContext Deep Demo executing — opening the filing cabinet');

  // Manilla / parchment palette used everywhere
  final manilla = Color(0xFFF1E1B5);
  final manillaDark = Color(0xFFD9C28A);
  final inkBlue = Color(0xFF1B3A6B);
  final stampRed = Color(0xFFB23030);
  final stampGreen = Color(0xFF2E6B3F);
  final cabinetBronze = Color(0xFF8B6F3D);
  final cabinetShadow = Color(0xFF3A2E18);
  final brass = Color(0xFFB89B5E);
  final parchment = Color(0xFFFBF4DC);

  // ============================================================
  // SECTION 1: Cabinet header / brass nameplate
  // ============================================================
  print('=== Section 1: Cabinet Header ===');

  final cabinetHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cabinetBronze, cabinetShadow],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: brass, width: 3.0),
      boxShadow: [
        BoxShadow(
          color: cabinetShadow.withValues(alpha: 0.6),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.account_balance, size: 56.0, color: brass),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [brass, Color(0xFFE2C677)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: cabinetShadow.withValues(alpha: 0.5),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            'BUREAU OF AUTOFILL',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: cabinetShadow,
              letterSpacing: 3.0,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Filing Cabinet — Records Division',
          style: TextStyle(
            fontSize: 14.0,
            color: brass,
            fontStyle: FontStyle.italic,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            border: Border.all(color: brass, width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'AutofillGroup · AutofillHints · AutofillConfiguration',
            style: TextStyle(
              fontSize: 11.0,
              color: brass,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
  print('Brass nameplate cast');

  // ============================================================
  // SECTION 2: Cabinet anatomy — Scope → Group → Client hierarchy
  // ============================================================
  print('=== Section 2: Cabinet Anatomy ===');

  final cabinetAnatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [parchment, manilla],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: cabinetBronze, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: cabinetShadow.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Cabinet Anatomy',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'AutofillScope → AutofillGroup → AutofillClient',
          style: TextStyle(
            fontSize: 12.0,
            color: cabinetBronze,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 18.0),
        // Cabinet (Scope)
        _buildAnatomyLayer(
          'AutofillScope',
          'The cabinet itself — owns the autofill context',
          Icons.account_balance,
          cabinetBronze,
          540.0,
        ),
        SizedBox(height: 8.0),
        Icon(Icons.arrow_downward, color: cabinetBronze, size: 24.0),
        SizedBox(height: 8.0),
        // Drawers (Groups)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnatomyLayer(
              'AutofillGroup',
              'A drawer of related fields',
              Icons.folder,
              Color(0xFFB07A2A),
              260.0,
            ),
            SizedBox(width: 12.0),
            _buildAnatomyLayer(
              'AutofillGroup',
              'Another drawer (sign-up vs. checkout)',
              Icons.folder,
              Color(0xFFB07A2A),
              260.0,
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Icon(Icons.arrow_downward, color: cabinetBronze, size: 24.0),
        SizedBox(height: 8.0),
        // Folders (Clients)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnatomyLayer(
              'AutofillClient',
              'TextField',
              Icons.description,
              inkBlue,
              160.0,
            ),
            SizedBox(width: 8.0),
            _buildAnatomyLayer(
              'AutofillClient',
              'TextField',
              Icons.description,
              inkBlue,
              160.0,
            ),
            SizedBox(width: 8.0),
            _buildAnatomyLayer(
              'AutofillClient',
              'TextField',
              Icons.description,
              inkBlue,
              160.0,
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: parchment,
            border: Border.all(color: cabinetBronze, width: 1.0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Each AutofillClient registers a unique identifier and a list of '
            'AutofillHints with its enclosing scope. The platform autofill '
            'service consults these hints to decide what to suggest.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: cabinetShadow,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Cabinet anatomy diagrammed');

  // ============================================================
  // SECTION 3: AutofillHints vocabulary — drawers by category
  // ============================================================
  print('=== Section 3: AutofillHints Vocabulary ===');

  // Personal drawer
  final personalHints = <List<String>>[
    ['name', AutofillHints.name],
    ['givenName', AutofillHints.givenName],
    ['middleName', AutofillHints.middleName],
    ['familyName', AutofillHints.familyName],
    ['namePrefix', AutofillHints.namePrefix],
    ['nameSuffix', AutofillHints.nameSuffix],
    ['nickname', AutofillHints.nickname],
    ['birthday', AutofillHints.birthday],
    ['gender', AutofillHints.gender],
    ['photo', AutofillHints.photo],
  ];
  for (var i = 0; i < personalHints.length; i++) {
    print('Personal[${personalHints[i][0]}] = "${personalHints[i][1]}"');
  }

  // Address drawer
  final addressHints = <List<String>>[
    ['streetAddressLine1', AutofillHints.streetAddressLine1],
    ['streetAddressLine2', AutofillHints.streetAddressLine2],
    ['addressCity', AutofillHints.addressCity],
    ['addressState', AutofillHints.addressState],
    ['postalCode', AutofillHints.postalCode],
    ['countryName', AutofillHints.countryName],
    ['countryCode', AutofillHints.countryCode],
    ['fullStreetAddress', AutofillHints.fullStreetAddress],
    ['sublocality', AutofillHints.sublocality],
    ['location', AutofillHints.location],
  ];
  for (var i = 0; i < addressHints.length; i++) {
    print('Address[${addressHints[i][0]}] = "${addressHints[i][1]}"');
  }

  // Credentials drawer
  final credentialHints = <List<String>>[
    ['username', AutofillHints.username],
    ['newUsername', AutofillHints.newUsername],
    ['password', AutofillHints.password],
    ['newPassword', AutofillHints.newPassword],
    ['oneTimeCode', AutofillHints.oneTimeCode],
    ['email', AutofillHints.email],
    ['telephoneNumber', AutofillHints.telephoneNumber],
    ['telephoneNumberCountryCode', AutofillHints.telephoneNumberCountryCode],
    ['telephoneNumberNational', AutofillHints.telephoneNumberNational],
    ['url', AutofillHints.url],
  ];
  for (var i = 0; i < credentialHints.length; i++) {
    print('Credential[${credentialHints[i][0]}] = "${credentialHints[i][1]}"');
  }

  // Financial drawer
  final financialHints = <List<String>>[
    ['creditCardNumber', AutofillHints.creditCardNumber],
    ['creditCardName', AutofillHints.creditCardName],
    ['creditCardSecurityCode', AutofillHints.creditCardSecurityCode],
    ['creditCardExpirationDate', AutofillHints.creditCardExpirationDate],
    ['creditCardExpirationMonth', AutofillHints.creditCardExpirationMonth],
    ['creditCardExpirationYear', AutofillHints.creditCardExpirationYear],
    ['creditCardExpirationDay', AutofillHints.creditCardExpirationDay],
    ['creditCardType', AutofillHints.creditCardType],
    ['transactionAmount', AutofillHints.transactionAmount],
    ['transactionCurrency', AutofillHints.transactionCurrency],
  ];
  for (var i = 0; i < financialHints.length; i++) {
    print('Financial[${financialHints[i][0]}] = "${financialHints[i][1]}"');
  }

  final personalDrawer = _buildDrawer(
    'PERSONAL',
    Icons.person_outline,
    Color(0xFF7A4F3A),
    parchment,
    manilla,
    personalHints,
  );
  final addressDrawer = _buildDrawer(
    'ADDRESS',
    Icons.location_on_outlined,
    Color(0xFF3A6B7A),
    parchment,
    manilla,
    addressHints,
  );
  final credentialsDrawer = _buildDrawer(
    'CREDENTIALS',
    Icons.vpn_key_outlined,
    Color(0xFF6B3A7A),
    parchment,
    manilla,
    credentialHints,
  );
  final financialDrawer = _buildDrawer(
    'FINANCIAL',
    Icons.credit_card_outlined,
    Color(0xFF7A3A3A),
    parchment,
    manilla,
    financialHints,
  );
  print('Four hint drawers stocked');

  // ============================================================
  // SECTION 4: AutofillGroup folder demonstration
  // ============================================================
  print('=== Section 4: AutofillGroup Folder ===');

  // Build real AutofillGroups, then show their identity in a parchment card.
  final signInGroup = AutofillGroup(
    onDisposeAction: AutofillContextAction.commit,
    child: Column(
      children: [
        TextField(
          autofillHints: const <String>[AutofillHints.email],
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          autofillHints: const <String>[AutofillHints.password],
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password'),
        ),
      ],
    ),
  );
  print('signInGroup = $signInGroup');

  final newAccountGroup = AutofillGroup(
    onDisposeAction: AutofillContextAction.commit,
    child: Column(
      children: [
        TextField(
          autofillHints: const <String>[AutofillHints.newUsername],
          decoration: InputDecoration(labelText: 'New username'),
        ),
        TextField(
          autofillHints: const <String>[AutofillHints.newPassword],
          obscureText: true,
          decoration: InputDecoration(labelText: 'New password'),
        ),
      ],
    ),
  );
  print('newAccountGroup = $newAccountGroup');

  final discardingGroup = AutofillGroup(
    onDisposeAction: AutofillContextAction.cancel,
    child: TextField(
      autofillHints: const <String>[AutofillHints.oneTimeCode],
      decoration: InputDecoration(labelText: 'One-time code'),
    ),
  );
  print('discardingGroup = $discardingGroup');

  final folderShowcase = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [manilla, manillaDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cabinetBronze, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: cabinetShadow.withValues(alpha: 0.4),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'AutofillGroup Folders',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(height: 12.0),
        _buildFolderCard(
          'Sign-In Folder',
          'Action: COMMIT on dispose',
          Icons.login,
          stampGreen,
          'AutofillContextAction.commit',
          ['email', 'password'],
          parchment,
        ),
        SizedBox(height: 10.0),
        _buildFolderCard(
          'Account Setup Folder',
          'Action: COMMIT on dispose',
          Icons.app_registration,
          stampGreen,
          'AutofillContextAction.commit',
          ['newUsername', 'newPassword'],
          parchment,
        ),
        SizedBox(height: 10.0),
        _buildFolderCard(
          'Throwaway OTP Folder',
          'Action: CANCEL on dispose',
          Icons.delete_outline,
          stampRed,
          'AutofillContextAction.cancel',
          ['oneTimeCode'],
          parchment,
        ),
      ],
    ),
  );
  print('Folder showcase compiled');

  // ============================================================
  // SECTION 5: AutofillContextAction stamps
  // ============================================================
  print('=== Section 5: AutofillContextAction Stamps ===');

  final actionValues = AutofillContextAction.values;
  final actionStamps = <Widget>[];
  for (var i = 0; i < actionValues.length; i++) {
    final action = actionValues[i];
    final isCommit = action == AutofillContextAction.commit;
    final stampColor = isCommit ? stampGreen : stampRed;
    final stampIcon = isCommit ? Icons.check_circle : Icons.cancel;
    final stampText = isCommit ? 'SAVED' : 'DISCARD';
    final description = isCommit
        ? 'Tells the platform to persist the captured values to the autofill store.'
        : 'Tells the platform to throw the captured values away (e.g. wrong form).';
    print('AutofillContextAction.${action.name}: $description');

    actionStamps.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        padding: EdgeInsets.all(16.0),
        width: 240.0,
        decoration: BoxDecoration(
          color: parchment,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cabinetBronze, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: cabinetShadow.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            // Round rubber stamp
            Container(
              width: 110.0,
              height: 110.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: stampColor, width: 4.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(stampIcon, color: stampColor, size: 32.0),
                  SizedBox(height: 4.0),
                  Text(
                    stampText,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: stampColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'AutofillContextAction.${action.name}',
              style: TextStyle(
                fontSize: 12.0,
                color: cabinetShadow,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.0,
                color: cabinetShadow,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Stamped ${actionStamps.length} rubber stamps');

  // ============================================================
  // SECTION 6: AutofillConfiguration anatomy + .disabled
  // ============================================================
  print('=== Section 6: AutofillConfiguration ===');

  final emailConfig = AutofillConfiguration(
    uniqueIdentifier: 'sign_in_email_field',
    autofillHints: const <String>[AutofillHints.email],
    currentEditingValue: TextEditingValue(text: 'jane.doe@example.com'),
    hintText: 'name@example.com',
  );
  final passwordConfig = AutofillConfiguration(
    uniqueIdentifier: 'sign_in_password_field',
    autofillHints: const <String>[AutofillHints.password],
    currentEditingValue: TextEditingValue.empty,
    hintText: 'Enter password',
  );
  final disabledConfig = AutofillConfiguration.disabled;

  print('emailConfig: enabled=${emailConfig.enabled} '
      'id="${emailConfig.uniqueIdentifier}" '
      'hints=${emailConfig.autofillHints} '
      'value="${emailConfig.currentEditingValue.text}"');
  print('passwordConfig: enabled=${passwordConfig.enabled} '
      'id="${passwordConfig.uniqueIdentifier}"');
  print('disabledConfig: enabled=${disabledConfig.enabled} '
      'hints=${disabledConfig.autofillHints} '
      'id="${disabledConfig.uniqueIdentifier}"');

  final configAnatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [parchment, manilla],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cabinetBronze, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: cabinetShadow.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'AutofillConfiguration — Index Card',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: cabinetShadow,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        _buildConfigCard(
          emailConfig,
          'Email Field — Sign-In',
          Icons.alternate_email,
          stampGreen,
          parchment,
          cabinetShadow,
        ),
        SizedBox(height: 10.0),
        _buildConfigCard(
          passwordConfig,
          'Password Field — Sign-In',
          Icons.lock_outline,
          stampGreen,
          parchment,
          cabinetShadow,
        ),
        SizedBox(height: 10.0),
        _buildConfigCard(
          disabledConfig,
          'AutofillConfiguration.disabled',
          Icons.do_not_disturb_on,
          stampRed,
          parchment,
          cabinetShadow,
        ),
      ],
    ),
  );
  print('Index cards filed');

  // ============================================================
  // SECTION 7: Sign-up form folder mockup (real AutofillGroup)
  // ============================================================
  print('=== Section 7: Sign-up Form Mockup ===');

  final signUpGroup = AutofillGroup(
    onDisposeAction: AutofillContextAction.commit,
    child: Column(
      children: [
        TextField(
          autofillHints: const <String>[AutofillHints.givenName],
          decoration: InputDecoration(
            labelText: 'First name',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          autofillHints: const <String>[AutofillHints.familyName],
          decoration: InputDecoration(
            labelText: 'Last name',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          autofillHints: const <String>[AutofillHints.email],
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.alternate_email),
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          autofillHints: const <String>[
            AutofillHints.telephoneNumber,
          ],
          decoration: InputDecoration(
            labelText: 'Telephone',
            prefixIcon: Icon(Icons.phone_outlined),
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          autofillHints: const <String>[AutofillHints.newUsername],
          decoration: InputDecoration(
            labelText: 'Choose a username',
            prefixIcon: Icon(Icons.badge_outlined),
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          autofillHints: const <String>[AutofillHints.newPassword],
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Choose a password',
            prefixIcon: Icon(Icons.lock_outline),
          ),
        ),
      ],
    ),
  );
  print('signUpGroup = $signUpGroup');

  final signUpFolder = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: cabinetShadow.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Column(
        children: [
          // Folder tab
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [manillaDark, manilla],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(color: cabinetBronze, width: 1.5),
            ),
            child: Row(
              children: [
                Icon(Icons.folder_open, color: cabinetBronze, size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  'NEW ACCOUNT — sign_up.form',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: cabinetShadow,
                    letterSpacing: 1.5,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: stampGreen.withValues(alpha: 0.2),
                    border: Border.all(color: stampGreen, width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'COMMIT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: stampGreen,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Folder body
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: parchment,
              border: Border.all(color: cabinetBronze, width: 1.5),
            ),
            child: signUpGroup,
          ),
        ],
      ),
    ),
  );
  print('Sign-up folder mockup mounted');

  // ============================================================
  // SECTION 8: Credit-card form folder mockup
  // ============================================================
  print('=== Section 8: Credit-card Form Mockup ===');

  final ccGroup = AutofillGroup(
    onDisposeAction: AutofillContextAction.commit,
    child: Column(
      children: [
        TextField(
          autofillHints: const <String>[AutofillHints.creditCardName],
          decoration: InputDecoration(
            labelText: 'Cardholder name',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          autofillHints: const <String>[AutofillHints.creditCardNumber],
          decoration: InputDecoration(
            labelText: 'Card number',
            prefixIcon: Icon(Icons.credit_card),
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                autofillHints: const <String>[
                  AutofillHints.creditCardExpirationMonth,
                ],
                decoration: InputDecoration(labelText: 'MM'),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                autofillHints: const <String>[
                  AutofillHints.creditCardExpirationYear,
                ],
                decoration: InputDecoration(labelText: 'YYYY'),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                autofillHints: const <String>[
                  AutofillHints.creditCardSecurityCode,
                ],
                decoration: InputDecoration(labelText: 'CVC'),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        TextField(
          autofillHints: const <String>[AutofillHints.postalCode],
          decoration: InputDecoration(
            labelText: 'Billing postal code',
            prefixIcon: Icon(Icons.local_post_office_outlined),
          ),
        ),
      ],
    ),
  );
  print('ccGroup = $ccGroup');

  final creditCardMockup = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: cabinetShadow.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [manillaDark, manilla],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(color: cabinetBronze, width: 1.5),
            ),
            child: Row(
              children: [
                Icon(Icons.credit_card, color: cabinetBronze, size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  'CHECKOUT — credit_card.form',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: cabinetShadow,
                    letterSpacing: 1.5,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: stampGreen.withValues(alpha: 0.2),
                    border: Border.all(color: stampGreen, width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'COMMIT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: stampGreen,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: parchment,
              border: Border.all(color: cabinetBronze, width: 1.5),
            ),
            child: ccGroup,
          ),
        ],
      ),
    ),
  );
  print('Credit-card folder mockup mounted');

  // ============================================================
  // SECTION 9: Registration lifecycle ledger
  // ============================================================
  print('=== Section 9: Registration Lifecycle ===');

  final lifecycleSteps = <List<String>>[
    [
      '1',
      'AutofillGroup wraps fields',
      'A registrar opens the folder',
      'AutofillGroup creates AutofillGroupState which implements AutofillScope.',
    ],
    [
      '2',
      'Field registers',
      'Document is dropped into the folder',
      'Each EditableTextState calls scope.register(this) during build.',
    ],
    [
      '3',
      'Configuration sent',
      'Index card filed with the platform',
      'AutofillConfiguration travels through TextInput.attach as part of TextInputConfiguration.',
    ],
    [
      '4',
      'Platform suggests',
      'Notary brings matching documents from the archive',
      'OS reads autofillHints and offers stored values for the right field.',
    ],
    [
      '5',
      'User accepts',
      'Documents are stamped and inserted',
      'TextInputClient.autofill(...) updates each field\'s TextEditingValue.',
    ],
    [
      '6',
      'AutofillGroup disposes',
      'Folder is closed',
      'onDisposeAction tells the platform to commit or cancel the saved context.',
    ],
  ];

  final lifecycleLedger = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [parchment, manilla],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cabinetBronze, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: cabinetShadow.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Registration Ledger',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: cabinetShadow,
              letterSpacing: 2.0,
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Center(
          child: Text(
            'How an AutofillClient finds its way into the cabinet',
            style: TextStyle(
              fontSize: 11.0,
              color: cabinetBronze,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        for (var i = 0; i < lifecycleSteps.length; i++)
          _buildLedgerRow(
            lifecycleSteps[i][0],
            lifecycleSteps[i][1],
            lifecycleSteps[i][2],
            lifecycleSteps[i][3],
            i.isEven ? parchment : manilla,
            cabinetShadow,
            cabinetBronze,
          ),
      ],
    ),
  );
  print('Lifecycle ledger inscribed');

  // ============================================================
  // SECTION 10: Platform→Client hint flow
  // ============================================================
  print('=== Section 10: Platform → Client Hint Flow ===');

  final hintFlow = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFEFE4C5), parchment],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cabinetBronze, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Platform → Client Hint Flow',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFlowNode(
              'Platform',
              'iOS / Android / Web',
              Icons.public,
              inkBlue,
            ),
            _buildFlowArrow('hint translation', cabinetBronze),
            _buildFlowNode(
              'AutofillScope',
              'Routes by id',
              Icons.account_balance,
              cabinetBronze,
            ),
            _buildFlowArrow('autofill(value)', cabinetBronze),
            _buildFlowNode(
              'AutofillClient',
              'Updates field',
              Icons.description,
              stampGreen,
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: parchment,
            border: Border.all(color: cabinetBronze, width: 1.0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'TextInputClient.requestAutofill() asks the platform to surface the '
            'autofill UI for the active connection. The platform then walks the '
            'AutofillScope, looks up clients by uniqueIdentifier, and delivers '
            'a TextEditingValue per matched field.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: cabinetShadow,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: inkBlue.withValues(alpha: 0.08),
            border: Border.all(color: inkBlue.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              Icon(Icons.touch_app, color: inkBlue, size: 22.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'TextInputClient.requestAutofill — the bell on the counter '
                  'that summons the notary.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: inkBlue,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Hint flow chart drafted');

  // ============================================================
  // SECTION 11: Code excerpts on parchment
  // ============================================================
  print('=== Section 11: Code Excerpts ===');

  final codeExcerpts = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Color(0xFF2A2418),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: brass, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: cabinetShadow.withValues(alpha: 0.5),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: brass, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Excerpts from the Records Manual',
              style: TextStyle(
                color: brass,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCode(
          '// Wrap related fields in an AutofillGroup\n'
          'AutofillGroup(\n'
          '  onDisposeAction: AutofillContextAction.commit,\n'
          '  child: Column(children: [\n'
          '    TextField(autofillHints: [AutofillHints.email]),\n'
          '    TextField(autofillHints: [AutofillHints.password]),\n'
          '  ]),\n'
          ')',
          Color(0xFFC1E1A6),
        ),
        SizedBox(height: 10.0),
        _buildCode(
          '// AutofillConfiguration travels with TextInputConfiguration\n'
          'AutofillConfiguration(\n'
          '  uniqueIdentifier: "sign_in_email_field",\n'
          '  autofillHints: [AutofillHints.email],\n'
          '  currentEditingValue: TextEditingValue(text: ""),\n'
          '  hintText: "name@example.com",\n'
          ')',
          Color(0xFFA6C8E1),
        ),
        SizedBox(height: 10.0),
        _buildCode(
          '// Opt out of autofill explicitly\n'
          'final disabled = AutofillConfiguration.disabled;\n'
          '// disabled.enabled == false\n'
          '// disabled.uniqueIdentifier == ""',
          Color(0xFFE1A6A6),
        ),
        SizedBox(height: 10.0),
        _buildCode(
          '// Surface the autofill UI from a TextInputClient\n'
          'class _MyClient implements TextInputClient {\n'
          '  void summon() => TextInput.attach(this, config)\n'
          '      .requestAutofill();\n'
          '}',
          Color(0xFFE1C7A6),
        ),
        SizedBox(height: 10.0),
        _buildCode(
          '// Cancel a half-typed form on dispose\n'
          'AutofillGroup(\n'
          '  onDisposeAction: AutofillContextAction.cancel,\n'
          '  child: TextField(\n'
          '    autofillHints: [AutofillHints.oneTimeCode],\n'
          '  ),\n'
          ')',
          Color(0xFFE1A6D8),
        ),
      ],
    ),
  );
  print('Manual excerpts transcribed');

  print('AutofillContext Deep Demo completed — closing the cabinet');

  // ============================================================
  // Final assembly
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        cabinetHeader,
        SizedBox(height: 24.0),
        Text(
          '1. Cabinet Anatomy',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
          ),
        ),
        cabinetAnatomy,
        SizedBox(height: 24.0),
        Text(
          '2. Hint Vocabulary',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: [
            personalDrawer,
            addressDrawer,
            credentialsDrawer,
            financialDrawer,
          ],
        ),
        SizedBox(height: 24.0),
        Text(
          '3. AutofillGroup Folders',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
          ),
        ),
        folderShowcase,
        SizedBox(height: 24.0),
        Text(
          '4. AutofillContextAction Stamps',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(alignment: WrapAlignment.center, children: actionStamps),
        SizedBox(height: 24.0),
        Text(
          '5. AutofillConfiguration Index Cards',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
          ),
        ),
        configAnatomy,
        SizedBox(height: 24.0),
        Text(
          '6. Sign-up Form Folder',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
          ),
        ),
        signUpFolder,
        SizedBox(height: 24.0),
        Text(
          '7. Credit-card Form Folder',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
          ),
        ),
        creditCardMockup,
        SizedBox(height: 24.0),
        Text(
          '8. Registration Lifecycle Ledger',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
          ),
        ),
        lifecycleLedger,
        SizedBox(height: 24.0),
        Text(
          '9. Platform → Client Hint Flow',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
          ),
        ),
        hintFlow,
        SizedBox(height: 24.0),
        Text(
          '10. Records Manual Excerpts',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: cabinetShadow,
          ),
        ),
        codeExcerpts,
        SizedBox(height: 24.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cabinetShadow, cabinetBronze],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: brass, width: 2.0),
          ),
          child: Center(
            child: Text(
              '— END OF RECORD —',
              style: TextStyle(
                fontSize: 14.0,
                color: brass,
                letterSpacing: 4.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _buildAnatomyLayer(
  String title,
  String subtitle,
  IconData icon,
  Color color,
  double width,
) {
  return Container(
    width: width,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            color: color.withValues(alpha: 0.85),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _buildDrawer(
  String title,
  IconData icon,
  Color labelColor,
  Color paper,
  Color folder,
  List<List<String>> hints,
) {
  final children = <Widget>[];
  for (var i = 0; i < hints.length; i++) {
    children.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: paper,
          border: Border.all(color: labelColor.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: [
            Container(
              width: 6.0,
              height: 14.0,
              color: labelColor,
            ),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                hints[i][0],
                style: TextStyle(
                  fontSize: 10.0,
                  color: labelColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '"${hints[i][1]}"',
              style: TextStyle(
                fontSize: 9.0,
                color: Color(0xFF3A2E18),
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    width: 270.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [folder, Color(0xFFD9C28A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: labelColor, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: labelColor.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(icon, color: labelColor, size: 22.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: labelColor,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          height: 2.0,
          color: labelColor.withValues(alpha: 0.5),
        ),
        SizedBox(height: 6.0),
        ...children,
      ],
    ),
  );
}

Widget _buildFolderCard(
  String title,
  String subtitle,
  IconData icon,
  Color stamp,
  String stampLabel,
  List<String> hintNames,
  Color paper,
) {
  final tags = <Widget>[];
  for (var i = 0; i < hintNames.length; i++) {
    tags.add(
      Container(
        margin: EdgeInsets.only(right: 6.0, top: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: stamp.withValues(alpha: 0.15),
          border: Border.all(color: stamp.withValues(alpha: 0.6)),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          hintNames[i],
          style: TextStyle(
            fontSize: 10.0,
            color: stamp,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: paper,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: stamp.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: stamp.withValues(alpha: 0.2),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: stamp, width: 2.0),
          ),
          child: Icon(icon, color: stamp, size: 28.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: stamp,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10.0,
                  color: stamp.withValues(alpha: 0.8),
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                stampLabel,
                style: TextStyle(
                  fontSize: 10.0,
                  color: stamp,
                  fontFamily: 'monospace',
                ),
              ),
              Wrap(children: tags),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildConfigCard(
  AutofillConfiguration config,
  String title,
  IconData icon,
  Color accent,
  Color paper,
  Color ink,
) {
  final hintsText = config.autofillHints.isEmpty
      ? '(none)'
      : config.autofillHints.join(', ');
  final valueText = config.currentEditingValue.text.isEmpty
      ? '(empty)'
      : config.currentEditingValue.text;
  final idText = config.uniqueIdentifier.isEmpty
      ? '(blank)'
      : config.uniqueIdentifier;
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: paper,
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.5),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: config.enabled
                    ? Color(0xFFE6F4EA)
                    : Color(0xFFF8E1E1),
                border: Border.all(
                  color: config.enabled
                      ? Color(0xFF2E6B3F)
                      : Color(0xFFB23030),
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                config.enabled ? 'enabled' : 'disabled',
                style: TextStyle(
                  fontSize: 10.0,
                  color: config.enabled
                      ? Color(0xFF2E6B3F)
                      : Color(0xFFB23030),
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        _buildConfigField('uniqueIdentifier', idText, ink),
        _buildConfigField('autofillHints', hintsText, ink),
        _buildConfigField('currentEditingValue.text', valueText, ink),
        _buildConfigField('hintText', config.hintText ?? '(null)', ink),
      ],
    ),
  );
}

Widget _buildConfigField(String label, String value, Color ink) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.0,
              color: ink,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 10.0,
              color: ink,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLedgerRow(
  String number,
  String title,
  String metaphor,
  String technical,
  Color background,
  Color ink,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: accent,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Color(0xFFFBF4DC),
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: ink,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                metaphor,
                style: TextStyle(
                  fontSize: 11.0,
                  color: accent,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                technical,
                style: TextStyle(
                  fontSize: 10.0,
                  color: ink,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowNode(
  String title,
  String subtitle,
  IconData icon,
  Color color,
) {
  return Container(
    width: 110.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      border: Border.all(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28.0),
        SizedBox(height: 4.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9.0, color: color.withValues(alpha: 0.8)),
        ),
      ],
    ),
  );
}

Widget _buildFlowArrow(String label, Color color) {
  return SizedBox(
    width: 56.0,
    child: Column(
      children: [
        Icon(Icons.arrow_forward, color: color, size: 22.0),
        SizedBox(height: 2.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.0,
            color: color,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCode(String code, Color textColor) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1A1610),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Color(0xFF8B6F3D), width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}
