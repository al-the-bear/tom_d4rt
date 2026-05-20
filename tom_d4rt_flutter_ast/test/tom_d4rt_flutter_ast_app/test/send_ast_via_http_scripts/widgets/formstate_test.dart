// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//                    QUILL PEWTER --- FormState (a notary's deep demo)
// =============================================================================
//
//  TARGET CLASS .... FormState  (package:flutter/widgets.dart)
//
//  CONTEXT ......... FormState is the live State object behind the Form
//                    widget. You reach it in two ways:
//
//                       1.  Form.of(context)            (descendant context)
//                       2.  GlobalKey<FormState>()
//                              .currentState             (after first build)
//
//                    Once you hold a FormState you can:
//
//                       *  validate() ........ run every FormField's
//                                              validator and return a
//                                              boolean indicating whether
//                                              every field passed.
//                       *  save() ............ invoke each FormField's
//                                              onSaved callback (typically
//                                              writing the value into a
//                                              model object).
//                       *  reset() ........... return every FormField to
//                                              its initial value and clear
//                                              error state.
//                       *  isValid (Flutter
//                          3.16+) ............ a non-mutating check used
//                                              when AutovalidateMode is
//                                              already running validators.
//
//                    FormState is created by the Form's StatefulWidget; it
//                    is therefore not directly constructible. The only
//                    legitimate handles are the two listed above.
//
//                    AutovalidateMode controls WHEN validators run on their
//                    own:
//
//                       *  disabled .................. validators run only
//                                                      when YOU call
//                                                      validate().
//                       *  always .................... validators run on
//                                                      every build.
//                       *  onUserInteraction ......... validators run after
//                                                      the user has touched
//                                                      a field once.
//                       *  onUnfocus (Flutter 3.16+) . validators run when
//                                                      a field loses focus.
//
//  D4RT NOTE ....... A live FormState requires the Form to be mounted in
//                    the element tree. During the first build,
//                    `formKey.currentState` is null, and `Form.of(context)`
//                    only works inside a descendant Builder. Calling
//                    validate(), save() or reset() during build is illegal
//                    in normal Flutter and is doubly fragile under d4rt
//                    (which renders ONE static snapshot).
//
//                    This deep demo therefore dramatises the API
//                    STATICALLY: we render Form widgets with
//                    TextFormField children, illustrate validators via
//                    inline pure functions, and SHOW the FormState API
//                    documentation in prose. We do NOT invoke any method
//                    that would need a live State.
//
//  THEME ........... QUILL PEWTER
//
//                    A nineteenth-century notary's chambers. Imagine an
//                    oak escritoire of a deep pewter-grey, ink-pots of
//                    polished iron, parchment unrolled and weighted with
//                    pewter discs. A single sealing-wax red rosette is
//                    pressed at the foot of every document, the impression
//                    of a notary's seal. The room is hushed; a brass-
//                    handled bell-pull waits at the corner. Each form is
//                    a "deed" --- a notarised document --- with a wax-seal
//                    corner. Prose reads as the notary's certificate
//                    ledger, formal and unhurried.
//
//                    Pewter-grey is the chassis. Ink-black is the type.
//                    Parchment is the paper. Sealing-wax red is the
//                    accent. Pale gilt is the trim.
//
//  SECTIONS
//
//      Section  1 .... Title cartouche & palette ledger
//      Section  2 .... Prose anatomy of Form / FormState / FormField
//      Section  3 .... AutovalidateMode tour (4 modes, side-by-side)
//      Section  4 .... Validator function catalogue
//      Section  5 .... Form.of(context) lookup pattern (illustrated)
//      Section  6 .... GlobalKey<FormState> pattern (illustrated)
//      Section  7 .... validate() / save() / reset() lifecycle prose
//      Section  8 .... Notarised deeds (8 form mocks, each a "deed")
//                           A. Plain login
//                           B. Signup (email + password + confirm)
//                           C. Profile edit (multi-line bio)
//                           D. Checkout address (international phone)
//                           E. Settings preferences
//                           F. Feedback survey (rating + comments)
//                           G. Reset password
//                           H. Onboarding multi-step (single-page mock)
//      Section  9 .... Accessibility considerations (semanticLabel,
//                                                    errorText, hint)
//      Section 10 .... Comparison: FormState vs other libraries' patterns
//      Section 11 .... DO / AVOID callouts
//      Section 12 .... Glossary of terms
//      Section 13 .... Recap footer
//
//  WHAT WE DO NOT TOUCH
//
//      formKey.currentState!.validate()      [needs live State]
//      formKey.currentState!.save()          [needs live State]
//      formKey.currentState!.reset()         [needs live State]
//      Any setState / StatefulWidget         [no live mutation]
//      Any TextEditingController             [no controllers]
//      Any FocusNode hooks                   [no focus orchestration]
//      Any Timer / Future / Stream           [no async]
//
//  D4RT CONSTRAINTS
//
//      *  build() is called exactly ONCE. We return a single snapshot.
//      *  No StatefulWidget, no setState, no controllers, no timers.
//      *  No `for-in` over BridgedInstance: indexed loops only.
//      *  No `.value` on Tween.animate: we don't animate.
//      *  Use `.withValues(alpha:...)` (not `.withOpacity`).
//
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  PALETTE  ---  Quill Pewter
// ---------------------------------------------------------------------------
//  A disciplined palette: pewter is the chassis, parchment the paper,
//  sealing-wax red the only loud note. Pale gilt provides the trim. Every
//  colour has a narrative role; we name each token in long form so the
//  reader can map the colour back to its part of the chamber.
// ---------------------------------------------------------------------------

const Color cPewterDark = Color(0xFF3C3F44); // deepest pewter (escritoire)
const Color cPewterMid = Color(0xFF565A60); // mid-pewter (panelling)
const Color cPewterLite = Color(0xFF7A7E84); // light pewter (rim)
const Color cPewterPale = Color(0xFFA9ADB2); // pale pewter (highlight)
const Color cInkBlack = Color(0xFF15130E); // notary ink, deepest
const Color cInkBlue = Color(0xFF1B2233); // ink under the lamp
const Color cParchment = Color(0xFFF1E8D0); // unrolled paper
const Color cParchmentDim = Color(0xFFD9CFB3); // shadowed paper
const Color cParchmentEdge = Color(0xFFB8A77F); // foxed edge
const Color cWaxRed = Color(0xFF9C2F22); // sealing-wax red, accent
const Color cWaxRedDeep = Color(0xFF6E1D14); // shadowed wax
const Color cWaxRedLite = Color(0xFFC15A45); // hot wax
const Color cGilt = Color(0xFFB89A52); // pale gilt trim
const Color cGiltDeep = Color(0xFF8A7236); // tarnished gilt
const Color cGiltLite = Color(0xFFE2C77A); // gilt highlight
const Color cFelt = Color(0xFF2A3A36); // green felt blotter
const Color cFeltLite = Color(0xFF3F5650); // pale felt
const Color cBoneWhite = Color(0xFFF8F4E6); // bone-white callout card
const Color cWarning = Color(0xFF8A6A1A); // ochre warning
const Color cValid = Color(0xFF3F5F2A); // moss valid

// Palette swatches surfaced in the title cartouche.
const List<Map<String, Object>> kPalette = <Map<String, Object>>[
  {'name': 'pewterDark', 'color': cPewterDark},
  {'name': 'pewterMid', 'color': cPewterMid},
  {'name': 'pewterLite', 'color': cPewterLite},
  {'name': 'pewterPale', 'color': cPewterPale},
  {'name': 'inkBlack', 'color': cInkBlack},
  {'name': 'inkBlue', 'color': cInkBlue},
  {'name': 'parchment', 'color': cParchment},
  {'name': 'parchmentDim', 'color': cParchmentDim},
  {'name': 'parchmentEdge', 'color': cParchmentEdge},
  {'name': 'waxRed', 'color': cWaxRed},
  {'name': 'waxRedDeep', 'color': cWaxRedDeep},
  {'name': 'waxRedLite', 'color': cWaxRedLite},
  {'name': 'gilt', 'color': cGilt},
  {'name': 'giltDeep', 'color': cGiltDeep},
  {'name': 'giltLite', 'color': cGiltLite},
  {'name': 'felt', 'color': cFelt},
  {'name': 'feltLite', 'color': cFeltLite},
  {'name': 'boneWhite', 'color': cBoneWhite},
];

// ---------------------------------------------------------------------------
//  TEXT TOKENS
// ---------------------------------------------------------------------------

const TextStyle kTitleStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w800,
  color: cParchment,
  letterSpacing: 1.6,
);

const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 14,
  fontStyle: FontStyle.italic,
  color: cParchmentDim,
  height: 1.45,
);

const TextStyle kSectionHeaderStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: cInkBlack,
);

const TextStyle kSectionLeadStyle = TextStyle(
  fontSize: 13,
  height: 1.45,
  color: cInkBlack,
);

const TextStyle kBodyStyle = TextStyle(
  fontSize: 12,
  height: 1.45,
  color: cInkBlack,
);

const TextStyle kBodyEmphStyle = TextStyle(
  fontSize: 12,
  height: 1.45,
  color: cInkBlack,
  fontWeight: FontWeight.w700,
);

const TextStyle kSmallLabelStyle = TextStyle(
  fontSize: 11,
  color: cWaxRedDeep,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.6,
);

const TextStyle kCodeStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: cParchment,
  height: 1.4,
);

const TextStyle kCalloutDoStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: cValid,
  letterSpacing: 0.5,
);

const TextStyle kCalloutAvoidStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: cWaxRedDeep,
  letterSpacing: 0.5,
);

const TextStyle kDeedTitleStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w800,
  color: cInkBlack,
  letterSpacing: 0.8,
);

const TextStyle kDeedSubtitleStyle = TextStyle(
  fontSize: 10,
  fontStyle: FontStyle.italic,
  color: cPewterDark,
  height: 1.3,
);

const TextStyle kDeedFieldLabelStyle = TextStyle(
  fontSize: 10,
  color: cInkBlack,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.4,
);

const TextStyle kDeedSealStyle = TextStyle(
  fontSize: 9,
  fontWeight: FontWeight.w900,
  color: cParchment,
  letterSpacing: 0.6,
);

const TextStyle kGlossaryTermStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: cWaxRedDeep,
  letterSpacing: 0.4,
);

const TextStyle kGlossaryDefStyle = TextStyle(
  fontSize: 12,
  color: cInkBlack,
  height: 1.4,
);

// ---------------------------------------------------------------------------
//  BUILD ENTRY POINT
// ---------------------------------------------------------------------------
//  D4rt invokes this exactly once. We assemble the entire snapshot up front
//  and return a single Widget --- the whole demo is a static photograph of
//  the notary's chambers with deeds laid out across the escritoire.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('===============================================================');
  print(' Quill Pewter --- FormState deep demo');
  print('===============================================================');
  print(' Building ONE static snapshot of the notary\'s chambers.');
  print(' We will lay out 8 deeds across the escritoire.');
  print(' Each deed is a Form widget with TextFormField children.');
  print(' We never invoke validate(), save() or reset() at build time.');
  print(' We narrate the API instead, in prose and side-by-side mocks.');

  final sections = <Widget>[
    _buildTitleCartouche(),
    _spacer(20),
    _buildSectionHeader('2. Anatomy of Form / FormState / FormField'),
    _buildAnatomySection(),
    _spacer(20),
    _buildSectionHeader('3. AutovalidateMode tour'),
    _buildAutovalidateTour(),
    _spacer(20),
    _buildSectionHeader('4. Validator function catalogue'),
    _buildValidatorCatalogue(),
    _spacer(20),
    _buildSectionHeader('5. Form.of(context) lookup pattern'),
    _buildFormOfPattern(),
    _spacer(20),
    _buildSectionHeader('6. GlobalKey<FormState> pattern'),
    _buildGlobalKeyPattern(),
    _spacer(20),
    _buildSectionHeader('7. validate() / save() / reset() lifecycle'),
    _buildLifecycleProse(),
    _spacer(20),
    _buildSectionHeader('8. Notarised deeds --- eight illustrative forms'),
    _buildDeedsLedger(),
    _spacer(20),
    _buildSectionHeader('9. Accessibility considerations'),
    _buildAccessibilitySection(),
    _spacer(20),
    _buildSectionHeader('10. Comparison with other libraries'),
    _buildComparisonSection(),
    _spacer(20),
    _buildSectionHeader('11. DO / AVOID callouts'),
    _buildDoAvoidCallouts(),
    _spacer(20),
    _buildSectionHeader('12. Glossary'),
    _buildGlossary(),
    _spacer(20),
    _buildRecapFooter(),
    _spacer(40),
  ];

  print(' Assembled ${sections.length} top-level section blocks.');
  print(' Returning Scaffold with SingleChildScrollView body.');

  return Scaffold(
    backgroundColor: cParchmentDim,
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: sections,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
//  Tiny helpers
// ---------------------------------------------------------------------------

Widget _spacer(double h) => SizedBox(height: h);

Widget _buildSectionHeader(String text) {
  // The section header is a parchment cartouche with a wax-red gutter on the
  // leading edge and a gilt underline. The notary's ledger uses the same
  // device for every chapter heading.
  return Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: cParchment,
        border: Border(
          left: BorderSide(color: cWaxRed, width: 6),
          bottom: BorderSide(color: cGiltDeep, width: 1),
        ),
      ),
      child: Text(text, style: kSectionHeaderStyle),
    ),
  );
}

// A tiny seal disc rendered at the foot of every deed.
Widget _buildWaxSeal({String label = 'NOTARISED'}) {
  return Container(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const RadialGradient(
        colors: <Color>[cWaxRedLite, cWaxRed, cWaxRedDeep],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      border: Border.all(color: cGiltDeep, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cInkBlack.withValues(alpha: 0.4),
          blurRadius: 4,
          offset: const Offset(1, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        label,
        style: kDeedSealStyle,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

// Decorative parchment frame for prose cards.
BoxDecoration _proseDeco() {
  return BoxDecoration(
    color: cParchment,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cGiltDeep, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cInkBlack.withValues(alpha: 0.18),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

// Pewter card frame for code excerpts.
BoxDecoration _codeDeco() {
  return BoxDecoration(
    color: cPewterDark,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: cGilt.withValues(alpha: 0.6), width: 1),
  );
}

// Generic "deed" frame: parchment with an aged edge and a sealing-wax corner.
Widget _deedFrame({
  required String title,
  required String subtitle,
  required List<Widget> body,
  String sealLabel = 'NOTARISED',
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: cParchment,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cParchmentEdge, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cInkBlack.withValues(alpha: 0.22),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 76, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: kDeedTitleStyle),
              const SizedBox(height: 2),
              Text(subtitle, style: kDeedSubtitleStyle),
              const Divider(color: cParchmentEdge, height: 14, thickness: 1),
              ...body,
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: _buildWaxSeal(label: sealLabel),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 1 --- Title cartouche & palette ledger
// ===========================================================================

Widget _buildTitleCartouche() {
  print(' Building Section 1: title cartouche & palette ledger.');
  // The cartouche is a deep pewter panel with a wax-red glow under it and a
  // gilt border --- the escritoire seen from above with the lamp lit.
  final BoxDecoration cartoucheDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cPewterDark, cPewterMid, cPewterLite],
      stops: <double>[0.0, 0.55, 1.0],
    ),
    borderRadius: BorderRadius.circular(14),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cWaxRed.withValues(alpha: 0.32),
        blurRadius: 22,
        spreadRadius: 1,
        offset: const Offset(0, 10),
      ),
    ],
    border: Border.all(color: cGilt, width: 2),
  );

  // A horizontal palette strip in the foot of the cartouche.
  final swatches = <Widget>[];
  for (int i = 0; i < kPalette.length; i++) {
    final entry = kPalette[i];
    final c = entry['color'] as Color;
    final n = entry['name'] as String;
    final swatchDeco = BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cParchment.withValues(alpha: 0.65), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cInkBlack.withValues(alpha: 0.45),
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    );
    swatches.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: <Widget>[
            Container(width: 36, height: 36, decoration: swatchDeco),
            const SizedBox(height: 2),
            SizedBox(
              width: 64,
              child: Text(
                n,
                style: const TextStyle(fontSize: 9, color: cParchment),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A small wax-seal sigil floating at the top right of the cartouche.
  final sealSigil = _buildWaxSeal(label: 'NOTARY');

  return Container(
    decoration: cartoucheDeco,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text('QUILL PEWTER', style: kTitleStyle),
                  SizedBox(height: 6),
                  Text(
                    'A notary\'s walkthrough of FormState --- the live State '
                    'object behind every Form widget. We tour the API in '
                    'prose, illustrate AutovalidateMode side-by-side, '
                    'catalogue validators, and lay out eight notarised '
                    'deeds across the escritoire.',
                    style: kSubtitleStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            sealSigil,
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'PALETTE LEDGER',
          style: TextStyle(
            color: cGilt,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: swatches),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: cInkBlue.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: cGiltDeep, width: 1),
          ),
          child: const Text(
            'Be it known to all who shall read these presents --- the within '
            'instrument concerning Form, FormState and FormField is rendered '
            'this day, in the chambers of the undersigned, for the '
            'instruction of any reader who shall require to know the office '
            'of validate(), save() and reset().',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: cParchment,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 2 --- Prose anatomy of Form / FormState / FormField
// ===========================================================================

Widget _buildAnatomySection() {
  print(' Building Section 2: anatomy of Form / FormState / FormField.');

  // We assemble three parchment cards side-by-side: Form, FormState,
  // FormField. Each card is headed with a wax-red gutter and contains a
  // small definition followed by the principal members of the type.

  final formCard = _buildAnatomyCard(
    title: 'Form',
    role: 'StatefulWidget',
    body:
        'A grouping container for FormField descendants. It does NOT add '
        'visual chrome of its own; it merely provides a place where its '
        'children can be validated, saved or reset together. The Form\'s '
        'State is FormState.',
    members: const <String>[
      'key            (GlobalKey<FormState>?)',
      'autovalidateMode (AutovalidateMode)',
      'onChanged      (VoidCallback?)',
      'onWillPop      (deprecated)',
      'canPop / onPopInvoked (newer)',
      'child          (Widget)',
    ],
  );

  final stateCard = _buildAnatomyCard(
    title: 'FormState',
    role: 'State<Form>',
    body:
        'The live State object. Reachable via Form.of(context) inside a '
        'descendant or via key.currentState (after first build). All '
        'mutating actions on the form pass through here.',
    members: const <String>[
      'validate() -> bool',
      'save()',
      'reset()',
      'isValid (Flutter 3.16+)',
      'context (BuildContext)',
      'widget   (Form)',
    ],
  );

  final fieldCard = _buildAnatomyCard(
    title: 'FormField<T>',
    role: 'StatefulWidget',
    body:
        'The unit of work inside a Form. TextFormField, DropdownButtonFormField '
        'and CheckboxListTile-style wrappers all extend FormField. Each field '
        'declares its validator, its onSaved hook, an initial value and an '
        'autovalidateMode override.',
    members: const <String>[
      'initialValue   (T?)',
      'validator      (FormFieldValidator<T>?)',
      'onSaved        (FormFieldSetter<T>?)',
      'autovalidateMode (AutovalidateMode?)',
      'enabled        (bool)',
      'restorationId  (String?)',
      'builder        (FormFieldBuilder<T>)',
    ],
  );

  // We also include a long prose paragraph beneath the three cards
  // explaining the relationships between the three types.
  final relationshipProse = Container(
    padding: const EdgeInsets.all(14),
    decoration: _proseDeco(),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Relationships, in prose', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'A Form widget is a grouping container, nothing more. It declares '
          'the SCOPE of a notarised act --- everything inside its subtree '
          'belongs to the same deed. The Form\'s State (FormState) is the '
          'office that keeps the records: when you ask the Form to '
          'validate, the office walks the registry and asks each '
          'FormField for its verdict; when you ask the Form to save, '
          'the office walks the registry and instructs each FormField '
          'to commit its value; when you ask the Form to reset, the '
          'office walks the registry and instructs each FormField to '
          'return to its origin.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'Each FormField, in turn, holds its own little State (a '
          'FormFieldState<T>). It is the FormFieldState that actually '
          'remembers the current value, runs the validator, and emits '
          'the error string when the validator returns non-null. '
          'TextFormField is a thin convenience that wraps a TextField '
          'inside a FormField<String>; DropdownButtonFormField is the '
          'analogous wrapper around DropdownButton<T>.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'The chain therefore reads: Form (widget) -> FormState (state) '
          '-> FormField<T> (widget) -> FormFieldState<T> (state). The '
          'top half of the chain is the deed; the bottom half is the '
          'individual signature line.',
          style: kBodyStyle,
        ),
      ],
    ),
  );

  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cBoneWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cParchmentEdge, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'The three types you will use every working day',
          style: kSectionLeadStyle,
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: formCard),
            const SizedBox(width: 10),
            Expanded(child: stateCard),
            const SizedBox(width: 10),
            Expanded(child: fieldCard),
          ],
        ),
        const SizedBox(height: 12),
        relationshipProse,
      ],
    ),
  );
}

Widget _buildAnatomyCard({
  required String title,
  required String role,
  required String body,
  required List<String> members,
}) {
  // Build the member list with an indexed loop --- never for-in over a
  // BridgedInstance.
  final memberWidgets = <Widget>[];
  for (int i = 0; i < members.length; i++) {
    memberWidgets.add(
      Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('  -  ', style: kBodyStyle),
            Expanded(
              child: Text(
                members[i],
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: cInkBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #111, P5(a)):
  // Original used `Border(left: cWaxRed/4, top/right/bottom:
  // cParchmentEdge/0.5)` + `borderRadius: 8`. Flutter forbids non-uniform
  // Border sides with a borderRadius. Refactor to a uniform
  // `Border.all(cParchmentEdge/0.5)` outer frame + a leading wax-red strip
  // Container inside `ClipRRect > IntrinsicHeight > Row` so the chunky
  // accent is preserved as the leftmost child instead of a Border side.
  // Visual is equivalent: parchment card with a wax-red leading gutter and
  // a thin gilt-coloured frame on the other sides.
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: cParchment,
          border: Border.all(color: cParchmentEdge, width: 0.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(width: 4, color: cWaxRed),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: kDeedTitleStyle),
                    Text(role, style: kDeedSubtitleStyle),
                    const SizedBox(height: 6),
                    Text(body, style: kBodyStyle),
                    const SizedBox(height: 8),
                    const Text('Principal members',
                        style: kSmallLabelStyle),
                    ...memberWidgets,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ===========================================================================
//  SECTION 3 --- AutovalidateMode tour
// ===========================================================================

Widget _buildAutovalidateTour() {
  print(' Building Section 3: AutovalidateMode tour.');

  // Four tiles, each a parchment slip describing one mode and showing a
  // miniature Form rendered with that mode. Note: we render the Form
  // statically; the mode is set on the widget but no validation actually
  // runs (we never call validate()). The tile is therefore a portrait of
  // what the mode is, not a moving demonstration.

  final modes = <Map<String, Object>>[
    <String, Object>{
      'name': 'disabled',
      'tagline':
          'Validators run only when YOU call validate(). The default. '
              'The form is silent until commanded.',
      'whenToUse':
          'Long forms where premature errors would harass the user; '
              'forms behind a "Submit" button.',
      'mode': AutovalidateMode.disabled,
      'sealColour': cPewterDark,
    },
    <String, Object>{
      'name': 'always',
      'tagline':
          'Validators run on every build, including the first. Errors '
              'appear before the user has typed anything.',
      'whenToUse':
          'Inline editors with no submit button; fields whose error '
              'state is purely informational.',
      'mode': AutovalidateMode.always,
      'sealColour': cWarning,
    },
    <String, Object>{
      'name': 'onUserInteraction',
      'tagline':
          'Validators run after the user has touched the field once, '
              'then on every change thereafter.',
      'whenToUse':
          'Most modern UX: forms where the first impression is clean '
              'and feedback follows interaction.',
      'mode': AutovalidateMode.onUserInteraction,
      'sealColour': cValid,
    },
    <String, Object>{
      'name': 'onUnfocus',
      'tagline':
          'Validators run when a field loses focus (Flutter 3.16+). '
              'Quiet while you type; verdict on tab-out.',
      'whenToUse':
          'Forms where in-flight typing should not be interrupted; '
              'long fields like addresses or bios.',
      'mode': AutovalidateMode.onUnfocus,
      'sealColour': cGiltDeep,
    },
  ];

  final tiles = <Widget>[];
  for (int i = 0; i < modes.length; i++) {
    tiles.add(_buildAutovalidateTile(modes[i]));
  }

  // We arrange them as 2 rows of 2 tiles for compactness.
  return Column(
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: tiles[0]),
          const SizedBox(width: 10),
          Expanded(child: tiles[1]),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: tiles[2]),
          const SizedBox(width: 10),
          Expanded(child: tiles[3]),
        ],
      ),
      const SizedBox(height: 14),
      _buildAutovalidateProse(),
    ],
  );
}

Widget _buildAutovalidateTile(Map<String, Object> entry) {
  final name = entry['name'] as String;
  final tagline = entry['tagline'] as String;
  final whenToUse = entry['whenToUse'] as String;
  final mode = entry['mode'] as AutovalidateMode;
  final sealColour = entry['sealColour'] as Color;

  // The tile is a parchment card. We render a tiny Form inside it with the
  // requested AutovalidateMode --- not because we will validate (we won't),
  // but because we want the widget tree to BE configured the way the
  // narrative claims.
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cParchment,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cParchmentEdge, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: sealColour,
                border: Border.all(color: cInkBlack, width: 0.6),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'AutovalidateMode.$name',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: cInkBlack,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(tagline, style: kBodyStyle),
        const SizedBox(height: 6),
        Text('When to use', style: kSmallLabelStyle),
        Text(whenToUse, style: kBodyStyle),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: cParchmentDim,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: cParchmentEdge, width: 0.5),
          ),
          child: Form(
            autovalidateMode: mode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Sample field', style: kDeedFieldLabelStyle),
                const SizedBox(height: 4),
                TextFormField(
                  initialValue: 'sample',
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6),
                    border: OutlineInputBorder(),
                    hintText: 'enter a value',
                  ),
                  style: const TextStyle(fontSize: 11),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAutovalidateProse() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: _proseDeco(),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('A note on choosing a mode', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'AutovalidateMode is set on the Form widget, but each FormField '
          'may override it. The override is useful when one field within a '
          'form should be louder than the rest --- for example, a password '
          'strength indicator that should always show its verdict. In '
          'general, prefer onUserInteraction at the Form level: it is the '
          'gentlest mode that still gives the user prompt feedback once '
          'they have begun.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'Avoid AutovalidateMode.always for any form longer than two '
          'fields: a wall of red error text on first paint is hostile, '
          'especially to users navigating with assistive technologies.',
          style: kBodyStyle,
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 4 --- Validator function catalogue
// ===========================================================================

// We define a small library of pure validator functions. Each takes a
// String? and returns String? --- null on success, an error message
// otherwise. They are all renderable: we will print the rule and a few
// sample outcomes for each one.
//
// These validators are STATIC: nothing here mutates, nothing depends on
// the live FormState. They are precisely the kind of thing one would
// hand to a TextFormField's `validator:` parameter.

String? vRequired(String? v) {
  if (v == null || v.isEmpty) {
    return 'This field is required.';
  }
  return null;
}

String? vEmail(String? v) {
  if (v == null || v.isEmpty) {
    return 'Email is required.';
  }
  // Tiny inline e-mail check. Real production code would use a more robust
  // pattern, but for instructional purposes we do not chase RFC 5322.
  final at = v.indexOf('@');
  final dot = v.lastIndexOf('.');
  if (at < 1) {
    return 'Email must contain an "@".';
  }
  if (dot <= at + 1) {
    return 'Email must contain a domain.';
  }
  if (dot >= v.length - 1) {
    return 'Email must end with a top-level domain.';
  }
  return null;
}

String? vPhone(String? v) {
  if (v == null || v.isEmpty) {
    return 'Phone number is required.';
  }
  int digits = 0;
  for (int i = 0; i < v.length; i++) {
    final ch = v.codeUnitAt(i);
    if (ch >= 0x30 && ch <= 0x39) {
      digits++;
    }
  }
  if (digits < 7) {
    return 'Phone number must contain at least 7 digits.';
  }
  return null;
}

String? vMinLength(String? v, int n) {
  if (v == null) {
    return 'This field is required.';
  }
  if (v.length < n) {
    return 'Must be at least $n characters.';
  }
  return null;
}

String? vMatchesRegex(String? v, RegExp re, String message) {
  if (v == null || v.isEmpty) {
    return 'This field is required.';
  }
  if (!re.hasMatch(v)) {
    return message;
  }
  return null;
}

String? vConfirmsPrior(String? v, String prior) {
  if (v == null || v.isEmpty) {
    return 'Please re-enter the value.';
  }
  if (v != prior) {
    return 'Entries do not match.';
  }
  return null;
}

Widget _buildValidatorCatalogue() {
  print(' Building Section 4: validator catalogue.');

  // We narrate each validator as a card with: name, rule, signature,
  // sample inputs and outcomes. We render the catalogue as a vertical
  // list so each validator gets full width.

  final items = <Map<String, Object>>[
    <String, Object>{
      'name': 'vRequired',
      'rule': 'Field must not be null and not empty.',
      'signature': 'String? vRequired(String? v)',
      'samples': const <List<String>>[
        <String>['', 'This field is required.'],
        <String>['Hadrian', '(no error)'],
        <String>['  ', '(no error --- whitespace counts as content here)'],
      ],
    },
    <String, Object>{
      'name': 'vEmail',
      'rule':
          'Field is required, must contain "@", must contain a "." after the '
              '"@", and must end with a top-level domain.',
      'signature': 'String? vEmail(String? v)',
      'samples': const <List<String>>[
        <String>['', 'Email is required.'],
        <String>['noat', 'Email must contain an "@".'],
        <String>['a@b', 'Email must contain a domain.'],
        <String>['a@b.', 'Email must end with a top-level domain.'],
        <String>['a@b.c', '(no error)'],
      ],
    },
    <String, Object>{
      'name': 'vPhone',
      'rule': 'Field is required and must contain at least 7 digit '
          'characters; non-digits (spaces, dashes, parentheses, plus '
          'signs) are tolerated and ignored.',
      'signature': 'String? vPhone(String? v)',
      'samples': const <List<String>>[
        <String>['', 'Phone number is required.'],
        <String>['123', 'Phone number must contain at least 7 digits.'],
        <String>['+44 20 7946 0958', '(no error)'],
        <String>['(415) 555-2671', '(no error)'],
      ],
    },
    <String, Object>{
      'name': 'vMinLength',
      'rule':
          'Field must contain at least N characters (configurable through '
              'the second argument). Passes on or above the threshold.',
      'signature': 'String? vMinLength(String? v, int n)',
      'samples': const <List<String>>[
        <String>['short, n=8', 'Must be at least 8 characters.'],
        <String>['longenoughstring, n=8', '(no error)'],
        <String>['null, n=4', 'This field is required.'],
      ],
    },
    <String, Object>{
      'name': 'vMatchesRegex',
      'rule':
          'Field must match the supplied RegExp; otherwise the supplied '
              'message is returned. Empty input returns the standard '
              '"required" message.',
      'signature':
          'String? vMatchesRegex(String? v, RegExp re, String message)',
      'samples': const <List<String>>[
        <String>['"abc123", /^[A-Za-z]+\$/, "letters only"', 'letters only'],
        <String>['"hello", /^[A-Za-z]+\$/, "letters only"', '(no error)'],
        <String>['"", /.+/, "no empty"', 'This field is required.'],
      ],
    },
    <String, Object>{
      'name': 'vConfirmsPrior',
      'rule': 'Field must equal the prior value supplied. Used for password '
          'confirmation and similar paired entries.',
      'signature': 'String? vConfirmsPrior(String? v, String prior)',
      'samples': const <List<String>>[
        <String>['"hunter2", prior="hunter2"', '(no error)'],
        <String>['"hunter3", prior="hunter2"', 'Entries do not match.'],
        <String>['"", prior="hunter2"', 'Please re-enter the value.'],
      ],
    },
  ];

  final cards = <Widget>[];
  for (int i = 0; i < items.length; i++) {
    cards.add(_buildValidatorCard(items[i]));
    if (i < items.length - 1) {
      cards.add(const SizedBox(height: 10));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: cards,
  );
}

Widget _buildValidatorCard(Map<String, Object> item) {
  final name = item['name'] as String;
  final rule = item['rule'] as String;
  final signature = item['signature'] as String;
  final samples = item['samples'] as List<List<String>>;

  // Sample rows.
  final sampleRows = <Widget>[];
  sampleRows.add(
    Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: cPewterPale,
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              'Input',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: cInkBlack,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              'Outcome',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: cInkBlack,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < samples.length; i++) {
    final row = samples[i];
    final input = row[0];
    final outcome = row[1];
    final bg = (i % 2 == 0) ? cParchment : cParchmentDim;
    final outcomeColor = outcome.startsWith('(no error)')
        ? cValid
        : cWaxRedDeep;
    sampleRows.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        color: bg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(
                input,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: cInkBlack,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                outcome,
                style: TextStyle(
                  fontSize: 11,
                  color: outcomeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      color: cBoneWhite,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cParchmentEdge, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: const BoxDecoration(
            color: cPewterDark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: cWaxRedLite,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: cParchment,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                signature,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: cParchment.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(rule, style: kBodyStyle),
        ),
        Column(children: sampleRows),
        const SizedBox(height: 4),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 5 --- Form.of(context) lookup pattern
// ===========================================================================

Widget _buildFormOfPattern() {
  print(' Building Section 5: Form.of(context) lookup pattern.');

  // Two-column layout: prose on the left, code excerpt on the right. The
  // code excerpt is rendered as a pewter-grey card with monospace text.

  final prose = Container(
    padding: const EdgeInsets.all(14),
    decoration: _proseDeco(),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Form.of(context)', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'Form.of(context) walks up the element tree from the supplied '
          'context until it finds the nearest Form ancestor, and returns '
          'that Form\'s State. The returned object is a FormState. If no '
          'Form ancestor exists, Form.of throws --- reach for '
          'Form.maybeOf(context) when the absence of a Form is a normal '
          'case.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'A common subtlety: if you call Form.of inside the SAME build '
          'method that constructs the Form, the supplied context will not '
          'be a descendant of the Form yet --- it will be the parent '
          'context. The remedy is to wrap the consumer in a Builder, '
          'whose builder receives a context that DOES sit beneath the '
          'Form. The example opposite shows the canonical wrapping.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'Form.of returns the live State, so methods like validate(), '
          'save() and reset() must only be called in event handlers --- '
          'never during build. Calling validate() during build is a '
          'classic source of "setState called during build" errors.',
          style: kBodyStyle,
        ),
      ],
    ),
  );

  final code = Container(
    padding: const EdgeInsets.all(14),
    decoration: _codeDeco(),
    child: const Text(
      "Widget build(BuildContext context) {\n"
      "  return Form(\n"
      "    autovalidateMode: AutovalidateMode.onUserInteraction,\n"
      "    child: Column(\n"
      "      children: [\n"
      "        TextFormField(\n"
      "          validator: vRequired,\n"
      "        ),\n"
      "        Builder(\n"
      "          builder: (innerCtx) {\n"
      "            // innerCtx IS a descendant of the Form,\n"
      "            // so Form.of(innerCtx) succeeds.\n"
      "            return ElevatedButton(\n"
      "              onPressed: () {\n"
      "                final state = Form.of(innerCtx);\n"
      "                if (state.validate()) {\n"
      "                  state.save();\n"
      "                }\n"
      "              },\n"
      "              child: const Text('Submit'),\n"
      "            );\n"
      "          },\n"
      "        ),\n"
      "      ],\n"
      "    ),\n"
      "  );\n"
      "}",
      style: kCodeStyle,
    ),
  );

  // Now show a small live mock of exactly that pattern --- a Form containing
  // a Builder that asks Form.of(context). We deliberately do NOT call
  // validate() inside the Builder; we only print the runtimeType to show
  // that the lookup succeeds.

  final liveMock = _deedFrame(
    title: 'Live mock --- Form.of(context) inside a Builder',
    subtitle: 'No validate() call; we only verify the lookup type.',
    sealLabel: 'OF',
    body: <Widget>[
      Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('email', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: 'pliny@ostia.example',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: vEmail,
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (innerCtx) {
                final state = Form.maybeOf(innerCtx);
                final type = state == null ? 'null' : state.runtimeType.toString();
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: cFelt,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Form.maybeOf(innerCtx) -> $type',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: cParchment,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ],
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: prose),
          const SizedBox(width: 12),
          Expanded(child: code),
        ],
      ),
      const SizedBox(height: 12),
      liveMock,
    ],
  );
}

// ===========================================================================
//  SECTION 6 --- GlobalKey<FormState> pattern
// ===========================================================================

Widget _buildGlobalKeyPattern() {
  print(' Building Section 6: GlobalKey<FormState> pattern.');

  final prose = Container(
    padding: const EdgeInsets.all(14),
    decoration: _proseDeco(),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('GlobalKey<FormState>', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'A GlobalKey<FormState> is the long-lived handle by which an '
          'OUTSIDE widget can speak to a Form. You create the key in a '
          'parent\'s State (or as a top-level final), pass it to the '
          'Form\'s "key:" parameter, and reach back into the Form via '
          'key.currentState whenever you need to validate, save or reset.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'Important rules: a GlobalKey must be created ONCE and reused '
          'across rebuilds; do not rebuild a fresh GlobalKey on every '
          'build, or you will detach the key from the Form\'s State. '
          'Create it in initState (or as a final field). On the first '
          'frame, key.currentState is null, because the Form has not been '
          'mounted yet --- so any code that needs the State must run in '
          'response to user input or a post-frame callback, not during '
          'build.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'When to prefer the key over Form.of(context): when the consumer '
          'is OUTSIDE the Form\'s subtree --- a top-level submit button '
          'that lives next to the Form, a parent dialog that needs to '
          'validate before dismissing, an AppBar action button, etc.',
          style: kBodyStyle,
        ),
      ],
    ),
  );

  final code = Container(
    padding: const EdgeInsets.all(14),
    decoration: _codeDeco(),
    child: const Text(
      "class _MyPageState extends State<MyPage> {\n"
      "  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();\n"
      "\n"
      "  @override\n"
      "  Widget build(BuildContext context) {\n"
      "    return Scaffold(\n"
      "      appBar: AppBar(\n"
      "        actions: [\n"
      "          IconButton(\n"
      "            icon: const Icon(Icons.check),\n"
      "            onPressed: () {\n"
      "              final state = _formKey.currentState;\n"
      "              if (state != null && state.validate()) {\n"
      "                state.save();\n"
      "              }\n"
      "            },\n"
      "          ),\n"
      "        ],\n"
      "      ),\n"
      "      body: Form(\n"
      "        key: _formKey,\n"
      "        child: ListView(children: [...]),\n"
      "      ),\n"
      "    );\n"
      "  }\n"
      "}",
      style: kCodeStyle,
    ),
  );

  // Mock that uses a top-level final GlobalKey<FormState> and renders the
  // Form. We do not call currentState anywhere --- the mock is just there
  // to show that the key plumbing is harmless at build time.
  final mockKey = GlobalKey<FormState>();
  final mock = _deedFrame(
    title: 'Live mock --- GlobalKey<FormState> attached',
    subtitle: 'currentState is null at build time; we read only its kind.',
    sealLabel: 'KEY',
    body: <Widget>[
      Form(
        key: mockKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('full name', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: 'Quintus Aurelius',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: vRequired,
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: cFelt,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          'mockKey.runtimeType -> ${mockKey.runtimeType}',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: cParchment,
          ),
        ),
      ),
    ],
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: prose),
          const SizedBox(width: 12),
          Expanded(child: code),
        ],
      ),
      const SizedBox(height: 12),
      mock,
    ],
  );
}

// ===========================================================================
//  SECTION 7 --- validate() / save() / reset() lifecycle prose
// ===========================================================================

Widget _buildLifecycleProse() {
  print(' Building Section 7: lifecycle prose.');

  // Three parchment cards in a row, then a long prose card explaining the
  // canonical "submit" handler.

  final validateCard = _buildLifecycleCard(
    icon: 'V',
    title: 'validate()',
    body:
        'Walks every FormFieldState beneath the Form, runs its validator, '
        'and updates the field\'s error text from the validator\'s return. '
        'Returns true if every field returned null. Returns false if any '
        'field returned a non-null error string.',
    sideEffects:
        'Mutates each FormFieldState\'s error text. The Form rebuilds; '
        'fields that have an error display it.',
    accent: cWaxRed,
  );

  final saveCard = _buildLifecycleCard(
    icon: 'S',
    title: 'save()',
    body:
        'Walks every FormFieldState beneath the Form and invokes its '
        'onSaved callback with the field\'s current value. Typically the '
        'onSaved closure writes into a model object held by the parent '
        'state.',
    sideEffects:
        'Calls user-supplied closures only. Does NOT validate; you must '
        'validate first and only save when validation passes.',
    accent: cValid,
  );

  final resetCard = _buildLifecycleCard(
    icon: 'R',
    title: 'reset()',
    body:
        'Walks every FormFieldState beneath the Form, returns each field '
        'to its initialValue, and clears all error text. The Form '
        'rebuilds in its pristine state.',
    sideEffects:
        'Useful after a successful save() (clear the form for re-entry) '
        'or as a "Cancel" button (discard the user\'s edits).',
    accent: cGiltDeep,
  );

  final canonicalHandler = Container(
    padding: const EdgeInsets.all(14),
    decoration: _codeDeco(),
    child: const Text(
      "void _onSubmit() {\n"
      "  final state = _formKey.currentState;\n"
      "  if (state == null) return;       // first-frame guard\n"
      "  if (!state.validate()) return;    // verdict: invalid\n"
      "  state.save();                     // commit values\n"
      "  // ... persist model, navigate, etc. ...\n"
      "  state.reset();                    // optional: clear form\n"
      "}",
      style: kCodeStyle,
    ),
  );

  final canonicalProse = Container(
    padding: const EdgeInsets.all(14),
    decoration: _proseDeco(),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('The canonical submit', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'The canonical "submit" handler is short and disciplined: '
          'guard against the null currentState, validate, bail out on a '
          'negative verdict, save, persist. reset() is optional --- you '
          'reset only when the user is expected to enter a fresh round '
          'of data immediately afterwards.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'A common mistake is to call save() unconditionally, on the '
          'theory that the Save button should "just save". But onSaved '
          'closures usually overwrite the model; if they fire on '
          'invalid data you have corrupted the model. Validate FIRST '
          'and only proceed if validation passes.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'Another pitfall: holding a stale FormState reference across '
          'rebuilds. Always re-read state from the key (or from '
          'Form.of(context)) inside the handler --- never cache it in a '
          'long-lived field.',
          style: kBodyStyle,
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: validateCard),
          const SizedBox(width: 10),
          Expanded(child: saveCard),
          const SizedBox(width: 10),
          Expanded(child: resetCard),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: canonicalHandler),
          const SizedBox(width: 12),
          Expanded(child: canonicalProse),
        ],
      ),
    ],
  );
}

Widget _buildLifecycleCard({
  required String icon,
  required String title,
  required String body,
  required String sideEffects,
  required Color accent,
}) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #111, P5(a)):
  // Original used `Border(left: accent/5, top/right/bottom:
  // cParchmentEdge/0.5)` + `borderRadius: 8`. Same non-uniform-Border-
  // with-borderRadius defect as _buildAnatomyCard. Refactor to a uniform
  // outer `Border.all(cParchmentEdge/0.5)` + a leading per-card accent
  // strip via `ClipRRect > IntrinsicHeight > Row`.
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: cParchment,
          border: Border.all(color: cParchmentEdge, width: 0.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(width: 5, color: accent),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accent,
                          ),
                          child: Text(
                            icon,
                            style: const TextStyle(
                              color: cParchment,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(title, style: kDeedTitleStyle),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(body, style: kBodyStyle),
                    const SizedBox(height: 8),
                    Text('Side effects', style: kSmallLabelStyle),
                    Text(sideEffects, style: kBodyStyle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ===========================================================================
//  SECTION 8 --- The eight notarised deeds
// ===========================================================================
//
//  Each deed is a Form widget rendered as a parchment "deed" --- a notarised
//  document with a wax-seal corner. The Form is real (it actually contains
//  TextFormField children with validators), but we never call validate(),
//  save() or reset() on it: the deeds are SNAPSHOTS, not interactions.
//
// ===========================================================================

Widget _buildDeedsLedger() {
  print(' Building Section 8: the eight notarised deeds.');

  final deeds = <Widget>[
    _buildDeedALogin(),
    _buildDeedBSignup(),
    _buildDeedCProfile(),
    _buildDeedDCheckout(),
    _buildDeedESettings(),
    _buildDeedFFeedback(),
    _buildDeedGResetPassword(),
    _buildDeedHOnboarding(),
  ];

  // Stack vertically with a small ledger header above each deed.
  final ledgerEntries = <Widget>[];
  final headers = <String>[
    'Deed A --- Plain login',
    'Deed B --- Signup (email + password + confirm)',
    'Deed C --- Profile edit (multi-line bio)',
    'Deed D --- Checkout address (international phone)',
    'Deed E --- Settings preferences',
    'Deed F --- Feedback survey (rating + comments)',
    'Deed G --- Reset password',
    'Deed H --- Onboarding (multi-step, single-page mock)',
  ];
  for (int i = 0; i < deeds.length; i++) {
    ledgerEntries.add(
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: cPewterMid,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: cGiltDeep, width: 1),
          ),
          child: Text(
            headers[i],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: cParchment,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
    );
    ledgerEntries.add(deeds[i]);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: ledgerEntries,
  );
}

// --- Deed A : plain login ---------------------------------------------------

Widget _buildDeedALogin() {
  return _deedFrame(
    title: 'Login --- the simplest deed',
    subtitle:
        'Two fields, no autovalidate, validators only at submit. The '
        'classic shape every modal authentication starts from.',
    sealLabel: 'LOGIN',
    body: <Widget>[
      Form(
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('email', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: 'curator@library.example',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
                hintText: 'name@example.com',
              ),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 12),
              validator: vEmail,
            ),
            const SizedBox(height: 10),
            const Text('password', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: 'hunter2',
              obscureText: true,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
                hintText: 'enter your password',
              ),
              style: const TextStyle(fontSize: 12),
              validator: (v) => vMinLength(v, 6),
            ),
          ],
        ),
      ),
    ],
  );
}

// --- Deed B : signup --------------------------------------------------------

Widget _buildDeedBSignup() {
  // We capture the password initialValue locally so that the confirm field
  // can compare against it via vConfirmsPrior. This is purely illustrative
  // --- in a real app the comparison happens against the live value of the
  // password TextFormField (typically through a TextEditingController).
  const String pw = 'hunter22';
  return _deedFrame(
    title: 'Signup --- email, password, confirm',
    subtitle:
        'Three fields, autovalidateMode.onUserInteraction at the Form '
        'level. The confirm field uses a paired-validator pattern.',
    sealLabel: 'SIGNUP',
    body: <Widget>[
      Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('email', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: 'novice@library.example',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 12),
              validator: vEmail,
            ),
            const SizedBox(height: 10),
            const Text('password', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: pw,
              obscureText: true,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
                helperText: 'at least 8 characters',
              ),
              style: const TextStyle(fontSize: 12),
              validator: (v) => vMinLength(v, 8),
            ),
            const SizedBox(height: 10),
            const Text('confirm password', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: pw,
              obscureText: true,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: (v) => vConfirmsPrior(v, pw),
            ),
          ],
        ),
      ),
    ],
  );
}

// --- Deed C : profile edit --------------------------------------------------

Widget _buildDeedCProfile() {
  return _deedFrame(
    title: 'Profile edit --- name, handle, multi-line bio',
    subtitle:
        'Mixed single- and multi-line fields. The bio uses maxLines and '
        'a generous minLines. Demonstrates that one Form can hold any '
        'mixture of FormField shapes.',
    sealLabel: 'PROFILE',
    body: <Widget>[
      Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('display name', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: 'Hadrian of Antioch',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: vRequired,
            ),
            const SizedBox(height: 10),
            const Text('handle', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: '@hadrian',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
                prefixText: '  ',
              ),
              style: const TextStyle(fontSize: 12),
              validator: (v) => vMatchesRegex(
                v,
                RegExp(r'^@[A-Za-z0-9_]{2,16}$'),
                'Handles begin with @, 2--16 letters, digits or underscores.',
              ),
            ),
            const SizedBox(height: 10),
            const Text('bio', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue:
                  'Cataloguer of nineteenth-century almanacs. Keeps a '
                  'small garden of irises and a large garden of footnotes. '
                  'Founder of the Society for the Preservation of '
                  'Marginalia.',
              maxLines: 4,
              minLines: 3,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: (v) => vMinLength(v, 16),
            ),
          ],
        ),
      ),
    ],
  );
}

// --- Deed D : checkout address ----------------------------------------------

Widget _buildDeedDCheckout() {
  return _deedFrame(
    title: 'Checkout address --- name, street, city, country, phone',
    subtitle:
        'Five fields. The phone field uses vPhone, which counts digits '
        'and tolerates dashes, spaces and "+". International-friendly.',
    sealLabel: 'CHECKOUT',
    body: <Widget>[
      Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('full name', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: 'Octavia Lentulus',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: vRequired,
            ),
            const SizedBox(height: 10),
            const Text('street address', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: '14 Vicus Patricius',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: vRequired,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text('city', style: kDeedFieldLabelStyle),
                      const SizedBox(height: 4),
                      TextFormField(
                        initialValue: 'Roma',
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 12),
                        validator: vRequired,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text('country', style: kDeedFieldLabelStyle),
                      const SizedBox(height: 4),
                      TextFormField(
                        initialValue: 'IT',
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 12),
                        validator: (v) => vMatchesRegex(
                          v,
                          RegExp(r'^[A-Z]{2}$'),
                          'Two-letter ISO code.',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('phone', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: '+39 06 6982 1234',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
                hintText: '+CC AAA NNN NNNN',
              ),
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 12),
              validator: vPhone,
            ),
          ],
        ),
      ),
    ],
  );
}

// --- Deed E : settings preferences ------------------------------------------

Widget _buildDeedESettings() {
  // Settings deeds typically combine TextFormField with toggle-shaped
  // controls. We represent the toggles statically as small parchment chips
  // so the deed remains a Form (validators applied to the text fields)
  // while the toggle row is purely illustrative.
  return _deedFrame(
    title: 'Settings preferences --- display name, locale, toggles',
    subtitle:
        'Demonstrates that a Form does not have to be ALL TextFormField '
        '--- the toggles below are decorative chips, while the text '
        'fields remain proper validated FormFields.',
    sealLabel: 'SETTINGS',
    body: <Widget>[
      Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('display name', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: 'Hadrian',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: vRequired,
            ),
            const SizedBox(height: 10),
            const Text('locale (BCP-47)', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: 'en-GB',
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: (v) => vMatchesRegex(
                v,
                RegExp(r'^[a-z]{2,3}(-[A-Z]{2})?$'),
                'BCP-47 like "en", "en-GB", "pt-BR".',
              ),
            ),
            const SizedBox(height: 12),
            const Text('toggles (illustrative)',
                style: kDeedFieldLabelStyle),
            const SizedBox(height: 6),
            Row(
              children: <Widget>[
                _buildToggleChip('dark theme', true),
                const SizedBox(width: 6),
                _buildToggleChip('analytics', false),
                const SizedBox(width: 6),
                _buildToggleChip('newsletter', true),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildToggleChip(String label, bool on) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: on ? cValid.withValues(alpha: 0.85) : cParchmentDim,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: on ? cValid : cParchmentEdge, width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: on ? cParchment : cPewterDark,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: on ? cParchment : cInkBlack,
          ),
        ),
      ],
    ),
  );
}

// --- Deed F : feedback survey -----------------------------------------------

Widget _buildDeedFFeedback() {
  return _deedFrame(
    title: 'Feedback survey --- rating + comments',
    subtitle:
        'A 5-pip rating row above a comments TextFormField. The rating '
        'row is illustrative; the comments field is a real FormField '
        'with a minLength validator.',
    sealLabel: 'FEEDBACK',
    body: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text('rating', style: kDeedFieldLabelStyle),
          const SizedBox(width: 10),
          _buildRatingPip(true),
          _buildRatingPip(true),
          _buildRatingPip(true),
          _buildRatingPip(true),
          _buildRatingPip(false),
        ],
      ),
      const SizedBox(height: 10),
      Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('comments', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue:
                  'The escritoire arrived in excellent condition. The '
                  'pewter inkwell was a touch tarnished but polished up '
                  'within the hour.',
              maxLines: 3,
              minLines: 2,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
                hintText: 'tell us what you thought',
              ),
              style: const TextStyle(fontSize: 12),
              validator: (v) => vMinLength(v, 12),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildRatingPip(bool filled) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? cWaxRed : cParchmentDim,
        border: Border.all(color: cInkBlack, width: 0.6),
      ),
    ),
  );
}

// --- Deed G : reset password ------------------------------------------------

Widget _buildDeedGResetPassword() {
  const String newPw = 'newhunter';
  return _deedFrame(
    title: 'Reset password --- old, new, confirm',
    subtitle:
        'Three fields. The "new" field must be 8+ chars. The "confirm" '
        'field must match the "new" field. The "old" field is required '
        'but its actual verification happens server-side.',
    sealLabel: 'RESET',
    body: <Widget>[
      Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('current password', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: 'hunter2',
              obscureText: true,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: vRequired,
            ),
            const SizedBox(height: 10),
            const Text('new password', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: newPw,
              obscureText: true,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
                helperText: 'at least 8 characters',
              ),
              style: const TextStyle(fontSize: 12),
              validator: (v) => vMinLength(v, 8),
            ),
            const SizedBox(height: 10),
            const Text('confirm new password', style: kDeedFieldLabelStyle),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: newPw,
              obscureText: true,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 12),
              validator: (v) => vConfirmsPrior(v, newPw),
            ),
          ],
        ),
      ),
    ],
  );
}

// --- Deed H : onboarding multi-step (single-page mock) ----------------------

Widget _buildDeedHOnboarding() {
  // We mock the impression of a multi-step form on a single page by
  // rendering three sub-deeds inside one outer Form, separated by
  // dividers. In a real app each step would be a separate page or a
  // PageView page; here the point is to show that one Form can scope
  // many fields across multiple visual sections.
  return _deedFrame(
    title: 'Onboarding --- three steps on one page',
    subtitle:
        'Three step-cards in a single Form. validate() at submit time '
        'checks every field across every step.',
    sealLabel: 'WELCOME',
    body: <Widget>[
      Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildOnboardingStep(
              stepNumber: 1,
              stepTitle: 'About you',
              fields: <Widget>[
                const Text('display name', style: kDeedFieldLabelStyle),
                const SizedBox(height: 4),
                TextFormField(
                  initialValue: 'Aurelia',
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 12),
                  validator: vRequired,
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildOnboardingStep(
              stepNumber: 2,
              stepTitle: 'Reach you',
              fields: <Widget>[
                const Text('email', style: kDeedFieldLabelStyle),
                const SizedBox(height: 4),
                TextFormField(
                  initialValue: 'aurelia@example.com',
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 12),
                  validator: vEmail,
                ),
                const SizedBox(height: 8),
                const Text('phone (optional)', style: kDeedFieldLabelStyle),
                const SizedBox(height: 4),
                TextFormField(
                  initialValue: '+44 20 7946 0958',
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontSize: 12),
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    return vPhone(v);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildOnboardingStep(
              stepNumber: 3,
              stepTitle: 'Secure you',
              fields: <Widget>[
                const Text('passphrase', style: kDeedFieldLabelStyle),
                const SizedBox(height: 4),
                TextFormField(
                  initialValue: 'iris-pewter-quill',
                  obscureText: true,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6),
                    border: OutlineInputBorder(),
                    helperText: 'three or more words separated by dashes',
                  ),
                  style: const TextStyle(fontSize: 12),
                  validator: (v) => vMatchesRegex(
                    v,
                    RegExp(r'^[a-z]+(-[a-z]+){2,}$'),
                    'Three or more lowercase words joined by dashes.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildOnboardingStep({
  required int stepNumber,
  required String stepTitle,
  required List<Widget> fields,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: cBoneWhite,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cParchmentEdge, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: cWaxRed,
              ),
              child: Text(
                '$stepNumber',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: cParchment,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              stepTitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: cInkBlack,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...fields,
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 9 --- Accessibility considerations
// ===========================================================================

Widget _buildAccessibilitySection() {
  print(' Building Section 9: accessibility considerations.');

  // Three accessibility cards (label, error, helper) plus a long prose
  // paragraph on assistive technology behaviour.

  final labelCard = _buildAccessibilityCard(
    icon: 'L',
    title: 'Labels (semanticLabel, labelText)',
    body:
        'Every TextFormField should declare a labelText (visible label) '
        'OR a semanticLabel (label exposed only to assistive '
        'technologies). Without one, a screen reader announces the field '
        'as "edit text" with no name --- a failure of basic perceivability.',
    advice:
        'Prefer labelText: it satisfies sighted and blind users with one '
        'declaration. Reach for semanticLabel only when visual real estate '
        'is at a premium and the visual context already names the field.',
  );

  final errorCard = _buildAccessibilityCard(
    icon: 'E',
    title: 'Errors (errorText)',
    body:
        'A validator\'s return value becomes the field\'s errorText. '
        'Screen readers announce the error when the field receives focus '
        'and the error is set. Keep error messages short, action-oriented '
        'and free of technical jargon.',
    advice:
        'Avoid generic "invalid" messages. Tell the user how to fix the '
        'problem: "Email must contain an @" not "Invalid email".',
  );

  final helperCard = _buildAccessibilityCard(
    icon: 'H',
    title: 'Helpers (helperText, hintText)',
    body:
        'helperText sits below the field and explains the rule before '
        'errors are shown ("at least 8 characters"). hintText sits inside '
        'the empty field and disappears on first keystroke. Both are '
        'announced by screen readers; do not duplicate the labelText in '
        'the helper.',
    advice:
        'Use helperText to communicate constraints proactively. Use '
        'hintText only for input format hints (placeholder examples), '
        'not for labels.',
  );

  final atProse = Container(
    padding: const EdgeInsets.all(14),
    decoration: _proseDeco(),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Assistive technologies and FormState',
            style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'When validate() updates errorText on a FormFieldState, the '
          'change is announced by the platform\'s assistive technology --- '
          'TalkBack on Android, VoiceOver on iOS, NVDA / JAWS on '
          'Windows. The announcement happens automatically because '
          'TextFormField wires its error state into the Semantics tree. '
          'You do NOT have to wire announcements manually.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'However: AutovalidateMode.always can produce a flood of '
          'announcements on first paint, particularly for users who tab '
          'through the form rapidly. Prefer onUserInteraction and let '
          'errors emerge gradually as the user engages with each field.',
          style: kBodyStyle,
        ),
        SizedBox(height: 8),
        Text(
          'Do not use colour alone to indicate validity. Provide an '
          'icon, an errorText string, or a helperText so the validity '
          'verdict is perceivable to colour-blind users and to screen '
          'reader users alike.',
          style: kBodyStyle,
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: labelCard),
          const SizedBox(width: 10),
          Expanded(child: errorCard),
          const SizedBox(width: 10),
          Expanded(child: helperCard),
        ],
      ),
      const SizedBox(height: 12),
      atProse,
    ],
  );
}

Widget _buildAccessibilityCard({
  required String icon,
  required String title,
  required String body,
  required String advice,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cParchment,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cParchmentEdge, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cWaxRedDeep,
                border: Border.all(color: cGiltDeep, width: 1),
              ),
              child: Text(
                icon,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: cParchment,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title, style: kDeedTitleStyle),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(body, style: kBodyStyle),
        const SizedBox(height: 8),
        Text('Advice', style: kSmallLabelStyle),
        Text(advice, style: kBodyStyle),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 10 --- Comparison with other libraries
// ===========================================================================

Widget _buildComparisonSection() {
  print(' Building Section 10: comparison with other libraries.');

  // We compare Flutter's FormState with: react-hook-form, formik, html5
  // form validation, flutter_form_builder. Each as a card with a "concept"
  // and a "Flutter analogue" column.

  final entries = <Map<String, String>>[
    <String, String>{
      'lib': 'react-hook-form',
      'concept':
          'register() returns input bindings; handleSubmit(fn) wraps the '
              'submit. Validation rules go on the register call.',
      'analogue':
          'TextFormField + validator: + onSaved:. handleSubmit -> '
              'state.validate() && state.save() inside an onPressed.',
    },
    <String, String>{
      'lib': 'formik',
      'concept':
          'A <Formik> component with initialValues, validate() and '
              'onSubmit. Field components read context for binding.',
      'analogue':
          'Form with autovalidateMode + initialValue per field. '
              'Form.of(context) is the equivalent of Formik\'s context-bound '
              'helper hooks.',
    },
    <String, String>{
      'lib': 'HTML5 native form validation',
      'concept':
          '<form> with <input required minlength pattern>. The browser '
              'enforces validity before submit.',
      'analogue':
          'Flutter\'s autovalidateMode + validator: closures. Browsers '
              'invoke validators on submit; FormState exposes the same '
              'pattern through validate().',
    },
    <String, String>{
      'lib': 'flutter_form_builder (community)',
      'concept':
          'FormBuilder widget with FormBuilderTextField and a richer set '
              'of field types out of the box.',
      'analogue':
          'A thin wrapper over Form / FormState with named-field access '
              'via FormBuilderState. Same validate()/save()/reset() '
              'lifecycle; identical mental model.',
    },
    <String, String>{
      'lib': 'reactive_forms (community)',
      'concept':
          'FormGroup / FormControl objects modelled on Angular\'s '
              'reactive forms. Streams emit value and status.',
      'analogue':
          'Replaces FormState entirely with a stream-based controller '
              'graph. Use when you need cross-field validation and live '
              'value streams; otherwise plain FormState is simpler.',
    },
  ];

  final cards = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    cards.add(_buildComparisonRow(entries[i], i));
    if (i < entries.length - 1) {
      cards.add(const SizedBox(height: 8));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: cards,
  );
}

Widget _buildComparisonRow(Map<String, String> e, int idx) {
  final lib = e['lib'] ?? '';
  final concept = e['concept'] ?? '';
  final analogue = e['analogue'] ?? '';
  final bg = (idx % 2 == 0) ? cParchment : cParchmentDim;
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cParchmentEdge, width: 0.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            lib,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: cWaxRedDeep,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Concept', style: kSmallLabelStyle),
              Text(concept, style: kBodyStyle),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Flutter analogue', style: kSmallLabelStyle),
              Text(analogue, style: kBodyStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 11 --- DO / AVOID callouts
// ===========================================================================

Widget _buildDoAvoidCallouts() {
  print(' Building Section 11: DO / AVOID callouts.');

  final dos = <String>[
    'DO read state via the key (or Form.of) inside the handler, not at '
        'build time --- currentState is null on first build.',
    'DO guard against a null currentState before calling validate() / '
        'save() / reset().',
    'DO call validate() FIRST and only call save() if validation '
        'succeeded. Never save invalid data.',
    'DO prefer AutovalidateMode.onUserInteraction: gentle on first paint, '
        'responsive once the user has begun.',
    'DO write specific, action-oriented validator messages: "Email must '
        'contain an @", not "Invalid email".',
    'DO use helperText to advertise field constraints proactively. '
        'Errors are last-resort feedback; helpers prevent them.',
    'DO co-locate related fields under one Form. The Form is the unit '
        'of submission; mirror your data model in its scope.',
    'DO test validators as pure functions. They take a String? and '
        'return String? --- the easiest unit-testable shape in the '
        'framework.',
  ];

  final avoids = <String>[
    'AVOID rebuilding a fresh GlobalKey<FormState>() inside build(). '
        'The key must outlive a single frame; create it in initState '
        'or as a final field.',
    'AVOID calling validate(), save() or reset() during build. They '
        'mutate state and rebuilds-from-build is illegal.',
    'AVOID AutovalidateMode.always for forms longer than two fields: '
        'a wall of red on first paint is hostile.',
    'AVOID bypassing validate() because "the validator already ran on '
        'unfocus". Always validate at submit; the user may submit '
        'without unfocusing.',
    'AVOID hiding validator failures: every validator that returns '
        'non-null must be visible to the user as either errorText or '
        'a Snackbar.',
    'AVOID using TextFormField as a non-Form text input. Use a plain '
        'TextField if you don\'t need a Form scope --- TextFormField '
        'pays for FormField machinery you would not use.',
    'AVOID storing the FormState reference in a long-lived field. The '
        'FormState may be replaced when the Form widget is rebuilt; '
        're-read it each time via the key.',
    'AVOID using a single Form to scope unrelated submissions. One '
        'Form per submit-able unit; multiple Forms can sit on one page.',
  ];

  // Two columns: DO on the left, AVOID on the right.
  final doRows = <Widget>[];
  doRows.add(
    Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: cValid,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          'DO',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: cParchment,
            letterSpacing: 1.6,
          ),
        ),
      ),
    ),
  );
  for (int i = 0; i < dos.length; i++) {
    doRows.add(_buildBulletRow(dos[i], cValid));
  }

  final avoidRows = <Widget>[];
  avoidRows.add(
    Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: cWaxRedDeep,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          'AVOID',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: cParchment,
            letterSpacing: 1.6,
          ),
        ),
      ),
    ),
  );
  for (int i = 0; i < avoids.length; i++) {
    avoidRows.add(_buildBulletRow(avoids[i], cWaxRedDeep));
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cBoneWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cValid, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: doRows,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cBoneWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cWaxRedDeep, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: avoidRows,
          ),
        ),
      ),
    ],
  );
}

Widget _buildBulletRow(String text, Color bullet) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 5, right: 8),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bullet,
          ),
        ),
        Expanded(child: Text(text, style: kBodyStyle)),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 12 --- Glossary
// ===========================================================================

Widget _buildGlossary() {
  print(' Building Section 12: glossary.');

  final terms = <Map<String, String>>[
    <String, String>{
      'term': 'Form',
      'def':
          'A StatefulWidget that scopes a group of FormField descendants. '
              'Has no visual chrome of its own.',
    },
    <String, String>{
      'term': 'FormState',
      'def':
          'The State<Form> object that carries validate(), save() and '
              'reset(). Reachable via Form.of(context) or '
              'GlobalKey<FormState>.currentState.',
    },
    <String, String>{
      'term': 'FormField<T>',
      'def':
          'The unit of work inside a Form: holds initialValue, validator, '
              'onSaved and a builder closure. Sub-classed by '
              'TextFormField, DropdownButtonFormField etc.',
    },
    <String, String>{
      'term': 'FormFieldState<T>',
      'def':
          'The State<FormField<T>> that actually remembers value and '
              'errorText, runs the validator, and emits errors.',
    },
    <String, String>{
      'term': 'FormFieldValidator<T>',
      'def': 'typedef String? Function(T? value). Returns null on success, '
          'an error message otherwise.',
    },
    <String, String>{
      'term': 'FormFieldSetter<T>',
      'def': 'typedef void Function(T? value). The signature of onSaved.',
    },
    <String, String>{
      'term': 'FormFieldBuilder<T>',
      'def':
          'typedef Widget Function(FormFieldState<T> field). Used to '
              'render custom FormFields.',
    },
    <String, String>{
      'term': 'AutovalidateMode',
      'def':
          'Enum with disabled / always / onUserInteraction / onUnfocus. '
              'Controls when validators run on their own.',
    },
    <String, String>{
      'term': 'GlobalKey<FormState>',
      'def':
          'Long-lived handle through which a widget OUTSIDE the Form '
              'subtree can call validate() / save() / reset().',
    },
    <String, String>{
      'term': 'validate()',
      'def':
          'Method on FormState. Walks every field, runs the validator, '
              'updates errorText, returns true iff every field passed.',
    },
    <String, String>{
      'term': 'save()',
      'def':
          'Method on FormState. Walks every field and invokes its '
              'onSaved callback. Does NOT validate.',
    },
    <String, String>{
      'term': 'reset()',
      'def':
          'Method on FormState. Walks every field, returns each to its '
              'initialValue, clears all errorText.',
    },
    <String, String>{
      'term': 'isValid',
      'def':
          'Property on FormState (Flutter 3.16+). Non-mutating check; '
              'use when AutovalidateMode is already running validators.',
    },
    <String, String>{
      'term': 'Form.of(context)',
      'def':
          'Static lookup that walks up the element tree from context to '
              'find the nearest Form ancestor and returns its FormState.',
    },
    <String, String>{
      'term': 'Form.maybeOf(context)',
      'def':
          'Like Form.of but returns null when no Form ancestor exists '
              '(rather than throwing).',
    },
  ];

  final rows = <Widget>[];
  for (int i = 0; i < terms.length; i++) {
    final term = terms[i]['term'] ?? '';
    final def = terms[i]['def'] ?? '';
    final bg = (i % 2 == 0) ? cParchment : cParchmentDim;
    rows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: bg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 170,
              child: Text(term, style: kGlossaryTermStyle),
            ),
            Expanded(child: Text(def, style: kGlossaryDefStyle)),
          ],
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      color: cBoneWhite,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cParchmentEdge, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            color: cPewterDark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 170,
                child: Text(
                  'Term',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: cParchment,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Definition',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: cParchment,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...rows,
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 13 --- Recap footer
// ===========================================================================

Widget _buildRecapFooter() {
  print(' Building Section 13: recap footer.');

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[cPewterDark, cInkBlue],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cGilt, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildWaxSeal(label: 'SEAL'),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'In witness whereof --- a recap',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: cParchment,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'FormState is the office that keeps the registry of a Form\'s '
          'fields. validate() walks the registry and asks each field for '
          'its verdict; save() walks the registry and instructs each '
          'field to commit; reset() walks the registry and returns each '
          'field to its origin. AutovalidateMode chooses when validators '
          'run on their own: disabled (only on demand), onUserInteraction '
          '(after first touch), onUnfocus (on tab-out), always (every '
          'build). Reach a FormState via Form.of(context) inside a '
          'descendant Builder, or via a GlobalKey<FormState> from outside '
          'the Form\'s subtree.',
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: cParchment,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Validators are pure functions of String? -> String?. Test '
          'them in isolation; compose them where they live. helperText '
          'advertises constraints; errorText is last-resort feedback. '
          'Co-locate one Form per submit-able unit; let your data model '
          'inform your Form scope.',
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: cParchmentDim,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: cInkBlack.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: cGiltDeep, width: 1),
          ),
          child: const Text(
            'Signed and sealed in the chambers of the undersigned this '
            'day, by the authority of FormState and the witness of '
            'eight notarised deeds, that all who shall consult this '
            'instrument may know the office of validate(), save() and '
            'reset().',
            style: TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: cParchment,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
