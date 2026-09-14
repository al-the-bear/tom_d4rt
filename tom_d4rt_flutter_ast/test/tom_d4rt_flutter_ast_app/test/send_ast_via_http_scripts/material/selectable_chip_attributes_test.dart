// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// D4rt deep visual demo: SelectableChipAttributes mixin showcase.
// =============================================================================
//
// THEME: "Petal Crimson"
//   A warm gallery palette of rose, coral, blush, and crimson set against a
//   cream-paper backdrop. The accent is a deep mulberry that rides every
//   selected-state highlight, so the eye instantly knows when a chip has
//   crossed the threshold from "available" to "chosen".
//
// SUBJECT:
//   The mixin SelectableChipAttributes from package:flutter/material.dart is
//   the contract that ChoiceChip, FilterChip, InputChip and RawChip all sign.
//   It guarantees five member signatures that drive Material's chip rendering
//   pipeline:
//
//     1. bool selected
//          The truth bit. Drives the Material ink ripple's resting state and
//          the avatar checkmark animation. When `true`, the chip paints with
//          the selectedColor mixed into its background tone.
//     2. ValueChanged<bool>? onSelected
//          The callback Material wires to its tap recognizer. Null means
//          "the chip is read-only" and the ink response is suppressed.
//     3. Color? selectedColor
//          The fill applied while selected == true. Resolves through the
//          ambient ChipThemeData when not provided.
//     4. ShapeBorder? avatarBorder
//          The shape clipped around the leading avatar widget when selected.
//          Often a CircleBorder, but any ShapeBorder is accepted.
//     5. Color? selectedShadowColor
//          The Material elevation shadow color projected beneath the chip
//          while it is selected. Subtle, but it sells the lift.
//
// PHILOSOPHY:
//   This file is a snapshot — there is no setState, no controller, no live
//   animation. Each chip is rendered twice: once with selected: false and
//   once with selected: true. The viewer reads the visual diff exactly the
//   same way the framework's painter would, but every frame is a still life.
//   Any onSelected we pass is a no-op `(bool _) {}` — the test runner never
//   taps anything, so the callback never fires.
//
// SECTIONS:
//   1.  Title banner with palette header.
//   2.  Mixin definition prose card.
//   3.  Property anatomy panel — five rows, swatches, descriptions.
//   4.  ChoiceChip moods gallery — eight moods, before/after.
//   5.  FilterChip foods gallery — cuisines and flavors.
//   6.  FilterChip languages gallery — programming language tags.
//   7.  FilterChip dietary gallery — dietary preferences.
//   8.  InputChip contacts gallery — fictional contact tags.
//   9.  InputChip hashtag suggestions gallery.
//  10.  RawChip lane — custom selectedColor, selectedShadowColor, avatarBorder.
//  11.  Side-by-side before/after rows with arrow connectors.
//  12.  Closing footer with property recap.
//
// RULES OBSERVED:
//   - Imports limited to package:flutter/material.dart.
//   - Only the file-level ignore on line 1.
//   - No top-level helper classes; every helper is an inline expression.
//   - .withValues(alpha: ...) instead of .withOpacity(...).
//   - flutter analyze must pass with zero issues.
// =============================================================================

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectableChipAttributes deep visual demo executing');

  // ===========================================================================
  // Palette: Petal Crimson
  // ===========================================================================
  final Color creamPaper = const Color(0xFFFFF5EE);
  final Color creamPanel = const Color(0xFFFFE8DC);
  final Color creamPanelAlt = const Color(0xFFFCDCC8);
  final Color blushSoft = const Color(0xFFF7B5A1);
  final Color blushMid = const Color(0xFFE89280);
  final Color coralPop = const Color(0xFFE8675C);
  final Color rosePetal = const Color(0xFFD94F70);
  final Color crimsonInk = const Color(0xFF8E1B3A);
  final Color mulberryShadow = const Color(0xFF5C0F2C);
  final Color leafSage = const Color(0xFFA8B89B);
  final Color goldenStamen = const Color(0xFFE2A23A);
  final Color charcoalText = const Color(0xFF2A1014);
  final Color paperLine = const Color(0xFFD9B7A8);

  print('Palette assembled: 12 hues for Petal Crimson.');

  // No-op callback. Material accepts this as a "live" handler so the chip
  // does not paint as disabled, but the test runner will never trigger it.
  void noop(bool _) {}

  // ===========================================================================
  // Source data tables.
  // ===========================================================================
  final List<List<String>> moodRows = <List<String>>[
    <String>['Joyful', '\u{1F642}'],
    <String>['Pensive', '\u{1F914}'],
    <String>['Curious', '\u{1F50D}'],
    <String>['Sleepy', '\u{1F634}'],
    <String>['Grateful', '\u{1F33C}'],
    <String>['Restless', '\u{1F501}'],
    <String>['Daring', '\u{1F525}'],
    <String>['Tender', '\u{1F49D}'],
  ];

  final List<List<String>> foodRows = <List<String>>[
    <String>['Ramen', 'noodle'],
    <String>['Tacos', 'street'],
    <String>['Sushi', 'sea'],
    <String>['Curry', 'spice'],
    <String>['Pasta', 'comfort'],
    <String>['Falafel', 'herb'],
  ];

  final List<List<String>> languageRows = <List<String>>[
    <String>['Dart', 'mobile'],
    <String>['Rust', 'systems'],
    <String>['Python', 'science'],
    <String>['Go', 'cloud'],
    <String>['Kotlin', 'mobile'],
    <String>['Swift', 'apple'],
  ];

  final List<List<String>> dietaryRows = <List<String>>[
    <String>['Vegan', 'plants'],
    <String>['Gluten-Free', 'wheat'],
    <String>['Halal', 'rite'],
    <String>['Kosher', 'rite'],
    <String>['Pescatarian', 'sea'],
  ];

  final List<List<String>> contactRows = <List<String>>[
    <String>['Anya P.', 'A'],
    <String>['Bertil O.', 'B'],
    <String>['Camille R.', 'C'],
    <String>['Daichi K.', 'D'],
    <String>['Elif T.', 'E'],
    <String>['Farouk N.', 'F'],
  ];

  final List<List<String>> hashtagRows = <List<String>>[
    <String>['#flutterdev', 'tech'],
    <String>['#dartlang', 'tech'],
    <String>['#sundaysketch', 'art'],
    <String>['#botanicals', 'art'],
    <String>['#slowmornings', 'life'],
  ];

  // ===========================================================================
  // Helper expressions (inline closures rather than top-level classes).
  // ===========================================================================

  // A swatch tile used by the property anatomy panel.
  Widget swatch(Color base, Color border) => Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: base,
          border: Border.all(color: border, width: 1.4),
          borderRadius: BorderRadius.circular(6),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: base.withValues(alpha: 0.45),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );

  // A small monospace tag.
  Widget codeTag(String label, Color bg, Color fg) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: fg.withValues(alpha: 0.35), width: 0.8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: fg,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  // A connector arrow built from plain Containers.
  Widget connector(Color line, Color tip) => SizedBox(
        width: 44,
        height: 18,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: line,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            Positioned(
              right: 4,
              child: Container(
                width: 0,
                height: 0,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.transparent, width: 6),
                    bottom: BorderSide(color: Colors.transparent, width: 6),
                    left: BorderSide(color: tip, width: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  // A description row inside the anatomy panel.
  Widget anatomyRow(String name, String description, Color sw1, Color sw2) =>
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: creamPaper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: paperLine, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            swatch(sw1, sw2),
            const SizedBox(width: 12),
            SizedBox(
              width: 130,
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: crimsonInk,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  height: 1.3,
                  color: charcoalText.withValues(alpha: 0.85),
                ),
              ),
            ),
          ],
        ),
      );

  // A section title tile.
  Widget sectionTitle(String number, String title, String subtitle) => Container(
        margin: const EdgeInsets.only(top: 18, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[crimsonInk, rosePetal, blushMid],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: mulberryShadow.withValues(alpha: 0.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: creamPaper,
                shape: BoxShape.circle,
                border: Border.all(color: crimsonInk, width: 2),
              ),
              child: Text(
                number,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: crimsonInk,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: creamPaper.withValues(alpha: 0.9),
                      fontStyle: FontStyle.italic,
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  // A prose paragraph styled in the cream/charcoal idiom.
  Widget prose(String text) => Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: creamPaper,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: paperLine.withValues(alpha: 0.7), width: 0.8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11.5,
            height: 1.45,
            color: charcoalText.withValues(alpha: 0.9),
          ),
        ),
      );

  // A row of two states — "off" left and "on" right with a connector.
  Widget beforeAfterRow(Widget off, Widget on, Color line, Color tip) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(child: off),
            connector(line, tip),
            Flexible(child: on),
          ],
        ),
      );

  // A wrapper that adds a soft frame around a chip so the theme reads.
  Widget chipFrame(Widget chip, Color frame) => Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: frame.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: frame.withValues(alpha: 0.45), width: 1),
        ),
        child: chip,
      );

  // ===========================================================================
  // Section 1 — Title banner.
  // ===========================================================================
  final Widget titleBanner = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[crimsonInk, rosePetal, coralPop, blushSoft],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: mulberryShadow.withValues(alpha: 0.4),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 28,
              decoration: BoxDecoration(
                color: goldenStamen,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'SelectableChipAttributes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'A still-life portrait of the mixin in Petal Crimson',
          style: TextStyle(
            color: creamPaper.withValues(alpha: 0.95),
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: <Widget>[
            codeTag('ChoiceChip', creamPaper, crimsonInk),
            codeTag('FilterChip', creamPaper, crimsonInk),
            codeTag('InputChip', creamPaper, crimsonInk),
            codeTag('RawChip', creamPaper, crimsonInk),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 2 — Mixin definition prose card.
  // ===========================================================================
  final Widget mixinCard = Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: creamPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: blushSoft, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: paperLine.withValues(alpha: 0.4),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'What the mixin guarantees',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: crimsonInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        prose(
          'SelectableChipAttributes is the contract that ChoiceChip, FilterChip, '
          'InputChip and RawChip implement. Material\'s chip painter consults it '
          'to learn whether the chip is currently selected, what tint to apply, '
          'how to clip the leading avatar, and what color to project behind the '
          'shadow when the chip is lifted by selection.',
        ),
        prose(
          'In this snapshot demo we never tap; we render the same chip twice — '
          'once unselected and once selected — and let the visual diff speak for '
          'the contract. Any callback we pass is a no-op; Material only needs '
          'to see "non-null" to keep the chip in the enabled visual state.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 3 — Property anatomy panel.
  // ===========================================================================
  final Widget anatomyPanel = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[creamPanel, creamPanelAlt],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: blushMid, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6,
              height: 22,
              decoration: BoxDecoration(
                color: crimsonInk,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Property anatomy',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: crimsonInk,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        anatomyRow(
          'selected',
          'The truth bit. When true, the chip paints with selectedColor in the '
              'background and asks the avatar to clip with avatarBorder.',
          rosePetal,
          crimsonInk,
        ),
        anatomyRow(
          'onSelected',
          'ValueChanged<bool>?. Material wires this to its tap recognizer; null '
              'puts the chip into the read-only visual state.',
          coralPop,
          crimsonInk,
        ),
        anatomyRow(
          'selectedColor',
          'The fill applied while selected. Falls back to ChipThemeData when '
              'omitted, then to the Material default.',
          blushMid,
          crimsonInk,
        ),
        anatomyRow(
          'avatarBorder',
          'A ShapeBorder that clips the leading avatar widget while selected. '
              'Defaults to CircleBorder.',
          goldenStamen,
          crimsonInk,
        ),
        anatomyRow(
          'selectedShadowColor',
          'The Material elevation shadow projected beneath the chip while '
              'selected. Subtle, but it sells the lift.',
          mulberryShadow,
          crimsonInk,
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 4 — ChoiceChip moods gallery.
  // ===========================================================================
  final List<Widget> moodChipsOff = <Widget>[];
  final List<Widget> moodChipsOn = <Widget>[];
  for (int i = 0; i < moodRows.length; i++) {
    final String mood = moodRows[i][0];
    final String emoji = moodRows[i][1];
    final ChoiceChip off = ChoiceChip(
      label: Text('$emoji $mood'),
      selected: false,
      onSelected: noop,
      selectedColor: rosePetal,
      backgroundColor: creamPanel,
      labelStyle: TextStyle(color: charcoalText, fontSize: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: paperLine, width: 1),
      ),
    );
    final ChoiceChip on = ChoiceChip(
      label: Text('$emoji $mood'),
      selected: true,
      onSelected: noop,
      selectedColor: rosePetal,
      backgroundColor: creamPanel,
      selectedShadowColor: mulberryShadow,
      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: crimsonInk, width: 1.4),
      ),
    );
    moodChipsOff.add(chipFrame(off, blushSoft));
    moodChipsOn.add(chipFrame(on, rosePetal));
  }

  final Widget moodsGallery = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[creamPaper, blushSoft.withValues(alpha: 0.35)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: blushMid, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'ChoiceChip — moods, eight petals',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: crimsonInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        prose(
          'ChoiceChip is the canonical "single-value selector" implementation of '
              'SelectableChipAttributes. The selected flag flips the background '
              'tint to selectedColor, and Material uses our crimson ink for the '
              'label silhouette. Below: eight moods rendered first in their off '
              'state, then in their selected state.',
        ),
        const SizedBox(height: 8),
        Text(
          'Off state',
          style: TextStyle(
            color: charcoalText,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: moodChipsOff),
        const SizedBox(height: 12),
        Text(
          'Selected state',
          style: TextStyle(
            color: crimsonInk,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: moodChipsOn),
      ],
    ),
  );

  // ===========================================================================
  // Section 5 — FilterChip foods gallery.
  // ===========================================================================
  final List<Widget> foodOff = <Widget>[];
  final List<Widget> foodOn = <Widget>[];
  for (int i = 0; i < foodRows.length; i++) {
    final String food = foodRows[i][0];
    final String tag = foodRows[i][1];
    foodOff.add(chipFrame(
      FilterChip(
        label: Text(food),
        selected: false,
        onSelected: noop,
        selectedColor: coralPop,
        backgroundColor: creamPanel,
        avatar: CircleAvatar(
          backgroundColor: blushSoft,
          child: Text(
            tag.substring(0, 1).toUpperCase(),
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        labelStyle: TextStyle(color: charcoalText, fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: paperLine, width: 1),
        ),
      ),
      blushSoft,
    ));
    foodOn.add(chipFrame(
      FilterChip(
        label: Text(food),
        selected: true,
        onSelected: noop,
        selectedColor: coralPop,
        backgroundColor: creamPanel,
        selectedShadowColor: mulberryShadow,
        avatarBorder: const StadiumBorder(),
        avatar: CircleAvatar(
          backgroundColor: creamPaper,
          child: Text(
            tag.substring(0, 1).toUpperCase(),
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: crimsonInk, width: 1.4),
        ),
      ),
      coralPop,
    ));
  }

  final Widget foodsGallery = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[creamPanel, blushSoft.withValues(alpha: 0.5)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: coralPop, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'FilterChip — cuisines and flavors',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: crimsonInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        prose(
          'FilterChip implements SelectableChipAttributes alongside its own '
              'check-mark API. We illustrate selectedColor with a coral fill and '
              'avatarBorder by switching the leading avatar to a StadiumBorder '
              'when selected — note how the avatar visually merges with the '
              'chip body, a subtle but powerful side-effect of the contract.',
        ),
        const SizedBox(height: 8),
        Text('Off state', style: TextStyle(color: charcoalText, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: foodOff),
        const SizedBox(height: 12),
        Text('Selected state', style: TextStyle(color: crimsonInk, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: foodOn),
      ],
    ),
  );

  // ===========================================================================
  // Section 6 — FilterChip languages gallery.
  // ===========================================================================
  final List<Widget> langOff = <Widget>[];
  final List<Widget> langOn = <Widget>[];
  for (int i = 0; i < languageRows.length; i++) {
    final String lang = languageRows[i][0];
    final String area = languageRows[i][1];
    langOff.add(chipFrame(
      FilterChip(
        label: Text(lang),
        selected: false,
        onSelected: noop,
        selectedColor: rosePetal,
        backgroundColor: creamPaper,
        avatar: Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: blushSoft,
            shape: BoxShape.circle,
            border: Border.all(color: paperLine, width: 1),
          ),
          child: Text(
            lang.substring(0, 1),
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        labelStyle: TextStyle(color: charcoalText, fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: paperLine, width: 1),
        ),
      ),
      blushSoft,
    ));
    langOn.add(chipFrame(
      FilterChip(
        label: Text(lang),
        selected: true,
        onSelected: noop,
        selectedColor: rosePetal,
        backgroundColor: creamPaper,
        selectedShadowColor: mulberryShadow,
        avatarBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: crimsonInk, width: 1.4),
        ),
        avatar: Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: creamPaper,
            shape: BoxShape.circle,
          ),
          child: Text(
            lang.substring(0, 1),
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: crimsonInk, width: 1.4),
        ),
      ),
      rosePetal,
    ));
    print('  language[$i] = $lang ($area)');
  }

  final Widget langsGallery = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: creamPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rosePetal, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'FilterChip — programming languages',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: crimsonInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        prose(
          'Here avatarBorder switches from a soft circle in the off state to a '
              'sharp rounded-rectangle in the selected state. Material clips the '
              'avatar against the new shape, so the same widget reads differently '
              'before and after selection — without us touching the avatar tree.',
        ),
        const SizedBox(height: 8),
        Text('Off state', style: TextStyle(color: charcoalText, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: langOff),
        const SizedBox(height: 12),
        Text('Selected state', style: TextStyle(color: crimsonInk, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: langOn),
      ],
    ),
  );

  // ===========================================================================
  // Section 7 — FilterChip dietary gallery.
  // ===========================================================================
  final List<Widget> dietOff = <Widget>[];
  final List<Widget> dietOn = <Widget>[];
  for (int i = 0; i < dietaryRows.length; i++) {
    final String diet = dietaryRows[i][0];
    dietOff.add(chipFrame(
      FilterChip(
        label: Text(diet),
        selected: false,
        onSelected: noop,
        selectedColor: leafSage,
        backgroundColor: creamPaper,
        labelStyle: TextStyle(color: charcoalText, fontSize: 12),
        shape: const StadiumBorder(),
      ),
      leafSage,
    ));
    dietOn.add(chipFrame(
      FilterChip(
        label: Text(diet),
        selected: true,
        onSelected: noop,
        selectedColor: leafSage,
        selectedShadowColor: mulberryShadow,
        backgroundColor: creamPaper,
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
        shape: const StadiumBorder(),
      ),
      leafSage,
    ));
  }

  final Widget dietGallery = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[creamPanel, leafSage.withValues(alpha: 0.35)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: leafSage, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'FilterChip — dietary preferences',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: crimsonInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        prose(
          'A second FilterChip lane, this time using a sage selectedColor to '
              'demonstrate that selectedColor is a free parameter — the contract '
              'doesn\'t force any particular hue. The painter simply asks the '
              'mixin "what fill?" and trusts whatever Color comes back.',
        ),
        const SizedBox(height: 8),
        Text('Off state', style: TextStyle(color: charcoalText, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: dietOff),
        const SizedBox(height: 12),
        Text('Selected state', style: TextStyle(color: crimsonInk, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: dietOn),
      ],
    ),
  );

  // ===========================================================================
  // Section 8 — InputChip contacts gallery.
  // ===========================================================================
  final List<Widget> contactOff = <Widget>[];
  final List<Widget> contactOn = <Widget>[];
  for (int i = 0; i < contactRows.length; i++) {
    final String name = contactRows[i][0];
    final String initial = contactRows[i][1];
    contactOff.add(chipFrame(
      InputChip(
        label: Text(name),
        selected: false,
        onSelected: noop,
        selectedColor: rosePetal,
        backgroundColor: creamPaper,
        avatar: CircleAvatar(
          backgroundColor: blushSoft,
          child: Text(
            initial,
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        labelStyle: TextStyle(color: charcoalText, fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: paperLine, width: 1),
        ),
      ),
      blushSoft,
    ));
    contactOn.add(chipFrame(
      InputChip(
        label: Text(name),
        selected: true,
        onSelected: noop,
        selectedColor: rosePetal,
        selectedShadowColor: mulberryShadow,
        avatarBorder: const CircleBorder(),
        backgroundColor: creamPaper,
        avatar: CircleAvatar(
          backgroundColor: creamPaper,
          child: Text(
            initial,
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: crimsonInk, width: 1.4),
        ),
      ),
      rosePetal,
    ));
  }

  final Widget contactsGallery = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: creamPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: rosePetal, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'InputChip — contact tags',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: crimsonInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        prose(
          'InputChip carries SelectableChipAttributes too. It\'s the chip that '
              'represents user input or an entity tag. We pin avatarBorder to a '
              'CircleBorder while selected — the avatar still shows initials, '
              'but the painter clips it to a perfect circle.',
        ),
        const SizedBox(height: 8),
        Text('Off state', style: TextStyle(color: charcoalText, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: contactOff),
        const SizedBox(height: 12),
        Text('Selected state', style: TextStyle(color: crimsonInk, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: contactOn),
      ],
    ),
  );

  // ===========================================================================
  // Section 9 — InputChip hashtag suggestions.
  // ===========================================================================
  final List<Widget> hashOff = <Widget>[];
  final List<Widget> hashOn = <Widget>[];
  for (int i = 0; i < hashtagRows.length; i++) {
    final String tag = hashtagRows[i][0];
    hashOff.add(chipFrame(
      InputChip(
        label: Text(tag),
        selected: false,
        onSelected: noop,
        selectedColor: goldenStamen,
        backgroundColor: creamPaper,
        labelStyle: TextStyle(color: charcoalText, fontSize: 12, fontFamily: 'monospace'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: paperLine, width: 1),
        ),
      ),
      goldenStamen,
    ));
    hashOn.add(chipFrame(
      InputChip(
        label: Text(tag),
        selected: true,
        onSelected: noop,
        selectedColor: goldenStamen,
        selectedShadowColor: mulberryShadow,
        backgroundColor: creamPaper,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
          fontFamily: 'monospace',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: crimsonInk, width: 1.4),
        ),
      ),
      goldenStamen,
    ));
  }

  final Widget hashGallery = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[creamPaper, goldenStamen.withValues(alpha: 0.35)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: goldenStamen, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'InputChip — hashtag suggestions',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: crimsonInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        prose(
          'Hashtags read best in monospace; we keep that face for both states '
              'and let selectedColor swing the entire chip from cream to honey '
              'gold. The painter doesn\'t care that we\'re mixing typefaces — '
              'the mixin contract is purely about chrome.',
        ),
        const SizedBox(height: 8),
        Text('Off state', style: TextStyle(color: charcoalText, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: hashOff),
        const SizedBox(height: 12),
        Text('Selected state', style: TextStyle(color: crimsonInk, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: hashOn),
      ],
    ),
  );

  // ===========================================================================
  // Section 10 — RawChip lane.
  // ===========================================================================
  final List<List<dynamic>> rawConfigs = <List<dynamic>>[
    <dynamic>['Coral / Stadium', coralPop, const StadiumBorder(), 'A'],
    <dynamic>['Rose / Circle', rosePetal, const CircleBorder(), 'B'],
    <dynamic>['Crimson / Rounded', crimsonInk, RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), 'C'],
    <dynamic>['Sage / Beveled', leafSage, const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))), 'D'],
    <dynamic>['Gold / Continuous', goldenStamen, const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))), 'E'],
  ];

  final List<Widget> rawOff = <Widget>[];
  final List<Widget> rawOn = <Widget>[];
  for (int i = 0; i < rawConfigs.length; i++) {
    final String label = rawConfigs[i][0] as String;
    final Color sel = rawConfigs[i][1] as Color;
    final ShapeBorder border = rawConfigs[i][2] as ShapeBorder;
    final String initial = rawConfigs[i][3] as String;

    rawOff.add(chipFrame(
      RawChip(
        label: Text(label),
        selected: false,
        onSelected: noop,
        selectedColor: sel,
        backgroundColor: creamPaper,
        avatar: CircleAvatar(
          backgroundColor: blushSoft,
          child: Text(
            initial,
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        labelStyle: TextStyle(color: charcoalText, fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: paperLine, width: 1),
        ),
      ),
      blushSoft,
    ));

    rawOn.add(chipFrame(
      RawChip(
        label: Text(label),
        selected: true,
        onSelected: noop,
        selectedColor: sel,
        selectedShadowColor: mulberryShadow,
        avatarBorder: border,
        backgroundColor: creamPaper,
        elevation: 4,
        avatar: CircleAvatar(
          backgroundColor: creamPaper,
          child: Text(
            initial,
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: crimsonInk, width: 1.4),
        ),
      ),
      sel,
    ));
  }

  final Widget rawLane = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[creamPanelAlt, blushSoft.withValues(alpha: 0.6)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: crimsonInk, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'RawChip — direct mixin showcase',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: crimsonInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        prose(
          'RawChip is the bare-metal Material chip on which ChoiceChip, '
              'FilterChip, and ActionChip are built. It exposes the full '
              'SelectableChipAttributes surface directly. Below we step through '
              'five different (selectedColor, avatarBorder) pairs so the '
              'pipeline\'s reaction to each variation is visible.',
        ),
        const SizedBox(height: 8),
        Text('Off state', style: TextStyle(color: charcoalText, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: rawOff),
        const SizedBox(height: 12),
        Text('Selected state', style: TextStyle(color: crimsonInk, fontWeight: FontWeight.w700, fontSize: 11)),
        const SizedBox(height: 4),
        Wrap(spacing: 8, runSpacing: 8, children: rawOn),
      ],
    ),
  );

  // ===========================================================================
  // Section 11 — Side-by-side before/after rows.
  // ===========================================================================
  ChoiceChip baChoice(bool sel) => ChoiceChip(
        label: const Text('Daring'),
        selected: sel,
        onSelected: noop,
        selectedColor: coralPop,
        backgroundColor: creamPanel,
        selectedShadowColor: sel ? mulberryShadow : null,
        labelStyle: TextStyle(
          color: sel ? Colors.white : charcoalText,
          fontSize: 12,
          fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: sel ? crimsonInk : paperLine, width: sel ? 1.4 : 1),
        ),
      );

  FilterChip baFilter(bool sel) => FilterChip(
        label: const Text('Curry'),
        selected: sel,
        onSelected: noop,
        selectedColor: rosePetal,
        backgroundColor: creamPaper,
        selectedShadowColor: sel ? mulberryShadow : null,
        avatar: CircleAvatar(
          backgroundColor: sel ? creamPaper : blushSoft,
          child: Text(
            'C',
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        avatarBorder: sel ? const StadiumBorder() : const CircleBorder(),
        labelStyle: TextStyle(
          color: sel ? Colors.white : charcoalText,
          fontSize: 12,
          fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: sel ? crimsonInk : paperLine, width: sel ? 1.4 : 1),
        ),
      );

  InputChip baInput(bool sel) => InputChip(
        label: const Text('Anya P.'),
        selected: sel,
        onSelected: noop,
        selectedColor: rosePetal,
        backgroundColor: creamPaper,
        selectedShadowColor: sel ? mulberryShadow : null,
        avatarBorder: sel ? const CircleBorder() : const StadiumBorder(),
        avatar: CircleAvatar(
          backgroundColor: sel ? creamPaper : blushSoft,
          child: Text(
            'A',
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        labelStyle: TextStyle(
          color: sel ? Colors.white : charcoalText,
          fontSize: 12,
          fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: sel ? crimsonInk : paperLine, width: sel ? 1.4 : 1),
        ),
      );

  RawChip baRaw(bool sel) => RawChip(
        label: const Text('Custom'),
        selected: sel,
        onSelected: noop,
        selectedColor: crimsonInk,
        backgroundColor: creamPaper,
        selectedShadowColor: sel ? mulberryShadow : null,
        avatarBorder: sel
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
            : const CircleBorder(),
        avatar: CircleAvatar(
          backgroundColor: sel ? creamPaper : blushSoft,
          child: Text(
            'X',
            style: TextStyle(color: crimsonInk, fontSize: 10, fontWeight: FontWeight.w800),
          ),
        ),
        labelStyle: TextStyle(
          color: sel ? Colors.white : charcoalText,
          fontSize: 12,
          fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: sel ? crimsonInk : paperLine, width: sel ? 1.4 : 1),
        ),
      );

  final Widget beforeAfterPanel = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[creamPaper, blushSoft.withValues(alpha: 0.5)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: crimsonInk, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Before vs after — selection diff',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: crimsonInk,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        prose(
          'Each row shows the same chip painted twice. The arrow points from the '
              'unselected state to the selected state — the contract members are '
              'identical, only the boolean changes.',
        ),
        const SizedBox(height: 10),
        beforeAfterRow(chipFrame(baChoice(false), blushSoft), chipFrame(baChoice(true), coralPop), rosePetal, crimsonInk),
        beforeAfterRow(chipFrame(baFilter(false), blushSoft), chipFrame(baFilter(true), rosePetal), rosePetal, crimsonInk),
        beforeAfterRow(chipFrame(baInput(false), blushSoft), chipFrame(baInput(true), rosePetal), rosePetal, crimsonInk),
        beforeAfterRow(chipFrame(baRaw(false), blushSoft), chipFrame(baRaw(true), crimsonInk), rosePetal, crimsonInk),
      ],
    ),
  );

  // ===========================================================================
  // Section 12 — Closing footer.
  // ===========================================================================
  final Widget footer = Container(
    margin: const EdgeInsets.only(top: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[crimsonInk, mulberryShadow],
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Recap — five contract members',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: <Widget>[
            codeTag('selected', creamPaper, crimsonInk),
            codeTag('onSelected', creamPaper, crimsonInk),
            codeTag('selectedColor', creamPaper, crimsonInk),
            codeTag('avatarBorder', creamPaper, crimsonInk),
            codeTag('selectedShadowColor', creamPaper, crimsonInk),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Implemented by ChoiceChip, FilterChip, InputChip, and RawChip — '
          'painted here in still life on Petal Crimson cream.',
          style: TextStyle(
            color: creamPaper.withValues(alpha: 0.95),
            fontStyle: FontStyle.italic,
            fontSize: 11,
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // Final assembly.
  // ===========================================================================
  print('Assembly: 12 sections composed for SelectableChipAttributes demo.');

  return Scaffold(
    backgroundColor: creamPaper,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          titleBanner,
          mixinCard,
          sectionTitle('1', 'Property anatomy', 'Five members of the mixin'),
          anatomyPanel,
          sectionTitle('2', 'ChoiceChip — moods', 'Eight petals, two states'),
          moodsGallery,
          sectionTitle('3', 'FilterChip — cuisines', 'avatarBorder swaps to a stadium'),
          foodsGallery,
          sectionTitle('4', 'FilterChip — languages', 'Avatar clipping shifts to rounded-rectangle'),
          langsGallery,
          sectionTitle('5', 'FilterChip — dietary', 'Free choice of selectedColor'),
          dietGallery,
          sectionTitle('6', 'InputChip — contacts', 'CircleBorder around initials'),
          contactsGallery,
          sectionTitle('7', 'InputChip — hashtags', 'Monospace face, golden selection'),
          hashGallery,
          sectionTitle('8', 'RawChip — direct surface', 'Five border shapes vs five colors'),
          rawLane,
          sectionTitle('9', 'Before vs after', 'Visual diff of the boolean'),
          beforeAfterPanel,
          footer,
        ],
      ),
    ),
  );
}
