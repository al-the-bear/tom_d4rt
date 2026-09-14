// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the Flutter widgets/AutofillGroup family.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports a single
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a long, static poster that walks through Flutter's
// autofill subsystem from the framework's perspective. Seven thematic
// sections cover:
//
//   1. Hero banner - what AutofillGroup, AutofillScope, AutofillClient and
//      AutofillHints actually buy you, and the three native backends.
//   2. Anatomy CustomPainter - the AutofillScope diagram showing one
//      AutofillGroup (the scope), several AutofillClients (the fields),
//      and the platform-side IME bridge that ships AutofillContextAction
//      messages across the boundary.
//   3. AutofillHints swatch grid - a colour-coded gallery of the hint
//      constants, grouped by domain: Identity, Contact, Address, Financial,
//      Auth, Locale.
//   4. Registration form mockup - non-interactive TextField placeholders
//      rendered as static rows, each tagged with its `autofillHints` badge
//      and grouped inside a visual AutofillGroup boundary.
//   5. Commit-vs-Cancel state diagram - two parallel flows showing the
//      effect of `TextInput.finishAutofillContext(shouldSave: true)` versus
//      `shouldSave: false`, and how `AutofillContextAction` enums fan out.
//   6. Platform matrix - a comparison table across iOS / Android / Web /
//      Windows / macOS / Linux showing which hints are honoured and what
//      backend powers the save dialog.
//   7. Code-snippet cards - four idiomatic recipes (AutofillGroup wrap,
//      autofillHints on TextField, manual commit/cancel, OTP/SMS hint).
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no live
// `AnimationController`, no `for-in` loops over Flutter-bridged collections.
// AutofillGroup/AutofillClient widgets are not instantiated for live focus
// transactions; instead we draw their logical structure with Containers and
// CustomPaint so the demo stays deterministic on a single frame.
import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// We pick literal ARGB values so the demo is theme-independent. The palette
// borrows from a "sky on porcelain" mood since autofill is essentially a
// communication channel between app and OS - cyan reads as "data in flight".
const Color _kCanvas = Color(0xFFF1F5F9);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF7FAFC);
const Color _kCardDark = Color(0xFF111827);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF0F172A);
const Color _kInkSecondary = Color(0xFF334155);
const Color _kInkTertiary = Color(0xFF94A3B8);
const Color _kInkOnDark = Color(0xFFE2E8F0);
const Color _kInkOnDarkSecondary = Color(0xFF94A3B8);
const Color _kAccent = Color(0xFF0EA5E9); // sky-500
const Color _kAccentSoft = Color(0xFFE0F2FE);
const Color _kAccentDeep = Color(0xFF0369A1);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentTeal = Color(0xFF14B8A6);
const Color _kAccentGreen = Color(0xFF22C55E);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentViolet = Color(0xFF8B5CF6);
const Color _kAccentSlate = Color(0xFF64748B);
const Color _kCodeBg = Color(0xFF0B1220);
const Color _kCodeText = Color(0xFFE6EDF7);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF64748B);
const Color _kSaveBg = Color(0xFFECFDF5);
const Color _kSaveBorder = Color(0xFF34D399);
const Color _kCancelBg = Color(0xFFFEF2F2);
const Color _kCancelBorder = Color(0xFFFCA5A5);

const TextStyle _kTitleStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.4,
);
const TextStyle _kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: _kInkSecondary,
);
const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 12.0,
  color: _kInkTertiary,
  fontWeight: FontWeight.w500,
);
const TextStyle _kBodyStyle = TextStyle(
  fontSize: 14.0,
  height: 1.45,
  color: _kInk,
);
const TextStyle _kBodySoftStyle = TextStyle(
  fontSize: 13.0,
  height: 1.4,
  color: _kInkSecondary,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.45,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kMonoInlineStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kInk,
  height: 1.3,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);

// ---------------------------------------------------------------------------
// PRIVATE BUILDER HELPERS
// ---------------------------------------------------------------------------
// These helpers stay as top-level private functions so the file reads
// linearly from header to footer. They mirror the convention used in
// widgets/focusnode_test.dart but with autofill-specific accents.

Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 30.0,
      bottom: 12.0,
      left: 18.0,
      right: 18.0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40.0,
          height: 40.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kTitleStyle),
              const SizedBox(height: 2.0),
              Text(tagline, style: _kSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = const EdgeInsets.symmetric(
    horizontal: 18.0,
    vertical: 6.0,
  ),
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(
  String title, {
  String? subtitle,
  Color titleColor = _kInk,
  Color subtitleColor = _kInkSecondary,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: titleColor,
          letterSpacing: -0.2,
        ),
      ),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 2.0),
        Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
      ],
    ],
  );
}

Widget _pill(String label, {Color colour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: colour,
      ),
    ),
  );
}

Widget _hintBadge(String label, Color colour) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.15),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: colour.withOpacity(0.35)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10.5,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
        color: colour,
      ),
    ),
  );
}

Widget _codeBlock(String code, {String? title}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF1F2937)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kCodeAccent,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
        Text(code, style: _kCodeStyle),
      ],
    ),
  );
}

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
    height: 1.0,
    color: _kHairline,
  );
}

Widget _kvRow(String key, String value, {Color valueColour = _kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: valueColour,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 - HERO BANNER
// ---------------------------------------------------------------------------
Widget _heroBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0C4A6E),
          Color(0xFF0369A1),
          Color(0xFF06B6D4),
        ],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x330C4A6E),
          offset: Offset(0.0, 6.0),
          blurRadius: 18.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'package:flutter/widgets.dart',
                style: TextStyle(
                  color: Color(0xFFE0F2FE),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'autofill.dart',
                style: TextStyle(
                  color: Color(0xFFE0F2FE),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'AutofillGroup, AutofillScope & AutofillHints',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'The bridge between TextInput-backed fields and the native '
          'credential vaults: iOS Keychain, Android Autofill Framework, '
          'Windows Credential Manager, and password managers via the '
          'web platform.',
          style: TextStyle(
            color: Color(0xFFCBD5F5),
            fontSize: 14.0,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('AutofillGroup', colour: const Color(0xFFE0F2FE)),
            _pill('AutofillScope', colour: const Color(0xFFFDE68A)),
            _pill('AutofillClient', colour: const Color(0xFFA7F3D0)),
            _pill('AutofillHints', colour: const Color(0xFFFBCFE8)),
            _pill('AutofillContextAction', colour: const Color(0xFFDDD6FE)),
            _pill('TextInput.finishAutofillContext', colour: const Color(0xFFFCA5A5)),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - ANATOMY DIAGRAM
// ---------------------------------------------------------------------------
class _AnatomyDiagramPainter extends CustomPainter {
  const _AnatomyDiagramPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kCardSoft;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        const Radius.circular(10.0),
      ),
      bg,
    );

    // Outer group rectangle - the AutofillGroup
    final double groupLeft = 24.0;
    final double groupTop = 32.0;
    final double groupRight = size.width - 220.0;
    final double groupBottom = size.height - 24.0;
    final Paint groupFill = Paint()..color = _kAccentSoft;
    final Paint groupStroke = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final RRect groupRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(groupLeft, groupTop, groupRight, groupBottom),
      const Radius.circular(12.0),
    );
    canvas.drawRRect(groupRect, groupFill);
    canvas.drawRRect(groupRect, groupStroke);

    final TextPainter groupLabel = TextPainter(
      text: const TextSpan(
        text: 'AutofillGroup  (AutofillScope)',
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: _kAccentDeep,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    groupLabel.layout();
    groupLabel.paint(canvas, Offset(groupLeft + 12.0, groupTop + 8.0));

    // Four client nodes inside the group
    final List<String> clients = <String>[
      'AutofillClient #1',
      'AutofillClient #2',
      'AutofillClient #3',
      'AutofillClient #4',
    ];
    final List<String> clientHints = <String>[
      'name',
      'email',
      'telephoneNumber',
      'postalCode',
    ];
    final double clientLeft = groupLeft + 18.0;
    final double clientRight = groupRight - 18.0;
    final double clientHeight = 36.0;
    final double clientStart = groupTop + 34.0;
    for (int i = 0; i < clients.length; i++) {
      final double y = clientStart + i * (clientHeight + 8.0);
      final RRect r = RRect.fromRectAndRadius(
        Rect.fromLTRB(clientLeft, y, clientRight, y + clientHeight),
        const Radius.circular(8.0),
      );
      final Paint fill = Paint()..color = _kCardBg;
      final Paint stroke = Paint()
        ..color = _kAccent.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawRRect(r, fill);
      canvas.drawRRect(r, stroke);

      final TextPainter clientLabel = TextPainter(
        text: TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: clients[i],
              style: const TextStyle(
                fontSize: 12.0,
                color: _kInk,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
            const TextSpan(
              text: '   hint: ',
              style: TextStyle(
                fontSize: 11.5,
                color: _kInkTertiary,
                fontFamily: 'monospace',
              ),
            ),
            TextSpan(
              text: clientHints[i],
              style: const TextStyle(
                fontSize: 11.5,
                color: _kAccentDeep,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
      );
      clientLabel.layout();
      clientLabel.paint(
        canvas,
        Offset(clientLeft + 10.0, y + (clientHeight - clientLabel.height) / 2.0),
      );

      // Arrow from this client to the platform bridge
      final double arrowFromX = clientRight;
      final double arrowFromY = y + clientHeight / 2.0;
      final double arrowToX = size.width - 196.0;
      final double arrowToY = size.height / 2.0;
      final Paint arrowPaint = Paint()
        ..color = _kAccent.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      final Path p = Path()
        ..moveTo(arrowFromX, arrowFromY)
        ..cubicTo(
          arrowFromX + 40.0,
          arrowFromY,
          arrowToX - 40.0,
          arrowToY,
          arrowToX,
          arrowToY,
        );
      canvas.drawPath(p, arrowPaint);
    }

    // Platform IME bridge on the right
    final double bridgeLeft = size.width - 196.0;
    final double bridgeTop = 60.0;
    final double bridgeRight = size.width - 24.0;
    final double bridgeBottom = size.height - 60.0;
    final Paint bridgeFill = Paint()..color = _kCardDark;
    final RRect bridgeRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(bridgeLeft, bridgeTop, bridgeRight, bridgeBottom),
      const Radius.circular(12.0),
    );
    canvas.drawRRect(bridgeRect, bridgeFill);

    final TextPainter bridgeTitle = TextPainter(
      text: const TextSpan(
        text: 'TextInput\nplatform channel',
        style: TextStyle(
          fontSize: 12.0,
          color: _kInkOnDark,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
          height: 1.3,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    bridgeTitle.layout(maxWidth: 160.0);
    bridgeTitle.paint(canvas, Offset(bridgeLeft + 12.0, bridgeTop + 12.0));

    final List<String> backends = <String>[
      'iOS UITextField',
      'Android AutofillManager',
      'Win32 Credential UI',
      'Web autocomplete=*',
    ];
    for (int i = 0; i < backends.length; i++) {
      final double bY = bridgeTop + 56.0 + i * 26.0;
      final TextPainter t = TextPainter(
        text: TextSpan(
          text: '\u2022 ${backends[i]}',
          style: const TextStyle(
            fontSize: 11.0,
            color: _kInkOnDarkSecondary,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      t.layout();
      t.paint(canvas, Offset(bridgeLeft + 12.0, bY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _anatomyDiagram() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Scope anatomy',
          subtitle:
              'AutofillGroup is the scope; every TextField with a non-null '
              'autofillHints list inside it acts as an AutofillClient.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 260.0,
          child: CustomPaint(
            painter: const _AnatomyDiagramPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _pill('AutofillScope.attach', colour: _kAccent),
            _pill('AutofillClient.textInputConfiguration', colour: _kAccentTeal),
            _pill('AutofillScope.autofillClients', colour: _kAccentViolet),
            _pill('TextInput.attach', colour: _kAccentBlue),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - AUTOFILLHINTS SWATCH GRID
// ---------------------------------------------------------------------------
class _HintEntry {
  const _HintEntry(this.name, this.category, this.colour);
  final String name;
  final String category;
  final Color colour;
}

const List<_HintEntry> _kHintCatalogue = <_HintEntry>[
  // Identity
  _HintEntry('name', 'Identity', _kAccentBlue),
  _HintEntry('givenName', 'Identity', _kAccentBlue),
  _HintEntry('middleName', 'Identity', _kAccentBlue),
  _HintEntry('familyName', 'Identity', _kAccentBlue),
  _HintEntry('namePrefix', 'Identity', _kAccentBlue),
  _HintEntry('nameSuffix', 'Identity', _kAccentBlue),
  _HintEntry('nickname', 'Identity', _kAccentBlue),
  _HintEntry('birthday', 'Identity', _kAccentBlue),
  _HintEntry('birthdayDay', 'Identity', _kAccentBlue),
  _HintEntry('gender', 'Identity', _kAccentBlue),

  // Contact
  _HintEntry('email', 'Contact', _kAccentTeal),
  _HintEntry('username', 'Contact', _kAccentTeal),
  _HintEntry('telephoneNumber', 'Contact', _kAccentTeal),
  _HintEntry('telephoneNumberAreaCode', 'Contact', _kAccentTeal),
  _HintEntry('telephoneNumberDevice', 'Contact', _kAccentTeal),
  _HintEntry('telephoneNumberCountryCode', 'Contact', _kAccentTeal),
  _HintEntry('telephoneNumberExtension', 'Contact', _kAccentTeal),

  // Address
  _HintEntry('streetAddressLine1', 'Address', _kAccentAmber),
  _HintEntry('streetAddressLine2', 'Address', _kAccentAmber),
  _HintEntry('streetAddressLine3', 'Address', _kAccentAmber),
  _HintEntry('addressCity', 'Address', _kAccentAmber),
  _HintEntry('addressState', 'Address', _kAccentAmber),
  _HintEntry('postalCode', 'Address', _kAccentAmber),
  _HintEntry('postalCodeExtended', 'Address', _kAccentAmber),
  _HintEntry('countryName', 'Address', _kAccentAmber),
  _HintEntry('countryCode', 'Address', _kAccentAmber),
  _HintEntry('addressCityAndState', 'Address', _kAccentAmber),

  // Financial
  _HintEntry('creditCardNumber', 'Financial', _kAccentRose),
  _HintEntry('creditCardSecurityCode', 'Financial', _kAccentRose),
  _HintEntry('creditCardExpirationDate', 'Financial', _kAccentRose),
  _HintEntry('creditCardExpirationMonth', 'Financial', _kAccentRose),
  _HintEntry('creditCardExpirationYear', 'Financial', _kAccentRose),
  _HintEntry('creditCardName', 'Financial', _kAccentRose),
  _HintEntry('creditCardType', 'Financial', _kAccentRose),

  // Auth
  _HintEntry('password', 'Auth', _kAccentViolet),
  _HintEntry('newPassword', 'Auth', _kAccentViolet),
  _HintEntry('newUsername', 'Auth', _kAccentViolet),
  _HintEntry('oneTimeCode', 'Auth', _kAccentViolet),

  // Locale / misc
  _HintEntry('language', 'Locale', _kAccentSlate),
  _HintEntry('jobTitle', 'Locale', _kAccentSlate),
  _HintEntry('organizationName', 'Locale', _kAccentSlate),
  _HintEntry('url', 'Locale', _kAccentSlate),
  _HintEntry('photo', 'Locale', _kAccentSlate),
];

Widget _hintSwatchGrid() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'AutofillHints catalogue',
          subtitle:
              'Forty-plus const strings on AutofillHints. Colour-coded by '
              'data domain so duplicates and gaps are easy to spot.',
        ),
        const SizedBox(height: 16.0),
        _hintCategoryLegend(),
        const SizedBox(height: 14.0),
        _hintGrid(),
      ],
    ),
  );
}

Widget _hintCategoryLegend() {
  return Wrap(
    spacing: 10.0,
    runSpacing: 6.0,
    children: <Widget>[
      _legendChip('Identity', _kAccentBlue),
      _legendChip('Contact', _kAccentTeal),
      _legendChip('Address', _kAccentAmber),
      _legendChip('Financial', _kAccentRose),
      _legendChip('Auth', _kAccentViolet),
      _legendChip('Locale', _kAccentSlate),
    ],
  );
}

Widget _legendChip(String label, Color colour) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.10),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: colour.withOpacity(0.35)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: colour,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _hintGrid() {
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < _kHintCatalogue.length; i++) {
    tiles.add(_hintTile(_kHintCatalogue[i]));
  }
  return Wrap(spacing: 8.0, runSpacing: 8.0, children: tiles);
}

Widget _hintTile(_HintEntry entry) {
  return Container(
    width: 178.0,
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: entry.colour.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: entry.colour.withOpacity(0.3)),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: entry.colour,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            entry.name,
            style: const TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: _kInk,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - REGISTRATION FORM MOCKUP
// ---------------------------------------------------------------------------
class _FieldRow {
  const _FieldRow(this.label, this.placeholder, this.hint, this.colour);
  final String label;
  final String placeholder;
  final String hint;
  final Color colour;
}

const List<_FieldRow> _kPersonalGroup = <_FieldRow>[
  _FieldRow('First name', 'Ada', 'givenName', _kAccentBlue),
  _FieldRow('Last name', 'Lovelace', 'familyName', _kAccentBlue),
  _FieldRow('Email', 'ada@analytical.example', 'email', _kAccentTeal),
  _FieldRow('Phone', '+44 20 7946 0958', 'telephoneNumber', _kAccentTeal),
];

const List<_FieldRow> _kAddressGroup = <_FieldRow>[
  _FieldRow('Address line 1', '12 Marlborough Place', 'streetAddressLine1', _kAccentAmber),
  _FieldRow('City', 'London', 'addressCity', _kAccentAmber),
  _FieldRow('Postal code', 'NW8 0PT', 'postalCode', _kAccentAmber),
  _FieldRow('Country', 'United Kingdom', 'countryName', _kAccentAmber),
];

const List<_FieldRow> _kPaymentGroup = <_FieldRow>[
  _FieldRow('Card number', '4242 4242 4242 4242', 'creditCardNumber', _kAccentRose),
  _FieldRow('Expiry MM/YY', '04 / 28', 'creditCardExpirationDate', _kAccentRose),
  _FieldRow('CVV', '737', 'creditCardSecurityCode', _kAccentRose),
];

const List<_FieldRow> _kAuthGroup = <_FieldRow>[
  _FieldRow('Username', 'ada.lovelace', 'newUsername', _kAccentViolet),
  _FieldRow('Password', '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022', 'newPassword', _kAccentViolet),
  _FieldRow('SMS code', '123456', 'oneTimeCode', _kAccentViolet),
];

Widget _formMockup() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Registration form mockup',
          subtitle:
              'Each visual group is one AutofillGroup. Every row is rendered '
              'as a non-interactive TextField placeholder paired with the '
              'autofillHints constant it would carry.',
        ),
        const SizedBox(height: 14.0),
        _formGroupBlock(
          'AutofillGroup #1 - Personal',
          _kAccentBlue,
          _kPersonalGroup,
        ),
        const SizedBox(height: 12.0),
        _formGroupBlock(
          'AutofillGroup #2 - Shipping address',
          _kAccentAmber,
          _kAddressGroup,
        ),
        const SizedBox(height: 12.0),
        _formGroupBlock(
          'AutofillGroup #3 - Payment',
          _kAccentRose,
          _kPaymentGroup,
        ),
        const SizedBox(height: 12.0),
        _formGroupBlock(
          'AutofillGroup #4 - Credentials',
          _kAccentViolet,
          _kAuthGroup,
        ),
      ],
    ),
  );
}

Widget _formGroupBlock(String label, Color colour, List<_FieldRow> rows) {
  final List<Widget> fieldWidgets = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    fieldWidgets.add(_formFieldRow(rows[i]));
    if (i != rows.length - 1) {
      fieldWidgets.add(const SizedBox(height: 8.0));
    }
  }
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.05),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: colour.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: colour,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                color: colour,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        ...fieldWidgets,
      ],
    ),
  );
}

Widget _formFieldRow(_FieldRow row) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        width: 120.0,
        child: Text(
          row.label,
          style: const TextStyle(
            fontSize: 12.5,
            color: _kInkSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Expanded(
        child: IgnorePointer(
          child: Container(
            height: 36.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: _kCardBg,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _kHairline),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              row.placeholder,
              style: const TextStyle(fontSize: 13.0, color: _kInk),
            ),
          ),
        ),
      ),
      const SizedBox(width: 10.0),
      _hintBadge(row.hint, row.colour),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - COMMIT vs CANCEL DIAGRAM
// ---------------------------------------------------------------------------
Widget _commitCancelDiagram() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'finishAutofillContext: commit vs cancel',
          subtitle:
              'TextInput.finishAutofillContext(shouldSave) is the only API '
              'that closes an AutofillContext. shouldSave maps directly to '
              'AutofillContextAction.commit / .cancel.',
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _commitColumn()),
            const SizedBox(width: 14.0),
            Expanded(child: _cancelColumn()),
          ],
        ),
        const SizedBox(height: 14.0),
        _commitCancelLegend(),
      ],
    ),
  );
}

Widget _commitColumn() {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kSaveBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kSaveBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kAccentGreen,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'shouldSave: true',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            const Text(
              'AutofillContextAction.commit',
              style: TextStyle(
                fontSize: 12.0,
                color: _kAccentDeep,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _stepRow('1', 'User taps "Sign up"'),
        _stepRow('2', 'TextInput.finishAutofillContext(shouldSave: true)'),
        _stepRow('3', 'AutofillScope.onDone(commit) fires on each client'),
        _stepRow('4', 'Platform shows save prompt'),
        _stepRow('5', 'Keychain / AutofillManager stores the record'),
        const SizedBox(height: 6.0),
        const Text(
          'Use commit when the user has just confirmed a credential. '
          'The platform may dedupe against existing records.',
          style: _kBodySoftStyle,
        ),
      ],
    ),
  );
}

Widget _cancelColumn() {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCancelBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kCancelBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kAccentRose,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'shouldSave: false',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            const Text(
              'AutofillContextAction.cancel',
              style: TextStyle(
                fontSize: 12.0,
                color: _kAccentRose,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _stepRow('1', 'User backs out of the form'),
        _stepRow('2', 'TextInput.finishAutofillContext(shouldSave: false)'),
        _stepRow('3', 'AutofillScope.onDone(cancel) fires on each client'),
        _stepRow('4', 'Platform suppresses save prompt'),
        _stepRow('5', 'Pending context is discarded'),
        const SizedBox(height: 6.0),
        const Text(
          'Use cancel when the user navigates away without submitting, '
          'or when validation fails after first edit.',
          style: _kBodySoftStyle,
        ),
      ],
    ),
  );
}

Widget _stepRow(String index, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 18.0,
          height: 18.0,
          margin: const EdgeInsets.only(top: 1.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kCardBg,
            shape: BoxShape.circle,
          ),
          child: Text(
            index,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 12.0,
              color: _kInk,
              fontFamily: 'monospace',
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _commitCancelLegend() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AutofillContextAction enum',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            color: _kInkSecondary,
          ),
        ),
        const SizedBox(height: 6.0),
        _kvRow('commit', 'Persist captured values into the platform vault.', valueColour: _kAccentGreen),
        _kvRow('cancel', 'Discard captured values; suppress save prompt.', valueColour: _kAccentRose),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - PLATFORM COMPARISON MATRIX
// ---------------------------------------------------------------------------
class _PlatformRow {
  const _PlatformRow(this.name, this.backend, this.identity, this.address, this.creditCard, this.oneTimeCode);
  final String name;
  final String backend;
  final String identity;
  final String address;
  final String creditCard;
  final String oneTimeCode;
}

const List<_PlatformRow> _kPlatformRows = <_PlatformRow>[
  _PlatformRow('iOS', 'Keychain Services', 'full', 'full', 'full', 'SMS / OS share-sheet'),
  _PlatformRow('Android', 'AutofillManager (>=O)', 'full', 'full', 'full', 'SMS Retriever API'),
  _PlatformRow('Web', 'autocomplete attribute', 'full', 'full', 'partial', 'browser-driven'),
  _PlatformRow('Windows', 'Credential Manager', 'partial', 'limited', 'limited', 'not supported'),
  _PlatformRow('macOS', 'Keychain Services', 'full', 'full', 'full', 'SMS via Continuity'),
  _PlatformRow('Linux', 'no-op', 'none', 'none', 'none', 'none'),
];

Widget _platformMatrix() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Platform matrix',
          subtitle:
              'Which autofillHints families are honoured on each platform. '
              'Web folds Flutter hints to native autocomplete tokens.',
        ),
        const SizedBox(height: 14.0),
        _matrixHeaderRow(),
        ..._matrixBodyRows(),
        const SizedBox(height: 10.0),
        _matrixLegend(),
      ],
    ),
  );
}

Widget _matrixHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: <Widget>[
        _matrixCell('Platform', flex: 2, onDark: true, bold: true),
        _matrixCell('Backend', flex: 3, onDark: true, bold: true),
        _matrixCell('Identity', flex: 2, onDark: true, bold: true),
        _matrixCell('Address', flex: 2, onDark: true, bold: true),
        _matrixCell('Card', flex: 2, onDark: true, bold: true),
        _matrixCell('OTP', flex: 3, onDark: true, bold: true),
      ],
    ),
  );
}

List<Widget> _matrixBodyRows() {
  final List<Widget> out = <Widget>[];
  for (int i = 0; i < _kPlatformRows.length; i++) {
    final _PlatformRow row = _kPlatformRows[i];
    final Color rowBg = i.isEven ? _kCardBg : _kCardSoft;
    out.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: rowBg,
          border: const Border(
            bottom: BorderSide(color: _kHairline),
          ),
        ),
        child: Row(
          children: <Widget>[
            _matrixCell(row.name, flex: 2, bold: true),
            _matrixCell(row.backend, flex: 3),
            _capabilityCell(row.identity, flex: 2),
            _capabilityCell(row.address, flex: 2),
            _capabilityCell(row.creditCard, flex: 2),
            _matrixCell(row.oneTimeCode, flex: 3),
          ],
        ),
      ),
    );
  }
  return out;
}

Widget _matrixCell(String label, {int flex = 1, bool onDark = false, bool bold = false}) {
  return Expanded(
    flex: flex,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.5,
        fontFamily: 'monospace',
        color: onDark ? _kInkOnDark : _kInk,
        fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
      ),
    ),
  );
}

Widget _capabilityCell(String value, {int flex = 1}) {
  Color colour;
  switch (value) {
    case 'full':
      colour = _kAccentGreen;
      break;
    case 'partial':
      colour = _kAccentAmber;
      break;
    case 'limited':
      colour = _kAccentRose;
      break;
    case 'none':
      colour = _kInkTertiary;
      break;
    default:
      colour = _kInkSecondary;
  }
  return Expanded(
    flex: flex,
    child: Row(
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: colour,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _matrixLegend() {
  return Wrap(
    spacing: 10.0,
    runSpacing: 6.0,
    children: <Widget>[
      _legendChip('full - all hints honoured', _kAccentGreen),
      _legendChip('partial - common hints only', _kAccentAmber),
      _legendChip('limited - vendor specific', _kAccentRose),
      _legendChip('none - no native bridge', _kInkTertiary),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - CODE SNIPPETS
// ---------------------------------------------------------------------------
Widget _codeSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: _cardTitle(
          'Idiomatic recipes',
          subtitle:
              'Four snippets every team copies into the first signup form. '
              'No StatefulWidget tricks: just declarative wiring.',
        ),
      ),
      _codeBlock(
        'AutofillGroup(\n'
        '  onDisposeAction: AutofillContextAction.commit,\n'
        '  child: Form(\n'
        '    key: _formKey,\n'
        '    child: Column(\n'
        '      children: <Widget>[\n'
        '        TextFormField(\n'
        '          autofillHints: const <String>[AutofillHints.email],\n'
        '          decoration: const InputDecoration(labelText: "Email"),\n'
        '        ),\n'
        '        TextFormField(\n'
        '          autofillHints: const <String>[AutofillHints.password],\n'
        '          obscureText: true,\n'
        '          decoration: const InputDecoration(labelText: "Password"),\n'
        '        ),\n'
        '      ],\n'
        '    ),\n'
        '  ),\n'
        ');',
        title: 'autofill_group_recipe.dart',
      ),
      _codeBlock(
        '// Multi-hint field. The platform picks the first hint it understands.\n'
        'TextFormField(\n'
        '  autofillHints: const <String>[\n'
        '    AutofillHints.newUsername,\n'
        '    AutofillHints.username,\n'
        '    AutofillHints.email,\n'
        '  ],\n'
        '  decoration: const InputDecoration(\n'
        '    labelText: "Choose a handle",\n'
        '    helperText: "We will sync this with your password manager.",\n'
        '  ),\n'
        ');',
        title: 'multi_hint_field.dart',
      ),
      _codeBlock(
        '// Manual commit/cancel - useful on multi-step wizards.\n'
        'void onSubmit() {\n'
        '  TextInput.finishAutofillContext(shouldSave: true);\n'
        '  // ...continue to confirmation page.\n'
        '}\n\n'
        'void onCancel() {\n'
        '  TextInput.finishAutofillContext(shouldSave: false);\n'
        '  Navigator.of(context).pop();\n'
        '}',
        title: 'manual_finish_autofill_context.dart',
      ),
      _codeBlock(
        '// SMS / OTP. iOS surfaces the latest one-time code from Messages,\n'
        '// Android uses the SMS Retriever API.\n'
        'TextField(\n'
        '  keyboardType: TextInputType.number,\n'
        '  autofillHints: const <String>[AutofillHints.oneTimeCode],\n'
        '  decoration: const InputDecoration(\n'
        '    labelText: "6-digit code",\n'
        '    counterText: "",\n'
        '  ),\n'
        '  maxLength: 6,\n'
        ');',
        title: 'one_time_code_field.dart',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// FOOTER - CHEAT SHEET
// ---------------------------------------------------------------------------
Widget _cheatSheet() {
  return _card(
    background: _kCardDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Cheat sheet',
          style: _kTitleStyle.copyWith(color: _kInkOnDark),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'API surface of the autofill subsystem, packed into a single card.',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 13.0,
          ),
        ),
        const SizedBox(height: 14.0),
        _darkKv('AutofillGroup', 'StatefulWidget. Acts as an AutofillScope; children with autofillHints register as clients.'),
        _darkKv('AutofillGroupState', 'State<AutofillGroup>. Implements AutofillScope. Holds registered AutofillClient list.'),
        _darkKv('AutofillScope', 'Mixin-style interface. Exposes attach(client) and autofillClients getter.'),
        _darkKv('AutofillClient', 'Interface implemented by EditableTextState. Provides textInputConfiguration, autofillId.'),
        _darkKv('AutofillHints', 'Class of const String tokens. NOT an enum - safe to extend in user code.'),
        _darkKv('AutofillContextAction', 'enum { commit, cancel }. Maps to TextInput.finishAutofillContext.shouldSave.'),
        _darkKv('TextInput.finishAutofillContext', 'static. Closes the active autofill context and tells the platform whether to save.'),
        _darkKv('AutofillGroup.onDisposeAction', 'Defaults to AutofillContextAction.commit. Fires when the group is removed from the tree.'),
      ],
    ),
  );
}

Widget _darkKv(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 240.0,
          child: Text(
            key,
            style: const TextStyle(
              color: _kCodeAccent,
              fontSize: 12.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: _kInkOnDark,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _heroBanner(),
          _sectionHeader(
            1,
            'AutofillGroup anatomy',
            'How the scope, the clients and the platform IME bridge fit '
                'together inside one frame.',
          ),
          _anatomyDiagram(),
          _sectionDivider(),
          _sectionHeader(
            2,
            'AutofillHints catalogue',
            'The colour-coded hint registry, grouped by data domain.',
          ),
          _hintSwatchGrid(),
          _sectionDivider(),
          _sectionHeader(
            3,
            'Registration form mockup',
            'Static visual rendering of four AutofillGroups stitched into one '
                'signup flow.',
          ),
          _formMockup(),
          _sectionDivider(),
          _sectionHeader(
            4,
            'Commit vs Cancel',
            'AutofillContextAction.commit and .cancel paths, with the IO '
                'they trigger on each side.',
          ),
          _commitCancelDiagram(),
          _sectionDivider(),
          _sectionHeader(
            5,
            'Platform matrix',
            'Per-platform support across Identity, Address, Card and OTP '
                'hint families.',
          ),
          _platformMatrix(),
          _sectionDivider(),
          _sectionHeader(
            6,
            'Idiomatic recipes',
            'Four code snippets that cover 90% of real-world autofill '
                'wiring in a Flutter app.',
          ),
          _codeSection(),
          _sectionDivider(),
          _sectionHeader(
            7,
            'Cheat sheet',
            'Surface area of the autofill subsystem, in one panel.',
          ),
          _cheatSheet(),
          const SizedBox(height: 30.0),
        ],
      ),
    ),
  );
}
