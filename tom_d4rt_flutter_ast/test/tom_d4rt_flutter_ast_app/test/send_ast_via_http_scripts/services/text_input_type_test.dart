// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // TEXT INPUT TYPES — A FIELD GUIDE TO THE PLATFORM IME CONTRACT
  // ============================================================
  //
  // Every TextField that ever blinked a cursor on a phone screen
  // sent a quiet little postcard to the operating system: "please,
  // for this particular box, show the user the most appropriate
  // virtual keyboard." That postcard's address is a TextInputType.
  //
  // It is, importantly, ONLY a hint. Flutter does not draw the OS
  // keyboard. Flutter does not validate the keystrokes. Flutter
  // simply tips a wink to Android, iOS, web, or desktop and asks
  // them politely to put a useful glyph layout in front of the
  // human. The OS may oblige; the OS may shrug; on desktop the
  // OS will almost certainly shrug because there is no virtual
  // keyboard to summon in the first place. This nuance is the
  // single most-misunderstood thing about TextInputType, and the
  // reason this demo exists.
  //
  // We will visit thirteen jacks on the patch panel:
  //
  //   text             — plain default keyboard
  //   multiline        — adds a Return / newline key
  //   number           — purely numeric pad
  //   number(decimal)  — numeric pad WITH a decimal point glyph
  //   number(signed)   — numeric pad WITH a minus glyph
  //   number(both)     — numeric pad WITH both
  //   phone            — telephony dialer layout
  //   datetime         — limited platform support; mostly text
  //   emailAddress     — keyboard with prominent @ and . keys
  //   url              — keyboard with prominent / and .com keys
  //   visiblePassword  — text-style with no autocorrect, visible
  //   name             — autocapitalised name-input layout
  //   streetAddress    — multi-line address layout
  //   none             — explicitly suppresses the IME
  //   webSearch        — keyboard with a "Go" or "Search" key
  //   twitter          — keyboard with prominent @ and # keys
  //
  // The widgets below are READ-ONLY: every TextField is wired to
  // a pre-populated TextEditingController and decorated as
  // enabled: false. Why? Because d4rt evaluates this build()
  // expression once, sends the AST to the host, and the host
  // never calls dispose. Live-typing controllers would leak. By
  // pre-filling them with a sample value we get a faithful
  // typographic preview without needing input focus.
  //
  // PALETTE (every colour referenced below — scan once, then on
  // with the show):
  //
  //   ink-deep         = 0xFF101522  (background, deepest)
  //   ink-mid          = 0xFF1A2138  (cards, surfaces)
  //   ink-rise         = 0xFF252E4C  (raised elements)
  //   parchment        = 0xFFF5EFE0  (text on dark)
  //   parchment-warm   = 0xFFE8DCC0  (subhead)
  //   accent-ember     = 0xFFE8763A  (primary accent)
  //   accent-amber     = 0xFFF2A65A  (secondary accent)
  //   accent-leaf      = 0xFF4A8C5C  (positive)
  //   accent-leaf-dark = 0xFF2F6440  (positive deep)
  //   accent-coral     = 0xFFD8554F  (warning)
  //   accent-coral-dk  = 0xFF8E2D27  (warning deep)
  //   accent-azure     = 0xFF4A78B0  (info)
  //   accent-azure-dk  = 0xFF2A4F7C  (info deep)
  //   accent-violet    = 0xFF7E5BA8  (specials)
  //   keycap-grey      = 0xFFD4D2CC  (keyboard graphic)
  //   keycap-dark      = 0xFFB0AEA8  (keyboard graphic shading)
  //
  // Read-only mantra: do not type, do not focus, do not dispose.
  // A demo, not an app. Now: lift the lid, behold the keys.
  // ============================================================

  const Color inkDeep = Color(0xFF101522);
  const Color inkMid = Color(0xFF1A2138);
  const Color inkRise = Color(0xFF252E4C);
  const Color inkHigher = Color(0xFF313B5E);
  const Color parchment = Color(0xFFF5EFE0);
  const Color parchmentWarm = Color(0xFFE8DCC0);
  const Color parchmentDim = Color(0xFFB8AE96);
  const Color accentEmber = Color(0xFFE8763A);
  const Color accentEmberDark = Color(0xFFA84F1F);
  const Color accentAmber = Color(0xFFF2A65A);
  const Color accentLeaf = Color(0xFF4A8C5C);
  const Color accentLeafDark = Color(0xFF2F6440);
  const Color accentCoral = Color(0xFFD8554F);
  const Color accentCoralDark = Color(0xFF8E2D27);
  const Color accentAzure = Color(0xFF4A78B0);
  const Color accentAzureDark = Color(0xFF2A4F7C);
  const Color accentViolet = Color(0xFF7E5BA8);
  const Color accentVioletDark = Color(0xFF54376E);
  const Color keycapGrey = Color(0xFFD4D2CC);
  const Color keycapDark = Color(0xFFB0AEA8);
  const Color keycapShadow = Color(0xFF6E6C66);
  const Color cardBorder = Color(0xFF3D4768);

  // ----------------------------------------------------------
  // GRADIENT POOL (≥6 — we have nine, well over the floor).
  // ----------------------------------------------------------

  const LinearGradient backdropGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF0B1020), Color(0xFF1A2138), Color(0xFF252E4C)],
    stops: <double>[0.0, 0.55, 1.0],
  );

  const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFE8763A),
      Color(0xFFF2A65A),
      Color(0xFFE8C063),
    ],
  );

  const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFF252E4C), Color(0xFF1A2138)],
  );

  const LinearGradient cardGradientWarm = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF313B5E), Color(0xFF1A2138)],
  );

  const LinearGradient leafGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF4A8C5C), Color(0xFF2F6440)],
  );

  const LinearGradient coralGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFFD8554F), Color(0xFF8E2D27)],
  );

  const LinearGradient azureGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF4A78B0), Color(0xFF2A4F7C)],
  );

  const LinearGradient violetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF7E5BA8), Color(0xFF54376E)],
  );

  const LinearGradient keyboardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFFD4D2CC), Color(0xFFB0AEA8)],
  );

  // ----------------------------------------------------------
  // SHADOW POOL (≥6 — we have eight).
  // ----------------------------------------------------------

  final List<BoxShadow> heroShadow = <BoxShadow>[
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.55),
      blurRadius: 28,
      offset: const Offset(0, 14),
    ),
    BoxShadow(
      color: accentEmber.withValues(alpha: 0.25),
      blurRadius: 40,
      offset: const Offset(0, 0),
    ),
  ];

  final List<BoxShadow> cardShadow = <BoxShadow>[
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.5),
      blurRadius: 14,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.3),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  final List<BoxShadow> keycapShadowList = <BoxShadow>[
    BoxShadow(
      color: keycapShadow.withValues(alpha: 0.65),
      blurRadius: 2,
      offset: const Offset(0, 2),
    ),
  ];

  final List<BoxShadow> stampShadow = <BoxShadow>[
    BoxShadow(
      color: accentEmber.withValues(alpha: 0.4),
      blurRadius: 18,
      offset: const Offset(0, 6),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.4),
      blurRadius: 6,
      offset: const Offset(0, 3),
    ),
  ];

  final List<BoxShadow> coralShadow = <BoxShadow>[
    BoxShadow(
      color: accentCoral.withValues(alpha: 0.35),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  final List<BoxShadow> leafShadow = <BoxShadow>[
    BoxShadow(
      color: accentLeaf.withValues(alpha: 0.35),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  final List<BoxShadow> azureShadow = <BoxShadow>[
    BoxShadow(
      color: accentAzure.withValues(alpha: 0.35),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  final List<BoxShadow> deepInsetShadow = <BoxShadow>[
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.6),
      blurRadius: 22,
      offset: const Offset(0, 12),
    ),
  ];

  // ----------------------------------------------------------
  // CONTROLLERS — declared inline as locals. d4rt evaluates this
  // build() once per request and never calls dispose, which is
  // why we DO NOT register them with a State and DO NOT attempt
  // any teardown. A small, deliberate, documented leak for the
  // sake of demo simplicity. In a real app you would absolutely
  // hold these in a StatefulWidget and dispose them.
  // ----------------------------------------------------------

  final TextEditingController ctrlText =
      TextEditingController(text: 'Hello, world. The cat sat on the mat.');
  final TextEditingController ctrlMultiline = TextEditingController(
    text: 'First line of a multiline note.\n'
        'Second line, after a Return key press.\n'
        'Third and final line, deliberately long enough to wrap '
        'so we can see how the field handles soft-wrapping in '
        'addition to hard line breaks.',
  );
  final TextEditingController ctrlNumber =
      TextEditingController(text: '4815162342');
  final TextEditingController ctrlNumberDecimal =
      TextEditingController(text: '3.14159');
  final TextEditingController ctrlNumberSigned =
      TextEditingController(text: '-273');
  final TextEditingController ctrlNumberBoth =
      TextEditingController(text: '-98.6');
  final TextEditingController ctrlPhone =
      TextEditingController(text: '+1 (415) 555-0177');
  final TextEditingController ctrlDatetime =
      TextEditingController(text: '2026-05-10 14:30');
  final TextEditingController ctrlEmail =
      TextEditingController(text: 'alexis.kyaw@gmail.com');
  final TextEditingController ctrlUrl =
      TextEditingController(text: 'https://flutter.dev/docs');
  final TextEditingController ctrlVisiblePassword =
      TextEditingController(text: 'CorrectHorseBatteryStaple');
  final TextEditingController ctrlOpaquePassword =
      TextEditingController(text: 'CorrectHorseBatteryStaple');
  final TextEditingController ctrlName =
      TextEditingController(text: 'Ada Lovelace');
  final TextEditingController ctrlStreet = TextEditingController(
    text: '221B Baker Street\nMarylebone\nLondon NW1 6XE\nUnited Kingdom',
  );
  final TextEditingController ctrlNone =
      TextEditingController(text: 'no IME shown for this field');
  final TextEditingController ctrlWebSearch =
      TextEditingController(text: 'how does TextInputType.webSearch differ');
  final TextEditingController ctrlTwitter =
      TextEditingController(text: '@flutterdev #flutter is great');

  // composite registration form controllers
  final TextEditingController formCtrlName =
      TextEditingController(text: 'Grace Hopper');
  final TextEditingController formCtrlEmail =
      TextEditingController(text: 'grace@navy.example.mil');
  final TextEditingController formCtrlPhone =
      TextEditingController(text: '+1 (202) 555-0142');
  final TextEditingController formCtrlAddress = TextEditingController(
    text: '4555 Overlook Avenue SW\nWashington, DC 20375\nUSA',
  );
  final TextEditingController formCtrlPassword =
      TextEditingController(text: 'COBOL-1959-Mark-I');

  // single vs multiline contrast section controllers
  final TextEditingController ctrlSingleNarrow =
      TextEditingController(text: 'Concise. One line. No newline key.');
  final TextEditingController ctrlMultiTall = TextEditingController(
    text: 'In a multiline TextField the IME serves up a Return\n'
        'key. Pressing it inserts a literal newline character\n'
        'into the controller value. The field grows as needed,\n'
        'or scrolls if you cap maxLines and content overflows.',
  );

  // ----------------------------------------------------------
  // TEXT STYLE CONSTANTS
  // ----------------------------------------------------------

  const TextStyle bodyStyle = TextStyle(
    color: parchment,
    fontSize: 15,
    height: 1.55,
  );

  const TextStyle bodyDimStyle = TextStyle(
    color: parchmentDim,
    fontSize: 14,
    height: 1.5,
  );

  const TextStyle h1Style = TextStyle(
    color: parchment,
    fontSize: 56,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.2,
    height: 1.04,
  );

  const TextStyle h2Style = TextStyle(
    color: parchment,
    fontSize: 30,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.4,
    height: 1.18,
  );

  const TextStyle h3Style = TextStyle(
    color: parchmentWarm,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.25,
  );

  const TextStyle subStyle = TextStyle(
    color: accentAmber,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.6,
  );

  const TextStyle codeStyle = TextStyle(
    color: parchment,
    fontFamily: 'monospace',
    fontSize: 14,
    height: 1.45,
  );

  const TextStyle labelStyle = TextStyle(
    color: parchmentWarm,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
  );

  // ----------------------------------------------------------
  // SECTION 1 — HERO
  // ----------------------------------------------------------

  final Widget heroSection = Container(
    margin: const EdgeInsets.fromLTRB(28, 36, 28, 24),
    padding: const EdgeInsets.fromLTRB(36, 44, 36, 44),
    decoration: BoxDecoration(
      gradient: cardGradient,
      borderRadius: BorderRadius.circular(28),
      border: Border.all(color: cardBorder, width: 1.5),
      boxShadow: heroShadow,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  gradient: heroGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: stampShadow,
                ),
                child: const Text(
                  'TEXTINPUTTYPE  ·  PLATFORM IME HINTS',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Text Input Types', style: h1Style),
              const SizedBox(height: 14),
              const SizedBox(
                width: 540,
                child: Text(
                  'A field guide to the thirteen jacks on the patch panel '
                  'between Flutter and the operating system. Each one is a '
                  'polite request — never a guarantee — for a particular '
                  'on-screen keyboard layout.',
                  style: bodyStyle,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  _PrivateBadge(
                    label: '13 INPUT TYPES',
                    gradient: leafGradient,
                    shadows: leafShadow,
                  ),
                  const SizedBox(width: 10),
                  _PrivateBadge(
                    label: '4 NUMBER VARIANTS',
                    gradient: azureGradient,
                    shadows: azureShadow,
                  ),
                  const SizedBox(width: 10),
                  _PrivateBadge(
                    label: 'READ-ONLY DEMO',
                    gradient: coralGradient,
                    shadows: coralShadow,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 28),
        Expanded(
          flex: 4,
          child: _PrivateKeyboardGraphic(
            keycapGradient: keyboardGradient,
            keycapShadows: keycapShadowList,
            accent: accentEmber,
          ),
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // SECTION 2 — ANATOMY OF TEXTINPUTTYPE
  // ----------------------------------------------------------

  final Widget anatomySection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    padding: const EdgeInsets.fromLTRB(32, 28, 32, 32),
    decoration: BoxDecoration(
      gradient: cardGradientWarm,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: cardBorder, width: 1.2),
      boxShadow: cardShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('CHAPTER ONE', style: subStyle),
        const SizedBox(height: 6),
        const Text('Anatomy of a TextInputType', style: h2Style),
        const SizedBox(height: 16),
        const Text(
          'A TextInputType is, fundamentally, a tiny envelope: a '
          'string label plus two optional booleans (signed and '
          'decimal). Flutter ships that envelope across the platform '
          'channel to the host OS, and the host OS — Android, iOS, '
          'web, macOS, Windows, Linux, Fuchsia, whatever — decides '
          'how to staff a virtual keyboard with that hint in mind.',
          style: bodyStyle,
        ),
        const SizedBox(height: 18),
        _PrivateAnatomyDiagram(
          accent: accentEmber,
          accentDark: accentEmberDark,
          parchment: parchment,
          parchmentDim: parchmentDim,
          inkRise: inkRise,
          inkHigher: inkHigher,
          shadows: cardShadow,
        ),
        const SizedBox(height: 20),
        const Text(
          'Crucially, the OS may IGNORE the hint. Desktop platforms '
          'often have no virtual keyboard at all — the hint becomes '
          'an autofill / accessibility breadcrumb. iOS has no native '
          'phone-only keyboard layout that exactly matches Android\'s '
          'phone dialer. Web browsers vary wildly. The contract is '
          '"best effort, not best guarantee."',
          style: bodyDimStyle,
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // SECTION 3 — GALLERY OF INPUT TYPES
  // helper to build a uniform card
  // ----------------------------------------------------------

  Widget makeGalleryCard({
    required String typeName,
    required String constructor,
    required String description,
    required String osBehavior,
    required Widget field,
    required LinearGradient stamp,
    required List<BoxShadow> stampShadows,
  }) {
    return Container(
      width: 420,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cardBorder, width: 1.0),
        boxShadow: cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: stamp,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: stampShadows,
                ),
                child: Text(
                  typeName.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF101010),
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  constructor,
                  style: const TextStyle(
                    color: parchmentDim,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: bodyStyle),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: inkDeep,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: cardBorder, width: 1),
            ),
            child: Text(
              'OS layout: $osBehavior',
              style: const TextStyle(
                color: parchmentWarm,
                fontStyle: FontStyle.italic,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 12),
          field,
        ],
      ),
    );
  }

  // shared, themed read-only TextField factory
  Widget readOnlyField({
    required TextEditingController controller,
    required TextInputType keyboardType,
    String? hint,
    int maxLines = 1,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: true,
      enabled: false,
      maxLines: obscureText ? 1 : maxLines,
      obscureText: obscureText,
      style: const TextStyle(
        color: parchment,
        fontSize: 15,
        fontFamily: 'monospace',
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: inkDeep,
        hintText: hint,
        hintStyle: const TextStyle(color: parchmentDim),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: cardBorder, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: cardBorder, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: accentEmber, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (String _) {},
    );
  }

  final List<Widget> galleryCards = <Widget>[
    makeGalleryCard(
      typeName: 'text',
      constructor: 'TextInputType.text',
      description: 'The default. A standard alphanumeric keyboard with '
          'autocorrect, autocapitalisation as configured, and the usual '
          'punctuation row. Use it whenever no other type fits.',
      osBehavior: 'Standard QWERTY (or locale equivalent) with full row of '
          'punctuation and an Enter key for submit.',
      stamp: heroGradient,
      stampShadows: stampShadow,
      field: readOnlyField(
        controller: ctrlText,
        keyboardType: TextInputType.text,
      ),
    ),
    makeGalleryCard(
      typeName: 'multiline',
      constructor: 'TextInputType.multiline',
      description: 'Replaces the IME submit key with a Return / newline '
          'key, allowing the controller value to contain literal "\\n" '
          'characters. Pair with maxLines: null or a number > 1.',
      osBehavior: 'Standard QWERTY with the action key replaced by a Return '
          'key that inserts \\n into the field.',
      stamp: leafGradient,
      stampShadows: leafShadow,
      field: readOnlyField(
        controller: ctrlMultiline,
        keyboardType: TextInputType.multiline,
        maxLines: 4,
      ),
    ),
    makeGalleryCard(
      typeName: 'number',
      constructor: 'TextInputType.number',
      description: 'A purely numeric pad. No decimal point, no minus sign. '
          'Equivalent to TextInputType.numberWithOptions(signed: false, '
          'decimal: false).',
      osBehavior: '0–9 grid; on iOS often a 10-key calculator layout, on '
          'Android a numeric pad with a Done key.',
      stamp: azureGradient,
      stampShadows: azureShadow,
      field: readOnlyField(
        controller: ctrlNumber,
        keyboardType: TextInputType.number,
      ),
    ),
    makeGalleryCard(
      typeName: 'number(decimal)',
      constructor: 'numberWithOptions(decimal: true)',
      description: 'Numeric pad WITH a decimal-point glyph (locale-aware: '
          'a comma in many European locales). Use for currency, weights, '
          'distances, percentages.',
      osBehavior: '0–9 grid plus a decimal separator key; the actual glyph '
          'is supplied by the locale, not by Flutter.',
      stamp: azureGradient,
      stampShadows: azureShadow,
      field: readOnlyField(
        controller: ctrlNumberDecimal,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
    ),
    makeGalleryCard(
      typeName: 'number(signed)',
      constructor: 'numberWithOptions(signed: true)',
      description: 'Numeric pad WITH a minus / plus glyph for entering '
          'negative numbers. Use for temperatures, deltas, GPS '
          'coordinates, accounting figures.',
      osBehavior: '0–9 grid plus a minus / plus-minus key. The OS may or '
          'may not enforce that the sign appears only at the start.',
      stamp: azureGradient,
      stampShadows: azureShadow,
      field: readOnlyField(
        controller: ctrlNumberSigned,
        keyboardType: const TextInputType.numberWithOptions(signed: true),
      ),
    ),
    makeGalleryCard(
      typeName: 'number(both)',
      constructor: 'numberWithOptions(signed: true, decimal: true)',
      description: 'Numeric pad with BOTH a sign glyph AND a decimal '
          'separator. The richest of the four numeric variants. Default '
          'for most general-purpose numeric inputs.',
      osBehavior: '0–9 grid plus both decimal separator and minus / plus '
          'glyphs.',
      stamp: azureGradient,
      stampShadows: azureShadow,
      field: readOnlyField(
        controller: ctrlNumberBoth,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
      ),
    ),
    makeGalleryCard(
      typeName: 'phone',
      constructor: 'TextInputType.phone',
      description: 'A telephony dialer layout: 0–9, plus a hash, asterisk, '
          'and (on Android) a dedicated plus key for international '
          'prefixes. Critically, NOT iOS-native — see pitfalls.',
      osBehavior: 'Android: 12-key phone dialer with #, *, +. iOS: numeric '
          'pad with phone-friendly punctuation; no exclusive dialer.',
      stamp: violetGradient,
      stampShadows: stampShadow,
      field: readOnlyField(
        controller: ctrlPhone,
        keyboardType: TextInputType.phone,
      ),
    ),
    makeGalleryCard(
      typeName: 'datetime',
      constructor: 'TextInputType.datetime',
      description: 'Hint that the value is a date and / or time. Platform '
          'support is patchy: most platforms fall back to the default '
          'text keyboard. Prefer showDatePicker / showTimePicker.',
      osBehavior: 'Android: numeric pad with colon and slash. iOS: same as '
          'numeric. Web: usually defaults to text.',
      stamp: violetGradient,
      stampShadows: stampShadow,
      field: readOnlyField(
        controller: ctrlDatetime,
        keyboardType: TextInputType.datetime,
      ),
    ),
    makeGalleryCard(
      typeName: 'emailAddress',
      constructor: 'TextInputType.emailAddress',
      description: 'Standard QWERTY with a prominent @ sign and . key on '
          'the primary layer. Disables "Smart Punctuation" on iOS so the '
          'user does not get curly quotes inside an email.',
      osBehavior: 'QWERTY with @ and . in primary positions. Often '
          'autocorrect off and autocapitalisation off.',
      stamp: heroGradient,
      stampShadows: stampShadow,
      field: readOnlyField(
        controller: ctrlEmail,
        keyboardType: TextInputType.emailAddress,
      ),
    ),
    makeGalleryCard(
      typeName: 'url',
      constructor: 'TextInputType.url',
      description: 'Standard QWERTY with prominent . / and (on iOS) a '
          '".com" key. Disables space (or replaces it with .) on some '
          'platforms because URLs cannot contain literal spaces.',
      osBehavior: 'QWERTY with . and / promoted. iOS adds .com long-press '
          'options. No autocorrect.',
      stamp: heroGradient,
      stampShadows: stampShadow,
      field: readOnlyField(
        controller: ctrlUrl,
        keyboardType: TextInputType.url,
      ),
    ),
    makeGalleryCard(
      typeName: 'visiblePassword',
      constructor: 'TextInputType.visiblePassword',
      description: 'Standard QWERTY but with autocorrect, '
          'autocapitalisation, and predictive text disabled. The text is '
          'still visible — obscureText is a SEPARATE flag.',
      osBehavior: 'QWERTY with no auto-anything. Often the long-press for '
          'numbers / symbols is more accessible.',
      stamp: coralGradient,
      stampShadows: coralShadow,
      field: readOnlyField(
        controller: ctrlVisiblePassword,
        keyboardType: TextInputType.visiblePassword,
      ),
    ),
    makeGalleryCard(
      typeName: 'name',
      constructor: 'TextInputType.name',
      description: 'A keyboard hint optimised for human names. Often '
          'enables word-level autocapitalisation and picks up the OS '
          'contacts dictionary for predictive text.',
      osBehavior: 'QWERTY with autocapitalisation: words. Some platforms '
          'enable contacts-based suggestions.',
      stamp: heroGradient,
      stampShadows: stampShadow,
      field: readOnlyField(
        controller: ctrlName,
        keyboardType: TextInputType.name,
      ),
    ),
    makeGalleryCard(
      typeName: 'streetAddress',
      constructor: 'TextInputType.streetAddress',
      description: 'A multi-line address layout. Pair with maxLines > 1. '
          'Often integrates with platform autofill so the user can pick '
          'an address from their saved profile.',
      osBehavior: 'QWERTY with newline support, autocapitalisation: words, '
          'and address-specific autofill suggestions.',
      stamp: heroGradient,
      stampShadows: stampShadow,
      field: readOnlyField(
        controller: ctrlStreet,
        keyboardType: TextInputType.streetAddress,
        maxLines: 4,
      ),
    ),
    makeGalleryCard(
      typeName: 'none',
      constructor: 'TextInputType.none',
      description: 'Explicitly suppresses the IME. Useful for fields that '
          'are populated programmatically — e.g. a barcode scanner, an '
          'NFC reader, a custom on-screen keypad.',
      osBehavior: 'NO virtual keyboard appears. The field can still hold '
          'focus and accept programmatic text changes.',
      stamp: coralGradient,
      stampShadows: coralShadow,
      field: readOnlyField(
        controller: ctrlNone,
        keyboardType: TextInputType.none,
      ),
    ),
    makeGalleryCard(
      typeName: 'webSearch',
      constructor: 'TextInputType.webSearch',
      description: 'A keyboard whose action key reads "Go" / "Search" / '
          '"Suchen" / etc. instead of "Done". Pair with onSubmitted to '
          'kick off a search query.',
      osBehavior: 'QWERTY with the IME action key replaced by a Search '
          'action.',
      stamp: heroGradient,
      stampShadows: stampShadow,
      field: readOnlyField(
        controller: ctrlWebSearch,
        keyboardType: TextInputType.webSearch,
      ),
    ),
    makeGalleryCard(
      typeName: 'twitter',
      constructor: 'TextInputType.twitter',
      description: 'A QWERTY layout with @ and # promoted to the primary '
          'layer. Designed for short-form social posts. The OS does not '
          'enforce a 280-character limit — that is on you.',
      osBehavior: 'QWERTY with @ and # in primary positions; no '
          'autocapitalisation by default.',
      stamp: heroGradient,
      stampShadows: stampShadow,
      field: readOnlyField(
        controller: ctrlTwitter,
        keyboardType: TextInputType.twitter,
      ),
    ),
  ];

  final Widget gallerySection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
    decoration: BoxDecoration(
      gradient: cardGradient,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: cardBorder, width: 1.2),
      boxShadow: cardShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 6),
          child: Text('CHAPTER TWO', style: subStyle),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 6),
          child: Text('Gallery — every TextInputType, on a card', style: h2Style),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 4, 12, 16),
          child: Text(
            'Sixteen read-only TextFields, one per input type. Each card '
            'shows the constructor, a paragraph of explanation, the OS '
            'layout you can typically expect, and a sample value typed '
            'into a disabled TextField so the platform glyphs render.',
            style: bodyStyle,
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: galleryCards,
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // SECTION 4 — NUMBER VARIATION SHOWCASE (4 cards in a row)
  // ----------------------------------------------------------

  Widget numberVariantCard({
    required String label,
    required String code,
    required String summary,
    required Widget field,
  }) {
    return Container(
      width: 320,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: azureGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: azureShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: parchment,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF000000).withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(code, style: codeStyle),
          ),
          const SizedBox(height: 10),
          Text(summary, style: const TextStyle(color: parchment, fontSize: 13, height: 1.45)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF000000).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: field,
          ),
        ],
      ),
    );
  }

  final Widget numberVariantsSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
    decoration: BoxDecoration(
      gradient: cardGradientWarm,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: cardBorder, width: 1.2),
      boxShadow: cardShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 6),
          child: Text('CHAPTER THREE', style: subStyle),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
          child: Text(
            'Number variants: signed × decimal',
            style: h2Style,
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 4, 12, 16),
          child: Text(
            'TextInputType.number is shorthand for '
            'numberWithOptions(signed: false, decimal: false). The '
            'two booleans give us four corners of a small matrix. '
            'Pick the one that matches what the user is allowed to '
            'TYPE — but do not assume the OS enforces it.',
            style: bodyStyle,
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            numberVariantCard(
              label: 'plain number',
              code: 'TextInputType.number',
              summary: 'Whole, unsigned numbers. No decimal, no minus.',
              field: readOnlyField(
                controller: ctrlNumber,
                keyboardType: TextInputType.number,
              ),
            ),
            numberVariantCard(
              label: 'signed',
              code: 'numberWithOptions(signed: true)',
              summary: 'Whole numbers, possibly negative — temperatures, '
                  'deltas, balances.',
              field: readOnlyField(
                controller: ctrlNumberSigned,
                keyboardType: const TextInputType.numberWithOptions(signed: true),
              ),
            ),
            numberVariantCard(
              label: 'decimal',
              code: 'numberWithOptions(decimal: true)',
              summary: 'Fractional numbers, non-negative — weights, '
                  'durations, percentages.',
              field: readOnlyField(
                controller: ctrlNumberDecimal,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            numberVariantCard(
              label: 'signed + decimal',
              code: 'numberWithOptions(signed: true, decimal: true)',
              summary: 'The richest variant — fractional, possibly '
                  'negative. Default for general numerics.',
              field: readOnlyField(
                controller: ctrlNumberBoth,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // SECTION 5 — MULTILINE SHOWCASE
  // ----------------------------------------------------------

  final Widget multilineSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    padding: const EdgeInsets.fromLTRB(32, 28, 32, 28),
    decoration: BoxDecoration(
      gradient: cardGradient,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: cardBorder, width: 1.2),
      boxShadow: cardShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('CHAPTER FOUR', style: subStyle),
        const SizedBox(height: 6),
        const Text('Single-line vs multiline', style: h2Style),
        const SizedBox(height: 12),
        const Text(
          'The visible difference: a multiline field grows downward. '
          'The functional difference: the IME exposes a Return key '
          'that inserts a literal newline character, instead of '
          'firing onSubmitted.',
          style: bodyStyle,
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Single line — TextInputType.text', style: labelStyle),
                  const SizedBox(height: 8),
                  readOnlyField(
                    controller: ctrlSingleNarrow,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'maxLines defaults to 1. The IME action key submits '
                    'the field. No newline is permitted in the value.',
                    style: bodyDimStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Multi line — TextInputType.multiline', style: labelStyle),
                  const SizedBox(height: 8),
                  readOnlyField(
                    controller: ctrlMultiTall,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Set maxLines: null to grow without limit. The IME '
                    'now shows a Return key, and \\n characters appear '
                    'in the controller value.',
                    style: bodyDimStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // SECTION 6 — DATETIME / FORMAT HINTS
  // ----------------------------------------------------------

  final Widget datetimeSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    padding: const EdgeInsets.fromLTRB(32, 28, 32, 28),
    decoration: BoxDecoration(
      gradient: violetGradient,
      borderRadius: BorderRadius.circular(24),
      boxShadow: deepInsetShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('CHAPTER FIVE', style: subStyle),
        const SizedBox(height: 6),
        Text(
          'datetime — a hint, mostly ignored',
          style: h2Style.copyWith(color: parchment),
        ),
        const SizedBox(height: 14),
        const Text(
          'TextInputType.datetime is the most aspirational of the '
          'set. On Android it nudges the IME toward a numeric pad '
          'with colon and slash glyphs; on iOS it usually falls '
          'back to default; on the web most browsers ignore it. '
          'For real date entry, prefer showDatePicker, '
          'showTimePicker, or a dedicated calendar widget — they '
          'are far more accessible and locale-correct.',
          style: bodyStyle,
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF000000).withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Read-only sample', style: labelStyle),
              const SizedBox(height: 8),
              readOnlyField(
                controller: ctrlDatetime,
                keyboardType: TextInputType.datetime,
                hint: 'yyyy-MM-dd HH:mm',
              ),
              const SizedBox(height: 10),
              Text(
                'Stored value: "${ctrlDatetime.text}"',
                style: const TextStyle(
                  color: parchmentWarm,
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // SECTION 7 — VISIBILITY / SECURITY
  // visiblePassword vs obscureText
  // ----------------------------------------------------------

  Widget passwordCard({
    required String title,
    required String detail,
    required Widget field,
    required LinearGradient gradient,
    required List<BoxShadow> shadows,
  }) {
    return Container(
      width: 380,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: shadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: parchment,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            detail,
            style: const TextStyle(color: parchment, fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 14),
          field,
        ],
      ),
    );
  }

  final Widget visibilitySection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    padding: const EdgeInsets.fromLTRB(32, 28, 32, 28),
    decoration: BoxDecoration(
      gradient: cardGradientWarm,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: cardBorder, width: 1.2),
      boxShadow: cardShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('CHAPTER SIX', style: subStyle),
        const SizedBox(height: 6),
        const Text('visiblePassword vs obscureText', style: h2Style),
        const SizedBox(height: 12),
        const Text(
          'These two settings are orthogonal. visiblePassword changes '
          'the IME behaviour (no autocorrect, no suggestions); '
          'obscureText changes the RENDERING (each glyph becomes a '
          'dot). Use one, the other, or both, depending on whether '
          'the user should see the characters they are typing.',
          style: bodyStyle,
        ),
        const SizedBox(height: 14),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            passwordCard(
              title: 'visible password',
              detail: 'keyboardType: visiblePassword, obscureText: false. '
                  'IME suppresses autocorrect; user can read what they '
                  'type. Best for one-time codes or password-creation '
                  'flows where confirmation is helpful.',
              field: readOnlyField(
                controller: ctrlVisiblePassword,
                keyboardType: TextInputType.visiblePassword,
              ),
              gradient: leafGradient,
              shadows: leafShadow,
            ),
            passwordCard(
              title: 'obscure password',
              detail: 'keyboardType: text, obscureText: true. Glyphs '
                  'rendered as dots. Standard sign-in flow. Note that '
                  'we do NOT use visiblePassword here — combining '
                  'them is allowed but uncommon.',
              field: readOnlyField(
                controller: ctrlOpaquePassword,
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              gradient: coralGradient,
              shadows: coralShadow,
            ),
          ],
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // SECTION 8 — COMPARISON TABLE
  // ----------------------------------------------------------

  TableRow buildHeaderRow() {
    return TableRow(
      decoration: const BoxDecoration(color: inkHigher),
      children: <Widget>[
        _PrivateTableCell(text: 'TextInputType', isHeader: true),
        _PrivateTableCell(text: 'Typical glyphs', isHeader: true),
        _PrivateTableCell(text: 'Platform fallback', isHeader: true),
      ],
    );
  }

  TableRow buildRow(String type, String glyphs, String fallback) {
    return TableRow(
      decoration: const BoxDecoration(color: inkMid),
      children: <Widget>[
        _PrivateTableCell(text: type, isHeader: false, isCode: true),
        _PrivateTableCell(text: glyphs, isHeader: false),
        _PrivateTableCell(text: fallback, isHeader: false),
      ],
    );
  }

  final Widget comparisonTableSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    padding: const EdgeInsets.fromLTRB(32, 28, 32, 32),
    decoration: BoxDecoration(
      gradient: cardGradient,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: cardBorder, width: 1.2),
      boxShadow: cardShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('CHAPTER SEVEN', style: subStyle),
        const SizedBox(height: 6),
        const Text('Type → glyphs → platform fallback', style: h2Style),
        const SizedBox(height: 14),
        const Text(
          'A quick reference. The "typical glyphs" column is what the '
          'OS usually surfaces on mobile; the "platform fallback" '
          'column is what happens when the OS does not honour the '
          'hint (mostly desktop, occasionally web).',
          style: bodyStyle,
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: cardBorder, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(2.0),
                1: FlexColumnWidth(2.5),
                2: FlexColumnWidth(2.5),
              },
              border: TableBorder.symmetric(
                inside: BorderSide(color: cardBorder, width: 0.6),
              ),
              children: <TableRow>[
                buildHeaderRow(),
                buildRow('text', 'a–z A–Z 0–9 punctuation',
                    'Same on all platforms'),
                buildRow('multiline',
                    'a–z A–Z 0–9 punctuation + Return key',
                    'Newline is just a normal char on desktop'),
                buildRow('number', '0–9',
                    'Desktop: ordinary keyboard, app must validate'),
                buildRow('number(decimal:true)', '0–9 + locale decimal',
                    'Desktop: same as text; rely on formatter'),
                buildRow('number(signed:true)', '0–9 + minus / plus',
                    'Desktop: same as text; rely on formatter'),
                buildRow('phone', '0–9 # * +',
                    'iOS: numeric; desktop: ordinary keyboard'),
                buildRow('datetime', '0–9 : / -',
                    'Mostly falls back to text on iOS and web'),
                buildRow('emailAddress', 'a–z 0–9 @ . _',
                    'Desktop: ordinary keyboard; autofill helps'),
                buildRow('url', 'a–z 0–9 . / : -',
                    'Desktop: ordinary keyboard; autofill helps'),
                buildRow('visiblePassword',
                    'a–z A–Z 0–9 punctuation, no autocorrect',
                    'Desktop: ordinary keyboard, app suppresses autocorrect'),
                buildRow('name', 'a–z A–Z, autocaps words',
                    'Desktop: ordinary keyboard'),
                buildRow('streetAddress', 'multi-line a–z 0–9 punctuation',
                    'Desktop: ordinary keyboard, address autofill'),
                buildRow('none', '— (no IME shown)',
                    'No effect on desktop; fields just receive focus'),
                buildRow('webSearch',
                    'a–z 0–9 punctuation, action key = Search',
                    'Desktop: action handled by your onSubmitted'),
                buildRow('twitter', 'a–z 0–9 @ # promoted',
                    'Desktop: ordinary keyboard'),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // SECTION 9 — PITFALLS
  // ----------------------------------------------------------

  Widget pitfallCallout({
    required String title,
    required String body,
    required LinearGradient gradient,
    required List<BoxShadow> shadows,
    required IconData icon,
  }) {
    return Container(
      width: 380,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: shadows,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: parchment, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: parchment,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  body,
                  style: const TextStyle(
                    color: parchment,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget pitfallsSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
    decoration: BoxDecoration(
      gradient: cardGradientWarm,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: cardBorder, width: 1.2),
      boxShadow: cardShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 6),
          child: Text('CHAPTER EIGHT', style: subStyle),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
          child: Text('Pitfalls and quiet surprises', style: h2Style),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            pitfallCallout(
              icon: Icons.warning_amber_outlined,
              title: 'A hint is not a validator',
              body: 'TextInputType.number(decimal: true) does NOT '
                  'validate the value. The user can paste literally '
                  'anything in there. Pair it with a TextInputFormatter '
                  '(e.g. FilteringTextInputFormatter) to actually '
                  'restrict the characters.',
              gradient: coralGradient,
              shadows: coralShadow,
            ),
            pitfallCallout(
              icon: Icons.phone_android_outlined,
              title: 'iOS has no phone-only keyboard',
              body: 'TextInputType.phone summons a 12-key dialer on '
                  'Android, but iOS surfaces a numeric pad with '
                  'phone-friendly punctuation — there is no '
                  'OS-level enforcement that the input is numeric.',
              gradient: violetGradient,
              shadows: stampShadow,
            ),
            pitfallCallout(
              icon: Icons.computer_outlined,
              title: 'Desktop ignores most hints',
              body: 'There is no virtual keyboard to pop open on '
                  'macOS, Windows, or Linux. TextInputType becomes a '
                  'best-effort autofill / accessibility hint and your '
                  'formatters / validators do all the real work.',
              gradient: azureGradient,
              shadows: azureShadow,
            ),
            pitfallCallout(
              icon: Icons.language_outlined,
              title: 'Locale-aware decimal separator',
              body: 'In a Continental European locale, '
                  'TextInputType.number(decimal: true) shows a comma, '
                  'not a dot. Your numeric parser must accept both — '
                  'or set the locale explicitly via NumberFormat.',
              gradient: leafGradient,
              shadows: leafShadow,
            ),
            pitfallCallout(
              icon: Icons.visibility_off_outlined,
              title: 'visiblePassword is not obscureText',
              body: 'visiblePassword is an IME hint (no autocorrect). '
                  'obscureText is a renderer flag (dots instead of '
                  'glyphs). They are orthogonal — set them '
                  'independently to get the behaviour you want.',
              gradient: coralGradient,
              shadows: coralShadow,
            ),
            pitfallCallout(
              icon: Icons.edit_off_outlined,
              title: 'TextInputType.none means NO keyboard',
              body: 'Use it deliberately for fields you populate '
                  'programmatically (barcode, NFC, custom keypad). '
                  'On platforms with hardware keyboards the field can '
                  'still receive typed input — none only suppresses '
                  'the SOFT keyboard.',
              gradient: violetGradient,
              shadows: stampShadow,
            ),
          ],
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // SECTION 10 — COMPOSITE REGISTRATION FORM
  // ----------------------------------------------------------

  Widget formRow({
    required String label,
    required String hint,
    required Widget field,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: labelStyle),
          const SizedBox(height: 4),
          Text(hint, style: bodyDimStyle),
          const SizedBox(height: 8),
          field,
        ],
      ),
    );
  }

  final Widget compositeFormSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    padding: const EdgeInsets.fromLTRB(32, 28, 32, 32),
    decoration: BoxDecoration(
      gradient: cardGradient,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: cardBorder, width: 1.2),
      boxShadow: cardShadow,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('CHAPTER NINE', style: subStyle),
        const SizedBox(height: 6),
        const Text('A registration form, every type in its place', style: h2Style),
        const SizedBox(height: 12),
        const Text(
          'A read-only mock of a typical sign-up screen. Each field '
          'gets the TextInputType that best matches its content. The '
          'OS picks the right keyboard, the user types fewer wrong '
          'characters, autofill works better. Small details, large '
          'difference in UX.',
          style: bodyStyle,
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: inkDeep,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cardBorder, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              formRow(
                label: 'Full name',
                hint: 'TextInputType.name — autocapitalisation: words.',
                field: readOnlyField(
                  controller: formCtrlName,
                  keyboardType: TextInputType.name,
                  hint: 'First Last',
                ),
              ),
              formRow(
                label: 'Email address',
                hint: 'TextInputType.emailAddress — @ and . promoted, no '
                    'autocorrect.',
                field: readOnlyField(
                  controller: formCtrlEmail,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'you@example.com',
                ),
              ),
              formRow(
                label: 'Phone number',
                hint: 'TextInputType.phone — dialer on Android, numeric '
                    'pad on iOS.',
                field: readOnlyField(
                  controller: formCtrlPhone,
                  keyboardType: TextInputType.phone,
                  hint: '+1 (555) 555-0100',
                ),
              ),
              formRow(
                label: 'Mailing address',
                hint: 'TextInputType.streetAddress — multiline, address '
                    'autofill.',
                field: readOnlyField(
                  controller: formCtrlAddress,
                  keyboardType: TextInputType.streetAddress,
                  hint: 'Street, city, postal code, country',
                  maxLines: 4,
                ),
              ),
              formRow(
                label: 'Password',
                hint: 'TextInputType.visiblePassword + obscureText: true. '
                    'No autocorrect, dots for the glyphs.',
                field: readOnlyField(
                  controller: formCtrlPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  hint: 'min 12 chars',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // SECTION 11 — FOOTER COLOPHON
  // ----------------------------------------------------------

  final Widget colophonSection = Container(
    margin: const EdgeInsets.fromLTRB(28, 16, 28, 36),
    padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
    decoration: BoxDecoration(
      gradient: heroGradient,
      borderRadius: BorderRadius.circular(20),
      boxShadow: stampShadow,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.keyboard_outlined,
            color: Color(0xFF1A1A1A), size: 36),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Colophon',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'A field guide to TextInputType, hand-laid in Material '
                'widgets, illustrated with read-only TextFields, '
                'illuminated with sixteen sample values. Set in '
                'monospace for the code, sans-serif for the prose. '
                'Print run: one — yours, here in this AST roundtrip.',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ----------------------------------------------------------
  // ASSEMBLY
  // ----------------------------------------------------------

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Text Input Types — a field guide',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: inkDeep,
      colorScheme: const ColorScheme.dark(
        primary: accentEmber,
        secondary: accentAmber,
        surface: inkMid,
      ),
      textTheme: const TextTheme(
        bodyMedium: bodyStyle,
        bodyLarge: bodyStyle,
      ),
    ),
    home: Scaffold(
      backgroundColor: inkDeep,
      body: Container(
        decoration: const BoxDecoration(gradient: backdropGradient),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              heroSection,
              anatomySection,
              gallerySection,
              numberVariantsSection,
              multilineSection,
              datetimeSection,
              visibilitySection,
              comparisonTableSection,
              pitfallsSection,
              compositeFormSection,
              colophonSection,
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// PRIVATE HELPER WIDGETS
// ============================================================

class _PrivateBadge extends StatelessWidget {
  const _PrivateBadge({
    required this.label,
    required this.gradient,
    required this.shadows,
  });

  final String label;
  final LinearGradient gradient;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(14),
        boxShadow: shadows,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFF5EFE0),
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _PrivateKeyboardGraphic extends StatelessWidget {
  const _PrivateKeyboardGraphic({
    required this.keycapGradient,
    required this.keycapShadows,
    required this.accent,
  });

  final LinearGradient keycapGradient;
  final List<BoxShadow> keycapShadows;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    // 4 rows × 10 keys, drawn purely from boxes; the spacebar row
    // is a single wide keycap. Glyph-free — just the silhouette of
    // a generic on-screen keyboard. This stands in for a real
    // pictogram and reinforces the "OS keyboard is the deliverable"
    // theme of the demo.
    Widget keyCap({double width = 28, String? glyph}) {
      return Container(
        width: width,
        height: 36,
        margin: const EdgeInsets.all(3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: keycapGradient,
          borderRadius: BorderRadius.circular(6),
          boxShadow: keycapShadows,
        ),
        child: glyph == null
            ? null
            : Text(
                glyph,
                style: const TextStyle(
                  color: Color(0xFF2A1810),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
      );
    }

    Widget row(List<Widget> caps) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: caps,
      );
    }

    final List<String> r1 = <String>[
      'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'
    ];
    final List<String> r2 = <String>[
      'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'
    ];
    final List<String> r3 = <String>['z', 'x', 'c', 'v', 'b', 'n', 'm'];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0E0B08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.5),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          row(r1.map((String g) => keyCap(glyph: g)).toList()),
          row(r2.map((String g) => keyCap(glyph: g)).toList()),
          row(<Widget>[
            keyCap(width: 36, glyph: '⇧'),
            ...r3.map((String g) => keyCap(glyph: g)),
            keyCap(width: 36, glyph: '⌫'),
          ]),
          row(<Widget>[
            keyCap(width: 32, glyph: '123'),
            keyCap(width: 32, glyph: '@'),
            keyCap(width: 140, glyph: 'space'),
            keyCap(width: 32, glyph: '.'),
            keyCap(width: 50, glyph: 'go'),
          ]),
        ],
      ),
    );
  }
}

class _PrivateAnatomyDiagram extends StatelessWidget {
  const _PrivateAnatomyDiagram({
    required this.accent,
    required this.accentDark,
    required this.parchment,
    required this.parchmentDim,
    required this.inkRise,
    required this.inkHigher,
    required this.shadows,
  });

  final Color accent;
  final Color accentDark;
  final Color parchment;
  final Color parchmentDim;
  final Color inkRise;
  final Color inkHigher;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    Widget node(String title, String body, Color top, Color bottom) {
      return Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[top, bottom],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: shadows,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: parchment,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: TextStyle(
                color: parchment,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      );
    }

    Widget arrow(String label) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(label,
                style: TextStyle(
                  color: parchmentDim,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 4),
            Container(width: 60, height: 2, color: accent),
            Icon(Icons.arrow_right_alt, color: accent, size: 22),
          ],
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        node(
          'Flutter',
          'TextField widget holds a TextInputType (the hint).',
          inkRise,
          inkHigher,
        ),
        arrow('TextInputType\nplatform channel'),
        node(
          'Engine',
          'Bridges the hint over a method channel to the OS.',
          inkHigher,
          inkRise,
        ),
        arrow('OS request\nshowKeyboard'),
        node(
          'Operating System',
          'Picks a virtual keyboard layout — or shrugs.',
          accentDark,
          accent,
        ),
      ],
    );
  }
}

class _PrivateTableCell extends StatelessWidget {
  const _PrivateTableCell({
    required this.text,
    required this.isHeader,
    this.isCode = false,
  });

  final String text;
  final bool isHeader;
  final bool isCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          color: isHeader ? const Color(0xFFF2A65A) : const Color(0xFFF5EFE0),
          fontFamily: isCode ? 'monospace' : null,
          fontWeight: isHeader ? FontWeight.w900 : FontWeight.w500,
          fontSize: isHeader ? 13 : 13.5,
          letterSpacing: isHeader ? 1.0 : 0.0,
          height: 1.4,
        ),
      ),
    );
  }
}
