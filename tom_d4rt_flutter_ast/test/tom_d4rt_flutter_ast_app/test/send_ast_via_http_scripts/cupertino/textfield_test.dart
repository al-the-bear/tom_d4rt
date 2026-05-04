// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Live Demo for CupertinoTextField from cupertino
// CupertinoTextField is an iOS-style text input widget. This demo renders
// every variant as a live editable field so the harness preview shows the
// real widget rather than a static description.
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PRE-FLIGHT: build all controllers up front, prefilled with realistic text
  // so each rendered field starts in a meaningful state and the
  // "current value" captions render with content the eye can verify.
  // ===========================================================================

  // Section 1 — Plain field
  final plainCtrl = TextEditingController(text: 'Hello, Cupertino!');

  // Section 2 — Decorated variants
  final decoratedRectCtrl = TextEditingController(text: 'Boxed entry');
  final decoratedPillCtrl = TextEditingController(text: 'Pill-shaped entry');
  final decoratedShadowCtrl = TextEditingController(text: 'Shadowed entry');

  // Section 3 — Borderless variants
  final borderlessLightCtrl = TextEditingController(text: 'Borderless on light');
  final borderlessTintCtrl = TextEditingController(text: 'Borderless on tint');
  final borderlessDarkCtrl = TextEditingController(text: 'Borderless on dark');

  // Section 4 — Prefix / suffix icons
  final searchPrefixCtrl = TextEditingController(text: 'cupertino widgets');
  final clearSuffixCtrl = TextEditingController(text: 'tap suffix to clear');
  final bothFixCtrl = TextEditingController(text: 'user@example.com');

  // Section 5 — Password
  final passwordCtrl = TextEditingController(text: 'sup3rSecret!');

  // Section 6 — Multi-line prose
  final multiLineCtrl = TextEditingController(
    text: 'CupertinoTextField with maxLines: null grows vertically as the\n'
        'user types. This is the canonical comment box pattern on iOS\n'
        'where rows wrap and the field expands until the keyboard pushes\n'
        'the layout. Try editing this prose to watch it reflow live.',
  );

  // Section 7 — Numeric / formatted
  final digitsOnlyCtrl = TextEditingController(text: '1234567890');
  final phoneMaskCtrl = TextEditingController(text: '5551234567');

  // Section 8 — Max length with counter
  final maxLengthCtrl = TextEditingController(text: 'twelve chars');

  // Section 9 — Custom placeholder styling
  final placeholderStyledCtrl = TextEditingController();

  // Section 10 — clearButtonMode demos
  final clearAlwaysCtrl = TextEditingController(text: 'always-clear');
  final clearEditingCtrl = TextEditingController(text: 'editing-clear');
  final clearNeverCtrl = TextEditingController(text: 'never-clear');

  // Section 11 — Themed via CupertinoTheme
  final themedDarkCtrl = TextEditingController(text: 'Dark theme entry');

  // Section 12 — Disabled / read-only
  final disabledCtrl = TextEditingController(text: 'enabled = false');
  final readOnlyCtrl = TextEditingController(text: 'readOnly = true');

  // ===========================================================================
  // Brief debug summary so test logs still show useful traces.
  // ===========================================================================
  print('═══════════════════════════════════════════════════════════════════');
  print('   CUPERTINO TEXT FIELD LIVE HARNESS');
  print('═══════════════════════════════════════════════════════════════════');
  print('Sections rendered: 12');
  print('Controllers wired: 22');
  print('Plain field initial value: "${plainCtrl.text}"');
  print('Multi-line prose length: ${multiLineCtrl.text.length} chars');
  print('Phone mask raw digits: "${phoneMaskCtrl.text}"');
  print('Max length cap: 32 (current ${maxLengthCtrl.text.length})');
  print('Disabled field text: "${disabledCtrl.text}"');
  print('═══════════════════════════════════════════════════════════════════');

  // Palette per section — keeps each block visually distinct.
  final palette = <_SectionPalette>[
    _SectionPalette(
      tint: Color(0xFFEAF4FF),
      barTint: Color(0xFF1E6FFF),
      heading: Color(0xFF003C8F),
      body: Color(0xFF1A1A1A),
    ),
    _SectionPalette(
      tint: Color(0xFFFFF3E6),
      barTint: Color(0xFFFF7A00),
      heading: Color(0xFF8A4500),
      body: Color(0xFF1A1A1A),
    ),
    _SectionPalette(
      tint: Color(0xFFEFFFEE),
      barTint: Color(0xFF34A853),
      heading: Color(0xFF1B5E20),
      body: Color(0xFF1A1A1A),
    ),
    _SectionPalette(
      tint: Color(0xFFF3ECFF),
      barTint: Color(0xFF7A2BE2),
      heading: Color(0xFF3F1A7A),
      body: Color(0xFF1A1A1A),
    ),
    _SectionPalette(
      tint: Color(0xFFFFEBEE),
      barTint: Color(0xFFD93025),
      heading: Color(0xFF7A0E0E),
      body: Color(0xFF1A1A1A),
    ),
    _SectionPalette(
      tint: Color(0xFFE6FFFB),
      barTint: Color(0xFF00897B),
      heading: Color(0xFF004D40),
      body: Color(0xFF1A1A1A),
    ),
    _SectionPalette(
      tint: Color(0xFFFFFDE7),
      barTint: Color(0xFFC9A227),
      heading: Color(0xFF6F5500),
      body: Color(0xFF1A1A1A),
    ),
    _SectionPalette(
      tint: Color(0xFFE3F2FD),
      barTint: Color(0xFF1976D2),
      heading: Color(0xFF0D3C7A),
      body: Color(0xFF1A1A1A),
    ),
    _SectionPalette(
      tint: Color(0xFFFCE4EC),
      barTint: Color(0xFFD81B60),
      heading: Color(0xFF7A1543),
      body: Color(0xFF1A1A1A),
    ),
    _SectionPalette(
      tint: Color(0xFFEDE7F6),
      barTint: Color(0xFF5E35B1),
      heading: Color(0xFF311B92),
      body: Color(0xFF1A1A1A),
    ),
    _SectionPalette(
      tint: Color(0xFF1E1E2E),
      barTint: Color(0xFF8AB4F8),
      heading: Color(0xFFE8EAED),
      body: Color(0xFFE8EAED),
    ),
    _SectionPalette(
      tint: Color(0xFFEFEFEF),
      barTint: Color(0xFF616161),
      heading: Color(0xFF212121),
      body: Color(0xFF1A1A1A),
    ),
  ];

  // ===========================================================================
  // SECTION 1 — Plain field with controller-driven caption.
  // ===========================================================================
  final section1 = _section(
    palette: palette[0],
    number: 1,
    title: 'Plain CupertinoTextField',
    description:
        'The bare default constructor: rounded chrome, system grey divider, '
        'and a placeholder. The caption beside the field shows the current '
        'controller value so you can confirm typing flows through.',
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: CupertinoTextField(
              controller: plainCtrl,
              placeholder: 'Type something…',
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: _liveCaption(
              label: 'current value',
              listenable: plainCtrl,
              builder: () => '"${plainCtrl.text}"',
              palette: palette[0],
            ),
          ),
        ],
      ),
      SizedBox(height: 12),
      _bulletRow(
        '• Default chrome uses CupertinoColors.tertiarySystemFill.',
        palette[0],
      ),
      _bulletRow(
        '• padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10).',
        palette[0],
      ),
      _bulletRow(
        '• placeholder appears when the controller text is empty.',
        palette[0],
      ),
    ],
  );

  // ===========================================================================
  // SECTION 2 — Decorated: rectangular, pill, and with shadow.
  // ===========================================================================
  final section2 = _section(
    palette: palette[1],
    number: 2,
    title: 'Decorated variants',
    description:
        'BoxDecoration drives the visual chrome. Three flavours below: a '
        'classic rectangular border, a fully-rounded pill, and a subtle '
        'drop shadow on a white surface.',
    children: [
      Text('Rectangular border',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: palette[1].heading)),
      SizedBox(height: 6),
      CupertinoTextField(
        controller: decoratedRectCtrl,
        placeholder: 'Rectangular',
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: palette[1].barTint, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      SizedBox(height: 14),
      Text('Pill shape',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: palette[1].heading)),
      SizedBox(height: 6),
      CupertinoTextField(
        controller: decoratedPillCtrl,
        placeholder: 'Pill',
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFFFFF8F0),
          border: Border.all(color: palette[1].barTint, width: 1),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      SizedBox(height: 14),
      Text('Box shadow',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: palette[1].heading)),
      SizedBox(height: 6),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: CupertinoTextField(
          controller: decoratedShadowCtrl,
          placeholder: 'With shadow',
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      SizedBox(height: 12),
      _liveCaption(
        label: 'pill value',
        listenable: decoratedPillCtrl,
        builder: () => '"${decoratedPillCtrl.text}"',
        palette: palette[1],
      ),
    ],
  );

  // ===========================================================================
  // SECTION 3 — Borderless variants on different background tints.
  // ===========================================================================
  final section3 = _section(
    palette: palette[2],
    number: 3,
    title: 'Borderless variants',
    description:
        'CupertinoTextField.borderless removes the chrome entirely. Useful '
        'inside cards, headers, and chat composers. The three rows below '
        'place the same widget on different background tints so the '
        '"no-chrome" effect is obvious.',
    children: [
      _borderlessRow(
        bg: CupertinoColors.white,
        label: 'on white',
        controller: borderlessLightCtrl,
        palette: palette[2],
      ),
      SizedBox(height: 10),
      _borderlessRow(
        bg: Color(0xFFD8F2DA),
        label: 'on green tint',
        controller: borderlessTintCtrl,
        palette: palette[2],
      ),
      SizedBox(height: 10),
      _borderlessRow(
        bg: Color(0xFF1F2D24),
        label: 'on dark surface',
        controller: borderlessDarkCtrl,
        palette: palette[2],
        invert: true,
      ),
      SizedBox(height: 12),
      _liveCaption(
        label: 'tint row value',
        listenable: borderlessTintCtrl,
        builder: () => '"${borderlessTintCtrl.text}"',
        palette: palette[2],
      ),
    ],
  );

  // ===========================================================================
  // SECTION 4 — Prefix / suffix icons.
  // ===========================================================================
  final section4 = _section(
    palette: palette[3],
    number: 4,
    title: 'Prefix and suffix icons',
    description:
        'prefix and suffix slots take any widget. The first field shows a '
        'leading magnifier; the second a trailing clear glyph; the third '
        'combines an @ prefix with a check-mark suffix for a styled email '
        'field.',
    children: [
      Text('Search prefix',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: palette[3].heading)),
      SizedBox(height: 6),
      CupertinoTextField(
        controller: searchPrefixCtrl,
        placeholder: 'Search…',
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        prefix: Padding(
          padding: EdgeInsets.only(left: 8, right: 4),
          child: Icon(
            CupertinoIcons.search,
            size: 18,
            color: palette[3].barTint,
          ),
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: Color(0xFFCFC2EE)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      SizedBox(height: 12),
      Text('Clear suffix',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: palette[3].heading)),
      SizedBox(height: 6),
      CupertinoTextField(
        controller: clearSuffixCtrl,
        placeholder: 'Has trailing icon',
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        suffix: Padding(
          padding: EdgeInsets.only(left: 4, right: 8),
          child: Icon(
            CupertinoIcons.clear_circled_solid,
            size: 18,
            color: palette[3].barTint,
          ),
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: Color(0xFFCFC2EE)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      SizedBox(height: 12),
      Text('Prefix + suffix',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: palette[3].heading)),
      SizedBox(height: 6),
      CupertinoTextField(
        controller: bothFixCtrl,
        placeholder: 'name@example.com',
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        prefix: Padding(
          padding: EdgeInsets.only(left: 8, right: 4),
          child: Icon(
            CupertinoIcons.at,
            size: 18,
            color: palette[3].barTint,
          ),
        ),
        suffix: Padding(
          padding: EdgeInsets.only(left: 4, right: 8),
          child: Icon(
            CupertinoIcons.check_mark_circled,
            size: 18,
            color: Color(0xFF34A853),
          ),
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: Color(0xFFCFC2EE)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      SizedBox(height: 12),
      _liveCaption(
        label: 'email value',
        listenable: bothFixCtrl,
        builder: () => '"${bothFixCtrl.text}"',
        palette: palette[3],
      ),
    ],
  );

  // ===========================================================================
  // SECTION 5 — Password with lock + decorative eye.
  // ===========================================================================
  final section5 = _section(
    palette: palette[4],
    number: 5,
    title: 'Password field',
    description:
        'obscureText: true masks the input. The lock prefix is a common '
        'iOS affordance; the eye suffix is decorative here — there is no '
        'real toggle in this snippet, the icon just illustrates the '
        'classic show/hide affordance position.',
    children: [
      CupertinoTextField(
        controller: passwordCtrl,
        placeholder: 'Password',
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        obscureText: true,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        prefix: Padding(
          padding: EdgeInsets.only(left: 8, right: 4),
          child: Icon(
            CupertinoIcons.lock,
            size: 18,
            color: palette[4].barTint,
          ),
        ),
        suffix: Padding(
          padding: EdgeInsets.only(left: 4, right: 8),
          child: Icon(
            CupertinoIcons.eye,
            size: 18,
            color: palette[4].barTint,
          ),
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: Color(0xFFE6BCBC)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      SizedBox(height: 12),
      _liveCaption(
        label: 'length',
        listenable: passwordCtrl,
        builder: () => '${passwordCtrl.text.length} chars',
        palette: palette[4],
      ),
      SizedBox(height: 8),
      _bulletRow('• obscureText: true', palette[4]),
      _bulletRow('• autocorrect: false', palette[4]),
      _bulletRow('• keyboardType: visiblePassword', palette[4]),
    ],
  );

  // ===========================================================================
  // SECTION 6 — Multi-line prose composer.
  // ===========================================================================
  final section6 = _section(
    palette: palette[5],
    number: 6,
    title: 'Multi-line composer',
    description:
        'A capped maxLines (here: 8) lets the field grow vertically up to a '
        'visible cap. Combined with TextInputType.multiline the on-screen '
        'keyboard exposes a Return key that inserts newlines instead of '
        'submitting. NOTE: in stock Flutter `maxLines: null` would let the '
        'field grow without bound; the d4rt bridge currently collapses an '
        'explicit `null` named-argument back to the constructor default '
        '(`1`), which would violate the `minLines >= 1` invariant when '
        'paired with `minLines: 4`. A finite cap is the safe demo value.',
    children: [
      CupertinoTextField(
        controller: multiLineCtrl,
        placeholder: 'Tell us a story…',
        padding: EdgeInsets.all(12),
        maxLines: 8,
        minLines: 4,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: Color(0xFFA8D8C8)),
          borderRadius: BorderRadius.circular(10),
        ),
        style: TextStyle(fontSize: 14, height: 1.4),
      ),
      SizedBox(height: 12),
      _liveCaption(
        label: 'character count',
        listenable: multiLineCtrl,
        builder: () => '${multiLineCtrl.text.length}',
        palette: palette[5],
      ),
      SizedBox(height: 8),
      _bulletRow('• maxLines: 8 (cap; would be null in stock Flutter)', palette[5]),
      _bulletRow('• minLines: 4 (initial height)', palette[5]),
      _bulletRow('• keyboardType: TextInputType.multiline', palette[5]),
    ],
  );

  // ===========================================================================
  // SECTION 7 — Numeric / formatted with input formatters.
  // ===========================================================================
  final section7 = _section(
    palette: palette[6],
    number: 7,
    title: 'Numeric and formatted input',
    description:
        'inputFormatters block characters before they reach the model. The '
        'first field allows only digits; the second is a US-style phone '
        'mask that rejects non-digits and caps length at 10 raw digits.',
    children: [
      Text('Digits only',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: palette[6].heading)),
      SizedBox(height: 6),
      CupertinoTextField(
        controller: digitsOnlyCtrl,
        placeholder: '0123456789',
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: Color(0xFFE0CC85)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      SizedBox(height: 12),
      Text('Phone mask (max 10 digits)',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: palette[6].heading)),
      SizedBox(height: 6),
      CupertinoTextField(
        controller: phoneMaskCtrl,
        placeholder: '5551234567',
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        prefix: Padding(
          padding: EdgeInsets.only(left: 10, right: 4),
          child: Text(
            '+1',
            style: TextStyle(
              fontSize: 14,
              color: palette[6].heading,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: Color(0xFFE0CC85)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      SizedBox(height: 12),
      _liveCaption(
        label: 'digits only value',
        listenable: digitsOnlyCtrl,
        builder: () => '"${digitsOnlyCtrl.text}"',
        palette: palette[6],
      ),
      SizedBox(height: 6),
      _liveCaption(
        label: 'phone raw',
        listenable: phoneMaskCtrl,
        builder: () => _formatPhone(phoneMaskCtrl.text),
        palette: palette[6],
      ),
    ],
  );

  // ===========================================================================
  // SECTION 8 — Max length with manual counter (no built-in counter on
  // CupertinoTextField, so we render one ourselves from the controller).
  // ===========================================================================
  final section8 = _section(
    palette: palette[7],
    number: 8,
    title: 'Max length with counter',
    description:
        'CupertinoTextField has maxLength but no built-in counter widget. '
        'The harness renders an "n/32" counter beneath the field by '
        'listening to the controller. The counter switches colour when '
        'the input nears the limit.',
    children: [
      CupertinoTextField(
        controller: maxLengthCtrl,
        placeholder: 'up to 32 characters',
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        maxLength: 32,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: Color(0xFFB6CFE9)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      SizedBox(height: 8),
      _CounterCaption(controller: maxLengthCtrl, max: 32, palette: palette[7]),
      SizedBox(height: 6),
      _bulletRow(
        '• Caps text at maxLength = 32 characters.',
        palette[7],
      ),
      _bulletRow(
        '• Counter is rendered by the harness, not the widget.',
        palette[7],
      ),
    ],
  );

  // ===========================================================================
  // SECTION 9 — Custom placeholder styling.
  // ===========================================================================
  final section9 = _section(
    palette: palette[8],
    number: 9,
    title: 'Custom placeholder styling',
    description:
        'placeholderStyle accepts a TextStyle independent of the input '
        'style. This field uses italic mauve text to tell the user the '
        'control is optional. Clear the field via the suffix to see the '
        'placeholder styling.',
    children: [
      CupertinoTextField(
        controller: placeholderStyledCtrl,
        placeholder: 'Optional — say something nice',
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        placeholderStyle: TextStyle(
          color: palette[8].barTint,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        style: TextStyle(
          fontSize: 14,
          color: palette[8].heading,
        ),
        clearButtonMode: OverlayVisibilityMode.editing,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: palette[8].barTint.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      SizedBox(height: 12),
      _liveCaption(
        label: 'value',
        listenable: placeholderStyledCtrl,
        builder: () => placeholderStyledCtrl.text.isEmpty
            ? '(empty — placeholder visible)'
            : '"${placeholderStyledCtrl.text}"',
        palette: palette[8],
      ),
    ],
  );

  // ===========================================================================
  // SECTION 10 — clearButtonMode demonstration.
  // ===========================================================================
  final section10 = _section(
    palette: palette[9],
    number: 10,
    title: 'clearButtonMode comparison',
    description:
        'CupertinoTextField bakes in an iOS-style clear button. The three '
        'fields below differ only in clearButtonMode so you can see when '
        'the X glyph appears: always, while editing, or never.',
    children: [
      _clearModeColumn(
        label: 'always',
        controller: clearAlwaysCtrl,
        mode: OverlayVisibilityMode.always,
        palette: palette[9],
      ),
      SizedBox(height: 12),
      _clearModeColumn(
        label: 'editing',
        controller: clearEditingCtrl,
        mode: OverlayVisibilityMode.editing,
        palette: palette[9],
      ),
      SizedBox(height: 12),
      _clearModeColumn(
        label: 'never',
        controller: clearNeverCtrl,
        mode: OverlayVisibilityMode.never,
        palette: palette[9],
      ),
      SizedBox(height: 8),
      _bulletRow(
        '• always: the X is shown whenever there is text.',
        palette[9],
      ),
      _bulletRow(
        '• editing: the X appears only while the field is focused.',
        palette[9],
      ),
      _bulletRow(
        '• never: the field never shows the built-in clear button.',
        palette[9],
      ),
    ],
  );

  // ===========================================================================
  // SECTION 11 — Themed via CupertinoTheme.
  // ===========================================================================
  final section11 = _section(
    palette: palette[10],
    number: 11,
    title: 'CupertinoTheme override',
    description:
        'Wrapping a subtree in CupertinoTheme switches default colours, '
        'including the cursor and selection highlight. The field below '
        'inherits a dark Brightness with a custom primary colour.',
    children: [
      CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF8AB4F8),
          textTheme: CupertinoTextThemeData(
            primaryColor: Color(0xFF8AB4F8),
            textStyle: TextStyle(
              color: Color(0xFFE8EAED),
              fontSize: 14,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF12121A),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFF2C2C3A)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inside dark CupertinoTheme:',
                style: TextStyle(
                  color: Color(0xFFE8EAED),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              CupertinoTextField(
                controller: themedDarkCtrl,
                placeholder: 'Dark themed entry…',
                placeholderStyle: TextStyle(
                  color: Color(0xFF9AA0A6),
                  fontStyle: FontStyle.italic,
                ),
                style: TextStyle(
                  color: Color(0xFFE8EAED),
                  fontSize: 14,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF1C1C26),
                  border: Border.all(color: Color(0xFF3C3C4A)),
                  borderRadius: BorderRadius.circular(8),
                ),
                cursorColor: Color(0xFF8AB4F8),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 12),
      _liveCaption(
        label: 'themed value',
        listenable: themedDarkCtrl,
        builder: () => '"${themedDarkCtrl.text}"',
        palette: palette[10],
      ),
    ],
  );

  // ===========================================================================
  // SECTION 12 — Disabled / read-only side-by-side.
  // ===========================================================================
  final section12 = _section(
    palette: palette[11],
    number: 12,
    title: 'Disabled vs read-only',
    description:
        'Two forms of "non-editable": enabled: false greys out the chrome '
        'and blocks focus entirely, while readOnly: true keeps the field '
        'focusable and selectable but rejects keyboard input. Both share '
        'the same controller pattern.',
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'enabled: false',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: palette[11].heading,
                  ),
                ),
                SizedBox(height: 6),
                CupertinoTextField(
                  controller: disabledCtrl,
                  enabled: false,
                  placeholder: 'disabled',
                  padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E6E6),
                    border: Border.all(color: Color(0xFFC0C0C0)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 6),
                _bulletRow(
                  '• Cannot focus or edit.',
                  palette[11],
                ),
                _bulletRow(
                  '• Chrome rendered in disabled style.',
                  palette[11],
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'readOnly: true',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: palette[11].heading,
                  ),
                ),
                SizedBox(height: 6),
                CupertinoTextField(
                  controller: readOnlyCtrl,
                  readOnly: true,
                  placeholder: 'read only',
                  padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    border: Border.all(color: Color(0xFF9E9E9E)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 6),
                _bulletRow(
                  '• Focusable, selectable, copyable.',
                  palette[11],
                ),
                _bulletRow(
                  '• Keyboard cannot mutate text.',
                  palette[11],
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      _liveCaption(
        label: 'disabled value',
        listenable: disabledCtrl,
        builder: () => '"${disabledCtrl.text}"',
        palette: palette[11],
      ),
      SizedBox(height: 6),
      _liveCaption(
        label: 'read-only value',
        listenable: readOnlyCtrl,
        builder: () => '"${readOnlyCtrl.text}"',
        palette: palette[11],
      ),
    ],
  );

  // ===========================================================================
  // FINAL ASSEMBLY
  // ===========================================================================
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('CupertinoTextField — live demo'),
        backgroundColor: Color(0xF2F8F8F8),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _heroBanner(),
              SizedBox(height: 16),
              section1,
              SizedBox(height: 14),
              section2,
              SizedBox(height: 14),
              section3,
              SizedBox(height: 14),
              section4,
              SizedBox(height: 14),
              section5,
              SizedBox(height: 14),
              section6,
              SizedBox(height: 14),
              section7,
              SizedBox(height: 14),
              section8,
              SizedBox(height: 14),
              section9,
              SizedBox(height: 14),
              section10,
              SizedBox(height: 14),
              section11,
              SizedBox(height: 14),
              section12,
              SizedBox(height: 18),
              _footer(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// HELPERS
// =============================================================================

class _SectionPalette {
  final Color tint;
  final Color barTint;
  final Color heading;
  final Color body;
  const _SectionPalette({
    required this.tint,
    required this.barTint,
    required this.heading,
    required this.body,
  });
}

Widget _section({
  required _SectionPalette palette,
  required int number,
  required String title,
  required String description,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: palette.tint,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: palette.barTint.withOpacity(0.35), width: 1),
    ),
    padding: EdgeInsets.all(0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Numbered title bar
        Container(
          decoration: BoxDecoration(
            color: palette.barTint,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '#$number',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.5,
                  color: palette.body,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _liveCaption({
  required String label,
  required Listenable listenable,
  required String Function() builder,
  required _SectionPalette palette,
}) {
  return AnimatedBuilder(
    animation: listenable,
    builder: (BuildContext _, Widget? _) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Color(0x22FFFFFF),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: palette.barTint.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Text(
              '$label:',
              style: TextStyle(
                fontSize: 11,
                color: palette.heading,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                builder(),
                style: TextStyle(
                  fontSize: 12,
                  color: palette.body,
                  fontFamily: 'monospace',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _bulletRow(String text, _SectionPalette palette) {
  return Padding(
    padding: EdgeInsets.only(top: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: palette.body,
        height: 1.3,
      ),
    ),
  );
}

Widget _borderlessRow({
  required Color bg,
  required String label,
  required TextEditingController controller,
  required _SectionPalette palette,
  bool invert = false,
}) {
  final fg = invert ? Color(0xFFE8EAED) : palette.heading;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: palette.barTint.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ),
        Expanded(
          child: CupertinoTextField.borderless(
            controller: controller,
            placeholder: 'Type here…',
            placeholderStyle: TextStyle(
              color: invert ? Color(0xFF9AA0A6) : Color(0xFF9E9E9E),
              fontStyle: FontStyle.italic,
            ),
            style: TextStyle(
              fontSize: 14,
              color: fg,
            ),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            cursorColor: invert ? Color(0xFF8AB4F8) : palette.barTint,
          ),
        ),
      ],
    ),
  );
}

Widget _clearModeColumn({
  required String label,
  required TextEditingController controller,
  required OverlayVisibilityMode mode,
  required _SectionPalette palette,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: palette.barTint,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            'clearButtonMode: $label',
            style: TextStyle(
              fontSize: 12,
              color: palette.heading,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      SizedBox(height: 6),
      CupertinoTextField(
        controller: controller,
        placeholder: 'tap to focus',
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        clearButtonMode: mode,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.all(color: palette.barTint.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );
}

class _CounterCaption extends StatefulWidget {
  final TextEditingController controller;
  final int max;
  final _SectionPalette palette;
  const _CounterCaption({
    required this.controller,
    required this.max,
    required this.palette,
  });

  @override
  State<_CounterCaption> createState() => _CounterCaptionState();
}

class _CounterCaptionState extends State<_CounterCaption> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.controller.text.length;
    final ratio = n / widget.max;
    final danger = ratio >= 0.9;
    final warn = ratio >= 0.7 && !danger;
    final color = danger
        ? Color(0xFFD93025)
        : warn
            ? Color(0xFFB07A00)
            : widget.palette.heading;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '$n / ${widget.max}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

String _formatPhone(String raw) {
  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) return '(empty)';
  if (digits.length < 4) return '(${digits.padRight(3, '·')})';
  if (digits.length < 7) {
    final p1 = digits.substring(0, 3);
    final p2 = digits.substring(3);
    return '($p1) $p2';
  }
  if (digits.length <= 10) {
    final p1 = digits.substring(0, 3);
    final p2 = digits.substring(3, 6);
    final p3 = digits.substring(6);
    return '($p1) $p2-$p3';
  }
  return digits;
}

Widget _heroBanner() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1E6FFF), Color(0xFF7A2BE2)],
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CupertinoTextField',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Twelve live, hand-built scenarios covering every commonly used '
          'parameter on the iOS-style text input — from default chrome to '
          'borderless variants, decoration overrides, prefix/suffix slots, '
          'password masking, multi-line composers, input formatters, '
          'maxLength counters, themed subtrees and disabled / read-only '
          'states.',
          style: TextStyle(
            color: Color(0xFFEFEFEF),
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _footer() {
  return Center(
    child: Column(
      children: [
        Text(
          'Live Demo • CupertinoTextField • 12 Sections',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF6E6E73),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'All fields above are real CupertinoTextField widgets backed by '
          'live TextEditingControllers — interact with them to see the '
          'captions update.',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF8E8E93),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
