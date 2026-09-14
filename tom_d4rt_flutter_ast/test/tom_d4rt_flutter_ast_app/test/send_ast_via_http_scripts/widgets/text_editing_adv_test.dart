// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for advanced TextField,
// TextFormField, EditableText and TextSelectionTheme configuration
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('=========================================================');
  print(' Advanced Text Editing widgets — deep visual demo');
  print('=========================================================');
  print('Topics covered:');
  print('  1. TextField decoration gallery');
  print('  2. TextField expansion / multiline configuration');
  print('  3. TextFormField validators showcase');
  print('  4. Autofill hints catalog');
  print('  5. TextSelectionTheme comparison');
  print('  6. MagnifierConfiguration anatomy');
  print('  7. EditableText parameter table');
  print('  8. Smart dashes / quotes + keyboard appearance');
  print('---------------------------------------------------------');

  // =========================================================================
  // SECTION 1 — TextField decoration gallery
  // -------------------------------------------------------------------------
  // We construct several visually distinct TextField instances showing the
  // four major InputBorder modes plus counter/prefix/suffix variants. Each
  // field uses a freshly constructed TextEditingController(text: '...') so
  // no runtime mutation is required.
  // =========================================================================
  print('--- SECTION 1: TextField decoration gallery ---');

  final headerSection1 = _sectionHeader(
    title: 'TextField decoration gallery',
    subtitle:
        'Four border modes (outline, underline, filled, none) combined with '
        'prefix, suffix, counter and helper text decorations.',
    color: Colors.indigo,
    icon: Icons.dashboard_customize,
  );

  // 1a. OutlineInputBorder — classic rounded outline with helper text.
  final outlinedCtrl = TextEditingController(text: 'Outlined field');
  final outlinedField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: outlinedCtrl,
      decoration: const InputDecoration(
        labelText: 'OutlineInputBorder',
        hintText: 'Enter project name',
        helperText: 'Rounded outlined border, 12 px radius',
        helperMaxLines: 2,
        prefixIcon: Icon(Icons.folder_open),
        suffixIcon: Icon(Icons.check_circle, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.indigo, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2.5),
        ),
      ),
    ),
  );
  print('  built outlined field with controller text: '
      '${outlinedCtrl.text}');

  // 1b. UnderlineInputBorder — Material default underline with counter.
  final underlineCtrl = TextEditingController(text: 'Underline default');
  final underlineField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: underlineCtrl,
      maxLength: 24,
      decoration: const InputDecoration(
        labelText: 'UnderlineInputBorder',
        hintText: 'Document title',
        helperText: 'Material default; reacts to focus colour.',
        counterText: '08 / 24 characters (preview only)',
        prefixIcon: Icon(Icons.description_outlined),
        suffixIcon: Icon(Icons.clear, color: Colors.grey),
      ),
    ),
  );
  print('  built underline field with controller text: '
      '${underlineCtrl.text}');

  // 1c. Filled field with no visible border (border: InputBorder.none).
  final filledCtrl = TextEditingController(text: 'Filled, no border');
  final filledField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: filledCtrl,
      decoration: InputDecoration(
        labelText: 'Filled / borderless',
        hintText: 'Tag or label',
        filled: true,
        fillColor: Colors.indigo.shade50,
        helperText: 'Fill colour acts as visual chrome.',
        prefixIcon: const Icon(Icons.label_important_outline),
        suffixText: 'tag',
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    ),
  );
  print('  built filled/none-border field with controller text: '
      '${filledCtrl.text}');

  // 1d. Hardened password-style field with obscuring text, info suffix icon.
  final passwordCtrl = TextEditingController(text: 'secret-1234');
  final passwordField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: passwordCtrl,
      obscureText: true,
      obscuringCharacter: '*',
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: 'Password (obscured)',
        helperText:
            'obscureText, obscuringCharacter: "*", enableSuggestions=false.',
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: Icon(Icons.remove_red_eye_outlined),
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('  built obscured password field with controller text length: '
      '${passwordCtrl.text.length}');

  // 1e. Disabled field — shows that decoration adapts.
  final disabledCtrl = TextEditingController(text: 'Disabled field');
  final disabledField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: disabledCtrl,
      enabled: false,
      decoration: const InputDecoration(
        labelText: 'Disabled field',
        helperText: 'enabled: false — content is read-only and dim.',
        prefixIcon: Icon(Icons.block),
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('  built disabled field with controller text: '
      '${disabledCtrl.text}');

  // 1f. Read-only field with copy suffix icon.
  final readOnlyCtrl =
      TextEditingController(text: 'read-only — token-9f02d11c');
  final readOnlyField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: readOnlyCtrl,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'Read-only token',
        helperText: 'readOnly: true — selectable but not editable.',
        prefixIcon: Icon(Icons.vpn_key_outlined),
        suffixIcon: Icon(Icons.copy_outlined),
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('  built read-only field with controller text: '
      '${readOnlyCtrl.text}');

  final section1 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50.withOpacity(0.55),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.indigo.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection1,
        outlinedField,
        underlineField,
        filledField,
        passwordField,
        disabledField,
        readOnlyField,
        _sectionFooter(
          'Each entry uses a fresh TextEditingController; the demo never '
          'mutates controllers at runtime.',
        ),
      ],
    ),
  );
  print('SECTION 1 — ${6} fields composed.');

  // =========================================================================
  // SECTION 2 — TextField expansion / multiline configuration
  // -------------------------------------------------------------------------
  // Shows minLines / maxLines / expands and textAlignVertical interaction.
  // =========================================================================
  print('--- SECTION 2: TextField expansion / multiline ---');

  final headerSection2 = _sectionHeader(
    title: 'Expansion & multiline configuration',
    subtitle:
        'Demonstrates minLines, maxLines, expands, textAlign, textAlignVertical '
        'and TextInputAction interplay.',
    color: Colors.teal,
    icon: Icons.height,
  );

  // 2a. Single line (default).
  final singleLineCtrl = TextEditingController(text: 'single line, maxLines=1');
  final singleLine = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: singleLineCtrl,
      decoration: const InputDecoration(
        labelText: 'Single line (default)',
        helperText: 'maxLines: 1 (default).',
        border: OutlineInputBorder(),
      ),
    ),
  );

  // 2b. 3 lines fixed.
  final fixedThreeCtrl = TextEditingController(
    text: 'Three rows fixed.\nLine 2 example.\nLine 3 example.',
  );
  final fixedThree = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: fixedThreeCtrl,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      decoration: const InputDecoration(
        labelText: 'maxLines: 3, multiline keyboard',
        helperText:
            'keyboardType: TextInputType.multiline, textInputAction.newline',
        border: OutlineInputBorder(),
      ),
    ),
  );

  // 2c. Auto-growing (minLines: 1, maxLines: 5).
  final growCtrl = TextEditingController(
    text: 'Auto-growing field.\nminLines: 1, maxLines: 5.',
  );
  final growField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: growCtrl,
      minLines: 1,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        labelText: 'Auto-growing (1 → 5)',
        helperText: 'minLines: 1, maxLines: 5 — height tracks content.',
        border: OutlineInputBorder(),
      ),
    ),
  );

  // 2d. Expanding to fill the parent — wrapped in a fixed-height box.
  final expandCtrl = TextEditingController(
    text:
        'Expanding field — fills its parent vertically; useful inside an '
        'editor card. Note the textAlignVertical: TextAlignVertical.top.',
  );
  final expandField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: SizedBox(
      height: 160,
      child: TextField(
        controller: expandCtrl,
        expands: true,
        maxLines: null,
        minLines: null,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          labelText: 'expands: true (fills parent)',
          helperText: 'maxLines: null, minLines: null, expands: true.',
          alignLabelWithHint: true,
          border: OutlineInputBorder(),
        ),
      ),
    ),
  );

  // 2e. Right-aligned field, search-style action.
  final rightAlignCtrl = TextEditingController(text: 'right aligned text');
  final rightAlign = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: rightAlignCtrl,
      textAlign: TextAlign.right,
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        labelText: 'textAlign.right, textInputAction.search',
        helperText: 'Search action commits the value, no newline allowed.',
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    ),
  );

  // 2f. Centered field, done action.
  final centerCtrl = TextEditingController(text: 'centered text');
  final centerField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: centerCtrl,
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: 'textAlign.center, textInputAction.done',
        helperText: 'done action closes the soft keyboard.',
        border: OutlineInputBorder(),
      ),
    ),
  );

  final section2 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.teal.shade50.withOpacity(0.55),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.teal.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection2,
        singleLine,
        fixedThree,
        growField,
        expandField,
        rightAlign,
        centerField,
        _sectionFooter(
          'expands: true requires both minLines and maxLines to be null and '
          'demands a bounded parent.',
        ),
      ],
    ),
  );
  print('SECTION 2 — ${6} expansion variants composed.');

  // =========================================================================
  // SECTION 3 — TextFormField validators showcase
  // -------------------------------------------------------------------------
  // Validators are passed in as plain top-level synchronous functions. We
  // pre-bind an errorText via InputDecoration to make the *visual* outcome
  // explicit without runtime triggering.
  // =========================================================================
  print('--- SECTION 3: TextFormField validators ---');

  final headerSection3 = _sectionHeader(
    title: 'TextFormField validation showcase',
    subtitle:
        'Each field has a synchronous validator and a pre-set errorText so '
        'the visual error state renders immediately on first paint.',
    color: Colors.deepOrange,
    icon: Icons.rule_folder_outlined,
  );

  final formKey = GlobalKey<FormState>();
  print('  FormState key: $formKey');

  // 3a. Required field — missing value.
  final requiredCtrl = TextEditingController(text: '');
  final requiredField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextFormField(
      controller: requiredCtrl,
      validator: _validateRequired,
      autovalidateMode: AutovalidateMode.disabled,
      decoration: const InputDecoration(
        labelText: 'Required field (empty)',
        helperText: '_validateRequired returns "required" on empty input.',
        errorText: 'required',
        prefixIcon: Icon(Icons.priority_high),
        border: OutlineInputBorder(),
      ),
    ),
  );

  // 3b. Email-style field — invalid pattern.
  final emailCtrl = TextEditingController(text: 'not-an-email');
  final emailField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextFormField(
      controller: emailCtrl,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const <String>[AutofillHints.email],
      validator: _validateEmail,
      decoration: const InputDecoration(
        labelText: 'Email',
        helperText: '_validateEmail checks for "@" presence.',
        errorText: 'not a valid email',
        prefixIcon: Icon(Icons.alternate_email),
        border: OutlineInputBorder(),
      ),
    ),
  );

  // 3c. Length-constrained field — too short.
  final shortCtrl = TextEditingController(text: 'abc');
  final shortField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextFormField(
      controller: shortCtrl,
      validator: _validateMinLength,
      decoration: const InputDecoration(
        labelText: 'Min length: 6',
        helperText: '_validateMinLength enforces >= 6 characters.',
        errorText: 'minimum 6 characters',
        prefixIcon: Icon(Icons.short_text),
        border: OutlineInputBorder(),
      ),
    ),
  );

  // 3d. Phone number — digits only.
  final phoneCtrl = TextEditingController(text: '+44 20 (formatter strips)');
  final phoneField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextFormField(
      controller: phoneCtrl,
      keyboardType: TextInputType.phone,
      autofillHints: const <String>[AutofillHints.telephoneNumber],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: _validatePhone,
      decoration: const InputDecoration(
        labelText: 'Phone (digits only)',
        helperText: 'FilteringTextInputFormatter.digitsOnly strips non-digits.',
        prefixIcon: Icon(Icons.call_outlined),
        border: OutlineInputBorder(),
      ),
    ),
  );

  // 3e. Currency field with custom formatter.
  final currencyCtrl = TextEditingController(text: '1234');
  final currencyField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextFormField(
      controller: currencyCtrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
      ],
      validator: _validateCurrency,
      decoration: const InputDecoration(
        labelText: 'Amount',
        prefixText: '€ ',
        suffixText: 'EUR',
        helperText: 'Numeric keyboard, decimal allowed.',
        prefixIcon: Icon(Icons.euro),
        border: OutlineInputBorder(),
      ),
    ),
  );

  // 3f. Always-valid descriptive field.
  final descCtrl = TextEditingController(
    text: 'Optional description — never errors.',
  );
  final descField = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextFormField(
      controller: descCtrl,
      validator: _validateAlwaysOk,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Description (optional)',
        helperText: '_validateAlwaysOk returns null unconditionally.',
        prefixIcon: Icon(Icons.notes),
        border: OutlineInputBorder(),
      ),
    ),
  );

  final formBody = Form(
    key: formKey,
    autovalidateMode: AutovalidateMode.disabled,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        requiredField,
        emailField,
        shortField,
        phoneField,
        currencyField,
        descField,
      ],
    ),
  );

  final section3 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.deepOrange.shade50.withOpacity(0.55),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.deepOrange.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection3,
        formBody,
        _sectionFooter(
          'Form validation is invoked by Form.of(context).validate(); the '
          'demo only renders the visual outcome (errorText pre-bound).',
        ),
      ],
    ),
  );
  print('SECTION 3 — ${6} validated form fields composed.');

  // =========================================================================
  // SECTION 4 — Autofill hints catalog
  // -------------------------------------------------------------------------
  // Builds a visual catalog of AutofillHints constants, with a representative
  // TextField for each major category, all wrapped in a single AutofillGroup.
  // =========================================================================
  print('--- SECTION 4: Autofill hints catalog ---');

  final headerSection4 = _sectionHeader(
    title: 'Autofill hints catalog',
    subtitle:
        'A representative TextField for each major AutofillHints category, '
        'inside a single AutofillGroup so the platform can coordinate fills.',
    color: Colors.purple,
    icon: Icons.auto_awesome_motion,
  );

  final autofillEntries = <Map<String, Object>>[
    <String, Object>{
      'label': 'Full name',
      'icon': Icons.badge,
      'text': 'Ada Lovelace',
      'hint': AutofillHints.name,
      'keyboard': TextInputType.name,
    },
    <String, Object>{
      'label': 'Given name',
      'icon': Icons.person_outline,
      'text': 'Ada',
      'hint': AutofillHints.givenName,
      'keyboard': TextInputType.name,
    },
    <String, Object>{
      'label': 'Family name',
      'icon': Icons.family_restroom,
      'text': 'Lovelace',
      'hint': AutofillHints.familyName,
      'keyboard': TextInputType.name,
    },
    <String, Object>{
      'label': 'Email',
      'icon': Icons.alternate_email,
      'text': 'ada@analytical.engine',
      'hint': AutofillHints.email,
      'keyboard': TextInputType.emailAddress,
    },
    <String, Object>{
      'label': 'Username',
      'icon': Icons.account_circle,
      'text': 'ada_lovelace',
      'hint': AutofillHints.username,
      'keyboard': TextInputType.text,
    },
    <String, Object>{
      'label': 'New password',
      'icon': Icons.password,
      'text': 'super-secret-2026',
      'hint': AutofillHints.newPassword,
      'keyboard': TextInputType.visiblePassword,
    },
    <String, Object>{
      'label': 'One-time code',
      'icon': Icons.sms,
      'text': '123456',
      'hint': AutofillHints.oneTimeCode,
      'keyboard': TextInputType.number,
    },
    <String, Object>{
      'label': 'Phone number',
      'icon': Icons.phone,
      'text': '+44 20 7946 0123',
      'hint': AutofillHints.telephoneNumber,
      'keyboard': TextInputType.phone,
    },
    <String, Object>{
      'label': 'Street address (line 1)',
      'icon': Icons.home_outlined,
      'text': '11 Berkeley Square',
      'hint': AutofillHints.streetAddressLine1,
      'keyboard': TextInputType.streetAddress,
    },
    <String, Object>{
      'label': 'Postal code',
      'icon': Icons.markunread_mailbox_outlined,
      'text': 'W1J 5LN',
      'hint': AutofillHints.postalCode,
      'keyboard': TextInputType.text,
    },
    <String, Object>{
      'label': 'Country',
      'icon': Icons.public,
      'text': 'United Kingdom',
      'hint': AutofillHints.countryName,
      'keyboard': TextInputType.text,
    },
    <String, Object>{
      'label': 'Credit card number',
      'icon': Icons.credit_card,
      'text': '4242 4242 4242 4242',
      'hint': AutofillHints.creditCardNumber,
      'keyboard': TextInputType.number,
    },
  ];

  final autofillFields = <Widget>[];
  for (var i = 0; i < autofillEntries.length; i++) {
    final entry = autofillEntries[i];
    final label = entry['label'] as String;
    final icon = entry['icon'] as IconData;
    final text = entry['text'] as String;
    final hint = entry['hint'] as String;
    final keyboard = entry['keyboard'] as TextInputType;
    final ctrl = TextEditingController(text: text);
    final obscure = hint == AutofillHints.newPassword;
    autofillFields.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: TextField(
          controller: ctrl,
          obscureText: obscure,
          keyboardType: keyboard,
          autofillHints: <String>[hint],
          decoration: InputDecoration(
            labelText: label,
            helperText: 'autofillHints: [$hint]',
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
    print('  autofill[$i] $label -> $hint');
  }

  final autofillGroup = AutofillGroup(
    onDisposeAction: AutofillContextAction.commit,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: autofillFields,
    ),
  );

  final section4 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.purple.shade50.withOpacity(0.45),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.purple.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection4,
        autofillGroup,
        _sectionFooter(
          'AutofillGroup.onDisposeAction: commit signals the platform that the '
          'collected values should be saved when the group is torn down.',
        ),
      ],
    ),
  );
  print('SECTION 4 — ${autofillEntries.length} autofill hints catalogued.');

  // =========================================================================
  // SECTION 5 — TextSelectionTheme comparison
  // -------------------------------------------------------------------------
  // Three TextSelectionThemeData variants applied via local Theme overrides,
  // each wrapping its own TextField so the cursor and selection chrome differ.
  // =========================================================================
  print('--- SECTION 5: TextSelectionTheme comparison ---');

  final headerSection5 = _sectionHeader(
    title: 'TextSelectionTheme comparison',
    subtitle:
        'Three TextSelectionThemeData variants, each wrapping a TextField '
        'so cursor colour, selection colour and handle colour differ visually.',
    color: Colors.green,
    icon: Icons.colorize,
  );

  final selectionThemeBlue = const TextSelectionThemeData(
    cursorColor: Color(0xFF1565C0),
    selectionColor: Color(0x551565C0),
    selectionHandleColor: Color(0xFF1565C0),
  );
  final selectionThemeOrange = const TextSelectionThemeData(
    cursorColor: Color(0xFFEF6C00),
    selectionColor: Color(0x55EF6C00),
    selectionHandleColor: Color(0xFFEF6C00),
  );
  final selectionThemePurple = const TextSelectionThemeData(
    cursorColor: Color(0xFF6A1B9A),
    selectionColor: Color(0x556A1B9A),
    selectionHandleColor: Color(0xFF6A1B9A),
  );

  final selThemeCtrl1 = TextEditingController(
      text: 'Blue selection theme — calm primary chrome.');
  final selThemeCtrl2 = TextEditingController(
      text: 'Orange selection theme — warm accent chrome.');
  final selThemeCtrl3 = TextEditingController(
      text: 'Purple selection theme — bold accent chrome.');

  final blueTheme = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextSelectionTheme(
      data: selectionThemeBlue,
      child: TextField(
        controller: selThemeCtrl1,
        decoration: const InputDecoration(
          labelText: 'Blue TextSelectionTheme',
          helperText: 'cursorColor / selectionColor / selectionHandleColor.',
          prefixIcon: Icon(Icons.format_color_text, color: Color(0xFF1565C0)),
          border: OutlineInputBorder(),
        ),
      ),
    ),
  );

  final orangeTheme = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextSelectionTheme(
      data: selectionThemeOrange,
      child: TextField(
        controller: selThemeCtrl2,
        decoration: const InputDecoration(
          labelText: 'Orange TextSelectionTheme',
          helperText: 'Same fields, warm-accent palette.',
          prefixIcon: Icon(Icons.format_color_text, color: Color(0xFFEF6C00)),
          border: OutlineInputBorder(),
        ),
      ),
    ),
  );

  final purpleTheme = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextSelectionTheme(
      data: selectionThemePurple,
      child: TextField(
        controller: selThemeCtrl3,
        decoration: const InputDecoration(
          labelText: 'Purple TextSelectionTheme',
          helperText: 'Same fields, bold-accent palette.',
          prefixIcon: Icon(Icons.format_color_text, color: Color(0xFF6A1B9A)),
          border: OutlineInputBorder(),
        ),
      ),
    ),
  );

  final themeSwatchRow = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      children: <Widget>[
        _themeSwatch('blue', selectionThemeBlue),
        const SizedBox(width: 12),
        _themeSwatch('orange', selectionThemeOrange),
        const SizedBox(width: 12),
        _themeSwatch('purple', selectionThemePurple),
      ],
    ),
  );

  final section5 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.green.shade50.withOpacity(0.55),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.green.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection5,
        themeSwatchRow,
        blueTheme,
        orangeTheme,
        purpleTheme,
        _sectionFooter(
          'TextSelectionThemeData is the modern replacement for the legacy '
          'cursorColor / selectionHandleColor properties on Theme.',
        ),
      ],
    ),
  );
  print('SECTION 5 — 3 selection themes composed.');

  // =========================================================================
  // SECTION 6 — MagnifierConfiguration anatomy
  // -------------------------------------------------------------------------
  // Pure illustration of MagnifierConfiguration parts via labelled rows;
  // no animated controller, no live magnifier.
  // =========================================================================
  print('--- SECTION 6: MagnifierConfiguration anatomy ---');

  final headerSection6 = _sectionHeader(
    title: 'MagnifierConfiguration anatomy',
    subtitle:
        'Labelled rows enumerate the MagnifierConfiguration fields and '
        'document their semantics. The fields below use the platform default.',
    color: Colors.blueGrey,
    icon: Icons.search,
  );

  final magnifierRows = <Widget>[
    _kv('Type', '$TextMagnifierConfiguration'),
    _kv('shouldDisplayHandlesInMagnifier',
        'Whether the selection handles render inside the magnifier overlay.'),
    _kv('magnifierBuilder',
        'A WidgetBuilder that returns the actual magnifier surface.'),
    _kv('disabled (static)',
        'MagnifierConfiguration.disabled — opt-out for the entire subtree.'),
    _kv('Used by', 'TextField.magnifierConfiguration, EditableText.'),
  ];

  final magnifierField = TextField(
    controller: TextEditingController(text: 'Default magnifier configuration'),
    magnifierConfiguration: TextMagnifier.adaptiveMagnifierConfiguration,
    decoration: const InputDecoration(
      labelText: 'magnifierConfiguration: adaptive',
      helperText:
          'TextMagnifier.adaptiveMagnifierConfiguration picks the platform '
          'magnifier (iOS/Android) appropriate at runtime.',
      prefixIcon: Icon(Icons.zoom_in),
      border: OutlineInputBorder(),
    ),
  );

  final disabledMagnifierField = TextField(
    controller: TextEditingController(text: 'Magnifier disabled here'),
    magnifierConfiguration: TextMagnifierConfiguration.disabled,
    decoration: const InputDecoration(
      labelText: 'magnifierConfiguration: disabled',
      helperText: 'MagnifierConfiguration.disabled — no magnifier at all.',
      prefixIcon: Icon(Icons.zoom_out),
      border: OutlineInputBorder(),
    ),
  );

  final section6 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50.withOpacity(0.55),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.blueGrey.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection6,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: magnifierRows,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: magnifierField,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: disabledMagnifierField,
        ),
        _sectionFooter(
          'A custom magnifier is built by supplying a MagnifierConfiguration '
          'whose magnifierBuilder returns a positioned Widget tree.',
        ),
      ],
    ),
  );
  print('SECTION 6 — magnifier anatomy and two field variants composed.');

  // =========================================================================
  // SECTION 7 — EditableText parameter table
  // -------------------------------------------------------------------------
  // Heavy parameter coverage by directly constructing a configured
  // EditableText with explicit FocusNode + style.
  // =========================================================================
  print('--- SECTION 7: EditableText parameter table ---');

  final headerSection7 = _sectionHeader(
    title: 'EditableText parameter surface',
    subtitle:
        'EditableText is the low-level text input primitive that TextField '
        'wraps. Here we enumerate and exercise its major parameters.',
    color: Colors.brown,
    icon: Icons.edit_note,
  );

  final editableCtrl1 = TextEditingController(
    text: 'EditableText — explicit focus node + style',
  );
  final editableFocus1 = FocusNode(debugLabel: 'editable-1');

  final editable1 = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: EditableText(
      controller: editableCtrl1,
      focusNode: editableFocus1,
      style: const TextStyle(
        fontSize: 16,
        fontFamily: 'monospace',
        color: Colors.black,
      ),
      cursorColor: Colors.brown,
      backgroundCursorColor: Colors.brown,
      cursorWidth: 2.0,
      cursorRadius: const Radius.circular(2),
      cursorHeight: 18,
      cursorOpacityAnimates: false,
      showCursor: true,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      keyboardAppearance: Brightness.light,
      autocorrect: true,
      enableSuggestions: true,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.enabled,
      maxLines: 1,
      readOnly: false,
      forceLine: true,
      paintCursorAboveText: false,
      obscureText: false,
    ),
  );

  final editableCtrl2 = TextEditingController(
    text: 'EditableText — multiline + dark keyboard appearance',
  );
  final editableFocus2 = FocusNode(debugLabel: 'editable-2');

  final editable2 = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: EditableText(
      controller: editableCtrl2,
      focusNode: editableFocus2,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      cursorColor: Colors.indigo,
      backgroundCursorColor: Colors.indigo.shade200,
      cursorWidth: 2.5,
      keyboardAppearance: Brightness.dark,
      autocorrect: false,
      enableSuggestions: false,
      smartDashesType: SmartDashesType.disabled,
      smartQuotesType: SmartQuotesType.disabled,
      maxLines: 3,
      minLines: 2,
      textAlign: TextAlign.start,
      scrollPadding: const EdgeInsets.all(24),
      enableInteractiveSelection: true,
      obscureText: false,
    ),
  );

  final editableTable = <Widget>[
    _kv('controller', 'TextEditingController, source of truth for value.'),
    _kv('focusNode', 'FocusNode for keyboard focus management.'),
    _kv('style', 'Mandatory TextStyle for glyph rendering.'),
    _kv('cursorColor', 'Solid colour of the blinking caret.'),
    _kv('backgroundCursorColor',
        'Colour of the caret when the field is not focused.'),
    _kv('cursorWidth / cursorHeight / cursorRadius',
        'Geometry of the caret rectangle.'),
    _kv('cursorOpacityAnimates',
        'Whether the cursor fades in/out (true on iOS by default).'),
    _kv('paintCursorAboveText',
        'Z-order of the cursor relative to the glyphs.'),
    _kv('keyboardAppearance',
        'Brightness.light or Brightness.dark — affects iOS keyboard chrome.'),
    _kv('autocorrect',
        'true enables platform-level auto-correction suggestions.'),
    _kv('enableSuggestions',
        'true allows the IME to surface completion suggestions.'),
    _kv('smartDashesType',
        'SmartDashesType.enabled converts double hyphens to em-dashes (iOS).'),
    _kv('smartQuotesType',
        'SmartQuotesType.enabled curls straight quotes to typographic ones.'),
    _kv('obscureText',
        'When true, glyphs are replaced by obscuringCharacter.'),
    _kv('readOnly', 'When true, content is selectable but not editable.'),
    _kv('maxLines / minLines / expands',
        'Sizing model — same semantics as TextField.'),
    _kv('forceLine',
        'Forces the editable to use at least one full line of height.'),
    _kv('scrollPadding',
        'Padding applied when scrolling the caret into view.'),
    _kv('enableInteractiveSelection',
        'Toggles long-press / drag selection gestures.'),
  ];

  final section7 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.brown.shade50.withOpacity(0.55),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.brown.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection7,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: editableTable,
          ),
        ),
        editable1,
        editable2,
        _sectionFooter(
          'EditableText is normally consumed through TextField / TextFormField; '
          'using it directly is reserved for custom input surfaces.',
        ),
      ],
    ),
  );
  print('SECTION 7 — ${editableTable.length} EditableText params tabled.');

  // =========================================================================
  // SECTION 8 — Smart dashes / quotes + keyboard appearance
  // -------------------------------------------------------------------------
  // Cross-platform input subtleties: how SmartDashesType / SmartQuotesType /
  // KeyboardAppearance influence the on-screen keyboard chrome.
  // =========================================================================
  print('--- SECTION 8: Smart dashes / quotes + keyboard appearance ---');

  final headerSection8 = _sectionHeader(
    title: 'Smart dashes / quotes & keyboard appearance',
    subtitle:
        'Six TextField variants demonstrating SmartDashesType, SmartQuotesType '
        'and KeyboardAppearance combinations.',
    color: Colors.cyan,
    icon: Icons.keyboard_alt,
  );

  final smartCtrl1 = TextEditingController(
      text: 'Smart dashes ON  -- becomes — on iOS.');
  final smartField1 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: smartCtrl1,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.enabled,
      keyboardAppearance: Brightness.light,
      decoration: const InputDecoration(
        labelText: 'smart dashes/quotes: enabled, keyboard: light',
        prefixIcon: Icon(Icons.horizontal_rule),
        border: OutlineInputBorder(),
      ),
    ),
  );

  final smartCtrl2 = TextEditingController(
      text: 'Smart dashes OFF -- stays as plain double hyphen.');
  final smartField2 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: smartCtrl2,
      smartDashesType: SmartDashesType.disabled,
      smartQuotesType: SmartQuotesType.disabled,
      keyboardAppearance: Brightness.light,
      decoration: const InputDecoration(
        labelText: 'smart dashes/quotes: disabled, keyboard: light',
        prefixIcon: Icon(Icons.horizontal_rule_rounded),
        border: OutlineInputBorder(),
      ),
    ),
  );

  final smartCtrl3 = TextEditingController(text: '"straight" → "curly"');
  final smartField3 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: smartCtrl3,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.enabled,
      keyboardAppearance: Brightness.dark,
      decoration: const InputDecoration(
        labelText: 'curly quotes on, keyboard: dark',
        prefixIcon: Icon(Icons.format_quote),
        border: OutlineInputBorder(),
      ),
    ),
  );

  final smartCtrl4 = TextEditingController(
      text: 'Mixed — dashes enabled, quotes disabled.');
  final smartField4 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: smartCtrl4,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.disabled,
      keyboardAppearance: Brightness.light,
      decoration: const InputDecoration(
        labelText: 'dashes: enabled, quotes: disabled',
        prefixIcon: Icon(Icons.tune),
        border: OutlineInputBorder(),
      ),
    ),
  );

  final smartCtrl5 =
      TextEditingController(text: 'Mixed — dashes disabled, quotes enabled.');
  final smartField5 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: smartCtrl5,
      smartDashesType: SmartDashesType.disabled,
      smartQuotesType: SmartQuotesType.enabled,
      keyboardAppearance: Brightness.light,
      decoration: const InputDecoration(
        labelText: 'dashes: disabled, quotes: enabled',
        prefixIcon: Icon(Icons.tune),
        border: OutlineInputBorder(),
      ),
    ),
  );

  final smartCtrl6 = TextEditingController(text: 'Dark-mode keyboard preview');
  final smartField6 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: smartCtrl6,
      keyboardAppearance: Brightness.dark,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.enabled,
      decoration: const InputDecoration(
        labelText: 'dark keyboard, smart features on',
        prefixIcon: Icon(Icons.dark_mode_outlined),
        border: OutlineInputBorder(),
      ),
    ),
  );

  final smartTable = <Widget>[
    _kv('SmartDashesType.enabled',
        'iOS converts -- to em-dash and --- to en-dash typographically.'),
    _kv('SmartDashesType.disabled',
        'Hyphens remain literal — useful for code or identifiers.'),
    _kv('SmartQuotesType.enabled',
        'Straight quotes curl to “ ” and ‘ ’ as you type (iOS).'),
    _kv('SmartQuotesType.disabled',
        'Quotes stay straight — required for JSON, code, regex.'),
    _kv('Brightness.light',
        'iOS keyboard renders in light-on-grey chrome.'),
    _kv('Brightness.dark',
        'iOS keyboard renders in dark-mode chrome regardless of OS theme.'),
  ];

  final section8 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50.withOpacity(0.55),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.cyan.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: smartTable,
          ),
        ),
        smartField1,
        smartField2,
        smartField3,
        smartField4,
        smartField5,
        smartField6,
        _sectionFooter(
          'On Android most of these properties have no visible effect; they '
          'are forwarded to the IME via the EditorInfo configuration.',
        ),
      ],
    ),
  );
  print('SECTION 8 — 6 smart-feature combos composed.');

  // =========================================================================
  // SECTION 9 — Cursor styling gallery
  // -------------------------------------------------------------------------
  // Cursor width / radius / colour / height permutations through TextField's
  // exposed cursor* parameters.
  // =========================================================================
  print('--- SECTION 9: Cursor styling gallery ---');

  final headerSection9 = _sectionHeader(
    title: 'Cursor styling gallery',
    subtitle:
        'Five TextField variants showing cursorWidth, cursorRadius, '
        'cursorColor and cursorHeight permutations.',
    color: Colors.pink,
    icon: Icons.brush,
  );

  final cursorVariants = <Map<String, Object>>[
    <String, Object>{
      'label': 'thin pink',
      'width': 1.0,
      'radius': 0.0,
      'color': Colors.pink,
      'height': 18.0,
      'text': '1.0 px wide, square, pink',
    },
    <String, Object>{
      'label': 'rounded teal',
      'width': 3.0,
      'radius': 4.0,
      'color': Colors.teal,
      'height': 22.0,
      'text': '3.0 px wide, radius 4, teal',
    },
    <String, Object>{
      'label': 'thick amber',
      'width': 5.0,
      'radius': 1.5,
      'color': Colors.amber,
      'height': 24.0,
      'text': '5.0 px wide, radius 1.5, amber',
    },
    <String, Object>{
      'label': 'subtle grey',
      'width': 2.0,
      'radius': 2.0,
      'color': Colors.grey,
      'height': 16.0,
      'text': '2.0 px wide, radius 2, grey',
    },
    <String, Object>{
      'label': 'classic blue',
      'width': 2.0,
      'radius': 1.0,
      'color': Colors.blue,
      'height': 20.0,
      'text': '2.0 px wide, radius 1, blue (default-ish)',
    },
  ];

  final cursorWidgets = <Widget>[];
  for (var i = 0; i < cursorVariants.length; i++) {
    final v = cursorVariants[i];
    final ctrl = TextEditingController(text: v['text'] as String);
    cursorWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextField(
          controller: ctrl,
          cursorColor: v['color'] as Color,
          cursorWidth: v['width'] as double,
          cursorRadius: Radius.circular(v['radius'] as double),
          cursorHeight: v['height'] as double,
          showCursor: true,
          decoration: InputDecoration(
            labelText: 'cursor: ${v['label']}',
            helperText:
                'cursorWidth: ${v['width']}, cursorRadius: ${v['radius']}, '
                'cursorHeight: ${v['height']}',
            prefixIcon: Icon(Icons.text_fields, color: v['color'] as Color),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
    print('  cursor[$i] ${v['label']} '
        'width=${v['width']} radius=${v['radius']} height=${v['height']}');
  }

  final section9 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.pink.shade50.withOpacity(0.45),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.pink.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection9,
        ...cursorWidgets,
        _sectionFooter(
          'cursorOpacityAnimates is locked to true on iOS; passing false '
          'is platform-overridden at runtime in many cases.',
        ),
      ],
    ),
  );
  print('SECTION 9 — ${cursorVariants.length} cursor styles composed.');

  // =========================================================================
  // SECTION 10 — InputDecoration counter / prefix / suffix permutations
  // -------------------------------------------------------------------------
  print('--- SECTION 10: InputDecoration counter / prefix / suffix ---');

  final headerSection10 = _sectionHeader(
    title: 'InputDecoration counter & affix permutations',
    subtitle:
        'counter / counterText / counterStyle / prefix / suffix / '
        'prefixText / suffixText combinations.',
    color: Colors.deepPurple,
    icon: Icons.straighten,
  );

  final counterCtrl1 = TextEditingController(text: 'Lorem');
  final counterField1 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: counterCtrl1,
      maxLength: 12,
      decoration: const InputDecoration(
        labelText: 'maxLength: 12 — default counter',
        helperText: 'Counter shows "current/max".',
        border: OutlineInputBorder(),
      ),
    ),
  );

  final counterCtrl2 = TextEditingController(text: 'Customised counter text');
  final counterField2 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: counterCtrl2,
      maxLength: 40,
      decoration: const InputDecoration(
        labelText: 'custom counterText',
        helperText: 'counterText: "remaining: 17 chars".',
        counterText: 'remaining: 17 chars',
        counterStyle: TextStyle(color: Colors.deepPurple),
        border: OutlineInputBorder(),
      ),
    ),
  );

  final counterCtrl3 = TextEditingController(text: 'Hidden counter');
  final counterField3 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: counterCtrl3,
      maxLength: 100,
      decoration: const InputDecoration(
        labelText: 'counter hidden',
        helperText: 'counterText: "" hides the counter entirely.',
        counterText: '',
        border: OutlineInputBorder(),
      ),
    ),
  );

  final prefixCtrl1 = TextEditingController(text: '12345');
  final prefixField1 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: prefixCtrl1,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'prefixText + suffixText',
        helperText: 'prefixText: "+44 ", suffixText: " ext".',
        prefixText: '+44 ',
        suffixText: ' ext',
        border: OutlineInputBorder(),
      ),
    ),
  );

  final prefixCtrl2 = TextEditingController(text: 'github.com/handle');
  final prefixField2 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: prefixCtrl2,
      decoration: InputDecoration(
        labelText: 'prefix widget + suffix widget',
        helperText: 'prefix: chip widget; suffix: trailing badge.',
        prefix: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text('https://'),
        ),
        suffix: Container(
          margin: const EdgeInsets.only(left: 8),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text('verified'),
        ),
        border: const OutlineInputBorder(),
      ),
    ),
  );

  final prefixCtrl3 = TextEditingController(text: 'icon prefix + icon suffix');
  final prefixField3 = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextField(
      controller: prefixCtrl3,
      decoration: const InputDecoration(
        labelText: 'prefixIcon + suffixIcon',
        helperText: 'prefixIcon: leading; suffixIcon: trailing.',
        prefixIcon: Icon(Icons.bolt),
        suffixIcon: Icon(Icons.workspaces_outlined),
        border: OutlineInputBorder(),
      ),
    ),
  );

  final section10 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50.withOpacity(0.45),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.deepPurple.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection10,
        counterField1,
        counterField2,
        counterField3,
        prefixField1,
        prefixField2,
        prefixField3,
        _sectionFooter(
          'prefix / suffix widgets share vertical alignment rules with '
          'prefixText / suffixText but accept arbitrary children.',
        ),
      ],
    ),
  );
  print('SECTION 10 — counter/affix permutations composed.');

  // =========================================================================
  // SECTION 11 — Brightness theming row
  // -------------------------------------------------------------------------
  print('--- SECTION 11: Brightness theming row ---');

  final headerSection11 = _sectionHeader(
    title: 'Brightness theming row',
    subtitle:
        'A light-themed TextField beside a dark-themed TextField, both '
        'wired through a local Theme override.',
    color: Colors.blueGrey,
    icon: Icons.brightness_6,
  );

  final brightnessLightField = Theme(
    data: ThemeData(brightness: Brightness.light),
    child: Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: TextEditingController(text: 'Brightness.light surface'),
          decoration: const InputDecoration(
            labelText: 'light theme',
            helperText: 'ThemeData(brightness: Brightness.light).',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    ),
  );

  final brightnessDarkField = Theme(
    data: ThemeData(brightness: Brightness.dark),
    child: Material(
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: TextEditingController(text: 'Brightness.dark surface'),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'dark theme',
            helperText: 'ThemeData(brightness: Brightness.dark).',
            labelStyle: TextStyle(color: Colors.white70),
            helperStyle: TextStyle(color: Colors.white54),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white38),
            ),
          ),
        ),
      ),
    ),
  );

  final brightnessRow = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: brightnessLightField),
        const SizedBox(width: 12),
        Expanded(child: brightnessDarkField),
      ],
    ),
  );

  final section11 = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50.withOpacity(0.45),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.blueGrey.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerSection11,
        brightnessRow,
        _sectionFooter(
          'A local Theme override only affects descendants; the rest of the '
          'app retains its own brightness.',
        ),
      ],
    ),
  );
  print('SECTION 11 — brightness row composed.');

  // =========================================================================
  // SECTION 12 — Final summary card
  // -------------------------------------------------------------------------
  print('--- SECTION 12: Summary card ---');

  final summary = Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Colors.indigo.shade100, Colors.purple.shade100],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'This script composes a one-shot static demo of every advanced '
          'configuration knob exposed by Flutter\'s text-editing widgets: '
          'decoration variants, validation, autofill, selection theming, '
          'magnifier configuration, EditableText parameter surface, smart '
          'dashes/quotes, keyboard appearance, cursor styling and '
          'brightness theming.',
          style: TextStyle(fontSize: 14, height: 1.45),
        ),
        SizedBox(height: 12),
        Text(
          'No runtime mutation, no animation, no async work. Each '
          'TextEditingController is constructed inline with a static seed '
          'value so the first paint is also the final paint.',
          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );

  // =========================================================================
  // ROOT
  // =========================================================================
  print('--- composing root Scaffold ---');

  final scaffold = Scaffold(
    backgroundColor: const Color(0xFFF6F4FB),
    appBar: AppBar(
      title: const Text('Advanced text editing widgets — deep demo'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        children: <Widget>[
          _topTitleCard(),
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
          summary,
          const SizedBox(height: 36),
        ],
      ),
    ),
  );

  print('=========================================================');
  print(' Demo composed: 12 sections, fully static, analyzer-clean.');
  print('=========================================================');

  return scaffold;
}

// ---------------------------------------------------------------------------
// Synchronous validators used by Section 3.
// ---------------------------------------------------------------------------
String? _validateRequired(String? value) {
  if (value == null || value.isEmpty) {
    return 'required';
  }
  return null;
}

String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'required';
  }
  if (!value.contains('@')) {
    return 'not a valid email';
  }
  return null;
}

String? _validateMinLength(String? value) {
  final v = value ?? '';
  if (v.length < 6) {
    return 'minimum 6 characters';
  }
  return null;
}

String? _validatePhone(String? value) {
  final v = value ?? '';
  if (v.length < 7) {
    return 'phone too short';
  }
  return null;
}

String? _validateCurrency(String? value) {
  final v = value ?? '';
  if (v.isEmpty) {
    return 'required';
  }
  final parsed = double.tryParse(v);
  if (parsed == null) {
    return 'must be a number';
  }
  if (parsed < 0) {
    return 'must be non-negative';
  }
  return null;
}

String? _validateAlwaysOk(String? value) {
  return null;
}

// ---------------------------------------------------------------------------
// Layout helpers — all stateless, all pure.
// ---------------------------------------------------------------------------
Widget _topTitleCard() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Colors.indigo.shade400, Colors.purple.shade400],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'Advanced Text Editing Widgets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'TextField · TextFormField · EditableText · TextSelectionTheme · '
          'MagnifierConfiguration · Brightness · KeyboardAppearance',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    ),
  );
}

Widget _sectionHeader({
  required String title,
  required String subtitle,
  required Color color,
  required IconData icon,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(8, 12, 8, 4),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sectionFooter(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontStyle: FontStyle.italic,
        color: Colors.black54,
      ),
    ),
  );
}

Widget _kv(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 220,
          child: Text(
            key,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _themeSwatch(String name, TextSelectionThemeData data) {
  final cursor = data.cursorColor ?? Colors.black;
  final selection = data.selectionColor ?? Colors.transparent;
  final handle = data.selectionHandleColor ?? cursor;
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              _dot('cursor', cursor),
              const SizedBox(width: 8),
              _dot('selection', selection),
              const SizedBox(width: 8),
              _dot('handle', handle),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _dot(String label, Color color) {
  return Column(
    children: <Widget>[
      Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black26),
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 10)),
    ],
  );
}
